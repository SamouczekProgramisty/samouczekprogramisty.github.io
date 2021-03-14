---
title: Klauzula WHERE w zapytaniach SQL
last_modified_at: 2021-03-14 11:47:30 +0100
categories:
- Bazy danych
- Kurs SQL
permalink: /klauzula-where-w-zapytaniach-sql/
header:
    teaser: /assets/images/2018/07/13_klauzula_where_w_zapytaniach_sql_artykul.jpeg
    overlay_image: /assets/images/2018/07/13_klauzula_where_w_zapytaniach_sql_artykul.jpeg
    caption: "[&copy; SplitShire](https://www.pexels.com/photo/binocular-country-lane-filter-focus-1421/)"
excerpt: W tym artykule przeczytasz o możliwościach klauzuli `WHERE`. Na praktycznych przykładach pokażę Ci jak filtrować dane w zapytaniach SQL. Także na przykładzie pokażę Ci czym jest atak _SQL injection_ i jak można się przed nim bronić. Dowiesz się także czegoś więcej o znakach specjalnych w SQL. Na końcu jak zwykle czekają na Ciebie zadania do samodzielnego rozwiązania.
---

{% include kurs-sql-notice.md %}

## Klauzula `WHERE`

W artykule opisującym [podstawy zapytania `SELECT`]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}) wspomniałem o klauzuli `WHERE`. Po przeczytaniu tamtego artykułu wiesz, że klauzula `WHERE` służy do filtrowania danych zwróconych przez zapytania typu `SELECT`.

Klauzula `WHERE` używana jest także w zapytaniach typu `UPDATE`, `INSERT` i `DELETE`. W pierwszym przypadku ogranicza zbiór wierszy, który powinien zostać zaktualizowany. W przypadku zapytania typu `DELETE` ogranicza zbiór wierszy, który powinien zostać usunięty. W zapytaniach typu `INSERT` używany jest z podzapytaniami (o podzapytaniach przeczytasz w jednym z kolejnych artykułów).

Informacje, które przeczytasz w tym artykule można odnieść do wszystkich czterech rodzajów zapytań.

## Literały w SQL

Zanim przejdę do omawiania warunków musisz poznać literały. Używałem ich już w [poprzednim artykule]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}) bez dodatkowego wyjaśnienia. Tutaj poświęcę im osobny paragraf.

