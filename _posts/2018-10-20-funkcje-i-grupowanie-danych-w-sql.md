---
title: Funkcje i grupowanie wierszy w SQL
last_modified_at: 2018-10-22 00:40:25 +0200
categories:
- Bazy danych
- Kurs SQL
permalink: /funkcje-i-grupowanie-wierszy-w-sql/
header:
    teaser: /assets/images/2018/10/20_funkcje_i_grupowanie_wierszy_w_sql.jpeg
    overlay_image: /assets/images/2018/10/20_funkcje_i_grupowanie_wierszy_w_sql.jpeg
    caption: "[&copy; geralt](https://pixabay.com/en/learn-mathematics-child-girl-2300141/)"
excerpt: >
    Artykuł ten opisuje podstawowe funkcje używane w zapytaniach SQL. Omawia także mechanizm grupowania. Po lekturze tego artykułu będziesz wiedzieć jak używać klauzuli `GROUP BY` i dowiesz się jaka jest różnica pomiędzy `HAVING` a `WHERE`. Na końcu artykułu czekają na Ciebie zadania z przykładowymi rozwiązaniami.
---

{% include kurs-sql-notice.md %}

## Funkcje

Na pewno znasz różne funkcje. Mogą kojarzyć Ci się z matematyką czy językami programowania. Okazuje się, że funkcje występują też w języku SQL. Funkcja w przypadku SQL zaimplementowana jest przez silnik bazy danych[^swoje]. Funkcje udostępnione przez silnik SQL możesz użyć w zapytaniach.


[^swoje]: Różne silniki baz danych pozwalają na definiowanie własnych funkcji. Na przykład SQLite udostępnia tę funkcjonalność poprzez funkcję [`sqlite3_create_function`](https://www.sqlite.org/c3ref/create_function.html). Odsyłam Cię do dokumentacji twojej bazy danych jeśli chcesz poznać więcej szczegółów.

Proszę spójrz na przykład:

```sql
SELECT LENGTH('abcd');
```

Tak, to jest poprawne zapytanie SQL. Wyrażenia `FROM` czy `WHERE` są opcjonalne w [zapytaniach typu `SELECT`]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}).
{:.notice--info}

W przykładzie tym wywołuję funkcję `LENGTH`, która jako parametr przyjmuje łańcuch znaków `abcd`. Wynikiem działania tego zapytania jest jeden wiersz, który zawiera długość przekazanego parametru:

```
4
```

### Funkcja operująca na tabeli

Teraz zobacz jak wygląda wywołanie tej samej funkcji na wartościach kolumny z tabeli:

```sql
SELECT LENGTH(billingstate)
  FROM invoice
 LIMIT 5;
```

