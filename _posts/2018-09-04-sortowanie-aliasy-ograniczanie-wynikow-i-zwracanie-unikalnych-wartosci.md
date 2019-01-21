---
title: Sortowanie, aliasy, ograniczanie wyników i zwracanie unikalnych wartości
date: 2018-11-11 21:07:14 +0100
categories:
- Bazy danych
- Kurs SQL
permalink: /sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci/
header:
    teaser: /assets/images/2018/09/04_sortowanie_aliasy_distinct_sql.jpg
    overlay_image: /assets/images/2018/09/04_sortowanie_aliasy_distinct_sql.jpg
    caption: "[&copy; Micheile Henderson](https://unsplash.com/photos/1SjD5ZEiUsA)"
excerpt: Artykuł ten opisuje kilka wyrażeń używanych w SQL. Po lekturze będziesz wiedzieć jak używać i do czego służą `DISTINCT`, `AS` czy `UNION`. Poznasz także sposoby na sortowanie i ograniczanie wyników przy użyciu `ORDER BY` i `LIMIT`. Na końcu artykułu czekają na Ciebie zadania z przykładowymi rozwiązaniami, które pomogą Ci utrwalić zdobytą wiedzę.
---

{% include kurs-sql-notice.md %}

W poprzednich częściach kursu opisałem [klauzulę `WHERE`]({% post_url 2018-07-26-klauzula-where-w-zapytaniach-sql %}) wraz z [podstawami zapytania typu `SELECT`]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}). Ten artykuł opisuje kilka dodatkowych mechanizmów, które możesz wykorzystać przy pracy z zapytaniami tego typu.

## Kolejność wyrażeń

Zanim przejdę do wyjaśnienia poszczególnych wyrażeń chciałbym zwrócić Twoją uwagę na ich kolejność. Język SQL określa w jakiej kolejności powinny być one używane w zapytaniach. Kolejność ta zawsze wygląda następująco:

```sql
   SELECT ...
(    FROM ...)
(   WHERE ...)
(ORDER BY ...)
(   LIMIT ...)
```

Elementy otoczone nawiasami `()` są opcjonalne i mogą być pominięte.

## Ograniczanie liczby wyników

Często w trakcie pracy z danymi w [bazach relacyjnych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}) chcemy podejrzeć dane zwracane przez zapytanie. W takim przypadku ważnych jest tylko kilka wynikowych wierszy. W takim przypadku z pomocą przychodzi wyrażenie `LIMIT`, które pozwala na ograniczenie liczby zwracanych wierszy. Na przykład poniższe zapytanie zwróci jedynie pięć wierszy z tabeli `genre`:

```sql
SELECT * 
  FROM genre
 LIMIT 5;
```

To wyrażenie często jest używane do stronicowania. Wyobraź sobie sytuację, w której sklep na stronie wyświetla dziesięć produktów. Odpowiednio skonstruowane zapytanie z wyrażeniem `LIMIT 10` zwróci dokładne te produkty, które powinny być wyświetlone.

Do poprawnego stronicowania używa się także wyrażenia `OFFSET`, które pozwala na przeskoczenie odpowiedniej liczby wyników. Na przykład wyrażenie poniżej wyświetli pięć wierszy pomijając pierwsze dziesięć. Pamiętaj, że w "produkcyjnych" zapytaniach tego typu powinno używać się sortowania, które opiszę niżej:

```sql
SELECT *
  FROM genre
 LIMIT 5 OFFSET 10;
```

## Wyłącznie unikalne wiersze

W niektórych przypadkach zapytanie SQL powinno zwrócić wyłącznie unikalne wartości. Tabela `invoice` zawiera między innymi kolumnę `billingcountry`. W tej kolumnie zawarty jest kraj, w którym wystawiono fakturę. Załóżmy, że Twoim zadaniem jest pobranie listy krajów, w których dokonano jakiegokolwiek zakupu. Tę listę zwróci takie zapytanie:

