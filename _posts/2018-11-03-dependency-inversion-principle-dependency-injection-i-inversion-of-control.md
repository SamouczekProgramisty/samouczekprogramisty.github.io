---
title: Dependency Inversion Principle, Dependency Injection i Inversion of Control
last_modified_at: 2018-11-18 13:05:47 +0100
categories:
- Dobre praktyki
- Programista rzemieślnik
permalink: /dependency-inversion-principle-dependency-injection-i-inversion-of-control/
header:
    teaser: /assets/images/2018/11/03-dependency-inversion-principle-dependency-injection-inversion-of-control.jpg
    overlay_image: /assets/images/2018/11/03-dependency-inversion-principle-dependency-injection-inversion-of-control.jpg
    caption: "[&copy; Randy Jacob](https://unsplash.com/photos/A1HC8M5DCQc)"
excerpt: >
    W programowaniu obiektowym istnieje kilka wytycznych pomagających pisać kod wysokiej jakości. W tym artykule chciałbym skupić się na tych, które dotyczą zależności. Mam na myśli _Dependency Inversion Principle_, _Dependency Injection_ i _Inversion of Control_. Często dostaje pytania o to czym te pojęcia różnią się od siebie. W tym artykule postaram się to wyjaśnić.
---

Moim zdaniem wokół tych pojęć narosło sporo różnych teorii i wyjaśnień. Każdy na swój sposób stara się je przełożyć na praktykę programowania. W tym artykule postaram się pokazać Ci definicje możliwe najbliższe oryginałowi. Dla pełnego obrazu postaram się także cytować oryginalną definicję, dzięki czemu będziesz mieć okazję wyrobić sobie własne zdanie.
{:.notice--info}

## _Dependency Inversion Principle_

Zasada odwrócenia zależności (ang. _Dependency Inversion Principle_) to literka _D_ w akronimie [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}). Akronim ten grupuje pięć różnych wytycznych pomagających pisać kod wysokiej jakości. W dalszej części artykułu będę się do niej odnosił także jako DIP.

W 2002 roku Robert C. Martin, znany także jako Uncle Bob opublikował książkę [Agile Software Development, Principles, Patterns and Practices](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445/) w 2013 książka doczekała się [nowego wydania](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/1292025948). W książce tej opisał wcześniej wspomniany akronim SOLID. Literka _D_ została opisana w osobnym rozdziale. Ogólną definicję tej zasady autor przedstawił jako:

> **The Dependency-Inversion Principle**<br />
> A. High-level modules should not depend on low-level modules. Both should depend on abstractions.<br />
> B. Abstractions should not depend upon details. Details should depend upon abstractions.<br />

Punkty tej zasady można przetłumaczyć jako:

> A. Moduły wysokiego poziomu nie powinny zależeć od modułów niskiego poziomu. Oba powinny zależeć od abstrakcji.<br />
> B. Abstrakcje nie powinny zależeć od detali. Detale powinny zależeć od abstrakcji.

### Przykład zastosowania _Dependency Inversion Principle_

Wyobraź sobie klimatyzator, który reaguje na temperaturę powietrza. Jeśli temperatura jest wyższa od założonego poziomu klimatyzator włącza się automatycznie. Wyłącza się, jeśli osiągnie temperaturę niższą o 3 stopnie niż założony poziom. Naiwna implementacja może wyglądać tak (zauważ, że tego klimatyzatora nie da się wyłączyć ;)):

```java
public class AirConditioner {
    private static final float THRESHOLD = 3;

    private final float desiredTemperature;
    private final Thermometer thermometer;

    public AirConditioner(float desiredTemperature, Thermometer thermometer) {
        this.desiredTemperature = desiredTemperature;
        this.thermometer = thermometer;
    }

    public void start() throws InterruptedException {
        while (true) {
            if (thermometer.measure() > desiredTemperature) {
                coolDown();
            }
            System.out.println("It's cool.");
            TimeUnit.SECONDS.sleep(5);
        }
    }

    private void coolDown() throws InterruptedException {
        while (thermometer.measure() > desiredTemperature - THRESHOLD) {
            System.out.println("Cooling down");
            // cooling down somehow ;)
            TimeUnit.SECONDS.sleep(5);
        }
    }
}

public class Thermometer {
    public float measure() {
        return new Random().nextFloat();
    }
}
```

