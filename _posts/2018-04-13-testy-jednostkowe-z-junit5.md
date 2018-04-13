---
title: Testy jednostkowe z JUnit 5
categories:
categories:
- Programista rzemieślnik
permalink: /testy-jednostkowe-z-junit5/
header:
    teaser: /assets/images/2018/04/13_testy_jednostkowe_z_junit5.jpg
    overlay_image: /assets/images/2018/04/13_testy_jednostkowe_z_junit5.jpg
    caption: "[&copy; rosengrant](https://www.flickr.com/photos/rosengrant/4012683209/sizes/l)"
excerpt: W artykule tym przeczytasz o JUnit 5. Dowiesz się co jest nowego w testowaniu przy użyciu JUnit 5. Poznasz sposoby na użycie wyrażeń lambda w testach. Zdobytą wiedzę będziesz mógł przećwiczyć rozwiązując zadania umieszczone na końcu artykułu.
---

{% capture intro %}
Jest to kolejny artykuł poświęcony tematyce testów, który napisałem na Samouczku. Zachęcam Cię także do przeczytania poprzednich artykułów:

- [Testy jednostkowe z JUnit 4]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}) - artykuł wprowadza w świat testów. Przeczytasz w nim między innymi o tym czym są asercje czy po co piszemy testy. Jeśli nie pisałeś wczesniej testów to tutaj powinieneś zacząć,
- [_Test driven development_ na przykładzie]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}) - artyku o podejściu do pisania testów nazywanym _test driven development_. Opisuję w nim cały cykl _RED, GREEN, REFACTOR_ popierając go przykładami.

W tym artykule będę zakładał, że wiesz czym są testy. W treści artykułu czasami będę porówywał wersję JUnit 5 z poprzednią, jednak znajomość JUnit 4 nie jest niezbędna.
{% endcapture %}

<div class="notice--info">
  {{ intro | markdownify }}
</div>

## Testy jednostkowe z JUnit 5

### Powody powstania JUnit 5

JUnit 4 to monolit. Jeden plik JAR (ang. _Java Archive_), który zawiera całą bibliotekę. Ten plik zawiera między innymi:

- klasy odpowiedzialne za wyszukiwanie testów,
- klasy odpowiedzialna za uruchamianie testów,
- klasy zawierające API do pisania testów (np. `@Test` czy implementacje asercji).

Jak widzisz łamie to jedną z podstawowych reguł dobrego podejścia do tworzenia kodu obiektowego: rób jedną rzecz i rób ją dobrze[^solid].

[^solid]: W orginale SRP (ang. _Single Responsibility Principle_) to pierwsza literka z akronimu [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}).

Poza tym IDE do uruchamiania testów i wyświetlania wyników używały prywatnej implementacji. Między innymi z tych powodów ewolucyjne rozwijanie biblioteki JUnit nie było możliwe. Nawet zmiana niektórych atrybutów powodowała, że IDE błędnie wyświetlało wyniki testów. Z tego powodu powstała inicjatywa rozwijania kolejnej wersji tej biblioteki.

### JUnit 5 jako platforma

JUnit 5 to trzy niezależne komponenty[^podzielone]:

[^podzielone]: Komponenty te są także podzielone na mniejsze elementy dystrybuowane w osobnych plikach JAR.

- platforma do uruchamiania testów: _JUnit Platform_,
- API używane do pisania testów: _JUnit Jupiter_,
- API używane do uruchamia testów napisanych w starszych wersjach JUnit na platformie JUnit 5: _JUnit Vintage_.

W swojej codziennej pracy używa się _JUnit Jupiter_, czyli samego API, które pozwala na tworzenie testów. To właśnie _JUnit Jupiter_ zawiera adnotacje, który są niezbędne w trakcie pisania testów. W trakcie uruchamiania testów pośrednio używa się też _JUnit Platform_, na przykład uruchamiając testy w IDE.

## Pierwszy test jednostkowy z JUnit 5

Projekt będę budował przy użyciu [Gradle]({% post_url 2017-01-19-wstep-do-gradle %}). Przykładowy test będzie służył do sprawdzenia, programu odpowiedzialnego za konwersję jednostek wagi. Każda z jednostek implementowała będzie [interfejs znacznikowy]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}#interfejs-znacznikowy) `WeightUnit`:

```java
public interface WeightUnit {
    int SCALE = 4;
    RoundingMode ROUNDING_MODE = RoundingMode.CEILING;
}
```

Klasa `Pound` reprezentuje funty:

