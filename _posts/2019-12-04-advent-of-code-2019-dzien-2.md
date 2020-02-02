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
excerpt: Advent of Code 2019 dzień 2. Tym razem próbujesz podsłuchać ruch sieciowy w Kwaterze Głównej Króliczka Wielkanocnego. Problem w tym, że używa się tam IPv7...
toc: false
---

## Wprowadzenie

{% include aoc-link.md year="2019" day="2" %}

## Dzień 2 zadanie 1

W drodze do osiągniącia [asysty grawitacyjnej](https://en.wikipedia.org/wiki/Gravity_assist) wokół księżyca twój komputer pokładowy zaczął gwałtownie pikać informując o [programie alarmowym 1202](https://www.hq.nasa.gov/alsj/a11/a11.landing.html#1023832). Przez radio Elf zaczął właśnie wyjaśniać jak zachować się w tej sytuacji: „Nie przejmuj się, to jest zupełnie norma---”, gdy właśnie komputer pokładowy [stanął w płomieniach](https://en.wikipedia.org/wiki/Halt_and_Catch_Fire).

Dałeś znać Elfom, że [magiczny dym](https://en.wikipedia.org/wiki/Magic_smoke) pradopodobnie ulotnił się z komputera pokładowego. „Ten komputer uruchamiał programy Intcode, jak ten do asysty grawitacyjnej. Na pewno znajdziesz zapasowe części, które pozwolą ci zbudować nowy komputer, który będzie mógł uruchamiać programy Intcode”.

Program Intcode to lista liczb całkowitych oddzielonych przecinkami (na przykład `1,0,0,3,99`). Aby uruchomić taki program zacznij od pierwszej liczby całkowitej (nazywanej pozycją 0). W tym miejscu znajdziesz tak zwany opcode – będzie to `1`, `2` albo `99`. Opcode określa co należy zrobić, na przykład `99` oznacza, że proram jest skończony i powinien natychmiast się zakończyć. Jeśli napotkasz nieznany opcode oznacza to, że coś poszło nie tak.

Opcode `1` dodaje do siebie dwa numery znajdujące się na dwóch kolejnych pozycjach i zachowuje wynik na trzeciej pozycji.

Opcode 1 adds together numbers read from two positions and stores the result in a third position. The three integers immediately after the opcode tell you these three positions - the first two indicate the positions from which you should read the input values, and the third indicates the position at which the output should be stored.

For example, if your Intcode computer encounters 1,10,20,30, it should read the values at positions 10 and 20, add those values, and then overwrite the value at position 30 with their sum.

Opcode 2 works exactly like opcode 1, except it multiplies the two inputs instead of adding them. Again, the three integers after the opcode indicate where the inputs and outputs are, not their values.

Once you're done processing an opcode, move to the next one by stepping forward 4 positions.

For example, suppose you have the following program:

1,9,10,3,2,3,11,0,99,30,40,50

For the purposes of illustration, here is the same program split into multiple lines:

1,9,10,3,
2,3,11,0,
99,
30,40,50

The first four integers, 1,9,10,3, are at positions 0, 1, 2, and 3. Together, they represent the first opcode (1, addition), the positions of the two inputs (9 and 10), and the position of the output (3). To handle this opcode, you first need to get the values at the input positions: position 9 contains 30, and position 10 contains 40. Add these numbers together to get 70. Then, store this value at the output position; here, the output position (3) is at position 3, so it overwrites itself. Afterward, the program looks like this:

1,9,10,70,
2,3,11,0,
99,
30,40,50

Step forward 4 positions to reach the next opcode, 2. This opcode works just like the previous, but it multiplies instead of adding. The inputs are at positions 3 and 11; these positions contain 70 and 50 respectively. Multiplying these produces 3500; this is stored at position 0:

3500,9,10,70,
2,3,11,0,
99,
30,40,50

Stepping forward 4 more positions arrives at opcode 99, halting the program.

Here are the initial and final states of a few more small programs:

    1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2).
    2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6).
    2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801).
    1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99.

Once you have a working computer, the first step is to restore the gravity assist program (your puzzle input) to the "1202 program alarm" state it had just before the last computer caught fire. To do this, before running the program, replace position 1 with the value 12 and replace position 2 with the value 2. What value is left at position 0 after the program halts?

## Podsumowanie

Zachęcam Cię do dalszej zabawy z drugą częścią zadania, jego treść pokaże się na stronie AoC2019 po rozwiązaniu pierwszej. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/kbl/aoc2019/tree/master/src/aoc/day01)[^go], jednak zrób to raczej w ostateczności.

[^go]: W tym roku do rozwiązywania zadań użyłem języka Go.

Na koniec mam do Ciebie prośbę – podziel się linkiem do artykułu ze znajomymi, którym może się on przydać. Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do samouczkowego newslettera i [polub Samouczka](https://www.facebook.com/SamouczekProgramisty) na Facebook'u. Do następnego razu!
