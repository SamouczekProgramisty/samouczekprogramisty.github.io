---
title: Advent of Code 2016 dzień 6
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-6/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_06_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_06_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 6. Dzisiaj próbujemy skontaktować się ze Świętym Mikołajem. Kod z powtórzeniami może pomóc odszyfrować zakłóconą transmisję.
disqus_page_identifier: 611 http://www.samouczekprogramisty.pl/?p=611
toc: false
---

## Wprowadzenie

{% include aoc-2016-link.md day="6" %}

## Dzień 6 zadanie 1

Wczorajsze [złamanie kodu do drzwi]({% post_url 2016-12-07-advent-of-code-2016-dzien-5 %}) pomogło Ci dostać się do odpowiedniego pokoju z prezentami. Dzisiaj próbujesz skontaktować się ze Świętym Mikołajem. Coś się jednak zacina. Na szczęście sygnał nie jest w pełni zakłócony i instrukcja w sytuacjach jak ta zaleca przełączenie się do [kodu z powtórzeniami](https://en.wikipedia.org/wiki/Repetition_code) żeby przesłać wiadomość poprawnie.

W tym modelu wiadomość wysyłana jest kilkukrotnie. Zachowałeś wszystkie otrzymane do tej pory sygnały, jednak dane wydają się być dość mocno zakłócone. Prawie niemożliwe do odzyskania. Prawie robi wielką różnicę :).

Jedyne co musisz zrobić to odnaleźć, która litera powtarza się największą liczbę razy na każdej pozycji. Na przykład, zakładając, że otrzymałeś następujące sygnały:

    eedadn
    drvtee
    eandsr
    raavrd
    atevrs
    tsrnev
    sdttsa
    rasrtv
    nssdts
    ntnada
    svetve
    tesnvt
    vntsnd
    vrdear
    dvrsen
    enarar

Najczęściej pojawiającą się literą na pierwszej pozycji jest e, na drugiej a na trzeciej s i tak dalej. Łącząc te litery ze sobą otrzymasz prawdziwy sygnał bez zakłóceń, easter.

Zakładając, że wszystkie przychodzące komunikaty zostały zapisane w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day06_input.txt), jaka wiadomość (po oczyszczeniu zakłóceń) była rzeczywiście wysłana?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day06), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
