---
title: Podzapytania SQL
last_modified_at: 2019-09-19 10:11:50 +0200
categories:
- Bazy danych
- Kurs SQL
permalink: /podzapytania-sql/
header:
    teaser: /assets/images/2019/08/19_podzapytania_sql_artykul.jpg
    overlay_image: /assets/images/2019/08/19_podzapytania_sql_artykul.jpg
    caption: "[&copy; jackmac34](https://pixabay.com/photos/matryoshka-russian-dolls-nesting-970943/)"
excerpt: W tym artykule opisuję podzapytania SQL. Po lekturze tego artykułu będziesz wiedzieć czym są podzapytania, kiedy można je stosować i w jakich miejscach mogą występować. Na przykładach poznasz zapytania skorelowane. Wszystkie omówione przypadki poparłem przykładowymi zapytaniami, które możesz wykonać samodzielnie. Na końcu artykułu czeka na Ciebie zestaw zadań, które pomogą Ci utrwalić zdobytą wiedzę.
---

{% include kurs-sql-notice.md %}

## Czym jest podzapytanie

Podzapytanie to zapytanie SQL, które umieszczone jest wewnątrz innego zapytania. Podzapytanie zawsze otoczone jest parą nawiasów `()`. Jak zwykle spróbuję pokazać to na przykładzie. Dla przypomnienia, najprostsze zapytanie SQL może wyglądać tak:

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

### Podzapytania skorelowane

Poprzedni przykład pokazywał „zwykłe” podzapytania. Istnieją jeszcze tak zwane podzapytania skorelowane. Czasami nazywa się je także zapytaniami powiązanymi. Od zwykłych różnią się one tym, że są powiązane z nadrzędnym zapytaniem. Spróbuję wyjaśnić to na przykładzie:

```sql
SELECT trackid
      ,albumid
      ,name
  FROM track AS outer_track
 WHERE milliseconds > (SELECT 10 * MIN(milliseconds)
                         FROM track AS inner_track
                        WHERE inner_track.albumid = outer_track.albumid);
```

To zapytanie zwraca identyfikator utworu, identyfikator albumu i tytuł utworu z tabeli `track`. Zwraca wyłącznie takie utwory, które są dziesięć razy dłuższe niż najkrótszy utwór z tego samego albumu. W tym przypadku podzapytanie używa dokładnie tej samej tabeli. Żeby móc odróżnić tabelę `track` z zapytania wewnętrznego, od tej samej tabeli w zapytaniu zewnętrznym używam aliasów – słowa kluczowego `AS`.

```sql
SELECT 10 * MIN(milliseconds)
  FROM track AS inner_track
 WHERE inner_track.albumid = outer_track.albumid;
```

Do tej pory w kursie posługiwałem się wyłącznie [aliasami kolumn]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#aliasy-dla-kolumn), jak widzisz istnieje także możliwość nadania aliasu tabelom.

Zapytania skorelowane nie są możliwe do wykonania bez dostępu do zapytania nadrzędnego. W tym przypadku zapytanie nie może być wykonane samodzielnie dlatego, że nie wie czym jest tabela `outer_track`.

{% include newsletter-srodek.md %}

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

[^join]: Dla uproszenia pominę tu możliwość użycia klauzuli `JOIN`.

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

Takie podejście ma jednak swoje wady. Jedną z nich jest to, że trzeba wykonać dwa zapytania. Kolejną jest potrzeba modyfikowania drugiego zapytania na podstawie wyników pierwszego. Co więcej taka modyfikacja nie zawsze jest możliwa – co jeśli lista zwróconych identyfikatorów miałaby kilkadziesiąt tysięcy elementów?

Podzapytania mogą mieć wiele zastosowań. Czasami osiągnięcie oczekiwanego efektu nie jest możliwe bez użycia podzapytania. Stosowanie podzapytań czasami może także prowadzić do uproszczenia finalnego zapytania.

Podzapytania mogą mieć różny wpływ na wydajność zapytania. Jeśli wydajność zapytania jest kluczowa sprawdzaj plan zapytania upewniając się czy usunięcie podzapytań mogłoby przyspieszyć jego wykonanie[^plan].

[^plan]: Możliwe, że silnik bazy danych, której używasz użyje dokładnie takiego samego planu zapytania zarówno przy użyciu podzapytań jak i klauzuli `JOIN`.

## Gdzie może występować podzapytanie

