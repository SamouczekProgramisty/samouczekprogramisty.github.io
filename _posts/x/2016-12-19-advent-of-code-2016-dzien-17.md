---
layout: single
title: Advent of Code 2016 dzień 17
date: '2016-12-19 20:52:47 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-17/"
---
Advent of Code 2016 dzień 17. Musisz dotrzeć do sejfu, który ukryty jest za kilkoma drzwiami, problem polega na tym, że zamki drzwi otwierają się wyłącznie w specyficznych momentach.

# Wprowadzenie
  
{% include aoc-2016-link.md day="17" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 17 zadanie 1
  
Wczoraj udało Ci się wygenerować [sumę kontrolną](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-16/), która pozwoliła oszukać system bezpieczeństwa. Dzisiaj próbujesz dostać się do sejfu, znajdującego się na końcu małego zbioru pokoi. Pokoje ułożone są w czterech rzędach i kolumnach. Pomiędzy pokojami znajdują się drzwi. Zaczynasz w pokoju w lewym górnym rogu (oznaczonym `S`), do sejfu możesz się dostać jeśli dojdziesz do pokoju, który znajduje się w prawym dolnym rogu (oznaczonym literą `V`).

    ##########S| | | ##-#-#-#-## | | | ##-#-#-#-## | | | ##-#-#-#-## | | |V##########

  
Mury przez które nie możesz przejść oznaczone są `#`, drzwi natomiast `-` lub `|`.

Drzwi w aktualnym pokoju są otwarte lub zamknięte. To w jakim są stanie zależy od heksadecymalnej sumy z hasła (wejście do programu) z dołączoną sekwencją wielkich liter reprezentujących ścieżkę, którą obrałeś do tej pory:

- `U` jeśli poszedłeś do góry,
- `D` jeśli poszedłeś w dół,
- `L` jeśli poszedłeś w lewo,
- `R` jeśli poszedłeś w prawo.
  
  
Tylko pierwsze cztery znaki sumy kontrolnej są wykorzystywane. Przedstawiają one odpowiednio drzwi z góry, z dołu z lewej i z prawej strony względem Twojej aktualnej pozycji. Którakolwiek z liter `b`, `c`, `d`, `e` czy `f` oznaczają, że odpowiadające im drzwi są otwarte. Każdy inny znak (numer czy `a`) znaczy, że drzwi są zamknięte i nie możesz ich otworzyć.

Aby dotrzeć do sejfu, jedyne co musisz zrobić to dotrzeć do pokoju w prawym&nbsp;dolnym rogu. Dotarcie do tego pokoju otwiera sejf i wszystkie pozostałe drzwi w labiryncie.

Dla przykładu załóżmy, że hasło to `hijkl`. Początkowo, nie ruszyłeś się do żadnego pokoju więc aktualna ścieżka jest pusta. Po prostu znajdujesz sumę kontrolną MD5 z `hijkl`. Pierwsze cztery znaki tej sumy to `ced9`. Oznacza to, że góra jest otwarta (`c`), dół jest otwarty (`e`), lewa strona jest otwarta (`d`) i prawa strona jest zamknięta (`9`). Ponieważ zaczynasz w lewym górnym rogu nie ma drzwi u góry ani po lewej stronie więc możesz pójść tylko w dół.

Następnie po jednym kroku (w dół), znajdujesz sumę kontrolną dla `hijklD`. Otrzymujesz sumę kontrolną `f2bc`, co oznacza, że możesz pójść z powrotem do góry, w lewo (tylko tam znów jest mur) lub w prawo. Pójście w prawo oznacza znajdowanie sumy z `hijklDR`, otrzymasz wtedy `5745` - wszystkie drzwi są zamknięte. Jednak gdy wrócisz do góry sytuacja wygląda inaczej. Mimo tego, że już w tym pokoju byłeś, teraz Twoja ścieżka jest inna, suma kontrolna też będzie inna więc też i inne drzwi mogą zostać otwarte.

Po udaniu się `DU` (i policzeniu sumy kontrolnej z `hijklDU` aby otrzymać `528e`), tylko prawe drzwi są otwarte. Po udaniu się w prawo i policzeniu sumy kontrolne wszystkie drzwi są zamknięte... Na szczęście Twoje hasło to nie `hijkl` :).

Wszystkie kody użyte przez Ochronę Sejfu Króliczka Wielkanocnego pozwalają na dotarcie do sejfu jeśli znasz poprawną ścieżkę. Na przykład:

- jeśli hasło to `ihgpwlah` najkrótsza ścieżka to `DDRRRD`,
- jeśli hasło to `kglvqrro` najkrótsza ścieżka to `DDUDRLRRUDRD`,
- jeśli hasło to `ulqzkmiv` najkrótsza ścieżka to `DRURDRUDDLLDLUURRDULRLDUUDDDRR`.
  
  
Zakładając, że Twoje hasło to `udskfozm` jaka jest najkrótsza ścieżka, która pozwala dotrzeć do sejfu?
# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day17), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

