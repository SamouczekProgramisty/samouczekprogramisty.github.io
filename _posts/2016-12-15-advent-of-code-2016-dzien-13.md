---
layout: post
title: Advent of Code 2016 dzień 13
date: '2016-12-15 18:26:01 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-13/"
---
Advent of Code 2016 dzień 13. Twoja pomoc potrzebna jest przy odnalezieniu drogi w labiryncie nowego budynku, dasz radę znaleźć najkrótszą możliwą drogę?

# Wprowadzenie
  
[idea]Oryginalna strona z zadaniami z [Advent of Code 2016](http://adventofcode.com/2016). Zadanie z artykułu dostępne jest pod adresem [http://adventofcode.com/2016/day/13](http://adventofcode.com/2016/day/13)[/idea]

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

[idea]Jeśli masz ochotę na odrobinę rywalizacji możesz dołączyć do klasyfikacji, którą założyłem na oryginalnej stronie. Aby dołączyć do tej klasyfikacji zaloguj się na [http://adventofcode.com/2016](http://adventofcode.com/2016) i dołącz wpisując kod `124245-88569bd0`.[/idea]

# Dzień 13 zadanie 1
  
Dzięki Twojej pomocy przy [wczorajszych](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-12/) instrukcjach assemblera udało się uruchomić kolejkę. Dotarłeś do pierwszego piętra nowego budynku. Niestety hall jest dużo mniej przyjazny niż świecące wnętrza w poprzednim budynku. Zamiast tego trafiłeś do plątaniny korytarzy i małych pomieszczeń.

Każde pomieszczenie w tym rejonie może być zidentyfikowane przez parę nieujemnych liczb całkowitych `(x, y)`. Każda taka współrzędna odpowiada albo ścianie albo otwartej przestrzeni. Nie możesz poruszać się na ukos. Labirynt zaczyna się na współrzędnych `(0, 0)` i wydaje się dążyć do nieskończoności dodatnich wartości `x` i `y`. Ujemne wartości są niepoprawne, przedstawiają położenie poza budynkiem. Znajdujesz się w małej poczekalni, która znajduje się na współrzędnych `(1, 1)`.

Wszystko wydaje się bardzo chaotyczne, jednak plakat znajdujący się na ścianie przekonuje Cię, że całość jest dość logiczna. Możesz stwierdzić czy dana pozycja `(x, y)` to ściana czy otwarta przestrzeń używając prostego systemu:binarną reprezentację

- Oblicz wartość równania `x*x + 3*x + 2*x*y + y + y*y`,
- dodaj ulubiony numer projektanta biura (wejście do programu),
- znajdź [binarną reprezentację](http://www.samouczekprogramisty.pl/system-dwojkowy/) tej sumy, policzyć ile bitów w tej reprezentacji to `1`,
- jeśli liczba bitów `1` jest parzysta `(x, y)` reprezentuje otwartą przestrzeń,
- jeśli liczba bitów `1` jest nieparzysta `(x, y)` reprezentuje ścianę.
  
  
Na przykład, jeśli ulubionym numerem projektanta biura jest `10`, poniżej widzisz układ biura gdzie ściany pokazane są jako `#` a otwarta przestrzeń jako `.`. Narożnik budynku wygląda tak:

    01234567890 .#.####.##1 ..#..#...#2 #....##...3 ###.#.###.4 .##..#..#.5 ..##....#.6 #...##.###

  
Załóżmy, że chciałbyś dotrzeć do pozycji `(7, 4)`. Najkrótsza droga, którą mógłbyś obrać oznaczona jest `O`:

    01234567890 .#.####.##1 .O#..#...#2 #OOO.##...3 ###O#.###.4 .##OO#OO#.5 ..##OOO.#.6 #...##.###

  
Więc dotarcie do punktu `(7, 4)` wymaga 11 kroków (zaczynając od pozycji `(1, 1)`).

Zakładając, że ulubionym numerem projektanta biura jest `1362`, jaka jest minimalna liczba kroków potrzebna do dotarcia do punku `(31, 39)`?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day13), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

