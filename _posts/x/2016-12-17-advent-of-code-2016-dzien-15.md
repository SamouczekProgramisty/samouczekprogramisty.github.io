---
layout: default
title: Advent of Code 2016 dzień 15
date: '2016-12-17 18:12:05 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-15/"
---
Advent of Code 2016 dzień 15. Znalazłeś ciekawą ruchomą rzeźbę. W jej środku poruszają się dziwne kapsuły, chciałbyś jedną z nich wyciągnąć. Dasz radę przechytrzyć mechanizm rzeźby?

# Wprowadzenie
  
{% include aoc-2016-link.md day="15" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 15 zadanie 1
  
Poprzedni udało Ci się wygenerować [listę haseł jednorazowych](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-14/). Po czym zacząłeś zwiedzać pozostałą część Kwatery Głównej. Wielki korytarz prowadzi do placu umieszczonego wewnątrz budynku. Na środku placu znajduje się ruchoma rzeźba. Rzeźba zamknięta jest pod przeźroczystą kopułą, wewnątrz niej krążą nieduże kapsuły. Kapsuły są przenoszone na górę rzeźby i spadają swobodnie odbijając się od kręcących się elementów rzeźby.

Część rzeźby jest nawet interaktywna. Kiedy naciśniesz przycisk kapsuła spuszczana jest w dół i próbuje przelecieć przez dziury w zestawie obracających się dysków. Jeśli przeleci przez nie wszystkie wypada przez niewielką dziurę na dole rzeźby. Jeśli którykolwiek z otworów nie jest "zgrany" z kapsułą kiedy ta opada, kapsuła odbija się od niego i wznosi się z powrotem na górę rzeźby. Chcesz mieć jedną z tych kapsuł :).

Dyski zatrzymują się co sekundę, każdy z nich ma inny rozmiar. Każdy z dysków ma określoną liczbę pozycji, na których się zatrzymuje. Pozycja z dziurą na dysku oznaczona jest numerem 0, na kolejnych pozycjach nie ma dziur przez które może przelecieć kapsuła.

Dyski są oddalone od siebie. Kiedy naciśniesz przycisk potrzeba jednej sekundy zanim kapsuła osiągnie pierwszy dysk, kolejna sekunda mija kiedy kapsuła przemieszcza się od jednego dysku do kolejnego pod spodem. Więc jeśli przyciśniesz przycisk w czasie 100, wtedy kapsuła dotrze do pierwszego dysku o czasie 101, do drugiego o czasie 102, do trzeciego o czasie 103 i tak dalej.

Przycisk wypuści kapsułę tylko o pełnych sekundach, nie można wypuścić jej w połowie sekundy.

Załóżmy, że w czasie 0 widzisz następujący układ dysków:

- Dysk #1 ma 5 pozycji, w czasie 0 jest na pozycji 4,
- dysk #2 ma 2 pozycje, w czasie 0 jest na pozycji 1.
  
  
Jeśli naciśniesz przycisk o czasie 0, kapsuła zacznie opadać. Dotrze do pierwszego dysku o czasie 1. Jako, że dysk #1 w czasie 0 był na pozycji 4, o czasie 1 przemieścił o jedną pozycję do przodu. Jako dysk z pięcioma pozycjami, kolejną pozycją jest 0 więc kapsuła swobodnie przelatuje przez otwór.

Następnie o czasie 2 kapsuła dociera do drugiego dysku. Drugi dysk przesunął się do przodu o dwie pozycje. Zaczął na pozycji 1, przesunął się do 0 i ostatecznie ponownie przemieścił się do pozycji 1. Ponieważ w każdym dysku jest tylko jeden otwór kapsuła nie może przelecieć przez dysk #2.

Jeśli jednak poczekasz z naciśnięciem przycisku do czasu 5, wtedy kapsuła może przelecieć swobodnie przez wszystkie dyski. Pierwszy dysk przesunie się w tym czasie 5 + 1 = 6 razy (do pozycji 0), drugi dysk przesunie się 5 + 2 = 7 razy, także do pozycji 0.

Twoja sytuacja jest bardziej skomplikowana, rzeźba ma więcej niż 2 dyski. Kiedy najszybciej możesz nacisnąć przycisk żeby kapsuła wypadła z rzeźby jeśli układ dysków opisany jest w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day15_input.txt)?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day15), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

