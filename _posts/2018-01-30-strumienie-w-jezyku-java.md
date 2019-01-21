---
title: Strumienie w języku Java
last_modified_at: 2019-01-10 22:58:06 +0100
categories:
- Kurs programowania Java
permalink: /strumienie-w-jezyku-java/
header:
    teaser: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    caption: "[&copy; AdamB1995](https://www.flickr.com/photos/150015896@N08/34409885560/sizes/l)"
excerpt: W artykule tym przeczytasz o strumieniach w języku Java. Dowiesz się czym są strumienie, poznasz podstawowe operacje na strumieniach. Wszystko jak zwykle poparte przykładami kodu. Zdobytą wiedzę będziesz mógł przećwiczyć rozwiązując przykładowe ćwiczenia.
---

{% capture wymagania %}
To jest jeden z artykułów w ramach [darmowego kursu programowania w Javie]({{ "/kurs-programowania-java" | absolute_url }}). Proszę zapoznaj się z pozostałymi częściami, mogą one być pomocne w zrozumieniu materiału z tego artykułu.

W szczególności potrzebna będzie wiedza na temat [kolekcji]({% post_url 2016-08-09-kolekcje-w-jezyku-java %}), [typów generycznych]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}) i [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
    {{ wymagania | markdownify }}
</div>

## Czym są strumienie

Strumienie służą do przetwarzania danych. Zawierają[^really] dane i pozwalają na opisanie co chcesz zrobić tymi danymi.

[^really]: To jest pewne uproszczenie. Strumienie nie muszą zwierać danych, które zwracają. Na przykład strumień generujący kolejne liczby pseudolosowe nie zawiera tych liczb, jedynie je generuje.

Dane mogą być przechowywane w kolekcji, mogą być wynikiem pracy z [wyrażeniami regularnymi]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}). W strumień możesz opakować praktycznie dowolny zestaw danych. Strumienie pozwalają w łatwy sposób zrównoleglić pracę na danych. Dzięki temu przetwarzanie dużych zbiorów danych może być dużo szybsze. Strumienie kładą nacisk na operacje jakie należy przeprowadzić na danych.

