---
title: Typy proste w języku Java
date: '2015-11-29 14:34:32 +0100'
categories:
- Kurs programowania Java
permalink: "/typy-proste-w-jezyku-java/"
header:
    teaser: "/assets/images/2015/11/29_typy_proste_w_jezyku_java.jpg"
    overlay_image: "/assets/images/2015/11/29_typy_proste_w_jezyku_java.jpg"
---

{% include toc %}

Dzisiaj poznasz kilka nowych typów prostych oraz klas z biblioteki standardowej. Dowiesz się czym jest literał. Poznasz kilka przykładów literałów w języku Java. Przeczytasz też o sposobie pobierania danych od użytkownika. Z tych klocków poskładamy program do obliczania średniej temperatury dla ostatniego tygodnia. Do dzieła :)

{% include kurs-java-notice.md %}

## Typ prosty
  
Znasz już typy proste z poprzednich artykułów. `int` czy `boolean` są tu dobrymi przykładami. Typy proste nie są instancjami obiektów więc nie mają żadnych metod. Poniżej przykład zmiennych typów, które już znasz:

```java
int age = 18;
boolean isAdult = true;
```
  
Jednak poza powyższymi przykładami istnieją też inne typy proste:
- `byte` typ, który może przechowywać liczby całkowite z zakresu od -128 do 127,
- `short` typ, który może przechowywać liczby całkowite z zakresu od -32'768 do 32'767,
- `int` ten już znasz, nowy dla Ciebie będzie zakres możliwych liczb do przechowania -2'147'483'648 do 2'147'483'647,
- `long` podobnie jak poprzednie typy służy do przechowywania liczb całkowitych, jednak tutaj zakres jest znacznie większy: od -9'223'372'036'854'775'808 do 9'223'372'036'854'775'807.

```java
byte daysInMonth = 31;
short daysInYear = 365;
long veryLargeNumber = 72036854775807L;
```
  
Proszę zwróć uwagę na zmienną `veryLargeNumber`. Zauważyłeś `L` na końcu? Dołączenie `L` na końcu sprawia, że używamy literału innego typu.

### Czym jest literał?
  
Zaraz, zaraz! Czym jest literał!? To nic skomplikowanego, jest to po prostu fragment kodu programu, który może być przypisany do zmiennej i nie jest wywołaniem konstruktora ani złożoną instrukcją. Przykładowe literały, które przechowują liczby:

    18
    0b11100
    -0xFF00
    0777
    +78_123_898
    45L
    45l

- `18` - nic nowego, zwykła liczba, którą już znasz,
- `0b11100` - też liczba, tylko zapisana binarnie, o tym typie zapisywania liczb przeczytasz w jednym z kolejnych artykułów,
- `-0xFF00` - tym razem liczba zapisana w [systemie szesnastkowym](https://pl.wikipedia.org/wiki/Szesnastkowy_system_liczbowy),
- `0777` - tak wygląda liczba zapisana w [systemie ósemkowym](https://pl.wikipedia.org/wiki/%C3%93semkowy_system_liczbowy),
- `+78_123_898` - to nic innego jak `78123898`, tylko zapisane w troszkę inny sposób. Znak `+` na początku jest zbędny (domyślnie literały przechowują liczby dodatnie). Znaki `_` podobnie nie są obowiązkowe, służą jedynie do zwiększenia czytelności liczby.
- `45L` – domyślnie wszystkie literały liczb całkowitych mają typ `int`. Żeby dać znać kompilatorowi o tym, ze ten literał może przechowywać większe wartości musimy dodać `L` na końcu
- `45l` – podobnie jak powyżej literał typu `long`, jednak tutaj na końcu widzimy małą literę `l`. Mimo tego, że taka konstrukcja jest dopuszczalna nie jest dobrą praktyką. `l` często może być pomylone z `1`, szczególnie jeśli używana jest czcionka o stałej szerokości.

### Domyślna konwersja
  
Możesz zadać sobie teraz pytanie. Po co musimy dodawać `L` na końcu liczby typu `long` a nie musimy dodawać nic dla liczby typu `short` czy `int`? Okazuje się, że kompilator wykonuje za nas automatycznej konwersji typu.

```java
short daysInYear = (short) 365;
```
  
Wartość w nawiasie mówi o tym na jaki typ chcemy rzutować 365 będące typu `int`. W tym przypadku rzutowanie nie jest potrzebne bo kompilator wykona tą konwersję za nas. Jeśli jednak będziesz chciał przypisać wartość typu `int` do wartości typu `short` musisz takiej konwersji dokonać.

```java
int someSmallNumber = 356;
short daysInYear = (short) someSmallNumber;
```
  
W przykładzie powyżej kompilator już takiej konwersji nie wykona automatycznie, programista musi sam o nią zadbać.

Zupełnie inną sprawą jest czy powinniśmy tak robić :) Jakim cudem `int`, który może przechowywać dużo większe liczby może się "zmieścić" w typie `short`? Otóż nie może :)

