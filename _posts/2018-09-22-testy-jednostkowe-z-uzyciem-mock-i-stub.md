---
title: Testy jednostkowe z użyciem mock i stub
date: 2018-09-28 21:34:55 +0200
categories:
- Testy jednostkowe
- Dobre praktyki
permalink: /testy-jednostkowe-z-uzyciem-mock-i-stub/
header:
    teaser: /assets/images/2018/09/22_testy_z_mock_i_stub_w_jezyku_java.jpeg
    overlay_image: /assets/images/2018/09/22_testy_z_mock_i_stub_w_jezyku_java.jpeg
    caption: "[&copy; Sebastian Molina](https://unsplash.com/photos/gYo3B_9So3Y)"
excerpt: >
    W artykule tym przeczytasz o obiektach pomocniczych typu mock i stub używanych w testach jednostkowych. Poznasz różnice pomiędzy nimi. Zobaczysz przykłady takich obiektów. Dowiesz się dlaczego obiekty tego typu używane są w testach jednostkowych. Poznasz też bibliotekę Mockito, która pozwala na pisanie testów jednostkowych wykorzystujących te abstrakcje. Zapraszam do lektury.
---

## Wprowadzenie

Zanim przejdę do omówienia obiektów pomocniczych mock[^polski] i stub, muszę wyjaśnić kilka pojęć związanych z testami jednostkowymi.

[^polski]: Nie podoba mi się nadużywanie nazw anglojęzycznych w branży IT. Zawsze staram się znaleźć polskie odpowiedniki używanych słów. Są jednak takie sytuacje, w których terminy angielskie są tak rozpowszechnione, że nawet nie silę się na znajdowanie polskich odpowiedników. Przykładem takich słów są mock (atrapa?) czy stub (zaślepka?). Jeśli znasz dobre tłumaczenia tych określeń proszę podziel się nimi w komentarzach. Z chęcią zacznę stosować polskie słowa, które będą zrozumiałe w branżowych rozmowach.

### Jednostka w testach jednostkowych

W artykule [wprowadzającym do testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}) wspomniałem o definicji jednostki. Jednostka to fragment kodu, który testowany jest przy pomocy testów jednostkowych. W większości przypadków jest to pojedyncza klasa. 

Projekty programistyczne zawierają wiele klas. Klasy te, zgodnie z zasadą pojedynczej odpowiedzialności (ang. _Single Responsibility Principle_) będącą częścią [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}), powinny być odpowiedzialne za jedną funkcjonalność. W praktyce sprowadza się to do tego, że klasa posiada zależności, które pomagają tę funkcjonalność wykonać.

Na przykład klasa odpowiedzialna za wyszukanie najtańszego połączenia lotniczego pomiędzy Wrocławiem a Barceloną zależna jest od innych klas, które udostępniają ceny połączeń u różnych operatorów.

Klasa odpowiedzialna za wyszukanie najtańszego samochodu do wynajęcia porównuje oferty różnych agencji zajmujących się wynajmem.

Z kolei klasa odpowiedzialna za znalezienie najtańszej podróży może korzystać z obu wcześniej wspomnianych klas. Może to prowadzić do skomplikowanej sieci zależności.

{% include figure image_path="/assets/images/2018/09/22_hierarchia_klas.jpg" caption="Przykładowy diagram zależności klas" %}

### Granice jednostki

W takiej sieci każda klasa może być jednostką, która ma swój zestaw testów jednostkowych. Zależności klasy są poza granicami jednostki. 

Szczególnie jeśli wymagają dostępu do zewnętrznych źródeł danych, takich jak [baza danych]( {{ '/kurs-sql' | absolute_url }}), pliki na dysku twardym czy zewnętrze API udostępniane przez [HTTP]({% post_url 2018-02-08-protokol-http %}).

Test jednostkowy powinien testować wyłącznie jednostkę. Zależności będące poza nią nie powinny być testowane w testach jednostkowych [^inne]. Innymi słowy wszystko co jest poza granicami jednostki powinno być w trakcie testów "wyłączone".

[^inne]: Służą do tego inne rodzaje testów, na przykład testy integracyjne czy systemowe. 

Biorąc pod uwagę diagram, który pokazałem wcześniej testy jednostkowe klasy `TripPlanner` powinny odpowiednio obsłużyć zależność od klas `FlightScanner` i `CarRental`. Do odpowiedniego obsłużenia tego typu zależności w testach jednostkowych służą obiekty typu mock czy stub.

