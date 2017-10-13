---
layout: post
title: Game of Life
date: '2016-11-06 14:01:08 +0100'
categories:
- Strefa zadaniowa
excerpt_separator: "<!--more-->"
permalink: "/game-of-life/"
---
Kolejny artykuł z serii „Strefy zadaniowej Samouczka”. Programowania najlepiej uczyć się rozwiązując konkretne problemy. Artykuł ten stawia przed Tobą właśnie taki problem.&nbsp;Dzisiejszym zadaniem będzie „Gra w życie” :). W każdym momencie możesz też spojrzeć do przykładowego rozwiązania, które dla Ciebie przygotowałem.

# Convey’s Game of Life
  
Gra w życie zakłada, że mamy planszę o nieskończonych wymiarach. Plansza ta podzielona jest na pola, w podobny sposób jak kartka w kratkę. Każda kratka reprezentuje pole. Każde pole ma dokładnie 8 sąsiadów, osiem kratek wokół.

Każde z pól może być w dwóch stanach. Może być żywe bądź martwe.

![plansza game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/zywa13.gif)

W przykładzie powyżej widzisz wycinek planszy na którym mamy żywą komórkę o współrzędnych (1, 3). Oznaczona jest ona czarnym kwadratem.

Gra sprowadza się do przygotowania kolejnych generacji planszy na podstawie jej aktualnego stanu. Kolejna generacja powstaje na podstawie czterech zasad:

- Każda żywa komórka z mniej niż dwoma żywymi sąsiadami umiera w kolejnej generacji z powodu wyludnienia,
- każda żywa komórka z dwoma lub trzema żywymi sąsiadami jest w stanie przetrwać do następnej generacji,
- każda żywa komórka z więcej niż trzema żywymi sąsiadami umiera w kolejnej genracji z powodu przeludnienia,
- każda martwa komórka z dokładnie trzema żywymi sąsiadami staje się żywa w kolejnej generacji.
  
  
Zobacz jak te zasady wyglądają na kilku przykładach.
## Przykład #1
  
W tym przykładzie pierwsza generacja planszy zawiera wyłącznie żywą komórkę na pozycji (1, 3). W kolejnej generacji komórka ta ginie ponieważ nie ma dwóch żywych sąsiadów.

![plansza game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/zywa13.gif) ![pusta plansza game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/pusta.gif)

## Przykład #2
  
W tym przykładzie, w pierwszej generacji mamy trzy żywe komórki na pozycjach (1, 2), (2, 2) i (3, 2). W kolejnej generacji dzieje się już trochę więcej:
- Komórka (1, 2) i (3, 2) giną ponieważ mają tylko jednego żywego sąsiada,
- komórka (2, 2) przeżywa ponieważ ma dokładnie dwóch żywych sąsiadów,
- komórki (2, 1) i (2, 3) ożywają ponieważ mają trzech żywych sąsiadów,
- pozostałe komórki pozostają martwe.
  
  
 ![plansza game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/plansza_okres2_poziom.gif) ![plansza game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/plansza_okres2_pion.gif)

Zauważ, że kolejna generacja prowadzi do kształtu podobnego do poprzedniej. W przypadku tego kształtu i kolejnych generacji okazuje się, że zawsze jakieś żywe komórki powstaną na planszy. Kolejne generacje można pokazać przy pomocy animacji:

![animacja game of life](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/plansza_okres2_animacja.gif)

## Kolejne przykłady
  
Bardziej skomplikowane kształty możesz zobaczyć na filmiku poniżej:

[video\_embed video="C2vgICfQawE" parameters="t=1m11s" mp4="" ogv="" placeholder="" html5\_parameters="" width="700" height="400"]

# Zadanie do wykonania
  
Twoim zadaniem jest napisanie gry w życie.

Aby trochę ułatwić wizualizację, nie będziemy implementowali nieskończonej planszy. Zodyfikujemy wymagania dotyczące planszy. W naszym przypadku planszę ograniczymy do kwadratu o boku N, gdzie N będzie parametrem konstruktora planszy. Nie będzie ona nieskończona, a będzie się „zawijała”. Co to oznacza?

Na poniższym obrazku zaznaczyłem sąsiedztwo dla pola (1, 0). Jak widzisz, „zawija się” ono w taki sposób, że obejmuje także ostatni rząd planszy.

![game of life sasiedztwo (1, 0)](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/plansza_sasiedztwo_10.gif)

Podobnie ma się sytuacja dla narożników. Poniższy obrazek pokazuje sąsiedztwo dla narożnika (0, 0).

![game of life sasiedztwo (0, 0)](http://www.samouczekprogramisty.pl/wp-content/uploads/2016/11/plansza_sasiedztwo_00.gif)

Napisz program, który będzie w stanie wygenerować kolejną generację planszy w „grze w życie”. Nie zapominaj o testach jednostkowych dla swojego programu.

Dla przykładu poniżej umieściłem jeden z testów z przykładowego rozwiązania.

    @Testpublic void shouldBeAbleToProvideNextGenerationWithPeriod() { String boardVisualisation = "+----+" + System.lineSeparator() + "| |" + System.lineSeparator() + "| o |" + System.lineSeparator() + "| o |" + System.lineSeparator() + "| o |" + System.lineSeparator() + "+----+"; Board board = new Board(4, Cell.live(1, 0), Cell.live(1, 1), Cell.live(1, 2)); assertEquals(boardVisualisation, board.toString()); String expected = "+----+" + System.lineSeparator() + "| |" + System.lineSeparator() + "| |" + System.lineSeparator() + "|ooo |" + System.lineSeparator() + "| |" + System.lineSeparator() + "+----+"; Board boardNextGeneration = board.nextGeneration(); assertEquals(expected, boardNextGeneration.toString());}

  
Przygotowałem też dla Ciebie [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/03_game_of_life) wraz z testami jednostkowymi. Możesz zajrzeć na samouczkowego githuba.
# Materiały dodatkowe

- [Artykuł na wikipedii na temat gry w życie](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life),
- [wywiad z autorem Game of Life](https://www.youtube.com/watch?v=R9Plq-D1gEk) – John H. Convey opowiada o Grze w Życie :)
  

# Podsumowanie
  
Mam nadzieję, że udało Ci się napisać grę w życie. Nie jest to duży projekt jednak rozbudowany na tyle, że musisz przećwiczyć podstawowe zagadnienia programowania obiektowego. Niby prosty zestaw zasad, a jaki ciekawy efekt można uzyskać :). Jeśli chciałbyś dostawać informacje o kolejnych artykułach prosto na Twoją skrzynkę zapisz się na mojego newslettera.

Na koniec proszę Cię, żebyś podzielił się informacją o Samouczku ze swoimi znajomymi, którzy też są zainteresowani programowaniem – zależy mi na dotarciu do jak największej liczby czytelników.

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/evaekeblad/916121748/sizes/l