Niestety pojęcie strumienia jest dość szerokie. Możesz się z nim także spotkać w przypadku pracy z plikami. W tym artykule mówiąc o strumieniach mam na myśli klasy implementujące interfejs [`Stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html).
{: .notice--warning}

### Strumień na przykładzie

Proszę spójrz na przykład poniżej. Postaram się pokazać Ci dwa różne sposoby na zrealizowanie wymagań. Pierwszy ze sposobów będzie opierał się na [pętli]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}), drugi na strumieniach.

```java
public class BoardGame {
    public final String name;
    public final double rating;
    public final BigDecimal price;
    public final int minPlayers;
    public final int maxPlayers;

    public BoardGame(String name, double rating, BigDecimal price, int minPlayers, int maxPlayers) {
        this.name = name;
        this.rating = rating;
        this.price = price;
        this.minPlayers = minPlayers;
        this.maxPlayers = maxPlayers;
    }
}
```

Klasa `BoardGame` opisuje grę planszową. Przy jej pomocy możesz utworzyć listę gier:

```java
List<BoardGame> games = Arrays.asList(
    new BoardGame("Terraforming Mars", 8.38, new BigDecimal("123.49"), 1, 5),
    new BoardGame("Codenames", 7.82, new BigDecimal("64.95"), 2, 8),
    new BoardGame("Puerto Rico", 8.07, new BigDecimal("149.99"), 2, 5),
    new BoardGame("Terra Mystica", 8.26, new BigDecimal("252.99"), 2, 5),
    new BoardGame("Scythe", 8.3, new BigDecimal("314.95"), 1, 5),
    new BoardGame("Power Grid", 7.92, new BigDecimal("145"), 2, 6),
    new BoardGame("7 Wonders Duel", 8.15, new BigDecimal("109.95"), 2, 2),
    new BoardGame("Dominion: Intrigue", 7.77, new BigDecimal("159.95"), 2, 4),
    new BoardGame("Patchwork", 7.77, new BigDecimal("75"), 2, 2),
    new BoardGame("The Castles of Burgundy", 8.12, new BigDecimal("129.95"), 2, 4)
);
```

Lista `games` zawiera 10 tytułów gier planszowych. Pochodzą one z listy najbardziej popularnych gier według portalu [BGG](https://boardgamegeek.com/browse/boardgame)[^gry]. Załóżmy, że chciałbyś zrobić znajomemu prezent. Chcesz kupić grę, gra powinna spełniać następujące warunki:

- powinna pozwolić na grę w więcej niż 4 osoby,
- powinna mieć ocenę wyższą niż 8,
- powinna kosztować mniej niż 150 zł.

[^gry]: Sam bardzo często gram w planszówki ;). Grałem w większość wymienionych tu gier - mogę je z czystym sumieniem polecić.

Następnie chcesz wyświetlić nazwy gier spełniających takie wytyczne wielkimi literami. Warunki te możesz spełnić przy pomocy poniższego fragmentu kodu:

```java
for (BoardGame game : games) {
    if (game.maxPlayers > 4) {
        if (game.rating > 8) {
            if (new BigDecimal(150).compareTo(game.price) > 0) {
                System.out.println(game.name.toUpperCase());
            }
        }
    }
}
```

Prawda, że kod układa się w piękną strzałkę ;)? Taka struktura ma swoją nazwę: [_Arrow Anti-Pattern_](http://wiki.c2.com/?ArrowAntiPattern). Dobrze jest unikać tego typu zagnieżdżonych warunków. Jednym ze sposobów uniknięcia tego antywzorca może być użycie strumieni:

```java
games.stream()
    .filter(g -> g.maxPlayers > 4)
    .filter(g -> g.rating > 8)
    .filter(g -> new BigDecimal(150).compareTo(g.price) > 0)
    .map(g -> g.name.toUpperCase())
    .forEach(System.out::println);
```

Oba sposoby pozwalają na uzyskanie tych samych wyników. Drugi sposób wykorzystuje strumienie i [wyrażenia lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}). Operacje na strumieniach wykorzystując wzorzec łączenia metod (ang. [_method chaining_](https://en.wikipedia.org/wiki/Method_chaining)), zwany także płynnym interfejsem (ang. [_fluent interface_](https://en.wikipedia.org/wiki/Fluent_interface)).

Rozłożę teraz ten strumień na części pierwsze.

{% include newsletter-srodek.md %}

## Analiza przykładowego strumienia

Aby w ogóle mówić o operacjach na strumieniu należy go na początku utworzyć. W poprzednim przykładzie użyłem metody [`stream`](https://docs.oracle.com/javase/9/docs/api/java/util/Collection.html#stream--). Metoda ta jest [metodą domyślną]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}/#metody-domyślne) zaimplementowaną w interfejsie [`Collection`](https://docs.oracle.com/javase/9/docs/api/java/util/Collection.html). Pozwala ona na utworzenie strumienia na podstawie danych znajdujących się w danej kolekcji.

```java
Stream<BoardGame> gamesStream = games.stream();
```

Strumienie zostały wprowadzone w Java 8. W tej wersji także dodano możliwość dodawania metod domyślnych do interfejsów. Te domyślne implementacje metod pozwoliły na dodanie nowych funkcjonalności nie psując kompatybilności wstecz.
{: .notice--info}

Interfejs `Stream` jest [interfejsem generycznym]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}). Przechowuje on informację o typie, który aktualnie znajduje się w danym strumieniu. W przykładzie powyżej utworzyłem strumień `gamesStream` zawierający instancje klasy `BoardGame`. Strumień ten utworzyłem na podstawie [listy]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}).

Następnie filtruję strumień używając wyrażeń lambda. Zwróć uwagę na to, że każde wywołanie metody [`filter`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#filter-java.util.function.Predicate-) tworzy nową instancję klasy `Stream`. Każda linijka odpowiedzialna jest za filtr innego rodzaju. Pierwszy wybiera wyłącznie te gry, w które może grać więcej niż 4 graczy. Wśród tak odfiltrowanych gier następnie wybieram te, których ocena jest wyższa niż 8. Ostatnim zawężeniem jest wybranie gier, które kosztują mniej niż 150zł:

```java
Stream<BoardGame> filteredStream = gamesStream
    .filter(g -> g.maxPlayers > 4)
    .filter(g -> g.rating > 8)
    .filter(g -> new BigDecimal(150).compareTo(g.price) > 0);
```

W tym przypadku nie zapisywałem pośrednich strumieni do zmiennych. Zapisałem wyłącznie wynik, który otrzymam po użyciu wszystkich trzech filtrów. Następnie z każdej gry pobieram jej nazwę i zmieniam ją na pisaną wielkimi literami:

```java
Stream<String> namesStream = filteredStream
    .map(g -> g.name.toUpperCase());
```

Strumień `filteredStream` zawiera instancje klasy `BoardGame`, z każdej z tych instancji pobieram nazwę. Nazwa ta jest następnie zwracana. Dzięki temu powstaje nowy strumień. Tym razem strumień zawiera zmienne typu `String`.

Ostatnią fazą jest wyświetlenie tak wybranych danych. Używam do tego [odwołania do metody]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}/#odwoływanie-się-do-metod) `println`:

```java
namesStream.forEach(System.out::println);
```

## Operacje na strumieniu

Operacje związane ze strumieniami można podzielić na trzy rozłączne grupy:

- tworzenie strumienia,
- przetwarzanie danych wewnątrz strumienia,
- zakończenie strumienia.

Każdy strumień ma dokładnie jedną metodę, która go tworzy na podstawie danych źródłowych[^zrodlo]. Następnie dane te są przetwarzane przez dowolną liczbę operacji. Każda z tych operacji tworzy nowy strumień danych wywodzący się z poprzedniego. Na samym końcu strumień może mieć dokładnie jedną metodę kończącą pracę ze strumieniem.

[^zrodlo]: Dane źródłowe mogą także pochodzić z innego strumienia.

### Wymagania dla operacji

Każda z operacji wykonywanych na strumieniu musi spełniać jasno określone wymagania.

#### Nie posiada stanu

Operacja nie może posiadać stanu. Przykładem operacji, która taki stan posiada jest metoda `modify`:

```java
public class StatefullOperation {

    private final Set<Integer> seen = new HashSet<>();

    private int modify(int number) {
        if (seen.contains(number)) {
            return number;
        }
        seen.add(number);
        return 0;
    }

    public static void main(String[] args) {
        for (int i = 0; i < 3; i++) {
            Stream<Integer> numbers = Stream.of(1, 2, 3, 1, 2, 3, 1, 2, 3);
            StatefullOperation requriements = new StatefullOperation();
            int sum = numbers.parallel()
                .map(requriements::modify)
                .mapToInt(n -> n.intValue()).sum();
            System.out.println(sum);
        }
    }

}
```

Jeśli nie spełnisz tego wymagania może to prowadzić do dziwnych, niedeterministycznych wyników w trakcie równoległego przetwarzania strumienia danych (o przetwarzaniu równoległym przeczytasz w jednym z poniższych akapitów). Spróbuj uruchomić ten fragment wiele razy. Czy dostajesz takie same wyniki za każdym razem :)? Uwierz mi, nie chcesz szukać takich błędów w programach uruchomionych na środowisku produkcyjnym. Znam to, byłem tam, nie rób tego.

#### Nie modyfikuje źródła danych

Operacja nie może modyfikować źródła danych. Taka modyfikacja jest automatycznie wykryta w trakcie pracy ze strumieniem. Pokazuje ją poniższy fragment kodu:

```java
List<Integer> numbers = new ArrayList<>();
numbers.add(1);
numbers.add(2);

numbers.stream()
    .map(v -> numbers.add(v) ? 1 : 0)
    .forEach(System.out::println);
```

Uruchomienie tego kodu kończy się rzuceniem wyjątku:

    1
    Exception in thread "main" java.util.ConcurrentModificationException
    1
        at java.util.ArrayList$ArrayListSpliterator.forEachRemaining(ArrayList.java:1380)
        at java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:481)
        at java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:471)
        at java.util.stream.ForEachOps$ForEachOp.evaluateSequential(ForEachOps.java:151)
        at java.util.stream.ForEachOps$ForEachOp$OfRef.evaluateSequential(ForEachOps.java:174)
        at java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:234)
        at java.util.stream.ReferencePipeline.forEach(ReferencePipeline.java:418)
        at pl.samouczekprogramisty.kursjava.streams.requirements.InterferingOperation.main(InterferingOperation.java:15)

## Rodzaje operacji na strumieniach

### Tworzenie strumieni

Strumienie można tworzyć na wiele sposobów poniżej pokażę Ci kilka przykładów.

- Strumień na podstawie kolekcji:

```java
Stream<Integer> stream1 = new LinkedList<Integer>().stream();
```

- Strumień na podstawie tablicy:

```java
Stream<Integer> stream2 = Arrays.stream(new Integer[]{});
```

- Strumień na podstawie łańcucha znaków rozdzielanego przez wyrażenie regularne:

```java
Stream<String> stream3 = Pattern.compile(".").splitAsStream("some longer sentence");
```
- Strumień [typów prostych]({% post_url 2015-11-29-typy-proste-w-jezyku-java %}):

```java
DoubleStream doubles = DoubleStream.of(1, 2, 3);
IntStream ints = IntStream.range(0, 123);
LongStream longs = LongStream.generate(() -> 1L);
```

- Strumień danych losowych:

```java
DoubleStream randomDoubles = new Random().doubles();
IntStream randomInts = new Random().ints();
LongStream randomLongs = new Random().longs();
```

- Pusty strumień:

```java
Stream.empty();
```

- Strumień danych z pliku:

```java
try (Stream<String> lines = new BufferedReader(new FileReader("file.txt")).lines()) {
    // do something
}
```

Strumień danych z pliku musi być zamknięty. W przykładzie powyżej użyłem do tego konstrukcji [try-with-resources]({% post_url 2016-08-25-konstrukcja-try-with-resources-w-jezyku-java %}). Strumień możesz także zamknąć wywołując na nim metodę `close`.
{: .notice--warning}

### Operacje na strumieniach

Nie opiszę tutaj wszystkich metod dostępnych na strumieniach. Jeśli chcesz poznać ich więcej zachęcam do zapoznania się z [dokumentacją interfejsu `Stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html).