W tym przypadku klasa `AirConditioner` jest "modułem wysokiego poziomu". Klasa `Thermometer` to "moduł niskiego poziomu". Zatem ten przykład nie spełnia DIP, bo klasa `AirConditioner` zależy bezpośrednio od `Thermometer`. To co proponuje Uncle Bob sprowadza się do wprowadzenia nowej abstrakcji. Istotne jest to, że to moduł wysokiego poziomu powinien być właścicielem tej abstrakcji.

Rozwiązaniem w tym przypadku może być wprowadzenie abstrakcji, interfejsu `Sensor`. Interfejs ten byłby implementowany przez `Thermometer`. Aby DIP była spełniona, klasa `AirConditioner` powinna być właścicielem interfejsu `Sensor`. Kod spełniający DIP może wyglądać tak:

```java
public interface Sensor {
    float measure();
}

public class AirConditioner {
    private static final float THRESHOLD = 3;

    private final float desiredTemperature;
    private Sensor temperatureSensor;

    public AirConditioner(float desiredTemperature, Sensor temperatureSensor) {
        this.desiredTemperature = desiredTemperature;
        this.temperatureSensor = temperatureSensor;
    }
    // ...
}

public class Thermometer implements Sensor {
    @Overrides
    public float measure() {
        return new Random().nextFloat();
    }
}
```

#### Co to znaczy być właścicielem abstrakcji?

Można powiedzieć, że komponent jest właścicielem abstrakcji, jeśli kontroluje sposób w jaki ta abstrakcja jest zdefiniowana. W przypadku interfejsów oznacza to tyle, że moduł określa metody dostępne w tym interfejsie. Stosując to do przykładu wyżej, aby DIP była spełniona to `AirConditioner` musi być właścicielem interfejsu `Sensor`.

