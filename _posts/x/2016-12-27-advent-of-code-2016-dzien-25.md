---
layout: single
title: Advent of Code 2016 dzień 25
date: '2016-12-27 08:00:22 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-25/"
---
Advent of Code 2016 dzień 25. Musisz nawiązać łączność z Mikołajem używając anteny na dachu budynku. Potrzebna jest do tego dodatkowa instrukcja assembunny.

# Wprowadzenie
  
{% include aoc-2016-link.md day="25" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 25 zadanie 1
  
Dzięki [robocikowi sprzątającemu](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-24/) udało Ci się obejść zabezpieczenia. Otwierasz drzwi prowadzące na dach, wielkie miasto ciągnie się aż po horyzont.

Nie zostało dużo czasu, to już Boże Narodzenie[^data] a Ty bynajmniej nie jesteś blisko Mikołaja. Może olbrzymia antena na dachu pomoże Ci nawiązać łączność? Podłączasz swój [prototypowy komputer](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-11/) do anteny i zaczynasz transmisję. Niestety nic się nie dzieje.

 [^data]: w oryginalnym Advent of Code to zadanie było opublikowane 25 grudnia.

Dzwonisz pod numer serwisanta znajdujący się z boku anteny i szybko opisujesz problem, mimo świąt serwisant odpowiada "nie jestem pewien jaki sprzęt podłączyłeś do tej anteny, ale potrzebuje on odpowiedniego sygnału zegara". Tak, tak odpowiadasz zegar dał już sygnał, to już najwyższy czas. W słuchawce słyszysz odpowiedź "nie o taki sygnał chodzi, potrzebny jest [sygnał zegara](https://en.wikipedia.org/wiki/Clock_signal) dla komputera anteny, taki który mówi kiedy powinien czytać dane, które chcesz wysłać. Nieskończony naprzemienny wzór z `0`, `1`, `0`, `1`, `0`, `1`, `0`, `1`...

Pytasz czy antena obsłuży sygnał zegara o częstotliwości Twojego prototypowego komputera. "Nie ma szans! Jedyna antena, która potrafi to obsłużyć znajduje się na szczycie budynku w Kwaterze Króliczka Wielkanocnego a Ty na pewno nie jesteś", odłożyłeś słuchawkę.

Udało Ci się wyciągnąć kod assembunny anteny odpowiedzialny za generowanie sygnału zegara (wejście do programu). Wygląda na to, że jest w większości kompatybilny z kodem, który [obsłgtugiwałeś](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-12/) [poprzednio](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-23/). Dodatkową instrukcją, którą używa antena jest:

- `out x` wysyła `x` (będący liczbą lub wartością rejestru) jako następną wartość sygnału zegara.
  
  
Kod pobiera pewną wartość (przechowywaną w rejestrze `a`), która opisuje sygnał, który powinien być wygenerowany ale nie jesteś pewien jak ta wartość jest użyta. Musisz znaleźć poprawną wartość rejestru eksperymentując.

Jaka jest najniższa dodatnia wartość rejestru `a`, która może być użyta do zainicjalizowania programu, która spowoduje, że wyjście do zegara będzie nieskończonym ciągiem `0`, `1`, `0`, `1`...? Program dla anteny znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day25_input.txt).

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day25), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

