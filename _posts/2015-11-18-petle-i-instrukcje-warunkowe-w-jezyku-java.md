---
title: Pętle i instrukcje warunkowe w języku Java
date: '2015-11-18 23:46:40 +0100'
categories:
- Kurs programowania Java
permalink: /petle-i-instrukcje-warunkowe-w-jezyku-java/
header:
    teaser: /assets/images/2015/11/08_pierwszy_program_w_java.png
    overlay_image: /assets/images/2015/11/08_pierwszy_program_w_java.png
excerpt: W tej części kursu Javy poznasz pętle i instrukcje warunkowe. Dowiesz się kiedy ich używać. Poznasz parę trików IDE wraz z dobrymi praktykami. Całość zakończysz zestawem zadań, które wykonasz samodzielnie :). Pamiętaj, że bez pętli i instrukcji warunkowych nie napiszesz żadnego "poważniejszego" programu. Do kodu!
disqus_page_identifier: 113 http://www.samouczekprogramisty.pl/?p=113
---

{% include kurs-java-notice.md %}

## Operatory logiczne

Zanim przejdę do opisania instrukcji warunkowych przeczytasz coś więcej na temat operatorów logicznych.

`<` jest operatorem logicznym, który znasz z poprzednich artykułów. W Javie istnieje kilka operatorów logicznych:

- `==` równe,
- `<` mniejsze,
- `<=` mniejsze bądź równe,
- `>` większe,
- `>=` większe bądź równe

Ich działanie możesz zobaczyć na kilku przykładach poniżej:

```java
int x = 1;
int y = 1;
int z = 2;
 
x == y; // true
x == z; // false
x < y; // false
x < z; // true
x <= y; // true
// itd.
```
  
Proste operacje logiczne możesz ze sobą łączyć przy pomocy dodatkowych operatorów:
- `&&` logiczne i,
- `||` logiczne lub.
  
Pomocna przy tym może być następująca tabelka. Pokazuje ona podstawowe operacje logiczne[^algebra].

