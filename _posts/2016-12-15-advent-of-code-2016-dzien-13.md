---
title: Advent of Code 2016 dzień 13
date: '2016-12-15 18:26:01 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-13/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_13_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_13_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 13. Twoja pomoc potrzebna jest przy odnalezieniu drogi w labiryncie nowego budynku, dasz radę znaleźć najkrótszą możliwą drogę?
disqus_page_identifier: 661 http://www.samouczekprogramisty.pl/?p=661
toc: false
---

## Wprowadzenie
  
{% include aoc-2016-link.md day="13" %}

## Dzień 13 zadanie 1
  
Dzięki Twojej pomocy przy [wczorajszych]({% post_url 2016-12-14-advent-of-code-2016-dzien-12 %}) instrukcjach assemblera udało się uruchomić kolejkę. Dotarłeś do pierwszego piętra nowego budynku. Niestety hall jest dużo mniej przyjazny niż świecące wnętrza w poprzednim budynku. Zamiast tego trafiłeś do plątaniny korytarzy i małych pomieszczeń.

Każde pomieszczenie w tym rejonie może być zidentyfikowane przez parę nieujemnych liczb całkowitych `(x, y)`. Każda taka współrzędna odpowiada albo ścianie albo otwartej przestrzeni. Nie możesz poruszać się na ukos. Labirynt zaczyna się na współrzędnych `(0, 0)` i wydaje się dążyć do nieskończoności dodatnich wartości `x` i `y`. Ujemne wartości są niepoprawne, przedstawiają położenie poza budynkiem. Znajdujesz się w małej poczekalni, która znajduje się na współrzędnych `(1, 1)`.

Wszystko wydaje się bardzo chaotyczne, jednak plakat znajdujący się na ścianie przekonuje Cię, że całość jest dość logiczna. Możesz stwierdzić czy dana pozycja `(x, y)` to ściana czy otwarta przestrzeń używając prostego systemu:binarną reprezentację

- Oblicz wartość równania `x*x + 3*x + 2*x*y + y + y*y`,
- dodaj ulubiony numer projektanta biura (wejście do programu),
- znajdź [binarną reprezentację]({% post_url 2016-02-11-system-dwojkowy %}) tej sumy, policzyć ile bitów w tej reprezentacji to `1`,
- jeśli liczba bitów `1` jest parzysta `(x, y)` reprezentuje otwartą przestrzeń,
- jeśli liczba bitów `1` jest nieparzysta `(x, y)` reprezentuje ścianę.
  
Na przykład, jeśli ulubionym numerem projektanta biura jest `10`, poniżej widzisz układ biura gdzie ściany pokazane są jako `#` a otwarta przestrzeń jako `.`. Narożnik budynku wygląda tak:

      0123456789
    0 .#.####.##
    1 ..#..#...#
    2 #....##...
    3 ###.#.###.
    4 .##..#..#.
    5 ..##....#.
    6 #...##.###
  
Załóżmy, że chciałbyś dotrzeć do pozycji `(7, 4)`. Najkrótsza droga, którą mógłbyś obrać oznaczona jest `O`:

      0123456789
    0 .#.####.##
    1 .O#..#...#
    2 #OOO.##...
    3 ###O#.###.
    4 .##OO#OO#.
    5 ..##OOO.#.
    6 #...##.###
  
Więc dotarcie do punktu `(7, 4)` wymaga 11 kroków (zaczynając od pozycji `(1, 1)`).

Zakładając, że ulubionym numerem projektanta biura jest `1362`, jaka jest minimalna liczba kroków potrzebna do dotarcia do punku `(31, 39)`?

## Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day13), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
