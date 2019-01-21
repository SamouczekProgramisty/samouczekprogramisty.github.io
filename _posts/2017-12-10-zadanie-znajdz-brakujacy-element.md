---
title: Samouczek na rozmowie - znajdź brakujący element
date: 2018-08-22 21:47:58 +0200
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /samouczek-na-rozmowie-znajdz-brakujacy-element/
header:
    teaser: /assets/images/2017/12/10_rozmowa_kwalifikacyjna_brakujacy_element_zadanie_artykul.jpg
    overlay_image: /assets/images/2017/12/10_rozmowa_kwalifikacyjna_brakujacy_element_zadanie_artykul.jpg
    caption: "[&copy; villamon](https://www.flickr.com/photos/villamon/5036944280/sizes/l)"
excerpt: W artykule tym rozkładam na części pierwsze zadanie, które sam miałem na rozmowie kwalifikacyjnej. Przeprowadzę Cię przez różne sposoby rozwiązania tego zadania. Zaczynając od tych najprostszych do tych, które są najbardziej wydajne. Zapraszam do lektury.
---

<script type="text/javascript"
    src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

{% include samouczek-na-rozmowie.md %}

## Kilka wskazówek dotyczących rozwiązywania zadań

Akurat to zadanie miałem sam na rozmowie kwalifikacyjnej. Rozmowa przeprowadzana na stanowisko starszego programisty. Sam problem nie jest dość trudny. Zauważyłem, że jest to częsta praktyka. Problemy do rozwiązania na rozmowach kwalifikacyjnych przeważnie służą tylko do tego, żeby zweryfikować czy kandydat zna składnię danego języka. Dodatkowo zadania tego typu sprawdzają umiejętność analizowania problemu i szukania rozwiązania.

Na rozmowie rozwiązałem ten problem algorytmem o najlepszej złożoności czasowej, jednak nie był on optymalny pod kątem użycia pamięci. Mimo tego, że moje rozwiązanie nie było idealne dostałem ofertę pracy. Tutaj chcę Ci pokazać, że nawet jeśli nie rozwiążesz problemu w idealny sposób a będziesz sensownie kombinował, uda się.

Zacznij od najprostszego rozwiązania. Zacznij od czegokolwiek i później głośno zastanawiaj się nad minusami Twojego rozwiązania. Prowadzący rozmowę widząc Twoje zaangażowanie często pomogą i nakierują Cię na lepsze rozwiązanie problemu.

## Zadanie do wykonania

Napisz funkcję `findMissing`, która jako argument przyjmuje tablicę N liczb całkowitych z zakresu od 0 do N. W tablicy wszystkie elementy są unikalne. Liczb z zakresu `<0, N>`, jest `N + 1`. Tablica ma długość N. W tablicy brakuje jednego elementu z zakresu. Funkcja `findMissing` powinna zwrócić brakujący element:

    tablica = [0, 2, 1, 4]
    findMissing(tablica) == 3

W przykładzie wejściem jest tablica, która ma 4 elementy. Brakuje w niej liczby 3, i właśnie taką liczbę zwraca funkcja `findMissing`.

### Najprostsze rozwiązanie problemu

Zacznę od najprostszego rozwiązania problemu. Na wejściu mamy [tablicę]({% post_url 2015-11-11-tablice-w-jezyku-java %})[^varargs], w której brakuje jednego elementu z zakresu `<0, N>`. Żeby znaleźć brakujący element można sprawdzić czy każdy z elementów występuje w tablicy. Pierwsza iteracja sprawdzi czy w tablicy występuje `0`, kolejna `1` i tak dalej aż dojdziemy do `N`. Proszę spójrz na przykładowe rozwiązanie:

```java
private static int naiveFindMissing(int... array) {
    int missing = 0;
    boolean elementFound;
    for (int elementToFind = 0; elementToFind <= array.length; elementToFind++) {
        elementFound = false;
        for (int elementInArray : array) {
            if (elementToFind == elementInArray) {
                elementFound = true;
                break;
            }
        }
        if (!elementFound) {
            missing = elementToFind;
            break;
        }
    }
    return  missing;
}
```

[^varargs]: Właściwie jest to argument, który akceptuje zmienną liczbę argumentów. Taka sygnatura metody pozwala także na przekazanie tablicy.

#### Złożoność obliczeniowa

Ten algorytm działa i znajduje brakujący element. Aby znaleźć brakujący element algorytm używa zagnieżdżonych pętli. Ilość iteracji w każdej z nich zależna jest od liczby elementów. Złożoność obliczeniowa tego algorytmu to `Ο(n^2)`

#### Złożoność pamięciowa

Algorytm ten używa stałej liczby zmiennych, jest ona niezależna od wielkości danych wejściowych. W związku z tym złożoność pamięciowa tego algorytmu jest stała, wynosi ona `Ο(1)`.

### Pamięciożerne rozwiązanie

