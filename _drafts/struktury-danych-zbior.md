---
title: Struktury danych – zbiór
last_modified_at: 2019-05-03 09:03:42 +0100
categories:
- Programista rzemieślnik
permalink: /struktury-danych-zbior/
header:
    teaser: /assets/images/2019/05/07_struktury_danych_zbior_artykul.jpg overlay_image: /assets/images/2019/05/07_struktury_danych_zbior_artykul.jpg
    caption: "[&copy; rawpixel.com](https://www.pexels.com/photo/assorted-plastic-toy-lot-1249159/)"
excerpt: W artykule tym przeczytasz o zbiorze. Dowiesz się jak działa ta struktura. Pokażę Ci przykładową implementację zbioru. Dowiesz się jaka jest złożoność obliczeniowa poszczególnych operacji. Zadania do rozwiązania pomogą Ci utrwalić zdobytą wiedzę.
---

{% capture wprowadzenie %}
Artykuł ten opisuje przykładową implementację zbioru. Zbiór jest abstrakcyjnym typem danych, który występuje w wielu językach programowania. Zasada pracy ze zbiorami są niezależnie od języka programowania.

Przykładową implementację przygotowałem w Javie. Żeby wynieść jak najwięcej z tego artykułu potrzebna jest wiedza na temat `hashCode` i `equals`. Niezbędna jest też znajomość [kontraktu pomiędzy metodami `equals` i `hashCode`]({% post_url 2016-04-17-porownywanie-obiektow-metody-equals-i-hashcode-w-jezyku-java %}).

Do zrozumienia przykładowej implementacji niezbędna będzie też wiedza o [typach generycznych]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}).

Może przydać się też wiedza na temat [szacowania złożoności obliczeniowej]({% post_url 2017-11-13-podstawy-zlozonosci-obliczeniowej %}).
{% endcapture %}

<div class="notice--info">
  {{ wprowadzenie | markdownify }}
</div>

## Struktura danych a abstrakcyjny typ danych

W poprzednich artykułach z serii opisujących [listę wiązaną]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}) czy [tablicę asocjacyjną]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}) pominąłem kwestie definicji. Używałem określenia struktura danych i abstrakcyjny typ danych zamiennie. Tym razem chciałbym zwrócić Twoją uwagę na drobną różnicę pomiędzy tymi określeniami.

Abstrakcyjny typ danych definiuje zachowanie danego typu. Określa zestaw operacji, które można na tym typie wykonać. Opis abastrakcyjnego typu danych zawiera także cechy charakterystyczne dla danego typu.

Na przykład zbiór jest abstrakcyjnym typem danych (niżej opiszę jego własności), a `TreeSet` czy `HashSet` są implementacjami tego abstrakcyjnego typu danych. Te implementacje używają róznych struktur danych. Innym przykładem może być absktrakcyjny typ danych [tablica asocjacyjna]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}), której implementacja może używać tablicy i listy wiązanej.

## Czym jest zbiór

Zbiór jest abstrakcyjnym typem danych, który ma następujące własności:

* pozwala na przechowywanie wielu elementów,
* kolejność elementów w zbiorze nie ma znaczenia[^wyjatek], 
* pozwala na przechowywanie co najwyżej jednej kopii elementu (duplikaty nie są dozwolone).

[^wyjatek]: Nietkóre implementacje porządkują elementy zbioru.

Podstawowymi operacjami, które można przeprowadzić na zbiorze jest dodanie elementu, usunięcie elementu i sprawdzenie czy dany element jest częścią zbioru.

Zbiór jest także jednym z podstawowych pojęć matematycznych.

## Algebra zbiorów

Tematem tego artykułu nie jest zbiór w kontekście matematycznym. Chciałbym jednak zwrócić Twoją uwagę na podstawowe operacje, które można przeprowadzać na zbiorach. Ta podstawowa wiedza może także przydać się w kontekście programowania.

