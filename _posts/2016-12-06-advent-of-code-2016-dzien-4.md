---
layout: post
title: Advent of Code 2016 dzień 4
date: '2016-12-06 18:01:18 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-4/"
---
Advent of Code 2016 dzień 4. Potrzeba jest pomoc przy odszyfrowaniu listy pokoi w Kwaterze Głównej. Bez kilku linijek kodu się nie obędzie...

# Wprowadzenie
  
[idea]Oryginalna strona z zadaniami z [Advent of Code 2016](http://adventofcode.com/2016). Zadanie z artykułu dostępne jest pod adresem [http://adventofcode.com/2016/day/4](http://adventofcode.com/2016/day/4)[/idea]

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

[idea]Jeśli masz ochotę na odrobinę rywalizacji możesz dołączyć do klasyfikacji, którą założyłem na oryginalnej stronie. Aby dołączyć do tej klasyfikacji zaloguj się na [http://adventofcode.com/2016](http://adventofcode.com/2016) i dołącz wpisując kod `124245-88569bd0`.[/idea]

# Dzień 4 zadanie 1
  
Twoja pomoc z problemem trójkątów [z wczoraj](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-3/) pozwoliła dotrzeć do automatu informacyjnego z listą pokoi. Oczywiście lista jest zaszyfrowana i pełna nieprawdziwych danych mających wprowadzić Cię w błąd. Całe szczęście udało Ci się znaleźć ledwo ukryte instrukcje jak dekodować te dane. Zacznij jednak od usunięcia danych, ktróre są niepoprawne.

Każdy pokój składa się z zaszyfrowanej nazy (małe litery oddzielone minusami), po której jest minus, identyfikator sektoru i suma kontrolna w nawiasach kwadratowych.

Nazwa pokoju jest prawdziwa jeśli suma kontrolna to pięć najczęściej spotykanych liter w zaszyfrowanej nazwie pokou. Litery powinny być ułożone w porządku malejącym według liczby wystąpień. Jeśli kilka liter ma taką samą liczbę wystąpień, to powinny być one posortowane alfabetycznie. Dla przykładu:

- `aaaaa-bbb-z-y-x-123[abxyz]` jest poprawną nazwą pokoju ponieważ najczęściej występującymi literami są a (5), b (3). x, y i z mające po jednym wystąpieniu posortowane są alfabetycznie,
- `a-b-c-d-e-f-g-h-987[abcde]` jest poprawną nazwą pokoju, chociaż wszystkie litery występują dokładnie taka samą liczbę razy suma kontrolna zawiera pierwszą piątkę posortowaną alfabetycznie,
- `not-a-real-room-404[oarel]` jest poprawną nazwą pokoju`,`
- `totally-real-room-200[decoy]` jest błędną nazwą pokju - suma kontrolna nie jest poprawna.
  
  
Biorąc pod uwagę prawdziwe nazwy pokoi z powyższej listy suma ich sektorów wynosi 1514.

Jaka jest suma sektorów prawdziwych pokoi z listy [tej listy](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day04_input.txt)?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day04), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