W aplikacjach, które cały kod źródłowy mają w jednym [pliku jar]({% post_url 2017-03-08-java-z-linii-polecen %}/#pliki-jar) jest to kwestia umowna. Zdarzają się jednak sytuacje, w których kod źródłowy rozdzielony jest pomiędzy kilka plików. 

Diagramy poniżej pokazują przykładowe sposoby podziału. Białe prostokąty reprezentują pliki JAR. Prostokąty z zaokrąglonymi rogami to klasy/interfejsy:

{% include figure image_path="/assets/images/2018/11/18_dip_approach_1.png" caption="Podział komponentów na osobne pliki JAR, sposób 1." %}
{% include figure image_path="/assets/images/2018/11/18_dip_approach_2.png" caption="Podział komponentów na osobne pliki JAR, sposób 2." %}

Zachęcam Cię do rzucenia okiem na [kod źródłowy na Github'ie](https://github.com/SamouczekProgramisty/MaterialyRozne/tree/master/06_dip_di_ioc/src/main/java/pl/samouczekprogramisty/dip). Pokazuję tam przykładowe sposoby rozdzielenia poszczególnych elementów pomiędzy pliki JAR.

### Moje trzy grosze

Na początku chciałbym zaznaczyć, że nie dorastam do pięt Robert'owi C. Martin'owi. Po tym wstępie mogę dodać moje trzy grosze ;).

Moim zdaniem, czasami jest tak, że nie ma sensu na siłę wprowadzać dodatkowego interfejsu. Czasami refaktoryzacja, która wydzieli dodatkową klasę, która opakowuje niskopoziomowe szczegóły jest wystarczająco dobra. Pozwala na uzyskanie kodu lepszej jakości. Bardzo mocno wierzę w zmiany wprowadzane małymi krokami. Dobrym pierwszym krokiem jest właśnie wydzielenie klas. Kolejnym etapem jest zastanowienie się na interfejsem pomiędzy nimi.

{% include newsletter-srodek.md %}

## _Inversion of Control_

W swoim [artykule](https://martinfowler.com/bliki/InversionOfControl.html) Martin Fowler wspomina, że pierwsza wzmianka o odwróceniu kontroli (ang. _Inversion of Control_) miała miejsce 1988 roku. Ten sam koncept opisany był także w 1985 roku w [artykule](http://www.digibarn.com/friends/curbow/star/XDEPaper.pdf) opisującym środowisko programowania Mesa chwaląc się tym, że posiada więcej niż 500 użytkowników :).

Ta druga wzmianka nazywa to podejście prawem Hollywood'u (ang. _Hollywod's Law_):

> **Don‘t  call  us,  we’ll  call  you  (Hollywood’s  Law).**<br />
> A tool should arrange for Tajo to notify it when the user wishes to communicate some event to the tool, rather than adopt an “ask the user for a command and execute it” model.

Można to przetłumaczyć jako:

> Narzędzie powinno (...) wspierać użytkownika kiedy on chce wydać narzędziu polecenie, a nie stosować się do podejścia "zapytaj użytkownika o polecenie i wykonaj je".

O odwróceniu kontroli wspomina też inna, klasyczna już książka [Design Patterns: Elements of Reusable Object-Oriented Software]({% post_url 2018-04-24-ksiazki-dla-programistow %}#design-patterns---gamma-helm-johnson-vlissides):

> A framework dictates the architecture of your application. It will define the overall structure, its partitioning into classes and objects, the key responsibilites thereof, how the clases and objects collaborate, and the thread of control. (...) Frameworks thus emphasize design reuse over code reuse (...). Reuse on this level leads to an inversion of control between the application and the software on which it's based. When you use a toolkit (...), you write the main body of the application and call the code you want to reuse. When you use a framework, you reuse the main body and write the code it calls.

Ten dłuższy fragment można przetłumaczyć jako[^framework]:

[^framework]: Mam świadomość, że _framework_ i _library_ to dwie różne rzeczy. Niestety nie znam lepszego tłumaczenia _framework_ niż biblioteka. Może powinienem użyć określenia rusztowanie? ;)

> Biblioteka (ang. framework) narzuca architekturę aplikacji. Definiuje także jej strukturę, podział na klasy i obiekty, ich zakres odpowiedzialności, jak klasy i obiekty współdziałają oraz sposób ich wywoływania. (...) Zatem biblioteka podkreśla wielokrotne użycie architektury a nie wielokrotne użycie kodu. Wielokrotne użycie na tym poziomie prowadzi do odwrócenia kontroli pomiędzy aplikacją i jej zależnościami. Kiedy używasz zestawu narzędzi, piszesz główne ciało aplikacji i wywołujesz kod, który chcesz używać wielokrotnie. Kiedy używasz biblioteki, używasz jej mechanizmów, które wywołują kod, który napiszesz.

W dalszej części artykułu czasami będę nazywał tę regułę jako IOC.

### Przykłady odwrócenia kontroli

Przykładem takiego odwrócenia kontroli może być [cykl życia serwletu]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %}#cykl-%C5%BCycia-serwletu). Bazując na specyfikacji serwletów masz pewność, że kontener wywoła odpowiednie metody w odpowiednim czasie. Nie ty je wywołujesz, robi to za Ciebie kontener serwletów. Na przykład nie Ty wywołujesz metodę `init`, robi to kontener serwletów wtedy, kiedy jest taka potrzeba.

