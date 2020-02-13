---
title: Advent of Code 2019 dzień 2
last_modified_at: 2018-11-24 08:04:40 +0100
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2019-dzien-2/
header:
    teaser: /assets/images/2019/1202-aoc2019-dzien-2/aoc-dzien-2-artykul.jpg
    overlay_image: /assets/images/2019/1202-aoc2019-dzien-2/aoc-dzien-2-artykul.jpg
    caption: "[&copy; Mike Kotsch](https://unsplash.com/photos/VpBmxwllHPE)"
excerpt: Advent of Code 2019 dzień 2. Pomóż zbudować podstawowy komputer Intcode.
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="2" %}

## Dzień 2 zadanie 1

W drodze do osiągniącia [asysty grawitacyjnej](https://en.wikipedia.org/wiki/Gravity_assist) wokół księżyca twój komputer pokładowy zaczął gwałtownie pikać informując o [programie alarmowym 1202](https://www.hq.nasa.gov/alsj/a11/a11.landing.html#1023832). Przez radio Elf zaczął właśnie wyjaśniać jak zachować się w tej sytuacji: „Nie przejmuj się, to jest zupełnie norma…”, gdy właśnie komputer pokładowy [stanął w płomieniach](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire).

Dałeś znać Elfom, że [magiczny dym](https://en.wikipedia.org/wiki/Magic_smoke) prawdopodobnie ulotnił się z komputera pokładowego. „Ten komputer uruchamiał programy Intcode, jak ten do asysty grawitacyjnej. Na pewno znajdziesz zapasowe części, które pozwolą ci zbudować nowy komputer, który będzie mógł uruchamiać programy Intcode”.

Program Intcode to lista liczb całkowitych oddzielonych przecinkami (na przykład `1,0,0,3,99`). Aby uruchomić taki program zacznij od pierwszej liczby całkowitej (znajdującej się na pozycji 0). W tym miejscu znajdziesz tak zwany opcode – będzie to `1`, `2` albo `99`. Opcode określa co należy zrobić, na przykład `99` oznacza, że proram jest skończony i powinien natychmiast się zakończyć. Jeśli napotkasz nieznany opcode oznacza to, że coś poszło nie tak.

Opcode `1` dodaje do siebie numery odczytane z dwóch pozycji i zapisuje ich sumę na trzeciej pozycji. Trzy liczby po opcode odwołują się do tych trzech pozycji – pierwsze dwie oznaczają pozycje, z których powinieneś odczytać wartości wejściowe. Trzecia oznacza pozycję, na której powinieneś zachować wynik.

Na przykład, jeśli komputer Intcode napotka `1,10,20,30` powinien przeczytać wartości na pozycjach `10` i `20`, dodać te wartości i zapisać sumę na pozycji `30` (nadpisując aktualną wartość na tej pozycji).

Opcode `2` działa prawie dokładnie jak opcode `1`, różnica polega na tym, że opcode `2` mnoży dwie liczby i zpisuje iloczyn. Ponownie trzy liczby po opcode oznaczają pozycje wartości wejściowych i miejsca gdzie powinieneś zapisać iloczyn.

Jeśli skończysz obsługiwać opcode przesuń się do następnego przechodząc do przodu o 4 pozycje.

Załółżmy, że przykladowy program wygląda następująco:

    1,9,10,3,2,3,11,0,99,30,40,50

Podzieliłem ten program na kilka linii żeby zwiększyć czytelność:

    1,9,10,3,
    2,3,11,0,
    99,
    30,40,50

Pierwsze cztery liczby `1,9,10,3` są na pozycjach 0, 1, 2 i 3. Razem tworzą pierwszą instrukcję (opcode `1`, dodawanie), pozycje dwóch wartości wejściowych (`9` i `10`) i pozycję wyjściową (`3`). Aby obsłużyć ten opcode na początku musisz pobrać wartości z pozycji wejściowych: pozycja `9` zawiera wartość 30 i pozycja `10` zawiera wartość 40. Dodając te numery otrzymasz 70. Tę wartość należy zapisać na pozycji wyjściowej. W tym przypadku pozycja wyjściowa to `3`. Wartość, która znajduje się na tej pozycji to także 3, więc w tym przypadku opcode nadpisuje wartość 3 znajdującą się na pozycji `3`. Po obsłużeniu tego opcode program wygląda następująco:

    1,9,10,70,
    2,3,11,0,
    99,
    30,40,50

Przechodzisz do przodu o 4 pozycje aby zająć się kolejnym opcode – `2`. Ten opcode zachowuje się prawie tak samo jak poprzedni – mnoży zamiast dodawać. Wartości wejściowe znajdują się na pozycjach 3 i 11, te pozycje zawierają odpowiednio liczby 70 i 50. Mnożąc je otrzymasz wynik 3500, który powinien zostać zapisany na pozycjij 0:

    3500,9,10,70,
    2,3,11,0,
    99,
    30,40,50

Przechodząc do przodu kolejne 4 pozycje napotykasz na opcode `99` – zatrzymanie programu.

Poniżej znajdziesz kilka przykładowych stanów początkowych i końcowych programów:

* `1,0,0,0,99` staje się `2,0,0,0,99` (1 + 1 = 2),
* `2,3,0,3,99` staje się `2,3,0,6,99` (3 * 2 = 6),
* `2,4,4,5,99,0` staje się `2,4,4,5,99,9801` (99 * 99 = 9801),
* `1,1,1,4,99,5,6,0,99` staje się `30,1,1,4,2,5,6,0,99`.

W momencie kiedy będziesz posiadał działający komputer pierwszym krokiem jest wznownienie [programu asystenta grawitacyjnego](https://github.com/kbl/aoc2019/blob/master/input/day02.txt) do stanu „1202 program alarm”, który osiągną krótko przed zapaleniem się poprzedniego komputera. Aby to zrobić, przed uruchomieniem programu zamień wartość pozycji 1 na `12` a wartość pozycji 2 na `2`. Jaką wartość ma pozycja 0 po zakończeniu działania programu?
    
## Podsumowanie

{% include aoc-2019-summary.md year="2019" day="2" %}
