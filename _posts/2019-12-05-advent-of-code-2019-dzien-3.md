---
title: Advent of Code 2019 dzień 3
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2019-dzien-3/
header:
    teaser: /assets/images/2019/1203-aoc2019-dzien-3/aoc-dzien-3-artykul.jpg
    overlay_image: /assets/images/2019/1203-aoc2019-dzien-3/aoc-dzien-3-artykul.jpg
    caption: "[&copy; Dan Gold](https://unsplash.com/photos/S0J_gLmaHwM)"
excerpt: Advent of Code 2019 dzień 3. Pomóż połapać się w plątaninie kabli
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="3" %}

## Dzień 3 zadanie 1

Asysta grawitacyjna powiodła się i jesteś na swojej drodze do stacji tankowania na Wenus. W trakcie zamieszania na Ziemi system zarządzania paliwem nie został poprawnie zainstalowany. Jest to pierwsza rzecz na twojej liście priorytetów.

Po otworzeniu przedniego panelu pokazuje się plątanina kabli. Dwa kable są podłączone do centralnego portu i tworzą tę plątaninę. Sledzisz każdy z kabli zaczynając od portu centralnego. Trasa każdego kabla opisana jest porzez pojedynczą linię tekstu (plik wejściowy).

Kable skręcają w każdą ze stron, czasami przecinają swoje ścieżki. Aby naprawić obwód musisz znaleść punkt przecięcia najbliższy do portu cerntralnego. Ponieważ kable są na siatce użyj [odłegłości Manhattan](https://en.wikipedia.org/wiki/Taxicab_geometry) do porówywania odległości. Chociaż technicznie kable przecinają się w centralnym porcie, gdzie oba się zaczynają, ten punkt nie może być brany pod uwagę. Także punkty przecięcia kabla z zamym sobą nie są poprawnymi punktami przecięcia.

Na przykład, jeśli ścieżka pierwszego kabla to `R8,U5,L5,D3`, wtedy zaczynając od portu centralnego (`o`) biegnie 8 pól w prawo (Right), 5 do góry (Up), 5 w lewo (Left) i 3 w dół (Down):

    ...........
    ...........
    ...........
    ....+----+.
    ....|....|.
    ....|....|.
    ....|....|.
    .........|.
    .o-------+.
    ...........

Jeśli ścieżka drugiego kabla określona jest przez `U7,R6,D4,L4`, wtedy zaczynając od portu centralnego biegnie 7 pół do góry, 6 w prawo, 4 w dół i 4 w lewo:

    ...........
    .+-----+...
    .|.....|...
    .|..+--X-+.
    .|..|..|.|.
    .|.-X--+.|.
    .|..|....|.
    .|.......|.
    .o-------+.
    ...........

Te kable przecinają się w dwóch punktach (onaczonych `X`). Punkt niżej jest bliżej do portu centralnego. Jego „odległość Manhattan” wynosi 6 (3 + 3).

Poniżej znajdziesz dwa dodatkowe przykłady.

Najbliższy punkt przecięcia znajduje się w odległości 159 od portu centralnego:

    R75,D30,R83,U83,L12,D49,R71,U7,L72
    U62,R66,U55,R34,D71,R55,D58,R83 

Najbliższy punkt przecięcia znajduje się w odległości 135 od portu centralnego:

    R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
    U98,R91,D20,R16,D67,R40,U7,R15,U6,R7

Jaka jest „odległość Manhattan” od portu centralnego do najbliższego przecięcia [tych kabli](https://github.com/kbl/aoc2019/blob/master/input/day03.txt)?

## Podsumowanie

{% include aoc-2019-summary.md year="2019" day="3" %}
