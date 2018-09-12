---
title: Format JSON w języku Java
categories:
- Narzędzia
- Kurs aplikacji webowych
permalink: /format-json-w-jezyku-java/
header:
    teaser: /assets/images/2018/09/04_sql.jpg
    overlay_image: /assets/images/2018/09/04_sql.jpg
    caption: "[&copy; Micheile Henderson](https://unsplash.com/photos/1SjD5ZEiUsA)"
excerpt: Artykuł opisuje sposoby pracy z formatem JSON w języku Java. Po lekturze będziesz wiedzieć czym jest format JSON, gdzie jest używany i dlaczego zyskał na popularności. Poznasz dwie specyfikacje z parasola JEE - JSON-P i JSON-B i dowiesz się jak ich używać. Zapraszam do lektury.
---

## Czym jest JSON

JSON (ang. _JavaScript Object Notation_) to format zapisu i wymiany danych. Jest to format tekstowy. Uważany jest za format czytelny zarówno dla maszyn jak i dla ludzi. 

Dane formatowane przy użyciu JSON określa się jako [`application/json`](https://www.iana.org/assignments/media-types/application/json). Ta wartość może być zawarta w [nagłówkach HTTP]({% post_url 2018-02-08-protokol-http %}#nag%C5%82%C3%B3wki-http) określając typ akceptowanych/wysyłanych danych.

Poniżej możesz zobaczyć prawidłowy dokument w formacie JSON:

```json
{
   "timestamp" : 1536731522,
   "event_type" : "jump-to-menu-activation",
   "measures" : {
      "filter_count" : 77,
      "result_count" : 25,
      "display_count" : 7
   },
   "dimensions" : {
      "query" : "test",
      "actor_id" : 73585,
      "session_id" : "b5c50e56-75ce-50cb-9d44-7cbba93b00e5",
      "display_set" : [
         [
            "Repository",
            106327483
         ],
         [
            "Repository",
            42456996
         ]
      ]
   }
}
```

To co widzisz powyżej to część zapytania, które wysyłane jest w trakcie wyszukiwania na Github'ie. W momencie wpisywania czegokolwiek w wyszukiwarkę strona wysyła zapytanie, którego ciało jest w formacie JSON. Fragment powyżej zawiera obiekt, który ma 4 atrybuty:

- `timestamp`, którego wartością jest liczba,
- `event_type`, którego wartością jest łańcuch znaków,
- `measures` i `dimensions`, których wartościami są inne obiekty.

 W związku ze swoją prostotą JSON nie pozwala na opisywanie schematu dokumentu. Nie wspiera także przestrzeni nazw (ang. _namespace_). JSON często porównywany jest z [formatem XML]({% post_url 2017-03-02-xml-dla-poczatkujacych %}) gdzie zarówno schemat jak przestrzenie nazw są wspierane. Mimo tych braków JSON zawojował Internet. Stało się to między innymi dzięki popularności języka JavaScript.

## Opis formatu JSON

JSON to bardzo prosty format zapisu/wymiany danych. Specyfikacja formatu JSON to jedna z przyjemniejszych specyfikacji jakie czytałem, jest przyjemna bo zawiera jedynie 5 stron tekstu ;). W formacie występuje sześć symboli, które określają strukturę dokumentu:

* `{` i `}`,
* `[` i `]`,
* `:`,
* `,`.

W formacie tym występują tylko trzy "słowa kluczowe", literały:

* `true`,
* `false`,
* `null`.

Białe znaki (tabulator, znak nowej linii[^nowalinia] czy spacja) są ignorowane. Zatem dwa poniższe dokumenty JSON są równoważne:

[^nowalinia]: Chodzi tu o dwa osobne znaki: nową linię i powrót karetki.

```json
{
    "coś": "jeszcze coś"
}
```
```json
{"coś":"jeszcze coś"}
```

### Wspierane typy danych

#### Łańcuch znaków

Łańcuchy znaków jakie są każdy widzi ;). Łańcuch znaków to ciąg znaków otoczony `"`. Dodatkowo znak `\` pozwala na wprowadzenie znaków specjalnych. Na przykład `\"` oznacza cudzysłów, a `\\` ukośnik. Kilka przykładowych wartości:

- `"some value"`,
- `"zażółć gęślą jaźń"`,
- `"true"`,
- `"\\\""`, reprezentuje łańcuch znaków `\"`.