```sql
SELECT billingcountry
  FROM invoice
```

To zapytanie ma jednak pewną wadę. Zwróć uwagę na to, że zwraca ono wartość kolumny `billingcountry` dla każdego wiersza znajdującego się w tabeli źródłowej. W tym przypadku tabela źródłowa zawiera wiele faktur dla tego samego kraju. Wystarczy spojrzeć na wynik zapytania. Poniżej możesz zobaczyć pierwsze dziesięć wierszy:

    Germany
    Norway
    Belgium
    Canada
    USA
    Germany
    Germany
    France
    France
    Ireland

Jak widzisz lista zawiera duplikaty. `Germany` i `France` są powielone. Cała lista krajów zawiera jeszcze więcej duplikatów, możesz to sprawdzić uruchamiając zapytanie samodzielnie.

W przypadku tego typu zapytań z pomocą przychodzi wyrażenie `DISTINCT`. Pozwala ono na odfiltrowanie powielonych wierszy. Proszę spójrz na przykład:

```sql
SELECT DISTINCT billingcountry
  FROM invoice;
```

Tym razem pierwsze dziesięć wierszy wygląda inaczej. Zwróć uwagę, że tym razem dzięki `DISTINCT` żaden wiersz nie jest powielony:

    Germany
    Norway
    Belgium
    Canada
    USA
    France
    Ireland
    United Kingdom
    Australia
    Chile

### Wiele kolumn z wyrażeniem `DISTINCT`

Klauzulę `DISTINCT` możesz stosować także w przypadku wielu kolumn. Załóżmy, że chcesz uzyskać listę wszystkich krajów i miejscowości, w których dokonano zakupu. Aby uzyskać taki wynik wystarczy nieznacznie zmodyfikować poprzednie zapytanie:

```sql
SELECT DISTINCT billingcountry
      ,billingcity
  FROM invoice;
```

Pierwsze dziesięć wierszy zwrócone przez to zapytanie wygląda tak (znak `|` służy do oddzielenia kolumn):

    Germany|Stuttgart
    Norway|Oslo
    Belgium|Brussels
    Canada|Edmonton
    USA|Boston
    Germany|Frankfurt
    Germany|Berlin
    France|Paris
    France|Bordeaux
    Ireland|Dublin

Zwróć uwagę na to, że kraje się powtarzają. Tym razem to para `billingcountry` i `billingcity` jest unikalna.

### `NULL` a `DISTINCT`

Aby określić czy wartości są unikalne trzeba je ze sobą porównać. Dzięki takiemu porównaniu zwracany wynik nie zawiera duplikatów. Porównywane są wszystkie wartości, `NULL` nie jest tu wyjątkiem. Proszę rzuć okiem na wynik tego zapytania, zwraca ono unikalne wartości dla pary `billingcountry` i `billingstate`:

```sql
SELECT DISTINCT billingcountry
      ,billingstate
  FROM invoice;
```
Pierwsze dziesięć wierszy zwrócone przez to zapytanie wygląda następująco:

    Germany|
    Norway|
    Belgium|
    Canada|AB
    USA|MA
    France|
    Ireland|Dublin
    United Kingdom|
    USA|CA
    USA|WA

Istnieją faktury wystawione w Niemczech, które nie mają uzupełnionej kolumny `billingstate`. Widać to w pierwszym wierszu wyników. Oznacza to tyle, że `DISTINCT` wartości `NULL` traktuje jako równe sobie.

## Sortowanie wyników

Język SQL bardzo często używany jest do generowania różnego rodzaju raportów. Raporty te lepiej przegląda się jeśli są odpowiednio uporządkowane. W języku SQL do sortowania wyników używa się wyrażenia `ORDER BY`. Proszę spójrz na przykład poniżej:

```sql
  SELECT name
    FROM genre
ORDER BY name;
```