Poza operacjami przyda się też wiedza o tak zwanym zbiorze pustym. Zbiór pusty jak sama nazwa wskazuje jest pusty, nie ma żadnego elementu.

### Iloczyn 

Nazywany także przecięciem dwóch zbiorów. Przecięcie to nic innego jak część wspólna dwóch zbiorów. Przecięcie dwóch zbiorów może prowadzić do uzyskania:
* mniejszego podzbioru, który jest częścią wspólną obu zbiorów,
* zbioru równemu obu zbiorom, jeśli oba zbiory zawierają dokładnie takie same elementy,
* pustego zbioru, jeśli oba zbiory nie mają wspólnych elementów.

Iloczyn dowolnego zbioru ze zbiorem pustym zawsze jest zbiorem pustym.

### Suma 

Suma dwóch zbiorów to zbiór, który zawiera wszystkie elementy z obu sumowanych zbiorów.

### Różnica 

Różnica zbioru A i zbioru B to zbiór zawierający wszystkie elementy, które są w zbiorze A i nie ma ich w zbiorze B.

## Jak działa zbiór?

W ramach tego artykułu skupię się na przykładowej implementacji, która oparta jest o funkcję skrótu (`hashCode`). Przedstawiona tu implementacja będzie uproszczoną wersją klasy `HashSet`, znajdującej się w bibliotece standardowej.

### `hashCode` i `equals`

Pdobnie jak w przypadku tablicy asocjacyjnej opartej o funkcję skrótu tak i tutaj `hashCode` i `equals` pełnią kluczową rolę.

Także tutaj na podstawie wartości funkcji skrótu obliczone zostanie „wiaderko” do którego wpadnie dany element. Następnie elementy wewnątrz tego samego wiaderka porównywane będą przy pomocy metody `equals`.

Podobnie jak w przypadu tablicy asocjacyjnej kluczowe jest zachowanie [kontraktu]({% post_url 2016-04-17-porownywanie-obiektow-metody-equals-i-hashcode-w-jezyku-java %}) pomiędzy tymi metodami.

Jak wspomniałem wyżej zbiór oferuje kilka podstawowych operacji. Na potrzeby tego artykułu ograniczę je do takiego interfejsu:

```java
public interface SimpleSet<E> {
    void add(E item);
    K remove(E item);
    boolean contains(E item);
}
```

### Podobieństwa pomiędzy `HashSet` i `HashMap`

Zacznę od tego czym jest tablica asocjacyjna. Ta struktura pozwala na przechowywanie kluczy i odpowiadających im wartości. Implementacja `HashMap` zakłada, że tablica asocjacyjna zawiera unikalny zestaw kluczy. Innymi słowy nie może w niej być dwóch takich samych kluczy. Tablica asocjacyjna także może nie zwracać uwagi na porządek kluczy[^treemap].

[^treemap]: Także i tutaj są wyjątki, niektóre implementacje pozwalają na porządkowanie kluczy.

Widzisz tu pewne podobieństwo pomiędzy zbiorem a tak zdefiniowaną tablicą asocjacyjną? Zbiór także nie zawiera duplikatów. Zbiór nie zwraca uwagi na porządek kluczy.

Powiem więcej, bardzo często implementacje zbioru opartego o funkcję skrótu pod spodem używają tablicy asocjacyjnej.


## Najczęściej zadawane pytania

### Czy zbiór jest serializowalny/wielowątkowo bezpieczny/posortowany

Jak wspomniałem na początku artykułu zbiór tak na prawdę nie jest strukturą danych. Zbiór to 



### Czym zbiór różni się od listy




### Czym zbiór różni się od tablicy asocjacyjnej

## Dodatkowe materiały do nauki

Jeśli chesz dowiedzieć się czegoś więcej o zbiorach [algebrze zbiorów](http://www.math.edu.pl/algebra-zbiorow).

## Podsumowanie

Teraz wiesz czym jest zbiór. 
