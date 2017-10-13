---
layout: default
title: Advent of Code 2016 dzień 3
date: '2016-12-05 17:20:41 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-3/"
---
Advent of Code 2016 dzień 3. Mikołaj trafił do departamentu graficznego i potrzebuje Twojej pomocy ze sprawdzeniem specyfikacji trójkątów ;). Pomożesz?

# Wprowadzenie
  
[idea]Oryginalna strona z zadaniami z [Advent of Code 2016](http://adventofcode.com/2016). Zadanie z artykułu dostępne jest pod adresem [http://adventofcode.com/2016/day/3](http://adventofcode.com/2016/day/3)[/idea]

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

[idea]Jeśli masz ochotę na odrobinę rywalizacji możesz dołączyć do klasyfikacji, którą założyłem na oryginalnej stronie. Aby dołączyć do tej klasyfikacji zaloguj się na [http://adventofcode.com/2016](http://adventofcode.com/2016) i dołącz wpisując kod `124245-88569bd0`.[/idea]

# Dzień 3 zadanie 1
  
Po przygodach z [wczorajszego dnia](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-2/) w końcu możesz się skupić i czysto myśleć. Zagłębiłeś się w labirynt korytarzy i boksów biurowych, które wypełniają tę część Kwatery Głównej Króliczka Wielkanocnego. To musi być dział projektantów graficznych, ściany pokryte są specyfikacjami dla trójkątów.

Hmm, czy aby na pewno?

Dokumenty z projektami pokazują długości boków każdego z trójkątów, ale... 5 10 25? Niektóre z nich nie są trójkątami. Musisz odrzucić te niepoprawne.

W poprawnym trójkącie suma dwóch boków musi być krótsza od najdłuższego boku. Na przykład nie można zbudować trójkąta z odcinków o długościach 5, 10 i 25. 5 + 10 nie jest większe niż 25.

Jak dużo poprawnych trójkątów znajduje się w [pliku wejściowym](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day03_input.txt)?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day03), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