Najprostszym rodzajem literałów są liczby, zapisuje się je podobnie jak w językach programowania: `42`, `12.34`. Liczby mogą być zapisane także w [notacji naukowej]({% post_url 2017-11-06-liczby-zmiennoprzecinkowe %}#notacja-naukowa-a-liczby-wymierne) `1.34E-5` lub [szesnastkowo]({% post_url 2016-02-11-system-dwojkowy %}) `0xBACA`[^zalezyodbazy].

Często będziesz także używać łańcuchów znaków. Łańcuch znaków powinien być otoczony apostrofami, na przykład `'Samouczek Programisty'`.

[^zalezyodbazy]: To zależy od silnika bazy danych. SQLite wspiera literały tego typu.

Innym przykładem literału jest `NULL`, który określa pustą wartość.

### Znaki specjalne w SQL

W SQL występują znaki specjalne. Do tej pory wprowadziłem `'`. Jeśli chcesz aby Twoje zapytanie dotyczyło wierszy, które zawierają `'` musisz poprzedzić go drugim znakiem `'`. Spójrz na przykład poniżej, posługuję się w nim konstrukcją `LIKE`, którą opisuję w jednym z kolejnych akapitów. Zapytanie zwraca wszystkie wiersze, w których kolumna `title` zawiera znak `'`:

```sql
SELECT *
  FROM album
 WHERE title LIKE '%''%';
```

## Warunki

### Łączenie warunków

Każdy z warunków, który opiszę można ze sobą łączyć używając operatorów `AND` lub `OR`. `AND` ma pierwszeństwo przed `OR`. Można także użyć nawiasów `()`, aby określić pierwszeństwo wykonania warunków. Używanie nawiasów nie zawsze jest obowiązkowe. Jednak moim zdaniem często warto ich używać. Dzięki nim bardziej skomplikowane zapytania mogą być bardziej czytelne. Nawiasy w przykładzie poniżej są zbędne, nie mają wpływu na kolejność wykonywania operacji:

    x OR y AND z
    x OR (y AND z)

Nawiasy w przykładzie poniżej zmieniają kolejność wykonywania operacji, więc nie można ich pominąć bez zmiany znaczenia zapytania:

    (x OR y) AND z

{% include newsletter-srodek.md %}

### Negacja warunków

Poza operatorami łączenia, które już znasz, istnieje także operator negacji warunku. Służy do tego operator `NOT`. Ten operator ma wyższy priorytet niż `OR` czy `AND`. Także i w tym przypadku możesz użyć nawiasów aby zmienić kolejność wykonywanych operacji. Poniższy przykład pokazuje przypadek, w którym nawiasy nie mają wpływu na kolejność wykonywanych porównań:

    (NOT x) OR y
    NOT x OR y

Jednak umieszczenie nawiasów w innym miejscu zupełnie zmienia warunek, który musi zostać spełniony przez zwracane wiersze:

    NOT (x OR y)

### `<`, `<=`, `=`, `!=, `>`, `>=`

Zacznę od najprostszych typów porównań. Podobne operatory występują także w językach programowania. Operatory porównują ze sobą wartości po obu stronach.

* `A < B` – wiersz spełnia warunek jeśli A jest mniejsze od B,
* `A <= B` – wiersz spełnia warunek jeśli A jest mniejsze bądź równe B,
* `A = B` – wiersz spełnia warunek jeśli A jest równe B,
* `A != B` – wiersz spełnia warunek jeśli A jest różne od B,
* `A > B` – wiersz spełnia warunek jeśli A jest większe od B,
* `A >= B` – wiersz spełnia warunek jeśli A jest większe bądź równe B.

Na przykład zapytanie poniżej wyświetli tylko te wiersze z tabeli `invoice`, których wartość kolumny `total` będzie większa niż 14 i mniejsza niż 15:

```sql
SELECT invoiceid
      ,total
  FROM invoice
 WHERE total > 14
   AND total < 15;
```

Następne zapytanie zwróci jedynie te wiersze, dla których kolumna `total` ma wartość `21.68`:

```sql
SELECT invoiceid
      ,total
      ,billingcountry
  FROM invoice
 WHERE total = 21.86;
```

Operatory `=` i `!=` mają dwie postacie. W tym samym celu możesz także użyć odpowiednio `==` i `<>`.

#### Porównywanie łańcuchów znaków

W przypadku języka SQL operatory służą do porównywania wartości kolumn. Mogą być użyte nie tylko do typów liczbowych. Dzięki tym operatorom można na przykład porównywać łańcuchy znaków. Zapytanie poniżej zwróci tylko te wiersze dla których kolumna `billingcountry` będzie większa niż `A` i mniejsza niż `C`. Innymi słowy zapytanie to zwróci wiersze, dla których `billingcountry` zawiera kraje zaczynające się na literę A albo B:

```sql
SELECT *
  FROM invoice
 WHERE billingcountry > 'A'
   AND billingcountry < 'C';
```

#### Porównywanie dat

SQLite nie ma specjalnego typu do przechowywania dat. Do tego celu używane mogą być łańcuchy znaków lub liczby. W związku z tym porównywanie dat sprowadza się do porównywania tych typów danych. Na przykład zapytanie poniżej zwróci wszystkie wiersze, które zawierają faktury wystawione w Polsce od 26 maja 2012 roku.

```sql
SELECT *
  FROM invoice
 WHERE billingcountry = 'Poland'
   AND invoicedate > '2012-05-26';
```

Przy porównaniach tego typu musisz uważać. Powyższe zapytanie zwróci wiersz, który zawiera datę `2012-05-26 00:00:00`. Jeśli zmieniłbym warunek na `invoicedate > '2012-05-26 00:00:00'` wówczas ten wiersz zostałby pominięty.

### BETWEEN

Do określenia zakresu, w którym powinna znaleźć się wartość kolumny możesz użyć `BETWEEN`. Zapytanie poniżej zwróci wszystkie wiersze, dla których wartość kolumny `total` jest większa bądź równa `10.91` i mniejsza bądź równa `11.96`:

```sql
SELECT *
  FROM invoice
 WHERE total BETWEEN 10.91 AND 11.96;
```

Porównanie `total BETWEEN 10.91 AND 11.96` jest tożsame porównaniu `total >= 10.91 AND total <= 11.96`. Warunek `BETWEEN` można poprzedzić `NOT`

### LIKE

SQL pozwala także na bardziej swobodne porównywanie łańcuchów znaków. Do tego celu używa się konstrukcji `LIKE`. W tym przypadku możesz użyć dwóch symboli, które mają specjalne znaczenie:

* `%` – oznacza dowolną liczbę znaków,
* `_` – oznacza jeden znak.

Mechanizm ten można porównać do bardzo uproszczonych [wyrażeń regularnych]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}):

