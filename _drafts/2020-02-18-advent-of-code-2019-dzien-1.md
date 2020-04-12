---
title: Advent of Code 2019 dzień 1
last_modified_at: 2020-02-02 20:28:33 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2019-dzien-1/
header:
    teaser: /assets/images/2019/1201-aoc2019-dzien-1/aoc-dzien-1-artykul.jpg
    overlay_image: /assets/images/2019/1201-aoc2019-dzien-1/aoc-dzien-1-artykul.jpg
    caption: "[&copy; Steinar Engeland](https://unsplash.com/photos/hmIFzdQ6U5k)"
excerpt: Advent of Code 2019 dzień 1. Pomóż znaleźć ilość paliwa niezbędną do startu.
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="1" %}

W 2016 roku także na łamach Samouczka rozwiązywałem zadania z Advent of Code. Tym razem postanowiłem pójść o krok dalej. Zamiast pokazywać Ci gotowe rozwiązania postaram się przeprowadzić Cię przez moją ścieżkę rozumowania. Celem jest osiągnięcie przez Ciebie rozwiązania samodzielnie przy drobnej pomocy w momentach, które mogą być problematyczne. Dzięki temu będziesz w stanie samodzielnie rozwiązać zadania korzystając z drobnych wskazówek jeśli te będą potrzebne.

Zadania w Advent of Code podzielone są na dwie części. Pierwsza z nich często jest „wprawką” do drugiej, zasadniczej części. W ramach Advent of Code dostęp do drugiej części odblokowywany jest po poprawnym rozwiązaniu pierwszego zadania.

## Dzień 1 zadanie 1

Elfy szybko załadowały Cię do statku i przygotowały do startu. 

Protokół bezpieczeństwa wymaga głosowania przed startem. Prawie każdy Elf jest za „Leć”, jednak Elf Starszy Paliwowy jest przeciwny. Niestety Elfy jeszcze nie określiły ilości paliwa niezbędnej do lotu.

Statek kosmiczny składa się z modułów. Paliwo niezbędne do uruchomienia modułu zależy od jego masy. W szczególności, aby znaleźć ilość paliwa niezbędną dla danego modułu należy wziąć jego masę, podzielić ją przez trzy, zaokrąglić w dół i odjąć 2.

Na przykład:

* Dla masy 12, podziel przez 3 i zaokrąglij w dół aby otrzymać 4, później odejmij 2 aby otrzymać 2,
* Dla masy 14, podziel przez 3 i zaokrąglij w dół aby ponownie otrzymać 4, więc także tym razem niezbędna ilość paliwa to 2,
* Dla masy 1969 wymagana ilość paliwa to 654,
* Dla masy 100756 wymagana ilość paliwa to 33583.

Elf Starszy Paliwowy musi znać sumaryczną ilość paliwa wymaganą przez statek kosmiczny. Aby ją znaleźć policz niezbędną ilość paliwa dla każdego modułu następnie dodaj je do siebie. Jaka jest sumaryczna ilość paliwa niezbędna dla [wszystkich modułów](https://github.com/kbl/aoc2019/blob/master/input/day01.txt) w Twoim statku?

### Wskazówki

### Testy jednostkowe

### Szablon rozwiązania

## Dzień 1 zadanie 2

W trakcie drugiej rundy głosowania Elf Starszy Równania Rakietowego przerywa sekwencję startową. Najwyraźniej zapomniałeś zabrać paliwo żeby przewieźć paliwo, które właśnie dodałeś.

Paliwo, podobnie jak moduł wymaga paliwa do przewiezienia. Podobnie jak w przypadku modułu, aby znaleźć ilość niezbędnego paliwa należy wziąć jego masę, podzielić ją przez trzy, zaokrąglić w dół i odjąć 2. 

Tak obliczone paliwo także wymaga paliwa do jego przewiezienia i paliwo potrzebne tym razem potrzebuje kolejnej porcji paliwa, i tak dalej. Jakakolwiek waga, która wymaga negatywnej wartości paliwa powinna zostać potraktowana jakby nie wymagała paliwa w ogóle.

Dla każdej wagi modułu policz niezbędne paliwo i dodaj do sumarycznej wagi paliwa. Później wagę paliwa jaką właśnie obliczyłeś potraktuj jako masę modułu i oblicz masę paliwa potrzebną do jego przewiezienia. Następnie powtórz proces, kontynuuj dopóki masa niezbędnego paliwa będzie wynosiła zero albo będzie ujemna.

Na przykład:

* moduł o masie 14 wymaga 2 paliwa. To paliwo nie wymaga paliwa do jego przewiezienia (2 podzielone przez 3, zaokrąglone w dół daje 0, które finalnie wymagałoby ujemnej wartości paliwa), więc sumaryczna ilość niezbędnego paliwa to nadal 2.
* na początku moduł o masie 1969 wymaga 654 paliwa. Następnie to paliwo wymaga dodatkowo 216 paliwa (654 / 3 - 2). 216 wymaga dodatkowo 70 paliwa, które wymaga 21, które wymaga 5, które nie wymaga dodatkowego paliwa. W tym przypadku sumaryczna ilość paliwa niezbędna do przewiezienia modułu o masie 1969 to 654 + 216 + 70 + 21 + 5 = 966,
* paliwo niezbędne do przewiezienia modułu o masie 100756 wraz z paliwem to: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.

Jaka jest sumaryczna ilość paliwa niezbędna dla [wszystkich modułów](https://github.com/kbl/aoc2019/blob/master/input/day01.txt) w Twoim statku biorąc pod uwagę wagę dodanego paliwa? Policz paliwo dla każdego modułu oddzielnie i dodaj te wartości na końcu do siebie.

## Podsumowanie

{% include aoc-2019-summary.md year="2019" day="1" %}
