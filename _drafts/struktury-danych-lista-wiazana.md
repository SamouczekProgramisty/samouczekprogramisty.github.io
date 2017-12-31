---
title: Struktury danych - lista wiązana
categories:
- Kurs aplikacji webowych
permalink: /struktury-danych-lista-wiazana/
header:
    teaser: /assets/images/2017/12/17_struktury_danych_lista_wiazana_artykul.jpg
    overlay_image: /assets/images/2017/12/17_struktury_danych_lista_wiazana_artykul.jpg
    caption: "[&copy; mangpages](https://www.flickr.com/photos/mangpages/1519626646/sizes/l)"
excerpt: W artykule tym przeczytasz o liście wiązanej (ang. _linked list_). Pokażę Ci przykładową implementację takiej listy. Dowiesz się jaka jest złożoność obliczeniowa poszczególnych operacji. Poznasz różnicę pomiędzy listą jednokierunkową a listą dwukierunkową. W utrwaleniu wiedzy na temat list pomogą Ci zadania umieszczone na końcu artykułu.
---

## Struktury danych

Lista wiązana to struktura danych. Struktury danych opisują sposób przechowywania danych w pamięci komputera. Przykładową strukturą danych jest [tablica]({% post_url 2015-11-11-tablice-w-jezyku-java %}). Każda struktura danych ma charakterystyczne dla siebie właściwości. Na przykład dodanie elementu do na początek tablicy ma [złożoność obliczeniową]({% post_url 2017-11-13-podstawy-zlozonosci-obliczeniowej %}) `Ο(n)`. Ta sama operacja dla listy wiązanej ma złożoność `Ο(1)`[^implementacja].

[^implementacja]: Oczywiście zależy to od implementacji listy. W przypadku listy wiązanej otrzymanie takiej złożoności nie jest problemem.

Te właściwości sprawiają, że użycie konkretnej struktury może uprościć rozwiązanie niektórych problemów. Możemy powiedzieć, że czasami lepiej jest użyć tablicy a w innym przypadku lista wiązana jest lepszym rozwiązaniem. Wszystko zależy od problemu, który próbujemy rozwiązać.

Klasyczną pozycją jeśli chodzi o powiązanie algorytmów i struktur danych jest książka autorstwa Niklausa Wirtha [Algorytmy + struktury danych = programy](http://lubimyczytac.pl/ksiazka/122213/algorytmy-struktury-danych-programy). 
{: .notice--info}

### Struktury danych w językach programowania

Struktura danych jest niezależna od języka programowania. Można ją zaimplementować w różnych językach. Na przykład tablica jest uniwersalną strukturą, która istnieje w każdym znanym mi języku programowani. 

Podonie sytuacja wygląda z listą wiązaną. Przeważnie w standardowej bibliotece danego języka znajdzie się już gotowa implementacja tej struktry danych. W języku Java implementacją dwukierunkowej listy wiązanej jest klasa [`LinkedList`](https://docs.oracle.com/javase/9/docs/api/java/util/LinkedList.html). O tym czym jest dwukierunkowa lista wiązana przeczytasz w jednym z akapitów poniżej.

Skoro zatem mamy gotowe implementacje to po co pisać kolejną? Jedynym powodem jest nauka i zrozumienie zasady działania danej struktury danych. Jeśli dany język dostarcza implementacji danej struktury najlepszym sposobem będzie jej użycie. Nie wymyślaj koła na nowo :).

Struktury danych dostępne w standardowej bibltiotece będą na pewno lepiej zaimplementowane niż własna wersja. Dodatkowo będę przetestowane przez dużo większą liczbę programistów.

## Jak działa lista wiązana

Lista wiązana to struktura, która składa się z węzłów. Każdy z węzłów zawiera element, który przechowuje. Dodatkowo posiada także odnośniki do innych elementów. W ten sposób powstaje łańcuch powiązanych ze sobą węzłów. To ile odnośników przechowuje węzeł określa czy lista jest jedno, czy dwukierunkowa.

Lista jednokierunkowa posiada wyłącznie odnośnik do jednego elementu. Lista dwukierunkowa posiada dwa odnośniki, do obu sąsiadujących elementów.

Lista wiązana jest strukturą, w której kolejność elementów ma znaczenie.

### Lista jednokierunkowa

W zależności od 

### Czym różni się lista wiązana od tablicy


## Czy można odwrócić listę wiązaną?

## Dwukierunkowa lista wiązana

Implementacja listy 

Sposób przechowywania listy wiązanej w pamięci

## Kiedy używać listy wiązanej

## Podstawowe operacje 

### Dodawanie elementów

### Usuwanie elementów

## Dodatkowe materiały do nauki

Jeśli chcesz spojrzeć na temat z innego punktu widzenia zachęcam Cię do przeczytania materiałów, które zebrałem poniżej. Lista jest dość popularną strukturą danych więc jest też sporo materiałów w internecie na jej temat.


## Zadania

Skoro już wiesz jak działa lista wiązana nadszedł czas na Twoją implementację. Przygotowałem dla Ciebie dwa zadania do wykonania:

- Zmodyfikuj klasę `SingleLinkedList` w taki sposób aby dodawanie elementów na koniec listy miało złożoność `Ο(1)`.
- Zmodyfikuj klasy `SingleLinkedList` i `DoubleLinkedList` w taki sposób aby pobieranie rozmiaru listy miało złożoność `Ο(1)`.

## Podsumowanie



