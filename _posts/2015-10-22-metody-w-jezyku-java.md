---
title: Metody w języku Java
date: '2015-10-22 23:38:44 +0200'
categories:
- Kurs programowania Java
- Programowanie
permalink: /metody-w-jezyku-java/
header:
    teaser: /assets/images/2015/10/22_metody_w_jezyku_java.png
    overlay_image: /assets/images/2015/10/22_metody_w_jezyku_java.png
excerpt: Artykułem tym rozpoczynam serię artykułów - kurs programowania w języku Java. Po przeczytaniu tego artykułu będziesz wiedział czym jest typ danych, dowiesz się czym jest metoda. Poznasz kilka podstawowych rodzajów danych (typów). Postaram się też przekazać Ci kilka dobrych praktyk. Zaczynamy!
disqus_page_identifier: 63 http://www.samouczekprogramisty.pl/?p=63
---

{% include kurs-java-notice.md %}

# Metoda

```java
boolean isBig(int someNumber) {
    return someNumber > 100;
}
```

Więc jesteś już po przeczytaniu swojego pierwszego fragmentu kodu! Brawo! Programowanie to nie tylko pisanie, ale także czytanie kodu własnego czy innych programistów. Ale do rzeczy...

Metoda to nic innego jak "worek" grupujący zestaw instrukcji. Kod grupujemy w ten sposób z kilku powodów. Wymienię dwa, które moim zdaniem są najważniejsze:

- jeśli jakiś fragment kodu ma być wykonany w wielu miejscach zdecydowanie lepiej jest utworzyć metodę i ją uruchomić (wywołać), niż kopiować ten sam fragment kodu wielokrotnie. Jest to istotne ponieważ w przypadku błędu trzeba go poprawić w jednym miejscu a nie kilku[^dry],
- programy są duże, bez odpowiedniego podziału opanowanie całego projektu/programu jest bardzo czasochłonne. Sensowny podział na metody pozwala szybciej zrozumieć kod.

