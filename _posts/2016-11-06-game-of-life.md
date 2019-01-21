---
last_modified_at: 2018-06-20 20:57:35 +0200
title: Game of Life
categories:
- Strefa zadaniowa
permalink: /game-of-life/
header:
    teaser: /assets/images/2016/11/06_zadanie_game_of_life_artykul.jpg
    overlay_image: /assets/images/2016/11/06_zadanie_game_of_life_artykul.jpg
    caption: "[&copy; evaekeblad](https://www.flickr.com/photos/evaekeblad/916121748/sizes/l)"
excerpt: Kolejny artykuł z serii „Strefy zadaniowej Samouczka”. Programowania najlepiej uczyć się rozwiązując konkretne problemy. Artykuł ten stawia przed Tobą właśnie taki problem. Dzisiejszym zadaniem będzie „Gra w życie” :). W każdym momencie możesz też spojrzeć do przykładowego rozwiązania, które dla Ciebie przygotowałem.
disqus_page_identifier: 523 http://www.samouczekprogramisty.pl/?p=523
---

## Convey’s Game of Life

Gra w życie zakłada, że mamy planszę o nieskończonych wymiarach. Plansza ta podzielona jest na pola, w podobny sposób jak kartka w kratkę. Każda kratka reprezentuje pole. Każde pole ma dokładnie 8 sąsiadów, osiem kratek wokół.

Każde z pól może być w dwóch stanach. Może być żywe bądź martwe.

{% include figure image_path="/assets/images/2016/11/06_zywa13.gif" caption="Żywa komórka (1, 3)" %}

W przykładzie powyżej widzisz wycinek planszy na którym mamy żywą komórkę o współrzędnych (1, 3). Oznaczona jest ona czarnym kwadratem.

Gra sprowadza się do przygotowania kolejnych generacji planszy na podstawie jej aktualnego stanu. Kolejna generacja powstaje na podstawie czterech zasad:

- Każda żywa komórka z mniej niż dwoma żywymi sąsiadami umiera w kolejnej generacji z powodu wyludnienia,
- każda żywa komórka z dwoma lub trzema żywymi sąsiadami jest w stanie przetrwać do następnej generacji,
- każda żywa komórka z więcej niż trzema żywymi sąsiadami umiera w kolejnej genracji z powodu przeludnienia,
- każda martwa komórka z dokładnie trzema żywymi sąsiadami staje się żywa w kolejnej generacji.

Zobacz jak te zasady wyglądają na kilku przykładach.

{% include newsletter-srodek.md %}

### Przykład 1.

W tym przykładzie pierwsza generacja planszy zawiera wyłącznie żywą komórkę na pozycji (1, 3). W kolejnej generacji komórka ta ginie ponieważ nie ma dwóch żywych sąsiadów.

{% include figure image_path="/assets/images/2016/11/06_zywa13.gif" caption="Żywa komórka (1, 3)" %}

{% include figure image_path="/assets/images/2016/11/06_pusta.gif" caption="Pusta plansza" %}

### Przykład 2.

W tym przykładzie, w pierwszej generacji mamy trzy żywe komórki na pozycjach (1, 2), (2, 2) i (3, 2). W kolejnej generacji dzieje się już trochę więcej:
- Komórka (1, 2) i (3, 2) giną ponieważ mają tylko jednego żywego sąsiada,
- komórka (2, 2) przeżywa ponieważ ma dokładnie dwóch żywych sąsiadów,
- komórki (2, 1) i (2, 3) ożywają ponieważ mają trzech żywych sąsiadów,
- pozostałe komórki pozostają martwe.

{% include figure image_path="/assets/images/2016/11/06_plansza_okres2_poziom.gif" caption="Figura okresowa" %}

{% include figure image_path="/assets/images/2016/11/06_plansza_okres2_pion.gif" caption="Figura okresowa" %}