* `%` odpowiada `.*` w wyrażeniach regularnych,
* `_` odpowiada `.` w wyrażeniach regularnych.

Proszę spójrz na przykład poniżej. W przykładzie tym wyświetlam wyłącznie wiersze, w których wartość kolumny `billingcountry` pasuje do określenia `%land`. Innymi słowy wyświetlam wyłącznie te wiersze, które kończą się na `land`:

```sql
SELECT *
  FROM invoice
 WHERE billingcountry
  LIKE '%land';
```

Poniższe zapytanie jest lekką modyfikacją powyższego. Jak widzisz użyłem w nim `%` dwa razy. W tym przypadku wyświetlone zostaną wiersze, w których kolumna `billingcountry` zawiera ciąg znaków `land`:

```sql
SELECT *
  FROM invoice
 WHERE billingcountry
  LIKE '%land%';
```

Słowo kluczowe `LIKE` możesz poprzedzić `NOT`. Warunek `NOT x LIKE y` jest tożsamy warunkowi `x NOT LIKE y`.

Jeśli chcesz aby znaki `_` czy `%` były traktowane dosłownie musisz posłużyć się wyrażeniem `ESCAPE`. Proszę spójrz na przykład poniżej. Zapytanie zwraca wszystkie wiersze, dla których wewnątrz kolumny `name` występuje znak `%`:

```sql
SELECT *
  FROM track
 WHERE name LIKE '%e%%' ESCAPE 'e';
```

Literał po `ESCAPE` może zawierać pojedynczy znak. Symbol ten jest użyty do poprzedzenia symbolu, który powinien być traktowany dosłownie. W przykładzie powyżej użyłem `'e'`.

### IS NULL

Niektóre wiersze mogą mieć puste kolumny. Puste, czyli takie, które nie są uzupełnione żadną wartością. W takim przypadku mówi się, że kolumna ma wartość `NULL`. Aby filtrować wiersze na podstawie tej wartości należy użyć wyrażenia `IS NULL`. Na przykład zapytanie poniżej pokazuje tylko te kraje, dla których wartość kolumny `billingstate` ma wartość `NULL`:

```sql
SELECT *
  FROM invoice
 WHERE billingstate IS NULL;
```

Zwróć uwagę na to, że kolumna zawierająca łańcuch znaków `''` (pusty łańcuch znaków) i wartość `NULL` to dwie zupełne różne rzeczy.

Podobnie jak w przypadku `LIKE` także tutaj możesz użyć słowa kluczowego `NOT`. Warunki `NOT x IS NULL` i `x IS NOT NULL` są tożsame.

### IN

Jeśli chcesz zwrócić wiersze, dla których kolumna przyjmuje jedną z określonych wartości możesz użyć `IN`. Zapytanie poniżej zwróci wszystkie wiersze z tabeli `invoice`, dla których `billingcountry` ma wartość `'USA'` i `billingstate` jedną z wartości `'CA'` lub `'TX'`:

```sql
SELECT *
  FROM invoice
 WHERE billingcountry = 'USA'
   AND billingstate IN ('CA', 'TX');
```

Użycie `IN` jest tożsame odpowiedniej liczbie warunków połączonych `OR`. 

## Czym jest wstrzykiwanie SQL (ang. _SQL Injection_)

Wstrzykiwanie SQL jest jednym z podstawowych ataków na aplikacje używające baz danych. Polega on na odpowiednim spreparowaniu danych wejściowych. W takim przypadku poza zapytaniem, które przygotuje programista wykonywane może być także to wprowadzone przez użytkownika.

Proszę spójrz na przykład w języku Java. W ten sposób na pewno będzie Ci łatwiej zrozumieć ten typ ataku.

Załóżmy, że w aplikacji próbujesz zaimplementować moduł logowania[^nierobtego]. Użytkownik w formularzu wprowadza swój e-mail i hasło.

[^nierobtego]: Do tej pory nie spotkałem się jeszcze z sytuacją, w której mechanizm logowania musiałbym pisać od podstaw samemu. Nie rób tego samodzielnie, użyj gotowego, sprawdzonego rozwiązania.

Aby upewnić się, że podane dane są prawidłowe pobierane są wiersze, które pasują do przekazanych danych logowania. Programista napisał szablon zapytania, który następnie uzupełniany jest danymi od użytkownika:

