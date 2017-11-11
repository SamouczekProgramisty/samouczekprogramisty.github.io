---
title: Advent of Code 2016 dzień 11
date: '2016-12-13 18:35:03 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-11/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_11_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_11_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 11. Dzisiaj trzeba przetransportować windą mikrochipy i generatory na ostatnie piętro. Ostrzegam, nie jest to proste zadanie! Dasz radę to zrobić?
disqus_page_identifier: 648 http://www.samouczekprogramisty.pl/?p=648
toc: false
---

## Wprowadzenie

{% include aoc-2016-link.md day="11" %}

## Dzień 11 zadanie 1

[Wczoraj]({% post_url 2016-12-12-advent-of-code-2016-dzien-10 %}), dzięki Twojej pomocy udało się poprawnie sterować dronami, dziś czeka na Ciebie duuużo trudniejsze zadanie. Nie zrażaj się jeśli coś nie będzie szło po Twojej myśli, nie jest to trywialny problem :).

Dzisiaj doszedłeś do miejsca gdzie cztery piętra, poza małym korytarzem, zostały zupełnie odseparowane od reszty budynku. Przechodząc przez niego widzisz znaki ostrzegające o promieniowaniu i wielki znak na którym widnieje napis "Dział Badania Cząstek Radioaktywnych".

