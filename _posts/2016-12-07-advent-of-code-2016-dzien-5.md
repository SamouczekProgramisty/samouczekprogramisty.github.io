---
title: Advent of Code 2016 dzień 5
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-5/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_05_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_05_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 5. Tym razem trzeba znaleźć hasło do drzwi. Tu poznasz czym jest bruteforce ;)...
disqus_page_identifier: 606 http://www.samouczekprogramisty.pl/?p=606
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2016" day="5" %}

## Dzień 5 zadanie 1

Dzięki temu, że [wczoraj]({% post_url 2016-12-06-advent-of-code-2016-dzien-4 %}) znalazłeś poprawny pokój, dzisiaj stoisz przed drzwiami bezpieczeństwa opracowanymi przez inżynierów Króliczka Wielkanocnego. Wydaje się, że większość swojej wiedzy o bezpieczeństwie wyciągnęli oglądając [filmy](https://en.wikipedia.org/wiki/Hackers_%28film%29) o [hakerach](https://en.wikipedia.org/wiki/WarGames).

Hasło chroniące drzwi o długości ośmiu znaków wygenerowane jest znak po znaku znajdując odpowiednią sumę [MD5](https://en.wikipedia.org/wiki/MD5). Suma ta generowana jest na podstawie identyfikatora drzwi i numeru. Numer przy każdej iteracji zwiększamy o jeden zaczynając od 0.

Hash zawiera kolejny symbol kodu jeśli jego [heksadecymalna](https://en.wikipedia.org/wiki/Hexadecimal) reprezentacja zaczyna się pięcioma zerami. Jeśli tak jest, szósty znak w sumie jest kolejnym znakiem hasła do drzwi.

Dla przykładu, jeśli identyfikator drzwi to `abc`:

- Pierwszy numer, przy którym otrzymamy sumę zaczynającą się od pięciu zer to `3231929`. Tę sumę MD5 znajdziemy dla łańcucha `abc3231929`. Szósty znak otrzymanej sumy kontrolnej, jest kolejnym znakiem hasła. W tym przypadku szósty znak to `1` i jest pierwszy znakiem hasła,
- przy `5017308` otrzymamy kolejną interesującą nas sumę kontrolną, zaczyna się ona od `000008f82`, więc drugim znakiem hasła jest `8` (szósty znak w sumie),
- trzecią suma zaczynająca się od pięciu zer otrzymamy dla łańcucha `abc5278568`, odnajdując kolejny znak hasła `f`.

W tym przykładzie, kontynuując poszukiwania aż odnajdziemy osiem znaków hasło jakie otrzymamy to `18f47a30`.

Jakie będzie hasło jeśli identyfikator drzwi to `abbhdwsy`?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day05), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