Podzapytanie może występować praktycznie wszędzie wewnątrz zapytania SQL. To gdzie podzapytanie może być użyte uzależnione jest od tego ile wartości zwraca. Jeśli podzapytanie zwraca pojedynczą wartość może być użyte jako część wyrażenia – na przykład w porównaniach, czy zwracanych kolumnach.

W przypadku gdy podzapytanie zwraca wiele wartości może być użyte na przykład w porównaniach czy jako tabela źródłowa. Poniższe przykłady powinny wyjaśnić poszczególne przypadki.

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

W tym przypadku podzapytanie zwraca pojedynczą wartość – globalną średnią wartość wszystkich faktur:

```sql
SELECT AVG(total)
  FROM invoice;
```

    avg(total)
    ----------------
    5.65194174757282

W połączeniu z zapytaniem głównym zwróci następujące wyniki:

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
           WHERE subquery_invoice.customerid = query_invoice.customerid) AS avg_total
    FROM invoice AS query_invoice
ORDER BY customerid
LIMIT 14;
```

W tym przypadku podzapytanie nadal zwraca pojedynczą wartość. Jednak tym razem wartość ta zależna jest od identyfikatora klienta znajdującego się w danym wierszu. Dla przykładu wybrałem jeden z identyfikatorów:

```sql
SELECT AVG(total)
  FROM invoice AS subquery_invoice
 WHERE subquery_invoice.customerid = 1;
```

    avg(total)
    ----------
    5.66

Zwróć uwagę, że tym razem zapytanie główne zwraca średnią charakterystyczną dla każdego klienta (która jest rożna od średniej dla wszystkich klientów):

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

Drugi przypadek pokazuje podzapytanie skorelowane. To podzapytanie powiązane jest z zapytaniem głównym. W odróżnieniu od pierwszego przypadku musi zostać wykonane wiele razy. Średnia użyta w pierwszym przypadku może być obliczona dokładnie raz dla uzyskania poprawnego wyniku.

### Podzapytanie wewnątrz klauzuli `FROM`

Wyniki podzapytania użytego wewnątrz klauzuli `FROM` traktowane są jakby były tabelą. Dlatego w tym przypadku podzapytanie może zwrócić wiele wartości. Kolumny użyte w podzapytaniu stają się kolumnami „tabeli” i mogą być użyte w zapytaniu głównym.

Proszę spójrz na przykład:

```sql
SELECT AVG(customer_total)
  FROM (SELECT SUM(total) AS customer_total
          FROM invoice
      GROUP BY customerid);
```

Ponownie zacznę od analizy podzapytania:

```sql
  SELECT SUM(total) AS customer_total
    FROM invoice
GROUP BY customerid;
```

Podzapytanie sumuje wszystkie poszczególnych klientów. Zwraca dokładnie tyle wierszy ile jest wartości kolumny `customerid`:

    customer_total
    --------------
    39.62
    37.62
    39.62
    39.62
    40.62
    …

Następnie taki wynik użyty jest do policzenia średniej z wszystkich sum. Ostatecznym wynikiem zapytania jest liczba pokazująca średnią sumę zamówień wszystkich klientów:

    avg(customer_total)
    -------------------
    39.4677966101694

Podzapytania tego typu mogą być użyte w bardziej skomplikowanych zapytaniach. Proszę spójrz na przykład poniżej:

```sql
SELECT invoiceid
      ,total
      ,invoice.billingstate
      ,billingstate_avg.state_avg
  FROM (SELECT billingstate
              ,AVG(total) AS state_avg
          FROM invoice
      GROUP BY billingstate) AS billingstate_avg JOIN invoice
                                                 ON billingstate_avg.billingstate = invoice.billingstate;
```

Analizę ponownie zacznę od podzapytania:

```sql
  SELECT billingstate
        ,AVG(total) AS state_avg
    FROM invoice
