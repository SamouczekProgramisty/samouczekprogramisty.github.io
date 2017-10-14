---
title: Advent of Code 2016 dzień 14
date: '2016-12-16 21:08:40 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-14/"
---
Advent of Code 2016 dzień 14. Żeby skontaktować się ze Świętym Mikołajem potrzebujesz zestawu haseł jednorazowych, pomożesz je wygenerować?

# Wprowadzenie
  
{% include aoc-2016-link.md day="14" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 14 zadanie 1
  
Po udanej [przeprawie przez labirynt](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-13/) chciałbyś przesłać wiadomość do Świętego Mikołaja. Żeby bezpiecznie połączyć się ze Świętym Mikołajem w trakcie misji używałeś haseł jednorazowych. Generowałeś je używając algorytmu, który został wcześniej zatwierdzony. Niestety hasła, które miałeś wygenerowane już się skończyły. Musisz wygenerować kolejne.

Do wygenerowania haseł potrzebujesz strumienia danych losowych. Strumień ten uzyskasz licząc sumę MD5 z odpowiednio przygotowanego łańcucha znaków. Łańcuch ten składa się z dwóch części. Pierwsza z nich jest stała (wejście do twojego programu), druga to zwiększająca się o 1 liczba całkowita zapisana dziesiętnie. Suma MD5 z takiego łańcucha powinna być przestawiona w postaci heksadecymalnej.

Niestety, nie wszystkie takie sumy MD5 to hasła a Ty potrzebujesz kolejnych 64 do dalszej komunikacji z Mikołajem. Suma MD5 jest hasłem jeśli:

- Zawiera trzy takie same znaki pod rząd, na przykład `777`, weź pod uwagę wyłącznie pierwszą trójkę w sumie,
- w kolejnych 1000 sum ten sam znak powtórzony jest pięć razy pod rząd, na przykład `77777`.
  
  
Jeśli jakaś suma zawiera pięć znaków pod rząd także powinieneś ją traktować jako potencjalne hasło (mając pięć powtórzonych znaków, oczywiście suma ma też trzy powtórzone znaki).

Na przykład, jeśli wejściem do programu jest `abc`:

- Pierwszy indeks, w którym suma MD5 zawiera potrojony znak to 18. Suma MD5 z `abc18` zawiera `...cc38887a5...`. Mimo to, indeks 18 nie liczy się jako poprawne hasło, ponieważ żadna z kolejnych 1000 sum (indeksy 19 do 1018 włącznie) nie zawiera `88888`,
- kolejny indeks, który zawiera potrojony znak to 39. Suma MD5 z `abc39` zawiera `eee`. Jest to także pierwsze poprawne hasło, ponieważ jedna z kolejnych 1000 sum (ta z indeksem 816) zawiera `eeeee`,
- żadna z kolejnych sześciu trójek występująca w kolejnych sumach nie jest hasłem, jednak kolejna już tak. Suma z indeksu 92 zawiera `999` a indeks 200 zawiera `99999`.
- w końcu indeks 22728 spełnia wszystkie wymagania i produkuje sześćdziesiąte czwarte hasło.
  
  
Więc w naszym przykładzie, jeśli wejściem do programu jest `abc`, indeks 22728 produkuje sześćdziesiąte czwarte hasło jednorazowe.

Jeśli wejściem do Twojego programu jest `yjdafjpo` który indeks generuje sześćdziesiąte czwarte hasło?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day14), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

