---
layout: default
title: Advent of Code 2016 dzień 24
date: '2016-12-26 08:23:00 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-24/"
---
Advent of Code 2016 dzień 24. Musisz znaleźć najkrótszą drogę dla robota czyszczącego kanały wentylacyjne. Robot musi odwiedzić kilka miejsc w plątaninie kanałów.

# Wprowadzenie
  
[idea]Oryginalna strona z zadaniami z [Advent of Code 2016](http://adventofcode.com/2016). Zadanie z artykułu dostępne jest pod adresem [http://adventofcode.com/2016/day/24](http://adventofcode.com/2016/day/24)[/idea]

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

[idea]Jeśli masz ochotę na odrobinę rywalizacji możesz dołączyć do klasyfikacji, którą założyłem na oryginalnej stronie. Aby dołączyć do tej klasyfikacji zaloguj się na [http://adventofcode.com/2016](http://adventofcode.com/2016) i dołącz wpisując kod `124245-88569bd0`.[/idea]

# Dzień 24 zadanie 1
  
W końcu udało Ci się przezwyciężyć [klawiaturę z sejfu](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-23/). Dzięki dokumentom, które tam znalazłeś dotarłeś do drzwi prowadzących na dach. Niestety są zamknięte na głucho, nie możesz się nawet to nich dostać, widzisz je za szybą kuloodporną. Jednak, robot, który czyści kanały wentylacyjne może.

Niestety nie jest to szybki robot, możesz go przekonfigurować tak, że będzie mógł połączyć się z kablami prowadzonymi z sytemu [HVAC](https://en.wikipedia.org/wiki/HVAC) (ogrzewanie, wentylacja, klimatyzacja). Jeśli będziesz w stanie pokierować go tak, żeby dotarł do kilku miejsc będziesz mógł ominąć system bezpieczeństwa chroniący drzwi.

Udało Ci się zdobyć plany kanałów wentylacyjnych, na których zaznaczone są istotne miejsca na mapie (wejście do programu). `0` to Twoja aktualna pozycja, z której robot czyszczący zaczyna się poruszać. Pozostałe numery (kolejność nie ma znaczenia) oznaczają miejsca, które robot musi odwiedzić co najmniej raz. Mury oznaczone są `#` a kanały, po których może się poruszać robot `.`. Numery oznaczające miejsca to także miejsca dostępne dla robota.

Na przykład, zakładając, że mapa kanałów wentylacyjnych wygląda następująco:

    ############0.1.....2##.#######.##4.......3############

  
Aby dotrzeć do wszystkich istotnych miejsc tak szybko jak to możliwe robot wybrał następującą ścieżkę:
- od miejsca startowego do `4` (2 kroki),
- od miejsca `4` do `1` (4 kroki, robot nie może poruszać się na ukos),
- od miejsca `1` do miejsca `2` (6 kroków),
- od miejsca `2` do miejsca `3` (2 kroki).
  
  
Z racji tego, że robot jest raczej powolny musisz znaleźć najkrótszą drogę. Przykład pokazuje najkrótszą możliwą drogę (14 kroków) wymaganych do odwiedzenia wszystkich istotnych punktów co najmniej raz.

Zakładając, że mapa kanałów wentylacyjnych znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day24_input.txt) i że robot zaczyna z pozycji `0`, jaka jest najmniejsza liczba kroków potrzebna aby odwiedzić wszystkie miejsca oznaczone numerami co najmniej raz?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day24), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

