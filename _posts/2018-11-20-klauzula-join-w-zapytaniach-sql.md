---
title: Klauzula JOIN w zapytaniach SQL
last_modified_at: 2018-11-22 23:20:12 +0100
categories:
- Bazy danych
- Kurs SQL
permalink: /klauzula-join-w-zapytaniach-sql/
header:
    teaser: /assets/images/2018/11/22_kauzula_join_w_zapytaniach_sql_artykul.jpg
    overlay_image: /assets/images/2018/11/22_kauzula_join_w_zapytaniach_sql_artykul.jpg
    caption: "[&copy; PublicDomainPictures](https://pixabay.com/pl/po%C5%82%C4%85czenia-po%C5%82%C4%85czenie-wsp%C3%B3%C5%82praca-316638/)"
excerpt: W tym artykule opisuję klauzulę `JOIN`. Pozwala ona na łączenie ze sobą danych znajdujących się w różnych tabelach. Po lekturze tego artykułu będziesz wiedzieć jakie są rodzaje złączeń i jakie są między nimi różnice. Wszystkie opisy poparte są przykładami. Na końcu artykułu znajdziesz zadania z przykładowymi rozwiązaniami, które pomogą utrwalić Ci wiedzę dotyczącą klauzuli `JOIN`.
---

{% include kurs-sql-notice.md %}

W tym artykule, jeśli wyraźnie nie zaznaczyłem inaczej, korzystam z bazy danych [SamouczekJoin.sqlite](https://github.com/SamouczekProgramisty/chinook-database/raw/master/SamouczekJoin.sqlite).
{:.notice--info}

## Odrobina teorii

Zanim przejdę do omówienia klauzuli `JOIN`. Muszę powiedzieć Ci coś więcej na temat modelu relacyjnego. Jeśli nie udało Ci się przeczytać artykułu dotyczącego [wprowadzenia do relacyjnych baz danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}) to najwyższy czas to nadrobić. Ten artykuł będzie wymagał materiału, który tam opisałem.

Poza materiałem z tamtego artykułu musisz poznać jeszcze jedno pojęcie. Mam na myśli iloczyn kartezjański.

## Iloczyn kartezjański

Wyobraź sobie dwie tabele. Jedna zawiera imiona męskie:

```sql
SELECT *
  FROM imiona_meskie;
```

    id          imie
    ----------  ----------
    1           Piotr
    2           Tomasz
    3           Jan

SQLite pozwala na takie formatowanie wyników po użyciu `.header on` in `.mode column`
{:.notice--info}

Druga żeńskie:

```sql
SELECT *
  FROM imiona_zenskie;
```

    id          imie
    ----------  ----------
    11          Anna
    12          Monika
    13          Zofia

Iloczynem kartezjańskim będzie zbiór, w którym każdy wiersz z pierwszej tabeli połączony będzie z każdym wierszem w drugiej tabeli. W związku z tym, że w każdej z tabel są 3 wiersze, wynikowa tabela[^relacja] będzie miała ich 9:

    id          imie        id          imie
    ----------  ----------  ----------  ----------
    1           Piotr       11          Anna
    1           Piotr       12          Monika
    1           Piotr       13          Zofia
    2           Tomasz      11          Anna
    2           Tomasz      12          Monika
    2           Tomasz      13          Zofia
    3           Jan         11          Anna
    3           Jan         12          Monika
    3           Jan         13          Zofia

[^relacja]: W kontekście modelu relacyjnego powinienem raczej użyć pojęcia relacja. Mam wrażenie, że tabela jest jednak łatwiejsze do zrozumienia.

Taki iloczyn kartezjański możesz wyprodukować używając zapytania:

```sql
SELECT *
  FROM imiona_meskie
      ,imiona_zenskie;
```

### Nazwy kolumn

Jak widzisz nazwy kolumn są w nim powtórzone. Pierwsze dwie `id` i `imie` pochodzą z tabeli `imiona_meskie`. Dwie kolejne, o tych samych nazwach pochodzą z tabeli `imiona_zenskie`.

W takim przypadku aby wybrać kolumnę, z konkretnej tabeli konieczne jest poprzedzenie jej nazwą tabeli. Na przykład:

```sql
SELECT imiona_meskie.id AS id_m
      ,imiona_zenskie.imie AS imie_z
      ,imiona_zenskie.*
  FROM imiona_meskie
      ,imiona_zenskie;
```

    id_m        imie_z      id          imie
    ----------  ----------  ----------  ----------
    1           Anna        11          Anna
    1           Monika      12          Monika
    1           Zofia       13          Zofia
    2           Anna        11          Anna
    2           Monika      12          Monika
    2           Zofia       13          Zofia
    3           Anna        11          Anna
    3           Monika      12          Monika
    3           Zofia       13          Zofia