[^dry]: DRY (ang. _Don't Repeat Yourself)_ zasada kładąca nacisk na redukcję powtarzającego się kodu.

## Wywołanie metody

Samo utworzenie metody nic nie daje. Metodę trzeba wywołać, aby została wykonana. Zwróć uwagę na ten fragment kodu:

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

Zauważ, że linijki z kodem kończą się znakiem `;`. Teraz po kolei postaram się wytłumaczyć każdy z tych elementów.

{% include newsletter-srodek.md %}

## Typy danych

Metoda wyżej przyjmuje argument `someNumber`. Argument ten ma swój typ `int`. Typ w języku programowania opisuje rodzaj danych. Np. w kodzie powyżej widoczne są 2 typy:
- `boolean` – typ przechowujący wartości prawda/fałsz. Prawda reprezentowana jest przez wartość `true`. Fałsz to `false`. Typ ten może nam pomóc przechowywać informację o tym czy ktoś jest wysoki, czy jest pełnoletni, czy ma niebieski kolor oczu itp.


```java
boolean isTall = true;
boolean hasBlueEyes = false;
```

- `int` – typ przechowujący liczby całkowite. Liczby te możesz zapisać na wiele sposobów, skupimy się na najprostszym – ciąg cyfr ewentualnie poprzedzony znakiem. Ten typ może nam posłużyć do przechowywania informacji o aktualnej temperaturze, wzroście, odległości z miasta A do B itp.

Tutaj muszę też powiedzieć o pewnych ograniczeniach. `int` podobnie jak każda inna wartość reprezentowana jest w pamięci komputera. Każda z wartości zajmuje określony rozmiar pamięci. Przez to ograniczenie nie jesteśmy w stanie przechowywać wszystkich liczb w zmiennej. Np. w przypadku Javy w zmiennej typu `int` możemy przechowywać liczby od -2,147,483,648 do 2,147,483,647. Jak widzisz są do dość duże liczby jednak do pewnych zastosowań potrzebujemy innych typów danych.

```java
int temperature = -12;
int height = 186;
int distance = 2589;
int numberOfErrors = 0;
```

## Nazewnictwo

Każdy język programowania ma swego rodzaju standardy określające sposób w jaki powinniśmy nazywać metody, zmienne, funkcje, klasy itp. W języku Java używamy tzw. Camel Case. W uproszczeniu sprowadza się on do tego, że kolejne słowa łączymy w jeden ciąg znaków. Każde kolejne słowo piszemy wielką literą:
- someSampleName,
- example,
- SampleClassName.

Swego rodzaju wyjątkiem są tu nazwy klas, które także zaczynamy od wielkiej litery.

Nie możemy użyć każdego ciągu znaków jako nazwy klasy/zmiennej/metody. Niektórych znaków nie możemy używać. Podobnie jest z niektórymi słowami. Java ma zestaw słów, które są „zastrzeżone” i nie mogą być użyte jako nazwa zmiennej. Kilka przykładów:

- `boolean` - jest to typ danych, nie możemy tak nazwać zmiennej
- `class` - jest to słowo kluczowe użyte przy definicji klasy,
- `return` - słowo kluczowe użyte w metodzie oznacza wartość zwracaną przez daną metodę,
- #2someName! - nie wszystkie znaki są dopuszczalne. Dla uproszczenia możemy przyjąć, że możemy używać wyłącznie małych i wielkich liter od a do z bez polskich znaków[^polskie_znaki].

[^polskie_znaki]: Reguły są oczywiście dużo bardziej rozbudowane, jednak dla naszych potrzeb takie uproszczenie w zupełności wystarczy.

## Argument metody

Metody mogą przyjmować jeden argument. Równie dobrze mogą nie przyjmować żadnego argumentu, właściwie to w języku Java mogą mieć ich dowolnie dużo. To, że jest to możliwe nie oznacza, że tak powinno się robić. W większości przypadków metody zawierające dużą liczbę argumentów są oznaką złych praktyk (ang. _code smell_). Duża liczba argumentów w metodzie pogarsza czytelność kodu.

Przykłady poniżej pokazują metody, z różnymi liczbami argumentów:

```java
void sayHello() {
    System.out.println("Hello");
}

int addNumbers(int number1, int number2) {
    return number1 + number2;
}
```

## Wynik metody

Metoda w języku Java może nie zwracać żadnej wartości, ma wówczas typ `void` jako typ zwracany. Możesz też napisać metodę, która zwraca dokładnie jedną wartość (obiekt lub typ prosty). Nie możesz natomiast napisać metody, która zwraca dwie lub więcej wartości. Można to obejść poprzez metody, które zwracają kolekcje obiektów (lista, tablica, zbiór, para etc.).

Metoda `sayHello` z poprzedniego przykładu nie zwraca żadnej wartości. Metody `isBig` i `addNumbers` zwracają odpowiednio wartość typu `boolean` i `int`.

## Ciało metody

Ciało metody to kod zawarty pomiędzy nawiasami klamrowymi `{}`. Przeanalizuję teraz ciała trzech metod pokazanych powyżej. 

Metoda `sayHello` nie zwraca żadnej wartości. W środku zawiera wyłącznie fragment kodu. W tym przypadku zawiera wywołanie metody `System.out.println`. Ta metoda wyświetla przekazany argument na konsoli:

```java
System.out.println("Hello");
```

Metoda `addNumbers` dodaje dwie zmienne `number1` i `number2`. Wynik dodawania jest zwracany jako wynik metody. Słowo kluczowe `return` wskazuje wynik metody:

```java
return number1 + number2;
```

Podobnie w przypadku metody `isBig` słowo kluczowe `return` wskazuje wynik:

```java
return someNumber > 100;
```

Ciało tej metody zawiera operator porównania `>`. `someNumber > 100` może zwrócić wartość logiczną. W zależności od wartości zmiennej `someNumber` wartość ta będzie różna:
- jeśli `someNumber` równa się 10 wówczas `someNumber > 100` oznacza fałsz - `false`
- jeśli `someNumber` równa się 100 wówczas `someNumber > 100` oznacza fałsz - `false`
- jeśli `someNumber` równa się 101 wówczas `someNumber > 100` oznacza prawdę - `true`

{% capture uwaga %}
Słowo kluczowe `return` może występować w metodach, które nie zwracają żadnej wartości:

```java
void saySomethingElse() {
    System.out.println("Something else");
    return;
}
```
{% endcapture %}

<div class="notice--info">
    {{ uwaga | markdownify }}
</div>

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

I jak czujesz się po pierwszej lekcji? Udało Ci się wykonać ćwiczenie? Daj znać jak Ci poszło w komentarzach. W następnym artykule będziesz mógł przeczytać o klasach. Jeśli chcesz być na bieżąco proszę polub stronę na Facebook'u.

Naukę dobrze jest rozpocząć w gronie znajomych motywując się nawzajem, proszę poleć im tą stronę - razem zaczniecie uczyć się programowania.
