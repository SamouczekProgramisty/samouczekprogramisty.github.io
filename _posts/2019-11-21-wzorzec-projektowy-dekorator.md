---
title: Wzorzec projektowy dekorator
last_modified_at: 2019-11-21 23:09:17 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-dekorator/
header:
    teaser: /assets/images/2019/11/21_wzorzec_projektowy_dekorator_artykul.jpg
    overlay_image: /assets/images/2019/11/21_wzorzec_projektowy_dekorator_artykul.jpg
    caption: "[&copy; Vladislav Vasnetsov](https://www.pexels.com/photo/person-painting-on-mug-2310883/)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o dekoratorze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce.
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

## Problem do rozwiązania

Wyobraź sobie restaurację, w której możesz zjeść pizzę. Właściciel restauracji daje Ci do wyboru 10 różnych dodatków. Możesz skomponować pizzę samodzielnie używając dostępnych dodatków. Każdy z dodatków ma swoją cenę i może być użyty wyłącznie jeden raz. Właściciel restauracji mógłby wypisać wszystkie kombinacje z tych 10 dodatków. Menu miałoby wtedy [1023 pozycje](https://pl.wikipedia.org/wiki/Kombinacja_bez_powt%C3%B3rze%C5%84), 1024 jeśli wliczymy Margharitę… Trochę dużo ;).

Właściciel podszedł do sprawy inaczej. Nadal daje Ci dowolność w wyborze dodatków, jednak wycenia każdy z nich jako osobną pizzę. Na przykład pizza z szynką, pizza z bazylią, pizza z mozzarellą i tak dalej. Następnie pozwala Ci łączyć ze sobą te pizze w dowolny sposób. Na przykład pizza bez żadnych dodatków kosztuje 15zł. Pizza z szynką kosztuje o 7 zł więcej niż pizza bazowa. Pizza z bazylią kosztuje o 2 zł więcej niż pizza bazowa. 

Dzięki takiemu podejściu w menu znajduje się 11 pozycji. Cena pizzy bez dodatków i cena każdego dodatku określona jako _cena pizzy bazowej + X zł_. Można powiedzieć, że właściciel restauracji użył wzorca dekoratora do opracowania cennika[^naciagane].

[^naciagane]: Ten przykład jest trochę naciągany. Sam dodatek nie jest pizzą, ale pizza z dodatkiem już tak. Jest to coś najbliższego światu rzeczywistemu co jest „dekoratorem” i powinno być łatwe do zrozumienia.

Podobne problemy występują w projektach informatycznych. Zdarzają się sytuacje, w których trzeba rozszerzyć działanie pewnego obiektu. Możliwych rozszerzeń jest wiele, jeszcze więcej jest kombinacji tych rozszerzeń. Z pomocą w rozwiązaniu tego problemu przychodzi wzorzec projektowy dekorator (ang. _decorator_[^wrapper]).

[^wrapper]: Inną nazwą tego wzorca projektowego, z którą możesz się spotkać jest _wrapper_.

## Wzorzec dekorator

### Diagramy klas

Istnieje wiele możliwości implementacji tego wzorca projektowego. Diagram klas poniżej pokazuje najprostszą z nich:

{% include figure image_path="/assets/images/2019/11/22_simple_decorator.svg" caption="Wzorzec projektowy dekorator (ang. _decorator_)" %}

`DecoratorA` i `DecoratorB` dekorują klasę `Component`. Dekoratory zawierają instancję klasy `Component`.

Często ten wzorzec projektowy przedstawiany jest w bardziej skomplikowany sposób:

{% include figure image_path="/assets/images/2019/11/17_decorator.svg" caption="Wzorzec projektowy dekorator (ang. _decorator_)" %}

W tym przypadku dekoratory mają wspólnego przodka, abstrakcyjną klasę `Decorator`. Sam komponent, który jest dekorowany także jest klasą abstrakcyjną, która posiada swoje konkretne implementacje. Na diagramie wyżej jest to `ConcreteComponent`.

Nie są to jedyne możliwe wersje implementacji tego wzorca. Przykładem innej implementacji może być użycie interfejsów w miejscu klasy komponentu. Inną modyfikacją może być użycie kompozycji w miejscu agregacji. Obie zmiany nie wpływają znacząco na implementację tego wzorca projektowego.

Wzorzec projektowy dekorator pozwala na wielokrotne rozszerzenie funkcjonalności obiektu poprzez „nakładanie” na siebie dekoratorów.

{% include newsletter-srodek.md %}

### Przykładowa implementacja dekoratora

Zacznę od pizzy bazowej:

```java
public class Pizza {
    private static final BigDecimal BASE_PRICE = new BigDecimal(12);

    public BigDecimal getPrice() {
        return BASE_PRICE;
    }

    @Override
    public String toString() {
        return "Pizza";
    }
}
```

Ot, zwykła klasa, która reprezentuje podstawową pizzę. Posiada metodę `getPrice`, która zwraca jej cenę.

Poniżej możesz zobaczyć jeden z dekoratorów. W tym przypadku jest to pizza z mozzarellą:

```java
public class PizzaWithMozzarella extends Pizza {
    private static final BigDecimal MOZZARELLA_PRICE = new BigDecimal(5);
    private final Pizza basePizza;

    public PizzaWithMozzarella(Pizza basePizza) {
        this.basePizza = basePizza;
    }

    @Override
    public BigDecimal getPrice() {
        return basePizza.getPrice().add(MOZZARELLA_PRICE);
    }
}
```

`PizzaWithMozzarella` w konstruktorze przyjmuje jako parametr instancję klasy `Pizza`, którą opakowuje. Następnie używa jej do obliczenia ceny pizzy z mozzarellą dodając do ceny pizzy bazowej cenę sera.

W tym przypadku klasa `Pizza` odpowiada klasie `Component` z diagramu UML, a klasa `PizzaWithMozzarella` reprezentuje `DecoratorA`.

Poniżej możesz zobaczyć użycie dekoratorów w praktyce. Opakowując kolejne pizze w dekoratory otrzymuję coraz bardziej skomplikowane pozycje. Dzięki takiemu podejściu mogę łączyć dodatki w dowolny sposób:

```java
public class Restaurant {
    public static void main(String[] args) {
        Pizza margherita = new Pizza();
        Pizza withMozzarella = new PizzaWithMozzarella(margherita);
        Pizza withMozzarellaAndHam = new PizzaWithHam(withMozzarella);
        Pizza withMozzarellaHamAndBasil = new PizzaWithBasil(withMozzarellaAndHam);

        DecimalFormat df = new DecimalFormat("#,00 zł");
        for (Pizza pizza : List.of(margherita, withMozzarella, withMozzarellaAndHam, withMozzarellaHamAndBasil)) {
            System.out.println(String.format("%s costs %s.", pizza, df.format(pizza.getPrice())));
        }
    }
}
```

### Dodatkowe rozważania

#### Zalety

Jedną z często polecanych praktyk w programowaniu obiektowym jest preferowanie [kompozycji przed dziedziczeniem](https://en.wikipedia.org/wiki/Composition_over_inheritance). Wzorzec projektowy dekorator jest flagowym przykładem użycia tej reguły. Takie podejście pozwala na dynamiczne rozszerzanie funkcjonalności obiektu bez potrzeby kompilacji kodu.

Niewątpliwą zaletą dekoratora jest możliwość dowolnego łączenia istniejących dekoratorów. Każdy z nich będzie opakowywał kolejny obiekt nie mając świadomości, że jest kolejnym dekoratorem w kolejce. Jest to istotne w przypadku gdy istnieje kilka dodatkowych funkcjonalności, które powinna zawierać rozszerzana klasa.

#### Wady

Interfejs dekoratora musi być dokładnie taki sam jak klasy dekorowanej. W niektórych językach programowania (na przykład w Javie) może prowadzić to do klas, które mają sporo metod, których implementacja polega na przekazaniu wywołania do dekorowanego obiektu (jeśli dekorator implementuje interfejs). Tę wadę można rozwiązać stosując dziedziczenie[^hierarchia].

[^hierarchia]: Takie podejście może wydłużać hierarchię dziedziczenia, sam preferuję użycie interfejsów jeśli hierarchia dziedziczenia jest dość długa.

Dekorator często jest „płaską klasą”. Rozszerza on dekorowaną klasę o jedną, podstawową funkcjonalność. Prowadzić to może do sytuacji, w której system zawiera wiele niewielkich klas. W sytuacji gdy zazwyczaj używa się stałego zbioru dekoratorów użycie standardowego dziedziczenia może ograniczyć tę liczbę.

## Przykłady użycia wzorca dekorator

W przypadku języka Java wzorzec projektowy dekorator jest dość często używany w bibliotece standardowej. Za przykład mogą tu posłużyć strumienie wykorzystywane przy [operacjach na plikach]({% post_url 2016-08-17-operacje-na-plikach-w-jezyku-java %}). [`InputStream`]({{ site.doclinks.java.io.InputStream }}) jest klasą abstrakcyjną, która posiada wiele dekoratorów, na przykład [`FileInputStream`]({{ site.doclinks.java.io.FileInputStream }}) czy [`BufferedInputStream`]({{ site.doclinks.java.io.BufferedInputStream }}).

Innym przykładem, również z języka Java, mogą być dekoratory kolekcji. Dekoratory te na przykład pozwalają na utworzenie kolekcji, która jest synchronizowana czy niemodyfikowalna. [`Collections`]({{ site.doclinks.java.util.Collections }}) zawiera szereg metod zaczynających się od `synchronized` albo `unmodifiable`, które tworzą instancje dekoratorów.

W języku Python istnieje składnia, która pozwala na łatwe użycie dekoratorów. Można powiedzieć, że ten wzorzec projektowy został wbudowany w język. Notacja `@dekorator` pozwala dekorować zarówno klasy jak i funkcje. Przykładami dekoratorów dostępnych w bibliotece standardowej mogą być `@property`, `@contextlib.contextmanager` czy `@functools.wraps`.

## Zadanie do wykonania

Chociaż klasy reprezentujące pizze z dodatkami spełniają swoje zadanie mogą być ulepszone. Zwróć uwagę, że klasy te są do siebie bardzo podobne. [Duplikacja kodu jest zła]({% post_url 2018-09-28-jakosc-kodu-a-oschle-pocalunki-jagny %}), zrefaktoryzuj kod w taki sposób aby usunąć tę duplikację. Spróbuj rozwiązać ten problem używając bardziej skomplikowanej wersji dekoratorów z drugiego diagramu UML.

Jak zwykle zachęcam Cię do samodzielnego rozwiązania zadania, w ten sposób nauczysz się najwięcej. Możesz też porównać swoje rozwiązanie z [przykładowym](https://github.com/SamouczekProgramisty/WzorceProjektowe/tree/master/java/03_decorator/src/main/java/pl/samouczekprogramisty/patterns/decorator/exercise).

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Warto także rzucić okiem do [polskiej](https://pl.wikipedia.org/wiki/Dekorator_(wzorzec_projektowy)) i [angielskiej Wikipedii](https://en.wikipedia.org/wiki/Decorator_pattern) gdzie znajdziesz artykuły dotyczące tego wzorca projektowego.

Zachęcam Cię też do zajrzenia do [kodu źródłowego](https://github.com/SamouczekProgramisty/WzorceProjektowe/tree/master/java/03_decorator/src/main/java/pl/samouczekprogramisty/patterns/decorator), którego użyłem w tym artykule.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest wzorzec dekorator. Znasz przykładowy sposób jego implementacji. Masz też zestaw materiałów dodatkowych, które pozwolą Ci spojrzeć na temat z innej strony. Po rozwiązaniu zadania wiesz jak zaimplementować ten wzorzec samodzielnie. Innymi słowy udało Ci się właśnie poznać kolejny wzorzec projektowy. Gratulacje! ;)

Jeśli artykuł przypadł Ci do gustu proszę podziel się nim ze znajomymi. Dzięki temu pozwolisz mi dotrzeć do nowych Czytelników, za co z góry dziękuję. Jeśli nie chcesz pomiąć kolejnych artykułów dopisz się do samouczkowego newslettera i polub [Samouczka Programisty na Facebooku](https://www.facebook.com/SamouczekProgramisty).

Do następnego razu!
