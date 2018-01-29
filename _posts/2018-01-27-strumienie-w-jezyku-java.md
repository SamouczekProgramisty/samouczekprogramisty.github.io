---
title: Strumienie w języku Java
categories:
- Kurs programowania Java
permalink: /strumienie-w-jezyku-java/
header:
    teaser: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    caption: "[&copy; AdamB1995](https://www.flickr.com/photos/150015896@N08/34409885560/sizes/l)"
excerpt: Stumyki
---

{% capture wymagania %}
To jest jeden z artykułów w ramach [darmowego kursu programowania w Javie]({{ "/kurs-programowania-java" | absolute_url }}). Proszę zapoznaj się z pozostałymi częściami, mogą one być pomocne w zrozumieniu materiału z tego artykułu.

W szczególności potrzebna będzie wiedza na temat [kolekcji]({% post_url 2016-08-09-kolekcje-w-jezyku-java %}), [typów generycznych]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}) i [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
    {{ wymagania | markdownify }}
</div>

## Czym są strumienie

Strumienie służą do przetwarzania danych. Dane mogą być przechowywane w kolekcji, mogą być wynikem pracy z [wyrażeniami regularnymi]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}). W strumień możesz opakować praktycznie dowolny zestaw danych. Strumienie pozwalają w łatwy spobób zrównoleglić pracę na danych. Dzięki temu przetwarzanie dużych zbiorów danych może być dużo szybsze.