Innym przykładem odwrócenia kontroli są kontenery IOC, na przykład [Guice](https://github.com/google/guice) czy Spring[^wielki]. Nie Ty tworzysz zależności, te zależności tworzone są przez kontener i wstrzykiwane do Twoich obiektów.

[^wielki]: Spring jest wielki. To słowo wytrych, które zawiera w sobie wszystko. Tutaj mam na myśli wyłącznie podzbiór Spring Core.

Poniżej pokażę Ci też odwrócenie kontroli na trochę mniejszym fragmencie kodu. Zwróć uwagę na implementację metody `toString`. W pierwszym przykładzie klasa `HtmlTag` wymaga wszystkich informacji w trakcie tworzenia obiektu:

```java
public class HtmlTag {

    private final String tag;
    private final String body;

    public HtmlTag(String tag, String body) {
        this.tag = tag;
        this.body = body;
    }

    @Override
    public String toString() {
        return String.format("<%s>%s</%s>", tag, body, tag);
    }
}
```

W drugim zastosowałem wzorzec _template meethod_. Metoda stosuje odwrócenie kontroli, w trakcie swojego działania prosi o niezbędne informacje wywołując metody `getTag` i `getBody`:

```java
public abstract class HtmlTag {

    protected abstract String getTag();
    protected abstract String getBody();

    @Override
    public String toString() {
        String tag = getTag();
        String body = getBody();
        return String.format("<%s>%s</%s>", tag, body, tag);
    }
}

public class EmTag extends HtmlTag {

    private String body;

    public EmTag(String body) {
        this.body = body;
    }

    @Override
    protected String getTag() {
        return "em";
    }

    @Override
    protected String getBody() {
        return body;
    }
}
```

## _Dependency Injection_

Niestety tutaj nie udało mi się dotrzeć do "pierwotnej" definicji tego pojęcia.

Można powiedzieć, że wstrzykiwanie zależności (ang. _Dependency Injection_) to praktyka wspomagająca pisanie kodu lepszej jakości.

Jest to mechanizm, który pozwala na dostarczenie zależności niezbędnych do poprawnego działania danego obiektu. Zależności mogą być dostarczane (wstrzykiwane) na wiele sposobów. Na przykład poprzez wywołanie "seterów", dostarczenie niezbędnych parametrów konstruktora czy korzystając z mechanizmu refleksji.

Bez wstrzykiwania wszystkie zależności tworzone są przez obiekt, który ich wymaga[^uproszczenie]. Prowadzi to do kodu, który jest trudny do testowania i mocno związany z konkretną implementacją zależności.

[^uproszczenie]: Jest to pewne uproszczenie. Możliwa jest sytuacja, w której kod napisany jest w sposób pozwalający na użycie DI, jednak tego nie robi.

W dalszej części artykułu czasami będę nazywał tę praktykę jako DI.

### Przykład użycia _Dependency Injection_

Proszę spójrz na przykład poniżej. Jest to klasa, która jest odpowiedzialna za tworzenie losowego łańcucha znaków o zadanej długości. Zauważ, że klasa `RandomString` wymaga generatora liczb losowych. W tym przykładzie tym generatorem jest instancja klasy `Random`. Głównym problemem tego kodu jest to, że używając klasy `RandomString` nie masz żadnego wpływu na sposób jej działania. Wszystkie jej zależności tworzone są w trakcie tworzenia instancji.

```java
public class RandomString {

    private final Random generator = new Random();

    public String getString(int length) {
        return generator.ints(length, 'a', 'z' + 1)
                .mapToObj(i -> (char) i)
                .reduce(new StringBuilder(), StringBuilder::append, StringBuilder::append)
                .toString();
    }
}
```

Pozornie niewielka zmiana bardzo mocno podnosi jakość kodu. Tą zmianą jest dodanie do konstruktora parametru, który inicjalizuje generator. Takie podejście pozwoli w łatwy sposób wstrzykiwać zależności tej klasy. Dzięki temu na przykład w trakcie [testów]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %}) możesz dostarczyć taką instancję `Random`, która za każdym razem będzie zwracała takie same wyniki:

```java
public class RandomString {

    private final Random generator;

    public RandomString(Random generator) {
        this.generator = generator;
    }

    // implementation of getString is the same
}
```

Tak zwane kontenery DI odpowiedzialne są za tworzenie sieci obiektów. Taki kontener wstrzykuje poszczególne zależności. W naszym przykładzie to kontener stworzyłby instancję klasy `Random` i `RandomString`. Ta druga utworzona zostałaby przy pomocy wcześniej utworzonej instancji klasy `Random`. Innymi słowy instancja klasy `Random` byłaby wstrzyknięta do instancji klasy `RandomString`.

## Porównanie DIP, IOC i DI

### Porównanie _Dependency Inversion Principle_ i _Inversion of Control_

Zasada odwrócenia zależności sprowadza się do dodawania nowych abstrakcji, które pozwolą tworzyć kod wyższej jakości. Odwrócenie kontroli może być stosowane na różnych poziomach.

