---
layout: default
title: Advent of Code 2016 dzień 19
date: '2016-12-21 18:48:37 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-19/"
---
Advent of Code 2016 dzień 19. Elfy podbierają prezenty sobie nawzajem dasz radę odnaleźć tego, który zostanie z wszystkimi prezemtami?

# Wprowadzenie
  
{% include aoc-2016-link.md day="19" %}

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

{% include aoc-2016-leaderboard.md %}

# Dzień 19 zadanie 1
  
Wczoraj przeszedłeś przez [pokój pełen pułapek](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-18/). Dzisiaj przydałyby się pomoc przy znalezieniu elfa, który został se wszystkimi prezentami. Elfy kontaktują się z Tobą przez bardzo bezpieczny kanał bezpieczeństwa. Pogubiły się w zabawie z prezentami.

Każdy elf ma prezent. Wszystkie elfy siedzą w kółku na ponumerowanych krzesłach. Numery zaczynają się od 1. Pierwszy elf zabiera wszystkie prezenty od elfa, który siedzi po jego lewej stronie, elf bez prezentów odchodzi z kółka i nie bierze udziału w dalszej grze.

Na przykład, jeśli w kółku byłoby 5 elfów:

    1 5 2 4 3

- Elf 1 bierze prezent drugiego elfa,
- elf 2 nie ma prezentów więc wypada z gry,
- elf 3 bierze prezent czwartego elfa,
- elf 4 nie ma prezentów więc wypada z gry,
- elf 5 bierze prezenty elfa pierwszego,
- ani elf 1 ani elf 2 nie mają już prezentów więc nie są brane pod uwagę,
- elf 3 zabiera prezenty piątego elfa.
  
  
Więc, gdy w kółku siedzi pięć elfów, ten na pozycji 3 zostanie ze wszystkimi prezentami.

Zakładając, że kółku siedzi `3014603` elfów, który z nich zostanie ze wszystkimi prezentami?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day19), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