Niestety pojęcie strumeinia jest dość szerokie. Możesz się z nim także spotkać w przypadku pracy z plikami. W przypadku plików także mówimy o strumieniu danych. W artykule tym mówiąc o strumieniach mam na myśli klasy implementujące interfejs [`Stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html).
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

`BoardGame` opisuje grę planszową. Przy jej pomocy możesz utworzyć listę gier:

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

Prawda, że kod układa się w piękną strzałkę ;)? Taka struktura ma nawet swoją nazwę: [_Arrow Anti-Pattern_](http://wiki.c2.com/?ArrowAntiPattern). Dobrze jest unikać tego typu zagnieżdżonych warunków. Jednym ze sposobów uniknięcia tego antywzorca może być użycie strumieni:

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

## Analiza przykładowego strumienia

Aby w ogóle mówić o operacjach na strumieniu należy go na początku utworzyć. W poprzednim przykładzie użyłem metody [`stream`](https://docs.oracle.com/javase/9/docs/api/java/util/Collection.html#stream--). Metoda ta jest [metodą domyślną]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}/#metody-domyślne) zaimplementowaną w interfejsie [`Collection`](https://docs.oracle.com/javase/9/docs/api/java/util/Collection.html). Pozwala ona na utworzenie strumienia na podstawie danych znajdujących się w danej kolekcji.

```java
Stream<BoardGame> gamesStream = games.stream();
```

Strumienie zostały wprowadzone w Java 8. W tej wersji także dodano możliwość dodawania metod domyślnych do interfejsów. Te domyślne implementacje metod pozwoliły na dodanie nowych funkcjonalności nie psując kompatybilności wstecz.
{: .notice--info}

Interfejs `Stream` jest [interfejsem generycznym]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}). Przechowuje on informację o typie, który aktualnie znajduje się w danym strumieniu. W przykładzie powyżej utworzyłem strumień `gamesStream` zawierający instancje klasy `BoardGame`. Strumień ten utworzyłem na podstawie [listy]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}).

Następnie filtruję strumień używając wyrażeń lambda. Zwróć uwagę na to, że gażde wywołąnie metody [`filter`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/Stream.html#filter-java.util.function.Predicate-) tworzy nową instancję klasy `Stream`. Każda linijka odpowiedzialna jest za filtr innego rodzaju. Pierszy wybiera wyłącznie te gry, w które może grać więcej niż 4 graczy. Wśród tak odfiltrowanych gier następnie wybieram te, których ocena jest wyższa niż 8. Ostatnim zawężeniem jest wybranie gier, które kosztują mniej niż 150zł:

```java
Stream<BoardGame> filteredStream = gamesStream
    .filter(g -> g.maxPlayers > 4)
    .filter(g -> g.rating > 8)
    .filter(g -> new BigDecimal(150).compareTo(g.price) > 0);
```

W tym przypadku nie zapisywałem pośrednich strumieni do zmiennych. Zapisałem wyczłącznie wynik, który otrzymam po użyciu wszystkich trzech filtrów. Następnie z każdej gry pobieram jej nazwę i zmieniam ją na pisaną wielkimi literami:

```java
Stream<String> namesStream = filteredStream
    .map(g -> g.name.toUpperCase());
```

Zwróć uwagę na to, że strumień `filteredStream` zawiera instancje klasy `BoardGame`, z każdej z tych instancji pobieram nazwę. Nazwa ta jest następnie zwracana. Dzięki temu powstaje nowy strumień. Tym razem strumień zawiera zmienne typu `String`.

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

#### Nie posida stanu

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

Tutaj sprawa jest prostsza, taka modyfikacja jest wykryta w trakcie pracy ze strumieniem. Pokazuje ją poniższy fragment kodu:

```java
List<Integer> numbers = new ArrayList<>();
numbers.add(1);
numbers.add(2);

numbers.stream()
    .map(v -> numbers.add(v) ? 1 : 0)
    .forEach(System.out::println);
```

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


## Właściwości strumieni

### Leniwe rozstrzyganie

### Przetwarzanie sekwencyjne i równoległe
stream/parallel stream

#### Przełączanie pomiędzy poszczególnymi trybami
parallel/sequential switches


Tematy do poruszenia:
stream peek
allMatch 

stream to nie pętla - break nie działa
stream for array
stream to comma sepparated string
stream sort
predicate
stream duplicates
spliterator
flatten list of lists
short circuit
flatMap
IntStream DoubleStream LongStream
collect(groupingBy(
zwięzłe metody - dobre praktyki
zrównoleglenie, wielowątkowość za darmo
Function.identity()
intermididate vs terminal operations
unordered
"don't change" the source - zmieniają obiekty niemutowalne
Ograniczanie na początku
mapToInt
Streams.iterate
Streams.generate

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

### Unikaj skomplkikowanych wyrażeń lambda

Skomplikowane, wielolinijkowe wyrażenie lambda może nie być czytelne. W takim przypadku, moim zdaniem, lepiej opakować kod w standarową metodę i użyć odnośnika do metody wewnątrz strumienia. Proszę porównaj dwa poniższe przykłady

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

Jak ktoś umie obsługiwac młotek to każdy problem wygląda jak gwóźdź. Strumienie są jednym ze sposobów rozwiązania problemu. To nie jest prawda, że znając strumienie powinieneś zapomnieć o pętlach. Dobrze jest znać oba mechanizmy. Poza tym, niektórych konstrukcji nie da się uzyskać przy pomocy strumieni. Przykładem mogą być tu niektóre pętle ze słówkiem kluczowym `break`.

"mutation of the shared state" - zła praktyka
List<String> rtsGames = new ArrayList<String>(); 
List<Game> games = null
games.stream()
  .filter(g -> g.getGenere() == Genere.RTS)
  .map(Game::getName)
  .forEach(name -> rtsGames.add(name)); 

dobra praktyka
List<Game> games = null
List<String>rtsGames = games.stream()
  .filter(g -> g.getGenere() == Genere.RTS)
  .map(Game::getName)
  .collect(Collectors.toList()); 

Tworzenie strumieni
- Arrays.stream
- Patern.combile().steram
- Collection.stream()
- File.stream()
- Stream.empty()
- IntStream LongStream DoubleStream
- Random.stream

## Strumienie to nie struktury danych

W poprzednich artykułach opisałem kilka struktur danych. Przykładem struktur danych może być [lista wiązana]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}) czy [mapa]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}). Strumienie nie są strukturą danych. W odróżnieniu od struktur nie służą do przechowywania danych. Strumienie jedynie pomagają określić operacje, które na tych danych chcesz wykonać. 

Mówi się, że strumienie pozwalają w deklaratywny sposób opisać operacje na danych. Można to uprościć do stwierdzenia, że struktury służą do przechowywania danych a strumienie służą do opisywania algorytmów, operacji na danych.

## Zadanie

Na koniec przygotowałem dla Ciebie kilka zadań do rozwiązania, które pomogą Ci utrwalić wiedzę zdobytą w tym artykule:

- Przerób poniższ fragment kodu tak żeby kod używał strumieni,
  ...
- Znajdz minimalny elment w kolekcji używając strumieni i funkcji reduce. Twoja funkcja powinna działać jak isteniejąca funkcja min.

## Dodatkowe materiały do nauki

Poniżej zebrałem dla Ciebie kilka dodatkowych źródeł, które pozwolą spojrzeć Ci na temat strumieni z innej strony. 

- [Bardzo dobra dokumentacja pakietu `java.util.stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/package-summary.html),
- [Wykład na temat strumieni autorstwa dr Krzysztofa Barteczki](https://pja.mykhi.org/2sem/GUI/wyklady_barteczko/wykl4/Html/strumienie.htm)[^nauka],
- [Część I tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html),
- [Część II tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/architect-streams-pt2-2227132.html),
- [Szczegółowy opis strumieni - Baeldung](www.baeldung.com/java-8-streams).

[^nauka]: Sam Javy w 2008 roku uczyłem się z książek właśnie tego autora :). Pamiętam, że były dużo bardziej przystępne niż _Thinking in Java_ ;).

## Podsumowanie


