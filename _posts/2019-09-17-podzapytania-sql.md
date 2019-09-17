---
title: Podzapytania SQL
last_modified_at: 2019-09-17 23:06:50 +0100
categories:
- Bazy danych
- Kurs SQL
permalink: /podzapytania-sql/
header:
    teaser: /assets/images/2019/08/19_podzapytania_sql_artykul.jpg
    overlay_image: /assets/images/2019/08/19_podzapytania_sql_artykul.jpg
    caption: "[&copy; jackmac34](https://pixabay.com/photos/matryoshka-russian-dolls-nesting-970943/)"
excerpt: W tym artykule opisuję podzapytania SQL. Po lekturze tego artykułu będziesz wiedzieć czym są podzapytania, kiedy można je stosować i w jakich miejscach mogą występować. Wszystkie omówione przypadki poparłem przykładowymi zapytaniami, które możesz wykonać samodzielnie. Na końcu artykułu czeka na Ciebie zestaw zadań, które pomogą Ci utrwalić zdobytą wiedzę.
---

{% include kurs-sql-notice.md %}

## Czym jest podzapytanie

Podzapytanie to zapytanie SQL, które umieszczone jest wewnątrz innego zapytania. Podzapytanie zawsze otoczone jest parą nawiasów `()`. Jak zwykle spróbuję pokazać Ci to na przykładzie. Dla przypomnienia, najprostrze zapytenie SQL może wyglądać tak:

```sql
SELECT 1;
```

Po wykonaniu takiego zapytania otrzymasz pojedynczy wiersz zawierający jedną kolumnę z wartością `1`. Teraz trochę skomplikuję to zapytanie:

```sql
SELECT *
  FROM (SELECT 1);
```

Efekt działania obu przykładów jest dokładnie taki sam. Drugi przykład używa podzapytania. Główne zapytanie `SELECT * FROM` zwraca wszystkie wiersze zwrócone przez podzapytanie `SELECT 1`. Przykład, który tu pokazałem jest trochę naciągany, bardziej prawdopodobny przykład może wyglądać następująco:

```sql
SELECT name
  FROM artist
 WHERE artistid IN (SELECT artistid
                      FROM album
                  GROUP BY artistid
                    HAVING COUNT(*) > 10);
```

Ponownie rozbiję to zapytanie na czynniki pierwsze. Proszę zwróć uwagę na podzapytanie:

```sql
   SELECT artistid
     FROM album
 GROUP BY artistid
   HAVING COUNT(*) > 10;
```

To zapytanie zwraca listę identyfikatorów płodnych artystów ;). Zapytanie zwraca identyfikatory artystów z tabeli `album`, którzy opublikowali więcej niż dziesięć albumów.

W połączeniu z głównym zapytaniem otrzymuję nazwy artystów, którzy opublikowali więcej niż dziesięć albumów.

### Po co stosuje się podzapytania

Powtórzę jeszcze raz przykład z poprzedniego punktu:

```sql
SELECT name
  FROM artist
 WHERE artistid IN (SELECT artistid
                      FROM album
                  GROUP BY artistid
                    HAVING COUNT(*) > 10);
```

Czy można osiągnąć ten sam efekt bez podzapytania[^join]? Oczywiście, że można. Jednym ze sposobów jest użycie stałej listy identyfikatorów artystów. Listę tych identyfikatorów zwróci zapytanie:

[^join]: Dla uproszenia pominę tu możliwść użycia klauzuli `JOIN`.

```sql
  SELECT artistid
    FROM album
GROUP BY artistid
  HAVING COUNT(*) > 10;
```

    ArtistId  
    ----------
    22        
    58        
    90   

Następnie taką listę można użyć w kolejnym zapytaniu:

```sql
SELECT name
  FROM artist
 WHERE artistid IN [22, 58, 90];
```

Takie podejście ma jednak swoje wady. Jedną z nich jest to, że trzeba wykonać dwa zapytania. Kolejną jest potrzeba modyfikowania drugiego zapytania na podstawie wyników pierwszego. Co więcej taka modyfikacja nie zawsze jest możliwa – co jeśli lista zwróconych indentyfikatorów miałaby kilkadziesiąt tysięcy elementów?

Podzapytania mogą mieć wiele zastosowań. Czasami osiągnięcie oczekiwanego efektu nie jest możliwe bez użycia podzapytania. Stosowanie podzapytań czasami może prowadzić do uproszczenia finalnego zapytania.

W zależności od silnika baz danych podzapytania mogą mieć różny wpływ na wydajność zapytania. Jeśli wydajność zapytania jest kluczowa uważaj z używaniem podzapytań – mogą mieć negatywny wpływ na wydajność[^plan].

