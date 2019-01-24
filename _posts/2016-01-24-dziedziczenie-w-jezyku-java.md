---
last_modified_at: 2019-01-24 16:52:00 +0100
title: Dziedziczenie w języku Java
categories:
- Kurs programowania Java
permalink: /dziedziczenie-w-jezyku-java/
header:
    teaser: /assets/images/2016/01/24_dziedziczenie_w_jezyku_java_artykul.jpeg
    overlay_image: /assets/images/2016/01/24_dziedziczenie_w_jezyku_java_artykul.jpeg
    caption: "[&copy; Marcin Pietraszek ;)](http://marcin.pietraszek.pl)"
excerpt: W innych artykułach omawiałem pewne aspekty programowania obiektowego. Wiesz już o interfejsach i dlaczego warto ich używać. Dzisiaj przeczytasz o dziedziczeniu. Bez dziedziczenia nie można mówić o programowaniu obiektowym w Javie. Dowiesz się czym jest `Object`, dlaczego dziedziczenie jest ważne i kiedy powinniśmy go używać. Przeczytasz o przeciążaniu i nadpisywaniu metod. Poznasz też słowa kluczowe `abstract` i `final`. Do kodu!
disqus_page_identifier: 200 http://www.samouczekprogramisty.pl/?p=200
---

{% include kurs-java-notice.md %}

## Dziedziczenie
  
Na początku postaram się wyjaśnić czym właściwie jest dziedziczenie. Nie jest to nic skomplikowanego.

Niektóre obiekty mogą mieć między sobą dużo wspólnego. Na przykład zarówno samochód osobowy jak i samochód ciężarowy mają silnik, kierownicę, drzwi, światła itd. Co prawda każdy z tych elementów może być różny, jednak bez wątpienia oba te pojazdy mają wiele wspólnego. Przede wszystkim oba są pojazdami. Możemy powiedzieć, że samochód ciężarowy rozszerza (ang. _extends_) funkcjonalność pojazdu.

W naszym przykładzie pojazd możemy uznać, za tak zwaną klasę bazową (lub nadklasę). Natomiast samochód osobowy i samochód ciężarowy rozszerzają funkcjonalność pojazdu. Możemy też powiedzieć, że każda z nich jest klasą pochodną (lub „podklasą”). Proszę spójrz na przykład:

```java
public class Vehicle {
}

public class Car extends Vehicle {
}

public class Truck extends Vehicle {
}
```
  
Dziedziczenie jest jedną z podstaw programowania obiektowego (nie tylko w języku Java). Dzięki dziedziczeniu możemy ograniczyć ilość powielonego kodu poprzez definiowanie atrybutów, konstruktorów, metod w klasach bazowych.

Dziedziczenie może być wielopoziomowe, jednak w języku Java zawsze bezpośrednio możemy dziedziczyć od jednej klasy.

```java
public class Vehicle {
}

public class Car extends Vehicle {
}

public class SUV extends Car {
}
```
  
W przykładzie powyżej `SUV` dziedziczy po klasie `Car`. Klasa `Car` jest podklasą klasy `Vehicle`. Zatem pośrednio `SUV` także dziedziczy po klasie `Vehicle`.

{% include newsletter-srodek.md %}

## Modyfikatory dostępu
  
Dzięki dziedziczeniu możemy mieć dostęp do metod, atrybutów, konstruktorów klas po których dziedziczymy. Do określenia czy dany element może być dostępny w ramach podklasy służą modyfikatory dostępu.

Do tej pory poznałeś modyfikatory dostępu takie jak:

- `public` - element oznaczony tym modyfikatorem dostępny jest "z zewnątrz" obiektu, stanowi jego interfejs,
- `private` - element oznaczony tym modyfikatorem jest dostępna wyłącznie wewnątrz obiektu, także klasy pochodne nie mają do niego dostępu.
  
