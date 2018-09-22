---
title: Testy jednostkowe z użyciem mock i stub
categories:
- Testy jednostkowe
- Dobre praktyki
permalink: /testy-jednostkowe-z-uzyciem-mock-i-stub/
header:
    teaser: /assets/images/2018/09/22_testy_z_mock_i_stub_w_jezyku_java.jpeg
    overlay_image: /assets/images/2018/09/22_testy_z_mock_i_stub_w_jezyku_java.jpeg
    caption: "[&copy; Sebastian Molina](https://unsplash.com/photos/gYo3B_9So3Y)"
excerpt: >
    W artykule tym przeczytasz o obiekach pomocniczych typu _mock_ i _stub_ użwanych w testach jednostkowych. Poznasz różnice pomiędzy nimi. Zobaczysz przykłady takich obiektów. Dowiesz się dlaczego obiekty tego typu używane są w testach jednostkowych. Poznasz też bibliotekę Mockito, która pozwala na pisanie testów jednostkowych wykorzystujących te abstrakcje. Zapraszam do lektury.
---

{% capture popolsku %}
Nie podoba mi się używanie nazw anglojęzycznych w branży IT. Zawsze staram się znaleźć polskie odpowiedniki używanych słów. Są jednak takie sytuacje, w których terminy angielskie są tak rozpowszechnione, że nawet nie silę się na znajdowanie polskich odpowiedników.

Przykładem takich słów są _mock_ (atrapa?) czy _stub_ (zaślepka?). Jeśli znasz dobre tłumaczenia tych określeń proszę podziel się nimi w komentarzach. Z chęcią zacznę stosować polskie słowa, które będą zrozumiałe w branżowych rozmowach.
{% endcapture %}

<div class="notice--info">
    {{ popolsku | markdownify }}
</div>

## Wprowadzenie

Zanim przejdę do omówienia obiektów pomocniczych _mock_ i _stub_, muszę wyjaśnić kilka pojęć związanych z testami jednostkowymi.

### Jednostka w testach jednostkowych

W artykule [wprowadzającym do testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}) wspomniałem o definicji jednostki. Jednostka to fragment kodu, który testowany jest przy pomocy testów jednostkowych. W większości przypadków jest to pojedyncza klasa. 

Projekty programistyczne zawierają wiele klas. Klasy te, zgodnie z zasadą pojedynczej odpowiedzialności (ang. _Single Responsibility Principle_) będącą częścią [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}), powinny być odpowiedzialne za jedną funkcjonalność. W praktyce sprowadza się to do tego, że klasa posiada zależności, które pomagają tę funkjonalność wykonać.

Na przykład klasa odpowiedzialna za wyszukanie najtańszego połączenia lotniczego pomiędzy Wrocławiem a Barceloną zależna jest od innych klas, które udostępniają ceny połączeń u różnych operatorów.

Klasa odpowiedzialna za wyszukanie najtańszego samochodu do wynajęcia porównuje oferty różnych agencji zamjmujących się wynajmem.

Z kolei klasa odpowiedzialna za znalezienie najtańszej podróży może korzystać z obu wcześniej wspomnianych klas. Może to prowadzić do skomplikowanej sieci zależności.

{% include figure image_path="/assets/images/2018/09/22_hierarchia_klas.jpg" caption="Przykładowy diagram zależności klas" %}

### Granice jednostki

W takiej sieci każda klasa może być jednostką, która ma swój zestaw testów jednostkowych. Zależności klasy są poza granicami jednostki. 

Szczególnie jeśli wymagają dostępu do zewnętrznych źródeł danych, takich jak [baza danych]( {{ '/kurs-sql' | absolute_url }}), pliki na dysku twardym czy zewnętrze API udostępniane przez [HTTP]({% post_url 2018-02-08-protokol-http %}).

Test jednostkowy powinien testować wyłącznie jednostkę. Zależności będącę poza nią nie powinny być testowane w testach jednostkowych [^inne]. Innymi słowy wszystko co jest poza granicami jednostki powinno być w trakcie testów "wyłączone".
[^inne]: Służą do tego inne rodzaje testów, na przykład testy integracyjne czy systemowe. 

Biorąc pod uwagę diagram, który pokazałem wcześniej testy jednostkowe klasy `TripPlanner` powinny odpowiednio osbsłużyć zależność od klas `FlightScanner` i `CarRental`. Do odpowiedniego obsłużenia tego typu zależności w testach jednostkowych służą obiekty typu _mock_ czy _stub_.

## Bohaterowie testów jednostkowych - _mock_ i _stub_

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
- wydłuża się czas trwania testów jednostkowych (odpytywanie zewnętrznego API zabiera czas).

