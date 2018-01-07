---
title: Struktury danych - tablica asocjacyjna
categories:
- Kurs aplikacji webowych
permalink: /struktury-danych-tablica-asocjacyjna/
header:
    teaser: /assets/images/2018/01/02_struktury_danych_lista_wiazana_artykul.jpg
    overlay_image: /assets/images/2018/01/02_struktury_danych_lista_wiazana_artykul.jpg
    caption: "[&copy; horiavarlan](https://www.flickr.com/photos/horiavarlan/4332381194/sizes/l)"
excerpt: W artykule tym przeczytasz o tablicy asocjacyjnej zwanej także słownikiem czy mapą. W artykule tym przeczytasz o tym jak działa ta struktura. Pokażę Ci przykładową implementację tablicy asocjacyjnej. Dowiesz się jaka jest złożoność obliczeniowa poszczególnych operacji. Na przykładzie zobaczysz dlaczego dobra funkcja skrótu jest bardzo istotna w przypadku tej struktury. W przystępny sposób opiszę optymalizacje wprowadzone w implementacji tej struktury w języku Java. Zadania do rozwiązania pomogą Ci utrwalić zdobytą wiedzę.
---

{% capture wprowadzenie %}
Artykuł ten opisuje strukturę danych określaną jako tablica asocjacyjna. Tę strukturę nazywa się też słownikiem czy mapą. Sama struktura występuje w wielu językach programowania. Zasada działania tej struktury jest niezależnie od języka programowania.

Przykładowa implementację przygotowałem w Javie. Aby wynieść jak najwięcej z tego artykułu powinieneś wiedzieć czym są metody `hashCode` i `equals`. Powinieneś też znać [kontrakt pomiędzy metodami `equals` i `hashCode`]({% post_url 2016-04-17-porownywanie-obiektow-metody-equals-i-hashcode-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
  {{ wprowadzenie | markdownify }}
</div>

## Czym jest tablica asocjacyjna

Tabli


## Jak działa `HashMap`

### Optymalizacja przedziałów

W Javowej implementacji 

### Sprawdzanie czy mapa jest pusta

### Sprawdzanie rozmiaru mapy

### Pobieranie wartości z mapy

### Dodawanie wartości do mapy

### Usuwanie wartości z mapy

## Porównanie złożoności obliczeniowych

Poniższa tabela zawiera zestawienie złożoności obliczeniowych podstawowych operacji dla mapy:

| Operacja                       | Mapa (dobra funkcja skrótu)  | Mapa (zła funkcja skrótu) |
|--------------------------------|:----------------------------:|:-------------------------:|
| dodawanie pary klucz/wartość   | `Ο(1)`                       | `Ο(1)`                    |
| usuwanie wartości z klucza     | `Ο(1)`                       | `Ο(n)` lub `Ο(log(n))`    |
| pobieranie wartości dla klucza | `Ο(1)`                       | `Ο(n)` lub `Ο(log(n))`    |

## Najczęściej zadawane pytania

## Dodatkowe materiały do nauki

Jeśli chcesz spojrzeć na temat z innego punktu widzenia zachęcam Cię do przeczytania materiałów, które zebrałem poniżej. Szczególnie polecam przejrzenie kodu źródłowego implementacji dostarczonej w SDK:

- [Artykuł o tablicy asocjacyjnej na Wikipedii](https://pl.wikipedia.org/wiki/Tablica_asocjacyjna),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/AlgorytmyStrukturyDanych/blob/master/02_hash_map/src/main/java/pl/samouczekprogramisty/asd/map/SimpleHashMap.java)
- [Implementacja HashMap z OpenJDK](http://hg.openjdk.java.net/jdk9/jdk9/jdk/file/tip/src/java.base/share/classes/java/util/HashMap.java)

## Zadania do wykonania

Dodaj do Klasy `SimpleHashMap` kilka metod występujących w interfejsie [`Map`](https://docs.oracle.com/javase/9/docs/api/java/util/Map.html):

1. Dodaj metodę [`containsKey`](https://docs.oracle.com/javase/9/docs/api/java/util/Map.html#containsKey-java.lang.Object-). Metoda powinna zwrócić `true` jeśli dany klucz istnieje w mapie.
2. Dodaj metodę [`containsValue`](https://docs.oracle.com/javase/9/docs/api/java/util/Map.html#containsValue-java.lang.Object-). Metoda powinna zwrócić `true` jeśli dany wartość istnieje w mapie.
3. Jaka jest złożoność obliczeniowa Twojej implementacji metod `containsKey` i `containsValue`?

Kod źródłowy klas [`SimpleHashMap`](https://github.com/SamouczekProgramisty/AlgorytmyStrukturyDanych/blob/master/02_hash_map/src/main/java/pl/samouczekprogramisty/asd/map/SimpleHashMap.java). Pemiętaj o dodaniu [testów jednostkowych]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}), potwierdzających, że Twoja implementacja działa poprawnie.

## Podsumowanie

Poznałeś właśnie zasadę działania mapy

Po przeczytaniu tego artykułu dokładnie wiesz czym są struktury danych. Poznałeś jednokierunkowe i dwukierunkowe listy wiązane. Zrozumiałeś działanie list na podstawie przykładowej implementacji. Rozwiązując zadania utrwaliłeś swoją wiedzę na temat list. Dobra robota :)!

Jeśli masz jakiekolwiek pytania czy uwagi proszę daj znać w komentarzu, postaram się pomóc. Jeśli nie chcesz pominąć kolejnych artykułów na blogu proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Proszę Cię też o podzielenie się linkiem ze znajomymi, może im także przyda się wiedza zgromadzona w tym artykule.
