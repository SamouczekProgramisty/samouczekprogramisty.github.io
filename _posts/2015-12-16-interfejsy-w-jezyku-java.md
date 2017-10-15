---
title: Interfejsy w języku Java
date: '2015-12-16 19:54:10 +0100'
categories:
- Kurs programowania Java
permalink: /interfejsy-w-jezyku-java/
header:
    teaser: /assets/images/2015/12/16_interfejsy_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2015/12/16_interfejsy_w_jezyku_java_artykul.jpg
excerpt: W artykule przeczytasz o interfejsach. Poznasz interfejs ze standardowej biblioteki Java. Dowiesz się czym różni się interfejs od jego implementacji. Przeczytasz też o tym dlaczego używanie interfejsów uważane jest w większości przypadków za dobrą praktykę. Jak zwykle na koniec będziesz miał także proste zadanie do wykonania..
---

{% include toc %}

{% include kurs-java-notice.md %}

## Interfejs
  
Wyobraź sobie kuchenkę mikrofalową. Kuchenka ma zestaw przycisków, parę pokręteł możliwe, że dodatkowy wyświetlacz. Ten zestaw to nic innego jak właśnie interfejs (ang. interface). Interfejs to&nbsp; zestaw „mechanizmów” służących do interakcji, w tym przypadku z kuchenką mikrofalową.

Pojęcie interfejsu można także przenieść do świata programowania. Mówimy wówczas o tak zwanym API (ang. _Application Programming Interface_).

Interfejs w kontekście programowania w języku Java to zestaw metod bez ich implementacji (bez kodu definiującego zachowanie metody)[^domyslne]. Właściwa implementacja metod danego interfejsu znajduje się w klasie implementującej dany interfejs.

[^domyslne]: Wyjątkiem tutaj są tak zwane metody domyślne o których przeczytasz niżej.

W języku Java do definiowani interfejsów używamy słowa kluczowego `interface`. Interfejsy, podobnie jak klasy, definiujemy w osobnych plikach. Nazwa pliku musi odpowiadać nazwie interfejsu.

```java
public interface Clock {
    long secondsElapsedSince(Date date);
}
```
  
Powyżej mamy przykład interfejsu o nazwie `Clock`, który ma jedną metodę `secondsElapsedSince`, która przyjmuje argument typu `Date`[^data] i zwraca wynik typu `long` mówiący o liczbie sekund, która minęła od czasu przekazanego w argumencie.

[^data]: `java.util.Date` jest jednym z typów z bilblioteki standardowej służącym do przedstawiania czasu.

Wszystkie metody zawarte w interfejsie zawsze są publiczne więc w tym przypadku można ominąć słowo kluczowe `public`, nie jest potrzebne.

Poza zwykłymi metodami w interfejsie mogą się znajdować

- metody domyślne,
- metody statyczne,
- stałe.
  
Więcej o metodach statycznych możesz przeczytać w [artykule opisującym pierwszy program w języku Java]({% post_url 2015-11-08-pierwszy-program-w-java %}). Nie jest to dla Ciebie nic nowego. Metody domyślne i stałe wymagają dodatkowego wyjaśnienia.

### Metody domyślne
  
Istnieje możliwość zdefiniowania tak zwanych metod domyślnych. Metody te mogą mieć właściwą implementacje w ciele interfejsu. Metody takie poprzedzone są słowem kluczowym `default` jak w przykładzie poniżej

```java
public interface MicrowaveOven {
    void start();
 
    void setDuration(int durationInSeconds);
 
    boolean isFinished();
 
    void setPower(int power);
 
    default String getName() {
        return "MicrovaweOwen";
    }
}
```
  
Klasy, które implementują interfejs mogą nadpisać metodę domyślną.

### Wartości niezmienne i stałe

```java
int counter = 123;
```
  
`counter` to zmienna. Do zmiennej `counter` możemy przypisać nową wartość:

```java
counter = counter + 1;
```
  
Wartości niezmienne w odróżnieniu od zmiennych poprzedzamy słowem kluczowym `final`. Poniżej możesz zobaczyć przykład klasy z atrybutem, którego wartości nie możemy przypisać na nowo. Atrybuty tego typu możemy inicjalizować jak w przykładzie poniżej: bezpośrednio bądź w ciele konstruktora.

```java
public class Calculator implements {
    public final double PI = 3.14;
    public final double SQRT_2;
 
    public Calculator() {
        SQRT_2 = Math.sqrt(2);
    }
}
```
  
Wartości niezmienne, podobnie jak metody, mogą być przypisane do instancji bądź klasy. Jeśli taka wartość przypisana jest do klasy mówimy wówczas o stałej. Jeśli chcemy aby stała była przypisana do klasy poprzedzamy ją słowem kluczowym `static`.

Do stałych wartość możemy przypisać wyłącznie raz - podczas inicjalizacji klasy. Zgodnie z konwencją nazewniczą stałe piszemy wielkimi literami.