- [`filter`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#filter-java.util.function.Predicate-<S-Del>) - zwraca strumień zawierający tylko te elementy dla których filtr zwrócił wartość `true`,
- [`map`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#map-java.util.function.Function-) - każdy z elementów może zostać zmieniony do innego typu, nowy obiekt zawarty jest w nowym strumieniu,
- [`peek`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#peek-java.util.function.Consumer-) - pozwala przeprowadzić operację na każdym elemencie w strumieniu, zwraca strumień z tymi samymi elementami,
- [`limit`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#limit-long-) - zwraca strumień ograniczony do zadanej liczby elementów, pozostałe są ignorowane.

### Kończenie strumienia

Operacjami kończącymi są wszystkie, które zwracają typ inny niż `Stream`. Metody tego typu mogą także nie zwracać żadnych wartości.

- [`forEach`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#forEach-java.util.function.Consumer-) - wykonuje zadaną operację dla każdego elementu,
- [`count`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#count--) - zwraca liczbę elementów w strumieniu,
- [`allMatch`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#allMatch-java.util.function.Predicate-) - zwraca flagę informującą czy wszystkie elementy spełniają warunek. Przestaje sprawdzać na pierwszym elemencie, który tego warunku nie spełnia,
- [`collect`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#collect-java.util.stream.Collector-) - pozwala na utworzenie nowego typu na podstawie elementów strumienia. Przy pomocy tej metody można na przykład utworzyć listę. Klasa [`Collectors`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Collectors.html) zawiera sporo gotowych implementacji.

## Właściwości strumieni

### Leniwe rozstrzyganie

Strumienie są leniwe :). Oznacza to, że przetwarzają elementy dopiero po wykonaniu metody kończącej. Dodatkowo niektóre operacje powodują wcześniejsze zakończenie czytania danych ze strumienia. Przykładem takiej operacji jest `limit`. Poniższy przykład pokaże Ci dokładnie te właściwości:

```java
IntStream numbersStream = IntStream.range(0, 8);
System.out.println("Przed");
numbersStream = numbersStream.filter(n -> n % 2 == 0);
System.out.println("W trakcie 1");
numbersStream = numbersStream.map(n -> {
    System.out.println("> " + n);
    return n;
});
System.out.println("W trakcie 2");
numbersStream = numbersStream.limit(2);
System.out.println("W trakcie 3");
numbersStream.forEach(System.out::println);
System.out.println("Po");
```

Po uruchomieniu tego kodu na konsoli będziesz mógł zobaczyć:

    Przed
    W trakcie 1
    W trakcie 2
    W trakcie 3
    > 0
    0
    > 2
    2
    Po

Zauważ, że komunikaty "W trakcie X" zostały wyświetlone przed operacją `map`. Zwróć także uwagę na to, że przetwarzanie skończyło się po dwóch elementach. To sprawka metody `limit`.

### Przetwarzanie sekwencyjne i równoległe

Strumienie mogą być przetwarzane sekwencyjnie bądź równolegle. Metoda `stream` tworzy sekwencyjny strumień danych. Metoda `parallelStream` tworzy strumień, który jest uruchamiany jednocześnie na kilku wątkach. To ile wątków zostanie uruchomionych zależy od procesora.

Strumień sekwencyjny można przełączyć na równoległy wywołując na nim metodę [`parallel`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/BaseStream.html#parallel--). Odwrotna operacja także jest możliwa dzięki metodzie [`sequential`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/BaseStream.html#sequential--).

## Dobre praktyki

W tym paragrafie postaram się zebrać dobre praktyki ułatwiające pracę ze strumieniami danych.

### Filtrowanie na początku

W związku z tym, że operacje na strumieniach wykonywane są tylko wtedy gdy jest to konieczne warto ograniczyć liczbę elementów najwcześniej jak to możliwe. Dzięki takiej prostej operacji możemy znacząco ograniczyć liczbę elementów, na których wykonana będzie czasochłonna metoda. W przykładzie poniżej symuluję czasochłonne wykonanie przez `Thread.sleep(100)`. Wywołanie to "usypia" wątek na 100 milisekund [^przyklad]:

[^przyklad]: To tylko przykładowa metoda, w praktyce taka czasochłonna operacja może polegać na przykład na pobraniu danych z bazy danych czy z pliku na dysku.

```java
public static int timeConsumingTransformation(int number) {
    try {
        Thread.sleep(100);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    return number;
}
```
W pierwszym przykładzie czasochłonna metoda wykonana jest na każdej z liczb:

```java
int slowNumber = IntStream.range(1950, 2150)
        .map(StreamsGoodPractices::timeConsumingTransformation)
        .filter(n -> n == 2000)
        .sum();
```

Lepszym rozwiązaniem, może być odwrócenie kolejności tych operacji. W tym przypadku czasochłonna metoda zostanie wywołana wyłącznie na przefiltrowanych elementach:

```java
int fastNumber = IntStream.range(1950, 2150)
        .filter(n -> n == 2000)
        .map(StreamsGoodPractices::timeConsumingTransformation)
        .sum();
```

### Unikaj skomplikowanych wyrażeń lambda

Skomplikowane, wieloliniowe wyrażenie lambda może nie być czytelne. W takim przypadku, moim zdaniem, lepiej opakować kod w metodę i użyć odnośnika do metody wewnątrz strumienia. Proszę porównaj dwa poniższe przykłady

```java
IntStream.range(1950, 2150)
    .filter(y -> (y % 4 == 0 && y % 100 != 0) || y % 400 == 0)
    .forEach(System.out::println);
```

```java
IntStream.range(1950, 2150)
    .filter(StreamsGoodPractices::isLeapYear)
    .forEach(System.out::println);

public static boolean isLeapYear(int year) {
    boolean every4Years = year % 4 == 0;
    boolean notEvery100Years = year % 100 != 0;
    boolean every400Years = year % 400 == 0;

    return (every4Years && notEvery100Years) || every400Years;
}
```

Chociaż drugi przykład jest zdecydowanie dłuższy wydaje mi się, że jest tez bardziej czytelny. A czytelność kodu ma znaczenie :).

### Nie nadużywaj strumieni

Jak ktoś umie obsługiwać młotek to każdy problem wygląda jak gwóźdź. Strumienie są jednym ze sposobów rozwiązania problemu. To nie jest prawda, że znając strumienie powinieneś zapomnieć o pętlach. Dobrze jest znać oba mechanizmy. Poza tym, niektórych konstrukcji nie da się uzyskać przy pomocy strumieni. Przykładem mogą być tu niektóre pętle ze słówkiem kluczowym `break`.

## Strumienie to nie struktury danych

W poprzednich artykułach opisałem kilka struktur danych. Przykładem struktur danych może być [lista wiązana]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}) czy [mapa]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}). Strumienie nie są strukturą danych. W odróżnieniu od struktur nie służą do przechowywania danych. Strumienie jedynie pomagają określić operacje, które na tych danych chcesz wykonać.

Mówi się, że strumienie pozwalają w deklaratywny sposób opisać operacje na danych. Można to uprościć do stwierdzenia, że struktury służą do przechowywania danych a strumienie służą do opisywania algorytmów, operacji na danych.

## Zadania

Na koniec przygotowałem dla Ciebie kilka zadań do rozwiązania, które pomogą Ci utrwalić wiedzę zdobytą w tym artykule:

1. Przerób poniższy fragment kodu tak żeby używał strumieni:
```java
double highestRanking = 0;
BoardGame bestGame = null;
for (BoardGame game : BoardGame.GAMES) {
    if (game.name.contains("a")) {
        if (game.rating > highestRanking) {
            highestRanking = game.rating;
            bestGame = game;
        }
    }
}
System.out.println(bestGame.name);
```
2. Znajdź minimalny element w kolekcji używając strumieni i funkcji [`reduce`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#reduce-java.util.function.BinaryOperator-). Twoja funkcja powinna działać jak istniejąca funkcja [`min`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#min-java.util.Comparator-).
3. Używając metody [`flatMap`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#flatMap-java.util.function.Function-) napisz strumień, który "spłaszczy" listę list.

Jak zwykle zachęcam Cię do samodzielnego rozwiązania zadań, wtedy nauczysz się najwięcej. Jeśli jednak będziesz miał z czymś kłopot możesz rzucić okiem do [przykładowych rozwiązań](https://github.com/SamouczekProgramisty/KursJava/tree/master/30_strumienie/src/main/java/pl/samouczekprogramisty/kursjava/streams/exercise), które przygotowałem.

## Dodatkowe materiały do nauki

Poniżej zebrałem dla Ciebie kilka dodatkowych źródeł, które pozwolą spojrzeć Ci na temat strumieni z innej strony.

- [Bardzo dobra dokumentacja pakietu `java.util.stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/package-summary.html),
- [Część I tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html),
- [Część II tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/architect-streams-pt2-2227132.html),
- [Szczegółowy opis strumieni - Baeldung](http://www.baeldung.com/java-8-streams),
- [Kod źródłowy użyty w tym artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/30_strumienie/src/main/java/pl/samouczekprogramisty/kursjava/streams).

## Podsumowanie

Strumienie wraz z wyrażeniami lambda to bardzo użyteczne narzędzie. Po lekturze artykułu wiesz już czym są strumienie i jak z nimi pracować. Potrafisz utworzyć strumień i zaaplikować do niego zestaw operacji. Znasz dobre praktyki pracy ze strumieniami. Rozwiązując ćwiczenia utrwaliłeś wiedzę z artykułu w praktyce.

Na koniec mam do Ciebie prośbę. Podziel się linkiem do artykułu ze swoimi znajomymi jeśli ten artykuł był dla Ciebie wartościowy. Jeśli nie chcesz pominąć kolejnych artykułów na blogu dopisz się do samouczkowego newslettera i polub profil Samouczka Programisty na Facebooku. Do następnego razu!