[^algebra]: Tzw. [algebrę Boole'a](https://pl.wikipedia.org/wiki/Algebra_Boole%E2%80%99a)

| Operacja          | Wynik  |
| :------:          | :---:  |
| prawda i prawda   | prawda |
| prawda i fałsz    | fałsz  |
| fałsz i prawda    | fałsz  |
| fałsz i fałsz     | fałsz  |
| prawda lub prawda | prawda |
| prawda lub fałsz  | prawda |
| fałsz lub prawda  | prawda |
| fałsz lub fałsz   | fałsz  |
  
Przekładając kilka powyższych linii na przykłady ze zmiennymi w Java wygląda to następująco:

```java
int x = 1;
int y = 1;
int z = 2;
x == y && z > y; // true && true => true
x <= y && z <= x; // true && false => false
x == y || z > y; // true || true => true
x <= y || z <= x; // true || false => true
```

Operatory w języku Java mają swój priorytet. Dzięki temu mnożenie jest wykonywane przed dodawaniem. Podobnie jest tutaj, operatory `<`, `==`, `<` itp. mają wyższy priorytet niż `&&` czy `||`.

## Instrukcje warunkowe

### Instrukcja `if`, `else if`, `else`
  
Do tej pory każda linijka kodu, którą napisałeś w działającym programie została wykonana. W większych programach często musimy decydować co powinno być wykonane. Np. jeśli jest temperatura jest większa niż 37°C[^zmiennyprzecinek] oznacza to, że możesz być chory. Jeśli jest mniejsza niż 36°C możesz być osłabiony.

 [^zmiennyprzecinek]: Tutaj lepszym pomysłem byłyby liczby "z przecinkiem", napisałem osobny artykuł na temat [liczb zmiennoprzecinkowych]({% post_url 2017-11-06-liczby-zmiennoprzecinkowe %}).

To jest najprostsza instrukcja warunkowa. Blok kodu zostanie wykonany jeśli wartość w nawiasie `()` będzie prawdą. W przykładzie sprawdzamy, czy temperatura jest mniejsza niż 36 stopni.

```java
if (temperature < 36) {
    System.out.println("Jesteś osłabiony?");
}
```
  
`else`, podobnie jak `if`, jest słowem kluczowym. Jeśli warunek przy instrukcji `if` nie zostanie spełniony wywołany zostanie zestaw instrukcji w bloku `else`.

```java
if (temperature < 36) {
    System.out.println("Jesteś osłabiony?");
}
else {
    System.out.println("Masz 36 lub więcej stopni.");
}
```

W języku Java możesz także połączyć `else` z `if` jak w przykładzie poniżej:

```java
int temperature = 38;
if (temperature < 36) {
    System.out.println("Jesteś osłabiony?");
}
else if (temperature < 37) {
    System.out.println("Wszystko w normie!");
}
else if (temperature < 38) {
    System.out.println("Jesteś przeziębiony?");
}
else {
    System.out.println("Masz co najmniej 38 stopni! Biegiem do lekarza!");
}
```
  
Kod ten na początku sprawdza czy temperatura jest mniejsza niż 36°C. Jeśli ten warunek nie jest spełniony sprawdzamy czy temperatura jest mniejsza niż 37°C. Podobnie działa kolejny warunek. Jeśli żaden z nich nie jest spełniony zostaje wykonany kod w bloku po `else`.

### Instrukcja `switch`
  
Jeśli mamy kilka warunków `if` następujących po sobie możemy zamienić je na inną konstrukcję - `switch`. Przejdźmy od razu do przykładu:

```java
int temperature = 37;
switch (temperature) {
    case 35:
        System.out.println("Jesteś osłabiony?");
        break;
    case 36:
        System.out.println("Wszystko w normie!");
        break;
    case 37:
        System.out.println("Jesteś przeziębiony?");
        break;
    case 38:
        System.out.println("Chyba jesteś chory.");
        break;
    default:
        System.out.println("Nie wiem jak się czujesz :(");
        break;
}
```
  
`switch` w przykładzie powyżej sprawdza wartość zmiennej `temperature` i w zależności od jej wartości wykonuje odpowiedni kod zdefiniowany w `case` poniżej. W naszym przypadku na ekranie zostanie wypisane `Jesteś przeziębiony?`.

Proszę zwróć uwagę na nowe słowo kluczowe `break`. `switch` dopasowuje `case` do wartość zmiennej, i wykonuje kod od pierwszego pasującego warunku do słowa kluczowego `break`.

```java
int temperature = 35;
switch (temperature) {
    case 35:
        System.out.println("Jesteś osłabiony?");
    case 36:
        System.out.println("Wszystko w normie!");
    case 37:
        System.out.println("Jesteś przeziębiony?");
        break;
    case 38:
        System.out.println("Chyba jesteś chory.");
        break;
}
```

W przykładzie powyżej `break` zostało pominięte przy `case 35` oraz `case 36`. Wartość zmiennej pasuje do `case 35`. Przez pominięcie słowa kluczowego `break` na ekranie zostaną wypisane 3 linijki. Dzieje się tak dlatego, że słowo kluczowe `break` zostało wypisane dopiero przy case 37.

    Jesteś osłabiony?
    Wszystko w normie!
    Jesteś przeziębiony?
  
Warunek `default` zostaje wykonany jeśli żadna gałąź `case` nie pasuje do wartości zmiennej. Zachęcam Cię do eksperymentowania :).

Instrukcja `switch` jest trochę ograniczona. Sprawdzana zmienna może być zmienną kilku typów np. `int` czy `String`.

## Pętle w języku Java

### Pętla `for`
  
Pętla pozwala na wykonanie fragmentu kodu wielokrotnie. Na przykład jeśli chcemy wypisać wszystkie liczby od 0 do 10 możemy to zrobić przy pomocy pętli

```java
for (int number = 0; number <= 10; number++) {
    System.out.println(number);
}
```
  
Pierwsza linijka to nic innego jak właśnie definicja pętli `for`. Kod wewnątrz nawiasu `()` możemy podzielić na trzy części:
1. inicjalizacja zmiennych,
2. sprawdzenie warunku,
3. zmiana wartości zmiennych.
  
W części inicjalizującej zmienne robimy coś co już znasz, tworzymy zmienną `number` i przypisujemy jej wartość `0`. Kolejna część to sprawdzenie czy wartość zmiennej jest mniejsza bądź równa `10`. Nowa dla Ciebie jest trzecia część a właściwie operator `++`. Proszę spójrz na przykład poniżej:

```java
int counter = 0;
counter = counter + 1;
counter += 1;
counter++;
```
  
Każda z trzech ostatnich linii zwiększa o jeden wartość zmiennej `counter`. Ostatnia wersja jest najkrótsza dlatego jest najczęściej spotykana w tego typu pętlach.

Kolejnym przykładem użycia pętli może być wyświetlenie każdego elementu tablicy

```java
int[] primeNumbers = new int[] {2, 3, 5, 7};
for (int index = 0; index < primeNumbers.length; index++) {
    System.out.println(primeNumbers[index]);
}
```
  
