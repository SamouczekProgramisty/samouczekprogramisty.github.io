---
title: Klauzula JOIN w zapytaniach SQL
categories:
- Bazy danych
- Kurs SQL
permalink: /klauzula-join-w-zapytaniach-sql/
header:
    teaser: /assets/images/2018/11/22_kauzula_join_w_zapytaniach_sql_artykul.jpg
    overlay_image: /assets/images/2018/11/22_kauzula_join_w_zapytaniach_sql_artykul.jpg
    caption: "[&copy; PublicDomainPictures](https://pixabay.com/pl/po%C5%82%C4%85czenia-po%C5%82%C4%85czenie-wsp%C3%B3%C5%82praca-316638/)"
excerpt: W artykule tym opisuję klauzulę `JOIN`. Pozwala ona na łączenie ze sobą danych znajdujących się w różnych tabelach. Po lekturze tego artykułu będziesz wiedzieć jakie są rodzaje złączeń i jakie są między nimi różnice. Opisy poparte są przykładami. Na końcu artykułu znajdziesz zadania z przykładowymi rozwiązaniami, które pomogą utrwalić Ci wiedzę dotyczącą klazuli `JOIN`.
---

{% include kurs-sql-notice.md %}

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

Iloczynem kartezjańskim będzie zbiór, w którym każdy wiersz z pierwszej tabeli połączony będzie z każdym wierszem w drugiej tabeli. W związku z tym, że w każdej z tabel są 3 wiersze, wynikowa tabela będzie miała ich 9:

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

W przykładzie tym użyłem także konstukcji `imiona_zenskie.*`, która zwraca wszystkie kolumny z tabeli `imiona_zenskie`.

## Typy złączeń

Złączenia będę omawiał na przykładzie dwóch tabel. `bajka` zwiera dwie kolumny:

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
 - `bajka_id` idytyfikator bajki, w której postać występuje, klucz obcy do tabeli `bajka`,
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

W złączeniach tabel istotne są [klucze głowne]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-g%C5%82%C3%B3wny) i [klucze obce]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-obcy). Tutaj jeszcze raz odsyłam Cię do artykułu opisującego [model relacyjny]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %})[^niewymagane].

[^niewymagane]: Złączeń można dokonywać na tabelach, które nie są połaczone między sobą kluczami obcymi. W praktyce nie zdarza się to za często. Upraszczając można powiedzieć, że klucze główne i klucze obce pomagają silinikom baz danych wykonywać złączenia, które są bardziej wydajne.

Znasz już dwa sposoby łączenia danych z wielu tabel. Iloczyn kartezjański i klauzle [`UNION` oraz `UNION ALL`]({% post_url 2018-09-04-sortowanie-aliasy-ograniczanie-wynikow-i-zwracanie-unikalnych-wartosci %}#scalanie-wynik%C3%B3w-wielu-zapyta%C5%84). O ile wyniki uzyskiwane przez złączenie wyników kilku zapytań mogą być przydatne to iloczyn karteznański zbyt użyteczny nie jest. SQL daje możliwość łączenia danych z wielu tabel na kilka innych sposobów.

Do uzyskania wszystkich rodzai złączeń podstawą jest iloczyn kartezjański. Z takiego iloczynu odrzucane są następnie wiersze, które "nie pasują" do złączenia danego typu[^optymalizacja].

[^optymalizacja]: Bazy danych mogą tu sporo optymalizować, dzięki czemu czasochłonne tworzenie iloczynu kartezjańskiego nie zawsze jest wykonywane. Jednak z punktu widzenia algebry relacji, podstawy modelu relacyjnego to właśnie iloczyn kartezjański jest punktem wyjścia.

### `INNER JOIN`

Podstawowym rodzajem złączenia jest `INNER JOIN`. W naszym przypadku może on służyć do zwrócenia imoin postaci i tytułów bajek:

```sql
SELECT postac.imie
      ,bajka.tytul
  FROM bajka
       INNER JOIN postac ON bajka.id = postac.bajka_id;
```

Zapytanie to łączy wiersze z tabeli `bajka` i `postac` wybierając tylko te dla których wartość kolumn `bajka.id` i `postac.bajka_id` jest równa:

    imie        tytul               
    ----------  --------------------
    Czika       101 Dalmatyńczyków
    Pongo       101 Dalmatyńczyków
    Wilma       Flinstonowie        
    Fred        Flinstonowie        
    Elka        Epoka lodowcowa     
    Maniek      Epoka lodowcowa     
    Migotka     Muminki             
    Muminek     Muminki      

Innym sposobem na uzyskanie tego samego wyniku jest takie zapytanie:

```sql
SELECT postac.imie
      ,bajka.tytul
  FROM bajka
      ,postac
 WHERE bajka.id = postac.bajka_id;
```

A co z brakującymi postaciami i bajkami? Zauważ, że wynik nie zawiera bajek takich jak "Jetsonowie", "Rozbójnik Rumcajs" czy "Smerfy". Brakuje także postaci "Maja", "Gucio", "Fiona" i "Shrek". Z pomocą przychodzą złączenia typu `OUTER JOIN`.

### `OUTER JOIN`

Istnieją trzy rodzaje złączeń typu `OUTER`:

 - `LEFT OUTER JOIN`,
 - `RIGHT OUTER JOIN`,
 - `FULL OUTER JOIN`.

#### `LEFT OUTER JOIN`
#### `RIGHT OUTER JOIN`

Niestety SQLite nie wspiera `RIGHT OUTER JOIN`. 
{:.notice--warning}

#### `FULL OUTER JOIN`

Niestety SQLite nie wspiera `FULL OUTER JOIN`. 
{:.notice--warning}

## `JOIN` tu, `JOIN` tam

Pamiętam, że na początku mnogość pojęć robiła mi niezły mętlik w głowie. Niektóre złączenia mają kilka nazw:

 - `JOIN` to to samo co `INNER JOIN`,
 - `LEFT JOIN` to to samo co `LEFT OUTER JOIN`,
 - `RIGHT JOIN` to to samo co `RIGHT OUTER JOIN`,
 - `FULL JOIN` to to samo co `FULL OUTER JOIN`,
 - `CROSS JOIN` to to samo co iloczyn kartezjański.

## Zadania do wykonania

### Przykładowe rozwiązania zadań

## Podsumowanie
