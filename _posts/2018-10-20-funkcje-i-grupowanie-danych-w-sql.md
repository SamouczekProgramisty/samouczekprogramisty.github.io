---
title: Funkcje i grupowanie wierszy w SQL
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

Na pewno znasz różne funkcje. Mogą kojarzyć Ci się z matemtatyką czy językami programowania. Okazuje się, że funkcje występują też w języku SQL. Funkcja w przypadku SQL zaimplementowana jest przez silnik bazy danych[^swoje]. Funkcje udostępnione przez silnik SQL możesz użyć w zapytaniach.


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

### Funckcja operująca na tabeli

Teraz zobacz jak wygląda wywołanie tej samej funkcji na wartości kolumny z tabeli:

```sql
SELECT LENGTH(billingstate)
  FROM invoice
 LIMIT 5;
```

W wyniku zapytania możez zobaczyć długość kolumny `billingstate` dla pięciu wierszy. Ograniczelie liczby wierszy jest możliwe dzięki [wyrażeniu `LIMIT`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#ograniczanie-liczby-wynik%C3%B3w):

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

Wyniki tego zapytania można zrozumieć jako: w tabeli `invoice` istnieją wiersze, których wartość kolumny `billingstate` jest pusta, ma długość 2, 6 lub 3.

### Użycie wyniku funkcji w wielu miejscach

A co jeśli chesz uzyskać posortowany wynik? Możesz powtórzyć wywołanie funkcji w [wyrażeniu `ORDER BY`](
{% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#sortowanie-wyników):

```sql
  SELECT DISTINCT LENGTH(billingstate)
    FROM invoice
ORDER BY LENGTH(billingstate);
```

Jendak w tym przypadku lepszym rowziązaniem jest [użycie aliasów]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#aliasy-dla-kolumn):

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

- `ABS` - zwraca [wartość bezwzględną](https://pl.wikipedia.org/wiki/Warto%C5%9B%C4%87_bezwzgl%C4%99dna) przyjmowanego argumentu,
- `LENGTH` - tę funkcję już znasz, zwraca długość łańcucha znaków,
- `LOWER` - zwraca kopię łańcucha znaków przekazanego jako parametr, w którym wszystkie litery zamienione są na małe[^ascii],
- `RANDOM` - zwraca losową liczbę całkowitą,
- `SUBSTR`[^substring] - `SUBSTR(x, y, z)` pobiera podzbiór znaków parametru `x` od litery `y` do litery `z`. Parametr `z` może być pominięty, wtedy funkcja zwraca podzbiór znaków od znaku `y` do końca,
- `TRIM` - usuwa spacje z obu stron przekazanego parametru,
- `UPPER` - funkcja działa podobnie jak `LOWER`, tym razem zwracany łańcuch znaków składa się z wielkich liter.

[^ascii]: W przypadku SQLite zamieniane są tylko litery kodowane w [ASCII](https://pl.wikipedia.org/wiki/ASCII), niestety funkcja ta nie działa poprawnie dla polskich znaków.
[^substring]: Wspominałem, że funkcje mogą być specyficzne dla różnych silników baz danych. Na przykład odpowiednikiem `SUBSTR` w Postgresql jest `SUBSTRING`.

Poza funkcjami, które wspomniałem wyżej istnieją też funkcje, które operują na grupach. Zanim jednak je omówię muszę powiedzieć Ci coś więcej o grupowaniu wierszy w SQL.

{% include newsletter-srodek.md %}

## Grupowanie wierszy przy pomocy `GROUP BY`

Wiesz już, że tabela `invoice` zawiera dane o fakturach. Załóżmy, że zadaniem jest przygotowanie raportu, w którym znajdzie się największa faktura dla każdego kraju. Żeby zrealizować takie wymaganie musisz pogrupować ze sobą wszystkie wiersze dotyczące danego kraju i znaleźć wśród nich ten, który ma największą wartość. W tym przypadku będziesz potrzebować wyrażenia `GROUP BY`. Proszę spójrz na przykład poniżej:

```sql
  SELECT billingcountry, MAX(total)
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
  SELECT billingcountry, billingstate, MAX(total)
    FROM invoice
GROUP BY billingcountry, billingstate,
   LIMIT 5;
```

### Uważaj na grupowanie w SQLite

SQLite jest pobłażliwy. Oznacza to tyle, że poniższe zapytanie uzna za poprawne:

```sql
SELECT billingcountry, MAX(total)
  FROM invoice;
```

W innych znanych mi bazach danych wywołanie takiego zapytania skończy się błędem podobnym do tego:

    ERROR:  column "invoice.billingcountry" must appear in the GROUP BY clause or be used in an aggregate function

Zapamiętaj, że każda kolumna, która jest zwracana powinna być albo uwzlędniona w wyrażeniu `GROUP BY`, albo przekazana do funkcji grupującej.

### Funkcje grupujące

Znasz już jedną z nich, `MAX`. Nadszedł czas na poznanie kolejnych:

- `AVG` - aa
- `MIN` - aa
- `SUM` - aa
- `TOTAL` - aa

Jest jeszcze jedna funkcja grupująca, która jest bardzo popularna. Jest nią `COUNT`.

#### Funkcja grupująca `COUNT`

```sql
SELECT COUNT(customerid)
  FROM invoice;
```

```sql
SELECT COUNT(*)
  FROM invoice;
```

```
412
```

```sql
SELECT COUNT(DISTINCT customerid)
  FROM invoice;
```

```
59
```

```sql
SELECT COUNT(billingstate)
  FROM invoice;
```

```
210
```

```sql
SELECT COUNT(DISTINCT billingstate)
  FROM invoice;
```

```
25
```

### Klauzula `HAVING`

## Czym różni się `WHERE` od `HAVING`?

Jest to jedno z popularnych pytań, które pojawiają się na rozmowach rekrutacyjnych. Pomogę Ci na nie odpowiedzieć :).

## Zadania do wykonania

### Przykładowe rozwiązania zadań

## Podsumowanie
