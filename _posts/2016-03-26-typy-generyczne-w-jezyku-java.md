---
title: Typy generyczne w języku Java
date: '2016-03-26 21:27:50 +0100'
categories:
- Kurs programowania Java
permalink: /typy-generyczne-w-jezyku-java/
header:
    teaser: /assets/images/2016/03/23_java_typy_generyczne_artykul.jpg
    overlay_image: /assets/images/2016/03/23_java_typy_generyczne_artykul.jpg
excerpt: Dzień dobry! Nadszedł czas na poznanie typów generycznych. Dowiesz się o "szablonach" w języku Java, które pozwalają na tworzenie bardziej uniwersalnych typów. Jest to wstęp, który pozwoli Ci dobrze zrozumieć kluczowy aspekt standardowych kolekcji ("tablic na sterydach") w języku Java. Każdy programista Javy musi znać typy generyczne :) Zapraszam do artykułu!
---

{% include toc %}

{% include kurs-java-notice.md %}

## Czym są typy generyczne

W uproszczeniu można powiedzieć, że typy generyczne są "szablonami". Dzięki typom generycznym możemy uniknąć niepotrzebnego rzutowania. Ponadto przy ich pomocy kompilator jest w stanie sprawdzić poprawność typów na etapie kompilacji, oznacza to więcej błędów wykrytych w jej trakcie.> I tu mała dygresja. Każdy błąd w kodzie kosztuje. Ktoś w końcu płaci za pracę testerów, programistów, administratorów. Im wcześniej wykryjemy błąd tym tańsze jest jego naprawienie. Poprawienie programu działającego na środowisku produkcyjnym może być bardzo drogie. Wykrywanie błędów w trakcie kompilacji, chociaż może być frustrujące dla programisty jest najtańszym rozwiązaniem :)
Poza tym dzięki typom generycznym możemy konstruować bardziej złożone klasy, które możemy używać w wielu kontekstach, łatwiej będzie Ci to zrozumieć na przykładzie.
## Porównanie typów generycznych i standardowych

Znasz już zwykłe klasy i interfejsy, zostały one omówione we wcześniejszych artykułach. Klasy mają swoje atrybuty, których typy znasz pisząc program.

```java
public class Apple {
}

public class AppleBox {
    private Apple apple;

    public AppleBox(Apple apple) {
        this.apple = apple;
    }

    public Apple getApple() {
        return apple;
    }
}
```

W przykładzie powyżej klasa `AppleBox` "wie" jakiego typu obiekt może przechowywać, jest to obiekt typu `Apple`. A co jeśli chcielibyśmy zrobić analogiczną klasę dla owoców innego rodzaju? Oczywiście możemy stworzyć podobne pudełko jak w przykładzie poniżej:

```java
public class Orange {
}

public class OrangeBox {
    private Orange orange;

    public OrangeBox(Orange orange) {
        this.orange = orange;
    }

    public Orange getOrange() {
        return orange;
    }
}
```

Oba przykłady są jak najbardziej poprawne jednak występuje w nich duplikacja. Te same elementy, konstrukcje powielane są wielokrotnie. Duplikacja w kodzie generalnie jest złą praktyką, należy jej unikać. Możemy zatem stworzyć kolejną klasę:

```
public class FruitBox {
    private Object fruit;

    public FruitBox(Object fruit) {
        this.fruit = fruit;
    }

    public Object getFruit() {
        return fruit;
    }
}

public class Main {
    public static void main(String[] args) {
        FruitBox fruitBox = new FruitBox(new Orange());
        Orange fruit1 = (Orange) fruitBox.getFruit();
    }
}
```

Z racji tego, że atrybut fruit jest typu Object możemy do niego przypisać zarówno instancję klasy `Orange` jak i `Apple`. Pojawia się jednak pewien problem. Mianowicie jeśli chcemy pobrać atrybut `fruit` i przypisać go do zmiennej odpowiedniego typu musimy rzutować. Tego typu konstrukcja może powodować błędy podczas wykonania programu i warto jej unikać. Z pomocą przychodzą typy generyczne. Proszę spójrz na przykład poniżej.

```java
public class BoxOnSteroids<T> {
    public T fruit;
 
    public BoxOnSteroids(T fruit) {
        this.fruit = fruit;
    }
 
    public T getFruit() {
        return fruit;
    }
}
 
public class Main {
    public static void main(String[] args) {
        BoxOnSteroids<Apple> appleBox = new BoxOnSteroids<Apple>(new Apple());
        BoxOnSteroids<Orange> orangeBox = new BoxOnSteroids<Orange>(new Orange());
 
        Orange fruit = orangeBox.getFruit();
    }
}
```

