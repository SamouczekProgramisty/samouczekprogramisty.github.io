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

# Klauzula `WHERE`

W artykule opisującym podstawy zapytania `SELECT` wspomniałem o klauzyli `WHERE`. Po przeczytaniu tamtego artykułu wiesz, że klauzula `WHERE` służy do filtrowania danych zwróconych przez zapytania typu `SELECT`.

Klauzula `WHERE` używana jest także w zapytaniach typu `UPDATE` i `DELETE`. W pierwszym przypadku ogranicza zbiór wierszy, który powinien zostać zaktualizowany. W przypadku zapytania typu `DELETE` ogranicza zbiór wierszy, który powinien zotać usunięty.

## Warunki

### < <= = > >=

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
