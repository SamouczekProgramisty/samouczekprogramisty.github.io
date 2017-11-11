---
title: Zestaw ćwiczeń dla początkujących programistów
date: '2016-03-13 13:33:03 +0100'
categories:
- Kurs programowania Java
permalink: "/zestaw-cwiczen-dla-poczatkujacych-programistow/"
header:
    teaser: /assets/images/2016/03/13_dodatkowe_zadania_artykul.jpg
    overlay_image: /assets/images/2016/03/13_dodatkowe_zadania_artykul.jpg
    caption: "[&copy; hades2k](https://www.flickr.com/photos/hades2k/)"
excerpt: Cześć! Dzisiaj będzie nietypowo. Nie będę miał dla Was nowej partii teorii a zestaw dodatkowych zadań, które możesz wykonać aby praktycznie przećwiczyć dotychczas zdobytą wiedzę. Nie ma lepszego sposobu nauki niż przez przykłady. Każde z zadań ma także gotowe rozwiązanie więc jeśli będziesz miał problem z którymkolwiek z nich pokażę Ci jego rozwiązanie. Zapraszam do klawiatury!
disqus_page_identifier: 263 http://www.samouczekprogramisty.pl/?p=263
---

{% include kurs-java-notice.md %}

Do rozwiązania zadań niezbędna będzie wiedza, którą możesz zdobyć czytając dotychczasowe artykuły. Jednak znajdą się też zadania, które będą wymagały dodatkowej lektury dokumentacji standardowej biblioteki Javy czy stron na Wikipedii. Aby wykonać te zadania musisz mieć wiedzę opisaną w artykułach w serii [kurs programowania java]({{ "/kurs-programowania-java/" | absolute_url }}) do artukułu o interfejsach włącznie.

Całość podzielona jest na części. Odpowiadają one artykułom, które do tej pory miałeś okazję przeczytać. Polecam robienie ich w kolejności – na przykład ciężko będzie Ci zrobić zadania związane z pętlami bez znajomości tablic.

Zadania starałem się zorganizować w ten sposób aby kolejne bazowały na stworzonych już metodach/obiektach. W codziennym programowaniu właśnie tak to wygląda, budujemy małe klocki, z których można złożyć większą całość. To też będziesz mógł przećwiczyć rozwiązując poniższe zadania.

## Operator `%`

Do tej pory nie opisałem jeszcze jednego dość przydatnego operatora w języku Java. Mianowicie `%`. Operator `%` zwraca resztę z dzielenia liczb. Najłatwiej będzie to zrozumieć na przykładzie

```java
4 % 3 == 1; // bo 3 mieści się raz w 4 i zostaje 1 reszty
8 % 3 == 2; // bo 3 mieści się dwa razy w 8 i zostaje 2 reszty
3 % 4 == 3; // bo 4 nie mieści się w 3 i zostaje 3 reszty
15 % 5 == 0; // bo 5 mieści się trzy razy w 15 i zostaje 0 reszty
```

Jeśli chcielibyśmy zapisać działanie tego operatora przy pomocy równania matematycznego moglibyśmy użyć następującego wzoru:

```java
(a / b) * b + (a % b) == a
```

Operator ten może się przydać na przykład do sprawdzenia czy liczba jest parzysta. Liczbę uważamy za parzystą jeśli jest podzielna przez 2 bez reszty

```java
boolean isEven = someNumber % 2 == 0;
```

## Zadania

### [Metody w języku Java]({% post_url 2015-10-22-metody-w-jezyku-java %})