W wyniku zapytania możesz zobaczyć długość kolumny `billingstate` dla pięciu wierszy. Ograniczenie liczby wierszy jest możliwe dzięki [wyrażeniu `LIMIT`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#ograniczanie-liczby-wynik%C3%B3w):

```



2
2
```

Dodam teraz kolejny element, który wprowadziłem poprzednio. Chodzi mi tu o [wyrażenie `DISTINCT`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#wy%C5%82%C4%85cznie-unikalne-wiersze). Wiesz pewnie, że zapewnia ono zwrócenie unikalnych wartości. W następnym przykładzie zapytanie zwraca unikalne długości wartości w kolumnie `billingstate` w tabeli `invoice`. Wynikiem działania tego zapytania są cztery wiersze:

```sql
SELECT DISTINCT LENGTH(billingstate)
  FROM invoice;
```

```

2
6
3
```

Pierwszy pusty wiersz zawiera kolumnę z wartością [`NULL`]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}#magiczna-warto%C5%9B%C4%87-null). Odpowiada on wszystkim wierszom z tabeli `invoice`, które w kolumnie `billingstate` mają wartość `NULL`.

Wyniki tego zapytania można zrozumieć jako: w tabeli `invoice` istnieją wiersze, których wartość kolumny `billingstate` jest pusta, ma długość 2, 6 albo 3.

### Użycie wyniku funkcji w wielu miejscach

A co jeśli chcesz uzyskać posortowany wynik? Możesz powtórzyć wywołanie funkcji w [wyrażeniu `ORDER BY`](
{% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#sortowanie-wyników):

```sql
  SELECT DISTINCT LENGTH(billingstate)
    FROM invoice
ORDER BY LENGTH(billingstate);
```

Jednak w tym przypadku lepszym rozwiązaniem jest [użycie aliasów]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#aliasy-dla-kolumn):

```sql
  SELECT DISTINCT LENGTH(billingstate) AS len
    FROM invoice
ORDER BY len;
```

W obu przypadkach zapytania zwrócą cztery posortowane rosnąco wiersze:

```

2
3
6
```

### Funkcje można łączyć

Funkcje przyjmują parametry. Wiesz już, że funkcja `LENGTH` przyjmuje łańcuch znaków. Przykładem innej funkcji może być `MAX`. Funkcja ta wybiera maksymalną wartość dla danej grupy (o grupach przeczytasz więcej w dalszej części artykułu):

```sql
SELECT MAX(LENGTH(billingstate))
  FROM invoice;
```

Przykład powyżej zwróci jeden wiersz, zawierający maksymalną wartość zwróconą przez funkcję `LENGTH`:

```
6
```

## Kilka przykładowych funkcji

Do tej pory pokazałem Ci tylko dwie funkcje `MAX` i `LENGTH`. Niżej pokażę Ci kilka innych.  Proszę pamiętaj o tym, że dużo funkcji jest charakterystycznych dla poszczególnych silników baz danych. W artykule starałem się opisać wyłącznie te, które są dostępne powszechnie. Zachęcam Cię do sprawdzenia dokumentacji Twojej bazy danych, żeby sprawdzić całą listę dostępnych funkcji.

- `ABS` – zwraca [wartość bezwzględną](https://pl.wikipedia.org/wiki/Warto%C5%9B%C4%87_bezwzgl%C4%99dna) przyjmowanego argumentu,
- `LENGTH` – tę funkcję już znasz, zwraca długość łańcucha znaków,
- `LOWER` – zwraca kopię łańcucha znaków przekazanego jako parametr, w którym wszystkie litery zamienione są na małe[^ascii],
- `RANDOM` – zwraca losową liczbę całkowitą,
- `SUBSTR`[^substring] – `SUBSTR(x, y, z)` pobiera podzbiór znaków parametru `x` od litery `y` do litery `z`. Parametr `z` może być pominięty, wtedy funkcja zwraca podzbiór znaków od znaku `y` do końca,
- `TRIM` – usuwa spacje z obu stron przekazanego parametru,
- `UPPER` – funkcja działa podobnie jak `LOWER`, tym razem zwracany łańcuch znaków składa się z wielkich liter.

[^ascii]: W przypadku SQLite zamieniane są tylko litery kodowane w [ASCII](https://pl.wikipedia.org/wiki/ASCII), niestety funkcja ta nie działa poprawnie dla polskich znaków.
[^substring]: Wspominałem, że funkcje mogą być specyficzne dla różnych silników baz danych. Na przykład odpowiednikiem `SUBSTR` w Postgresql jest `SUBSTRING`.

Poza funkcjami, które wspomniałem wyżej istnieją też funkcje, które operują na grupach. Zanim jednak je omówię muszę powiedzieć Ci coś więcej o grupowaniu wierszy w SQL.

{% include newsletter-srodek.md %}

## Grupowanie wierszy przy pomocy `GROUP BY`

Wiesz już, że tabela `invoice` zawiera dane o fakturach. Załóżmy, że zadaniem jest przygotowanie raportu, w którym znajdzie się największa faktura dla każdego kraju. Żeby zrealizować takie wymaganie musisz pogrupować ze sobą wszystkie wiersze dotyczące danego kraju i znaleźć wśród nich ten, który ma największą wartość. W tym przypadku będziesz potrzebować wyrażenia `GROUP BY`. Proszę spójrz na przykład poniżej:

```sql
  SELECT billingcountry
        ,MAX(total)
    FROM invoice
GROUP BY billingcountry
   LIMIT 5;
```

To zapytanie zwróci pięć wierszy. Każdy z nich zawierał będzie kraj i największą wartość faktury dla danego kraju:

```
Argentina 13.86
Australia 13.86
Austria   18.86
Belgium   13.86
Brazil    13.86
```

### Grupowanie kilku kolumn

Podobnie jak w przypadku [sortowania w SQL]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}) tak i przy grupowaniu możesz określić wiele kolumn. Proszę spójrz na przykład poniżej:

```sql
  SELECT billingcountry
        ,billingstate
        ,MAX(total)
    FROM invoice
GROUP BY billingcountry
        ,billingstate
   LIMIT 5;
```

Tym razem zapytanie zwróci pięć wierszy, które będą zawierały maksymalną wartość faktury dla pary `billingcountry` i `billingstate`:

```
Argentina                     13.86
Australia       NSW           13.86
Austria                       18.86
Belgium                       13.86
Brazil          DF            13.86
```

### Uważaj na grupowanie w SQLite

Zachowanie SQLite w przypadku grupowania i brakującego wyrażenia `GROUP BY` jest dziwne. Oznacza to tyle, że poniższe zapytanie SQLite uzna za poprawne:

```sql
SELECT billingcountry
      ,MAX(total)
  FROM invoice;
```

Wywołanie takiego zapytania w bazie PostgreSQL kończy się błędem:

    ERROR:  column "invoice.billingcountry" must appear in the GROUP BY clause or be used in an aggregate function

Zapamiętaj, że każda kolumna, która jest zwracana powinna być albo uwzględniona w wyrażeniu `GROUP BY`, albo użyta w funkcji grupującej.

### Funkcje grupujące

W artykule pokazałem Ci już kilka funkcji dostępnych w SQL. Istnieje odrębna grupa funkcji, która używana jest przy grupowaniu wartości. Znasz już jedną z nich, `MAX`. Nadszedł czas na poznanie kolejnych:

- `AVG` – zwraca średnią wartość,
- `MIN` – zwraca minimalną wartość,
- `SUM` – zwraca sumę wartości,
- `TOTAL` – działa podobnie jak `SUM`, jedyna różnica polega na tym, że jeśli wszystkie wartości to `NULL`, wówczas `TOTAL` zwróci 0, a `SUM` zwróci `NULL`.

Jest jeszcze jedna funkcja grupująca, która jest bardzo popularna. Jest nią `COUNT`.

#### Funkcja grupująca `COUNT

Funkcja `COUNT` służy do zliczania wierszy, które mają wartość inną niż `NULL`. Jej najprostsza postać może wyglądać jak w przykładzie poniżej. To zapytanie zwróci liczbę wierszy, dla których wartość kolumny `customerid` nie ma wartości `NULL`:

```sql
SELECT COUNT(customerid)
  FROM invoice;
```
Jeśli chcesz policzyć ogólną liczbę wierszy możesz użyć `*` jako argumentu:

```sql
SELECT COUNT(*)
  FROM invoice;
```

W obu przypadkach zapytanie zwróci jeden wiersz:

```
412
```
W przypadku funkcji `COUNT`  możesz także użyć [wyrażenia `DISTINCT`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#wy%C5%82%C4%85cznie-unikalne-wiersze):

```sql
SELECT COUNT(DISTINCT customerid)
  FROM invoice;
```

W tym przypadku zapytanie zwróci liczbę unikalnych wartości kolumny `customerid`:

```
59
```

## Klauzula `HAVING`

Załóżmy tym razem, że potrzebujesz raport, w którym pokażesz sumaryczny przychód dla poszczególnych krajów. Poniższe zapytanie da Ci odpowiednie wyniki:

```sql
  SELECT billingcountry
        ,SUM(total)
    FROM invoice
GROUP BY billingcountry;
```
Może zdarzyć się sytuacja, w której nie potrzebujesz całej listy. W tym przypadku raport powinien zawierać wyłącznie te kraje, dla których suma sprzedaży była większa niż 100. Z pomocą w tego typu zapytaniach przychodzi klauzula `HAVING`:

```sql
  SELECT billingcountry
        ,SUM(total) AS summed_total
    FROM invoice
GROUP BY billingcountry
  HAVING summed_total > 100;
```

Wynikiem tego zapytania będzie poniższe sześć wierszy:

```
Brazil          190.1
Canada          303.96
France          195.1
Germany         156.48
USA             523.06
United Kingdom  112.86
```

### Czym różni się `WHERE` od `HAVING`?

Jest to jedno z popularnych pytań, które pojawiają się na rozmowach rekrutacyjnych. Pomogę Ci na nie odpowiedzieć :). Odpowiadając jednym zdaniem możesz powiedzieć, że klauzula `WHERE` służy do filtrowania wyników zapytania biorąc pod uwagę pojedynczy wiersz, natomiast klauzula `HAVING` pozwala na filtrowanie wyników na podstawie zgrupowanych wartości.

Jeśli otrzymasz tego typu pytanie na rozmowie kwalifikacyjnej posłuż się jakimś prostym przykładem, w którym pokażesz tę różnicę w praktyce.

Połączenie `WHERE` i `HAVING` w jednym zapytaniu często pozwala lepiej zrozumieć różnicę pomiędzy nimi. W przykładzie poniżej zmodyfikowałem poprzednie zapytanie, tak żeby nie uwzględniało stolicy Kanady:

```sql
  SELECT billingcountry
        ,SUM(total) AS summed_total
    FROM invoice
   WHERE billingcity != 'Ottawa'
GROUP BY billingcountry
  HAVING summed_total > 100;
```

Wyniki tym razem są inne. Proszę zwróć uwagę na sumę dla Kanady w obu przypadkach:

```
Brazil          190.1       
Canada          266.34      
France          195.1       
Germany         156.48      
USA             523.06      
United Kingdom  112.86  
```

## Zadania do wykonania

Przygotowałem dla Ciebie kilka zadań do wykonania. Każde z nich możesz wykonać używając wcześniej przygotowanego środowiska. Jak zawsze zachęcam Cię do eksperymentowania, wtedy nauczysz się najwięcej.

Napisz zapytanie, które zwróci:

- średnią, minimalną i maksymalną wartość kolumny `total` w tabeli `invoice`,
- liczbę wierszy w tabeli `invoice` w których długość kolumny `billingcountry` jest większa niż 5,
- liczbę unikalnych dat (kolumna `invoicedate`), w których wystawiono faktury (tabela `invoice`),
- daty (kolumna `invoicedate`), w których wystawiono co najmniej dwie faktury (tabela `invoice`),
- pięć losowych wierszy z tabeli `genre` (wywołania tego zapytania wiele razy powinno zwrócić różne wyniki),
- miesięczną (kolumna `invoicedate`) sumę faktur (kolumna `total` w tabeli `invoice`) od kupujących z identyfikatorem (kolumna `customerid`) mniejszym niż 30, wynik powinien być posortowany po miesięcznej sumie faktur i zawierać jedynie te miesiące dla których suma jest większa od 40.

### Przykładowe rozwiązania zadań

```sql
SELECT AVG(total)
      ,MIN(total)
      ,MAX(total)
  FROM invoice;
```

```sql
SELECT count(*)
  FROM invoice
 WHERE LENGTH(billingcountry) > 5;
```

```sql
SELECT COUNT(DISTINCT invoicedate)
  FROM invoice;
```

```sql
  SELECT invoicedate 
    FROM invoice
GROUP BY invoicedate
  HAVING count(*) >= 2;
```

```sql
  SELECT *
    FROM genre
ORDER BY RANDOM()
   LIMIT 5;
```

```sql
  SELECT SUBSTR(invoicedate, 0, 8) AS invoice_month
        ,SUM(total) AS monthly_total
    FROM invoice
   WHERE customerid < 30
GROUP BY invoice_month
  HAVING monthly_total > 40
ORDER BY monthly_total;
```

## Podsumowanie

Po lekturze artykułu wiesz czym jest grupowanie wierszy. Znasz kilka przydatnych funkcji w SQL. Potrafisz powiedzieć jaka jest różnica pomiędzy wyrażeniami `HAVING` i `WHERE`. Po rozwiązaniu zadań wiesz, że umiesz zastosować tę wiedzę w praktyce. Gratuluję! :)

Daj znać w komentarzach jak udało Ci się rozwiązać zadania, może Twoje zapytania wyglądają trochę inaczej?

Na koniec mam do Ciebie standardową prośbę. Jeśli znasz kogoś, komu ten artykuł może pomóc proszę przekaż tej osobie linka do artykułu. Dzięki temu pomożesz mi dotrzeć do nowych czytelników – z góry dziękuję za Twoją pomoc. Jeśli nie chcesz ominąć kolejnych artykułów dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Do następnego razu!
