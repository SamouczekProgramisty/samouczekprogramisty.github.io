---
title: Metody w języku Java
last_modified_at: 2018-08-20 16:31:08 +0200
categories:
- Kurs programowania Java
- Programowanie
permalink: /metody-w-jezyku-java/
header:
    teaser: /assets/images/2015/10/22_metody_w_jezyku_java.png
    overlay_image: /assets/images/2015/10/22_metody_w_jezyku_java.png
excerpt: Artykułem tym rozpoczynam serię artykułów – kurs programowania w języku Java. Po przeczytaniu tego artykułu będziesz wiedzieć czym jest typ danych, dowiesz się czym jest metoda. Poznasz kilka podstawowych rodzajów danych (typów). Postaram się też przekazać Ci kilka dobrych praktyk. Zaczynamy!
disqus_page_identifier: 63 http://www.samouczekprogramisty.pl/?p=63
---

{% include kurs-java-notice.md %}

# Metoda

```java
boolean isBig(int someNumber) {
    return someNumber > 100;
}
```

Więc jesteś już po przeczytaniu swojego pierwszego fragmentu kodu! Brawo! Programowanie to nie tylko pisanie, ale także czytanie kodu. Ale do rzeczy...

Metoda to nic innego jak worek grupujący zestaw instrukcji. Kod grupujemy w ten sposób z kilku powodów. Wymienię dwa, które moim zdaniem są najważniejsze:

- jeśli jakiś fragment kodu ma być wykonany w wielu miejscach zdecydowanie lepiej jest utworzyć metodę i ją uruchomić (wywołać), niż kopiować ten sam fragment kodu wielokrotnie. Jest to istotne ponieważ w przypadku błędu trzeba go poprawić w jednym miejscu a nie w kilku[^dry],
- programy są duże, bez odpowiedniego podziału opanowanie całego projektu/programu jest bardzo czasochłonne. Sensowny podział na mniejsze części pozwala szybciej zrozumieć kod.

