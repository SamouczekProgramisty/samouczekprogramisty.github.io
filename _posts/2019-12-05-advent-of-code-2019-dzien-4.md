---
title: Advent of Code 2019 dzień 4
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2019-dzien-4/
header:
    teaser: /assets/images/2019/1204-aoc2019-dzien-4/aoc-dzien-4-artykul.jpg
    overlay_image: /assets/images/2019/1204-aoc2019-dzien-4/aoc-dzien-4-artykul.jpg
    caption: "[&copy; Jason Blackeye](https://unsplash.com/photos/1swEt2WM39E)"
excerpt: Advent of Code 2019 dzień 4. Pomóż odnaleźć zgubione hasło
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="4" %}

## Dzień 4 zadanie 1

Dotarłeś do stacji tankowania na Wenus. Okazało się, że dostęp do stacji wymaga podania hasła. Elfy zapisały hasło na małej kartecze, ale ktoś ją wyrzucił.

Jednak pamiętaja kilka istotnych faktów dotyczących hasła:

* składa się z sześciu cyfr,
* jest mniejsze niż wartość w pliku wejściowym,
* dwie sąsiednie cyfry są takie same (jak `22` w `122345`),
* idąc od lewej do prawej cyfry nigdy nie maleją. Mogą rosnąć lub pozostać takie same (na przykład `111123` albo `135679`).

Nie biorąc pod uwagę wartości pliku wejściowego poniższe stwierdzenia są prawdziwe:
* `111111` spełnia warunki (podwojone `11`, cyfry nie maleją),
* `223450` nie spełnia warunków (cyfry maleją `50`),
* `123789` nie spełnia warunków (brak powtórzonych cyfr).

Ile różnych haseł mniejszych niż wartość w [pliku wejściowym](https://github.com/kbl/aoc2019/blob/master/input/day04.txt) spełnia wszystkie warunki?

## Podsumowanie

{% include aoc-2019-summary.md year="2019" day="3" %}