W przykładzie tym użyłem także konstrukcji `imiona_zenskie.*`, która zwraca wszystkie kolumny z tabeli `imiona_zenskie`.

{% include newsletter-srodek.md %}

## Typy złączeń

Złączenia będę omawiał na przykładzie dwóch tabel `bajka` i `postac`. `bajka` zwiera dwie kolumny:

- `id` identyfikator bajki, klucz główny,
- `tytul` tytuł bajki.

```sql
SELECT *
  FROM bajka;
```

    id          tytul
    ----------  --------------------
    1           101 Dalmatyńczyków
    2           Flinstonowie
    3           Jetsonowie
    4           Epoka lodowcowa
    5           Rozbójnik Rumcajs
    6           Muminki
    7           Smerfy

`postac` to tabela z trzema kolumnami:

- `id` identyfikator postaci, klucz główny,
- `bajka_id` identyfikator bajki, w której postać występuje, klucz obcy do tabeli `bajka`,
- `imie` imię postaci.

```sql
SELECT *
  FROM postac;
```

    id          bajka_id    imie
    ----------  ----------  ----------
    1           1           Czika
    2           1           Pongo
    3           2           Wilma
    4           2           Fred
    5           4           Elka
    6           4           Maniek
    7           6           Migotka
    8           6           Muminek
    9                       Maja
    10                      Gucio
    11                      Fiona
    12                      Shrek

W złączeniach tabel istotne są [klucze główne]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-g%C5%82%C3%B3wny) i [klucze obce]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-obcy). Tutaj jeszcze raz odsyłam Cię do artykułu opisującego [model relacyjny]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %})[^niewymagane].

[^niewymagane]: Złączeń można dokonywać na tabelach, które nie są połączone między sobą kluczami obcymi. W praktyce nie zdarza się to za często. Upraszczając można powiedzieć, że klucze główne i klucze obce pomagają silnikom baz danych wykonywać złączenia, które są bardziej wydajne.