{% include newsletter-srodek.md %}

## Bohaterowie testów jednostkowych - mock i stub

Poniżej możesz zobaczyć przykładową klasę, która może być użyta do agregowania lotów udostępnianych przez różnych przewoźników:

```java
public interface Airline {
    List<Flight> findFlight(String departureAirport,
                            String destinationAirport,
                            LocalDate flightDate) throws FlightException;
}
```

```java
public class FlightScanner {

    private final Airline[] airlines;

    public FlightScanner(Airline... airlines) {
        this.airlines = airlines;
    }

    public Flight findCheapestFlight(String departure, String destination, LocalDate flightDate) {
        Optional<Flight> cheapestFlight = Arrays.stream(airlines)
                .map(a -> {
                    try {
                        return a.findFlight(departure, destination, flightDate);
                    } catch (FlightException e) {
                        // log
                        List<Flight> empty = Collections.emptyList();
                        return empty;
                    }
                })
                .flatMap(List::stream)
                .min(Comparator.comparing(Flight::getPrice));

        return cheapestFlight.orElse(null);
    }
}
```

Klasa `FlightScanner` używa wielu przewoźników. Zależność ta dostarczona jest w konstruktorze w formie tablicy obiektów implementujących interfejs `Airline`. Następnie w metodzie `findCheapestFlight` loty zwracane przez różnych przewoźników są agregowane. Metoda zwraca najtańszy lot spełniający warunki, albo `null` jeśli lot nie zostanie znaleziony.

Do utworzenia testów jednostkowych dla klasy `FlightScanner` potrzebne są instancje implementujące interfejs `Airline`. Rzeczywiste obiekty, które pobierają dane z linii lotniczych nie są dobrym pomysłem z kilku powodów:

- testy jednostkowe stają się testami integracyjnymi,
- testy jednostkowe zależą od stanu zewnętrznych usług, które czasami mogą nie działać,
- zewnętrzne usługi mogą zwracać różne dane w zależności od czasu ich wywołania,
- wydłuża się czas trwania testów jednostkowych (odpytywanie zewnętrznego API zabiera czas).

W związku z tymi wadami powstaje potrzeba zastąpienia rzeczywistej implementacji interfejsu `Airline` obiektem pomocniczym używanym wyłącznie w trakcie testów.

Samodzielne pisanie klas stub'ów czy mock'ów nie jest potrzebne. Przykłady, które tu pokazuję mają służyć wyłącznie zrozumieniu co dzieje się w trakcie użycia obiektów tego typu. W praktyce klasy te tworzone są w dużo prostszy sposób przy użyciu dedykowanych bibliotek. Jedną z nich, Mockito, opisuję w dalszej części artykułu.
{:.notice--warning}

### Czym jest stub?

Stub to obiekt, który w testach służy do imitowania właściwej implementacji. Jego zadaniem jest wyłącznie zwrócenie zadanej wartości. Przykładowy test jednostkowy używający kilku obiektów typu stub może wyglądać następująco:

```java
class FlightScannerTestStubs {

    private Airline stub1 = (departureAirport, destinationAirport, flightDate) -> Collections.singletonList(
        new Flight("AB1234", new BigDecimal(100), "WRO", "BCN")
    );

    private Airline stub2 = (departureAirport, destinationAirport, flightDate) -> Collections.singletonList(
        new Flight("AB2345", new BigDecimal(200), "WRO", "BCN")
    );

    private Airline stub3 = (departureAirport, destinationAirport, flightDate) -> { throw new FlightException("BOOM!"); };

    @Test
    void shouldFindLowestPrice() {
        FlightScanner flightScanner = new FlightScanner(stub1, stub2, stub3);
        assertThat(flightScanner.findCheapestFlight("not", "important", null).getFlightNumber(), is("AB1234"));
    }
}
```

Interfejs `Airline` jest [interfejsem funkcyjnym]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}#interfejs-funkcyjny). Dzięki temu w przykładzie mogłem użyć wyrażeń lambda. Instancje `stub1`, `stub2` i `stub3` zachowują się w ten sam sposób przy każdym ich wywołaniu.