```java
public interface Cat {
    int NUMBER_OF_PAWS = 4;
}
```
  
W interfejsie powyżej mamy stałą, która pokazuje ile łap ma kot. Domyślnie wszystkie atrybuty interfejsu są stałymi publicznymi przypisanymi do interfejsu więc słowa kluczowe `public static final` mogą zostać pominięte.

## Implementacja interfejsu
  
Sam interfejs nie jest zbyt wiele warty bez jego implementacji. Poniżej możesz zobaczyć przykładową, prostą implementację.

```java
public interface Clock {
    long secondsElapsedSince(Date date);
}
 
public class BrokenClock implements Clock {
    public long secondsElapsedSince(Date date) {
        return 300;
    }
}
```
  
Klasa `BrokenClock` implementuje interfejs `Clock`. Zwróć uwagę na słowo kluczowe `implements`. Używamy go żeby pokazać że klasa `BrockenClock` implementuje interfejs `Clock`.

W języku Java jedna klasa może implementować wiele interfejsów. W takim przypadku klasa implementująca musi definiować metody wszystkich interfejsów, które implementuje[^abstrakcyjne].

[^abstrakcyjne]: Oczywiście jest od tego wyjątek, o klasach abstrakcyjnych przeczytasz w innym artykule.

## Dziedziczenie interfejsów
  
Dziedziczenie to temat na osobny, obszerny artykuł. Jednak już teraz wspomnę, że interfejsy mogą dziedziczyć po innych interfejsach. Dziedziczenie oznaczane jest słowem kluczowym `extends`. Interfejs, który dziedziczy po innych interfejsach zawiera wszystkie metody z tych interfejsów.

```java
public interface Cat {
    int NUMBER_OF_PAWS = 4;
 
    String getName();
}
 
public interface LasagnaEater {
    String getLasagnaRecipe();
}
 
public interface FatCat extends Cat, LasagnaEater {
    double getWeight();
}
```
  
W przykładzie powyżej klasa implementująca interfejs `FatCat`, musi zaimplementować 3 metody:
- `String getName()`,
- `String getLasagnaRecipe()`,
- `duble getWeight()`.
  
## Interfejs znacznikowy
  
A czy możliwa jest sytuacja kiedy interfejs nie ma żadnej metody? Oczywiście, że tak. Mówimy wówczas o interfejsie znacznikowym. Jak sama nazwa wskazuje służy on do oznaczenia, danej klasy. Dzięki temu możesz przekazać zestaw dodatkowych informacji. Przykładem takiego interfejsu jest `java.io.Serializable`, którego używamy aby dać znać kompilatorowi, że dana klasa jest serializowalna (o serializacji przeczytasz w innym artykule).

## Interfejs a typ obiektu
  
Każdy obiekt w języku Java może być przypisany do zmiennej określonego typu. W najprostszym przypadku jest to jego klasa.

Interfejsy pozwalają na przypisane obiektu do zmiennej typu interfejsu. Wydaje się to trochę skomplikowane jednak mam nadzieję, że przykład poniżej pomoże w zrozumieniu tego tematu.

```java
public class Garfield implements FatCat {
    // implementacja metod
}
```

{% include figure image_path="/assets/images/2015/12/16_dziedziczenie.png" caption="Przykład hierarchii dziedziczenia" %}

```java
Garfield garfield = new Garfield();
FatCat fatCat = new Garfield();
Cat cat = new Garfield();
LasagnaEater lasagnaEater = new Garfield();
```
  
Instancję klasy `Garfield` możemy przypisać zarówno do zmiennej klasy `Garfield` jak i każdego z interfejsów, który ta klasa implementuje (bezpośrednio lub pośrednio). Chociaż w trakcie wykonania programu każdy z obiektów jest tego samego typu (instancja klasy `Garfield`), to w trakcie kompilacji sprawa wygląda trochę inaczej:
- na obiekcie `garfield` możemy wykonać wszystkie metody udostępnione w klasie `Garfield` i interfejsach, które ta klasa implementuje:
  - `getWeight()`,
  - `getName()`,
  - `getLasagnaReceipe()`.
- na obiekcie `fatCat` możemy wykonać wszystkie metody udostępnione w interfejsie `FatCat` i interfejsach po których dziedziczy:
  - `getWeight()`,
  - `getName()`,
  - `getLasagnaReceipe()`.
- na obiekcie `cat` możemy wykonać wyłącznie metody z interfejsu `Cat`:
  - `getName()`.
- na obiekcie `lasagnaEater` możemy wykonać wyłącznie metody z interfejsu `LasagnaEater`:
  - `getLasagnaReceipe()`.

## Zastosowania interfejsów
  
Do czego właściwie potrzebne są nam interfejsy? Czy nie jest to po prostu zestaw dodatkowych linijek kodu, które trzeba napisać i nic one nie wnoszą? Otóż nie.