```java
String emailProvidedByUser = "...";
String passwordProvidedByUser = "...";
String queryTemplate = "SELECT password_hash FROM users WHERE email = '%s';"
String query = String.format(queryTemplate, emailProvidedByUser);

String paswordHashInDatabase = executeQuery(query);
boolean loginSuccessfull = magicHash(passwordProvidedByUser).equals(paswordHashInDatabase);
```

Jeśli użytkownik wprowadzi email `zenek@parapet.pl` i hasło `tajnehaslo` to logowanie przebiegnie pomyślnie :). Problem zacznie się jeśli użytkownik zacznie być złośliwy. Co stanie się jeśli użytkownik wprowadzi email `'; DELETE FROM users WHERE 1 = 1 OR email = '` i dowolne hasło?

Do bazy zostanie wysłane następujące zapytanie:

```sql
SELECT password_hash
  FROM users
 WHERE email = '';
 
DELETE FROM users
 WHERE 1 = 1
    OR email = '';
```

Właściwie są to dwa zapytania. Bardziej istotne jest drugie z nich. Po jego wykonaniu z tabeli `users` zostaną usunięte wszystkie wiersze. To raczej nie jest efekt, którego spodziewał się programista ;). 

### Zapobieganie _SQL Injection_

Ręczne budowanie zapytań SQL poprzez łączenie łańcuchów znaków przeważnie nie jest dobrym rozwiązaniem. Używaj do tego celu dedykowanych bibliotek. W Języku Java może to być na przykład Hibernate. W Pythonie SQLalchemy też świetnie daje sobie z tym radę. Jestem pewien, że w innych językach programowania istnieją podobne rozwiązania. Biblioteki te domyślnie odpowiednio traktują dane, które służą do wypełniania szablonów zapytań.

Jeśli chcesz budować zapytania "ręcznie". Pamiętaj o odpowiednim traktowaniu danych pochodzących od użytkownika. Takim danym nigdy nie można ufać. Musisz założyć, że każdy użytkownik jest złośliwy i będzie chciał zepsuć Twoją aplikację. W najprostszym scenariuszu użycie `''` w miejscu każdego znaku `'` w danych pochodzących od użytkownika powinno pomóc.

## Zadania do wykonania

Poniżej znajdziesz zestaw zadań, które pomogą Ci przećwiczyć materiał omówiony w tym artykule.

Napisz zapytanie, które:

- zwróci wszystkie wiersze z tabeli `track`, dla których: `unitprice` jest mniejsze niż `1` i znak `%` zawarty jest w kolumnie `name` oraz kolumna `name` kończy się na `e`,
- zwróci wszystkie wiersze z tabeli `invoice`, które mają uzupełnioną kolumnę `billingstate` i nie są ze Stanów Zjednoczonych,
- zwróci wszystkie wiersze z tabeli `invoice`, które dotyczą Polski, Czech albo Węgier dla których wartość faktury przekracza 10,
- zwróci imiona pracowników z tabeli `employee`, które dotyczą pracowników urodzonych w latach 60. 

### Przykładowe rozwiązania zadań

```sql
SELECT *
  FROM track
 WHERE unitprice < 1
   AND name LIKE '%x%%e' ESCAPE 'x';
```

```sql
SELECT *
  FROM invoice
 WHERE billingstate IS NOT NULL
   AND billingcountry != 'USA';
```

```sql
SELECT *
  FROM invoice
 WHERE billingcountry IN ('Poland', 'Czech Republic', 'Hungary')
   AND total > 10;
```

```sql
SELECT firstname 
  FROM employee
 WHERE birthdate BETWEEN '1960-' AND '1970-';
```

## Podsumowanie

Warunki masz już za sobą. Po rozwiązaniu zadań potrafisz sprawnie posługiwać się różnymi warunkami w języku SQL. Wiesz jak wygląda atak _SQL injection_ i jak można się przed nim bronić. Jeśli znasz kogoś komu ta wiedza może się przydać proszę przekaż odnośnik do tego artykułu. Dzięki temu pomożesz mi dotrzeć do nowych czytelników a na tym właśnie mi zależy. Z góry dziękuję :).

Jeśli nie chcesz pominąć kolejnych artykułów na blogu proszę polub Samouczka na Facebooku i dodaj swój adres e-mail do samouczkowego newslettera.

Trzymaj się i do następnego razu!