W przypadku dziedziczenia znaczenie ma także modyfikator `protected`. Element poprzedzony tym atrybutem może być dostępny wewnątrz klasy bądź przez każdą inną klasę która po niej dziedziczy.

Przygotowałem osobny artykuł poświęcony [modyfikatorom dostępu]({% post_url 2017-10-29-modyfikatory-dostepu-w-jezyku-java %}). Jeśli chcesz dowiedzieć się więcej o modyfikatorach powinieneś go przeczytać.
{:.notice--info}

Niżej możesz zobaczyć publiczną klasę `Greeter`. Używa ona trzech modyfikatorów dostępu: `public`, `protected` i `private`:

- klasa `Greeter` ma modyfikator `public`,
- atrybut `message` ma modyfikator `private`,
- metoda `sayHello` ma modyfikator `protected`.


```java
public class Greeter {
    private String message = "Hello!"

    protected void sayHello() {
        System.out.println(message);
    }
}
```

## Przesłonięcie i przeciążenie metody

Pytanie o to, czym różni się przesłonięcie od przeciążenia metody często trafia się na rozmowach o pracę. Pamiętam je jako jedno z obowiązkowych pytań na stanowiska początkujących programistów. Warto znać tę różnicę.
{:.notice--info}

### Sygnatura metody

Zanim wytłumaczę Ci te pojęcia musisz wiedzieć czym jest sygnatura metody. Specyfikacja języka Java określa sygnaturę metody jako jej nazwę wraz z listą argumentów. W szczególności w skład sygnatury metody nie wchodzi typ zwracany przez daną metodę.

W poniższym przykładzie sygnaturą metody jest `main(String[])` (nazwy parametrów nie są istotne):
```java
public static void main(String[] args) throws Exception {
    System.out.println("something important");
}
```

{% include newsletter-srodek.md %}

### Przesłonięcie metody
  
Łatwo sobie wyobrazić sytuację, w której metoda o tej samej sygnaturze występuje zarówno w klasie bazowej jak i klasie pochodnej. W tej sytuacji mówimy o tym, że klasa pochodna przesłania metodę z klasy bazowej (ang. _override_). Proszę spójrz na przykład poniżej.

```java
public class Vehicle {
    public void startEngine() {
        System.out.println("Engine starts. Brum brum brum.");
    }
}
 
public class Car extends Vehicle {
    public void startEngine() {
        System.out.println("Force driver to fasten seat belts.");
    }
}
```
  
W naszym przykładzie wywołanie metody `startEngine` na obiekcie typu `Car` zmusi kierowcę do zapięcia pasów (wyświetli się komunikat `Force driver to fasten seat belts`). Jeśli tę samą metodę wywołamy na instancji obiektu klasy Vehicle wówczas pojawi się komunikat `Engine starts. Brum brum brum.`.

Co jeśli chcielibyśmy nieznacznie zmodyfikować oryginalną metodę? Jest na to sposób. Słowo kluczowe `super` pozwala na wywołanie nadpisanej metody z klasy bazowej. Rozszerzając przykład powyżej moglibyśmy napisać taki fragment kodu:

```java
public class Car extends Vehicle {
    public void startEngine() {
        super.startEngine();
        System.out.println("Force driver to fasten seat belts.");
    }
}
```
  
W takim przypadku wywołanie metody `startEngine` na instancji obiektu `Car` na początku wywoła tę metodę z klasy bazowej (wyświetli się komunikat `Engine starts...`) następnie pokazany zostanie komunikat `Force driver...` (zachęcam do eksperymentowania z IDE).