W związku z tymi wadami powstaje potrzeba zastąpienienia rzeczywisej implementacji interfejsu `Airline` obiektem pomocniczym używanym wyłącznie w trakcie testów.

Samodzielne pisanie klas _stub'ów_ czy _mock'ów_ nie jest potrzebne. Przykłady, które tu pokazuję mają służyć wyłącznie zrozumieniu co dzieje się w trakcie użycia obiektów tego typu. W praktyce klasy te tworzone są w dużo prostszy sposób przy użyciu dedykowanych bibliotek. Jedną z nich, Mockito, opisuję w dalszej części artykułu.
{:.notice--warning}

### Czym jest _stub_?

_Stub_ to obiekt, który w testach służy do imitowania właściwej implementacji. Jego zadaniem jest wyłącznie zwrócenie zadanej wartości. Przykładowy test jednostkowy używający kilku obiektów typu _stub_ może wyglądać następująco:

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

Dzięki tym obiektom zastąpiłem zależności klasy `FlightScanner`.

### Czym jest _mock_?

_Mock_ to obiekt, którego używa się zamiast rzeczywistej implementacji w trakcie testów jednostkowych. Pozwala on na określenie jakich interakcji spodziewamy się w trakcie testów. Następnie można sprawdzić czy spodziewane interakcje rzeczywiście wytąpiły.

Przykładowa implementacja _mock'a_ interfejsu `Airline` może wyglądać następująco:

```java
private static final class AirlineMock implements Airline {

    private static final class Key {
        String departureAirport;
        String arrivalAirport;
        LocalDate flightDate;

        public Key(String departureAirport, String arrivalAirport, LocalDate flightDate) {
            this.departureAirport = departureAirport;
            this.arrivalAirport = arrivalAirport;
            this.flightDate = flightDate;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Key key = (Key) o;
            return Objects.equals(departureAirport, key.departureAirport) &&
                    Objects.equals(arrivalAirport, key.arrivalAirport) &&
                    Objects.equals(flightDate, key.flightDate);
        }

        @Override
        public int hashCode() {
            return Objects.hash(departureAirport, arrivalAirport, flightDate);
        }
    }

    private static final class Value {
        List<Flight> returnValue;
        boolean wasCalled;

        public Value(List<Flight> returnValue) {
            this.returnValue = returnValue;
        }
    }

    private final Map<Key, Value> invocations = new HashMap<>();

    AirlineMock expectedCall(String departureAirport, String destinationAirport, LocalDate flightDate, Supplier<List<Flight>> result) {
        invocations.put(new Key(departureAirport, destinationAirport, flightDate), new Value(result));
        return this;
    }

    void verifyCalls() {
        boolean allInvocationsCalled = invocations.values().stream().allMatch(v -> v.wasCalled);
        if (!allInvocationsCalled) {
            throw new AssertionError("One of the expected invocations wasn't called!");
        }
    }

    @Override
    public List<Flight> findFlight(String departureAirport, String destinationAirport, LocalDate flightDate) throws FlightException {
        Value value = invocations.get(new Key(departureAirport, destinationAirport, flightDate));
        if (value == null) {
            return Collections.emptyList();
        }
        value.wasCalled = true;
        return value.returnValue.get();
    }
}
```

Teraz rozbiję ten kod na mniejsze fragmenty.

Klasa `AirlineMock` reprezentująca _mock'a_ zwiera jeden atrybut - mapę. Wewnątrz tej mapy trzymane są spodziewane parametry wywołania _mock'a_ i generowana odpowiedź. Klucz reprezentowany przez [wewnętrzną klasę]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}) `Key` grupuje parametry przekazywane do metody `findFlights` interfejsu `Airline`. Wartość reprezentowana przez klasę `Value` zawiera wartość zwróconą z wywołania tej metody.

```java
private final Map<Key, Value> invocations = new HashMap<>();
```

Klasa `AirlineMock` implementuje interfejs `Airline`. Implementacja metody interfejsu `Airline` bazuje na wcześniej opisanej mapie. Każde wywołanie metody oznacza czy spodziewane wywołania _mock'a_ rzeczywiście miały miejsce:

```java
@Override
public List<Flight> findFlight(String departureAirport, String destinationAirport, LocalDate flightDate) throws FlightException {
    Value value = invocations.get(new Key(departureAirport, destinationAirport, flightDate));
    if (value == null) {
        return Collections.emptyList();
    }
    value.wasCalled = true;
    return value.returnValue.get();
}
```

Kluczowa w tej klasie jest metoda `verifyCalls`. To właśnie możliwość weryfikowania wywołań odróżnia _mock'i_ od _stub'ów_.

