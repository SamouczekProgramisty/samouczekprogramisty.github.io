---
layout: default
title: Metody w języku Java
date: '2015-10-22 23:38:44 +0200'
categories:
- Kurs programowania Java
- Programowanie
excerpt_separator: "<!--more-->"
permalink: "/metody-w-jezyku-java/"
---
Artykułem tym rozpoczynamy serię artykułów - kurs programowania w języku Java. Po przeczytaniu tego artykułu będziesz wiedział czym jest typ danych, dowiesz się czym jest metoda. Poznasz kilka podstawowych rodzajów danych (typów). Postaram się też przekazać Ci kilka dobrych praktyk. Zaczynamy!

{% include kurs-java-notice.md %}

# Metoda

    boolean isBig(int someNumber) { return someNumber > 100;}

  
Więc jesteś już po przeczytaniu swojego pierwszego fragmentu kodu! Brawo! Programowanie to nie tylko pisanie, ale także czytanie kodu własnego czy innych programistów. Ale do rzeczy...

Metoda to nic innego jak „worek” grupujący zestaw instrukcji. Kod grupujemy w ten sposób z kilku powodów. Wymienię dwa, które moim zdaniem są najważniejsze:

- jeśli jakiś fragment kodu ma być wykonany w wielu miejscach zdecydowanie lepiej jest utworzyć metodę i ją uruchomić (wywołać), niż kopiować ten sam fragment kodu wielokrotnie. Jest to istotne ponieważ w przypadku błędu trzeba go poprawić w jednym miejscu a nie kilku\*[1. DRY (ang. _Don't Repeat Yourself)_ zasada kładąca nacisk na redukcję powtarzającego się kodu],
- programy są duże, bez odpowiedniego podziału opanowanie całego projektu/programu jest bardzo czasochłonne. Sensowny podział na metody pozwala szybciej zrozumieć kod.
  

## Deklaracja metody

    boolean isBig(int someNumber)

  
Linijka ta zawiera kolejno:
1. typ zwracany przez metodę,
2. nazwę metody,
3. typ argumentu,
4. nazwę zmiennej, argumentu.
  
  
Teraz po kolei postaram się wytłumaczyć każdy z tych elementów.
## Typy danych
  
Metoda wyżej przyjmuje argument `someNumber`. Argument ten ma swój typ `int`. Typ w języku programowania opisuje rodzaj danych. Np. w kodzie powyżej widoczne są 2 typy:
- `boolean` – typ przechowujący wartości prawda/fałsz. Prawda reprezentowana jest przez wartość `true`. Fałsz to `false`. Typ ten może nam pomóc przechowywać informację o tym czy ktoś jest wysoki, czy jest pełnoletni, czy ma niebieski kolor oczu itp.
  

    boolean isTall = true;boolean hasBlueEyes = false;

- `int` – typ przechowujący liczby całkowite. Liczby te możesz zapisać na wiele sposobów, skupimy się na najprostszym – ciąg cyfr ewentualnie poprzedzony znakiem. Ten typ może nam posłużyć do przechowywania informacji o aktualnej temperaturze, wzroście, odległości z miasta A do B itp.
  
  
Tutaj muszę też powiedzieć o pewnych ograniczeniach. `int` podobnie jak każda inna wartość reprezentowana jest w pamięci komputera. Każda z wartości zajmuje określony rozmiar pamięci. Przez to ograniczenie nie jesteśmy w stanie przechowywać wszystkich liczb w zmiennej. Np. w przypadku Javy w zmiennej typu `int` możemy przechowywać numery od -2,147,483,648 do 2,147,483,647. Jak widzisz są do dość duże liczby jednak do pewnych zastosowań potrzebujemy innych typów danych.

    int temperature = -12;int height = 186;int distance = 2589;int numberOfErrors = 0;

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
- #2someName! - nie wszystkie znaki są dopuszczalne. Dla uproszczenia możemy przyjąć, że możemy używać wyłącznie małych i wielkich liter od a do z bez polskich znaków[1.Reguły są oczywiście dużo bardziej rozbudowane, jednak dla naszych potrzeb takie uproszczenie w zupełności wystarczy.].
  

## Argument metody
  
Metody mogą przyjmować jeden argument. Równie dobrze mogą nie przyjmować żadnego argumentuj, właściwie to w języku Java mogą mieć ich dowolnie dużo. To, że jest to możliwe nie oznacza, że tak powinno się robić. W większości przypadków metody zawierające dużą liczbę argumentów są oznaką złych praktyk (ang. _code smell_). Duża liczba argumentów w metodzie pogarsza czytelność kodu.
## Wynik metody
  
Metoda w języku Java może nie zwracać żadnej wartości, ma wówczas typ `void` jako typ zwracany. Możesz też napisać metodę, która zwraca dokładnie jedną wartość (obiekt lub typ prosty). Nie możesz natomiast napisać metody, która zwraca dwie lub więcej wartości. Można to obejść poprzez metody, które zwracają kolekcje obiektów (lista, tablica, zbiór, para etc.).
## Ciało metody
  
Ciało metody to kod zawarty pomiędzy nawiasami klamrowymi `{}`. W naszym przykładzie ciałem metody jest

    return someNumber > 100;

  
`someNumber > 100` może zwrócić wartość logiczną. W zależności od wartości argumentu `someNumber` wartość ta będzie różna:
- jeśli `someNumber` równa się 10 wówczas `someNumber > 100` oznacza fałsz - `false`
- jeśli `someNumber` równa się 100 wówczas `someNumber > 100` oznacza fałsz - `false`
- jeśli `someNumber` równa się 101 wówczas `someNumber > 100` oznacza prawdę - `true`
  
  
Na koniec mam dla Ciebie małe ćwiczenie:
# Ćwiczenie
  
Napisz metodę, która sprawdzi czy temperatura przekazana jako argument jest dodatnia. Po rozwiązaniu zadania możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/blob/master/01_metody/src/main/java/pl/samouczekprogramisty/kursjava/methods/TemperatureCheck.java).
# Podsumowanie
  
I jak czujesz się po pierwszej lekcji? Udało Ci się wykonać ćwiczenie? Daj znać jak Ci poszło w komentarzach. W następnym artykule będziesz mógł przeczytać o klasach. Jeśli chcesz być na bieżąco proszę polub stronę na Facebook'u.

Naukę dobrze jest rozpocząć w gronie znajomych motywując się nawzajem, proszę poleć im tą stronę - razem zaczniecie uczyć się programowania.

[FM\_form id="3"]