GROUP BY billingstate;
```

Podzapytanie używa [klauzuli `GROUP BY`]({% post_url 2018-10-20-funkcje-i-grupowanie-danych-w-sql %}) żeby zwrócić średnią wartość zamówienia dla każdego stanu:

    BillingState  state_avg
    ------------  ---------------
                  5.6930693069307
    AB            5.3742857142857
    AZ            5.3742857142857
    BC            5.5171428571428
    CA            5.5171428571428
    …

Następnie takie wyniki, używając [klauzuli `JOIN`]({% post_url 2018-11-20-klauzula-join-w-zapytaniach-sql %}), złączone są z tabelą `invoice`. Kolumną używaną do złączenia jest `billingstate`. Wynikiem jest zbiór wierszy zawierający faktury, które mają uzupełnioną kolumnę `billingstate` (efekt złączenia). Każda taka faktura zestawiona jest później ze średnią obowiązującą w danym stanie:

    InvoiceId   Total       BillingState  state_avg
    ----------  ----------  ------------  ----------------
    4           8.91        AB            5.37428571428571
    5           13.86       MA            5.37428571428571
    10          5.94        Dublin        6.51714285714286
    13          0.99        CA            5.51714285714286
    14          1.98        WA            5.66
    …

### Podzapytania wewnątrz klauzuli `WHERE`

Podzapytanie może być także użyte do filtrowania wyników głównego zapytania. Przykład poniżej pokazuje takie zapytanie:

```sql
SELECT trackid
      ,name
      ,milliseconds
  FROM track
 WHERE milliseconds < (SELECT 10 * MIN(milliseconds)
                         FROM track);
```

W tym przypadku podzapytanie zwraca dziesięciokrotność długości najkrótszej ścieżki:

```sql
SELECT 10 * MIN(milliseconds)
  FROM track;
```

    10 * min(milliseconds)
    ----------------------
    10710

Następnie ten wynik użyty jest do zwrócenia ścieżek, które są krótsze od tej wartości:

    TrackId     Name        Milliseconds
    ----------  ----------  ------------
    168         Now Sports  4884        
    170         A Statisti  6373        
    178         Oprah       6635        
    2461        É Uma Part  1071        
    3304        Commercial  7941   

Możliwe jest także używanie podzapytań zwracających wiele wartości. Proszę spójrz na przykład poniżej:

```sql
SELECT trackid
      ,name
  FROM track
 WHERE mediatypeid IN (SELECT mediatypeid
                         FROM mediatype
                        WHERE name LIKE '%AAC%');
```

W tym przypadku podzapytanie zwraca listę identyfikatorów typów których nazwa pasuje do wyrażenia `'%AAC%'`. Następnie te identyfikatory użyte są do odfiltrowania ścieżek, które mają odpowiednią wartość kolumny `mediatypeid`. Innymi słowy zapytanie zwraca ścieżki, które są w formacie pasującym do `'%AAC%'`.

Wyżej wspomniałem już o zapytaniach powiązanych. Musisz wiedzieć, że podzapytania powiązane mogą wystąpić także w innych miejscach. Poniżej pokazuję Ci przykład takiego podzapytania występującego w [klauzuli `WHERE`]({% post_url 2018-07-26-klauzula-where-w-zapytaniach-sql %}):

```sql
SELECT albumid
      ,name
      ,milliseconds
  FROM track AS outer_track 
 WHERE milliseconds < (SELECT AVG(milliseconds)
                         FROM track AS inner_track
                        WHERE inner_track.albumid = outer_track.albumid);
```

W tym przypadku podzapytanie zwraca średnią długość ścieżki dla każdego albumu. Następnie wartość ta użyta jest w głównym zapytaniu. Pozwala ona zwrócić wyłącznie te wiersze, które dotyczą ścieżek o długości krótszej niż średnia z ich albumu.

#### Operator `EXISTS`

W artykule dotyczącym [klauzuli `WHERE`]({% post_url 2018-07-26-klauzula-where-w-zapytaniach-sql %}) pominąłem między innymi możliwość użycia operatora `EXISTS`. Operator `EXISTS` powoduje, że zwrócone są wyłącznie te wiersze, dla których podzapytanie zwróci co najmniej jeden wiersz. Proszę spójrz na przykład:

```sql
SELECT *
  FROM employee AS outer_employee
 WHERE EXISTS (SELECT *
                 FROM employee AS inner_empolyee
                WHERE inner_employee.reportsto = outer_employee.employeeid);