Teraz spróbuję ugryźć problem z innej strony. Z opisu problemu wiem, że brakuje jednej liczby z zakresu `<0, N>`. Pomysł jest taki, aby stworzyć tablicę wartości logicznych (flag), które będą wskazywały czy dany element znajduje się w tablicy. Iterując po elementach tablicy wejściowej można oznaczać każdą z flag. Następnie iterując po tablicy z flagami można znaleźć tę, która ma wartość `false`. To ona będzie wskazywała brakujący element:

```java
private static int memoryGreedyFindMissing(int... array) {
    boolean[] foundElements = new boolean[array.length + 1];

    for (int element : array) {
        foundElements[element] = true;
    }

    for (int index = 0; index < foundElements.length; index++) {
        if (!foundElements[index]) {
            return index;
        }
    }
    throw new IllegalStateException("At least one flag should be equal false!");
}
```

#### Złożoność obliczeniowa

Algorytm wymaga przejścia przez wszystkie elementy tablicy wejściowej. Dodatkowo iterujemy po tablicy flag. Rozmiar tej tablicy jest także zależy od wielkości danych wejściowych. Uzyskujemy zatem lepszą złożoność obliczeniową niż w poprzednim przypadku `Ο(2n) = Ο(n)`.

#### Złożoność pamięciowa

Aby algorytm działał konieczna jest inicjalizacja tablicy z flagami. Jej rozmiar zależny jest od wielkości danych wejściowych. W związku z tym algorytm ten ma złożoność pamięciową `Ο(n)`. Zatem kosztem pamięci udało mi się poprawić wydajność algorytmu. W większości przypadków taka zmiana jest akceptowalna, jednak problem ten można rozwiązać jeszcze wydajniej.

### Optymalne rozwiązanie

Z opisu zadania wiesz, że szukamy brakującej liczby z zakresu `<0, N>`. Liczby 0, 1, 2, ..., N to [ciąg arytmetyczny](https://pl.wikipedia.org/wiki/Ci%C4%85g_arytmetyczny). Istnieje wzór, który pozwala na obliczenie sumy elementów ciągu arytmetycznego:

$$S_n = rac{n(2a_1 + (n - 1)r)}{2}$$

Załóżmy, że tablica wejściowa ma 100. Wiemy zatem, że szukamy liczby z zakresu 0 do 100. Liczb w tym zakresie jest 101, pierwszy element ma wartość 0 a różnica pomiędzy elementami wynosi 1. Podstawiając te wartości pod wzór otrzymujemy sumę elementów:

$$S_n = rac{101 * (2 * 0 + (101 - 1) * 1)}{2} = rac{101 * 100}{2} = 5050$$

Skoro znamy oczekiwaną sumę możemy zsumować zawartość przekazanej tablicy i odjąć tę wartość od oczekiwanej sumy. Wynik odejmowania to brakujący element:


```java
private static int optimalFindMissing(int... array) {
    int expectedSum = (array.length + 1) * array.length / 2;
    int actualSum = 0;

    for (int element : array) {
        actualSum += element;
    }

    return expectedSum - actualSum;
}
```

#### Złożoność obliczeniowa

W tym przypadku w rozwiązaniu jest wyłącznie jedna pętla o złożoności `Ο(n)`. Obliczenie sumy elementów ma złożoność `Ο(1)`. Więc finalnie złożoność obliczeniowa tego algorytmu to `Ο(n)`.

#### Złożoność pamięciowa

Algorytm ten wymaga stałej liczby zmiennych. Liczba ta nie jest zależna od wielkości danych wejściowych. Zatem złożoność pamięciowa tego algorytmu to `Ο(1)`.

## Wyślij mi swoje zadanie

Jeśli chcesz abym spróbował omówić zadanie, na które Ty trafiłeś daj znać. Zastrzegam jednak, że nie jestem alfą i omegą. Potrafię sobie wyobrazić problemy, na które nie znajdę najlepszego rozwiązania. Niemniej jednak postaram się rozwiązać to zadanie w najlepszy znany mi sposób. Zadania możesz wysłać na mój adres e-mail _marcin [małpka] samouczekprogramisty.pl_.

{% include zadanie-z-rozmowy-notice.md %}

## Podsumowanie

Po przeczytaniu artykułu znasz trzy sposoby rozwiązania zadanego problemu. Znasz złożoność pamięciową i obliczeniową każdego z rozwiązań. Jesteś o jedno zadanie lepiej przygotowany do rozmowy kwalifikacyjnej ;).

Przykładowe rozwiązania, przedstawione w artykule znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/07_missing_element/src). Kod zawiera także [testy jednostkowe]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}), których użyłem do weryfikacji poprawności działania algorytmów.

Jeśli nie chcesz pominąć kolejnych artykułów z tej serii dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Jak zwykle, jeśli masz jakiekolwiek pytania proszę zadaj je w komentarzach. Postaram się pomóc ;). Do następnego razu!