```java
void verifyCalls() {
    boolean allInvocationsCalled = invocations.values().stream().allMatch(v -> v.wasCalled);
    if (!allInvocationsCalled) {
        throw new AssertionError("One of the expected invocations wasn't called!");
    }
}
```

Użycie _mock'a_ w kodzie testu może wyglądać następująco:

```java
public class FlightScannerTestMocks {

    @Test
    void shouldFindLowestPrice() {
        LocalDate day = LocalDate.of(2018, 9, 22);
        String departureAirport = "departure";
        String destinationAirport = "arrival";
        AirlineMock mock1 = new AirlineMock()
                .expectedCall(
                        departureAirport + " ",
                        destinationAirport,
                        day,
                        Collections.singletonList(
                                new Flight(
                                        "XX1234",
                                        new BigDecimal(400),
                                        departureAirport,
                                        destinationAirport
                                )
                        )
                );

        AirlineMock mock2 = new AirlineMock()
                .expectedCall(
                        departureAirport,
                        destinationAirport,
                        day,
                        Collections.singletonList(
                                new Flight(
                                        "AA7777",
                                        new BigDecimal(100),
                                        departureAirport,
                                        destinationAirport
                                )
                        )
                );

        FlightScanner flightScanner = new FlightScanner(mock1, mock2);
        assertThat(flightScanner.findCheapestFlight(departureAirport, destinationAirport, day).getFlightNumber(), is("AA7777"));
        mock1.verifyCalls();
        mock2.verifyCalls();
    }
}
```

Jak widzisz poza sprawdzeniem czy zwrócony został lot z najniższą ceną weryfkuję także, to, że zależności klasy `FlightScanner` zostały wywołane:

```java
assertThat(flightScanner.findCheapestFlight(departureAirport, destinationAirport, day).getFlightNumber(), is("AA7777"));
mock1.verifyCalls();
mock2.verifyCalls();
```

### Jaka jest różnica pomiędzy _mock_ i _stub_?

_Mock_ to _stub_ na sterydach ;).

Wiesz już, że _stub_ to obiekt, który podstawiasz w teście za właściwą implementację. _Stub_ pozwala jedynie na określenie zachowania obiektu, który imituje.

_Mock_ to  także obiekt, który podstawiasz w teście za właściwą implementację. W tym przypadku, poza oreśleniem zachowania masz możliwość jego weryfikacji. Innymi słowy _mocki_ pozwalają sprawdzać czy dany obiekt został użyty, jakie metody były wywołane w trakcie testu, jekie parametry były użyte w trakcie tych wywołań.

Te informacje pozwalają na pisanie testów, które sprawdzają otoczenie testowanej jednostki. Na przykład w trakcie wyszukiwania najtańszego lotu _mock_, który reprezentuje dostawcę połączeń pozwoli sprawdzić czy rzeczywiście dany dostawca został użyty, jakie parametry zostały mu przekazane.

Samodzielne pisanie klas _mock'ów_ czy _stub'ów_ jest uciążliwe, z pomocą przychodzą liczne bibltioteki, które robią to automatycznie. Jedną z takich bibliotek jest Mockito.

## Biblioteka Mockito

## Używanie _mock'ów_ a higiena

Wszystko jest dla ludzi, jeśli stosowane jest w rozsądnych ilościach. Jeśli Twój test jednostkowy w przerażającej większości składa się z przygotowania obiektów typu _mock_ czy _stub_ to warto się mu bliżej przyjrzeć. Może jest tak, że Twoja klasa ma zbyt szeroką odpowiedzialność? Może warto wprowadzić dodatkowy typ, który będzie grupował część tych zadań.

Niestety nie potrafię podać Ci jasnej reguły, która mówi: jeśli obiektów _mock_ masz więcej niż X to źle. Wydaje mi się, że takiej reguły nie ma. Jednak wiem, że testy jednostkowe, które naszpikowane są obiektami tego typu mogą być ciężke w utrzymaniu.

Dlatego właśnie stosuj zasady higieny w pracy z _mock'ami_ :). Jeśli Twoim subektywnym zdaniem przygotowanie testu jednostkowego jest zbyt pracochłonne, wymaga zbyt dużo przygotowania, to zabierz się za refaktoring.

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

Postaraj się napisać program używająć [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). Testy jednostkowe powinny używać obiektów typu _mock_ i _stub_ do symulowania zachowania API.

Jeśli będziesz mieć jakiekolwiek problemy zawsze możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/10_currency).

## Podsumowanie

Po przeczytaniu tego artykułu wiesz czym jest _mock_ i _stub_. Na przykładzie potrafisz pokazać różnicę pomiędzy obiektami tego typu. Po rozwiązaniu zadania udało Ci się w praktyce sprawdzić swoją wiedzę zdobytą w tym artykule. 