```

W tym przypadku skorelowane podzapytanie zwraca wiersze, które połączone są relacją szef-podwładny. Wiersze, które zawierają pracowników nie posiadających podwładnych są pominięte. Dzieje się tak dlatego, że podzapytanie w ich przypadku nie zwróci ani jednego wiersza.

#### Operatory `ALL` i `ANY` 

Operatory `ALL` i `ANY` nie są obsługiwane przez bazę SQLite.
{:.notice--warning}

Operatory `ALL` i `ANY` używa się w połączeniu z [operatorami porównania z klauzuli `WHERE`]({% post_url 2018-07-26-klauzula-where-w-zapytaniach-sql %}#-----).

Na przykład wyrażenie `kolumna > ALL (podzapytanie)` oznacza, że kolumna musi mieć większą wartość niż wszystkie wartości zwrócone przez podzapytanie.

Analogicznie `kolumna <= ANY (podzapytanie)` oznacza, że kolumna musi mieć wartość mniejszą bądź równą którejkolwiek z wartości zwróconych przez podzapytanie.

Chociaż SQLite nie wspiera tych operatorów identyczne zachowanie można uzyskać stosując [funkcje `MIN` albo `MAX`]({% post_url 2018-10-20-funkcje-i-grupowanie-danych-w-sql %}#funkcje-grupując). Dla przykładu dwa poniższe zapytania dałyby te same wyniki:

```sql
SELECT *
  FROM track
 WHERE milliseconds < ALL (SELECT milliseconds
                             FROM track);
```

```sql
SELECT *
  FROM track
 WHERE milliseconds < (SELECT MAX(milliseconds)
                         FROM track);
```

### Podzapytania jako wyrażenie

Podzapytania zwracające pojedynczą wartość mogą traktowane być jako wyrażenie. W związku z tym mogą wystąpić w innych miejscach zapytania SQL. Kilka zapytań tego typu omówiłem dokładnie w poprzednich podpunktach.

Poniżej pokazuję kilka przykładów obrazujących użycie podzapytań w innych miejscach zapytania SQL.

#### Podzapytania wewnątrz klauzuli `ORDER BY`

Dziwne, ale poprawne sortowanie:

```sql
  SELECT *
    FROM artist
ORDER BY (SELECT MAX(albumid)
            FROM album
           WHERE artist.artistid = album.artistid);
```

#### Podzapytania wewnątrz klauzuli `LIMIT`

Ponownie dziwne, ale poprawne ograniczanie liczby wierszy:

```sql
SELECT * FROM album LIMIT (SELECT COUNT(*)
                             FROM artist);
```

#### Podzapytania wewnątrz klauzuli `HAVING`

Tym razem podzapytanie zostało użyte do zwrócenia wierszy, dla których suma jest większa niż suma w jednym ze stanów:

```sql
  SELECT customerid
        ,SUM(total) AS sum_total
    FROM invoice
GROUP BY customerid
  HAVING sum_total > (SELECT SUM(total)
                        FROM invoice
                       WHERE billingstate = 'WA');
```

## Podzapytania a klauzula `JOIN`

Często istnieje wiele sposobów na uzyskanie tych samych wyników. W przypadku niektórych podzapytań możliwe jest ich zastąpienie odpowiednimi złączeniami. Poprawne użycie [klauzuli `JOIN`]({% post_url 2018-11-20-klauzula-join-w-zapytaniach-sql %}) może pomóc w usunięciu niechcianego podzapytania.

## Podzapytania w innych rodzajach zapytań

Do tej pory w ramach [kursu SQL]({{ '/kurs-sql/' }}) omawiałem wyłącznie [zapytania typu `SELECT`]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}). W języku SQL istnieją także inne rodzaje zapytań. Musisz wiedzieć, że także w zapytaniach typu `UPDATE` czy `DELETE` możesz spodziewać się użycia podzapytań.

## Dobre praktyki przy używaniu podzapytań

To, że coś jest możliwe, wcale nie znaczy, że powinno być używane. Zapytania SQL szybko mogą stać się mało czytelne. Przez co będą trudne w zrozumieniu i późniejszym utrzymaniu. Jeśli podzapytanie wprowadza niepotrzebne zamieszanie postaraj się rozwiązać problem inaczej – czasami jest to możliwe na przykład przy użyciu [klauzuli `JOIN`]({% post_url 2018-11-20-klauzula-join-w-zapytaniach-sql %}).

Ta sama klauzula może także pomóc w optymalizowaniu zapytania zawierającego podzapytania. Dobrą praktyką jest porównanie planu wykonania obu wersji zapytania. Plan zapytania możesz sprawdzić używając `EXPLAIN <zapytanie sql>`.  
### Podzapytanie w podzapytaniu podzapytania

Podzapytania to twory, które mogą być zagnieżdżone. W zależności od silnika bazy danych limit zagnieżdżonych podzapytań może być różny. Mimo tego, że takie konstrukcje są możliwe, w codziennej pracy nie spotkałem się za podzapytaniami zagnieżdżonymi więcej niż dwa poziomy.

Nadmierne zagnieżdżanie podzapytań nie jest dobrą praktyką. Takie łańcuszki nie poprawiają czytelności zapytania. Dodatkowo powoduje problemy z jego utrzymaniem. Jeśli musisz stosować więcej niż jeden, dwa poziomy zagnieżdżenia zastanów się czy nie można rozwiązać tego problemu inaczej.

## Zadania do wykonania

Poniżej przygotowałem dla Ciebie zestaw kilku zadań, które pozwolą Ci sprawdzić wiedzę dotyczącą podzapytań w praktyce. Zanim zerkniesz do przykładowego rozwiązania zachęcam się do samodzielnej próby rozwiązania zadań – w ten sposób nauczysz się najwięcej.

Napisz zapytanie używając podzapytań, które zwróci:

1. sumaryczną wartość (kolumna `total`) faktur (tabela `invoice`), których kwota jest powyżej średniej wartości wszystkich faktur,
2. średnią liczbę albumów (tabela `album`) dla artystów, którzy opublikowali więcej niż dwa albumy,
3. wiersze zawierające identyfikator klienta (kolumna `customerid`) i wartość faktur ponad średnią wartość faktur danego klienta (`wartość - średnia`). Zapytanie powinno zwrócić wyłącznie wiersze gdzie ta różnica jest większa od `0`,
4. te same wyniki, które zwraca zapytanie poniżej bez użycia klauzuli `JOIN`:
```sql
  SELECT name 
    FROM artist JOIN album
                ON artist.artistid = album.artistid
