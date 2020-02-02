---
title: Advent of Code 2019 dzień 1
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2019-dzien-1/
header:
    teaser: /assets/images/2019/1201-aoc2019-dzien-1/aoc-dzien-1-artykul.jpg
    overlay_image: /assets/images/2019/1201-aoc2019-dzien-1/aoc-dzien-1-artykul.jpg
    caption: "[&copy; Steinar Engeland](https://unsplash.com/photos/hmIFzdQ6U5k)"
excerpt: Advent of Code 2019 dzień 1. Pomóż znaleźć ilość paliwa niezbędną do startu.
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="1" %}

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

## Podsumowanie

Zachęcam do dalszej zabawy z drugą częścią zadania, jego treść pokaże się na stronie AoC2019 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/kbl/aoc2019/tree/master/src/aoc/day01), jednak zrób to raczej w ostateczności. W tym roku do rozwiązania zadań użyłem języka Go.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi. Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do samouczkowego newslettera i [polub Samouczka](https://www.facebook.com/SamouczekProgramisty) na Facebook'u. Do następnego razu!
