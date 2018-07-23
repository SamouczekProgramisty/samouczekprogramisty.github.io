---
title: Klauzula WHERE w zapytaniach SQL
categories:
- Bazy danych
- Kurs SQL
permalink: /klauzula-where-w-zapytaniach-sql/
header:
    teaser: /assets/images/2018/07/13_klauzula_where_w_zapytaniach_sql_artykul.jpeg
    overlay_image: /assets/images/2018/07/13_klauzula_where_w_zapytaniach_sql_artykul.jpeg
    caption: "[&copy; SplitShire](https://www.pexels.com/photo/binocular-country-lane-filter-focus-1421/)"
excerpt: W tym artykule przeczytasz o możliwościach klauzuli `WHERE`. Na praktycznych przykładach pokażę Ci jak filtrować dane w zapytaniach SQL. Także na przykładzie pokażę Ci czym jest atak SQL injection i jak można się przed nim bronić. Na końcu jak zwykle czekają na Ciebie zadania do samodzielnego rozwiązania.
---

{% include kurs-sql-notice.md %}

## Klauzula `WHERE`

W artykule opisującym podstawy zapytania `SELECT` wspomniałem o klauzyli `WHERE`. Po przeczytaniu tamtego artykułu wiesz, że klauzula `WHERE` służy do filtrowania danych zwróconych przez zapytania typu `SELECT`.

Klauzula `WHERE` używana jest także w zapytaniach typu `UPDATE` i `DELETE`. W pierwszym przypadku ogranicza zbiór wierszy, który powinien zostać zaktualizowany. W przypadku zapytania typu `DELETE` ogranicza zbiór wierszy, który powinien zotać usunięty. Informacje, które przeczytasz w tym artykule można odnieść do wszystkich trzech rodzai zapytań.

## Literały w SQL

Zanim przejdę do omawiania warunków musisz poznać literały. Używalem ich już w [poprzednim artykule]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}), jednak tutaj poświęcę im osobny paragraf.


## Warunki

Każdy z warunków, który opopiszę można ze sobą łączyć używając operatorów `AND` lub `OR`. `AND` ma pierwszeństwo przed `OR`. Można także użyć nawiasów `()`, aby określić pierwszeństwo wykonania warunków. Używanie nawiasów nie jest obowiązkowe. Jednak moim zdaniem często warto ich używać. Dzięki nim bardziej skomplikowane zapytania mogą być bardziej czytelne. Na przykład nawiasy w przykładzie poniżej są zbędne, nie mają wpływu na kolejność wykonywania operacji:
   
    x OR y AND z
    x OR (y AND z)

Nawiasy w przykładzie poniżej zmieniają kolejność wykonywania operacji więc nie można ich pominąć bez zmiany znaczenia zapytania:

    (x OR y) AND z

### `<`, `<=`, `=`, `>`, `>=`

Zacznę od najprostszych typów porównań. Podobne operatory występują także w językach programowania. Operatory porównują ze sobą wartości po obu stronach.

* `A < B` - wiersz spełnia warunek jeśli A jest mniejsze od B,
* `A <= B` - wiersz spałnia warunek jeśli A jest mniejsze bądź równe B,
* `A = B` - wiersz spełnia warunek jeśli A jest równe B,
* `A > B` - wiersz spełnia warunek jeśli A jest większe od B,
* `A >= B` - wiersz spełnia warunek jeśli A jest większe bądź równe B.

Na przykład zapytanie poniżej wyświetli tylko te wiersze z tabeli `invoice`, których wartość kolumny `total` będzie większa niż 14 i mniejsza niż 15:

```sql
SELECT invoiceid
      ,total
  FROM invoice
 WHERE total > 14
   AND total < 15;
```

W odróżnieniu od języków programowania operator porównania ma postać pojedynczego znaku równości `=`. Następne zapytanie zwróci jedynie te wiersze, dla których kolumna `total` ma wartość `21.68`:

```sql
SELECT invoiceid
      ,total
      ,billingcountry
  FROM invoice
 WHERE total = 21.86;
```

W przypadku języka SQL operatory służą one do porównywania wartości kolumn. Mogą być użyte nie tylko do typów liczbowych. Dzięki tym operatorom można na przykład porównywać łańcuchy znaków. Zapytanie poniżej zwróci tylko te wiersze dla których kolumna `billingcountry` będzie większa niż `A` i mniejsza niż `C`. Innymi słowy zapytanie to zwróci wiersze, dla których `billingcountry` zawiera kraje zaczynające się na literę A albo B:

select * from invoice where billingcountry > 'A' and billingcountry < 'B';

### NOT BETWEEN
### NOT LIKE
### IS NULL
### NOT IN

## Łączenie warunków


# Czym jest SQL Injection

SQL Injection jest jednym z podstawowych ataków na aplikacje używające baz danych. Polega on na odpowiednim spreparowaniu danych wejściowych użytkownika.

W takim przypadku poza zapytaniem, które przygotuje programista wykonywane może być także to wprowadzone przez użytkownika.

Proszę spójrz na przykład. W ten sposób na pewno będzie Ci łatwiej zrozumieć ten typ ataku.

Załóżmy, że w aplikacji próbujesz zaimplementować moduł logowania[^nierobtego]. Użytkownik w formularzu wprowadza swój email i hasło.

[^nierobtego]: Do tej pory nie spotkałem się jeszcze z sytuacją, mechanizm logowania musiałbym pisać od podstaw samemu. Nie rób tego samodzielnie, użyj gotowego, sprawdzonego rozwiązania. ↩

Aby upewni

programista napisał takie zapytanie:

```sql
SELECT password_hash 
  FROM users
 WHERE email = '%s';
```

Następinie w programie pobiera dane wprowadzone w formularzu

1=1 i SQL injection

# Zadania do wykonania

# Podsumowanie
