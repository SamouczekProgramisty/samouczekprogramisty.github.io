---
layout: post
title: Advent of Code 2016 dzień 21
date: '2016-12-23 18:18:32 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/advent-of-code-2016-dzien-21/"
---
Advent of Code 2016 dzień 21. Trzeba zaimplementować serię przekształceń łańcucha znaków aby otrzymać tajne hasło. Bez niego nie będziesz mógł dostać się do systemu operacyjnego.

# Wprowadzenie
  
[idea]Oryginalna strona z zadaniami z [Advent of Code 2016](http://adventofcode.com/2016). Zadanie z artykułu dostępne jest pod adresem [http://adventofcode.com/2016/day/21](http://adventofcode.com/2016/day/21)[/idea]

Advent of Code to inicjatywa, w której codziennie publikowane są zadania algorytmiczne dla programistów. Ich rozwiązywanie pomaga rozwijać umiejętności nie tyko początkujących programistów. W tej serii artykułów pokazuję zadanie opublikowane w ramach Advent of Code 2016 wraz z przykładowym rozwiązaniem.

[idea]Jeśli masz ochotę na odrobinę rywalizacji możesz dołączyć do klasyfikacji, którą założyłem na oryginalnej stronie. Aby dołączyć do tej klasyfikacji zaloguj się na [http://adventofcode.com/2016](http://adventofcode.com/2016) i dołącz wpisując kod `124245-88569bd0`.[/idea]

# Dzień 21 zadanie 1
  
Wczoraj [znalazłeś adres IP komputera](http://www.samouczekprogramisty.pl/advent-of-code-2016-dzien-20/), który nie jest blokowany przez firewall. Komputer, do którego systemu próbujesz się włamać używa dziwnego mechanizmu mieszającego do przechowywania haseł. Mimo to, nie powinno nastręczyć Ci żadnych trudności utworzenie samemu takiego hasła, które możesz dodać do systemu. Wystarczy, że zaimplementujesz odpowiednie przekształcenia.

Operacja mieszająca składa się z serii operacji (dokładna ich lista jest wejściem do programu). Zaczynając od hasła, które ma być pomieszane aplikujesz każdą operację kolejno. Pojedyncze operacje opisane są poniżej:

- `swap position X with position Y` oznacza, że litery pod indeksami `X` i `Y` (zaczynając od `0`) powinny być zamienione,
- `swap letter X with letter Y` oznacza, że litery `X` i `Y` powinny być zamienione (niezależnie na jakich pozycjach się znajdują),
- `rotate left/right X step(s)` oznacza, że cały łańcuch znaków powinien być "przesunięty" w lewo lub prawo o `X` znaków, na przykład przesunięcie łańcucha `abcd` o jedną literę w prawo da Ci `dabc`,
- `rotate based on position of letter X` oznacza, że cały łańcuch znaków powinien być "przesunięty" w prawo. To o ile powinien być przesunięty zależy od indeksu litery `X` zanim łańcuch będzie przesunięty. Jak poznasz indeks litery `X` przesuń łańcuch znaków o jedną pozycję w prawo, dodatkowo przesuń łańcuch w prawo o indeks na którym znajduje się litera `X`. Jeśli indeks był równy bądź większy `4` przesuń łańcuch o jeszcze jedną pozycję w prawo,
- `reverse positions X through Y` oznacza, że zakres pomiędzy `X` i `Y` (włączając oba indeksy) powinien być odwrócony,
- `move position X to position Y` oznacza, że litera, która jest pod indeksem `X` powinna być usunięta z łańcucha i włożona pod indeks `Y`.
  
  
Na przykład, zakładając, że hasło początkowe to `abcde` i chcesz przeprowadzić następującą serię przekształceń:
- `swap position 4 with position 0` zamienia pierwszą i ostatnią literę, otrzymujesz `ebcda`, wynik ten jest wejściem do kolejnego kroku,
- `swap letter d with letter b` zamienia literę `d` z literą `b`, w wyniku czego otrzymasz `edcba`,
- `reverse positions 0 through 4` sprawia, że cały łańcuch znaków jest odwrócony produkując `abcde`,
- `rotate left 1 step` przesuwa w lewo cały łańcuch o jedną literę, w wyniku tego przekształcenia pierwsza litera ląduje na końcu `bcdea`,
- `move position 1 to position 4` usuwa literę na pozycji `1` (`c`), wkładając ją na pozycję `4` (na koniec łańcucha): `bdeac`,
- `move position 3 to position 0` usuwa literę z pozycji `3` (`a`), wkładając ją na pozycję `0` (początek łańcucha): `abdec`,
- `rotate based on position of letter b` znajduje indeks litery `b` (`1`), później rotuje cały łańcuch o `1` plus indeks litery (`2`): `ecabd`,
- `rotate based on position of letter d` znajduje indeks litery `d` (`4`), później rotuje cały łańcuch o `1` plus indeks litery (`4`), dodając dodatkową jedynkę ponieważ indeks był większy bądź równy `4`, finalnie rotuje łańcuch o `6` pozycji: `decab`.
  
  
Po tych wszystkich krokach, hasło to `decab`.

Teraz Twoja kolej. Musisz wygenerować hasło, którego użyjesz aby dostać się do systemu. Zakładając, że lista przekszałceń znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day21_input.txt), a hasło początkowe to `abcdefgh` jakie będzie hasło po przekształceniach?

# Podsumowanie
  
Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day21), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/derekl/sets/72157649148835567