Dzięki tym obiektom zastąpiłem zależności klasy `FlightScanner`. Wartości zwracane przez te obiekty użyte są do wyszukania najtańszego lotu. W tym przypadku kod najtańszego lotu to AB1234. Lot ten zwrócony jest przez obiekt `stub1`.

### Czym jest mock?

Mock to obiekt, którego używa się zamiast rzeczywistej implementacji w trakcie testów jednostkowych. Pozwala on na określenie jakich interakcji spodziewamy się w trakcie testów. Następnie można sprawdzić czy spodziewane interakcje rzeczywiście wystąpiły.

Przykładowa implementacja mock'a interfejsu `Airline` może wyglądać następująco:

```java
private static final class AirlineMock implements Airline {

    private static final class MethodInvocation {
        String departureAirport;
        String arrivalAirport;
        LocalDate flightDate;

        MethodInvocation(String departureAirport, String arrivalAirport, LocalDate flightDate) {
            this.departureAirport = departureAirport;
            this.arrivalAirport = arrivalAirport;
            this.flightDate = flightDate;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) {
                return true;
            }
            if (o == null || getClass() != o.getClass()) {
                return false;
            }
            MethodInvocation methodInvocation = (MethodInvocation) o;
            return Objects.equals(departureAirport, methodInvocation.departureAirport) &&
                    Objects.equals(arrivalAirport, methodInvocation.arrivalAirport) &&
                    Objects.equals(flightDate, methodInvocation.flightDate);
        }

        @Override
        public int hashCode() {
            return Objects.hash(departureAirport, arrivalAirport, flightDate);
        }
    }

    private final Set<MethodInvocation> invocations = new HashSet<>();

    void verifyCalled(String departureAirport, String destinationAirport, LocalDate flightDate) {
        boolean wasCalled = invocations.contains(new MethodInvocation(departureAirport, destinationAirport, flightDate));
        if (!wasCalled) {
            throw new AssertionError("One of the expected invocations wasn't called!");
        }
    }

    @Override
    public List<Flight> findFlight(String departureAirport, String destinationAirport, LocalDate flightDate) {
        invocations.add(new MethodInvocation(departureAirport, destinationAirport, flightDate));
        return Collections.emptyList();
    }
}
```

Teraz rozbiję ten kod na mniejsze fragmenty.

Klasa `AirlineMock` reprezentująca mock'a zwiera jeden atrybut - zbiór. Wewnątrz tego zbioru trzymane są parametry wywołań mock'a. Wartości zbioru reprezentowane są przez [klasę wewnętrzną]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}) `MethodInvocation`. Ta klasa grupuje parametry przekazywane do metody `findFlight` interfejsu `Airline`.

```java
private final Set<MethodInvocation> invocations = new HashSet<>();
```

Klasa `AirlineMock` implementuje interfejs `Airline`. Implementacja metody interfejsu `Airline` bazuje na wcześniej opisanym zbiorze. Każde wywołanie metody dodaje do tego zbioru parametry wywołania metody:

```java
@Override
public List<Flight> findFlight(String departureAirport, String destinationAirport, LocalDate flightDate) {
    invocations.add(new MethodInvocation(departureAirport, destinationAirport, flightDate));
    return Collections.emptyList();
}
```

Kluczowa w tej klasie jest metoda `verifyCalled`. To właśnie możliwość weryfikowania wywołań odróżnia mock'i od stub'ów:

```java
void verifyCalled(String departureAirport, String destinationAirport, LocalDate flightDate) {
    boolean wasCalled = invocations.contains(new MethodInvocation(departureAirport, destinationAirport, flightDate));
    if (!wasCalled) {
        throw new AssertionError("One of the expected invocations wasn't called!");
    }
}
```

Użycie mock'a w kodzie testu może wyglądać następująco:

```java
@Test
void shouldFindLowestPrice() {
    String departureAirport = "departure";
    String destinationAirport = "arrival";
    LocalDate day = LocalDate.of(2018, 9, 22);
    AirlineMock mock1 = new AirlineMock();
    AirlineMock mock2 = new AirlineMock();

    FlightScanner flightScanner = new FlightScanner(mock1, mock2);
    flightScanner.findCheapestFlight(departureAirport, destinationAirport, day);

    mock1.verifyCalled(departureAirport, destinationAirport, day);
    mock2.verifyCalled(departureAirport, destinationAirport, day);
}
```