To zapytanie pobiera wszystkie wartości kolumny `name` z tabeli `genre`. Zwrócony wynik posortowany jest rosnąco według kolumny `name`. Pierwsze pięć wierszy zwróconych przez to zapytanie wygląda tak:

    Alternative
    Alternative & Punk
    Blues
    Bossa Nova
    Classical

### Zmiana kierunku sortowania

Domyślnie `ORDER BY` sortuje wyniki w porządku rosnącym. Możesz jednak to zmienić używając wyrażenia `DESC` po nazwie kolumny, która powinna być sortowana. Lekka modyfikacja poprzedniego zapytania zwraca gatunki muzyczne w kolejności malejącej:

```sql
  SELECT name
    FROM genre
ORDER BY name DESC;
```

Tym razem pierwsze pięć wierszy wygląda zupełnie inaczej:

    World
    TV Shows
    Soundtrack
    Science Fiction
    Sci Fi & Fantasy

Istnieje wyrażenie `ASC`, które mówi o tym, żeby wynik był sortowany rosnąco. Często jest ono pomijane ponieważ, takie właśnie jest domyślne zachowanie `ORDER BY`. Przykładowe zapytanie bez pominięcia `ASC` może wyglądać tak:

```sql
  SELECT name
    FROM genre
ORDER BY name ASC;
```

{% include newsletter-srodek.md %}

### Sortowanie po wielu kolumnach

Klauzula `ORDER BY` pozwala na sortowanie po wielu kolumnach jednocześnie. Na początku wynik sortowany jest po pierwszym wyrażeniu. Jeśli występują w nim duplikaty są one sortowane po drugim wyrażeniu, i tak dalej... Proszę spójrz na przykład:

```sql
  SELECT DISTINCT billingcountry
        ,billingstate
    FROM invoice
ORDER BY billingcountry DESC
        ,billingstate;
```

To zapytanie zwraca unikalne wartości `billingcountry` i `billingstate`. Wynik posortowany jest malejąco po `billingcountry` i rosnąco po `billingstate`. Pierwsze pięć wierszy wyniku zapytania wygląda następująco:

    United Kingdom|
    USA|AZ
    USA|CA
    USA|FL
    USA|IL

Możesz także sortować po kolumnie, która nie jest uwzględniona w finalnym wyniku. Na przykład zapytanie poniżej zwraca wyłącznie unikalne wartości kolumny `billingcountry` sortując je po kolumnie `billingcity`:

```sql
  SELECT DISTINCT billingcountry
    FROM invoice
ORDER BY billingcity;
```

Wynik tego zapytania może wydawać się losowy, jednak podejrzenie miast skojarzonych z wyświetlonymi państwami pozwoli rozwiązać zagadkę sortowania:

    Netherlands
    India
    USA
    Belgium
    Hungary
    Argentina

## Aliasy dla kolumn