Interfejsy w bardzo prosty sposób ułatwiają różnego rodzaju integrację różnych fragmentów kodu. Wyobraź sobie sytuację, w której Piotrek pisze program obliczający średnią temperaturę w każdym z województw. Współpracuje on z Kasią, która pisze program udostępniający aktualną temperaturę w danej miejscowości.

Aby Piotrek mógł napisać swój program musi skorzystać z programu Kasi. Musi się z nim zintegrować. Taką integrację ułatwiają właśnie interfejsy.

Piotrek z Kasią uzgadniają, że będą używali następującego interfejsu

```java
public interface Thermometer {
    double getCurrentTemperatureFor(String city);
}
```
  
Dzięki niemu Piotrek może pisać swój program równolegle z Kasią.

Co więcej może się okazać, że implementacja Kasi nie jest zbyt dokładna. Ania implementuje ten sam interfejs ale temperatury przez nią zwracane są dokładniejsze. Wówczas Piotrek w ogóle nie musi zmieniać swojego programu. Wystarczy, ze użyje innej implementacji interfejsu `Thermometer` dostarczonej przez Anię.

To właśnie jest kolejna zaleta interfejsów. Dzięki nim możemy pisać programy, które możemy w łatwiejszy sposób modyfikować. Interfejsy jasno oddzielają komponenty programu. Dzięki takiemu podejściu komponenty można z łatwością wymieniać.

## Zadanie
  
Napisz dwie klasy implementujące interfejs `Computation`. Niech jedna z implementacji przeprowadza operację dodawania, druga mnożenia.

```java
public interface Computation {
    double compute(double argument1, double argument2);
}
```
  
Użyj obu implementacji do uzupełnienia programu poniżej:

```java
public class Main {
    public static void main(String[] args) {
        Main main = new Main();
        Computation computation;
 
        if (main.shouldMultiply()) {
            computation = new Multiplication(); // zaimplementuj brakującą klasę
        }
        else {
            computation = new Addition(); // zaimplementuj brakującą klasę
        }
 
        double argument1 = main.getArgument();
        double argument2 = main.getArgument();
 
        double result = computation.compute(argument1, argument2);
        System.out.println("Wynik: " + result);
    }
 
    private boolean shouldMultiply() {
        return false; // tutaj zapytaj użytkownika co chce zrobić (mnożenie czy dodawanie)
    }
 
    private double getArgument() {
        return 0; // tutaj pobierz liczbę od użytkownika
    }
}
```
  
Program po uruchomieniu powinien zapytać użytkownika jaką operację chce wykonać, następnie pobrać dwa argumenty niezbędne do wykonania tej operacji. Ostatnią linijką powinien być wynik dodawania/mnożenia wyświetlony użytkownikowi. Przygotowałem też dla Ciebie [przykładowe rozwiązanie zadania](https://github.com/SamouczekProgramisty/KursJava/tree/master/07_interfejsy/src/main/java/pl/samouczekprogramisty/kursjava/interfaces/exercise), pamiętaj jednak, że rozwiązując je samodzielnie nauczysz się najwięcej.

## Materiały dodatkowe
  
Oczywiście nie wyczerpaliśmy tematu mimo sporej objętości artykułu. Zachęcam do samodzielnego pogłębiania wiedzy korzystając z materiałów dodatkowych. Specyfikacja Języka Java jest w języku angielskim.
- [Opis interfejsu na Wikipedii](https://pl.wikipedia.org/wiki/Interfejs_%28programowanie_obiektowe%29)
- [Rozdział w Java Language Specification dotyczący interfejsów](https://docs.oracle.com/javase/specs/jls/se8/html/jls-9.html)
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/07_interfejsy/src/main/java/pl/samouczekprogramisty/kursjava/interfaces)
  
## Podsumowanie
  
Dzisiaj poruszyliśmy bardzo wiele zagadnień. Dowiedziałeś się o interfejsach, przeczytałeś o ich przeznaczeniu. Poznałeś też kilka nowych słów kluczowych w języku Java. Wystarczająca dawka wiedzy jak na jeden dzień :)

Mam nadzieję, że artykuł był dla Ciebie ciekawy, jeśli cokolwiek nie było zrozumiałe bądź wymaga dokładniejszego wyjaśnienia daj znać, na pewno pomogę.

Jak zwykle na koniec mam do Ciebie prośbę. Proszę podziel się artykułem ze swoimi znajomymi, zależy mi na dotarciu do jak największej liczby osób, które chcą nauczyć się programowania :) Zapraszam także na [SamouczekProgramisty](https://facebook.com/SamouczekProgramisty) na facebooku. Możesz też zapisać się do mojego newslettera.

Do następnego razu!

Zdjęcie dzięki uprzejmości _FreeImages.com/Piotr Lewandowski_.
