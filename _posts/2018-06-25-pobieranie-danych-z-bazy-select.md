---
title: Pobieranie danych z bazy - SELECT
categories:
- Bazy danych
- Kurs SQL
permalink: /pobieranie-danych-z-bazy-select/
header:
    teaser: /assets/images/2018/06/28_pobieranie_danych_z_bazy_select_artykul.jpeg
    overlay_image: /assets/images/2018/06/28_pobieranie_danych_z_bazy_select_artykul.jpeg
    caption: "[&copy; whale](https://unsplash.com/photos/OiiThC8Wf68)"
excerpt: Jest to pierwszy artykuł w praktycznym kursie SQL dla początkujących. Po przeczytaniu tego artykułu będziesz wiedzieć czym jest język SQL. Dowiesz się jak wygląda podstawowe zapytanie `SELECT`. Artykuł opisuje także przygotowanie środowiska pozwalającego przećwiczyć zdobytą wiedzę. Na końcu artykułu czeka na Ciebie zestaw zadań do samodzielnego wykonania.
---

{% include kurs-sql-notice.md %}

# Wprowadzenie do języka SQL

Język SQL (ang. _Structured Query Language_) powstał kilkadziesiąt lat temu. Służy do pobierania i przetwarzania danych zapisanych w bazie danych. Język ten został ustandaryzowany i na przestrzeni kilkudziesięciu lat powstało wiele wersji tego standardu.

{% capture standardy %}
Niestety treść standardów nie jest dostępna bezpłatnie. Jeśli będziesz chcieć uzupełnić swoją wiedzę, to dokumentacja bazy danych, której używasz jest bardzo dobrym źródłem. Popularne bazy danych dokładnie opisują swoją implementację standardu SQL:

- [SQL implementowany przez SQLite](https://www.sqlite.org/lang.html),
- [SQL implementowany przez PostgreSQL](https://www.postgresql.org/docs/10/static/sql.html),
- [SQL implementowany przez MySQL](https://dev.mysql.com/doc/refman/8.0/en/sql-syntax.html),
- [SQL implementowany przez Oracle](https://docs.oracle.com/database/121/SQLRF/toc.htm).
{% endcapture %}

<div class="notice--info">
  {{ standardy | markdownify }}
</div>

Język SQL jest językiem deklaratywnym. Oznacza to tyle, że instrukcje tego języka opisują co chcemy osiągnąć, a nie jak to zrobić. Dla porównania można powiedzieć, że język Java nie jest językiem deklaratywnym. Programując w [języku Java]({{ '/kurs-programowania-java' | absolute_url }}) mówisz o tym jak chcesz coś zrobić.

Język SQL oparty jest na zapytaniach. Przykładowe zapytanie SQL może wyglądać tak:

```sql
SELECT *
  FROM genre
 WHERE name = 'Rock'
   AND genreid < 20;
```

## SQL to nie baza danych

Definicji bazy danych może być wiele. Jednak nie znam żadnej, która mówiłaby, że baza danych to SQL.

SQL to język, który pomaga dogadać się z bazą danych. Baza danych to dane, to ich zbiór. W relacyjnych bazach danych są one zorganizowane w tabele. W jednej bazie danych przeważnie znajduje się wiele tabel.

Tabele zawierają wiersze i kolumny. Na przykład tabela `genre` zawiera nazwy gatunków muzycznych:

    | genreid | name   |
    |---------|--------|
    | 1       | 'Rock' |
    | 2       | 'Jazz' |

Tabela, którą pokazałem wyżej zawiera dwa wiersze i dwie kolumny: `genreid` i `name`. Można powiedzieć, że baza danych to zbiór tabel zawierających dane. Język SQL pomaga w łatwym operowaniu na danych. SQL ukrywa w sobie sposób w jaki dane są przetwarzane, zwraca wyłącznie finalny wynik.

Bazy danych także ukrywają sposób przechowywania danych. Użytkownika nie interesuje sposób ich zapisu a jedynie to, co chce uzyskać przy pomocy zapytania SQL[^wydajnosc].

[^wydajnosc]: Na pewnym etapie zaawansowania znajomość wewnętrznych mechanizmów działania bazy danych jest bardzo ważna. Pozwala ona na tworzenie zapytań, które są bardziej wydajne.

## Podział SQL

Zapytania w SQL możemy podzielić na kilka rozłącznych grup. Każda z tych grup zawiera różne rodzaje zapytań. Grupy zostały wydzielone na podstawie zadań realizowanych przez poszczególne zapytania. Możemy wyszczególnić następujące grupy:

- DQL (ang. _Data Query Language_)
- DML (ang. _Data Manipulation Language_)
- DDL (ang. _Data Definition Language_)

Dodatkowo czasami wyróżnia się też grupy:

- DCL (ang. _Data Control Language_)
- TCL (ang. _Transaction Control Language_)

### DQL

DQL składa się wyłącznie z zapytań typu `SELECT`. Zapytania te służą do odpytywania (ang. _query_) bazy danych. Innymi słowy służą do pobierania danych z bazy danych. Zapytania typu `SELECT` są najczęściej używane. Poniżej możesz zobaczyć zapytanie, które pobiera wszystkie kolumny i wiersze z tabeli `genre`.

```sql
SELECT *
  FROM genre;
```

Na razie nie przejmuj się składnią zapytania, omówię ją szczegółowo poniżej.

### DML

DML służy do tworzenie, modyfikowania i usuwania danych. W skład tej grupy wchodzą zapytania:

- `INSERT` - dodaje wiersze do tabeli,
- `UPDATE` - aktualizuje wiersze w tabeli,
- `DELETE` - usuwa wiersze z tabeli.

### DDL

Wiesz już, że [relacyjne bazy danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}) składają się z tabel. Dodatkowo w bazach występują inne obiekty jak indeksy (ang. _index_), klucze obce (ang. _foreign key_), klucze główne (ang. _primary key_), ograniczenia (ang. _constraint_), wyzwalacze (ang. _trigger_) czy widoki (ang. _view_). Część języka odpowiedzialna za zarządzanie tymi obiektami to DDL. Zapytania należące do DDL to:

- `CREATE` - tworzą obiekty bazy danych,
- `ALTER` - modyfikują tabele bazy danych,
- `DROP` - usuwają obiekty bazy danych,
- `TRUNCATE` - usuwa wszystkie dane z tabeli[^niedml].

[^niedml]: Chociaż `TRUNCATE` jest podobne do zapytania typu `DELETE` jest klasyfikowane jako DDL. Wynika to z faktu, że zapytania `TRUNCATE` nie mogą być cofnięte. Zapytania typu `DELETE` mogą być cofnięte w ramach trwającej transakcji.

### DCL

Bazy danych często pozwalają na zarządzanie dostępem do danych. Realizowane jest to przy pomocy kont użytkowników[^hba]. DCL służy do manipulacji prawami dostępu do danych przypisanych do poszczególnych kont:

[^hba]: Pomijam tu ustawienia na poziomie konfiguracji silnika bazy danych. Te ustawienia mogą wymagać restartu silnika. Przykładem może tu być plik konfiguracyjny [`pg_hba.conf`](https://www.postgresql.org/docs/10/static/auth-pg-hba-conf.html) istniejący w bazie danych PostgreSQL.

- `GRANT` - nadaje uprawnienia,
- `REVOKE` - usuwa uprawnienia.

### TCL

Na początku przygody z SQL nie musisz przejmować się transakcjami. Opiszę je dokładniej w kolejnych artykułach w ramach kursu. Teraz w zupełności wystarczy wiedza o tym, że istnieje coś takiego jak transakcja. Do zarządzania transakcjami służą zapytania:

- `BEGIN` - rozpoczyna transakcję,
- `COMMIT` - zatwierdza transakcję,
- `ROLLBACK` - wycofuje transakcję,
- `SAVEPOINT` - zapisuje "punkt przywracania" aktualnej transakcji.

## SQL a wielkość liter

SQL jest językiem, w którym wielkość liter w słowach kluczowych i identyfikatorach nie ma znaczenia. Wyjątkiem są tu identyfikatory, które są otoczone znakiem cudzysłowu `"`[^zalezy]. Na przykład oba poniższe zapytania są równoważne:

[^zalezy]: To zachowanie zależy od silnika bazy danych. Niektóre silnik respektują identyfikatory otoczone `"`, inne nie.

```sql
SELECT * FROM genre WHERE genreid = 1;
```

```sql
SELECT * frOM geNRe wherE GenReID = 1;
```

Chociaż wielkość liter nie ma znaczenia, moim zdaniem dobrą praktyką jest pisanie słów kluczowych wielkimi literami. W codziennej pracy także starałem się unikać nadawania nazw, które wymagają otoczenia `"`. Dodatkowo zawsze staram się formatować zapytania żeby były bardziej czytelne:

```sql
SELECT *
  FROM genre
 WHERE genreid = 1;
```

{% include newsletter-srodek.md %}

# Przygotowanie środowiska

Moim zdaniem najlepszym sposobem na naukę jest praktyka. Właśnie z tego powodu chcę pomóc przygotować Ci środowisko, w którym możliwe będzie testowanie zapytań.

Aby móc ćwiczyć na bieżąco wszystkie zagadnienia, które będę opisywał będziesz potrzebować serwera bazy danych. Jak wspomniałem w artykule opisującym [relacyjne bazy danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}) jest wiele silników baz danych.

Ze względu na łatwą instalację (właściwie to jej brak), w kursie używał będę bazy danych [SQLite](https://www.sqlite.org/). Baza ta jest w zupełności wystarczająca na potrzeby kursu. Oczywiście, jeśli chcesz wykonywać ćwiczenia używając bardziej zaawansowanych baz danych możesz to zrobić ;).

## Instalacja bazy danych

Zacznij od [pobrania narzędzi SQLite](https://www.sqlite.org/download.html). W zależności od systemu operacyjnego, na którym pracujesz pobierz odpowiednią wersję:

- Windows - _Precompiled Binaries for Windows_,
- Linux - _Precompiled Binaries for Linux_,
- Mac OS X - _Precompiled Binaries for Mac OS X (x86)_.

Plik do pobrania to archiwum zip rozpoczynające się od _sqlite-tools-_. Wewnątrz tego archiwum znajduje się program `sqlite.exe` (lub `sqlite`, w zależności od Twojego systemu operacyjnego). Program ten pozwala na pracę z bazą danych SQLite.

Jak widzisz w tym przypadku właściwie nie ma potrzeby instalacji żadnego programu, wystarczy rozpakować archiwum zip. W przypadku baz danych używanych w środowiskach produkcyjnych proces ten jest dużo bardziej skomplikowany.

## Import gotowej bazy danych

W internecie istnieje wiele zbiorów danych. Jednym z nich jest ten udostępniony przez projekt [Chinook](https://github.com/SamouczekProgramisty/chinook-database). Jest to testowa baza danych reprezentująca sklep z muzyką. Sama baza nie jest duża, jednak w zupełności wystarczy na omówienie podstawowych możliwości SQL.

Pobierz [przykładową bazę danych](https://github.com/SamouczekProgramisty/chinook-database/blob/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite?raw=true)
i zachowaj ją w pliku `Chinook_Sqlite.sqlite`, następnie uruchom program `sqlite3`. Po uruchomieniu wpisz komendę, która otworzy pobraną bazę danych:

    .open <ścieżka do pobranego pliku>

Żeby sprawdzić, czy wszystko działa poprawnie możesz wpisać komendę `.tables`, powinna ona wypisać wszystkie tabele znajdujące się bazie danych.

{% include figure image_path="/assets/images/2018/06/28_sqlite_open_database.gif"  caption="Otworzenie bazy danych w sqlite" %}

Komendy zaczynające się od `.` (na przykład `.open` czy `.tables`) to wewnętrzne polecenia SQLite. Jest ich dużo więcej. Jeśli chcesz je zobaczyć użyj polecenia `.help`.
{:.notice--info}

# Zapytania `SELECT`

Założeniem tego kursu jest to, że będzie on praktyczny od samego początku do końca. Wszystkie zapytania, które tutaj pokazuję możesz wykonać samodzielnie używając środowiska, które wcześniej opisałem.
{:.notice--info}

## Schemat tabeli

Zanim przejdę do tłumaczenia zapytań `SELECT` chciałbym zwrócić Twoją uwagę na budowę tabeli. Wiesz już, że tabela składa się z wierszy i kolumn. Każda kolumna przechowuje dane pewnego typu. Mogą to być na przykład łańcuchy znaków czy liczby.

Można powiedzieć, że tabela ma swój schemat. SQLite ma wewnętrzne polecenie, które pozwala pokazać schemat tabeli - `.schema`. Na przykład schemat tabeli `Invoice` wygląda tak:

    sqlite> .schema Invoice
    CREATE TABLE [Invoice]
    (
        [InvoiceId] INTEGER  NOT NULL,
        [CustomerId] INTEGER  NOT NULL,
        [InvoiceDate] DATETIME  NOT NULL,
        [BillingAddress] NVARCHAR(70),
        [BillingCity] NVARCHAR(40),
        [BillingState] NVARCHAR(40),
        [BillingCountry] NVARCHAR(40),
        [BillingPostalCode] NVARCHAR(10),
        [Total] NUMERIC(10,2)  NOT NULL,
        CONSTRAINT [PK_Invoice] PRIMARY KEY  ([InvoiceId]),
        FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId])
                    ON DELETE NO ACTION ON UPDATE NO ACTION
    );
    CREATE UNIQUE INDEX [IPK_Invoice] ON [Invoice]([InvoiceId]);
    CREATE INDEX [IFK_InvoiceCustomerId] ON [Invoice] ([CustomerId]);

To co widzisz, to zapytania typu DDL, które tworzą tabelę i obiekty z nią powiązane. Powyższe zapytana poza tabelą tworzą indeksy, klucze obce i klucz główny.

Istnieją także bazy danych, które pozwalają przechowywać dane w strukturze, która nie ma sztywno określonego schematu. Podobnie jak [relacyjne bazy danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}) mają one swoje wady i zalety.
{:.notice--info}

### Typy danych

Typy obsługiwanych danych mogą znacznie różnić się pomiędzy różnymi silnikami baz danych. Różnice te jednak nie przeszkadzają w nauce języka SQL.
{:.notice--info}

Tabela `Invoice` składa się z dziewięciu kolumn. Kolumna `InvoiceId` jest kluczem głównym tabeli. Każda z kolumn ma przypisany typ. Typ określa rodzaj danych przechowywanych w danej kolumnie[^typy_sqlite]. Na przykład kolumna `InvoiceDate` jest typu `DATETIME`, kolumny tego typu służą do przechowywania daty i czasu.

[^typy_sqlite]: To stwierdzenie nie jest do końca prawdziwe dla SQLite, jednak ma zastosowanie w innych silnikach baz danych. W przypadku SQLite typ danych określany jest na podstawie zawartości a nie typu kolumny. To zachowanie jest raczej wyjątkiem w świecie relacyjnych baz danych. Po szczegóły odsyłam Cię do [dokumentacji SQLite](https://www.sqlite.org/datatype3.html#datatypes_in_sqlite).

Innymi typami, które występują w tej tabeli są:

- `INTEGER` - służy on do przechowywania liczb całkowitych,
- `NVARCHAR(x)` - służy on do przechowywania łańcuchów znaków do długości `x`,
- `NUMERIC(x, y)` - służy do przechowywania liczb rzeczywistych, które mają do `x` cyfr z `y` po przecinku.

Innymi popularnymi typami są[^storage_type]:

- `BLOB` - służy do przechowywania danych binarnych (ang. _binary large object_),
- `DATETIME` - służy do przechowywania daty i czasu,
- `DATE` - służy do przechowywania daty,
- `BOOLEAN` - służy do przechowywania wartości logicznych,
- `TEXT` - służy do przechowywania łańcuchów znaków gdzie ciężko jest oszacować maksymalną długość tekstu, lub wahania długości tekstu są duże.

[^storage_type]: W przypadku SQLite wszystkie typy danych są przekształcane na "typy pierwotne": `NULL`, `INTEGER`, `REAL`, `TEXT`, `BLOB`. Dane na dysku zawsze zapisane są jako jeden z typów pierwotnych.

## Składnia zapytania `SELECT`

Zapytanie `SELECT` w swojej najprostszej formie wygląda tak:

```sql
SELECT *
  FROM invoice;
```

To Zapytanie zawiera dwa słowa kluczowe: `SELECT` i `FROM`. Pomiędzy tymi słowami znajduje się lista kolumn, które powinny zostać zwrócone. Znak `*` w tym kontekście oznacza "pobierz wszystkie". Po słowie kluczowym `FROM` występuje nazwa tabeli - `invoice`. Całe zapytanie jest zakończone średnikiem. Spróbuj wykonać to zapytanie na swojej kopii bazy danych:

    sqlite> SELECT * FROM invoice;
    1|2|2009-01-01 00:00:00|Theodor-Heuss-Straße 34|Stuttgart||Germany|70174|1.98
    2|4|2009-01-02 00:00:00|Ullevålsveien 14|Oslo||Norway|0171|3.96
    (...)

### Filtrowanie przy pomocy `WHERE`

Pobieranie całej tabeli nie zawsze jest przydatne. Bardzo często zapytania `SELECT` filtrują pobierane dane. Aby filtrować dane zwracane przez zapytanie musisz użyć słowa kluczowego `WHERE` i warunków, które filtrują dane:

```sql
SELECT *
  FROM invoice
 WHERE billingcity = 'Dublin' AND total > 5
    OR billingcity = 'Boston' AND total < 3 AND total > 1;
```

Zapytanie wyżej ma kilka warunków. Każdy z nich oddzielony jest słowem kluczowym `OR` (logiczne lub) i `AND` (logiczne i). W tym przypadku zostaną zwrócone wszystkie wiersze dla których spełniony jest jeden z warunków:

- kolumna `billingcity` ma wartość Dublin i kolumna `total` zawiera liczbę większą od 5,
- kolumna `billingcity` ma wartość Boston i kolumna `total` zawiera liczbę z przedziału (1, 3).

Słowo kluczowe `AND` ma wyższy priorytet niż `OR`, dla pewności możesz użyć nawiasów. Poniższe zapytanie da dokładnie ten sam wynik co poprzednie:

```sql
SELECT *
  FROM invoice
 WHERE (billingcity = 'Dublin' AND total > 5)
    OR (billingcity = 'Boston' AND total < 3 AND total > 1);
```

Spróbuj wywołać to zapytanie na swojej kopii bazy danych:

    sqlite> SELECT * FROM invoice WHERE billingcity = 'Dublin' AND total > 5 OR billingcity = 'Boston' AND total < 3 AND total > 1;
    10|46|2009-02-03 00:00:00|3 Chatham Street|Dublin|Dublin|Ireland||5.94
    189|23|2011-04-18 00:00:00|69 Salem Street|Boston|MA|USA|2113|1.98
    (...)

#### Magiczna wartość `NULL`

Każdy wiersz w tabeli może mieć wartość, która pasuje do typu przechowywanego przez daną kolumnę. W SQL jest jeszcze specjalna wartość. Jest nią `NULL`. Możesz ją porównać do pustej wartości w językach programowania. W Javie i JavaScript byłby to `null`, w Pythonie `None`, w Ruby i Go `nil` itd.

Istotne jest rozróżnienie pomiędzy pustą wartością a `NULL`. Na przykład pusty łańcuch znaków to zupełnie coś innego niż `NULL`.

Wartość ta jest traktowana w specyficzny sposób w przypadku porównań. Do sprawdzania czy kolumna w wierszu ma wartość `NULL` służy wyrażenie `IS NULL`. Aby sprawdzić, czy dana kolumna nie ma wartości `NULL` używa się wyrażenia `IS NOT NULL`.

Na przykład poniższe zapytanie zwróci jedynie te wiersze dla których kolumna `billingcountry` ma wartość inną niż USA i `billingstate` nie ma wartości `NULL`:

```sql
SELECT *
  FROM invoice
 WHERE billingstate IS NOT NULL
   AND billingcountry != 'USA';
```

### Wybór kolumn

Użycie klauzuli `WHERE` pozwala na odfiltrowanie części wierszy. W przypadku kolumn mechanizm jest podobny. Jeśli chcesz wybrać podzbiór kolumn, a nie wszystkie, to musisz wskazać te, które Cię interesują:

```sql
SELECT invoicedate
      ,billingcity
      ,total
  FROM invoice
 WHERE billingcountry = 'Poland';
```
Powyższe zapytanie zwróci wyłącznie te faktury, które zostały wystawione w Polsce. Wynik będzie zawierał tylko trzy wskazane kolumny. Zwróć uwagę, że klauzula `WHERE` używa kolumn, które nie są zwracane w wyniku wykonania zapytania.

### To dopiero początek

Rysunek poniżej pokazuje składnię zapytania `SELECT` w SQLite. W artykule tym omówiłem wyłącznie podstawowe elementy.

{% include figure image_path="/assets/images/2018/06/28_select-stmt.gif"  caption="Składania zapytania `SELECT`" %}

W kolejnych artykułach omówię między innymi pozostałe elementy składni zapytania `SELECT`.

# Zadania do wykonania

Na koniec mam dla Ciebie kilka zadań, w których przećwiczysz materiał z tego artykułu. Postaraj się rozwiązać zapytania samodzielnie, wtedy nauczysz się najwięcej:

- Napisz zapytanie, które zwróci wszystkie gatunki muzyczne z tabeli `genre`, 
- Napisz zapytanie, które zwróci wszystkie stany w USA, w których wystawiono fakturę na kwotę większą niż 15,
- Napisz zapytanie, które zwróci wszystkie kraje, w których wystawiono fakturę pomiędzy na kwotę mniejszą niż 10 pomiędzy '2013-12-05 00:00:00' i '2013-12-09 00:00:00',
- Napisz zapytanie, które zwróci wszystkie miasta i kraje gdzie wartość kolumny `billingstate` równa się `NULL` i wartość zamówienia jest większa niż 17 oraz te gdzie wartość zamówienia jest mniejsza niż 1, `billingstate` nie ma wartości `NULL` i zostały wystawione po '2013-09-20 00:00:00'.

# Dodatkowe materiały do nauki

Jeśli chcesz spojrzeć na temat z innej perspektywy polecam przeczytanie poniższych materiałów. Pozwoli Ci to poszerzyć swoją wiedzę związaną z językiem SQL i jego składnią.

- [Artykuł na temat SQL na Wikipedii](https://pl.wikipedia.org/wiki/SQL),
- [Dokumentacja SQLite](https://www.sqlite.org/docs.html).

# Podsumowanie

Po przeczytaniu tego artykułu wiesz czym jest język SQL. Potrafisz podzielić zapytania języka SQl na grupy. Znasz podstawy zapytania typu `SELECT`. Potrafisz zastosować w praktyce zapytania tego typu do pobrania danych z bazy. Innymi słowy masz solidne podstawy, dzięki którym możesz przejść do kolejnego etapu nauki języka SQL.

Przyznam Ci się, że miałem problem z zakończeniem tego artykułu. Mam świadomość, że nie jest kompletny, ale postanowiłem podzielić go na mniejsze, łatwiejsze do przyswojenia części. W kolejnych artykułach z cyklu możesz spodziewać się pogłębienia tematu :).

Na koniec proszę Cię o polecenie tego artykułu Twoim znajomym, którym może się on przydać. Dzięki Tobie uda mi się dotrzeć do nowych czytelników. Z góry dziękuję ;). Jeśli cokolwiek nie będzie dla Ciebie jasne proszę daj znać w komentarzach, postaram się pomóc. Jeśli nie chcesz pominąć kolejnych artykułów na blogu proszę polub Samouczka na Facebooku i dodaj swój adres e-mail do samouczkowego newslettera. Do następnego razu! ;)