```java
public class Pound implements WeightUnit {
    public static final BigDecimal POUND_TO_KILOGRAM_RATIO = new BigDecimal("0.453592").setScale(SCALE, ROUNDING_MODE);

    public final BigDecimal value;

    public Pound(BigDecimal value) {
        if (BigDecimal.ZERO.compareTo(value) > 0) {
            throw new IllegalArgumentException("Weight can't be negative!");
        }
        this.value = value.setScale(SCALE, ROUNDING_MODE);
    }

    public Kilogram toKilograms() {
        return new Kilogram(value.multiply(POUND_TO_KILOGRAM_RATIO).setScale(SCALE, ROUNDING_MODE));
    }
}
```

Jej odpowiednik dla kilogramów to klasa `Kilogram`:

```java
public class Kilogram implements WeightUnit {
    public final BigDecimal value;

    public Kilogram(BigDecimal value) {
        if (BigDecimal.ZERO.compareTo(value) > 0) {
            throw new IllegalArgumentException("Weight can't be negative!");
        }
        this.value = value.setScale(SCALE, ROUNDING_MODE);
    }

    public Pound toPounds() {
        return new Pound(value.divide(Pound.POUND_TO_KILOGRAM_RATIO, SCALE, ROUNDING_MODE));
    }
}
```

Przykładowy zestaw testów może wyglądać następująco:

```java
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.assertEquals;

class UnitConverterTest {
    @Test
    void shouldConvertZeroKilogramValue() {
        Pound pounds = new Kilogram(BigDecimal.ZERO).toPounds();
        assertEquals(BigDecimal.ZERO.setScale(4), pounds.value);
    }

    @Test
    void shouldConvertZeroPoundValue() {
        Kilogram kilograms = new Pound(BigDecimal.ZERO).toKilograms();
        assertEquals(BigDecimal.ZERO.setScale(4), kilograms.value);
    }

    @Test
    void shouldConvert1Pound() {
        assertEquals(new BigDecimal("0.4536"), new Pound(BigDecimal.ONE).toKilograms().value);
    }

    @Test
    void shouldConvert1Kilogram() {
        assertEquals(new BigDecimal("2.2046"), new Kilogram(BigDecimal.ONE).toPounds().value);
    }
}
```

Zwróć uwagę na to, że zarówno klasa `UnitConverterTest` jak i wszystkie metody nie są publiczne. JUnit 5, w odróżnieniu od swojego poprzednika, nie wymaga aby klasa/metody z testami były publicznie dostępne.

Kolejną różnicą jest pakiet, w którym znajdują się klasy użyte do tworzenia testów: `org.junit.jupiter.api`. Jest to bazowy pakiet zawierający wszystkie elementy niezbędne do pisania testów.

Metody oznaczone adnotacją [`@Test`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Test.html) to testy. Metody te nie mogą zwracać żadnej wartości, nie mogą być prywatne ani statyczne.

Wewnątrz testów używa się asercji. Asercje dostarczone przez JUnit zgrupowane są wewnątrz klasy [`Assertions`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html). W przykładach powyżej użyłem asercji [`assertEquals`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html#assertEquals-java.lang.Object-java.lang.Object-).

## Możliwości JUnit 5

### Cykl życia testów

Podobnie jak w poprzedniej wersji JUnit 5 określa cykl życia testów. Dzięki temu możesz odpowiednio przygotować warunki do uruchomienia testów. JUnit tworzy nową instancję klasy przed każdym uruchomieniem testu.

Jeśli chcesz zmienić to zachowanie możeszy użyć adnotacji [`@TestInstance`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/TestInstance.html), dzięki tej adnotacji możesz wymusić współdzielenie instancji klasy pomiędzy testami. Moim zdaniem, w większości przypadków nie powinieneś jednak tego robić. Dobrą praktyką jest pisanie testów, które są od siebie niezależne.

Do zarządzania cyklem życia służą następujące [adnotacje]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}):

- [`@BeforeEach`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/BeforeEach.html),
- [`@AfterEach`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/AfterEach.html),
- [`@BeforeAll`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/BeforeAll.html),
- [`@AfterAll`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/AfterAll.html).

### Zmiana nazwy testu

JUnit 5 pozwala na manipulowanie nazwą testu. Dzięki temu możesz opisać test używając znaków, które nie są dopuszczalne w nazwie metody. Służy do tego adnotacja [`@DisplayName`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/DisplayName.html):

```java
@Test
@DisplayName("0.1 pounds to kilograms ♥ ♦ ♣ ♠")
void shouldConvertFractions() {
    assertEquals(new BigDecimal("0.0454"), new Pound(new BigDecimal("0.1")).toKilograms().value);
}
```

### Testowanie wyjątków

