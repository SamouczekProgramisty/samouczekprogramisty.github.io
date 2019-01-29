---
title: Advent of Code 2016 dzień 18
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-18/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_18_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_18_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 18. Trafiłeś do pokoju, w którym w podłodze ukrytych jest sporo pułapek. Znasz algorytm według, którego układane były pułapki. Które kafle są bezpieczne?
disqus_page_identifier: 689 http://www.samouczekprogramisty.pl/?p=689
toc: false
---

## Wprowadzenie

{% include aoc-2016-link.md day="18" %}

## Dzień 18 zadanie 1

Rozwiązanie poprzedniego zadania pozwoliło Ci dostać się do [sejfu]({% post_url 2016-12-19-advent-of-code-2016-dzien-17 %}). W sejfie były tylko wskazówki jak dotrzeć do pewnego pokoju, był nieźle ukryty. Jak tylko wszedłeś do pokoju usłyszałeś głośne kliknięcie. Okazuje się, że część kafli na podłodze to pułapki. Ta, którą właśnie wyzwoliłeś wystrzeliła, cudem udało Ci się uniknąć tego co miała z Tobą zrobić. Następnym razem nie będziesz miał tyle szczęścia...

Po dokładniejszym przyjrzeniu się, ułożenie pułapek i bezpiecznych kafli w pokoju wydaje się pasować do pewnego wzoru. Kafle ułożone są w rzędach o tej samej szerokości. Znalazłeś karteczkę z zapisem bezpiecznych kafli (`.`) i pułapek (`^`) w pierwszym rzędzie (wejście do programu).

Rodzaj kafla (pułapka czy normalne, bezpieczne pole) w każdym rzędzie bazuje na typach kafli w rzędzie poprzednim. Z poprzedniego rzędu istotne są kafel w poprzedniej kolumnie, w tej samej kolumnie i w następnej kolumnie. Jeśli kafel jest w pierwszej lub ostatnie kolumnie jego odpowiedniki w poprzednim rzędzie znajdujące się "w ścianie" uznawane są za bezpieczne.

Na przykład, załóżmy, że znasz pierwszy rząd (oznaczony literami) i chciałbyś dowiedzieć się o kaflach w następnym rzędzie (oznaczonym liczbami):

    ABCDE
    12345

Rodzaj kafla 2 zależy od rodzaju kafli `A`, `B` i `C`. Rodzaj kafla 5 zależy od kafli `D`, `E` i "bezpiecznego kafla w ścianie". Nazwijmy kafle z poprzedniego rzędu lewym, środkowy i prawym. Wówczas kafel jest pułapką wtedy i tylko wtedy gdy spełniona jest jedna z poniższych sytuacji:
- lewy i środkowy kafel są pułapkami, prawy kafel jest bezpieczny,
- środkowy i prawy kafel są pułapkami, lewy kafel jest bezpieczny,
- tylko lewy kafel jest pułapką,
- tylko prawy kafel jest pułapką.

Każda inna sytuacja oznacza, że kafel jest bezpieczny.

Załóżmy, że pierwszy rząd to `..^^.`, stosując reguły przedstawione powyżej możesz poznać kafle w kolejnych rzędach:

- Pierwszy kafel w następnym rzędzie bierze pod uwagę "nieistniejący kafel ze ściany", środkowy (pierwsza `.` oznaczająca bezpieczny kafel) i prawy (druga `.`, także bezpieczny) kafel z poprzedniego rządu. Ponieważ żadna z reguł określająca pułapkę nie została spełniona, kafel jest bezpieczny,
- kolejny kafel w następnym rzędzie bierze pod uwagę lewy (`.`), środkowy (`.`) i prawy (`^`) kafel z poprzedniego rzędu. Taki układ pasuje do czwartej reguły więc ten kafel to pułapka,
- trzeci kafel bierze pod uwagę `.^^`, taki układ pasuje do drugiej reguły, ten kafel to także pułapka,
- ostatnie dwa kafle pasują odpowiedni do pierwszej i trzeciej reguły dla pułapek – oba kafle to pułapki.

Po zastosowaniu tych kroków poznałeś kolejny rząd kafli w pokoju `.^^^^`. Następnie używając tych samych reguł możesz poznać trzeci rząd `^^..^`. Układ kafli w pierwszych trzech rzędach wygląda następująco:

    ..^^.
    .^^^^
    ^^..^

Poniżej jest przykład z trochę większego pokoju o dziesięciu rzędach i kolumnach:

    .^^.^.^^^^
    ^^^...^..^
    ^.^^.^.^^.
    ..^^...^^^
    .^^^^.^^.^
    ^^..^.^^..
    ^^^^..^^^.
    ^..^^^^.^^
    .^^^..^.^^
    ^^.^^^..^^

W powyższym przykładzie, w dziesięciu rzędach jest 38 bezpiecznych kafli.

Zakładając, że pierwszy rząd dla pokoju, w którym się znajdujesz jest w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day18_input.txt) – ile jest bezpiecznych kafli w pierwszych 40 rzędach (wliczając podany)?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day18), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