[^dry]: DRY (ang. _Don't Repeat Yourself)_ zasada kładąca nacisk na redukcję powtarzającego się kodu.

# Typy danych

Zadnim przejdę do omówienia metod musisz dowiedzieć się czym są typy danych.

Metoda wyżej przyjmuje argument `someNumber`. Argument ten ma swój typ `int`. Typ w języku programowania opisuje rodzaj danych. Na przykład w kodzie powyżej widoczne są dwa typy:
- `boolean` – typ przechowujący wartości prawda/fałsz. Prawda reprezentowana jest przez wartość `true`. Fałsz to `false`. Typ ten może nam pomóc przechowywać informację o tym czy ktoś jest wysoki, czy jest pełnoletni, czy ma niebieski kolor oczu itp.

```java
boolean isTall = true;
boolean hasBlueEyes = false;
```

- `int` – typ przechowujący liczby całkowite. Liczby te możesz zapisać na wiele sposobów, skupię się na najprostszym – ciąg cyfr (opcjonalnie poprzedzony znakiem). Ten typ może nam posłużyć do przechowywania informacji o aktualnej temperaturze, wzroście, odległości z miasta A do B itp.

Tutaj muszę też powiedzieć o pewnych ograniczeniach. `int` podobnie jak każda inna wartość reprezentowana jest w pamięci komputera. Każda z wartości zajmuje określony rozmiar pamięci. Przez to ograniczenie nie jesteśmy w stanie przechowywać wszystkich liczb w zmiennej. W przypadku Javy w zmiennej typu `int` możemy przechowywać liczby od -2 147 483 648 do 2 147 483 647. Jak widzisz są do dość duże liczby jednak do pewnych zastosowań potrzebujemy innych typów danych.

```java
int temperature = -12;
int height = 186;
int distance = 2589;
int numberOfErrors = 0;
```

Innym popularnym typem danych jest `String`. Służy on do przechowywania łańcuchów znaków:

```java
String name = "Marcin";
String weekday = "Monday";
String someSentence = "Samouczek Programisty jest git ;)";
```

# Omówienie składni definiowania metody

Powtórzę ten sam fragment kodu jeszcze raz:

```java
boolean isBig(int someNumber) {
    return someNumber > 100;
}
```

Powyższe trzy linijki to definicja metody. W ten sposób tworzy się metodę. Metoda to zestaw instrukcji, który opcjonalnie może zwracać jakąś wartość. Szablon metody wygląda następująco:

    <typ zwracany> <nazwa metody>(<opcjonalna lista argumentów>) {
        <ciało metody>
    }

## Argumenty metody

Metody mogą przyjmować dowolnie dużo argumentów albo mogą nie przyjmować ich wcale. To, że jest to możliwe nie oznacza, że tak powinno się robić. W większości przypadków metody zawierające dużą liczbę argumentów są oznaką złych praktyk (ang. _code smell_). Duża liczba argumentów w metodzie pogarsza czytelność kodu.

Argumenty zawsze mają postać `<typ argumentu> <nazwa argumentu>`. Jeśli występuje więcej argumentów oddzielone są one przecinkiem. Na przykład metoda niżej pobiera trzy argumenty i zwraca ich sumę:

```java
int addNumbers(int number1, int number2, int number3) {
    return number1 + number2 + number3;
}
```

{% include newsletter-srodek.md %}

## Wartość zwracana

Metoda może zwracać jakąś wartość. Do zwrócenia wartości z metody służy słowo kluczowe `return`. Na przykład metoda niżej nie pobiera żadnych argumentów i zwraca łańcuch znaków:

```java
String getName() {
    return "Marcin";
}
```

Metoda może także nie zwracać żadnej wartości, wówczas używa się słowa kluczowego `void` do określenia typu zwracanej wartości. Na przykład metoda poniżej nie przyjmuje żadnych argumentów i nie zwraca żadnej wartości:

```java
void printSomething() {
    System.out.println("Something");
}
```

Jeśli metoda nie zwraca żadnej wartości również możesz użyć w jej ciele słowa kluczowego `return`. W takim przypadku `return` służy do wcześniejszego zakończenia działania metody (nie przejmuj się konstrukcją `if`, omówię ją niżej):

```java
void printSomethingIfNumberIsBig(int number) {
    if (number < 10) {
        return;
    }
    System.out.println("Something");
}
```

Wiesz już, że metody mogą przyjmować wiele argumentów. W języku Java nie jest możliwe zwracanie wielu wartości. Metoda może nie zwrócić nic (`void`) lub pojedynczą wartość.

## Ciało metody

Ciało metody to kod zawarty pomiędzy nawiasami klamrowymi `{}`. Przeanalizuję teraz ciała trzech metod pokazanych powyżej. 

Metoda `printSomething` nie zwraca żadnej wartości. W środku zawiera wyłącznie fragment kodu. W tym przypadku zawiera wywołanie metody `System.out.println`. Ta metoda wyświetla przekazany argument na konsoli:

```java
System.out.println("Something");
```

Metoda `addNumbers` dodaje trzy zmienne `number1`, `number2` i `number3`. Wynik dodawania zwracany jest jako wynik metody. Słowo kluczowe `return` wskazuje wynik metody:

```java
return number1 + number2 + number3;
```

Podobnie w przypadku metody `isBig` słowo kluczowe `return` wskazuje wynik:

```java
return someNumber > 100;
```

Ciało tej metody zawiera operator porównania `>`. `someNumber > 100` może zwrócić wartość logiczną. W zależności od wartości zmiennej `someNumber` wartość ta będzie różna:
- jeśli `someNumber` równa się 10 wówczas `someNumber > 100` oznacza fałsz – `false`,
- jeśli `someNumber` równa się 100 wówczas `someNumber > 100` oznacza fałsz – `false`,
- jeśli `someNumber` równa się 101 wówczas `someNumber > 100` oznacza prawdę – `true`.

Pamiętaj o tym, że słowo kluczowe `return` może występować w metodach, które nie zwracają żadnej wartości.
{:.notice--warning}

## Definicja metody a jej wywołanie

Musisz nauczyć się rozróżniać dwa różne zapisy. Definicję metody:

```java
boolean isBig(int someNumber) {
    return someNumber > 100;
}
```

Wywołanie metody:

```java
boolean someVariable = isBig(10);
```
```java
printSomething();
````

Pierwszy z nich to definicja metody. W ten sposób tworzy się metodę. Samo utworzenie metody nie powoduje jej wywołania. Drugi fragment kodu to wywołanie metody `isBig` i przypisanie wyniku do zmiennej `someVariable`. W trzecim fragmencie wywołana jest metoda `printSomething`.

Teraz celowo trochę zamieszam Ci w głowie. Spójrz na kod poniżej:

```java
boolean isBig = isBig(10);
```

Ta linijka to wywołanie metody `isBig`, która zwraca wartość i przypisuje ją do zmiennej o nazwie `isBig`. W tym przypadku `isBig` może oznaczać dwie różne rzeczy:

- nazwę metody,
- zmienną przechowującą typ `boolean` – w tym przypadku wynik działania metody `isBig`.

## Wywołanie metody

Wiesz już, że samo utworzenie metody nic nie daje. Metodę trzeba wywołać, aby została wykonana. Zwróć uwagę na ten fragment kodu:

```java
int someNumber = 123;
boolean result = isBig(someNumber);
```

Ten fragment kodu zawiera kolejno:
1. Pierwsza linijka to utworzenie zmiennej i przypisanie do niej wartości:
    1. `int` określający typ zmiennej,
    2. `someNumber` nazwa zmiennej,
    3. znak `=`, który oznacza przypisanie do zmiennej,
    4. wartość `123`, tak zwany literał.
2. Druga linijka to wywołanie metody i przypisanie wyniku do zmiennej:
    1. `boolean` określający typ zmiennej,
    2. `result` nazwę zmiennej,
    3. znak przypisania,
    4. wywołanie metody `isBig`, jako argument do jej wywołania przekazałem wartość zmiennej `someNumber`.

Zauważ, że linijki z kodem kończą się znakiem `;`. Wywołanie metody zawsze zawiera nazwę nawiasy `()` i nie zawiera `{}`.

## Nazewnictwo

Każdy język programowania ma swego rodzaju standardy określające sposób w jaki powinno się nazywać metody, zmienne, funkcje, klasy itp. W języku Java używa się tzw. [_Camel Case_](https://pl.wikipedia.org/wiki/CamelCase). W uproszczeniu sprowadza się on do tego, że kolejne słowa łączy się w jeden ciąg znaków. Każde kolejne słowo pisze się wielką literą:

- someSampleName,
- example,
- SampleClassName.

Swego rodzaju wyjątkiem są tu nazwy klas, które także zaczynają się od wielkiej litery.

Nie każdy ciąg znaków może być użyty jako nazwy klasy/zmiennej/metody. Niektórych znaków nie można używać. Podobnie jest z niektórymi słowami. Java ma zestaw słów, które są zastrzeżone i nie mogą być użyte jako nazwa zmiennej. Kilka przykładów:

- `boolean` – jest to typ danych, nie można tak nazwać zmiennej,
- `class` – jest to słowo kluczowe użyte przy definicji klasy,
- `return` – słowo kluczowe użyte w metodzie oznacza wartość zwracaną przez daną metodę,
- `void` – słowo kluczowe pokazujące brak zwracanej wartości,
- `#2someName!` – nie wszystkie znaki są dopuszczalne. Dla uproszczenia można przyjąć, że można używać wyłącznie małych i wielkich liter od a do z bez polskich znaków[^polskie_znaki].

[^polskie_znaki]: Reguły są oczywiście dużo bardziej rozbudowane, jednak dla naszych potrzeb takie uproszczenie w zupełności wystarczy.

# Konstrukcja `if`

Tę konstrukcję wprowadzam teraz tylko abyś mógł użyć jej w rozwiązaniu ćwiczenia. Szerzej opisałem ją w [osobnym artykule]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}).
{: .notice--info}