Jak widzisz w teście sprawdzam czy zależności klasy `FlightScanner` zostały wywołane z odpowiednimi parametrami. Zależności w tym przypadku zastąpione były mock'ami:

```java
mock1.verifyCalled(departureAirport, destinationAirport, day);
mock2.verifyCalled(departureAirport, destinationAirport, day);
```

Musisz wiedzieć, że ta implementacja mock'a jest uproszczona. Biblioteki takie jak Mockito dostarczają implementacji mock'ów, która ma dużo większe możliwości. Przeczytasz o nich w dalszej części artykułu.

### Jaka jest różnica pomiędzy mock i stub?

Mock to stub na sterydach ;).

Wiesz już, że stub to obiekt, który podstawiasz w teście za właściwą implementację. Stub pozwala jedynie na określenie zachowania obiektu, który imituje.

Mock to  także obiekt, który podstawiasz w teście za właściwą implementację. W tym przypadku, poza określeniem zachowania[^uproszczenie] masz możliwość jego weryfikacji. Innymi słowy mock'i pozwalają sprawdzać czy dany obiekt został użyty, jakie metody były wywołane w trakcie testu, jakie parametry były użyte w trakcie tych wywołań.

[^uproszczenie]: Przykładowa implementacja mock'a zawiera jedynie możliwość weryfikacji wywołania metody. W ramach ćwiczeń możesz napisać klasę mock'a, która będzie pozwalała zarówno na określenie zachowania jak i sprawdzenie wywołań.

Te informacje pozwalają na pisanie testów, które sprawdzają otoczenie testowanej jednostki. Na przykład w trakcie wyszukiwania najtańszego lotu mock, który reprezentuje dostawcę połączeń pozwoli sprawdzić czy rzeczywiście dany dostawca został użyty, jakie parametry zostały mu przekazane.

Samodzielne pisanie klas mock'ów czy stub'ów jest uciążliwe, z pomocą przychodzą liczne biblioteki, które robią to automatycznie. Jedną z takich bibliotek jest Mockito.

## Biblioteka Mockito

Zanim przejdę do omówienia możliwości biblioteki Mockito proszę spójrz na ten sam test z jej wykorzystaniem:

```java
class FlightScannerTestMockito {
    @Test
    void shouldFindLowestPrice() throws FlightException {
        String departureAirport = "departure";
        String destinationAirport = "arrival";
        LocalDate day = LocalDate.of(2018, 9, 22);
        Airline mock1 = Mockito.mock(Airline.class);
        Airline mock2 = Mockito.mock(Airline.class);

        FlightScanner flightScanner = new FlightScanner(mock1, mock2);
        flightScanner.findCheapestFlight(departureAirport, destinationAirport, day);

        Mockito.verify(mock1).findFlight(departureAirport, destinationAirport, day);
        Mockito.verify(mock2).findFlight(departureAirport, destinationAirport, day);
    }
}
```

Celowo nie zastosowałem tu importów statycznych. W praktyce, po ich zastosowaniu test jest jeszcze krótszy. Cały narzut pisania dedykowanych klas spada na bibliotekę Mockito.

### Tworzenie mock'ów

Tworzenie mock'ów sprowadza się do wywołania metody metodę [`Mockito.mock()`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#mock-java.lang.Class-). Metoda ta przyjmuje klasę albo interfejs. Utworzony mock będzie miał typ przekazanej klasy albo interfejsu. Na przykład utworzenie mock'a dla interfejsu `Airline` sprowadza się do jednej linijki kodu:

```java
Airline mockedAirline = Mockito.mock(Airline.class);
```

Mockito wspiera także tworzenie mocków używając adnotacji [`@Mock`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mock.html). W zależności od wersji biblioteki JUnit do poprawnego działania tej adnotacji potrzebne są:

- JUnit 4: `@RunWith(MockitoJUnitRunner.class)` albo `@Rule` wraz z `MockitoJUnit.rule()`,
- Junit 5: `@ExtendWith(MockitoExtension.class)`.

W przykładzie poniżej Mockito automatycznie utworzy mock'a interfejsu `Airline`:

```java
@ExtendWith(MockitoExtension.class)
class MockitoExamplesTest {

    @Mock
    Airline airlineMock;

    @Test
    void shouldCreateMockInstance() {
        assertThat(airlineMock, is(notNullValue()));
    }
}
```

### Weryfikacja wywołań metod