```java
short overflow = (short) 1_111_111;
System.out.println(overflow);
```
  
Jak myślisz co zostanie wyświetlone na konsoli? Nie, nie będzie to 1'111'111. Komputer wyświetli -3001 :) Dzieje się tak dlatego, że liczba 1'111'111 jest większa od maksymalnej wartości jaką może przechowywać `short`.

To co musisz zapamiętać z tego podrozdziału to fakt, że część konwersji wykonywana jest automatycznie a część spada na programistę. Te drugie są bardziej niebezpieczne bo mogą prowadzić do niespodziewanych rezultatów.

### Znak
  
Znasz już klasę `String`. Instancja klasy `String` przechowuje łańcuch znaków. Pojedynczy znak natomiast może być przechowywany w zmiennej typu `char` jak w przykładzie poniżej.

```java
char firstAlphabetLetter = 'a';
```
  
`'a'` też jest literałem, jest to literał typu `char`. Jeśli jesteśmy przy znakach to możemy zahaczyć też o łańcuchy znaków. Znany Ci już `"xyz"` to literał typu `String`.

### Liczby zmiennoprzecinkowe
  
Do tej pory używaliśmy wyłącznie liczb całkowitych. W Javie istnieją też oczywiście typy proste, które mogą przechowywać liczby zmiennoprzecinkowe. Istnieją dwa takie typy:
- `float`,
- `double`.
  
Podobnie jak w przypadku `int` i `long`, `float` i `double` różnią się wielkością liczb, które mogą przechowywać. `double` może przechowywać dużo większe liczby niż `float`. Na końcu literałów typu `float` musimy dodawać `f` bądź `F` jak w przykładzie poniżej.

```
float pi = 3.14F;
double g = 9.80665;
```
  
Chociaż typy te doskonale nadają się do przechowywania np. temperatury w programie, który napiszesz w ramach ćwiczenia to już do "poważnych" obliczeń te typy się nie nadają. W dużym uproszczeniu można powiedzieć, że komputer ma problem z przechowywaniem pewnych ułamków. W poważniejszych obliczeniach wymagających liczb zmiennoprzecinkowych używamy innych typów takich jak `java.math.BigDecimal`.

123 jest literałem, podobnie jest z 3.14F, ten drugi to literał przechowujący liczbę zmiennoprzecinkową. W Javie zawsze do oddzielenia liczby całkowitej (3) od dziesiętnej (14) używamy znaku `.` (kropki).

## Typy proste a obiekty
  
Każdy z typów prostych ma odpowiadający mu obiekt:

```java
byte b1 = 10;
Byte b2 = new Byte((byte) 10);
 
short s1 = 10;
Short s2 = new Short((short) 10);
 
int i1 = 10;
Integer i2 = new Integer(10);
 
long l1 = 10L;
Long l2 = new Long(10L);
 
boolean bo1 = true;
Boolean bo2 = new Boolean(true)
 
char c1 = 'c';
Character c2 = new Character('c');
 
float f1 = 1.2F;
Float f2 = new Float(1.2F);
 
double d1 = 1.2;
Double d2 = new Double(1.2);
```
  
Jak widzisz tworzenie obiektów jest trochę "trudniejsze" niż tworzenie zmiennych typów prostych. Jednak nie jest to wymagane. W Javie istnieje tak zwany autoboxing/autounboxing:

```java
Byte b3 = 10;
Short s3 = 10;
Integer i3 = 10;
Long l3 = 10L;
Boolean bo3 = true;
Character c3 = 'c';
Float f3 = 1.2F;
Double d3 = 1.2
```
  
W przykładach powyżej kompilator Javy automatycznie opakował typy proste do obiektów (autoboxing). Operacja odwrotna (autounboxing) także jest możliwa:

```java
int i4 = new Integer(12);
```

## Pobieranie danych od użytkownika
  
Teraz jak znasz już wszystkie typy proste w języku Java nadszedł moment na napisane pierwszego interaktywnego programu. W programie zapytamy użytkownika o siedem kolejnych temperatur i policzymy średnią temperaturę. Do napisania takiego programu użyjemy znanych już pętli.

Zanim jednak do tego przejdziemy musisz poznać klasę `java.util.Scanner`. Jest to klasa dostępna w standardowej bibliotece Javy, która może nam pomóc w pobieraniu danych od użytkownika.

### Standardowe wejście i standardowe wyjście
  