Zacznę od fragmentu kodu:
```java
boolean result = isBig(123);
if (result) {
    System.out.println("Liczba jest duza.");
}
else {
    System.out.println("Liczba nie jest duza.");
}
```

Pierwszą linijkę już znasz. To wywołanie metody `isBig` i przypisanie wyniku do zmiennej o nazwie `result`. Kolejna linijka to konstrukcja `if`. Konstrukcja ta sprawdza czy `result` ma wartość `true`. Jeśli tak, to zostanie wywołany kod, który jest w bloku otoczonym `{}`. Jeśli `result` ma wartość `false` wówczas zostanie wywołany kod znajdujący się w bloku po `else`. 

Więc jeśli `result` ma wartość `true` wówczas zostanie wywołany kod:

```java
System.out.println("Liczba jest duza.");
```

Jeśli `result` ma wartość `false` to wywołany zostanie kod:

```java
System.out.println("Liczba nie jest duza.");
```

# Ćwiczenie

Na koniec mam dla Ciebie małe ćwiczenie. Napisz metodę, która sprawdzi czy temperatura przekazana jako argument jest dodatnia. Po rozwiązaniu zadania możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/blob/master/01_metody/src/main/java/pl/samouczekprogramisty/kursjava/methods/TemperatureCheck.java).

Jeszcze nie wiesz jak uruchomić tę metodę w działającym programie. Dowiesz się jak to zrobić w kolejnych etapach kursu.
{: .notice--warning}

# Podsumowanie

I jak czujesz się po pierwszej lekcji? Udało Ci się wykonać ćwiczenie? Daj znać jak Ci poszło w komentarzach. W następnym artykule przeczytasz o klasach. Jeśli chcesz być na bieżąco proszę polub [stronę Samouczka na Facebook'u](https://www.facebook.com/SamouczekProgramisty).

Naukę dobrze jest rozpocząć w gronie znajomych motywując się nawzajem, proszę poleć im tę stronę – razem zaczniecie uczyć się programowania.
