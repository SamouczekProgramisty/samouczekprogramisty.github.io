---
layout: default
title: Konwersja i rzutowanie w języku Java
date: '2016-02-17 17:48:51 +0100'
categories:
- Kurs programowania Java
excerpt_separator: "<!--more-->"
permalink: "/konwersja-i-rzutowanie-w-jezyku-java/"
---
Cześć! W dzisiejszym artykule przeczytasz o konwersji i rzutowaniu w języku Java. Przeczytasz o konwersji obiektów oraz typów prostych. Dowiesz się czym jest czym jest konwersja bezstratna. Przeczytasz o konwersji typów do typu `String`. Poznasz mechanizm boxing'u oraz unboxing'u. Innymi słowy, dziś kolejna porcja informacji na temat języka Java :)

{% include kurs-java-notice.md %}

# Rzutowanie
  
Zaczniemy od rzutowania (ang. _cast_). Jak już wiesz kompilator Javy ma pewną wiedzę na temat tego jaki rodzaj obiektu kryje się pod daną referencją w trakcie kompilacji. Wie to z typu zmiennej do której przypisany jest dany obiekt. Jednak możliwa jest sytuacja kiedy pod referencją typu X przypisany jest obiekt typu Y jak w przykładzie poniżej:

    public void differentTypes() { Object objectInstance = new Object(); Object stringInstance = "string";}

  
Obie referencje są typu `Object` jednak druga z nich przechowuje zmienną typu `String`. Jest to w 100% poprawny kod. Jednak jeśli na zmiennej `stringInstance` chciałbyś wywołać metodę, którą implementuje klasa `String` a nie ma jej w klasie `Object` skończy się to błędem kompilacji:

    Error:(15, 23) java: cannot find symbol symbol: method length() location: variable stringInstance of type java.lang.Object

  
Jak zatem wywołać taką metodę? Przecież jesteśmy pewni, że pod zmienną `stringInstance` kryje się obiekt typu `String`. Tutaj z pomocą przychodzi rzutowanie. Java pozwala rzutować typ A na typ B używając wyrażenia rzutowania, możesz je zobaczyć w przykładzie poniżej:

    public void differentTypes() { Object objectInstance = new Object(); Object stringInstance = "string"; String realString = (String) stringInstance; realString.length();}

  
Oczywiście nie każde rzutowanie jest poprawne. W przykładzie poniżej możesz zobaczyć błędne rzutowanie z typu Object na typ `String`. Tego typu operacje kończą się wyjątkiem w trakcie wykonania programu:

    public class RuntimeType { public static void main(String[] args) { Object[] someMysteriousObjects = new Object[] {"1234", new Object()}; String castedString = (String) someMysteriousObjects[0]; String classCastException = (String) someMysteriousObjects[1]; }}

    Exception in thread "main" java.lang.ClassCastException: java.lang.Object cannot be cast to java.lang.String at pl.samouczekprogramisty.kursjava.RuntimeType.main(RuntimeType.java:8)

  
Wyjątek mówi tyle, że obiektu typu `java.lang.Object` nie możemy rzutować do typu `java.lang.String`. Jakie rzutowanie jest w takim razie dozwolone? Możemy rzutować wyłącznie na typ, który znajduje się hierarchii dziedziczenia danego obiektu. Z tego właśnie powodu rzutowanie `String` na `Object` jest dopuszczalne ale odwrotna operacja kończy się błędem.

W jednym z kolejnych artykułów przeczytasz o typach generycznych, które pomagają rozwiązać część sytuacji, kiedy rzutowanie jest potrzebne. W codziennym programowaniu radziłbym unikać tego typu operacji. Z pewnością istnieje inny sposób napisania programu, który pozwoli na uniknięcie rzutowania.

# Konwersja
  
