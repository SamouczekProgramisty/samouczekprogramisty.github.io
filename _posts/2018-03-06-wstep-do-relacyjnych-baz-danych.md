---
title: Wstęp do relacyjnych baz danych
date: 2018-07-18 20:43:32 +0200
categories:
- Bazy danych
permalink: /wstep-do-relacyjnych-baz-danych/
header:
    teaser: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    overlay_image: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    caption: "[&copy; liquene](https://www.flickr.com/photos/liquene/3802773731/sizes/l)"
excerpt: W artykule tym przeczytasz o tym czym jest relacyjny model baz danych. Dowiesz się o tym jak wygląda komunikacja pomiędzy klientem a serwerem bazy danych. Poznasz pojęcia krotki, relacji i atrybutu w kontekście relacyjnych baz danych. Dowiesz się czym jest klucz główny i klucz obcy. Artykuł zawiera podstawy niezbędne do zrozumienia relacyjnych baz danych. Zapraszam do lektury.
---

## Czym jest baza danych

Baza danych to zbiór danych zapisanych w odpowiednim formacie. Format zapisu danych pozwala na dostęp do danych. W zależności od zastosowania dane zapisywane są w różny sposób. Sposób zapisu danych ma wpływ na wydajność poszczególnych operacji (zapisu, odczytu, usunięcia i modyfikacji danych).

Istnieje wiele rodzai baz danych. Jednym z najbardziej popularnych jest relacyjna baza danych. Określenie relacyjna baza danych opisuje bazę danych, w której dane zapisane są w postaci tak zwanych krotek. Krotki mają swoje atrybuty. Każda krotka zapisana jest w relacji.

