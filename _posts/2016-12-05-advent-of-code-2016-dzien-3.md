---
title: Advent of Code 2016 dzień 3
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-3/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_03_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_03_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 3. Mikołaj trafił do departamentu graficznego i potrzebuje Twojej pomocy ze sprawdzeniem specyfikacji trójkątów ;). Pomożesz?
disqus_page_identifier: 595 http://www.samouczekprogramisty.pl/?p=595
toc: false
---

## Wprowadzenie
  
{% include aoc-link.md year="2016" day="3" %}

## Dzień 3 zadanie 1
  
Po przygodach z [wczorajszego dnia]({% post_url 2016-12-04-advent-of-code-2016-dzien-2 %}) w końcu możesz się skupić i czysto myśleć. Zagłębiłeś się w labirynt korytarzy i boksów biurowych, które wypełniają tę część Kwatery Głównej Króliczka Wielkanocnego. To musi być dział projektantów graficznych, ściany pokryte są specyfikacjami dla trójkątów.

Hmm, czy aby na pewno?

Dokumenty z projektami pokazują długości boków każdego z trójkątów, ale... 5 10 25? Niektóre z nich nie są trójkątami. Musisz odrzucić te niepoprawne.

W poprawnym trójkącie suma dwóch boków musi być krótsza od najdłuższego boku. Na przykład nie można zbudować trójkąta z odcinków o długościach 5, 10 i 25. 5 + 10 nie jest większe niż 25.

Jak dużo poprawnych trójkątów znajduje się w [pliku wejściowym](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/test/resources/day03_input.txt)?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day03), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
