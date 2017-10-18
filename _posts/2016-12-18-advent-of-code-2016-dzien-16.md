---
title: Advent of Code 2016 dzień 16
date: '2016-12-18 13:23:48 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-16/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_16_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_16_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 16. Wiesz czym są fraktale? Okazuje się, że pewien mechanizm do ich generowania wykorzystuje się w Kwaterze Głównej. Dasz radę przechytrzyć systemy bezpieczeństwa i wygenerować odpowiednią sumę kontrolną?
---

## Wprowadzenie

{% include aoc-2016-link.md day="16" %}

## Dzień 16 zadanie 1

Wczoraj [wyciągnąłeś kapsułę z ruchomej rzeźby]({% post_url 2016-12-17-advent-of-code-2016-dzien-15 %}), dzisiaj czeka na Ciebie zupełnie inne zadanie. Wróciłeś do skanowania sieci w Kwaterze Głównej Króliczka Wielkanocnego, niestety tym razem zostawiłeś ślady, które mogą Cię zdradzić. Musisz nadpisać część dysków z danymi, które wyglądają jak losowe żeby zatrzeć ślady i zaktualizować lokalny system bezpieczeństwa sumą kontrolną tych danych.

Aby te wygenerowane dane nie wyglądały podejrzanie muszą spełniać kilka warunków. Czysto losowe dane zostaną wykryte. Aby wygenerować odpowiednią sekwencję danych, które oszukają mechanizmy wykrywania intruzów musisz użyć zmodyfikowanego fraktala "[smoka Heighwaya](https://en.wikipedia.org/wiki/Dragon_curve)".

Zacznij od stanu początkowego (wejście do Twojego programu). Następnie, do momentu kiedy nie będziesz miał wystarczającej ilości danych do wypełnienia dysku powtarzaj następujące kroki:

- Nazwij dane, które masz na tym etapie jako "a",
- zrób kopię "a", nazywając ją "b",
- odwróć kolejność znaków w "b",
- zamień wszystkie `0` na `1` i wszystkie `1` na `0`,
- połącz ze sobą "a" i "b" wstawiając `0` pomiędzy nimi.

Na przykład, po jednym kroku takiego algorytmu:
- `1` zamienia się w `100`,
- `0` zamienia się w `001`,
- `11111` zamienia się w `11111000000`,
- `111100001010` zamienia się w `1111000010100101011110000`.

Powtarzaj te kroki dopóki nie będziesz miał wystarczającej ilości danych żeby wypełnić dysk.

Kiedy już wygenerujesz dane, musisz także policzyć sumę kontrolną dla tych danych. Do liczenia sumy użyj wyłącznie tych danych, które zmieszczą się na dysku, nawet jeśli w ostatnim kroku wygenerowałeś więcej danych.

Suma kontrolna danych jest stworzona na podstawie każdej nie nakładającej się pary znaków w danych. Jeśli oba znaki są takie same (`00` lub `11`), kolejny numer sumy kontrolnej to 1. Jeśli znaki są różne (`01` lub `10`), następny numer sumy kontrolnej to 0. Ten proces powinien stworzyć nowy łańcuch znaków, który będzie krótszy dokładnie o połowę. Jeśli długość sumy kontrolnej jest parzysta powtórz ten proces tak długo dopóki nie otrzymasz sumy kontrolnej z nieparzystą liczbą znaków.

Na przykład, załóżmy, że chcemy wypełnić dysk danymi o długości 12 znaków. Po wygenerowaniu danych pierwsze 12 znaków to `110010110100`. Aby wygenerować sumę kontrolną:

- Weź pod uwagę każdą parę: `11`, `00`, `10`, `11`, `01`, `00`,
- pary odpowiednio mają identyczne, identyczne, różne, identyczne, różne i identyczne numery, w wyniku czego uzyskujemy `110101`,
- suma ma długość parzystą więc powtarzamy proces,
- pary tym razem to `11` (identyczne), `01` (różne) i `01` (różne),
- tym razem suma kontrolna `100` ma nieparzystą długość co kończy proces.

Więc w naszym przypadku, suma kontrolna dla `110010110100` to `100`.

Łącząc te wszystkie kroki ze sobą, załóżmy, że chcesz wypełnić dysk o długości 20 znaków używając danych wejściowych `10000`:

- ponieważ `10000` jest za krótkie, musimy wygenerować więcej danych,
- po pierwszej rundzie algorytmu uzyskujemy `10000011110` (11 znaków), nadal za mało,
- po drugiej rundzie algorytmu uzyskujemy `10000011110010000111110` (23 znaki), wystarczy,
- ponieważ potrzebujemy 20 znaków a wygenerowaliśmy 23 pozbywamy się trzech ostatnich uzyskując `10000011110010000111`,
- następnie liczymy sumę kontrolną, po pierwszej rundzie mamy `0111110101`, suma ma 10 znaków więc kontynuujemy,
- po dwóch rundach suma kontrolna to `01100`, ponieważ długość sumy kontrolnej jest nieparzysta przerywamy algorytm.

W tym przypadku poprawna suma kontrolna to `01100`.

Zakładając, że dysk, który chcesz wypełnić ma 272 znaki i sekwencja początkowa to `10011111011011001` jaka jest poprawna suma kontrolna?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day16), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!