Operacje w relacyjnych bazach danych oparte są o [algebrę relacji](https://en.wikipedia.org/wiki/Relational_algebra). Dostęp do danych możliwy jest dzięki użyciu [SQL](https://en.wikipedia.org/wiki/SQL) (ang. _Structured Query Language_). SQL to język charakterystyczny dla baz danych.

Możesz spotkać się z wieloma implementacjami relacyjnych baz danych. Kilka najczęściej używanych implementacji możesz znaleźć poniżej:

- [PostgreSQL](https://www.postgresql.org/),
- [MySQL](https://www.mysql.com/),
- [SQLite](https://www.sqlite.org/index.html),
- [Oracle](https://www.oracle.com/database/index.html),
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-2017),
- [HyperSQL](http://hsqldb.org/).

Bazy danych różnią się między sobą implementacją. Różnią się także wersją SQL, którą obsługują. Chociaż istnieje standard opisujący język SQL występują drobne różnice pomiędzy SQL obsługiwanym przez poszczególne bazy danych. Różne wersje SQL nazywane są dialektami.

{% include wspolpraca-infoshare-2018.md %}

## Jak działa relacyjna baza danych

Bazy danych używane w środowiskach produkcyjnych składają się z wielu komponentów. W dużym uproszczeniu można powiedzieć, że zawsze występują dwa: klient bazy danych i serwer bazy danych. Serwer bazy danych to program, który potrafi obsłużyć żądania wysyłane przez klienty. Serwer odpowiedzialny jest za zapisywanie i udostępnianie danych przechowywanych w bazie.

Serwer używa pewnego portu, na którym nasłuchuje żądań od klientów. Na przykład [PostgreSQL](https://www.postgresql.org/) domyślnie używa portu 5432.

W większości znanych mi przypadków serwery używają protokołu [ODBC](https://en.wikipedia.org/wiki/Open_Database_Connectivity) (ang. _Open Database Connectivity_) do komunikacji z klientami. Jest to protokół, który zapewnia spójny dostęp do danych, niezależny od serwera bazy danych. Sewery udostępniają także protokół [JDBC](https://en.wikipedia.org/wiki/Java_Database_Connectivity) (ang. _Java Database Connectivity_).

Klienty wskazują serwer, z którym chcą się połączyć za pomocą URL. W przypadku bazy danych PostgreSQL URL może wyglądać następująco:

    jdbc:postgresql://some.server.host:5432/database_name

URL ten służy do połączenia się do serwera `some.server.host` na porcie `5432` używając protokołu `jdbc:postgresql`. `database_name` wskazuje bazę danych do której chcemy się połączyć. Jeśli chcesz przeczytać więcej o URL odsyłam Cię do artykułu na temat [protokołu HTTP]({% post_url 2018-02-08-protokol-http %}).

Do obsługi takiego połączenia klient potrzebuje odpowiedniego sterownika. Sterownik to klasa obsługująca połączenie. Producenci bazy danych [udostępniają](https://jdbc.postgresql.org/) takie sterowniki.

Klienty używając języka SQL wysyłają żądania do serwera. Dotyczą one dostępu do danych zapisanych w bazie. Wcześniej wspomniany sterownik obsługuje komunikację pomiędzy klientem a serwerem.

Serwer interpretuje te zapytania i pobiera dane z plików zachowanych na dysku serwera[^uproszczenie]. Następnie dane te są zwracane do klienta, po czym sterownik interpretuje dane przekazane zgodnie z protokołem, np. JDBC.

Bardzo często zapytanie SQL zwraca przetworzone dane do klienta. Przetwarzanie surowych danych odbywa się po stronie serwera relacyjnej bazy danych.

[^uproszczenie]: Jest to duże uproszczenie. Bazy danych są programami, które są przystosowane do obsługi dużej liczby zapytań. Znane mi relacyjne bazy danych wspierają [ACID](https://en.wikipedia.org/wiki/ACID). Zapytania często podlegają optymalizacji. Przetwarzanie danych zgodnie z zapytaniem SQL to także robota serwera. Czynniki te sprawiają, że dostęp do danych to coś więcej niż zwykłe "pobieranie danych z dysku".

{% include newsletter-srodek.md %}

## Model relacyjny

Za modelem relacyjnym stoi [algebra relacji](https://en.wikipedia.org/wiki/Relational_algebra). Jest to matematyczny opis operacji wykonywanych na danych zachowanych w bazie. Możesz w nim przeczytać o sumie zbiorów, iloczynie kartezjańskim etc. Postaram się wytłumaczyć sposób działa baz bez użycia takich pojęć.

Na potrzeby tego artykułu posłużę się wcześniej wspomnianym przykładem magazynu. Załóżmy, że w tym przypadku bazę danych możemy opisać kilkoma zdaniami:

- W magazynie przechowujemy różne rodzaje towarów,
- Poszczególne towary produkowane są przez różnych producentów,
- Różni hurtownicy pobierają różne towary z magazynu,
- Każdy producent ma jednego opiekuna handlowego.

### Encja

Zrób proste ćwiczenie. Wybierz wszystkie rzeczowniki z listy, którą umieściłem wyżej. Możesz ją porównać z tą listą:

- magazyn,
- towar,
- producent,
- hurtownik,
- opiekun handlowy.

Można powiedzieć, że encje to rzeczowniki wyjęte z opisu bazy danych ;). Encje to rodzaje "obiektów" przechowywanych w bazie. Na przykład towar, czy producent. Odpowiednikiem encji w programowaniu obiektowym jest klasa. Zatem w przypadku bazy danych opisującej magazyn występuje pięć rodzai encji.

Sama encja nie jest ściśle związana z modelem relacyjnym. Definicja ta jest jednak używana w trakcie projektowania baz danych.

### Atrybut

Każda z encji ma swoje właściwości. Na przykład opiekun handlowy ma numer telefonu, imię czy nazwisko. Każdy z tych elementów to atrybut. Podobnie jak w programowaniu obiektowym instancje mają swoje atrybuty.

Podobnie jak w języku programowania tak i tutaj atrybuty mają swoje typy. Relacyjne bazy danych obsługują różne typy. W większości przypadków typy z języków programowania mają swoje odpowiedniki w typach w bazie danych. Na przykład:

| Typ w języku Java | Typ w PostgreSQL   |
| ----------------- | ------------------ |
| `String`          | `varchar`          |
| `boolean`         | `boolean`          |
| `double`          | `double precision` |
| `byte[]`          | `bytea`            |
| `int`             | `integer`          |

Istnieją jednak typy, które nie mają swojego dokładnego odwzorowania w niektórych językach programowania, na przykład:

- `box`,
- `decimal(p, s)`,
- `polygon`.

Te różnice pokazują, że nie zawsze da się przenieść świat relacyjnej bazy danych do świata programowania obiektowego. Tematyce mapowania obiektowo-relacyjnego (ang. _object-relational mapping_) poświęcę osobny artykuł.

### Krotka

Krotka to zbiór atrybutów. Upraszczając można powiedzieć, że krotka w modelu relacyjnym odpowiada instancji obiektu w programowaniu obiektowym[^mapowanie]. Krotki często prezentowane są w postaci wiersza w tabeli gdzie każda kolumna odpowiada poszczególnym atrybutom.

[^mapowanie]: Nie jest to do końca prawda, na przykład w przypadku relacji wiele do wielu krotki w relacji łączącej nie muszą mieć odpowiadającego im obiektu w języku programowania.

Przykładem krotki zawierającej towar może być:

| Nazwa `varchar` | Stan magazynowy `integer` | Cena `double precision` |
| --------------- | ------------------------- | ----------------------- |
| trampki         | 10                        | 99.99                   |

### Relacja

W relacyjnym modelu bazy danych relacją określamy zbiór krotek. Skoro pojedyncza krotka to wiersz w tabeli, to zbiór krotek to cała tabela :). Istnieją różne konwencje nazywania relacji. W dalszej części artykułu będę używał liczby mnogiej od nazwy encji. Dla przykładu relacja przechowująca krotki `towar` będzie nazywała się `towary`.

Musisz także wiedzieć, że relacją także możemy określać zależności jakie występują pomiędzy poszczególnymi tabelami. Na przykład tabela `towary` jest powiązana z tabelą `producenci`. Producent produkuje różne towary. Zatem pomiędzy `producenci` a `towary` występuje relacja jeden do wielu - jeden producent produkuje wiele towarów.
{:.notice--info}

Zbierając kilka krotek, relacja `towary` może wyglądać następująco:

| Nazwa `varchar` | Stan magazynowy `integer` | Cena `double precision` |
| --------------- | ------------------------- | ----------------------- |
| trampki         | 10                        | 99.99                   |
| sweter          | 0                         | 299.99                  |
| lizak           | 2500                      | 0.5                     |
| spinacz         | 500                       | 0.01                    |

W modelu relacyjnym krotki w relacji nie mogą się powtarzać (elementy w zbiorze są unikalne). W praktyce relacyjne bazy danych posługujące się SQL pozwalają na duplikaty wierszy w tabelach. Sam język SQL pozwala na pobranie unikalnych elementów z danej tabeli.

### Klucz główny

Zbiór atrybutów (kolumn w tabeli) tworzy klucz główny. Klucz główny to unikalny identyfikator dla każdego wiersza w tabeli. W większości przypadków tabele zawierają dodatkową kolumnę, która zawiera identyfikator w postaci liczby:

| Id `integer` (PK) | Nazwa `varchar` | ... |
| ----------------- | --------------- | --- |
| 1                 | trampki         | ... |
| 2                 | sweter          | ... |
| 3                 | lizak           | ... |
| 4                 | spinacz         | ... |

W tabeli wyżej kolumna `Id` jest kluczem głównym (ang. _primary key_). Tworzenie kluczy głównych przy pomocy liczby pozwala na automatyczne tworzenie nowej wartości klucza dla nowego wiersza. Wystarczy podnieść o 1 największą wartość klucza głównego. Klucze główne składające się z wielu kolumn nazywa się kluczami złożonymi.

Bazy danych optymalizują dostęp do danych przy pomocy klucza głównego. Oznacza to tyle, że pobranie wiersza z tabeli `towary` na podstawie kolumny `Id` będącej kluczem głównym może być bardziej wydajne niż pobranie tego samego wiersza na podstawie wartości kolumny `Nazwa`.

### Klucz obcy

Wspomniałem wyżej, że tabele mogą być ze sobą powiązane. Te zależności pomiędzy tabelami pokazane są przez klucze obce (ang. _foreign key_). Klucz obcy to dodatkowa kolumna (lub kolumny), która pokazuje zależność. Na przykład tabela `producenci` może wyglądać następująco:

| Id `integer` (PK) | Siedziba `varchar` | Rok założenia `integer` |
| ----------------- | ------------------ | ----------------------- |
| 1                 | Wrocław            | 2007                    |
| 2                 | Warszawa           | 1980                    |
| 3                 | Kraków             | 1948                    |

Dodatkowa kolumna `producent_id` znajdująca się wewnątrz tabeli `towary` pokazuje zależność pomiędzy towarami a producentami:

| Id `integer` (PK) | Nazwa `varchar` | Producent id `integer` (FK) | ... |
| ----------------- | --------------- | --------------------------- | --- |
| 1                 | trampki         | 1                           | ... |
| 2                 | sweter          | 2                           | ... |
| 3                 | lizak           | 3                           | ... |
| 4                 | spinacz         | 3                           | ... |

Taka tabela pokazuje, że trampki produkowane są przez producenta z Wrocławia, swetry przez producenta z Warszawy. Producent z Krakowa produkuje lizaki i spinacze.

## Rodzaje powiązań

Tabele mogą mieć trzy rodzaje zależności. Każdą z nich opiszę w osobnym podpunkcie.

### Jeden do jednego

Przykładem takiej zależności może być samochód - numer rejestracyjny. Każdy numer rejestracyjny przypisany jest do jednego samochodu, podobnie każdy samochód ma tylko jeden numer rejestracyjny. W przypadku magazynu relacją tego typu może być opiekun handlowy - producent. Zależność tego typu reprezentuje dodatkowa kolumna w tabeli:

`producenci`

| Id `integer` (PK) | Siedziba `varchar` | Rok założenia `integer` |
| ----------------- | ------------------ | ----------------------- |
| ...               | ...                | ...                     |

`opiekunowie`

| Id `integer` (PK) | Nazwisko `varchar` | Producent id `integer` (FK) |
| ----------------- | ------------------ | --------------------------- |
| ...               | ...                | ...                         |

Kolumna `Producent id` w tabeli `opiekunowie` wskazuje na producenta, za którego jest odpowiedzialny dany opiekun.

### Jeden do wielu

Przykładem takiej zależności może być towar - producent. Każdy towar produkowany jest przez jednego producenta. Podobnie jak w przypadku reakcji jeden do jednego zależność tego typu uzyskuje się poprzez dodanie odpowiedniej kolumny:

`producenci`

| Id `integer` (PK) | Siedziba `varchar` | Rok założenia `integer` |
| ----------------- | ------------------ | ----------------------- |
| ...               | ...                | ...                     |

`towary`

| Id `integer` (PK) | Nazwa `varchar` | ... | Producent id `integer` (FK) |
| ----------------- | --------------- | --- | --------------------------- |
| ...               | ...             | ... | ...                         |

Zauważ, że zarówno zależność jeden do wielu, jak i jeden do jednego możliwa jest przy pomocy pojedynczej kolumny.

Zależność tego typu określa się także jako 1 do n.

### Wiele do wielu

Zależność wiele do wielu może występować pomiędzy hurtownikami i towarami. Oznacza ona tyle, że wielu hurtowników zaopatruje się w wiele towarów. Ten sam towar pobierany jest przez wielu hurtowników. W przypadku takiej zależności niezbędna jest dodatkowa tabela, która połączy ze sobą dwie tabele:

`towary`

| Id `integer` (PK) | Nazwa `varchar` | ... | Producent id `integer` (FK) |
| ----------------- | --------------- | --- | --------------------------- |
| ...               | ...             | ... | ...                         |

`hurtownicy`

| Id `integer` (PK) | Nazwa hurtowni `varchar` |
| ----------------- | ------------------------ |
| ...               | ...                      |

`towary_hurtownicy`

| Towar id `integer` (FK) | Hurtownik id `integer` (FK) |
| ----------------------- | --------------------------- |
| ...                     | ...                         |

W tym przypadku tabela `towary_hurtownicy` ma dwa klucze obce. Jeden z nich pokazuje na tabelę `towary` drugi na `hurtownicy`. Zauważ, że w przypadku tej tabeli kluczem głównym, który identyfikuje każdy wiersz może być para tych kolumn. Jest to tak zwany klucz złożony.

Zależność tego typu określa się także jako n do m.

## Dodatkowe materiały do nauki

- [Bazy danych - wykłady na UW](http://wazniak.mimuw.edu.pl/index.php?title=Bazy_danych),
- [Model relacyjny - artykuł na Wikipedii](https://pl.wikipedia.org/wiki/Model_relacyjny),
- [Model relacyjny - wykład na AGH](http://www.metal.agh.edu.pl/~regulski/bd-podyp/00-wyklady/05_model_relacyjny.pdf).

## Zadanie do wykonania

Dasz radę zaprojektować bazę danych, do przechowania informacji o wykładach w trakcie konferencji? Spróbuj zrobić to na podstawie agendy znajdującej się na stronie [infoShare](https://infoshare.pl/#outline-agenda).

## Podsumowanie

W dzisiejszym artykule przeczytałeś o bazach danych. Poznałeś sposób komunikacji pomiędzy klientem a serwerem. Dowiedziałeś się czym jest model relacyjny. Wiesz czym jest relacja, krotka czy atrybut w kontekście modelu relacyjnego. Zdobytą wiedzę mogłeś przećwiczyć rozwiązując zadanie do wykonania. Te postawy pozwolą Ci lepiej zrozumieć SQL i mapowanie obiektowo relacyjne.

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Trzymaj się i do następnego razu!
