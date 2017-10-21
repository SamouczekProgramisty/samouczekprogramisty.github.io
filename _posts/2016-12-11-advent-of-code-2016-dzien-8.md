---
title: Advent of Code 2016 dzień 8
date: '2016-12-11 01:35:45 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-8/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_08_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_08_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 8. Twoja pomoc jest potrzebna w symulacji pracy zniszczonego wyświetlacza. Dasz radę rozwiązać to zadanie?
disqus_page_identifier: 625 http://www.samouczekprogramisty.pl/?p=625
---

## Wprowadzenie

{% include aoc-2016-link.md day="8" %}

## Dzień 8 zadanie 1

Dzięki Twoje pomocy [poprzednio]({% post_url 2016-12-09-advent-of-code-2016-dzien-7 %}) udało się znaleźć wszystkie adresy w Kwaterze Głównej Króliczka Wielkanocnego wspierające TLS. Dzisiaj czeka na Ciebie inne zadanie.

Trafiłeś na drzwi. Wydaje się, że drzwi implementują coś w rodzaju uwierzytelniania dwuskładnikowego. Aby przez nie&nbsp;przejść na początku musisz użyć karty magnetycznej (z tym nie ma problemu, jedną znalazłeś na pobliskim biurku). Następnie, na malutkim ekranie pokazywany jest kod, który musisz wklepać na klawiaturze przy drzwiach. Później można tylko zakładać, że drzwi się otworzą.

Niestety, wyświetlacz, na którym pokazywany jest kod jest rozbity. Po kilku minutach i rozłożeniu wszystkiego na części dowiedziałeś się dokładnie jak on działa. Teraz nie zostało już nic innego jak tylko dojść do tego co pokazałby wyświetlacz.

Pasek magnetyczny na karcie, której możesz użyć do otworzenia drzwi zawiera sekwencje instrukcji dla wyświetlacza. Te instrukcje są także wejściem do zadania, które musisz rozwiązać. Ekran ma 50 pikseli szerokości i 6 pikseli wysokości. Wszystkie piksele na początku są wyłączone. Sam ekran jest w stanie wykonać trzy specyficzne polecenia:

- `rect AxB` włącza wszystkie piksele w prostokącie w lewym górnym rogu ekranu. Prostokąt jest szeroki na `A` pikseli i wysoki na `B` pikseli,
- `rotate row y=A by B` przesuwa wszystkie piksele w rzędzie `A` (gdzie 0 to pierwszy wiersz od góry) w prawo o `B` pikseli. Piksele, które "wypadłyby" za ekran pokazują się po lewej stronie ekranu,
- `rotate column x=A by B` przesuwa wszystkie piksele w kolumnie `A` (gdzie 0 to pierwsza kolumna od lewej strony) w dół o `B` pikseli. Pikseke, które "wypadłyby za ekran pokazują się na górze kolumny.

Dla przykładu poniższa sekwencja pokazuje operacje dla mniejszego ekranu o wymiarach 7 na 3 pikseli:
- `rect 3x2` tworzy mały prostokąt w lewym górnym rogu,

```
###....
###....
.......
```

- `rotate column x=1 by 1` przesuwa kolumnę 1 w dół o 1 piksel,

```
#.#....
###....
.#.....
```

- `rotate row y=0 by 4` przesuwa wiersz 0 w prawo o 4 piksele,

```
....#.#
###....
.#.....
```

- `rotate column x=1 by 1` ponownie przesuwa kolumnę 1 w dół o 1 piksel. Tym razem piksel z ostatniego rzędu pojawia się w pierwszym rzędzie,

```
.#..#.#
#.#....
.#.....
```

Jak widzisz, ta technologia obsługi ekranów ma niesamowite możliwości i niedługo zdominuje rynek małych wyświetlaczy. Przynajmniej tak twierdzi naklejka reklamowa z tyłu wyświetlacza.

Twoim zadaniem jest policzenie pikseli, które będą świeciły się na ekranie po wprowadzeniu sekwencji komend z [pliku wejściowego](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day08_input.txt).

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day08), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!