W odróżnieniu od JUnit 4, JUnit 5 nie pozwala na określenie oczekiwanego wyjątku w elemencie adnotacji `@Test`. W nowym podejściu użyte są [wyrażenia lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}). Blok, który ma rzucić wyjątek powinien implementować interfejs funkcyjny [`Executable`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/function/Executable.html). W najprostszym przypadku jest to wyrażenie lambda.

Metoda [`assertThrows`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html#assertThrows-java.lang.Class-org.junit.jupiter.api.function.Executable-) przyjmuje:
- klasę wyjątku, który powinien być rzucony
- implementację interfejsu, która powinna ten wyjątek rzucić:

```java
@Test
void shouldntAcceptNegativeWeightInPounds() {
    IllegalArgumentException exception = assertThrows(
        IllegalArgumentException.class,
        () -> new Pound(new BigDecimal(-1))
    );
    assertEquals("Weight can't be negative!", exception.getMessage());
}
```

`assertThrows` zwraca instancję wyjątku, który został rzucony.

### Ograniczanie czasu działania testów

JUnit 5 pozwala na testowanie czy wykonanie fragmentu kodu będzie trwało krócej niż założony z góry okres. Służą do tego asercje:

- [`assertTimeout`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html#assertTimeout-java.time.Duration-org.junit.jupiter.api.function.Executable-),
- [`assertTimeoutPreemptively`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html#assertTimeoutPreemptively-java.time.Duration-org.junit.jupiter.api.function.Executable-).

Obie asercje przyjmują argumenty:
- instancję klasy [`Duration`](https://docs.oracle.com/javase/10/docs/api/java/time/Duration.html) określającą maksymalny czas działania,
- implementację interfejsu funkcyjnego `Executable`, to ten sam interfejs, który jest użyty w przypadku `assertThrows`.

```java
@Test
void shouldTransalteUnitsBlazinglyFast() {
    assertTimeout(Duration.ofMillis(10), () -> new Kilogram(BigDecimal.TEN).toPounds());
}
```

`assertTimeout` uruchamia przekazany fragment kodu w tym samym wątku i czeka na jego zakończenie. Po zakończeniu sprawdza czy założony czas został przekroczony. `assertTimeoutPreemptively` uruchamia przekazany fragment kodu w innym wątku i kończy go natychmiast po przekroczeniu założonego czasu.

### Zagnieżdżanie testów

JUnit 5 pozwala na wykorzystywanie [klas wewnętrznych]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}). Wraz z adnotacjami do zarządzania cyklem życia pozwala to na lepszą organizację testów. Służy do tego adnotacja [`@Nested`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Nested.html). Przykład poniżej pokazuje klasę `ExceptionHandling`, która zawiera jeden test. Klasa ta jest zagnieżdżona wewnątrz `UnitConverterTest`:

```java
class UnitConverterTest {
    @Test
    void shouldConvertZeroKilogramValue() {
        Pound pounds = new Kilogram(BigDecimal.ZERO).toPounds();
        assertEquals(BigDecimal.ZERO.setScale(44), pounds.value);
    }

    @Nested
    class ExceptionHandling {
        @Test
        void shouldntAcceptNegativeWeightInPounds() {
            IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> new Pound(new BigDecimal(-1)));
            assertEquals("Weight can't be negative!", exception.getMessage());
        }
    }
}
```

### Łączenie kilku asercji

Dobrą praktyką pisania testów jest używanie jednej asercji na każdy test. Takie podejście pozwala zobaczyć wszytkie asercje, które nie zostały spełnione. Prosty przykład poniżej pokazuje tę sytuację. Test jednostkowy, który zawiera te dwie linijki nigdy nie dojdzie do uruchomienia drugiej z nich:

```java
assertTrue(false);
assertFalse(true);
```

Przez to zachowanie nie zobaczysz od razu wszystkich błędnych asercji. JUnit 5 pozwala na obejście tego problemu dzięki użyciu assercji [`assertAll`]():

```java
@Test
void shouldntAcceptNullValue() {
    assertAll(
        () -> assertThrows(NullPointerException.class, () -> new Kilogram(null)),
        () -> assertThrows(NullPointerException.class, () -> new Pound(null))
    );
}
```

W przykładzie powyżej niezależnie od wyniku pierwszej asercji druga także zostanie wywołana. Obie zostaną uwzględnione w wynikach działania testów.

### Powtarzanie testów

Zdarzyło mi się pisać testy, które zawierały pętle. Pętle te służyły do powtórzenia dokładnie tego samego testu wielokrotnie. Pisałem takie testy w sytuacji gdy dochodziło do wyścigu i czasami dany test przechodził, czasami nie. JUnit 5 umożliwia pisanie tego typu testów bez użycia pętli. Służy do tego adnotacja [`@RepeatedTest`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/RepeatedTest.html):

```java
@RepeatedTest(3)
void shouldAlwaysReturnTheSameValue() {
    assertEquals(new BigDecimal("29.4840").setScale(4), new Pound(new BigDecimal(65)).toKilograms().value);
}
```

W przykładzie powyżej test zostanie wywołany trzy razy.

### Ignorowanie testów

JUnit 5 pozwala na ignorowanie testów. Najprostszym sposobem jest dodanie adnotacji [`@Disabled`](https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Disabled.html).

## Uruchamianie testów JUnit 5

Jak wspomniałem wyżej różne narzędzia używały wewnętrznego API biblioteki JUnit to uruchamiania i wyświetlania wyników testów. W związku z tym zmiana wersji biblioteki JUnit wymaga taże zmiany w różnych narzędziach. Aby używać JUnit 5 w IDE musi się ono poprawnie integrować z nową wersją biblioteki. Od jakiegoś już czasu główne IDE mają takie wsparcie:

- IntelliJ Idea 2016.2
- Eclipse Oxygen

### JUnit 5 z Gradle

Gradle od wersji 4.6 wspiera natywnie uruchamianie testów przy pomocy _JUnit Platform_. Dodanie kilku linijek do `build.gradle` pozwala na uruchamianie testów przy pomocy Gradle:

    dependencies {
        testImplementation group: 'org.junit.jupiter', name: 'junit-jupiter-api', version: '5.1.0'
        testRuntimeOnly group: 'org.junit.jupiter', name: 'junit-jupiter-engine', version: '5.1.0'
    }

    test {
        useJUnitPlatform()
    }

## Materiały dodatkowe

JUnit 5 ma bardzo dobrą dokumentację. Na YouTube znajdziesz też całkiem sporo prezentacji, które opisują nowe podejście. Poniżej zebrałem dla Ciebie materiały, które są dobrym uzupełnieniem dla treści artykułu:

- [Dokumentacja biblioteki JUnit](https://junit.org/junit5/docs/current/user-guide/),
- [Prezentacja z Devoxx prowadzona przez Lead Developer'a bibltioteki JUnit](https://www.youtube.com/watch?v=0qI6_NKFQsY),
- [JUnit 5 z innej perspektywy, integracja ze Spring 5](https://www.youtube.com/watch?v=-mIrA5cVfZ4),
- [Kampania na Indiegogo sponsorująca rozwój JUnit 5](https://www.indiegogo.com/projects/junit-lambda#/),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/31_testy_jednostkowe_junit5).

## Zadania do wykonania

1. Napisz program, który będzie pomagał w prowadzeniu kantoru. Kantor powinien obsługiwać wymianę trzech par walutowych:
- PLN - EUR,
- PLN - USD,
- EUR - USD.
Właściciel kantoru z góry określa przelicznik referencyjny i spread dla każdej pary walutowej. W bardziej rozwiniętej wersji kantor powinien pobierać przelicznik referencyjny używająć API NBP.
Napisz ten program używając podejścia [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}).
1. Zrefaktoryzuj kod źródłowy przykładów użytych w artykule tak aby `Weight` było klasą, której konstruktor akceptuje dwa parametry:
- `WeightUnit unit` - [typ wyliczeniowy]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}) określający rodzaj jednostki. Powinien mieć wartości `POUND` i `KILOGRAM`,
- `BigDecimal value` - wartość wagi w danej jednostce.
Dodatkowo klasa ta powinna zawierać metodę `Weight convert(WeightUnit convertTo)`. Użyj istniejących testów i metodyki TDD do przeprowadzenia refaktoringu kodu.

Zachęcam Cię do samodzielnego rozwiązania zadań, wtedy nauczysz się najwięcej. Podziel się linkiem do swojego rozwiązania w komentarzu :).

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest JUnit 5. Znasz komponenty składające się na tę bibliotekę. Rozwiązałeś zadanie, które pozwoliło Ci użyć JUnit 5 w praktyce. Od dzisiaj możesz zacząć pisać testy używając wyłącznie JUnit 5 ;). W artykule tym celowo pominąłem część funkcjonalności udostępnionych przez JUnit 5. Zachęcam Cię do zajrzenia do materiałów dodatkowych, szczególnie dokumentacji.

Jeśli masz jakiekolwiek pytania, proszę zadaj je w komentarzu. Jeśli nie chcesz ominąć kolejnych artykułów na blogu dopisz się do samouczkowego newslettera i polub Samouczka na Facebook'u. Do następnego razu!