{% capture sqlite %}
W jednym z poprzednich artykułów opisałem [przygotowanie środowiska]({% post_url 2018-06-25-pobieranie-danych-z-bazy-select %}#przygotowanie-%C5%9Brodowiska). Zakładam, że w trakcie kursu używasz SQLite.

W przypadku tej bazy danych, klient domyślnie nie wyświetla nazw zwracanych kolumn. Możesz je włączyć używając polecenia `.headers on`. Polecam także zmianę sposobu prezentacji wyników przy użyciu `.mode column`. Dzięki temu zwracane dane będą bardziej czytelne.

W tej sekcji kursu będę pokazywał wyniki w postaci kolumn z nagłówkiem zawierającym ich nazwy.
{% endcapture %}

<div class="notice--info">
  {{ sqlite | markdownify }}
</div>

Spójrz na pierwsze pięć wierszy w tabeli `genre`:

    sqlite> SELECT * FROM genre LIMIT 5;
    GenreId     Name      
    ----------  ----------
    1           Rock      
    2           Jazz      
    3           Metal     
    4           Alternativ
    5           Rock And R

W tym przypadku pierwszy wiersz wyników pokazuje nazwy zwracanych kolumn. Nazwy pod którymi zwracane są wyniki można zmienić używając wyrażenia `AS`. Spójrz na przykład:

```sql
SELECT genreid AS id
      ,name AS 'genre name'
  FROM genre
 LIMIT 5;
```

Tym razem wyniki poprzedzone są innymi nazwami kolumn, mimo tego, że pochodzą z tego samego źródła.

    id          genre name
    ----------  ----------
    1           Rock      
    2           Jazz      
    3           Metal     
    4           Alternativ
    5           Rock And R

Wyrażenie `AS` najczęściej używane jest przy bardziej skomplikowanych zapytaniach. Na przykład jeśli do otrzymania pewnego wyniku potrzeba złączyć tabelę z samą sobą.  O zapytaniach tego typu przeczytasz w dalszej części kursu.

## Scalanie wyników wielu zapytań

Do scalania[^zlaczenie] wyników wielu zapytań służy wyrażenie `UNION ALL` albo `UNION`. Tym razem zacznę od przykładu:

[^zlaczenie]: Celowo unikam tu słowa złączenie, które bardziej kojarzy mi się z wyrażeniem typu `JOIN`, które opiszę w jednym z kolejnych artykułów.

```sql
   SELECT name AS xxx
     FROM genre
UNION ALL
   SELECT DISTINCT billingcity
     FROM invoice
 ORDER BY xxx
    LIMIT 10;
```

To zapytanie zwraca w jednej kolumnie o nazwie `xxx` wszystkie wartości kolumny `name` z tabeli `genre` połączone z unikalnymi wartościami kolumny `billingcity` z tabeli `invoice`. Połączone wyniki tych dwóch zapytań posortowane są po kolumnie `xxx`. Zapytanie zwraca tylko dziesięć pierwszych wartości:

    Alternative
    Alternative & Punk
    Amsterdam
    Bangalore
    Berlin
    Blues
    Bordeaux
    Bossa Nova
    Boston
    Brasília

Podzapytania, które są scalane przy użyciu wyrażeń `UNION` albo `UNION ALL` muszą zwracać tę samą liczbę kolumn o tym samym typie[^typ].

[^typ]: Nie jest to do końca prawda. W przypadku relacyjnych baz danych, które znam SQLite jest najbardziej pobłażliwy. SQLite pozwala na łączenie ze sobą różnych typów przy użyciu `UNION` czy `UNION ALL`. Na przykład w bazie danych PostgreSQL użycie `UNION` do złączenia zapytań zwracających różne typy danych kończy się wyjątkiem.

Wyrażenia `LIMIT` i `ORDER BY` mogą być użyte tylko do scalonych zapytań. Nie możesz ich użyć wewnątrz zapytań, które są scalane.
{:.notice--info}

### Różnica pomiędzy `UNION` a `UNION ALL`

Oba wyrażenia służą do scalenia wyników wielu zapytań. Mają jednak jedną znaczącą różnicę. `UNION` zwróci unikalną listę wierszy. `UNION ALL` zwróci wszystkie wiersze, w wyniku mogą być duplikaty.

### Wiele podzapytań

W przykładzie powyżej użyłem `UNION ALL` do scalania wyników dwóch zapytań. Jednak nie jest to koniec możliwości tego wyrażenia. Pozwala ono na scalanie wyników wielu zapytań. Na przykład zapytanie poniżej jest także poprawne:

```sql
   SELECT genreid
         ,name AS xxx
     FROM genre
UNION ALL
   SELECT invoiceid
         ,billingcity
     FROM invoice
    UNION
   SELECT albumid
         ,title
     FROM album
 ORDER BY xxx
    LIMIT 10;
```

Zwraca ono dwie kolumny, których zawartość pochodzi z trzech różnych tabel.

### Czy `UNION` jest potrzebne?

Niektóre wyrażenia `UNION` mogą być zastąpione przy pomocy `OR`. Zatem kiedy stosować `UNION` albo `UNION ALL`? Te klauzule możesz stosować jeśli w wynikowej kolumnie powinny znaleźć się dane z różnych źródeł. Są też inne przypadki, związane z optymalizacją wydajności zapytań. Pominę te drugie bo znacząco wykraczają poza zakres tego kursu i są specyficzne dla różnych silników baz danych.

## Zadania do wykonania

Poniżej znajdziesz kilka zadań do wykonania. Każde z nich wymaga napisania jednego zapytania. Napisz zapytanie, które:

- zwróci dziesięć najdłuższych ścieżek (tabela `track`), weź pod uwagę tylko te, których kompozytor (kolumna `composer`) zawiera literę `b`,
- zwróci pięć najtańszych ścieżek (tabela `track`) dłuższych niż minuta,
- zwróci unikalną listę dwudziestu kompozytorów których ścieżki kosztują mniej niż 2$ posortowanych malejąco według identyfikatora gatunku (kolumna `genreid`) i rosnąco według rozmiaru (kolumna `bytes`),
- zwróci dwie kolumny. Pierwsza z nich powinna zawierać ścieżki (kolumna `name`) droższe niż 1$ i poprawnych kompozytorów (kolumna `composer` nie ma wartości `NULL`) pod nazwą `magic thingy`. Druga powinna zawierać liczbę bajtów. Wynik powinien zawierać dziesięć wierszy i być posortowany rosnąco po liczbie bajtów[^zle],
- zwróci piątą stronę z fakturami (tabela `invoice`) zakładając, że na stronie znajduje się dziesięć faktur i sortowane są według identyfikatora (kolumna `invoiceid`).

[^zle]: W codziennym programowaniu raczej nie zdarza się sytuacja, w której w jednej wynikowej kolumnie łączy się zupełnie różne dane.

### Przykładowe rozwiązania zadań

```sql
  SELECT name
    FROM track
   WHERE composer like '%b%'
ORDER BY milliseconds DESC
   LIMIT 10;
```

```sql
  SELECT name
        ,unitprice
    FROM track
   WHERE milliseconds > 60000
ORDER BY unitprice 
   LIMIT 5;
```

```sql
  SELECT DISTINCT composer 
    FROM track
   WHERE unitprice < 2
ORDER BY genreid DESC
        ,bytes
   LIMIT 10;
```

```sql
  SELECT name AS 'magic thingy'
        ,bytes
    FROM track
   WHERE unitprice > 1
   UNION
  SELECT composer
        ,bytes
    FROM track
   WHERE composer IS NOT NULL
ORDER BY bytes ASC
   LIMIT 10;
```

```sql
  SELECT *
    FROM invoice
ORDER BY invoiceid
   LIMIT 10 OFFSET 40;
```

## Podsumowanie

Kolejną część kursu SQL masz już za sobą. W tym artykule udało Ci się przeczytać o kilku przydatnych konstrukcjach. Wiesz jak sortować wyniki, jak ograniczać liczbę zwracanych wierszy, potrafisz łączyć ze sobą wyniki kilku zapytań i wiesz jak zwracać wyłącznie unikalne wartości. Po rozwiązaniu zadań  wiesz, że potrafisz wykorzystać tę wiedzę w praktyce. Gratulacje! :)

Które z zadań sprawiło Ci największą trudność? Może masz jakiekolwiek pytania dotyczące materiału, który opisałem w tym artykule? Daj znać w komentarzach pod artykułem.

Na koniec mam do Ciebie prośbę. Jeśli znasz kogoś dla kogo treść tego artykułu będzie przydatna proszę podziel się nim z tą osobą. Pomożesz mi w ten sposób dotrzeć do nowych czytelników. Jeśli nie chcesz ominąć kolejnych artykułów na blogu proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebook'u. Do następnego razu!