Mockito pozwala na weryfikację wywołań utworzonych mock'ów. Służy do tego metoda [`Mockito.verify`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#verify-T-).  Proszę spójrz na przykład poniżej:

```java
@Test
void verifyExamples1() throws FlightException {
    airlineMock.findFlight("exactValue", "exactValue", LocalDate.now());

    verify(airlineMock).findFlight("exactValue", "exactValue", LocalDate.now());
}
```

Wewnątrz testu wywołuję metodę `findFlight`. Następnie weryfikuję wywołanie tej metody przekazując konkretny zestaw parametrów. Ten test się powiedzie ponieważ metoda z takimi parametrami została wywołana. Mockito pozwala na dużą dowolność w specyfikowaniu parametrów akceptowanych przez mock'i.

W tym przykładzie sprawdzam, czy metoda `findFlight` została wykonana co najwyżej 10 razy z dowolnymi argumentami:

```java
@Test
void verifyExamples2() throws FlightException {
    airlineMock.findFlight("exactValue", "exactValue", LocalDate.now());

    verify(airlineMock, atMost(10)).findFlight(anyString(), any(), any(LocalDate.class));
}
```

Tym razem sprawdzam, czy metoda `findFlight` została wywołana co najmniej raz z parametrami, które pasują do wymagań:

```java
@Test
void verifyExamples3() throws FlightException {
    airlineMock.findFlight("exactValue", "exactValue", LocalDate.now());

    verify(airlineMock, atLeastOnce()).findFlight(contains("Val"), startsWith("ex"), eq(LocalDate.now()));
}
```

Do weryfikacji liczby wywołań mogą służyć następujące metody:

- `Mockito.atMost`,
- `Mockito.atLeastOnce`,
- `Mockito.atLeast`,
- `Mockito.never`,
- `Mockito.times`,
- `Mockito.calls`.

Do weryfikacji parametrów mogą służyć następujące metody:

- `Mockito.anyString`,
- `Mockito.any`,
- `Mockito.contains`,
- `Mockito.matches`,
- `Mockito.startsWith`,
- `Mockito.anyCollection`,
- `Mockito.anyIterable`.

Metod tego typu jest dużo więcej. Po ich pełną listę odsyłam Cię do [dokumentacji biblioteki Mockito](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html).

### Stub czy mock?

Wiesz już, że mock to stub na sterydach. Mockito pozwala także na określanie zachowania mocków, nie tylko weryfikację wywołań. Mockito domyślnie tworzy stub'y dla wszystkich metod. Domyślnie zwracają one "wartości zerowe" (pusta kolekcja, 0, `null`). Przykład poniżej, pokazuje domyślne zachowanie Mockito:

```java
@Test
void whenExamples1() throws FlightException {
    List<Flight> flight = airlineMock.findFlight("a", "b", LocalDate.now());
    assertThat(flight, is(notNullValue()));
    assertThat(flight, is(empty()));
}
```