[Adnotacja]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}) [`@Override`](https://docs.oracle.com/javase/9/docs/api/java/lang/Override.html) informuje kompilator o tym, że dana metoda powinna przesłaniać inną metodę w klasie bazowej. Jeśli warunek ten nie będzie spełniony możesz spodziewać się błędu kompilacji.
{:.notice--info}

### Przeciążenie metody

Przeciążenie (ang. _overload_) metody nie jest związane z dziedziczeniem. Mówimy o tym, że metoda jest przeciążona jeśli w ramach jednej klasy występuje wiele metod o tej samej nazwie. W tym przypadku każda z tych metod, mimo tej samej nazwy, ma różną sygnaturę. Metody te różnią się między sobą listą argumentów. Spójrz na przykład poniżej:

```java
public abstract class Vehicle {
    protected final int tankCapacity = 60;
    protected int fuelLevel = tankCapacity;

    public void fillTank() {
        int toFill = tankCapacity - fuelLevel;
        fillTank(toFill);
    }

    public void fillTank(int toFill) {
        if (toFill + fuelLevel > tankCapacity) {
            System.out.println("I can't fill tank with " + toFill + " litres.");
        }
        else {
            fuelLevel += toFill;
            System.out.println("I've filled the tank with " + toFill + " litres.");
        }
    }
}
```
W przykładzie tym metoda `fillTank` jest przeciążona. Pierwsza jej wersja nie pobiera żadnych argumentów. Druga liczbę typu `int`. Obie służą do napełnienia zbiornika paliwem.

Częstą praktyką jest używanie wewnątrz przeciążonej metody wywołania jej innego odpowiednika. Zazwyczaj metody z mniejszą liczbą argumentów wywołują te z większą. W takim przypadku możesz nadać domyślne wartości parametrów dla metod z większą ich liczbą.

W przykładzie powyżej bezargumentowa metoda `fillTank` wylicza ile paliwa brakuje do pełnego zbiornika. Następnie wywołuje przeciążoną metodę przekazując jej liczbę brakujących litrów

Przeciążać można także metody statyczne. Jako przykład może tu posłużyć metoda z biblioteki standardowej [`LocalDateTime.of`](https://docs.oracle.com/javase/9/docs/api/java/time/LocalDateTime.html#of-int-int-int-int-int-). Metoda ta jest przeciążona aż siedem razy.

Konstruktory nie są wyjątkiem, także można je przeciążać. Dzięki temu pozwalasz na tworzenie danego obiektu na wiele różnych sposobów:

```java
public class Car extends Vehicle {
    public Car() {
        this(new DiselEngine());
    }

    public Car(Engine engine) {
        super(engine, NUMBER_OF_WHEELS);
    }
}
```

Podobnie jak w zwykłym przeciążeniu także i tutaj często odwołuje się do innego konstruktora. Służy do tego słowo kluczowe `this`. W przykładzie powyżej bezparametrowy konstruktor wywołuje konstruktor przyjmujący instancję klasy implementującą interfejs `Engine`. W tym przypadku nowa instancja `DieselEngine` tworzona jest wewnątrz konstruktora bezparametrowego.

## Konstruktory a dziedziczenie
  
Konstruktory w przypadku dziedziczenia zachowują się tak samo jak metody. Także możemy wywołać konstruktor z klasy bazowej wewnątrz klasy dziedziczącej używając słowa kluczowego `super` (jeśli pozwala na to modyfikator dostępu).

Klasa pochodna musi mieć możliwość wywołania konstruktora klasy bazowej. Jeśli tego nie robi domyślnie wywoływany jest konstruktor bezparametrowy

```java
public class Animal {
    public Animal() {
    }
}
 
public class Dog extends Animal {
    public Dog() {
        super();
    }
}
```
  
W powyższym przykładzie wewnątrz konstruktora klasy `Dog` wywołujemy konstruktor klasy `Animal` wywołując `super()`. Jak napisałem wyżej możemy pominąć to wywołanie, wówczas kompilator zrobi to za nas. Ma to pewne konsekwencje. Jeśli w klasie bazowej zdefiniujemy konstruktor z parametrami wówczas konstruktor bezparametrowy nie zostanie utworzony automatycznie.

W takich przypadkach w konstruktorach klas pochodnych musimy wywołać konstruktor klasy bazowej. Pokazałem to w przykładzie poniżej:

```java
public class Vehicle {
    private int numberOfWheels;
    private Engine engine;
 
    public Vehicle(Engine engine, int numberOfWheels) {
        this.engine = engine;
        this.numberOfWheels = numberOfWheels;
    }
}
 
public class Car extends Vehicle {
    private static final int NUMBER_OF_WHEELS = 4;
 
    public Car(Engine engine) {
        super(engine, NUMBER_OF_WHEELS);
    }
}
```
  
Jak widzisz w przykładzie powyżej klasa `Car` nie musi definiować konstruktora z taką samą liczbą parametrów jak klasa bazowa, ale musi wywołać konstruktor klasy `Vehicle` i przekazać dwa parametry. Dzieje się tak, ponieważ w klasie `Vehicle` jest tylko konstruktor z dwoma parametrami.

## Klasy abstrakcyjne
  
Czasami może wystąpić sytuacja, w której klasa bazowa jest swego rodzaju uogólnieniem, abstrakcją, która nie ma sensu bez konkretnych implementacji. Wówczas możemy mówić o klasie abstrakcyjnej.

Nie ma możliwości stworzenie instancji klasy abstrakcyjnej. W naszym przykładzie klasa Vehicle mogłaby być klasą abstrakcyjną. Klasy abstrakcyjne poprzedzamy słowem kluczowym abstract. Proszę spójrz na przykład poniżej.

```java
public abstract class Vehicle {
    private int numberOfWheels;
    private Engine engine;
 
    public Vehicle(Engine engine, int numberOfWheels) {
        this.engine = engine;
        this.numberOfWheels = numberOfWheels;
    }
}
 
public class Car extends Vehicle {
    private static final int NUMBER_OF_WHEELS = 4;
 
    public Car(Engine engine) {
        super(engine, NUMBER_OF_WHEELS);
    }
}
```
  
Jak widzisz klasa abstrakcyjna może mieć konstruktor, jednak służy on tylko do tego, żeby uniknąć duplikacji kodu w klasach pochodnych. Klasa `Car` używa konstruktora zdefiniowanego w abstrakcyjnej klasie `Vehicle`.

## Klasy i metody finalne
  
Możliwość dziedziczenia i nadpisywania metod daje bardzo duże możliwości. Wyobraź sobie następujący kod:

```java
public interface BankAccount {
    void deposit(BigDecimal amount);
    void withdraw(BigDecimal amount);
}
 
public class Transfer {
    public void transferMoney(BankAccount source, BankAccount destination, BigDecimal amount) {
        source.withdraw(amount);
        destination.deposit(amount);
    }
}
```
  
Co stanie się jeśli programista utworzy nową klasę jak w przykładzie poniżej?

```java
public class FraudTransfer extends Transfer{
    public void transferMoney(BankAccount source, BankAccount destination, BigDecimal amount) {
        destination.deposit(amount);
    }
}
```

Przy takiej implementacji konto docelowe zostałoby zasilone dodatkową kwotą jednak ta kwota nie byłaby pobrana z konta źródłowego. Niedobrze.

W takich przypadkach możemy użyć słowa kluczowego `final`. Słowo to umieszczone przed klasą oznacza, że nie możemy po danej klasie dziedziczyć. W przypadku metody oznacza, że metoda nie może zostać nadpisana.

Dla przykładu klasy w pakiecie `java.lang` są finalne. Nie można nadpisać ich implementacji.

## Klasa `java.lang.Object`
  
Teraz już wiesz czym jest dziedziczenie. A wiesz, że używałeś go od pierwszej lekcji nauki języka Java? :)

Z jednego z poprzednich artykułów wiesz o tym, że kompilator dodaje automatycznie konstruktor bezparametrowy jeśli nie zdefiniujesz żadnego w swojej klasie. Podobnie jest z dziedziczeniem, każda klasa domyślnie dziedziczy po klasie `java.lang.Object` (chyba, że zdefiniujesz inną klasę po której dziedziczysz).

Dzięki tej klasie masz dostęp do zestawu metod, które zdefiniowane są w ciele klasy Object. Na przykład metoda `String toString()` ma swoją podstawową implementację w klasie `Object`[^tostring].

[^tostring]: Domyślna implementacja pokazuje nazwę klasy wraz z pakietem oraz jej adres w pamięci np. `pl.samouczekprogramisty.kursjava.cars.X@14ae5a5`.

## Dobre praktyki
  
Dziedziczenie to bardzo pomocny mechanizm. Jak napisałem wcześniej pozwala nam na uniknięcie duplikowania kodu. Jednak ma też swoje wady. Hierarchie dziedziczenia, które mają dużo poziomów mogą stać się mało czytelne. Tak zagmatwany kod może stać się trudny w utrzymaniu. Powinniśmy unikać takiej sytuacji.

Nie ma tu jasnej reguły, jednak w przypadku gdy w programie występuje wielopoziomowe dziedziczenie starałbym się uprościć taki kod. Bardzo często mówi się o preferowaniu kompozycji nad dziedziczeniem. Kompozycja to nic innego jak zawarcie innego obiektu jako atrybut naszej klasy. Kompozycja w wielu przypadkach potrafi uprościć skomplikowane hierarchie dziedziczenia.

## Zadanie
  
Na koniec mam dla Ciebie zadanie do wykonania, przećwiczysz w nim zagadnienia omówione w tym artykule.

Napisz program, w którym zasymulujesz hierarchię dziedziczenia zwierząt. Stwórz abstrakcyjną klasę `Animal`, po której będą dziedziczyły klasy `Fish` i `Mammal`. Wszystkie te klasy powinny być abstrakcyjne. Następnie stwórz konkretne klasy które dziedziczą po `Fish` i `Mammal`. Będą to odpowiednio `Goldfish` i `Human`.

Nadpisz metodę `toString` w każdej z tych klas. Stwórz instancje obu tych klas i wyświetl je na konsoli.

Jeśli miałbyś problemy z zadaniem możesz spojrzeć na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/tree/master/08_dziedziczenie/src/main/java/pl/samouczekprogramisty/kursjava/inheritance/exercise).