#### Obiekt

Element tego typu składa się z nawiasów `{` i `}`. Wewnątrz nawiasów umieszczone są pary w postaci: `"nazwa atrybutu": <wartość atrybutu>`. `<wartość atrybutu>` może być dowolną wspieraną wartością. Nazwa atrybutu przedstawiona jest jako łańcuch znaków. Pary oddzielone są od siebie `,`. Kolejność par nie ma znaczenia. Specyfikacja nie narzuca unikalności kluczy[^praktyka].

[^praktyka]: W praktyce nie spotkałem się ze zduplikowanymi kluczami.

```json
{
    "attribute": "value",
    "other attribute": 123
}
```

#### Lista

Element tego typu grupuje uporządkowaną listę wartości. Składa się on z nawiasów `[` i `]`. Wewnątrz nich znajdują się wartości oddzielone `,`. Wartości wewnątrz listy mogą być różnych typów

```json
[1, true, "true"]
```
#### Numer

Numery w formacie JSON to ciąg cyfr. Opcjonalnie poprzedzony znakiem `-`. Do odzielenia części ułamkowej od całkowitej służy `.`. Notacja naukowa jest dopuszczalna. Oto kilka prawidłowych liczb w formacie JSON:

- `123`,
- `123.123`,
- `-123`,
- `1.23123e2`,
- `1.23123E-2`.

#### Literały

W formacie JSON występują trzy literały:

- `true` - reprezentuje wartość logiczną - prawdę,
- `false` - reprezentuje wartość logiczną - fałsz,
- `null` - reprezentuja wartość pustą, brak wartości.

### Element główny

Specyfikacja formatu JSON nie narzuca typu elementu głównego. Oznacza to tyle, że zgodnie ze specyfikacją poniższe dokumenty są poprawne:

```json
[1, 2, 3]
```

```json
true
```

```json
"some string"
```

Mimo braku takiego wymogu przyjęło się, że elementem głównym dokumentu w tym formacie zawsze jest obiekt. Poniżej znajdziesz "poprawną" reprezentację przykładów, które przytoczyłem wyżej:

```json
{
    "x": [1, 2, 3]
}
```

```json
{
    "y": true
}
```

```json
{
    "z": "some string"
}
```

{% include newsletter-srodek.md %}

## JSON w języku Java

### JSON-P

JSON-P jest specyfikacją, która opisuje przetważanie formatu JSON. Zakłada przetwarzanie dokumentów JSON w trybie strumieniowym (nie trzeba załadować całego dokumentu do pamięci). Pozwala na parsowanie i generowanie dokumentów w formacie JSON. Specyfikacja JSON-P 1.1 jest częścią JEE 8.

### JSON-B

JSON-B to specyfikacja, która pozwala na mapowanie dokumentów w formacie JSON i obietów w języku Java. Pozwala na konfigurowanie sposobu mapowania obiektów na dokumenty przy pomocy [adnotacji]({% 2016-10-03-adnotacje-w-jezyku-java %}). Specyfikacja JSON-B 1.0 jest częścią JEE 8.

## `json_pp`

Nie mogę tu pominąć `json_pp`. Jest to narzędzie używane w linii poleceń, które formatuje dokument JSON wyświetlając go w bardziej czytelnej formie. Nie raz pomogło mi przy pracy z tym formatem:

    $ echo '{"some": "magic", "json": true, "values": 123}' | json_pp
    {
       "json" : true,
       "values" : 123,
       "some" : "magic"
    }

## Dodatkowe materiały do nauki

Jeśli chcesz dowiedzieć się czegoś więcej na temat formatu JSON zachęcam Cię do sięgnięcia po materiały dodatkowe:

* [Specyfikacja JSON](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf) specyfikacja ma kod 404 - kod odpowiedzi Not Found w specyfikacji [protokołu HTTP]({% post_url 2018-02-08-protokol-http %}#statusy-4xx),
* [Artykuł o JSON na Wikipedii](https://en.wikipedia.org/wiki/JSON),
* [Specyfikacja JSON-B](https://jcp.org/aboutJava/communityprocess/final/jsr367/index.html),
* [Specyfikacja JSON-P](https://jcp.org/aboutJava/communityprocess/final/jsr374/index.html).

## Podsumowanie
