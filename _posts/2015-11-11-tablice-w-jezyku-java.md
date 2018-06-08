---
title: Tablice w języku Java
date: '2015-11-11 08:39:54 +0100'
categories:
- Kurs programowania Java
permalink: /tablice-w-jezyku-java/
header:
    teaser: /assets/images/2015/11/11_tablice_w_jezyku_java.png
    overlay_image: /assets/images/2015/11/11_tablice_w_jezyku_java.png
excerpt: Dzisiaj dowiesz się czegoś więcej o tablicach w języku Java. Przeczytasz czym są „Magic Numbers” i dlaczego są złe. Poznasz też metody o zmiennej liczbie argumentów. Na koniec czeka na Ciebie zestaw zadań do wykonania wraz z przykładowymi rozwiązaniami.
disqus_page_identifier: 155 http://www.samouczekprogramisty.pl/?p=155
---

{% include kurs-java-notice.md %}

## Czym jest tablica

Tydzień ma siedem dni. Załóżmy, że pierwszy dzień tygodnia to poniedziałek. Wtorek jest drugi, środa jest następna itd. Dni możemy ułożyć w swego rodzaju ponumerowany szereg.

Tablica jednowymiarowa to nic innego jak właśnie taki ponumerowany szereg. W Javie elementy w tablicy numerujemy od 0. Więc w naszym przypadku poniedziałek ma numer 0, wtorek 1 itd. Numer identyfikujący każdy element tablicy to indeks.

Tablice grupują obiekty tego samego typu[^tablice]. Mogą to być łańcuchy znaków, liczby, wartości logiczne, instancje klas stworzonych przez Ciebie, itd.

[^tablice]: Znów uproszczenie, jak poznamy dziedziczenie dowiesz się trochę więcej na ten temat.

### Tworzenie tablicy
  
Przekładając nasz przykład z dniami tygodnia na Javę dojdziemy do takiego fragmentu kodu

```java
String[] daysOfWeek = new String[7];
daysOfWeek[0] = "poniedziałek";
daysOfWeek[1] = "wtorek";
daysOfWeek[2] = "środa";
daysOfWeek[3] = "czwartek";
daysOfWeek[4] = "piątek";
daysOfWeek[5] = "sobota";
daysOfWeek[6] = "niedziela";
```
  
W pierwszej linijce tworzymy nową tablicę obiektów typu `String`. Tablica może pomieścić 7 elementów. Poniedziałek ma indeks 0, niedziela ma indeks 6.

Raz przypisany obiekt w tablicy możemy nadpisać.

```java
daysOfWeek[0] = "Monday";
```
  
Teraz pod indeksem 0 znajduje się `Monday`, pod 1 bez zmian nadal jest `wtorek`.

Jeśli spróbujesz odwołać się do nieistniejącego elementu w tablicy zostanie rzucony wyjątek `java.lang.ArrayIndexOutOfBoundsException`. O wyjątkach przeczytasz w jednym z kolejnych artykułów. Aktualnie wystarczy Ci informacja, że wyjątki sygnalizują sytuacje wyjątkowe :) i mogą przerwać działanie programu. Poniższa linijka zakończy program wyjątkiem, odwołujemy się tam do ósmego, nieistniejącego elementu tablicy.

 ```java
System.out.println(daysOfWeek[7]);
```
  
Tablicę można też od razu zainicjalizować wartościami. Oba sposoby inicjalizacji tworzą obiekt tablicy. Zauważ, że w drugim przypadku nie musimy podawać jej długości. Jest ona znana na podstawie przekazanych wartości.

```java
String[] wintersMonths = new String[] {"grudzień", "styczeń", "luty"};
```

{% include newsletter-srodek.md %}

### Atrybut length
  
Tablica to obiekt. Podobnie jak inne obiekty posiada swoje atrybuty i metody. Jedynym publicznie dostępnym atrybutem metody jest `length`. Atrybut ten przechowuje rozmiar tablicy

```java
System.out.println(wintersMonths.length); // w naszym przypadku wyświetli 3
```

## Tablice wielowymiarowe
  
Wyżej napisałem, ze w tablicy możesz trzymać dowolny obiekt. Tablica też jest obiektem :) Więc nic nie stoi na przeszkodzie, żeby w tablicach umieścić inne tablice. Tablica dwuwymiarowa to nic innego jak tabela zawierająca wiersze i kolumny w której możesz przechowywać dane.

Nic nie stoi na przeszkodzie do tworzenia tablic, które mają więcej niż 2 wymiary, jednak w praktyce raczej ich się nie spotyka. Jeśli potrzebna jest tak skomplikowana tablica programiści zazwyczaj przechowują dane w inny sposób używając zbiorów, map czy list[^kolekcje].

[^kolekcje]: Są to 3 podstawowe typy kolekcji w języku Java. Przeczytasz o nich w jednym z kolejnych artykułów.

W naszym przykładzie tablicy dwuwymiarowej użyjemy do przechowywania stanu gry kółko krzyżyk

```java
int[][] ticTacToeBoard = new int[3][];
ticTacToeBoard[0] = new int[3];
ticTacToeBoard[1] = new int[3];
ticTacToeBoard[2] = new int[3];
```
  
W pierwszy wierszu inicjalizujemy wyłącznie jeden z wymiarów. Musimy tam podać tylko liczbę wierszy, które będzie przechowywała nasza tablica dwuwymiarowa. Kolejne 3 linie kodu to inicjalizacja wierszy tablicy.

Jeśli każdy z wierszy tablicy wielowymiarowej ma dokładnie taki sam rozmiar możemy zainicjalizować ją w jednej linijce. Poniższy przykład ma ten sam efekt jak poprzedni:

```java
int[][] ticTacToeBoard = new int[3][3];
```
  
`ticTacToeBoard[0]` odwołuje się do pierwszego wiersza w tablicy. `ticTacToeBoard[0][0]` odwołuje się do pierwszej komórki w pierwszym wierszu. W ten sposób każde pole na naszej planszy ma unikalny indeks składający się z dwóch liczb:

| 00 | 01 | 02 |
| 10 | 11 | 12 |
| 20 | 21 | 22 |
  
Podobnie jak w przypadku tablicy jednowymiarowej i tu możemy przypisywać wartości. Poniżej przykładowy przebieg gry.

```java
int nought = 1; // kółko
int cross = 2; // krzyżyk
ticTacToeBoard[1][1] = nought;
ticTacToeBoard[2][2] = cross;
ticTacToeBoard[0][0] = nought;
ticTacToeBoard[1][2] = cross;
ticTacToeBoard[0][2] = nought;
ticTacToeBoard[0][1] = cross;
```
  
Spróbuj narysować sobie na kartce powyższy przebieg gry. Kto ma szanse na wygraną? :)

### Magiczne liczby
  
Przykład z planszą do gry świetnie nadaje się do wytłumaczenia czym właściwie są magiczne liczby (ang. _magic numbers_). W kodzie programu bardzo często występują liczby. Liczby te w rzeczywistości mają jakieś znaczenie. W naszym przykładzie 1 to nie zwykła jedynka a wartość oznaczająca kółko. Dobrą praktyką jest przypisanie takich „magicznych wartości” do zmiennych/stałych[^stale] i używanie ich w kodzie. Na dłuższą metę kod używający nazwanych zmiennych w miejscu „magic numbers” jest bardziej czytelny i łatwiejszy w utrzymaniu.

[^stale]: O stałych przeczytasz w innym artykule.

```java
ticTacToeBoard[1][1] = nought;
ticTacToeBoard[2][2] = cross;
ticTacToeBoard[1][1] = 1;
ticTacToeBoard[2][2] = 2;
```
  
Poza czytelnością zyskujemy kolejną rzecz. Nie łamiemy zasady DRY (ang. _Don't Repeat Yourself_)[^dry].

[^dry]: W uproszczeniu zasada mówi o nie powtarzaniu tego samego kodu wielokrotnie, przeczytasz o tym w jednym z kolejnych artykułów. Poprę to lepszym przykładem niż ten w tym artykule.

## Metody o zmiennej liczbie argumentów
  
Znasz już metodę `main`, domyślnie przyjmuje ona tablicę łańcuchów znaków. Równie dobrze metodę tą możemy zapisać jako

```java
public static void main(String ... args);
```
  
Inny przykład metody z wieloma argumentami to metoda sumująca wszystkie przekazane liczby:

```java
int sum(int ... numbers);
```
  
Magiczny wielokropek to coś w rodzaju wzbogacenia składni (ang. _syntactic sugar_). Nasza metoda z przykładu może przyjąć dowolną liczbę argumentów. W szczególności może też nie przyjąć żadnego.

```java
sum();
sum(1, 2, 3);
```
  
Metody mogą przyjmować wiele argumentów. Jednak argument z wielokropkiem może być tylko jeden i musi występować jako ostatni.

Jak wspomniałem wielokropek to wzbogacenie składni. W rzeczywistości metody są tożsame:

```java
int sum(int ... numbers);
int sum(int[] numbers);
```

## Materiały dodatkowe

Jeśli chcesz przeczytać o tablicach w innym miejscu zachęcam do rzucenia okiem na linki poniżej:

 - [Fragment wykładu na jednym z uniwersytetów w Stanach Zjednoczonych dotyczący tablic](https://www.andrew.cmu.edu/course/15-121/lectures/Arrays/arrays.html).

## Zadania

1. Napisz metodę pobierającą dwuelementową tablicę liczb i zwracający ich sumę.
2. Napisz program pobierający trójelementową tablicę liczb i zwracający największą liczbę.
3. Jak przechowałbyś stan sudoku? Napisz program, który stworzy instancje tablicy służących do przechowywania [sudoku](https://pl.wikipedia.org/wiki/Sudoku) i uzupełnij ją [przykładową planszą](https://pl.wikipedia.org/wiki/Sudoku#/media/File:Sudoku_przyklad.png).
4. Jak przechowałbyś stan gry w szachy? Napisz program, który stworzy instancje tablic służące do przechowywania stanu gry w szachy. Potrafiłbyś zachować w nim ostatni stan partii [Kasparowa z Deep Blue](https://en.wikipedia.org/wiki/Deep_Blue_versus_Garry_Kasparov#Game_5_2)?
  
Zachęcam Cię, do samodzielnego rozwiązania zadań, jeśli jednak miałbyś jakikolwiek problem możesz rzucić okiem na [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/04_tablice/src/main/java/pl/samouczekprogramisty/kursjava/arrays/exercise). Pamiętaj, że rozwiązując zadania samodzielnie nauczysz się najwięcej.

## Podsumowanie
  
Bardzo się cieszę, że przeczytałeś artykuł aż do końca. Jeśli masz jakiekolwiek uwagi proszę podziel się nimi w komentarzach. Byłbym także bardzo wdzięczny gdybyś przekazał swoim znajomym informację o blogu – jak zawsze zależy mi na dotarciu do jak największej grupy ludzi, którzy chcą uczyć się programować.

Jak zwykle informacje o artykule prezentuję na stronie na Facebooku, polub ją a będziesz otrzymywał informacje o nowych artykułach.