Zwróć uwagę na to, że DIP wspomina o interfejsach pomiędzy poszczególnymi modułami. Opisując tę zasadę wspomniałem także o tym, że to moduł wysokiego poziomu jest właścicielem tego interfejsu. 

Takie podejście Uncle Bob uznaje jako odwrócenie kontroli. Po zastosowaniu zasady odwrócenia zależności moduł wyższego poziomu staje się właścicielem interfejsu. W przeciwnym przypadku to moduł niższego poziomu jest właścicielem tego interfejsu. Ta subtelna różnica prowadzi do odwrócenia kontroli. 

### Porównanie _Dependency Inversion Principle_ i _Dependency Injection_

Zasada odwrócenia zależności wprowadza nowe abstrakcje. Można powiedzieć, że te nowe abstrakcje to zależności. Zależności te mogą być wstrzykiwane. Zatem użycie DIP pozwala na łatwe zastosowanie DI. 

Te dwa pojęcia są także podobne pod względem nazwy ;). Wydaje mi się, że to właśnie ta zbliżona nazwa powoduje tyle zamieszania i powoduje mieszanie tych dwóch pojęć.

### Porównanie _Inversion of Control_ i _Dependency Injection_

IOC odwraca kontrolę. Objawia się to na wielu poziomach. Czasami może to być odwrócenie tego kto jest właścicielem interfejsu. Czy odwrócenie kolejności, w której generowane są obiekty.

Kontenery DI to nic innego jak kontenery, które wspierają IOC. Istnieje także pojęcie kontenerów IOC. Z mojego punktu widzenia kontenery IOC i kontenery DI określają to samo. To samo czyli mechanizm, który w łatwy sposób pozwala na wstrzykiwanie zależności.

Zauważ, że w przypadku tych kontenerów odwrócona jest kolejność wywoływania konstruktorów obiektów. Muszę tu też dodać, że stosowanie IOC wcale nie wymaga użycia DI. Jednak użycie DI wymaga użycia IOC.

## Dodatkowe materiały do nauki

Materiałów związanych z tymi trzema pojęciami jest sporo. Poniżej zebrałem kilka z nich:

- [Artykuł dotyczący _Dependency Inversion Principle_ na Wikipedii](https://en.wikipedia.org/wiki/Dependency_inversion_principle),
- [Artykuł dotyczący _Inversion of Control_ na Wikipedii](https://en.wikipedia.org/wiki/Inversion_of_control),
- [Artykuł dotyczący _Inversion of Control_ na stronie Martin'a Fowler'a](https://martinfowler.com/bliki/InversionOfControl.html),
- [Artykuł na temat _Inversion of Control_ i wzorca _Dependency Injection_ na stronie Martin'a Fowler'a](https://martinfowler.com/articles/injection.html).
- [Ciekawostka, wzmianka z 1985 o Hollywood's Law](http://www.digibarn.com/friends/curbow/star/XDEPaper.pdf),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/MaterialyRozne/tree/master/06_dip_di_ioc/src/main/java/pl/samouczekprogramisty)

Dodatkowo odsyłam Cię do źródeł w postaci książek, o których pisałem w artykule. Niestety ich minusem jest wysoka cena:

- [Agile Software Development, Principles, Patterns and Practices](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445/),
- [Design Patterns: Elements of Reusable Object-Oriented Software](https://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612).

## Podsumowanie

Po przeczytaniu tego artykułu wiesz czym jest DIP, IOC i DI. Na przykładach pokazałem Ci jak wygląda kod przed i po zastosowaniu tych zasad. Mam nadzieję, że teraz nie będziesz już mieć problemu ze wskazaniem różnic pomiędzy tymi pojęciami, które są często mylone.

Na koniec proszę Cię o podzielenie się tym artykułem ze swoimi znajomymi. Dzięki temu pozwolisz dotrzeć mi do szerszego grona Czytelników, a na tym właśnie mi zależy. Z góry dziękuję! Jeśli nie chcesz pominąć kolejnych artykułów polub Samouczka na Facebook'u i dopisz się do samouczkowego newslettera. Do następnego razu!