Zauważ, że kolejna generacja prowadzi do kształtu podobnego do poprzedniej. W przypadku tego kształtu i kolejnych generacji okazuje się, że zawsze jakieś żywe komórki powstaną na planszy. Kolejne generacje można pokazać przy pomocy animacji:

{% include figure image_path="/assets/images/2016/11/06_plansza_okres2_animacja.gif" caption="Figura okresowa" %}

### Kolejne przykłady

Bardziej skomplikowane kształty możesz zobaczyć na filmiku poniżej:

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/C2vgICfQawE?controls=1&showinfo=1&t=1m11s" frameborder="0" allowfullscreen></iframe>

## Zadanie do wykonania

Twoim zadaniem jest napisanie gry w życie.

Aby trochę ułatwić wizualizację, nie będziemy implementowali nieskończonej planszy. Zodyfikujemy wymagania dotyczące planszy. W naszym przypadku planszę ograniczymy do kwadratu o boku N, gdzie N będzie parametrem konstruktora planszy. Nie będzie ona nieskończona, a będzie się „zawijała”. Co to oznacza?

Na poniższym obrazku zaznaczyłem sąsiedztwo dla pola (1, 0). Jak widzisz, „zawija się” ono w taki sposób, że obejmuje także ostatni rząd planszy.

{% include figure image_path="/assets/images/2016/11/06_plansza_sasiedztwo_10.gif" caption="Sąsiednie pola dla (1, 0) " %}

Podobnie ma się sytuacja dla narożników. Poniższy obrazek pokazuje sąsiedztwo dla narożnika (0, 0).

{% include figure image_path="/assets/images/2016/11/06_plansza_sasiedztwo_00.gif" caption="Sąsiednie pola dla (0, 0) " %}

Napisz program, który będzie w stanie wygenerować kolejną generację planszy w „grze w życie”. Nie zapominaj o testach jednostkowych dla swojego programu.

Dla przykładu poniżej umieściłem jeden z testów z przykładowego rozwiązania.

```java
@Test
public void shouldBeAbleToProvideNextGenerationWithPeriod() {
    String boardVisualisation = "+----+" + System.lineSeparator() +
                                "|    |" + System.lineSeparator() +
                                "| o  |" + System.lineSeparator() +
                                "| o  |" + System.lineSeparator() +
                                "| o  |" + System.lineSeparator() +
                                "+----+";
    Board board = new Board(4, Cell.live(1, 0), Cell.live(1, 1), Cell.live(1, 2));
    assertEquals(boardVisualisation, board.toString());
 
    String expected = "+----+" + System.lineSeparator() +
                      "|    |" + System.lineSeparator() +
                      "|    |" + System.lineSeparator() +
                      "|ooo |" + System.lineSeparator() +
                      "|    |" + System.lineSeparator() +
                      "+----+";
    Board boardNextGeneration = board.nextGeneration();
    assertEquals(expected, boardNextGeneration.toString());
}
```

Przygotowałem też dla Ciebie [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/03_game_of_life) wraz z testami jednostkowymi. Możesz zajrzeć na samouczkowego githuba.

## Materiały dodatkowe

- [Artykuł na wikipedii na temat gry w życie](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life),
- [wywiad z autorem Game of Life](https://www.youtube.com/watch?v=R9Plq-D1gEk) – John H. Convey opowiada o Grze w Życie :)

## Podsumowanie

Mam nadzieję, że udało Ci się napisać grę w życie. Nie jest to duży projekt jednak rozbudowany na tyle, że musisz przećwiczyć podstawowe zagadnienia programowania obiektowego. Niby prosty zestaw zasad, a jaki ciekawy efekt można uzyskać :). Jeśli chciałbyś dostawać informacje o kolejnych artykułach prosto na Twoją skrzynkę zapisz się na mojego newslettera.

Na koniec proszę Cię, żebyś podzielił się informacją o Samouczku ze swoimi znajomymi, którzy też są zainteresowani programowaniem – zależy mi na dotarciu do jak największej liczby czytelników.