Możesz zmienić to w jaki sposób mock ma zareagować na wywołanie metody używając [`Mockito.when`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#when-T-). Poniższy przykład pokazuje jak przekonać Mockito do rzucenia wyjątku w odpowiednim momencie. Zwróć uwagę, że także tutaj użyłem metod do określania parametrów:

```java
@Test
void whenExamples2() throws FlightException {
    when(airlineMock.findFlight(any(), any(), any())).thenThrow(new FlightException("some message"));

    assertThrows(FlightException.class, () -> airlineMock.findFlight("a", "b", LocalDate.now()));
}
```

Poza rzucaniem wyjątków możesz określić właściwą wartość zwróconą po wywołaniu metody:

```java
@Test
void whenExamples3() throws FlightException {
    Flight someFlight = new Flight("ABC123", BigDecimal.TEN, "departure", "arriva");
    when(airlineMock.findFlight("a", "b", LocalDate.now()))
            .thenReturn(Collections.singletonList(someFlight));

    List<Flight> flight = airlineMock.findFlight("a", "b", LocalDate.now());
    assertThat(flight.size(), is(1));
    assertThat(flight.get(0), is(someFlight));
}
```

Do określenia zachowania mock'a możesz także użyć metod:
- [`Mockito.doReturn`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#doReturn-java.lang.Object-),
- [`Mockito.doThrow`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#doThrow-java.lang.Class-),
- [`Mockito.doNothing`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#doNothing--),
- [`Mockito.doAnswer`](https://static.javadoc.io/org.mockito/mockito-core/2.22.0/org/mockito/Mockito.html#doAnswer-org.mockito.stubbing.Answer-).

## Używanie mock'ów a higiena

Wszystko jest dla ludzi, jeśli stosowane jest w rozsądnych ilościach. Jeśli Twój test jednostkowy w przerażającej większości składa się z przygotowania obiektów typu mock czy stub to warto się mu bliżej przyjrzeć. Może jest tak, że Twoja klasa ma zbyt szeroką odpowiedzialność? Może warto wprowadzić dodatkowy typ, który będzie grupował część tych zadań? Może liczba zależności klasy jest zbyt duża?

Niestety nie potrafię podać Ci jasnej reguły, która mówi: jeśli obiektów mock masz więcej niż X to jest coś źle. Wydaje mi się, że takiej reguły nie ma. Jednak wiem, że testy jednostkowe, które naszpikowane są obiektami tego typu mogą być ciężkie w utrzymaniu.

Dlatego właśnie stosuj zasady higieny w pracy z mock'ami :). Jeśli Twoim subiektywnym zdaniem przygotowanie testu jednostkowego jest zbyt pracochłonne, wymaga zbyt dużo przygotowania, to zabierz się za refaktoring. Oczywiście sam refaktoring będzie łatwiejszy jeśli kod, który chcesz zmienić będzie już pokryty testami.

## Dodatkowe materiały do nauki

Jeśli chcesz poszerzyć wiedzę zdobytą po przeczytaniu tego artykułu zachęcam Cię do zajrzenia do tych źródeł:

- [Strona biblioteki JUnit](https://junit.org/junit5/),
- [Strona biblioteki Mockito](https://site.mockito.org/),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/33_testy_z_mock_stub_spy).

## Zadanie do wykonania

Napisz program, który będzie implementował następujący [interfejs]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}):

```java
public interface ExchangeApi {
    /**
     * @param date date for which exchange rate should be returned
     * @param currencyCode currency code that should be checked, for example USD
     * @return exchange rate between PLN and currencyCode on date
     */
    BigDecimal exchangeRate(LocalDate date, String currencyCode);
}
```

Twój program powinien używać API z historycznymi kursami walut udostępnionymi przez NBP. Dokumentacja API dostępna jest na [stronie NBP](http://api.nbp.pl/#kursyWalut). W praktyce potrzebny będzie wyłącznie ten adres: `http://api.nbp.pl/api/exchangerates/rates/a/<kod>/<data>/?format=json`

Na przykład, żeby pobrać kurs dla dolara amerykańskiego (kod waluty `USD`) dla 5 IV 2016 trzeba wysłać [zapytanie typu `GET`]({% post_url 2018-02-08-protokol-http %}) pod adres `http://api.nbp.pl/api/exchangerates/rates/a/usd/2016-04-05/?format=json`. Odpowiedź, którą dostaniesz będzie wyglądać następująco:

```json
{
    "table": "A",
    "currency": "dolar amerykański",
    "code": "USD",
    "rates": [{
        "no": "065/A/NBP/2016",
        "effectiveDate": "2016-04-05",
        "mid": 3.7337
    }]
}
```

Do parsowania odpowiedzi tego typu przydatna jest biblioteka, która obsługuje [parsowanie formatu JSON]({% post_url 2018-09-14-format-json-w-jezyku-java %}).

Postaraj się napisać program używając [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). Testy jednostkowe powinny używać obiektów typu mock i stub do symulowania zachowania API.

Jeśli będziesz mieć jakiekolwiek problemy zawsze możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/10_currency).

## Podsumowanie

Po przeczytaniu tego artykułu wiesz czym jest mock i stub. Na przykładzie potrafisz pokazać różnicę pomiędzy obiektami tego typu. Po rozwiązaniu zadania udało Ci się w praktyce sprawdzić swoją wiedzę zdobytą w tym artykule. 

Mam nadzieję, że artykuł przypadł Ci do gustu, daj znać w komentarzach jak użycie mock'ów i stub'ów wpływa na Twoje testy jednostkowe. Jeśli nie chcesz pominąć kolejnych wpisów proszę dopisz się do Samouczkowego Newslettera i polub Samouczka na Facebook'u.
