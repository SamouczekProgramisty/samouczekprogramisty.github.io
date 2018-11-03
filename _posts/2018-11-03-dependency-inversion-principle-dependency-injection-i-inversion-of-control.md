---
title: Dependency Inversion Principle, Dependency Injection i Inversion of Control
categories:
- Dobre praktyki
- Programista rzemieślnik
permalink: /dependency-inversion-principle-dependency-injection-i-inversion-of-control/
header:
    teaser: /assets/images/2018/11/03-dependency--inversion-principle-dependency-injection-inversion-of-control.jpg
    overlay_image: /assets/images/2018/11/03-dependency--inversion-principle-dependency-injection-inversion-of-control.jpg
    caption: "[&copy; Randy Jacob](https://unsplash.com/photos/A1HC8M5DCQc)"
excerpt: >
    W programowaniu obiektowym istnieje kilka wytycznych pomagających pisać kod wysokiej jakości. W tym artykule chciałbym skupić się na tych, które dotyczą zależności. Mam na myśli _Dependency Inversion Principle_, _Dependency Injection_ i _Inversion of Control_. Często dostaje pytania o to czym te pojęcia różnią się od siebie. W tym artykule postaram się to wyjaśnić.
---

Moim zdaniem wokół tych pojęć narosło sporo różnchy teorii i wyjaśnień. Każdy na swój sposób stara się je przełożyć na praktykę programowania. W tym artykule postaram się pokazać Ci definicje możliwe najbliższe oryginałowi. Dla pełnego obrazu postaram się także pokzać oryginalną definicję, dzięki czemu będziesz mieć okazję wyrobić sobie własne zdanie.
{:.notice--info}

## _Dependency Inversion Principle_

Zasada odwrócenia zależności (ang. _Dependency Inversion Principle_) to literka _D_ w akronimie [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}). Akronim ten grupuje pięć różnych wytycznych pomagających pisać kod wysokiej jakości. W dalszej części artykułu będę się do niej odnośił także jako DIP.

W 2002 roku Robert C. Martin, znany także jako Uncle Bob opublikował książkę [Agile Software Development, Principles, Patterns and Practices](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445/) w 2013 książka doczekała się [nowego wydania](https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/1292025948). W książsce tej opisał wcześniej wspomniany akronim SOLID. Literka _D_ doczekła się osobnego rozdziału, jednak ogólną definicję tej zasady przedstawił jako:

> **The Dependency-Inversion Principle**<br />
> A. High-level modules should not depend on low-level modules. Both should depend on abstractions.<br />
> B. Abstractions should not depend upon details. Details should depend upon abstractions.<br />

Punkty tej zasady można przetłumaczyć jako

- A. Moduły wysokiego poziomu nie powinny zależeć od modułów niskiego poziomu. Oba powinny zależeć od abstrakcji.
- B. Abstrakcje nie powinny zależeć od detali. Detale powinny zależeć od abstrakcji.

### Przykład zastosowania _Dependency Inversion Principle_

Wyobraź sobie klimatyzator, który reaguje na temperaturę powietrza. Jeśli temperatura jest wyższa od założonego poziomu klimatyzator włącza się automatycznie. Wyłącza się, jeśli osiągnie temperaturę niższą o 3 stopnie niż założony poziom. Naiwna implementacja może wyglądać tak (zauważ, że tego klimatyzatora nie da się wyłączyć ;)):


```java
public class AirConditioner {
    private static final float THRESHOLD = 3;

    private final float desiredTemperature;
    private Thermometer thermometer;

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

W tym przypadku klasa `AirConditioner` jest "modułem wysokiego poziomu". Klasa `Thermometer` to "moduł niskiego poziomu". Zatem ten przykład nie spełnia DIP. To co proponuje Uncle Bob sprowadza się do wprowadzenia nowej abstrakcji. Istotne jest to, że to moduł wysokiego poziomu powinien być właścicielem tej abstrakcji [^osobna_paczka]. Jeśli moduł jest właścicielem abstrakcji, to kontroluje sposób w jaki ta abstrakcja jest zdefiniowana. W przypadku interfejsów oznacza to tyle, że moduł określa metody dostępne w tym interfejsie.

[^osobna_paczka]: Alternatywą jest wprowadzenie oddzielnej "paczki", w której znajdował będzie się interfejs. Wówczas taka paczka jest zależnością zarówno dla modułów niskiego i wysokiego poziomu.

Rozwiązaniem w tym przypadku może być wprowadzenie abstrakcji, interfejsu `Sensor`. Interfejs ten byłby implementowany przez `Thermometer`. Aby reguła DIP była spełniona klasa `AirConditioner` powinna być właścicielem interfejsu `Sensor`. Kod spełniający DIP może wyglądać tak:

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

Zachęcam Cię do rzuczenia okiem na [kod źródłowy na Github'ie](TODO). Pokazuję tam przykładowe sposoby rozdzielenia poszczególnych elmentów pomiędzy pliki jar.

### Moje trzy grosze

Na początku chciałbym zaznaczyć, że nie dorastam do pięt Robert'owi C. Martin'owi. Po tym wstępie mogę dodać moje trzy grosze ;).

Moim zdaniem, czasami jest tak, że nie ma sensu na siłę wprowadzać dodatkowego interfejsu. Czasami refaktoryzacja, która wydzieli dodatkową klasę, która opakowuje niskopoziomowe szczegóły jest wystarczająco dobra. Pozwala na uzyskanie kodu lepszej jakości. Bardzo mocno wierzę w zmiany wprowadzane małymi krokami. Dobrym pierwszym krokiem jest właśnie wydzielenie klas. Kolejnym etapem jest zastanowienie się na interfejsem pomiędzy nimi.

## _Dependency Injection_

Zasada wtrzykiwania zależności (ang. _Dependency Injection_)

## _Inversion of Control_

Zasada odwrócenia kontroli (ang. _Inversion of Control_)

## Dodatkowe materiały do nauki

- [Artykuł dotyczący _Dependency Inversion Principle_ na Wikipedii](https://en.wikipedia.org/wiki/Dependency_inversion_principle),
- [Artykuł dotyczący _Inversion of Control_ na Wikipedii](https://en.wikipedia.org/wiki/Inversion_of_control),
- [Artykuł dotyczący _Inversion of Control_ na stronie Martin'a Fowler'a](https://martinfowler.com/bliki/InversionOfControl.html),
- [Ciekawostka, wzmianka z 1985 o Hollywood's Law](http://www.digibarn.com/friends/curbow/star/XDEPaper.pdf),