GROUP BY name
  HAVING COUNT(*) > 10;
```
5. te same wyniki, które zwraca zapytanie poniżej bez użycia klauzuli `JOIN`:
```sql
SELECT invoiceid
      ,total
      ,invoice.billingstate
      ,billingstate_avg.state_avg
  FROM (SELECT billingstate
              ,AVG(total) AS state_avg
          FROM invoice
      GROUP BY billingstate) AS billingstate_avg JOIN invoice
                                                 ON billingstate_avg.billingstate = invoice.billingstate;
```

### Przykładowe rozwiązania zadań
1.
```sql
SELECT SUM(total)
  FROM invoice
 WHERE total > (SELECT AVG(total)
                  FROM invoice);
```
2.
```sql
SELECT AVG(how_many)
  FROM (SELECT COUNT(*) AS how_many
          FROM album
      GROUP BY artistid
        HAVING how_many > 2);
```
3.
```sql
SELECT customerid
      ,(total - (SELECT AVG(total)
                   FROM invoice AS i2
                  WHERE i1.customerid = i2.customerid)) AS above_average
  FROM invoice AS i1
 WHERE above_average > 0;
```
4.
```sql
SELECT name
  FROM artist
 WHERE artistid IN (SELECT artistid
                      FROM album
                  GROUP BY artistid
                    HAVING COUNT(*) > 10);
```
5.
```sql
SELECT invoiceid
      ,total
      ,billingstate
      ,(SELECT AVG(total) AS state_avg
          FROM invoice
         WHERE billingstate = outer.billingstate)
  FROM invoice AS outer
 WHERE billingstate IS NOT NULL;
```

## Podsumowanie

Po lekturze artykułu wiesz już czym są podzapytania. Wiesz doskonale gdzie można ich używać. Udało Ci się także poznać kilka dobrych praktyk dotyczących używania podzapytań. Po samodzielnym rozwiązaniu zadań możesz śmiało powiedzieć, że potrafisz posługiwać się podzapytaniami.

Artykuł ten zamyka część kursu poświęconą zapytaniom typu `SELECT`. W kolejnych częściach kursu poznasz pozostałe elementy języka SQL niezbędne do codziennej pracy.

Mam nadzieję, że artykuł przypadł Ci do gustu. Udało Ci się rozwiązać zadania? Podziel się swoimi rozwiązaniami! Spojrzenie na ten sam problem z innego punktu widzenia pozwoli wszystkim na nauczenie się jeszcze więcej.

Zależy mi na dotarciu do nowych Czytelników, jeśli uważasz, że ten artykuł byłby wartościowy dla kogoś z Twoich znajomych bardzo proszę podziel się z nim odnośnikiem do tego artykułu. Z góry dziękuję!

Jeśli nie chcesz ominąć kolejnych artykułów w przyszłości proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebook'u. Trzymaj się i do następnego razu!