W przypadku komputerów możemy mówić o tak zwanym standardowym wejściu i standardowym wyjściu. Możemy to uprościć do tego, że standardowe wyjście to znaki, które wypisujemy na konsoli. Standardowe wyjście jest reprezentowane przez obiekt `System.out`. Już to znasz: `System.out.println("standardowe wyjście")`. To nic innego jak użycie metody `println` na obiekcie `System.out`.

Klasa `Scanner` używa obiektu standardowego wejścia upraszczając programiście pobieranie danych od użytkownika:

```java
Scanner inputScanner = new Scanner(System.in);
```
  
Klasa `Scanner ma kilka ciekawych metod, których możemy użyć, m.in.:`
- `inputScanner.nextInt()`,
- `inputScanner.nextDouble()`.
  
Metody te odpowiednio pobierają liczbę całkowitą i liczbę zmiennoprzecinkową. Poniżej przykładowy program pobierający siedem temperatur dla kolejnych dni.

```java
public class AverageTemperature {
    public static void main(String... args) {
        double[] temperature = new double[7];
        Scanner inputScanner = new Scanner(System.in);
 
        for(int i = 0; i < temperature.length; i++) {
            System.out.println("Wprowadź liczbę " + i);
            temperature[i] = inputScanner.nextDouble();
        }
 
        double summarizedTemp = 0;
        for (double temp : temperature) {
            summarizedTemp += temp;
        }
 
        System.out.println("Średnia temperatura wynosi " + (summarizedTemp / temperature.length));
    }
}
```
  
Jeśli masz jakiekolwiek pytania dotyczącke kodu powyżej proszę zadaj je w komentarzach.

## Ćwiczenie
  
Teraz ćwiczenie dla Ciebie. Napisz program, który policzy średnią z kilku przedmiotów. Możemy założyć, że uczeń w szkole ma 3 przedmioty i z każdego z nich dostał po 4 oceny.

Do wykonania tego zadania możesz potrzebować tablic wielowymiarowych i zagnieżdżonych pętli. Dla przypomnienia możesz zajrzeć do [artykułu o tablicach wielowymiarowych]({% post_url 2015-11-11-tablice-w-jezyku-java %}) i [pętlach w języku Java]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}).

Zagnieżdżona pętla to nic innego jak pętla umieszczona w ciele innej pętli. Dla przykładu pętle, które mogą pomóc Ci wykonać zadanie mogą wyglądać tak:

```java
int numberOfClasses = 3;
int numberOfNotes = 4;
for (int classIndex = 0; classIndex < numberOfClasses; classIndex++) {
    for (int noteIndex = 0; noteIndex < numberOfNotes; noteIndex++) {
        // zadanie ;)
    }
}
```
  
Jeśli masz jakiekolwiek pytania podziel się nimi w komentarzach. Pochwal się też jeśli udało Ci się wykonać to zadanie :) Jeśli będziesz miał problemy z jego wykonaniem możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/KursJava/blob/master/06_typy_proste/src/main/java/pl/samouczekprogramisty/kursjava/primitivetypes/exercise/Excercise.java).

## Materiały dodatkowe
  
Temat bynajmniej nie jest wyczerpany. Jeśli chcesz bardziej pogłębić swoją wiedzę przygotowałem dla Ciebie zestaw linków z dodatkowymi materiałami do nauki. Część z nich jest w języku angielskim.
- [Dokumentacja do klasy Scanner](http://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html)
- [System szesnastkowy zapisu liczb](https://pl.wikipedia.org/wiki/Szesnastkowy_system_liczbowy),
- [System ósemkowy zapisu liczb](https://pl.wikipedia.org/wiki/%C3%93semkowy_system_liczbowy),
- [Rozdział w Java Language Specification dotyczący typów prostych](https://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.2),
- [Rozdzial w Java Language Specification dotyczący literałów](https://docs.oracle.com/javase/specs/jls/se8/html/jls-3.html#jls-3.10),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/blob/master/06_typy_proste/src/main/java/pl/samouczekprogramisty/kursjava/primitivetypes).
  
## Podsumowanie
  
Dzisiaj poznałeś całkiem sporo nowych rzeczy. Znasz już wszystkie typy proste w Javie i typy je opakowujące. Wiesz już czym jest literał i jakie są ich rodzaje. Umiesz pobierać dane od użytkownika. Innymi słowy masz już wszystkie klocki potrzebne do budowania interaktywnych programów :).

Mam nadzieję, że artykuł Ci się spodobał. Jeśli tak to proszę podziel się nim ze swoimi znajomymi. Jeśli chcesz wiedzieć o nowych wpisach proszę polub naszą stronę na facebooku. Trzymaj się! Do następnego razu!