Rzutowanie to specyficzny przypadek konwersji, jest to konwersja jawna, wymuszona przez programistę. W trakcie niektórych operacji może dochodzić do automatycznej konwersji, konwersji niejawnej. Konwersja niejawna może wystąpić np. podczas wywołania metod czy operacji arytmetycznych. Poniżej przykład konwersji automatycznej, która zachodzi w trakcie wywołania metody:

    public class WideningConversion { public static void main(String[] args) { WideningConversion conversion = new WideningConversion(); int intVariable = Integer.MAX_VALUE; long longVariable = Long.MAX_VALUE; conversion.methodLongArgument(longVariable); conversion.methodLongArgument(intVariable); // extending conversion } public void methodLongArgument(long argument) { System.out.println(argument); }}

  
Dochodzi do konwersji ponieważ metoda `methodLongArgument` przyjmuje parametr typu `long` a jedno z wywołań przyjmuje zmienną typu `int`. Jest to tak zwana konwersja rozszerzająca. Może być wykonana niejawnie ponieważ podczas takiej konwersji nie zachodzi ryzyko utracenia informacji (o tym dalej). Kompilator robi to automatycznie za programistę. W przykładzie powyżej zmienna `intVariable` zostałą automatycznie rozszerzone do typu `long`. Nie utraciliśmy żadnych informacji ponieważ typ `long` zawsze może pomieścić liczby które przechowuje `int`. W przykładzie używam zmiennych statycznych `MAX_VALUE`, które są typu `int` lub `long` i trzymają największą liczbę możliwą do przechowywania przez dany typ.

Konwersja w odwrotną stronę wymaga już jawnego rzutowania. Taka konwersja może prowadzić do utraty informacji. Proszę spójrz na przykład:

    public class NarrowingConversion { public static void main(String[] args) { NarrowingConversion conversion = new NarrowingConversion(); int intVariable = Integer.MAX_VALUE; long longVariable = Long.MAX_VALUE; long longVariableWithoutLoosingInformation = Integer.MAX_VALUE; // automatic conversion from int to long conversion.methodIntArgument(intVariable); conversion.methodIntArgument((int) longVariable); conversion.methodIntArgument((int) longVariableWithoutLoosingInformation); } public void methodIntArgument(int argument) { System.out.println(argument); }}

  
Jak myślisz co zostanie wypisane na konsoli po uruchomieniu tego programu?

    2147483647-12147483647

  
Dziwne prawda? :) Środkowa linijka to nic innego jak właśnie "utrata informacji", która może zajść w trakcie jawnej konwersji[^konwersja]. Ostatnia linijka pokazuje, że nie każda konwersja z `long` do `int` prowadzi do utraty informacji.

[^konwersja]: Wartość -1 wynika ze sposobu zapisywania liczb w Javie. Wiesz już o [binarnym zapisie](http://www.samouczekprogramisty.pl/system-dwojkowy/), tutaj wykorzystywana jest jego specyficzna odmiana – uzupełnienia do dwóch, jeżeli jesteś zainteresowany szczegółami daj znać w komentarzu, skrobnę o tym artykuł :).

## Konwersja typów zmiennoprzecinkowych do całkowitoliczbowych
  
Innym przykładem konwersji w której dochodzi do utraty informacji jest konwersja z typów zmiennoprzecinkowych do typów całkowitoliczbowych:

```java
int intValue = (int) 123.123F;
long longValue = (long) 456.456;
```
  
W obu przypadkach tracimy informację o ułamku, zostaje wyłącznie część całkowitoliczbowa.

## Automatyczna konwersja podczas przypisania
  
Podobnie rzecz się ma w przypadku przypisania wartości zmiennej, tutaj także dochodzi do automatycznej konwersji. Poniższy przykład pokazuje kilka możliwych przypadków:

    public class AssignmentConversion { public static void main(String[] args) { long longValue = 123; int intValue = (short) 123; float floatValue = 12.12F; double doubleValue = floatValue; System.out.println(longValue); System.out.println(intValue); System.out.println(floatValue); System.out.println(doubleValue); }}

  
Pierwsza linijka metody `main` to niejawna konwersja z typu `int` na `long` (literały całkowitoliczbowe domyślnie są typu `int`), kolejna zawiera jawne rzutowanie 123 na typ `short`, które następnie konwertowane jest niejawnie z powrotem na typ `int`. Ostatni przykład to konwersja z typu `float` do `double`.
# Automatyczna konwersja podczas operacji arytmetycznych
  
Podczas operacji arytmetycznych także może dochodzić do niejawnej konwersji. Zgodnie ze specyfikacją języka Java (https://docs.oracle.com/javase/specs/jls/se7/html/jls-5.html#jls-5.6.2) możliwa jest konwersja (zachodzi pierwszy pasujący warunek):
1. rozszerzająca do typu `double` jeśli którykolwiek z elementów operacji arytmetycznej jest typu `double`,
2. rozszerzająca do typu `float` jeśli którykolwiek z elementów operacji jest typu `float`,
3. rozszerzająca to typu `long` jeśli którykolwiek z elementów operacji jest typu `long`,
4. rozszerzająca do typu `int`.
  
  
Wszystkie cztery przypadki pokazane są w przykładzie poniżej:

    public class ArithmeticConversion { public static void main(String[] args) { short shortValue = 1; int intValue = 1; long longValue = 2; float floatValue = 3.1F; double doubleValue = 4.1; System.out.println(intValue + doubleValue); System.out.println(intValue + floatValue); System.out.println(intValue + longValue); System.out.println(shortValue + shortValue); }}

  
Tutaj drobna dygresja, operator dzielenia (/) wykonuje w języku Java dzielenie całkowitoliczbowe jeśli dzielna i dzielnik są całkowitoliczbowe. Jeśli chcemy otrzymać typ zmiennoprzecinkowy co najmniej jeden z elementów musi być typu zmiennoprzecinkowego:

    5 / 2 = 25.0 / 2 = 2.55 / 2.0 = 2.56 / 2 = 36.0 / 2 = 3.0

# Boxing i unboxing
  
Jak wiesz w języku Java występują zarówno typy proste jak i obiekty reprezentujące liczby np. `int` i `Integer`. Kompilator Java jest w stanie dokonać konwersji pomiędzy odpowiadającymi sobie typami prostymi i obiektami automatycznie. Proszę spójrz na przykład poniżej

    int primitiveInt = new Integer(123);long primitiveLong = new Long(123L);float primitiveFloat = new Float(123.123F);double primitiveDouble = new Double(123.123);boolean primitiveBoolean = new Boolean(true);

  
Mamy tu do czynienia z tak zwanym "_unboxing_'iem", czyli automatycznym odpakowywaniem obiektu do odpowiadającego mu typu prostego.

    Integer objectInteger = 123;Long objectLong = 123L;Float objectFloat = 123.123F;Double objectDouble = 123.123;Boolean objectBoolean = true;

  
Przykłady powyżej pokazują z kolei "_boxing_", czyli automatyczne tworzenie instancji obiektów na podstawie typów prostych.

Podczas _boxingu_/_unboxingu_ może dość do rzucenia różnych wyjątków, na przykład gdy obiekt przypisywany do typu prostego jest nullem lub gdy do typu prostego próbujemy przypisać inny obiekt (np. `Long` do `int`).

# Konwersja do typu `String`
  
Konwersja do typu `String` jest specyficznym rodzajem konwersji automatycznej. Jest ona specyficzna ponieważ bazuje na metodzie `toString`, która może być przedefiniowana przez programistę. Konwersja do typu `String` zachodzi przy operatorze dodawania + jeśli któryś z dodawanych elementów jest typu `String`.

Typy proste także są automatycznie konwertowane do typu `String`, odbywa się to dwuetapowo, na początku zachodzi boxing następne obiekt konwertowany jest do typu `String` (wywoływana jest metoda `toString`).

    String x = "123" + new Object();String y = new Object() + "123";String z = 1 + "123";

# Zadania

1. Napisz program przyjmujący od użytkownika liczbę całkowitą i wyświetl wynik mnożenia tej liczby oraz stałej pi (`Math.PI`). Wyświetl wynik w postaci liczby całkowitej i liczby zmiennoprzecinkowej.
2. Napisz program pobierający od użytkownika dwie liczby całkowite. Wyświetl wynik ich dzielenia wraz z częścią ułamkową.
3. Napisz program, który skończy się wyjątkiem spowodowanym błędem podczas boxingu/unboxingu.
4. Jak myślisz co otrzymasz przypisując zmienną typu `char` do zmiennej typu `int`? Znajdziesz ten numer w [tabeli ASCII](https://pl.wikipedia.org/wiki/ASCII#Tabela)?
  
  
Przygotowałem też dla Ciebie zestaw [przykładowych rozwiązań zadań](https://github.com/SamouczekProgramisty/KursJava/tree/master/11_konwersja_rzutowanie/src/main/java/pl/samouczekprogramisty/kursjava/zadanie), analizując je także możesz się czegoś nauczyć.
# Dodatkowe materiały do nauki

- [https://docs.oracle.com/javase/specs/jls/se7/html/jls-15.html#jls-15.16](https://docs.oracle.com/javase/specs/jls/se7/html/jls-15.html#jls-15.16) – "cast expression",
- [https://docs.oracle.com/javase/specs/jls/se7/html/jls-5.html](https://docs.oracle.com/javase/specs/jls/se7/html/jls-5.html) – rzutowanie i konwersje,
- [https://github.com/SamouczekProgramisty/KursJava/tree/master/11\_konwersja\_rzutowanie](https://github.com/SamouczekProgramisty/KursJava/tree/master/11_konwersja_rzutowanie) – kod źródłowy przykładów użytych w artykule.
  

# Podsumowanie
  
Właśnie dowiedziałeś się o kilku kolejnych zakamarkach języka Java. Mam nadzieję, że Ci się podobało. Jak zwykle na koniec mam do Ciebie prośbę, podziel się artykułem ze swoimi znajomymi, zleży mi na dotarciu do jak największego grona czytelników. Jeśli nie chcesz pominąć żadnego postu polub Samouczka na facebooku. Do następnego razu! :)

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/parrhesiastes