`public class BoxOnSteroids<T>` to nic innego jak pierwsza linijka definicji klasy. Nowa tutaj jest konstrukcja z nawiasami. Oznacza ona właśnie typ generyczny, który możemy parametryzować innym typem. Typ ten dostaje "tymczasową nazwę", w tym przypadku `T`, której używamy dalej w ciele klasy.

W trakcie tworzenia instancji obiektu `BoxOnSteroids` podajemy informację o typie, który chcielibyśmy wstawić w miejsce `T`. W naszym przykładzie są to klasy `Apple` lub `Orange`. Dzięki takiej konstrukcji kompilator dokładnie wie jakiego typu obiekt zostanie zwrócony przez metodę `getFruit` w związku z tym rzutowanie nie jest konieczne[^rzutowanie].

[^rzutowanie]: W praktyce rzutowanie tam występuje jednak jest wykonywane automatycznie przez kompilator generujący bytecode.

## Definicja klasy generycznej

Klasę generyczną definiujemy w następujący sposób

```java
class Name<T1, T2, ..., Tn> {
    /* body */
}
```

Zauważ, że w nawiasach `<>` możemy umieścić więcej niż jeden parametr. Chociaż zgodnie ze specyfikacją języka Java możesz użyć dowolnej nazwy która nadaje się na nazwę zmiennej istnieje konwencja nazewnicza sugerująca nazwy parametrów. Zwyczajowo do tego celu używa się wielkich liter `T`, `K`, `U`, `V`, `E`.

W miejsce parametrów możemy wstawić dowolny obiekt, nie może to jednak być typ prosty. Innymi słowy `Integer` jest w porządku, `int` powoduje błąd.

## Instancja klasy generycznej

Skoro już wiemy jak zdefiniować klasę generyczną przydałoby się stworzyć jej instancję żeby w końcu jej użyć :) Linijka poniżej tworzy instancję klasy generycznej `BoxOnSteroids`, która parametryzowana jest typem `Orange`.

```java
BoxOnSteroids<Orange> orangeBox = new BoxOnSteroids<Orange>(new Orange());
```

Zauważ, że i tutaj występuje pewna duplikacja. Zarówno przy określaniu typu zmiennej jak i przy wywołaniu konstruktora powtarzamy klasę `Orange`. Nie jest to konieczne. Jeśli kompilator jest w stanie "wywnioskować" jaki typ powinien być użyty możemy go pominąć przy konstruktorze.

```java
BoxOnSteroids<Orange> orangeBox = new BoxOnSteroids<>(new Orange());
```

## Zagnieżdżone typy generyczne

Możesz też tworzyć instancje typów generycznych, które są bardziej skomplikowane. Przykład poniżej pokazuje klasę `Pair`, która parametryzowana jest dwoma innymi typami.

```java
public class Pair<T, S> {
    private T first;
    private S second;
 
    public Pair(T first, S second) {
        this.first = first;
        this.second = second;
    }
 
    public T getFirst() {
        return first;
    }
 
    public S getSecond() {
        return second;
    }
}
```

Java pozwala na to aby tworząc instancję typu generycznego parametryzować go innym typem generycznym. Brzmi to skomplikowanie, mam nadzieję, że przykład pomoże Ci to zrozumieć:

```java
Pair<BoxOnSteroids<Orange>, BoxOnSteroids<Apple>> pairOfBoxes =
        new Pair<>(
                new BoxOnSteroids<>(new Orange()),
                new BoxOnSteroids<>(new Apple())
        );
```

W przykładzie tym tworzony jest obiekt klasy `Pair`, który parametryzowany jest klasami `BoxOnSteroids<Orange>` i `BoxOnSteroids<Apple>`.

## Typy generyczne nie rozwiązują wszystkich problemów

Typy generyczne zostały wprowadzone w wersji Javy 1.5. Nie były dostępne od początku jej istnienia. Zatem istnieją sytuacje, w których nawet ich stosowanie może prowadzić do wystąpienia błędów w trakcie wykonywania programu. Proszę spójrz na przykład poniżej:

    BoxOnSteroids boxWithoutType = new BoxOnSteroids(new Apple());BoxOnSteroids boxWithApple = boxWithoutType;BoxOnSteroids boxWithOrange = boxWithoutType;Apple apple = boxWithApple.getFruit();Orange orange = boxWithOrange.getFruit(); // ClassCastException


W przykładzie tym tworzona jest instancja klasy generycznej `BoxOnSteroids` bez wyspecyfikowania klasy, która znajduje się "w środku". Następnie tą instancję przypisujemy do zmiennych typu `BoxOnSteroids<Apple>` i `BoxOnSteroids<Orange>`. O ile w pierwszym przypadku typ owocu trzymanego w środku się zgadza to ostatnia linia nie jest poprawna – generuje błąd typu `ClassCastException`. Obiekt typu `Apple` jest rzutowany przez kompilator do typu `Orange`[^rzutowanie].

