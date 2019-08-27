---
title: Format JSON w języku Java
last_modified_at: 2019-02-27 22:57:33 +0100
categories:
- Narzędzia
- Kurs aplikacji webowych
permalink: /format-json-w-jezyku-java/
header:
    teaser: /assets/images/2018/09/13_format_json_w_jezyku_java.jpg
    overlay_image: /assets/images/2018/09/13_format_json_w_jezyku_java.jpg
    caption: "[&copy; xresch](https://pixabay.com/en/analytics-information-innovation-3088958/)"
excerpt: Artykuł opisuje sposoby pracy z formatem JSON w języku Java. Po lekturze będziesz wiedzieć czym jest format JSON, gdzie jest używany i dlaczego zyskał na popularności. Poznasz dwie specyfikacje z parasola JEE – JSON-P i JSON-B i dowiesz się jak ich używać. Zapraszam do lektury.
---

## Czym jest JSON

JSON (ang. _JavaScript Object Notation_) to format zapisu i wymiany danych. Jest to format tekstowy. Uważany jest za format czytelny zarówno dla maszyn jak i dla ludzi. 

Dane formatowane przy użyciu JSON mogą być określane się jako [`application/json`](https://www.iana.org/assignments/media-types/application/json). Ta wartość może być zawarta w [nagłówkach HTTP]({% post_url 2018-02-08-protokol-http %}#nag%C5%82%C3%B3wki-http) określając typ akceptowanych/wysyłanych danych.

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

 W związku ze swoją prostotą JSON nie wspiera przestrzeni nazw (ang. _namespace_). Weryfikacja schematu dokumentu możliwa jest przy użyciu dodatkowych narzędzi: [JSON Schema](https://json-schema.org) lub [JSchema](http://jschema.org). JSON często porównywany jest z [formatem XML]({% post_url 2017-03-02-xml-dla-poczatkujacych %}) gdzie zarówno schemat jak przestrzenie nazw są wspierane. Faktem jest, że format JSON zawojował Internet. Stało się tak między innymi dzięki popularności języka JavaScript, z którego ten format się wywodzi.

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

Łańcuchy znaków jakie są każdy widzi ;). Łańcuch znaków to ciąg znaków otoczony `"`. Dodatkowo znak `\` pozwala na wprowadzenie znaków specjalnych. Na przykład `\"` oznacza cudzysłów, a `\` ukośnik. Kilka przykładowych wartości:

- `"some value"`,
- `"zażółć gęślą jaźń"`,
- `"true"`,
- `"\\""`, reprezentuje łańcuch znaków `\"`.

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

Element tego typu grupuje uporządkowaną listę wartości. Składa się on z nawiasów `[` i `]`. Wewnątrz nich znajdują się wartości oddzielone `,`. Wartości wewnątrz listy mogą być różnych typów[^podobnie]:

[^podobnie]: Tutaj sprawa wygląda podobnie jak w obiektach, specyfikacja dopuszcza takie zachowanie jednak w praktyce nie jest to często spotykane.

```json
[1, true, "true"]
```

#### Liczba

Liczby w formacie JSON to ciąg cyfr. Opcjonalnie poprzedzony znakiem `-`. Do oddzielenia części ułamkowej od całkowitej służy `.`. Notacja naukowa jest dopuszczalna. Oto kilka prawidłowych liczb w formacie JSON:

- `123`,
- `123.123`,
- `-123`,
- `1.23123e2`,
- `1.23123E-2`.

#### Literały

W formacie JSON występują trzy literały:

- `true` – reprezentuje wartość logiczną – prawdę,
- `false` – reprezentuje wartość logiczną – fałsz,
- `null` – reprezentuje wartość pustą, brak wartości.

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

## JSON-P

{% capture notice %}
Wszystkie fragmenty kodu użyte w tym artykule udostępnione są na [Samouczkowym Githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/32_format_json/src/main/java/pl/samouczekprogramisty/kursjava/json). Zachęcam Cię do eksperymentów i uruchomienia kodu samodzielnie.

Zwróć też uwagę na zależności wspomniane w pliku [`build.gradle`](https://github.com/SamouczekProgramisty/KursJava/blob/master/32_format_json/build.gradle). Część klas użytych we fragmentach poniżej nie jest dostępna w standardowej bibliotece Javy.
{% endcapture %}

<div class="notice--info">
  {{ notice | markdownify }}
</div>

JSON-P jest specyfikacją, która opisuje przetwarzanie formatu JSON. Zakłada przetwarzanie dokumentów JSON zarówno w całości jak i w trybie strumieniowym (nie trzeba załadować całego dokumentu do pamięci). Pozwala na parsowanie i generowanie dokumentów w formacie JSON. Specyfikacja JSON-P 1.1 jest częścią JEE 8.

### Tryb "obiektowy"

Decydując się na tryb obiektowy musisz zbudować cały obiekt przed przekształcaniem go do formatu JSON. 

#### Zapis

Tworzenie instancji klas odpowiadających typom formatu JSON polega na wywołaniu odpowiednich metod udostępnionych przez klasy [`JsonArrayBuilder`]({{ site.doclinks.javax.json.JsonArrayBuilder }}) i [`JsonObjectBuilder`]({{ site.doclinks.javax.json.JsonObjectBuilder }}). Instancje tych klas tworzone są przez [`JsonBuilderFactory`]({{ site.doclinks.javax.json.JsonBuilderFactory }}). Proszę spójrz na przykład poniżej:

```java
JsonBuilderFactory builderFactory = Json.createBuilderFactory(Collections.emptyMap());
JsonObject publicationDateObject = builderFactory.createObjectBuilder()
        .add("rok", 2018)
        .add("miesiąc", 9)
        .add("dzień", 13).build();

System.out.println(publicationDateObject.toString());
```

W przykładzie tym tworzę obiekt, który ma trzy atrybuty: `rok`, `miesiąc` i `dzień`. Po uruchomieniu takiego fragmentu kodu na konsoli wyświetli się dokument w formacie JSON:

```json
{"rok":2018,"miesiąc":9,"dzień":13}
````

Bardziej skomplikowany przykład możesz zobaczyć poniżej. Używam w nim dokładnie tego samego API łącząc ze sobą różne obiekty. W wyniku działania tego kodu powstaje zagnieżdżona struktura obiektów:

```java
JsonBuilderFactory builderFactory = Json.createBuilderFactory(Collections.emptyMap());
JsonObject publicationDateObject = builderFactory.createObjectBuilder()
        .add("rok", 2018)
        .add("miesiąc", 9)
        .add("dzień", 13).build();

JsonObject articleObject = builderFactory.createObjectBuilder()
        .add("tytuł", "Format JSON w języku Java")
        .add("data publikacji", publicationDateObject).build();

JsonArray articlesArray = builderFactory.createArrayBuilder().add(articleObject).build();

JsonObject webPageObject = builderFactory.createObjectBuilder()
        .add("adres www", "https://www.samouczekprogramisty.pl")
        .add("artykuły", articlesArray).build();

JsonObject authorObject = builderFactory.createObjectBuilder()
        .add("imię", "Marcin")
        .add("nazwisko", "Pietraszek")
        .add("strona", webPageObject).build();
```

Tym razem użyję trochę innej metody wypisywania obiektu. Tworząc instancję [`JsonWriterFactory`]({{ site.doclinks.javax.json.JsonWriterFactory }}) mogę przekazać konfigurację. Konfiguracja wpływa na zachowanie tej klasy. 

```java
Map<String, ?> config = Collections.singletonMap(JsonGenerator.PRETTY_PRINTING, true);
JsonWriterFactory writerFactory = Json.createWriterFactory(config);
writerFactory.createWriter(System.out).write(authorObject);
```

Dzięki takiemu podejściu wynik wypisywany na konsoli jest sformatowany w bardziej czytelny sposób:

```json
{
    "imię": "Marcin",
    "nazwisko": "Pietraszek",
    "strona": {
        "adres www": "https://www.samouczekprogramisty.pl",
        "artykuły": [
            {
                "tytuł": "Format JSON w języku Java",
                "data publikacji": {
                    "rok": 2018,
                    "miesiąc": 9,
                    "dzień": 13
                }
            }
        ]
    }                                                                                                                                    
}
```

{% include newsletter-srodek.md %}

#### Odczyt

Każdy z przykładów poniżej używa instancji `InputStream`, którą tworzę w sposób pokazany poniżej. Metoda `buildObject` zwraca `JsonObject`, który pokazałem w poprzednim paragrafie:

```java
String jsonObject = buildObject().toString();
InputStream inputStream = new ByteArrayInputStream(jsonObject.getBytes());
```

Odczyt dokumentów w formacie JSON używa podobnego API. Tym razem tworzę instancję klasy [`JsonReaderFactory`]({{ site.doclinks.javax.json.JsonReaderFactory }}). Używam jej do utworzenia instancji [`JsonReader`]({{ site.doclinks.javax.json.JsonReader }}):

```java
JsonReaderFactory readerFactory = Json.createReaderFactory(Collections.emptyMap());
JsonReader jsonReader = readerFactory.createReader(inputStream);
```

Klasa `JsonReader` udostępnia kilka metod, które pozwalają na odczyt danych w formacie JSON:

* `readObject`,
* `readArray`,
* `readValue`,
* `read`.

Używając publicznych metod udostępnionych w klasach `JsonObject` i `JsonArray` poruszam się po dokumencie JSON:

```java
try (JsonReader jsonReader = readerFactory.createReader(new ByteArrayInputStream(jsonDocument.getBytes()))) {
    JsonObject jsonObject = jsonReader.readObject();
    System.out.println(jsonObject
                    .getJsonObject("strona")
                    .getJsonArray("artykuły")
                    .get(0).asJsonObject()
                    .getJsonObject("data publikacji")
    );
}
```

Powyższy fragment kodu wyświetli na konsoli jeden z zagnieżdżonych obiektów:

```java
{"rok":2018,"miesiąc":9,"dzień":13}
```

Istnieje jednak prostszy sposób na dotarcie do tego samego obiektu. Można posłużyć się ścieżką jak w przykładzie poniżej:

```java
JsonReaderFactory readerFactory = Json.createReaderFactory(Collections.emptyMap());
try (JsonReader jsonReader = readerFactory.createReader(new ByteArrayInputStream(jsonDocument.getBytes()))) {
    JsonStructure jsonStructure = jsonReader.read();
    System.out.println(jsonStructure.getValue("/strona/artykuły/0/data publikacji"));
}
```

### Tryb strumieniowy

Tryb strumieniowy pozwala na odczyt/zapis dokumentów w formacie JSON bez ładowania ich w całości do pamięci. Dane są odczytywane lub zapisywane na bieżąco.

#### Zapis

W przypadku zapisu fabryka [`JsonGeneratorFactory`]({{ site.doclinks.javax.json.stream.JsonGeneratorFactory }}) pomaga w tworzeniu [`JsonGenerator`]({{ site.doclinks.javax.json.stream.JsonGenerator }}). Instancja tej klasy pisze do strumienia poszczególne tokeny (elementy składowe dokumentu w formacie JSON). metody `write*` pozwalają na zapis danych do strumienia. Przykład poniżej zapisuje do strumienia dokładnie ten sam dokument JSON jaki użyłem w podejściu obiektowym:

```java
JsonGeneratorFactory generatorFactory = Json.createGeneratorFactory(Collections.singletonMap(JsonGenerator.PRETTY_PRINTING, true));
JsonGenerator generator = generatorFactory.createGenerator(System.out);
generator
    .writeStartObject()
        .write("imię", "Marcin")
        .write("nazwisko", "Pietraszek")
        .writeStartObject("strona")
            .write("adres www", "https://www.samouczekprogramisty.pl")
            .writeStartArray("artykuły")
                .writeStartObject()
                    .write("tytuł", "Format JSON w języku Java")
                    .writeStartObject("data publikacji")
                        .write("rok", 2018)
                        .write("miesiąc", 9)
                        .write("dzień", 13)
                    .writeEnd()
                .writeEnd()
            .writeEnd()
        .writeEnd()
    .writeEnd().flush();
```

#### Odczyt

W przypadku czytania dokumentu w trybie strumieniowym przydadzą się klasy [`JsonParserFactory`]({{ site.doclinks.javax.json.JsonParserFactory }}) i [`JsonParser`]({{ site.doclinks.javax.json.JsonParser }}). Instancja tej ostatniej pozwala na sprawdzenie czy w strumieniu znajduje się kolejny token. Jeśli tak, można go pobrać i odpowiednio na niego zareagować. Poniżej możesz zobaczyć przykład odczytywania dokumentu JSON w trybie strumieniowym:

```java
JsonParserFactory parserFactory = Json.createParserFactory(Collections.emptyMap());
JsonParser parser = parserFactory.createParser(buildObject());

while (parser.hasNext()) {
    JsonParser.Event event = parser.next();
    switch (event) {
        case START_OBJECT:
            System.out.println("{");
            break;
        case END_OBJECT:
            System.out.println("}");
            break;
        case START_ARRAY:
            System.out.println("[");
            break;
        case END_ARRAY:
            System.out.println("]");
            break;
        case KEY_NAME:
            System.out.print(String.format("\"%s\": ", parser.getString()));
            break;
        case VALUE_NUMBER:
            System.out.println(parser.getBigDecimal());
            break;
        case VALUE_STRING:
            System.out.println(String.format("\"%s\"", parser.getString()));
            break;
        default:
            System.out.println("true, false or null");
    }
}
```

W wyniku działania tego kodu na konsoli wyświetli się dokument:

```json
{
"imię": "Marcin"
"nazwisko": "Pietraszek"
"strona": {
"adres www": "https://www.samouczekprogramisty.pl"
"artykuły": [
{
"tytuł": "Format JSON w języku Java"
"data publikacji": {
"rok": 2018
"miesiąc": 9
"dzień": 13
}
}
]
}
}
```

Jak widzisz formatowanie tu kuleje :). Może spróbujesz napisać to w taki sposób, żeby dokument był bardziej czytelny?

## JSON-B

JSON-B to specyfikacja, która pozwala na mapowanie dokumentów w formacie JSON i obiektów w języku Java. Pozwala na konfigurowanie sposobu mapowania obiektów na dokumenty przy pomocy [adnotacji]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}). Specyfikacja JSON-B 1.0 jest częścią JEE 8.

JSON-B pozwala na [serializację i deserializację]({% post_url 2016-09-02-serializacja-w-jezyku-java %}) stanu obiektu używając formatu JSON.

### Zapis obiektu

Zacznę od zwykłej klasy, dla czytelności usunąłem metody dostępowe (gettery i settery):

```java
public class Newspaper {
    private String title;
    private int circulation;
    private LocalDate issueDate;

    @SuppressWarnings("unused")
    public Newspaper() {
    }

    public Newspaper(String title, int circulation, LocalDate issueDate) {
        this.title = title;
        this.circulation = circulation;
        this.issueDate = issueDate;
    }

    // getters & setters
}
```

Aby zapisać instancję tego obiektu do formatu JSON należy użyć [`JsonBuilder`]({{ site.doclinks.javax.json.bind.JsonBuilder }}) do stworzenia instancji klasy [`Jsonb`]({{ site.doclinks.javax.json.bind.Jsonb }}). W większości przypadków ta instancja powinna być współdzielona w całej aplikacji. 

Klasa `Jsonb` posiada zestaw przeciążonych metod `toJson`, które pozwalają na serializację obiektu. Przykład poniżej używa jednej z tych metod:

```java
Newspaper newspaper = new Newspaper("Samouczek Programisty", 100_000, LocalDate.of(2018, 9, 13));
Jsonb jsonb = JsonbBuilder.create();
String newspaperRepresentation = jsonb.toJson(newspaper);
System.out.println(newspaperRepresentation);
```

Po wykonaniu tego fragmentu kodu na konsoli wyświetli się tekst:


```json
{"circulation":100000,"issueDate":"2018-09-13","title":"Samouczek Programisty"}
```

### Odczyt obiektu

Odczyt (deserializacja) przebiega w podobny sposób. Tym razem należy użyć metody `fromJson` do odczytania dokumentu JSON. Zauważ, że drugim parametrem przekazywanym do tej metody jest klasa/typ nowotworzonego obiektu:

```java
Newspaper newspaper = new Newspaper("Samouczek Programisty", 100_000, LocalDate.of(2018, 9, 13));
Jsonb jsonb = JsonbBuilder.create();
String newspaperRepresentation = jsonb.toJson(newspaper);

Newspaper otherNewspaper = jsonb.fromJson(newspaperRepresentation, Newspaper.class);
System.out.println(otherNewspaper.getIssueDate());
```

W wyniku działania tego kodu na konsoli wyświetli się data pobrana z dokumentu JSON:

    2018-09-13

### Modyfikacja zachowania JSON-B

JSON-B pozwala na modyfikację jego zachowania. Dzięki temu dokument, który jest tworzony/czytany może różnić się od obiektu w języku Java. Klasa `AnnotationExamples` zawiera kilka adnotacji wpływających na kształt dokumentu JSON:

```java
@JsonbPropertyOrder({"ccc", "bbb"})
public class AnnotationExamples {
    @JsonbTransient
    private String skipped;

    @JsonbProperty(nillable=true)
    private String a1;

    private String a2;

    @JsonbNumberFormat("0.0000")
    private double bbb;

    @JsonbProperty("other_name")
    private String ccc;

    // getters & setters
}
```

* [`@JsonbTransient`]({{ site.doclinks.javax.json.bind.annotation.JsonbTransient }}) – atrybut powinien zostać pomięty,
* [`@JsonbProperty`]({{ site.doclinks.javax.json.bind.annotation.JsonbProperty }}) – pozwala na ustawienie nowej nazwy atrybutu. Zmienia zachowanie (de)serializacji jeśli atrybut ma wartość `null` (domyślnie takie wartości są pomijane),
* [`@JsonbNumberFormat`]({{ site.doclinks.javax.json.bind.annotation.JsonbNumberFormat }}) – określa format w jakim powinna być zapisana liczba,
* [`@JsonbDateFormat`]({{ site.doclinks.javax.json.bind.annotation.JsonbDateFormat }}) – określa format w jakim powinna być zapisana data.
* [`@JsonbPropertyOrder`]({{ site.doclinks.javax.json.bind.annotation.JsonbPropertyOrder }}) – określa kolejność w jakiej atrybuty powinny być serializowane.

Pozostałe adnotacje znajdziesz w [dokumentacji]({{ site.doclinks.javax.json.bind.annotation._package }}).

Miejsce umieszczenia adnotacji ma znaczenie:

- adnotacja nad atrybutem – ma wpływ zarówno na serializację jak i deserializację atrybutu,
- adnotacja nad getterem – ma wpływ wyłącznie na serializację atrybutu,
- adnotacja nad setterem – ma wpływ wyłącznie na deserializację atrybutu.

Proszę spójrz jak adnotacje wpływają na kształt generowanego dokumentu:

```java
AnnotationExamples annotationExamples = new AnnotationExamples();
annotationExamples.setBbb(123.45);
annotationExamples.setCcc("ccc");
annotationExamples.setSkipped("skipped");

WithoutAnnotationExamples withoutAnnotationExamples = new WithoutAnnotationExamples();
withoutAnnotationExamples.setBbb(123.45);
withoutAnnotationExamples.setCcc("ccc");
withoutAnnotationExamples.setSkipped("skipped");
```

Klasa z adnotacjami:
```json
{"other_name":"ccc","bbb":"123.4500","a1":null}
```

Klasa bez adnotacji:
```json
{"bbb":123.45,"ccc":"ccc","skipped":"skipped"}
```

Adnotacje pozwalają na zmianę zachowana JSON-B w trakcie kompilacji. Istnieje także metoda na wprowadzenie takich zmian wyłącznie w trakcie uruchomienia programu.

## `json_pp`

Nie mogę tu pominąć `json_pp`. Jest to narzędzie używane w linii poleceń. Co prawda nie jest ono bezpośrednio związane z Javą ani specyfikacjami, które tu opisałem, jednak jest bardzo przydatne. Program ten formatuje dokument JSON wyświetlając go w bardziej czytelnej formie. Nie raz pomogło mi przy pracy z tym formatem:

    $ echo '{"some":"magic","json":true,"values":123}' | json_pp
    {
       "json" : true,
       "values" : 123,
       "some" : "magic"
    }

## Dodatkowe materiały do nauki

Jeśli chcesz dowiedzieć się czegoś więcej na temat formatu JSON zachęcam Cię do sięgnięcia po materiały dodatkowe:

* [Specyfikacja JSON](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf) specyfikacja ma kod 404 – kod odpowiedzi Not Found w specyfikacji [protokołu HTTP]({% post_url 2018-02-08-protokol-http %}#statusy-4xx) :),
* [Artykuł o JSON na Wikipedii](https://en.wikipedia.org/wiki/JSON),
* [Specyfikacja JSON-P]({{ site.doclinks.specs.jsonp }}),
* [Dokumentacja API JSON-P]({{ site.doclinks.javax.json.jsonp_overview }}),
* [Specyfikacja JSON-B]({{ site.doclinks.specs.jsonb }}),
* [Dokumentacja API JSON-B]({{ site.doclinks.javax.json.jsonb_overview }}).

Na pewno przyda Ci się też [kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/32_format_json/src/main/java/pl/samouczekprogramisty/kursjava/json).

## Zadanie do wykonania

Znajdź API udostępnione za pośrednictwem [protokołu HTTP]({% post_url 2018-02-08-protokol-http %})(S), które używa formatu JSON. Napisz program, który wyśle zapytanie do wybranego przez Ciebie API i przetworzy otrzymaną odpowiedź. Proszę daj znać w komentarzach, które API chcesz użyć. Jeśli masz problem ze znalezieniem API możesz użyć jednego z tych, które są zebrane na [samouczkowym Github'ie](https://github.com/SamouczekProgramisty/public-apis).

Możesz także rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/blob/master/10_currency/src/main/java/pl/samouczekprogramisty/szs/currency/NbpApi.java), w którym użyłem [API NBP](http://api.nbp.pl/). Program, który napisałem pobiera średni kurs wymiany waluty dla zadanego dnia. Dzięki niemu możesz na przykład sprawdzić jaki był średni kurs USD/PLN w zadanym dniu.

## Podsumowanie

Po przeczytaniu tego artykułu wiesz już czym jest JSON. Potrafisz stworzyć poprawny dokument w tym formacie. Wiesz jak używać specyfikacji z parasola JEE odpowiedzialnych za pracę z formatem JSON. Obecnie większość znanych mi API udostępnionych za pośrednictwem [HTTP]({% post_url 2018-02-08-protokol-http %}) używa formatu JSON do wymiany danych. Po lekturze możesz swobodnie używać tych API z poziomu języka Java. Gratulacje! :)

Na koniec mam do Ciebie prośbę. Proszę podziel się linkiem do artykułu ze znajomymi, którym może się on przydać. Dzięki Tobie uda mi się dotrzeć do nowych czytelników. Jeśli nie chcesz ominąć kolejnych artykułów proszę dopisz się do samouczkowego newslettera i polub stronę Samouczka na Facebook'u. Do następnego razu!