## Dodatkowe materiały
  
Poniżej przygotowałem dla Ciebie zestaw linków z dodatkowymi materiałami, część z nich jest w języku angielskim.
- [https://pl.wikipedia.org/wiki/Dziedziczenie\_%28programowanie%29](https://pl.wikipedia.org/wiki/Dziedziczenie_%28programowanie%29)
- [https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8](https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8)
- [https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html](https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html)
- [https://docs.oracle.com/javase/tutorial/java/concepts/inheritance.html](https://docs.oracle.com/javase/tutorial/java/concepts/inheritance.html)
- [kod źródłowy przykładów z tego artykułu](https://github.com/SamouczekProgramisty/KursJava/tree/master/08_dziedziczenie/src/main/java/pl/samouczekprogramisty/kursjava/inheritance)
  
## Podsumowanie
  
Bardzo się cieszę, że przeczytałeś artykuł do końca. Dzisiaj dowiedziałeś się czegoś więcej o dziedziczeniu. Poznałeś słowa kluczowe `abstract` i `final`. Wiesz już czym jest nadpisywanie metod czy klasa bazowa. Innymi słowy poznałeś kolejny zestaw narzędzi niezbędnych dla każdego programisty. Tak trzymaj! :)

Na koniec bardzo proszę Cię o podzielenie się artykułem ze swoimi znajomymi, którzy są zainteresowani taką tematyką. Jak zwykle zależy mi na tym, żeby z blogiem i jego zawartością dotrzeć do jak największej liczby czytelników takich jak Ty :) Jeśli jeszcze tego nie zrobiłeś prosiłbym o polubienie strony na Facebooku.

Do następnego razu!