[^rzutowanie]: Tu właśnie objawia się to automatyczne rzutowanie generowane przez kompilator

## Słowo kluczowe `extends`

To słowo kluczowe ma zastosowanie także w przypadku typów generycznych. Dzięki niemu możemy ograniczyć zestaw klas którymi możemy parametryzować nasz typ generyczny. Omówmy to na przykładzie:

```java
public interface Figure {
    String getName();
}
 
public class Circle implements Figure {
    public String getName() {
        return "circle";
    }
}
 
public class BoxForFigures<T extends Figure> {
    private T element;
 
    public BoxForFigures(T element) {
        this.element = element;
    }
 
    public T getElement() {
        return element;
    }
    
    public String getElementName() {
        return element.getName();
    }
}
 
BoxForFigures<Circle> circleBox = new BoxForFigures<>(new Circle());
BoxForFigures<Apple> appleBox; // complilation error
```

Jak widzisz przykład definiuje prosty interfejs `Figure` i klasę `Circle`, która go implementuje. Następnie definiujemy klasę `BoxForFigures`, która jest generyczna i może być parametryzowana przez typy dziedziczące/implementujące `Figure<T extends Figure>`.

Dzięki takiemu zapisowi kompilator pozwoli nam stworzyć instancję `circleBox` jednak zacznie się buntować przy `appleBox` (`Apple` nie implementuje interfejsu `Figure`).

Kolejną zaletą używania tego słowa kluczowego jest możliwość wywoływania metod na obiekcie typu parametryzowanego. W przykładzie powyżej wiemy że `T` jest czymś co implementuje `Figure` więc musi mieć metody dostępne w tym interfejsie. Właśnie z tego powodu w metodzie `getElementName` możemy wywołać metodę `getName` z tego interfejsu.

## Dziedziczenie typów generycznych

Tutaj należy się dodatkowe zdanie wyjaśnienia poparte prostym przykładem. Proszę spójrz na początek na klasy `Rectangle` i `Square` poniżej:

```java
public class Rectangle implements Figure {
    public String getName() {
        return "rectangle";
    }
}
 
public class Square extends Rectangle {
    public String getName() {
        return "square";
    }
}
```

Jak wiesz każda klasa w języku Java dziedziczy po klasie `Object` (bezpośrednio, bądź pośrednio). W naszym przykładzie bezpośrednio po klasie `Object` dziedziczą klasy `Rectangle`, `BoxForFigures<Rectangle>` i `BoxForFigures<Square>`[^plik_class]. Natomiast `Square` dziedziczy po `Rectangle`.

[^plik_class]: W rzeczywistości, po skompilowaniu powstanie jeden plik class z klasą `BoxForFigures`.

{% include figure image_path="/assets/images/2016/03/23_dziedziczenie_typow_generycznych_2.jpg" caption="Dziedziczenie typów generycznych." %}

Ma to swoje konsekwencje widoczne w przykładzie poniżej:

```java
Rectangle rectangle = new Square();
BoxForFigures<Rectangle> rectangleBox = new BoxForFigures<Square>(new Square()); // compilation error
```

Dzięki takiemu schematowi dziedziczenia do referencji typu `Rectangle` możemy przypisać obiekt `Square`. Jednak próba przypisania obiektu `BoxForFigures<Square>` do referencji `BoxForFigures<Rectangle>` powoduje błąd kompilacji.

Jednak podobnie jak w przypadku zwykłych klas, klasy generyczne także mogą dziedziczyć po innych klasach. W szczególności mogą także dziedziczyć po klasach generycznych.

```java
class StandardBox<T> {
    public T object;
 
    public StandardBox(T object) {
        this.object = object;
    }
}
 
public class FancyBox<T> extends StandardBox<T> {
    public FancyBox(T object) {
        super(object);
    }
    public void saySomethingFancy() {
        System.out.println("our " + object + " is cool!");
    }
}
 
public class Main {
    public static void main(String[] args) {
        FancyBox<String> box = new FancyBox<>("something");
        box.saySomethingFancy();
    }
}
```

W naszym przykładzie klasa `FancyBox` dziedziczy po `StandardBox`, widoczne jest to na diagramie poniżej.

{% include figure image_path="/assets/images/2016/03/23_dziedziczenie_typow_generycznych.jpg" caption="Dziedziczenie typów generycznych" %}

## Metody z generycznymi argumentami – wildcard

### `FancyBox<?>`

