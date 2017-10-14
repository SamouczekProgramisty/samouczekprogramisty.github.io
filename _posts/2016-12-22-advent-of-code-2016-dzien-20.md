---
layout: default
title: Advent of Code 2016 dzień 20
date: '2016-12-22 21:44:35 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-20/"
---
Advent of Code 2016 dzień 20. Potrzebna jest Twoja pomoc przy odnalezieniu pierwszego adresu IP, który nie jest zablokowany przez firewall. Pomożesz?

# Wprowadzenie
  
{% include aoc-2016-link.md day="20" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 20 zadanie 1
  
Dzięki Tobie wczoraj udało się [znaleźć Elfa](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-19/), który ma wszystkie prezenty. Dzisiaj chciałbyś wpiąć do sieci swój mały mikroprocesor żeby mieć dostęp do sieci później. Jednak firewall w Kwaterze Głównej pozwala tylko na komunikację z kilkoma zewnętrznymi adresami IP.

Udało Ci się dostać do listy blokowanych adresów IP, jednak lista jest strasznie słabo utrzymana. Wszystkie IP są pomieszane i nie jest jasne które adresy IP są dozwolone. Ponadto, adresy nie są zapisane w standardowej notacji a jako zwykłe liczby całkowite, które mogą mieć wartość od 0 do 4294967295 włącznie.

Na przykład, załóżmy, że tylko wartości od 0 do 9 były poprawne i udało Ci się wyciągnąć następującą listę zablokowanych adresów:

    5-80-24-7

  
Lista określa zakresy adresów IP, zarówno startowa jak i końcowa wartość są zabronione. W takim przypadku wyłącznie adresy IP 3 i 9 są dozwolone, jako jedyne nie są w żadnym z zablokowanych zakresów.

Zakładając, że lista zablokowanych adresów znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day20_input.txt), jaka jest najniższa wartość IP, który nie jest zablokowany?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day20), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