Według konsoli pokazującej status cząstek ten obiekt jest aktualnie wykorzystywany do eksperymentowania z [generatorami radioizotopów z przetwornikami termoelektrycznymi](https://en.wikipedia.org/wiki/Radioisotope_thermoelectric_generator) (ang. _Radioisotope Thermoelectic Generators_) zwanymi także RTG lub generatorami. Generatory są zaprojektowane tak aby mogły być sparowane ze specjalnie przygotowanymi mikrochipami. Sam generator jest wysoce radioaktywnym kamieniem, który generuje energię elektryczną odzyskiwaną z ciepła.

Niestety eksperymentalne RTG mają słabą ochronę przeciwko promieniowaniu. Przez tę wadę są radioaktywne i niebezpieczne. Mikrochipy jako prototypy nie mają normalnej osłony przeciwko promieniowaniu ale mają możliwość generowania pola elektromagnetycznego, które chroni przez promieniowaniem. Aby móc wydzielić tę osłonę mikrochipy muszą być zasilane. Niestety mogą one być zasilone wyłącznie przez odpowiadające im RTG. RTG zasilające dany mikrochip jest nadal niebezpieczny dla innych mikrochipów.

Innymi słowy, jeśli mikrochip jest pozostawiony w tym samym obszarze co inny RTG i nie jest połączony do swojego własnego RTG, usmaży się. Zakłada się więc, że będziesz postępował zgodnie z procedurą i trzymał mikrochipy podłączone do odpowiadających im RTG i z dala od RTG dla innych mikrochipów.

Mikrochipy wydają się być bardzo interesujące i przydatne do Twoich aktualnych planów, chciałbyś je zdobyć dla własnych celów. Na 4 piętrze znajduje się maszyna, która jest w stanie złożyć komputer z mikrochipów i generatorów, który będziesz mógł bezpiecznie zabrać ze sobą. Oczywiście aby działał musisz dostarczyć na 4 piętro wszystkie mikrochipy wraz z odpowiadającymi im generatorami.

Wewnątrz części budynku osłonionej przed promieniowaniem (gdzie bezpiecznie jest przechowywać niezłożone RTG), jest winda, która może poruszać się pomiędzy czterema piętrami. Winda maksymalnie może przewozić Ciebie i dwa urządzenia (generatory czy mikrochipy). Jako środek bezpieczeństwa, winda działa wyłącznie jeśli przewozi co najmniej jeden generator lub mikrochip. Winda zawsze zatrzymuje się na każdym piętrze aby doładować swoje baterie. Ładowanie zajmuje tak dużo czasu, że elementy w windzie i elementy na piętrze oddziałują na siebie.

Zrobiłeś notatki dotyczące położenia każdego z elementów (wejście do programu). Zanim założysz strój chroniący przed promieniowaniem i zaczniesz przenosić elementy warto opracować plan w jakiej kolejności należy przenosić poszczególne części.

Gdy wchodzisz do strefy zagrożonej wraz z windą znajdujecie się na pierwszym piętrze.

Dla przykłady, załóżmy, że komponenty w odizolowanej strefie rozłożone są następująco:

- Pierwsze piętro zawiera mikrochip hydrogen i mikrochip lithium,
- drugie piętro zawiera generator hydrogen,
- trzecie piętro zawiera generator lithium,
- czwarte piętro jest puste.

Początkowy układ możemy zapisać jako (F# oznacza numer piętra, E windę (ang. _elevator_), H&nbsp; hydrogen, L lithium, M mikrochip i G generator)

```
F4 .  .  .  .  .
F3 .  .  .  LG .
F2 .  HG .  .  .
F1 E  .  HM .  LM
```

Aby przewieźć wszystko na górę do maszyny składającej na 4 piętrze możesz postępować według następujących kroków:
- Zabrać mikrochip hydrogen na drugie piętro (jest to bezpieczne ponieważ znajduje się tam odpowiadający generator),

```
F4 .  .  .  .  .
F3 .  .  .  LG .
F2 E  HG HM .  .
F1 .  .  .  .  LM
```

- zabrać mikrochip hydrogen razem z odpowiadającym generatorem na trzecie piętro (jest to bezpiecznie ponieważ HM ma HG),

```
F4 .  .  .  .  .
F3 E  HG HM LG .
F2 .  .  .  .  .
F1 .  .  .  .  LM
```

- zostawić generator hydrogen na trzecim piętrze i zjechać z mikrochipem hydrogen na drugie piętro (musisz mieć coś ze sobą, żeby winda ruszyła),

```
F4 .  .  .  .  .
F3 .  HG .  LG .
F2 E  .  HM .  .
F1 .  .  .  .  LM
```

- zjechać na pierwsze piętro (jest to bezpieczne, mikrochipy nie oddziałują na siebie),

```
F4 .  .  .  .  .
F3 .  HG .  LG .
F2 .  .  .  .  .
F1 E  .  HM .  LM
```

- zabrać oba mikrochipy na drugie piętro (ponownie, nie ma tu żadnego generatora, który by je usmażył),

```
F4 .  .  .  .  .
F3 .  HG .  LG .
F2 E  .  HM .  LM
F1 .  .  .  .  .
```

- ponownie zabrać oba mikrochipy wyżej, na trzecie piętro (tym razem każdy z nich ma odpowiadający generator, który chroni je od usmażenia),

```
F4 .  .  .  .  .
F3 E HG HM LG LM
F2 .  .  .  .  .
F1 .  .  .  .  .
```

- zabrać oba mikrochipy na czwarte piętro,

```
F4 E  .  HM .  LM
F3 .  HG .  LG .
F2 .  .  .  .  .
F1 .  .  .  .  .
```

- zostawić mikrochip lithium na czwartym piętrze i zabrać mikrochip hydrogen na trzecie piętro (musisz coś zabrać, żeby winda działa, na trzecim piętrze będziesz bezpieczny, chociaż jest tam generator lithium, jest też generator hydrogen, który chroni odpowiadający mu mikrochip),

```
F4 .  .  .  .  LM
F3 E  HG HM LG .
F2 .  .  .  .  .
F1 .  .  .  .  .
```

- zabrać oba generatory na czwarte piętro (jest to bezpieczne bo mikrochip lithium będzie chroniony przez generator lithium),

```
F4 E  HG .  LG LM
F3 .  .  HM .  .
F2 .  .  .  .  .
F1 .  .  .  .  .
```

- zjechać w dół z mikrochipem lithium (musisz coś zabrać, żeby winda działała),

```
F4 .  HG .  LG .
F3 E  .  HM .  LM
F2 .  .  .  .  .
F1 .  .  .  .  .
```

- zabrać na górę generator i mikrochip lithium

```
F4 E HG HM LG LM
F3 .  .  .  .  .
F2 .  .  .  .  .
F1 .  .  .  .  .
```

Przy takim podejściu potrzeba 11 kroków aby zebrać wszystkie elementy na czwartym piętrze aby móc je złożyć w jedną całość. Każde zatrzymanie się windy liczone jest jako jeden krok, nawet jeśli nic nie jest dodane czy usunięte z windy.

Jaka jest minimalna liczba kroków potrzebna do przeniesienia wszystkich elementów jeśli ich układ opisany jest w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day11_input.txt)?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day11), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!