W pierwszej linijce definiujemy tablicę z kilkoma liczbami pierwszymi (jeśli nie wiesz czym są liczby pierwsze możesz przeczytać o nich w [artykule na wikipedii](https://pl.wikipedia.org/wiki/Liczba_pierwsza)). Następnie w pętli wyświetlamy każdy element tej tablicy.

Istnieje też uproszczona wersja pętli `for`. Jeśli nie musisz mieć dostępu do zmiennej reprezentującej np. indeks tablicy możesz użyć poniżej wersji pętli.


```java
for (int primeNumber : primeNumbers) {
    System.out.println(primeNumber);
}
```
  
Tutaj w pierwszej linijce do zmiennej `primeNumber` przypisujemy kolejne elementy tablicy `primenNumbers`, które następnie wyświetlamy na ekranie.

#### Live templates
  
Obie wersje pętli for możesz utworzyć dużo łatwiej. Z jednego z poprzednich artykułów wiesz już o istnieniu live templates. Okazuje się, że IDE pomaga nam także w tworzeniu pętli. Wystarczy, że wpiszesz `fori` i naciśniesz `Enter`, IDE wstawi szablon pętli za Ciebie. Jeśli w ten sam sposób chcesz wstawić szablon uproszczonej pętli for możesz wpisać `I` i nacisnąć `Enter`.

### Pętla while
  
W języku Java istnieją także inne konstrukcje pętli. Kolejnym przykładem jest pętla `while`. Tym razem przejdziemy od razu do przykładu

```java
int number = 0;
while (number < 10) {
    System.out.println(number);
    number++;
}
```
  
Pętla `while` wykonuje swoje ciało (kod wewnątrz `{}`) tak długo jak spełniony jest warunek zapisany pomiędzy `()` (lub pętla nie zostanie przez nas przerwana). Podobnie jak w poprzenich przykładach pętla wyświetla zestaw liczb, tym razem liczby od 0 do 9.

Poniżej kolejny przykład pętli `while`. Tym razem warunek zakończenia pętli sprawdzany jest w jej ciele. Użyliśmy do tego celu instrukcji warunkowej `if`. Słowo kluczowe `break` napotkane wewnątrz pętli natychmiast przerywa jej wykonanie (dotyczy to także pętli `for`).

```java
int number = 0;
while (true) {
    System.out.println(number);
    number++;
    if (number == 10) {
        break;
    }
}
```

### Nieskończona pętla
  
Pętle mają to do siebie, że przy źle zdefiniowanych warunkach mogą wykonywać kod wewnątrz swojego ciała w nieskończoność. Jest to dość częsty błąd, szczególnie spotykany na początku przygody z programowaniem. Dlatego należy uważnie sprawdzać warunki zakończenia pętli, żeby uniknąć tego błędu.

Poniżej przykład pętli wyświetlającej `1` w nieskończoność.

```java
while(true) {
    System.out.println(1);
}
```

## Zadania

1. Poza poznanym dzisiaj operatorem `++` istnieje też jego odpowiednik zmniejszający wartość zmiennej o 1. Jest nim `--`. Napisz program, który wypisze na ekranie malejąco wszystkie liczby od 20 do 10.
2. Napisz pętlę while, która wypisze na ekranie wszystkie liczby od 10 do 20 włącznie.
3. Napisz pętlę for, która wypisze na ekranie wszystkie liczby nieparzyste od -10 do 40.
4. Przerób pętlę z zadania trzeciego na pętlę while.
5. Napisz metodę, która jako jedyny argument przyjmie zmienną typu `int[]` i zwróci sumę wszystkich elementów tablicy.
6. Przerób funkcję z zadania piątego tak, żeby metoda przymowała tablicę dwuwymiarową typu `int[][]`.
  
Przygotowałem też [zestaw przykładowych rozwiązań](https://github.com/SamouczekProgramisty/KursJava/tree/master/05_petle/src/main/java/pl/samouczekprogramisty/kursjava/loops/exercise) powyższych zadań. Zachęcam jednak do ich samodzielnego rozwiązania, wtedy nauczysz się najwięcej.

## Podsumowanie
  
Dzisiaj znów nauczyłeś się paru nowych rzeczy dotyczących Javy. Mam nadzieję, że artykuł Ci się spodobał. Jeśli tak będę wdzięczny jeśli podzielisz się nim ze swoimi znajomymi. Proszę polub stronę na facebooku jeśli nie chcesz pominąć żadnego nowego artykułu. Na dzisiaj już starczy wiedzy :) Miłego dnia i do następnego razu!