[^plan]: Możliwe, że silnik bazy danych, której używasz użyje dokładnie takiego samego planu zapytania zarówno przy użyciu podzapytań jak i klauzuli `JOIN`.

## Gdzie może występować podzapytanie

Podzapytanie może występować praktycznie wszędzie wewnątrz zapytania SQL. To gdzie podzapytanie może być użyte uzależnione jest od tego ile wartości zwraca. Jeśli podzapytanie zwraca pojedynczą warstość może być użyte jako częśc wyrażenia – na przykład w porównaniach, czy zwracanych kolumnach. W przypadku gdy podzapytanie zwraca wiele wartości może być użyte na przykład w porównaniach czy jako tabela źródłowa. Poniższe przykłady powinny wyjaśnić poszczególne przypadki.

### Podzapytanie wewnątrz listy pobieranych wartości

Wyobraź sobie raport, który musisz przygotować. Raport powinien zawierać wszystkie faktury klientów. Poszczególne kolumny powinny pokazywać identyfikator klienta, wartość faktury i globalną średnią wartość faktur. Tego typu problem możesz rozwiązać używając podzapytania:

```sql
  SELECT customerid
        ,total
        ,(SELECT AVG(total)
            FROM invoice) AS avg_total
    FROM invoice
ORDER BY customerid
   LIMIT 14;
```

W tym przypadku podzapytanie zwraca pojedynczą wartość – globalną średnią wartość wszystkich faktur. Powyższe zapytanie zwróci następujące wyniki:

    CustomerId  Total       avg_total
    ----------  ----------  ----------------
    1           3.98        5.65194174757282
    1           3.96        5.65194174757282
    1           5.94        5.65194174757282
    1           0.99        5.65194174757282
    1           1.98        5.65194174757282
    1           13.86       5.65194174757282
    1           8.91        5.65194174757282
    2           1.98        5.65194174757282
    2           13.86       5.65194174757282
    2           8.91        5.65194174757282
    2           1.98        5.65194174757282
    2           3.96        5.65194174757282
    2           5.94        5.65194174757282
    2           0.99        5.65194174757282

Okazuje się, że raport nie jest idealny. Lepiej wyglądałoby zestawienie wartości poszczególnych faktur ze średnią faktur dla danego klienta. W tym przypadku podzapytanie musi bazować na kolumnie dostępnej w zapytaniu głównym. Aby móc tego dokonać niezbędne jest używanie [aliasów]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#aliasy-dla-kolumn) (w tym przypadku aliasów dla tabel):

```sql
  SELECT customerid
        ,total
        ,(SELECT AVG(total)
            FROM invoice AS subquery_invoice
           WHERE query_invoice.customerid = subquery_invoice.customerid) AS avg_total
    FROM invoice AS query_invoice
ORDER BY customerid
LIMIT 14;
```

W tym przypadku podzapytanie nadal zwraca pojedynczą wartość. Jednak tym razem wartość ta zależna jest od identyfikatora klienta znajdującego się w danym wierszu. To zapytanie zwróci następujące wiersze:

    CustomerId  Total       avg_total
    ----------  ----------  ----------
    1           3.98        5.66
    1           3.96        5.66
    1           5.94        5.66
    1           0.99        5.66
    1           1.98        5.66
    1           13.86       5.66
    1           8.91        5.66
    2           1.98        5.37428571
    2           13.86       5.37428571
    2           8.91        5.37428571
    2           1.98        5.37428571
    2           3.96        5.37428571
    2           5.94        5.37428571
    2           0.99        5.37428571

### Podzapytanie wewnątrz klauzuli `FROM`

Podzapytanie może zwrócić wiele wartości. W tym przypadku zapytanie zwraca śrendnią wartość sum faktur poszczególnych klientów:

```sql
SELECT AVG(customer_total)
  FROM (SELECT SUM(total) AS customer_total
          FROM invoice
      GROUP BY customerid);
```


* Wewnątrz klauzuli `WHERE` – podzapytanie może zwrócić wiele wartości. W tym przypadku zapytanie zwraca albumy, których identyfikatory są większe niż największy identyfikator albumu zacznającego się na literę `A`:
```sql
SELECT *
  FROM album
 WHERE albumid > (SELECT MAX(albumid)
                      FROM album
                     WHERE title LIKE 'A%');
```

* Wewnątrz klauzuli `HAVING` – w tym przypadku zapytanie zwraca listę identyfikatorów 
```sql
  SELECT artistid, 
    FROM album
GROUP BY artistid
  HAVING artistid > (SELECT 250);
```