1. Napisz metodę, która zwróci Twój aktualny wiek.
2. Napisz metodę, która zwróci Twoje imię,
3. Napisz metodę, która jako argument przyjmuje 2 liczby i wypisuje ich sumę, różnicę i iloczyn,
4. Napisz metodę, która jako argument przyjmuje liczbę i zwraca `true` jeśli liczba jest parzysta,
5. Napisz metodę, która jako argument przyjmuje liczbę i zwraca `true` jeśli metoda jest podzielna przez 3 i przez 5,
6. Napisz metodę, która jako argument przyjmuje liczbę i zwraca go podniesionego do 3 potęgi,
7. Napisz metodę, która jako argument przyjmuje liczbę i zwraca jej pierwiastek kwadratowy (poczytaj javadoc do klasy [Math](https://docs.oracle.com/javase/8/docs/api/java/lang/Math.html), znajdziesz tam metodę, która na pewno Ci pomoże),
8. Napisz metodę, która jako argument przyjmie trzy liczby. Metoda powinna zwrócić `true` jeśli z odcinków o długości przekazanych w argumentach można zbudować trójkąt prostokątny.

### [Obiekty i pakiety]({% post_url 2015-11-01-obiekty-w-jezyku-java %})

1. Utwórz klasę `Human` reprezentującą człowieka, musi posiadać atrybuty takie jak wiek, waga, wzrost, imię i płeć. Klasa powinna także zawierać metody `getAge`, `getWeight`, `getHeight`, `getName`, `isMale`.
2. Utwórz klasę reprezentującą prostokąt, musi posiadać atrybuty długość i szerokość. Klasa powinna posiadać metody obliczające pole, obwód i długość przekątnej.
3. Utwórz klasę o nazwie `MyNumber`, której jedyny konstruktor przyjmuje liczbę. Klasa powinna mieć następujące metody
  1. `MyNumber isOdd()` - `true` jeśli atrybut jest nieparzysty,
  2. `MyNumber isEven()` - `true` jeśli atrybut jest parzysty,
  3. `MyNumber sqrt()` - pierwiastek z atrybutu,
  4. `MyNumber pow(MyNumber x)` - atrybut podniesiony do potęgi x (przydatnej metody poszukaj w javadoc do klasy [Math](https://docs.oracle.com/javase/8/docs/api/java/lang/Math.html)),
  5. `MyNumber add(MyNumber x)` - zwraca sumę atrybutu i x opakowaną w klasę `MyNumber`,
  6. `MyNumber subtract(MyNumber x)` - zwraca różnicę atrybutu i x opakowaną w klasę `MyNumber`.

A teraz ciekawostka, jeśli rozwiązałeś zadanie 3. to muszę Ci zdradzić, że podobna klasa istnieje w standardowej bibliotece języka Java. Jest to klasa `BigInteger`/`BigDecimal`. Oczywiście jej możliwości są dużo bardziej rozbudowane, jednak zasada działania jest podobna.

### [Tablice]({% post_url 2015-11-11-tablice-w-jezyku-java %})

1. Napisz metodę, która zwróci tablicę `String[]` zawierającą pierwsze 5 liter alfabetu,
2. Napisz metodę pobierającą trójelementową tablicę liczb, która zwróci tablicę zawierającą te same elementy w odwróconej kolejności

Dużo zadań dotyczących tablic wymaga znajmości pętli, dlatego w następnym akapicie znajdziesz więcej interesujących zadań związanych z tablicami.

### [Pętle i instrukcje warunkowe]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %})

1. Utwórz metodę pobierającą dodatnią liczbę całkowitą X, która wyświetli na ekranie liczby od zera do X,
2. Jeśli w zadaniu 1. użyłeś pętli `for` przerób tą metodę na `while` (lub odwrotnie),
3. Napisz klasę `ArrayFactory`, która w konstruktorze pobierze liczbę całkowitą X większą od zera. Klasa powinna mieć 2 metody:
  1. `int[] oneDimension` - zwróci instancję tablicy jednowymiarowej o długości X,
  2. `int[][] twoDimension` - zwróci instację tablicy dwuwymiarowej gdzie liczba wierszy i liczba kolumn równa się X,

4. Utwórz metodę, która pobierze liczbę i wypisze każdy znak w osobnej linii zaczynając od ostatniej cyfry (np. dla liczby 123 będą to trzy linie z 3, 2 i 1),
5. Utwórz metodę, która jako argument pobierze obiekt klasy `String` i zwróci "odwrócony" argument. Na przykład "pies" przekształci w "seip",
6. Utwórz metodę, która pobierze liczbę oraz zwróci ją w formie binarnej (2 =\> "10", 4 =\> "100", 5 =\> "101", itd.). [System binarny](http://www.samouczekprogramisty.pl/system-dwojkowy/) opisałem w osobnym artykule,
7. Utwórz metodę, pobierającą łańcuch znaków, która sprawdzi czy jest on [palindromem](https://pl.wikipedia.org/wiki/Palindrom). Np. "kajak" jest palindromem (to samo czytane "od przodu i od tyłu") jednak "kotek" już nie. Może przydać Ci się metoda `String#toCharArray`
8. Do klasy `ArrayFactory` dodaj metodę zwracającą [macierz jednostkową](https://pl.wikipedia.org/wiki/Macierz_jednostkowa) (jedynki "na przekątnej"),
9. Napisz metodę, która pobierze tablicę liczb całkowitych i wyświetli ją w postaci "[liczba, liczba, liczba]",
10. Napisz metodę, która pobierze tablicę liczb całkowitych i posortuje ją w kolejności od najmniejszej do największej liczby. Jednym z podstawowych algorytmów sortowania jest [sortowanie bąbelkowe](https://pl.wikipedia.org/wiki/Sortowanie_b%C4%85belkowe).

Chociaż zadania wymagają wiedzy z zakresu podstaw języka Java nie są bardzo łatwe. Na pewno ciekawostką dla Ciebie będzie to, że na przykład zadanie z palindromem czasami trafia się na rozmowach rekrutacyjnych :)

### [Typy proste]({% post_url 2015-11-29-typy-proste-w-jezyku-java %})

W tej sekcji znajdują się głównie zadania, które wymagają znajomości klasy `Scanner` opisanej w artykule dotyczącym typów prostych.
1. Jeśli w klasie `Human` użyłeś typów prostych zamień je na odpowiadające im klasy (`int` =\> `Integer`),
2. Napisz program, który pobierze od użytkownika liczbę całkowitą a następnie wyświetli jej binarną reprezentację na ekranie,
3. Napisz program, który pobierze od użytkownika liczbę całkowitą N reprezentującą długość tablicy a następnie poprosi o N kolejnych liczb uzupełniając nimi wcześniej stworzoną tablicę. Wyświetl na konsoli tablicę posortowaną w kolejności od najmniejszej do największej liczby,
4. Napisz program, który pobierze od użytkownika łańcuch znaków i wyświetli na konsoli jego długość, informację czy jest to palindrom czy nie oraz jego odwróconą wartość.

### [Interfejsy]({% post_url 2015-12-16-interfejsy-w-jezyku-java %})

1. Stwórz interfejs `Figure`. Interfejs powinien zawierać metody `getPerimeter` (zwracającą obwód) oraz `getArea` (zwracającą powierzchnię). Następnie utwórz klasy `Circle`, `Triangle` i `Rectangle`, niech każda z klas implementuje interfejs `Figure`. Napisz program, który pobierze od użytkownika:
  1. długość promienia koła,
  2. 2 długości boków trójkąta prostokątnego (boki przy kącie prostym),
  3. długość boków prostokąta.

Utworzy instancje tych obiektów i umieści je w tablicy `Figure[]`. Następnie iterując po obiektach wyświetl pole oraz obwód aktualnego obiektu.

## Rozwiązania zadań

Starałem się nie korzystać z bibliotek/API, którego jeszcze nie poznaliśmy w ramach kursu. Używając bardziej zaawansowanych metod niektóre z przedstawionych tu zadań można rozwiązać lepiej, jednak na początek takie proste podejście w zupełności wystarczy. Prosiłbym Cię żebyś jednak spróbował rozwiązać zadania samodzielnie, dopiero jeśli nie będzie już innego wyjścia rzuć okiem na [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/12_dodatkowe_zadania/src/main/java/pl/samouczekprogramisty/kursjava).

Rozwiązania, które dostarczyłem nie są jedynymi możliwymi rozwiązaniami, Ty mogłeś rozwiązać dany problem zupełnie inaczej.

## Podsumowanie

Mam nadzieję, że zestaw zadań Ci się spodobał. Raz jeszcze prosiłbym Cię, żebyś rozwiązał je samodzielnie, wtedy nauczysz się najwięcej. Jeśli chciałbyś abym napisał kolejny artykuł tego typu daj znać ;) Jeśli będziesz miał problem z którymkolwiek z nich możesz rzucić okiem do gotowych rozwiązań.

Jeśli nie chcesz pominąć żadnego z kolejnych artykułów proszę polub naszą stronę na facebooku. Proszę Cię też abyś udostępnił ten artykuł innym Twoim znajomym, którzy mogą być zainteresowani – niezmiennie zależy mi na dotarciu do jak największej liczby czytelników. Do następnego razu! :)
