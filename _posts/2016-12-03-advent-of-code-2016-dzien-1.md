---
title: Advent of Code 2016 dzień 1
date: '2016-12-03 11:54:39 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-1/
header:
    teaser: /assets/images/2016/12/advent_of_code_2016_01_artykul.jpg
    overlay_image: /assets/images/2016/12/advent_of_code_2016_01_artykul.jpg
    caption: "[&copy; theslugandlettuce101](https://www.flickr.com/photos/theslugandlettuce101/8422854662/sizes/l)"
excerpt: Advent of Code 2016 czas zacząć. Jest to pierwszy z serii artykułów, które poświęcone będą zadaniom z AoC20016. Dzisiaj pomagamy Mikołajowi dotrzeć do Kwatery Głównej Króliczka Wielkanocnego.
disqus_page_identifier: 578 http://www.samouczekprogramisty.pl/?p=578
toc: false
---

## Wprowadzenie

{% include aoc-2016-link.md day="1" %}

Zadania celowo publikuję z opóźnieniem, aby rozwiązania nie miały wpływu na zabawę innych. Dodatkowo każdego dnia na stronie Advent of Code publikowane są dwa zadania. Drugie dostępne jest po rozwiązaniu pierwszego. Przykładowe rozwiązanie zawiera oba rozwiązania jednak prezentuję treść tylko pierwszego z nich.

Mam nadzieję, że uda mi się rozwiązać wszystkie zadania, chociaż kto wie. Może jak pojawią się trudniejsze problemy algorytmiczne będę potrzebował pomocy? Zobaczymy :).

## Zarys historii

Sanie Świętego Mikołaja potrzebują zegara o bardzo wysokiej dokładności do wskazywania kierunku, oscylator zegara regulowany jest przez gwiazdy. Niestety, gwiazdy zostały ukradzione przez Króliczka Wielkanocnego. Aby ocalić Święta Wielki Mikołaj musi odzyskać wszystkie 50 gwiazdek do 25 grudnia.

Zbieraj gwiazdki rozwiązując zadania, każdego dnia udostępnione będą dwa zadania w kalendarzu adwentowym, drugie zadanie jest dostępne po ukończeniu pierwszego. Za rozwiązanie zadania otrzymujesz gwiazdkę. Powodzenia!

## Dzień 1 zadanie 1

Wylądowałeś niedaleko Kwatery Głównej Króliczka Wielkanocnego. Niestety „niedaleko”, nie oznacza w Kwaterze Głównej. Instrukcje na Dokumentach Rekrutacyjnych Króliczka Wielkanocnego pomagające w dotarcku do Kwater rozpracowały Elfy. Zaczynają się one od miejsca zrzutu, nikt nie miał czasu rozpracować ich do końca aby uzyskać dokładny adres Kwatery.

Dokumenty mówią, że powinieneś rozpocząć swoją podróż do Kwatery w punkcie w którym wylądowałeś i zwrócić się na północ. Następnie powinieneś podążać zgodnie ze wskazówkami - skręcić w lewo (`L`) lub w prawo (`R`) o 90 stopni i iść prosto zadaną liczbę bloków kończąc na nowym skrzyżowaniu.

Nie masz czasu na podążanie za tak absurdalnymi instrukcjami na pieszo, zanim ruszysz wolisz poznać dokładne współżędne celu. Zakładając, że możesz poruszać się wyłącznie [ulicami miasta](https://en.wikipedia.org/wiki/Taxicab_geometry) jak długa jest najkrótsza droga do celu?

Na przykład:

- Podążając za instrukcjami `R2, L3` kończysz 2 bloki na wschód i 3 bloki na północ, lub 5 bloków od pozycji startowej,
- podążając za `R2, R2, R2` kończysz 2 bloki na południe od pozycji startowej,
- podążając za `R5, L5, R5, R3` kończysz 10 bloków na wschód i 2 bloki na północ, lub 12 bloków od pozycji startowej.


Jak daleko od pozycji lądowania znajduje się Kwatera Główna Króliczka Wielkanocnego?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day01), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!