Znasz już dwa sposoby łączenia danych z wielu tabel. Iloczyn kartezjański i klauzule [`UNION` oraz `UNION ALL`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#scalanie-wynik%C3%B3w-wielu-zapyta%C5%84). O ile wyniki uzyskiwane przez złączenie wyników kilku zapytań przy pomocy `UNION` lub `UNION ALL` mogą być przydatne to iloczyn kartezjański zbyt użyteczny nie jest. SQL daje możliwość łączenia danych z wielu tabel na kilka innych sposobów.

Do uzyskania wszystkich rodzai złączeń podstawą jest iloczyn kartezjański. Z takiego iloczynu odrzucane są następnie wiersze, które "nie pasują" do złączenia danego typu[^optymalizacja].

[^optymalizacja]: Bazy danych mogą tu sporo optymalizować, dzięki czemu czasochłonne tworzenie iloczynu kartezjańskiego nie zawsze jest wykonywane. Jednak z punktu widzenia algebry relacji, podstawy modelu relacyjnego to właśnie iloczyn kartezjański jest punktem wyjścia.

### `INNER JOIN`

Podstawowym rodzajem złączenia jest `INNER JOIN`. Z iloczynu kartezjańskiego wybiera ono te wiersze, dla których warunek złączenia jest spełniony. W żadnej z łączonych tabel kolumna użyta do łączenia nie może mieć wartości `NULL`. Na przykład:

```sql
SELECT *
  FROM bajka INNER JOIN postac
             ON bajka.id = postac.bajka_id;
```

To zapytanie zwraca wszystkie kolumny z tabel `bajka` i `postac`. Zwrócone są tylko te wiersze, dla których wartość kolumn `bajka.id` i `postac.bajka_id` jest równa:

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    4           Epoka lodowcowa       5           4           Elka      
    4           Epoka lodowcowa       6           4           Maniek    
    6           Muminki               7           6           Migotka   
    6           Muminki               8           6           Muminek   

W zrozumieniu tego co się tutaj stało może pomóc rzucenie okiem na iloczyn kartezjański (jakie zapytanie wyprodukuje taki iloczyn kartezjański?):

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    1           101 Dalmatyńczyków    3           2           Wilma     
    1           101 Dalmatyńczyków    4           2           Fred      
    1           101 Dalmatyńczyków    5           4           Elka      
    1           101 Dalmatyńczyków    6           4           Maniek    
    1           101 Dalmatyńczyków    7           6           Migotka   
    1           101 Dalmatyńczyków    8           6           Muminek   
    1           101 Dalmatyńczyków    9                       Maja      
    1           101 Dalmatyńczyków    10                      Gucio     
    1           101 Dalmatyńczyków    11                      Fiona     
    1           101 Dalmatyńczyków    12                      Shrek     
    2           Flinstonowie          1           1           Czika     
    2           Flinstonowie          2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    2           Flinstonowie          5           4           Elka      
    2           Flinstonowie          6           4           Maniek   
    ...

Wynik złączenia, zawiera tylko cztery wiersze z tych, które pokazałem wyżej:

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    ...

Zwróć uwagę na wartości kolumn `id` (tej pierwszej, z tabeli `bajka`) i `bajka_id` (z tabeli `postac`). Jak widzisz zapytanie używające złączenia typu `INNER JOIN` zwraca wyłącznie te wiersze dla których kolumny użyte do złączenia mają tę samą wartość.

Innym sposobem na uzyskanie tego samego wyniku jest zapytanie:

```sql
SELECT *
  FROM bajka
      ,postac
 WHERE bajka.id = postac.bajka_id;
```

#### Wybieranie kolumn

Rzadko pobranie wszystkich kolumn po złączeniu tabel jest potrzebne. Bardzo często zwracane wiersze zawierają tylko niezbędny podzbiór kolumn:

```sql
SELECT bajka.tytul
      ,postac.imie
  FROM bajka INNER JOIN postac
             ON bajka.id = postac.bajka_id;
```

    tytul                 imie      
    --------------------  ----------
    101 Dalmatyńczyków    Czika     
    101 Dalmatyńczyków    Pongo     
    Flinstonowie          Wilma     
    Flinstonowie          Fred      
    Epoka lodowcowa       Elka      
    Epoka lodowcowa       Maniek    
    Muminki               Migotka   
    Muminki               Muminek   

A co z brakującymi postaciami i bajkami? Zauważ, że wynik nie zawiera bajek takich jak "Jetsonowie", "Rozbójnik Rumcajs" czy "Smerfy". Brakuje także postaci "Maja", "Gucio", "Fiona" i "Shrek". Z pomocą przychodzą złączenia typu `OUTER JOIN`.

### `OUTER JOIN`

Istnieją trzy rodzaje złączeń typu `OUTER`:

- `LEFT OUTER JOIN`,
- `RIGHT OUTER JOIN`,
- `FULL OUTER JOIN`.

#### `LEFT OUTER JOIN`

Tym razem zacznę od przykładu. Zapytanie używające złączenia tego typu może wyglądać tak:

```sql
SELECT *
  FROM bajka LEFT OUTER JOIN postac
             ON bajka.id = postac.bajka_id;
```

W wyniku działania tego zapytania zwrócone zostaną następujące wiersze:

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    3           Jetsonowie                                              
    4           Epoka lodowcowa       5           4           Elka      
    4           Epoka lodowcowa       6           4           Maniek    
    5           Rozbójnik Rumcajs                                      
    6           Muminki               7           6           Migotka   
    6           Muminki               8           6           Muminek   
    7           Smerfy           

W tym przypadku zapytanie zwróciło wszystkie bajki. Zarówno te, dla których istnieją odpowiadające im postaci jak i te, które nie mają odpowiadających wierszy w tabeli `postac`. Widzisz różnicę? W złączeniu typu `LEFT OUTER JOIN` znajdują się dodatkowe wiersze. Te wiersze zawierają wartości `NULL` w kolumnach tabeli `postac`. Pokazuje to tyle, że dla bajek "Jetsonowie", "Rozbójnik Rumcajs" i "Smerfy" nie udało się znaleźć odpowiadających wierszy w tabeli `postac`.

Innymi słowy złączenie typu `LEFT OUTER JOIN` zwraca:
 
- wiersze dla których warunek złączenia jest spełniony,
- wiersze z "lewej tabeli" dla których nie ma odpowiedników w prawej (`*bajka* LEFT OUTER JOIN postac`).

#### Wybieranie kolumn

Także tutaj ograniczenie liczby kolumn jest przydatne:

```sql
SELECT bajka.tytul
      ,postac.imie
  FROM bajka
       LEFT OUTER JOIN postac ON bajka.id = postac.bajka_id;
```

To zapytanie zwróci następujące wiersze:

    tytul                 imie      
    --------------------  ----------
    101 Dalmatyńczyków    Czika     
    101 Dalmatyńczyków    Pongo     
    Flinstonowie          Fred      
    Flinstonowie          Wilma     
    Jetsonowie                      
    Epoka lodowcowa       Elka      
    Epoka lodowcowa       Maniek    
    Rozbójnik Rumcajs              
    Muminki               Migotka   
    Muminki               Muminek   
    Smerfy                    

#### `RIGHT OUTER JOIN`

Niestety SQLite nie wspiera `RIGHT OUTER JOIN`. Wyniki, które tu pokazuję możesz uzyskać w innych silnikach baz danych lub obchodząc ograniczenia SQLite.
{:.notice--warning}

`RIGHT OUTER JOIN` jest złączeniem podobnym do `LEFT OUTER JOIN`. Złączenie typu `RIGHT OUTER JOIN` zwraca:
 
- wiersze dla których warunek złączenia jest spełniony,
- wiersze z "prawej tabeli" dla których nie ma odpowiedników w lewej (`bajka RIGHT OUTER JOIN *postac*`).

```sql
SELECT *
  FROM bajka RIGHT OUTER JOIN postac
             ON bajka.id = postac.bajka_id;
```

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    4           Epoka lodowcowa       5           4           Elka      
    4           Epoka lodowcowa       6           4           Maniek    
    6           Muminki               7           6           Migotka   
    6           Muminki               8           6           Muminek   
                                      9                       Maja      
                                      10                      Gucio     
                                      11                      Fiona     
                                      12                      Shrek   

W tym przypadku zapytanie zwróciło wszystkie postaci. Zarówno te, dla których istnieją odpowiadające im bajki jak i te, które nie mają odpowiadających wierszy w tabeli `bajka`. W tym przypadku dla postaci "Maja", "Gucio", "Fiona" i "Shrek" nie udało znaleźć się odpowiadających bajek.

##### Jak uzyskać `RIGHT OUTER JOIN` w SQLite 

Tutaj sprawa jest banalnie prosta `bajka RIGHT OUTER JOIN postac` zwraca te same wyniki co `postac LEFT OUTER JOIN bajka` :). Zatem zwykłe odwrócenie tabel wystarczy:

```sql
SELECT bajka.*
      ,postac.* 
  FROM postac LEFT OUTER JOIN bajka
              ON bajka.id = postac.bajka_id;
```

#### `FULL OUTER JOIN`

Niestety SQLite nie wspiera `FULL OUTER JOIN`. Wyniki, które tu pokazuję możesz uzyskać w innych silnikach baz danych lub obchodząc ograniczenia SQLite.  
{:.notice--warning}

`FULL OUTER JOIN` jest złączeniem które zwraca:
 
- wiersze dla których warunek złączenia jest spełniony,
- wiersze z "lewej tabeli" dla których nie ma odpowiedników w prawej (`*bajka* LEFT OUTER JOIN postac`),
- wiersze z "prawej tabeli" dla których nie ma odpowiedników w lewej (`bajka RIGHT OUTER JOIN *postac*`).

```sql
SELECT *
  FROM bajka FULL OUTER JOIN postac
             ON bajka.id = postac.bajka_id;
```

    id          tytul                 id          bajka_id    imie      
    ----------  --------------------  ----------  ----------  ----------
    1           101 Dalmatyńczyków    1           1           Czika     
    1           101 Dalmatyńczyków    2           1           Pongo     
    2           Flinstonowie          3           2           Wilma     
    2           Flinstonowie          4           2           Fred      
    3           Jetsonowie                                              
    4           Epoka lodowcowa       5           4           Elka      
    4           Epoka lodowcowa       6           4           Maniek    
    5           Rozbójnik Rumcajs                                      
    6           Muminki               7           6           Migotka   
    6           Muminki               8           6           Muminek   
    7           Smerfy                                                  
                                      9                       Maja      
                                      10                      Gucio     
                                      11                      Fiona     
                                      12                      Shrek   
    
##### Jak uzyskać `FULL OUTER JOIN` w SQLite 

`FULL OUTER JOIN` jest złączeniem, która zwraca wiersze z połączenia `LEFT OUTER JOIN` i `RIGHT OUTER JOIN`. Klauzula `WHERE bajka.id IS NULL` odpowiada za odfiltrowanie części wspólnej. Bez tego warunku wynik zawierałby powielone wiersze wspólne dla `LEFT OUTER JOIN` i `RIGHT OUTER JOIN`:

```sql
SELECT *
  FROM bajka LEFT OUTER JOIN postac
             ON bajka.id = postac.bajka_id
UNION ALL
SELECT bajka.*
      ,postac.*
  FROM postac LEFT OUTER JOIN bajka
              ON bajka.id = postac.bajka_id
 WHERE bajka.id is NULL;
```

