---
layout: default
title: Advent of Code 2016 dzień 10
date: '2016-12-12 19:31:29 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-10/"
---
Advent of Code 2016 dzień 10. Dzisiejsze zadanie to sterowanie robotami, potrafisz zinterpretować instrukcje dla dronów?

# Wprowadzenie
  
{% include aoc-2016-link.md day="10" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 10 zadanie 1
  
Dzięki Twojej pomocy przy [wczorajszym](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-9/) zadaniu udało się zdekompresować kilka interesujących plików.

Doszedłeś do fabryki w której [małe latające robociki](https://www.youtube.com/watch?v=JnkMyfQ5YfY&t=40) przekazują sobie mikrochipy. Po dokładniejszym przyjrzeniu się zauważyłeś, że każdy robot przekazuje cokolwiek dalej tylko jeśli ma dwa mikrochipy. Jeśli już je ma, przekazuje je innemu robotowi lub wrzuca je do jednego z koszy oznaczających "wyjście". Czasami roboty pobierają mikrochipy z koszy oznaczonych napisem "wejście".

Patrząc na jeden z mikrochipów wydaje się, że zawierają one pojedynczy, unikalny numer. Roboty używają pewnej logiki aby zdecydować co zrobić z każdym z chipów. Dostałeś się do lokalnego komputera i udało Ci się ściągnąć instrukcje sterujące robotami (wejście do zadania).

Niektóre z instrukcji określają, że mikrochip o konkretnej wartości powinien być przekazany konkretnemu robotowi. Reszta instrukcji określa co każdy robot powinien zrobić z mikrochipami które posiada. Instrukcja ta mówi o tym co robot powinien zrobić z chipem o niższej i o wyższej wartości.

Na przykład, biorąc pod uwagę poniższy zestaw instrukcji:

    value 5 goes to bot 2bot 2 gives low to bot 1 and high to bot 0value 3 goes to bot 1bot 1 gives low to output 1 and high to bot 0bot 0 gives low to output 2 and high to output 0value 2 goes to bot 2

  
Początkowo, robot 1 zaczyna z chipem o wartości 3 a robot 2 zaczyna z chipami o wartości 2 i 5. Ponieważ robot 2 ma dwa mikrochipy przekazuje ten o mniejszej wartości (2) do robota 1 a ten o większej wartości (5) do robota 0.

Po tych instrukcjach robot 1 ma dwa chipy. Mikrochip o wartości 2 umieszcza w koszu wyjściowym o numerze 1 i przekazuje mikrochip o wartości 3 do robota 0. Jako ostatni robot 0 mający dwa mikrochipy przekazuje ten o mniejszej wartości (3) do wyjścia 2 a ten o większej wartości (5) do kosza 0.

Na końcu:

- kosz wyjściowy 0 zawiera mikrochip o wartości 5,
- kosz wyjściowy 1 zawiera mikrochip o wartości 2
- kosz wyjściowy 2 zawiera mikrochip o wartości 3.
  
  
W tej konfiguracji robot numer 2 był odpowiedzialny za porównywanie wartości mikrochipów o wartości 5 i 2.

Bazując na instrukcjach dla robotów umieszczonych w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day10_input.txt), robot o którym numerze odpowiedzialny jest za porównywanie mikrochipów o wartościach 61 i 17?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day10), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

