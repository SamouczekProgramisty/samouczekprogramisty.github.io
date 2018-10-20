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

[^swoje]: Różne silniki baz danych pozwalają na definiowanie własnych funkcji. Na przykład SQLite udostępnia tę funkcjonalność poprzez funkcję [`sqlite3_create_function`](https://www.sqlite.org/c3ref/create_function.html). Odsyłam Cię do dokumentacji twojej bazy danych jeśli chcesz poznać szczegóły.

Proszę spójrz na przykład:


```sql
SELECT DISTINCT LENGTH(billingstate)
  FROM invoice;
```

Pamiętasz [wyrażenie `DISTINCT`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#wy%C5%82%C4%85cznie-unikalne-wiersze)? Wiesz pewnie, że zapewnia ono zwrócenie unikalnych wartości. W przykładzie wyżej zapytanie zwraca unikalne długości wartości w kolumnie `billingstate` w tabeli `invoice`:

```

2
6
3
```

Pierwszy pusty wiersz to `NULL`, który został zwrócony dla wszystkich wierszy, które posiadają `NULL` jako wartość kolumny `billingstate`.

Wyniki tego zapytania można zrozumieć jako: w tabeli `invoice` istnieją wiersze, których wartość kolumny `billingstate` jest pusta, ma długość 2, 6 lub 3.

### Funkcje można łączyć

```sql
SELECT MAX(LENGTH(billingstate))
  FROM invoice;
```

Proszę pamiętaj o tym, że dużo funkcji jest charakterystycznych dla poszczególnych silników baz danych. W artykule starałem się opisać wyłącznie te, które są dostępne powszechnie. Zachęcam Cię do sprawdzenia dokumentacji Twojej bazy danych, żeby sprawdzić całą listę dostępnych funkcji.
{:.notice--warning}

+ `ABS`
`CHAR_LENGTH`
`CONCAT`
`DATE_PART`
`DATE_TRUNC`
`LENGTH`
`LOWER`
`POSITION`
`REPEAT`
`SUBSTRING`
`TO_DATE`
`TRUNC`
`UPPER`

{% include newsletter-srodek.md %}

## Grupowanie wierszy

### Klauzula `GROUP BY`

### Funkcje grupujące

SELECT COUNT(customerid) FROM invoice;
SELECT COUNT(*) FROM invoice;
412
SELECT COUNT(DISTINCT customerid) FROM invoice;
59
SELECT COUNT(billingstate) FROM invoice;
210
SELECT COUNT(DISTINCT billingstate) FROM invoice;
25

`MAX`
`MIN`
`SUM`, `TOTAL`
`AVG`

### Klauzula `HAVING`

## Czym różni się `WHERE` od `HAVING`?

## Zadania do wykonania

### Przykładowe rozwiązania zadań

## Podsumowanie