## `JOIN` tu, `JOIN` tam

Pamiętam, że na początku mnogość pojęć robiła mi niezły mętlik w głowie. Do tego wszystkiego silniki bazy danych pozwalające na opuszczanie niektórych słów kluczowych nie pomagały. Lista niżej powinna Ci pomóc się w nich odnaleźć:

- `JOIN` to to samo co `INNER JOIN`,
- `LEFT JOIN` to to samo co `LEFT OUTER JOIN`,
- `RIGHT JOIN` to to samo co `RIGHT OUTER JOIN`,
- `FULL JOIN` to to samo co `FULL OUTER JOIN`,
- `CROSS JOIN` to to samo co iloczyn kartezjański.

## Zadania do wykonania

Poniżej przygotowałem dla Ciebie kilka zadań do wykonania. Pomogą Ci one przećwiczyć sporą część materiału opisanego w kursie do tej pory. Wszystkie zapytania powinny być wywołane na bazie danych [Chinook](https://github.com/SamouczekProgramisty/chinook-database/raw/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite).

Jak zwykle zachęcam Cię do samodzielnego eksperymentowania zanim rzucisz okiem na przykładowe rozwiązania.

Napisz zapytanie, które zwróci:

- liczbę wierszy w iloczynie kartezjańskim tabel `track`, `invoice` i `invoiceline` (UWAGA! to zapytanie może trochę potrwać),
- tytuł albumu i nazwę artysty dla wszystkich nazw artystów zaczynających się od `s`,
- identyfikator i nazwę list utworów, które są puste,
- nazwy trzech najczęściej występujących gatunków muzycznych wraz z odpowiadającą im liczbą utworów posortowaną malejąco po liczbie utworów,
- tytuły pięciu najdłuższych albumów posortowanych malejąco po ich długości,
- tytuły albumów, na których występują utwory z gatunku "Reggae",
- pięć nazw list utworów, które są najdroższe (suma cen wszystkich ścieżek jest największa),

### Przykładowe rozwiązania zadań

```sql
SELECT COUNT(*)
  FROM track
      ,invoice
      ,invoiceline;
```

```sql
SELECT album.title
      ,artist.name 
  FROM album JOIN artist 
             ON album.artistid = artist.artistid
 WHERE artist.name LIKE 's%';
```

```sql
SELECT playlist.* 
  FROM playlist LEFT JOIN playlisttrack
                ON playlisttrack.playlistid = playlist.playlistid
 WHERE playlisttrack.trackid IS NULL;
```

```sql
  SELECT genre.name
        ,count(*) AS how_many
    FROM genre LEFT JOIN track
               ON genre.genreid = track.genreid
GROUP BY genre.name
ORDER BY how_many DESC
   LIMIT 3;
```

```sql
  SELECT album.title
    FROM track JOIN album
               ON track.albumid = album.albumid
GROUP BY album.albumid
ORDER BY SUM(track.milliseconds) DESC
   LIMIT 5;
```

```sql
SELECT DISTINCT album.title
  FROM track JOIN genre
             ON track.genreid = genre.genreid
             JOIN album
             ON track.albumid = album.albumid
 WHERE genre.name = "Reggae";
```

```sql
SELECT playlist.name
  FROM playlist JOIN playlisttrack
                ON playlist.playlistid = playlisttrack.playlistid
                JOIN track
                ON playlisttrack.trackid = track.trackid
GROUP BY playlist.name
ORDER BY SUM(track.unitprice) DESC
   LIMIT 5;
```

## Podsumowanie

Po lekturze tego artykułu wiesz już czym są złączenia. Znasz wszystkie typy złączeń występujące w zapytaniach SQL. Po przerobieniu przykładowych zadań wiesz jak połączyć w całość wiedzę zdobytą do tej pory na kursie. Gratuluję!

Muszę, Ci powiedzieć, że moim zdaniem ta część materiału jest zdecydowanie najtrudniejsza dla początkujących, na pewno dla mnie taka była. Daj sobie trochę czasu na przetrawienie wiedzy z tego artykułu :). Jeśli nie wszystko jest dla Ciebie zrozumiałe daj znać w komentarzach, postaram się pomóc.

Jeśli uważasz, że artykuł może przydać się komuś z Twoich znajomych, proszę przekaż mu linka. W ten sposób pomożesz mi dotrzeć do nowych Czytelników, z góry dziękuję!

Jeśli nie chcesz ominąć kolejnych artykułów polub Samouczka na Facebooku i dopisz się do samouczkowego newslettera.

Trzymaj się!