Pisząc metody, które jako argumenty przyjmują typy generyczne nie zawsze chcesz dokładnie specyfikować typ. W takim wypadku z pomocą przychodzi znak `?`, który może akceptować różne typy.

 ```java
private static void method1(FancyBox<?> box) {
    Object object = box.object;
    System.out.println(object);
}
 
private static void plainWildcard() {
    method1(new FancyBox<>(new Object()));
    method1(new FancyBox<>(new Square()));
    method1(new FancyBox<>(new Apple()));
}
```

Jak widzisz w przykładzie powyżej metoda method1 może akceptować różne klasę `FancyBox` parametryzowaną dowolnym typem.

### `FancyBox<? extends Figure>` "upper bound"

Znak `?` może występować także w połączeniu ze słówkiem kluczowym `extends`. W takim przypadku możesz ograniczyć akceptowane typy "z góry". Na przykład w przykładzie poniżej metoda akceptuje jedynie klasy typy, które dziedziczą po Figure.

```java
private static void method2(FancyBox<? extends Figure> box) {
    Figure figure = box.object;
    System.out.println(figure);
}
 
private static void method3(FancyBox<Figure> box) {
    Figure figure = box.object;
    System.out.println(figure);
}
 
private static void upperBoundWildcard() {
    method2(new FancyBox<>(new Square()));
    method2(new FancyBox<>(new Circle()));
    //method3(new FancyBox<Square>(new Square())); // compilation error
}
```

W przykładzie tym możesz także zobaczyć, że typ `FancyBox<Figure>` jest bardziej restrykcyjny niż `FancyBox<? extends Figure>`. W konsekwencji próba wywołania `method3` z argumentem innego typu niż `FancyBox<Figure>` skutkuje błędem kompilacji.

### `FancyBox<? super Rectangle>` "lower bound"

Poza ograniczeniem "z góry" możesz także ograniczyć akceptowalne typy "z dołu". W przykładzie poniżej metoda akceptuje wyłącznie argumenty typu `FancyBox<Object>`, `FancyBox<Figure>` i `FancyBox<Rectangle>`.

```java
private static void method4(FancyBox<? super Rectangle> box) {
    box.object = new Square();
    //box.object = new Circle(); // compilation error
}
 
private static void lowerBoundWildcard() {
    method4(new FancyBox<>(new Rectangle()));
    method4(new FancyBox<Figure>(new Rectangle()));
    method4(new FancyBox<>(new Object()));
    //method4(new FancyBox<Square>(new Square())); // compilation error
}
```

Zauważ, ze w niektórych miejscach nie ma potrzeby podawania typu generycznego. Samo `<>` wystarczy, kompilator jest w stanie wywnioskować jakiego typu może się tam spodziewać.Typy generyczne są skomplikowaneJeśli aktualnie masz mętlik w głowie nie przejmuj się.

## Typy generyczne są skomplikowane

Nie zostały one dodane do Javy od samego początku. W związku z tym, że twórcy chcieli zachować kompatybilność wstecz[^compatibility] istnieje wiele kruczków, które nie są trywialne. Pominąłem w artykule np. "type erasure" czy generyczne metody, które nie są istotne na początku. Jeśli jesteś nimi zainteresowany odsyłam do materiałów dodatkowych.

[^compatibility]: Twórcom zależało na tym aby programy napisane w starej wersji Javy mogły być uruchamiane na najnowszych wersjach maszyny wirtualnej.

## Materiały dodatkowe

Wszystkie przykłady użyte w tym artykule dostępne są na githubie. Poniżej zebrałem dla Ciebie zestaw dodatkowy materiałów, jeśli chciałbyś poszerzyć swoją wiedzę na temat typów generycznych w języku Java.

- <https://docs.oracle.com/javase/tutorial/java/generics/index.html>
- <https://docs.oracle.com/javase/tutorial/extra/generics/index.html>
- <https://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.5>
- <https://pl.wikipedia.org/wiki/Programowanie_uog%C3%B3lnione>

## Podsumowanie

Nie jest to oczywiście kompletny artykuł dotyczący typów generycznych w Javie. Pominięte zostały aspekty wymazywania typów czy bardziej szczegółowe informacje dotyczące użycia ?. Jeśli któryś fragment jest dla Ciebie nie do końca zrozumiały daj znać, postaram się rozszerzyć artykuł o dodatkowe przykłady i opisy.

Na koniec mam do Ciebie prośbę. Proszę podziel się artykułem ze swoimi znajomymi, którzy mogą być zainteresowani tematem programowania. Zależy mi na dotarciu do jak największej liczby czytelników. Jeśli nie chcesz ominąć żadnego kolejnego artykułu polub nas na facebooku :) Do następnego razu!

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/huntingglee/2222875354
