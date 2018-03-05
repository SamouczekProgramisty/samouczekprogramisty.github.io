---
title: Wstęp do relacyjnych baz danych
categories:
- Strefa zadaniowa
permalink: /wstep-do-relacyjnych-baz-danych/
header:
    teaser: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    overlay_image: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    caption: "[&copy; liquene](https://www.flickr.com/photos/liquene/3802773731/sizes/l)"
excerpt: W artykule tym przeczytasz o tym czym jest relacyjny model baz danych. Przeczytasz o tym jak wygląda komunikacja pomiędzy klientem a serwerem bazy danych. Dowiesz się czym jest krotka czy relacja. Dowiesz się czym jest klucz główny, klucz obcy czy postać normalna. Zapraszam do lektury.
---

## Dlaczego używamy bazy danych

Część programów komputerowych nie potrzebuje przechowywać swojego stanu, na przykład kalkulator. Kalkulator może świetnie działać i spełniać swoją funkcję bez zapamiętywania danych wprowadzonych przez użytkownika pomiędzy uruchomieniami.

Jednak istnieją programy, które do poprawnego działania muszą bazować na danych wprowadzonych poprzednio przez użytkownika. Wyobraź sobie program do obsługi magazynu. Pracownik magazynu w trakcie przyjęcia czy wydania towaru musi wprowadzić taką informację do programu. Dzięki temu stan w programie odpowiada rzeczywistemu stanowi w magazynie. Informacja o wszystkich towarach przechowywanych w magazynie musi być trwale zachowana. 

Takie wymaganie jest charakterystyczne dla wielu programów. Możliwe jest zapisywanie takiego stanu w pliku i odczytywanie go w danym programie. Wiele programów tak własnie robi. Jednak implementowanie swojego własnego formatu przechowywania danych może być czasochłonne. Może także powodować wiele problemów w sytuacji gdy danych do zachowania będzie dużo [^duzo].

[^duzo]: Ile to jest "dużo" zależy sposobu oprogramowania dostepu do danych i ich przechowywania. Może być tak, że na komputerze, który ma 8GB pamięci RAM "dużo" danych to 4GB, jeśli całą bazę danych trzeba zapisać do pamięci komputera. Może być też tak, że "dużo" to 4PB (petabajty) jeśli baza danych jest odpowiednio rozproszona. Określenie "dużo" jest względne.

Jest to standardowy problem, który trzeba rozwiązać w wielu programach. Rozwiązaniem tego problemu w wielu przypadkach jest użycie odpowiedniej bazy danych.

### Czym jest baza danych

Baza danych to zbiór danych zapisanych w odpowiednim formacie. Format zapisu danych pozwala na dostęp do danych. W zależności od zastosowania dane zapisywane są w różny sposób. Sposób zapisu danych ma wpływ na wydajność poszczególnych operacji (zapisu, odczytu, usunięcia i modyfikacji danych).

Istnieje wiele rodzai baz danych. Jednym z najbardziej popularnych jest relacyjna baza danych. Określenie relacyjna baza danych opisuje bazę danych, w której dane zapisane są w postaci tak zwanych krotek. Krotki mają swoje atrybuty. Każda krotka zapisana jest w relacji. 

Operacje w relacyjnych bazach danych oparte są o [algebrę relacji](https://en.wikipedia.org/wiki/Relational_algebra). Dostęp do danych możliwy jest dzięki użyciu [SQL](https://en.wikipedia.org/wiki/SQL) (ang. _Structured Query Language_). SQL to język charakterystyczny dla baz danych, który pozwala na dostęp do danych w bazie.

### Jak działa relacyjna baza danych

Bazy danych używane w środowiskach produkcyjnych składają się z wielu komponentów. W uproszczeniu można powiedzieć, że zawsze występują dwa: klient bazy danych i serwer bazy danych. Serwer bazy danych to program, który potrafi obsłużyć żądania wysyłane przez klienty.

Serwer używa pewnego portu, na którym nasłuchuje żądań od klientów. Na przykład [PostgreSQL](https://www.postgresql.org/) domyślnie używa portu 5432.

W większości znanych mi przypadków serwery używają protokołu [ODBC](https://en.wikipedia.org/wiki/Open_Database_Connectivity) (ang. _Open Database Connectivity_) do komunikacji z klientami. Jest to protokół, który zapewnia spójny dostęp do danych, niezależny od serwera bazy danych. Sewery udostępniają także protokół [JDBC](https://en.wikipedia.org/wiki/Java_Database_Connectivity) (ang. _Java Database Connectivity_).

Klienty łączą się z serwerem bazy danych używając URL. W przypadku bazy danych PostgreSQL ten url może wyglądać następująco {{jdbc:postgresql://server.host:5432/database_name}}. Do obsługi takiego połączenia klient potrzebuje odpowiedniego sterownika. Sterownik to klasa obsługująca dane połączenie. Producenci bazy danych [udostępniają](https://jdbc.postgresql.org/) takie sterowniki.

Klienty używając języka SQL wysyłają żądania do serwera. Dotyczą one dostępu do danych zapisanych w bazie. Wcześniej wspomniany sterownik obsługuje komunikację pomiędzy klientem a serwerem.

Serwer interpretuje te zapytania i pobiera dane z plików zachowanych na dysku serwera[^uproszczenie]. Następnie dane te są zwrócone do klienta.

[^uproszczenie]: Jest to duże uproszczenie. Bazy danych są programami, które są przystosowane do obsługi dużej liczby zapytań. Dodatkowo relacyjne bazy danych wspierają [ACID](https://en.wikipedia.org/wiki/ACID). Czynniki te sprawiają, że dostęp do danych to coś więcej niż "pobieranie danych z dysku".

## Model relacyjny

### Relacja

### Krotka

### Atrybut

### Klucz główny

### Klucz obcy

## Postać normalna

## Podsumowanie

Po przeczytaniu artykułu znasz dwa sposoby rozwiązania zadanego problemu. Znasz złożoność pamięciową i obliczeniową każdego z rozwiązań. Jesteś o jedno zadanie lepiej przygotowany do rozmowy kwalifikacyjnej ;).

Przykładowe rozwiązania, przedstawione w artykule znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/08_cyclic_number/src). Kod zawiera także [testy jednostkowe]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}), których użyłem do weryfikacji poprawności działania algorytmów.

Jeśli nie chcesz pominąć kolejnych artykułów z tej serii dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Jak zwykle, jeśli masz jakiekolwiek pytania proszę zadaj je w komentarzach. Postaram się pomóc ;). Do następnego razu!
