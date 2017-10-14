---
layout: default
title: Advent of Code 2016 dzień 12
date: '2016-12-14 17:30:07 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-12/"
---
Advent of Code 2016 dzień 12. Dzisiejsze zadanie to emulator języka assembunny. Napiszesz program, który rozumie assembler używany w Kwaterze Głównej Króliczka Wielkanocnego.

# Wprowadzenie
  
{% include aoc-2016-link.md day="12" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 12 zadanie 1
  
W końcu udało Ci się dotrzeć na ostatnie piętro budynku. Piękny ogród ze skośnym szklanym sufitem. Siedząc na ławce pomiędzy [liliami](https://www.google.com/search?q=tiger+lilies&tbm=isch) odszyfrowałeś kilka plików, które udało Ci się wykraść z serwera piętro niżej.

Według tych dokumentów Kwatera Główna Królicza Wielkanocnego nie jest jednym budynkiem. Jest kompleksem budynków w okolicy. Wszystkie z nich połączone są kolejką i jeden z nich znajduje się całkiem niedaleko! Niestety, w nocy kolejka nie jeździ.

Udało Ci się zdalnie połączyć do systemu sterującego kolejką i odkryłeś, że sekwencja początkowa wymaga hasła. Logika sprawdzagtjąca hasło (wejście dla Twojego programu) jest łatwa do pozyskania, jednak kod jest dość dziwny. Używa on specjalnego języka assembunny zaprojektowanego dla komputera, który złożyłeś [wczoraj](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-11/). Musisz wywołać kod, żeby uzyskać hasło.

Kod assembunny, który udało Ci się zdobyć operuje na czterech rejestrach (a, b, c i d), które przechowują wartość początkową 0 i mogą trzymać dowolną liczbę całkowitą. Wygląda na to, że wykorzystywany jest dość ubogi zestaw instrukcji:

- `cpy x y` kopiuje `x` (zawartość rejestru albo liczbę) do rejestru `y`,
- `inc x` zwiększa wartość rejestru `x` o jeden,
- `dec x` zmniejsza wartość rejestru `x` o jeden,
- `jnz x y` skacze do instrukcji oddalonej o `y` (dodatnie wartości oznaczają skok do przodu, ujemne do tyłu) jeśli `x` (liczba lub zawartość rejestru) nie jest zerem.
  
  
Instrukcja `jnz` przesuwa się relatywnie względem siebie, skok o -1 oznacza skok do poprzedniej instrukcji, skok o 2 przeskoczy następną instrukcję.

Mając na przykład następujący zestaw instrukcji:

    cpy 41 ainc ainc adec ajnz a 2dec a

  
Powyższy kod ustawi rejestr a na wartość 41, zwiększy wartość rejestru o 1 dwukrotnie, zmniejszy wartość rejestru o 1 i następnie przeskoczy ostatnią instrukcję (ponieważ wartość rejestru `a` != 0). Ostateczna wartość rejestru a to 42. Program kończy się kiedy przejdzie za ostatnią instrukcję.

Zakładając, że kod assembunny znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day12_input.txt), jaka będzie wartość rejestru `a` na koniec programu?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day12), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