* Wewnątrz klauzuli `ORDER BY`
```sql
  SELECT *
    FROM artist
ORDER BY (SELECT MAX(albumid)
            FROM album
           WHERE artist.artistid = album.artistid);
```

### Podzapytanie wewnątrz klauzuli `LIMIT`

```sql
SELECT *
  FROM album LIMIT (SELECT COUNT(*)
                      FROM artist);
```



Podzapytanie może także występować w zapytaniach typu `UPDATE` i `DELETE`[^kurs].

[^kurs]: Tych typów zapytań jeszcze nie opisałem w kursie, na pewno doczekają się osobnego artykułu.

Chociaż możliwość używania podzapytań jest tak szeroka w praktyce najczęściej spotyka się je wewnątrz klauzuli `FROM` i `WHERE`.

## Podzapytania a klauzula `JOIN`

Możliwe, że udało Ci się zauważyć, że część podzapytań można stosować wymiennie z klauzulą `JOIN`.

## Podzapytanie a liczba zwracanych wierszy

### Wiele wierszy

### Pojedynczy wiersz

## Podzapytania a klauzula `JOIN`

## Podzapytanie w podzapytaniu podzapytania

Podzapytania to twory, które mogą być zagnieżdżane. W zależności od silinka bazy danch limit zagnieżdżonych podzapytań może być różny. mimo tego, że takie konstrukcje są możliwe w codziennej pracy nie spotkałem się za podzapytaniami zagnieżdżonymi więcej niż dwa poziomy.

## Dobre praktyki przy używaniu podzapytań

To, że coś jest możliwe, wcale nie znaczy, że powinno być używane. Zapytania SQL szybko mogą stać się mało czytelne. Przez co będą trudne w zrozumieniu i późniejszym utrzymaniu. Jeśli podzapytanie wprowadza niepotrzebne zamieszanie postaraj się rozwiązać problem inaczej – czasami jest to możliwe na przykład przy użyciu klauzuli `JOIN`.

Nadmierne zagnieżdżanie podzapytań także wydaje się nie być dobrą praktyką. Takie łańcuszki nie poprawiają czytelności zapytania co powoduje wcześniej wspomniane problemy z jego późniejszym utrzymaniem. Jeśli musisz stosować więcej niż jeden poziom zagnieżdżenia zastanów się czy nie można rozwiązać tego problemu inaczej.

WHERE expression [NOT] IN (subquery)
WHERE expression comparision_operator [ANY|ALL] (subquery)
WHERE expression [NOT] EXISTS (subquery)

## Zadania do wykonania

Napisz zapytanie używając podzapytań, które zwróci:

1. średnią liczbę albumów dla artystów, którzy opublikowali więcej niż dwa albumy
2. Napisz zapytanie zwracające te same wyniki be użycia `JOIN`:
```sql
  SELECT name 
    FROM artist JOIN album
                ON artist.artistid = album.artistid
GROUP BY name
  HAVING COUNT(*) > 10;
```

### Przykładowe rozwiązania zadań

```sql
SELECT AVG(how_many)
  FROM (SELECT COUNT(*) AS how_many
          FROM album
      GROUP BY artistid
        HAVING how_many > 2);
```

```sql
SELECT name
  FROM artist
 WHERE artistid IN (SELECT artistid
                      FROM album
                  GROUP BY artistid
                    HAVING COUNT(*) > 10);
```

## Podsumowanie

Po lekturze artykułu wiesz już czym są podzapytania. Wiesz doskonale gdzie można ich używać. Udało Ci się także poznać kilka dobrych praktyk dotyczących używania podzapytań. Po samodzielnym rozwiązaniu zadań możesz śmiało powiedzieć, że potrafisz posługiwać się podzapytaniami.

Artykuł ten zamyka część kursu poświęconą zapytaniom typu `SELECT`. W kolejnych częściach kursu poznasz pozostałe elementy języka SQL niezbędne do codziennej pracy.

Mam nadzieję, że artykuł przypadł Ci do gustu. Udało Ci się rozwiązać zadania? Podziel się swoimi rozwiązaniami! Spojrzenie na ten sam problem z innego punktu widzenia pozwoli wszystkim na nauczenie się jeszcze więcej.

Zależy mi na dotarciu do nowych Czytelników, jeśli uważasz, że ten artykuł byłby wartościowy dla kogoś z Twoich znajomych bardzo proszę podziel się z nim odnośnikiem do tego artykułu. Z góry dziękuję!

Jeśli nie chesz ominąć kolejnych artykułów w przyszłości proszę dopisz się do Samouczkowego newslettera i polub Samouczka na Facebook'u. Trzymaj się i do następnego razu!
