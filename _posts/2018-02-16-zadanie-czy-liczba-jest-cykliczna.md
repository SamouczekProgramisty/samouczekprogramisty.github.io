---
title: Samouczek na rozmowie - czy liczba jest cykliczna
date: 2018-08-22 21:47:58 +0200
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /samouczek-na-rozmowie-czy-liczba-jest-cykliczna/
header:
    teaser: /assets/images/2018/02/16_rozmowa_kwalifikacyjna_liczba_cykliczna_zadanie_artykul.jpg
    overlay_image: /assets/images/2018/02/16_rozmowa_kwalifikacyjna_liczba_cykliczna_zadanie_artykul.jpg
    caption: "[&copy; soundman1024](https://www.flickr.com/photos/soundman1024/6805264986/sizes/l)"
excerpt: W artykule tym rozkładam na części pierwsze zadanie, podesłane przez jednego z czytelników. Po lekturze tego artykułu będziesz wiedział czym są liczby cykliczne i w jaki sposób sprawdzić czy dana liczba jest cykliczna. Zapraszam do lektury.
---

{% include samouczek-na-rozmowie.md %}

## Czym jest liczba cykliczna

Zanim przejdę do treści zadania musisz wiedzieć czym jest [liczba cykliczna](https://en.wikipedia.org/wiki/Cyclic_number). Liczba cykliczna to liczba całkowita, której cykliczne permutacje cyfr są możliwe do uzyskania przez mnożenie liczby przez kolejne liczby naturalne. Przykładową liczbą cykliczną jest 142857. Wyniki mnożenia tej liczby przez pierwsze 6 liczb naturalnych dają jej permutacje cykliczne:

    142857 * 1 = 142857
    142857 * 2 = 285714
    142857 * 3 = 428571
    142857 * 4 = 571428
    142857 * 5 = 714285
    142857 * 6 = 857142

{% capture permutacja %}
Permutacja cykliczna może brzmieć jak coś skomplikowanego. W praktyce powstaje ona przez wstawianie pierwszego elementu danego łańcucha na koniec. Na przykład permutacjami cyklicznymi łańcucha znaków `abcd` są:

 - `abcd`
 - `bcda`
 - `cdab`
 - `dabc`
{% endcapture %}

<div class="notice--info">
    {{ permutacja | markdownify }}
</div>

## Zadanie do wykonania

Napisz funkcję `isCyclic`, która jako argument dostaje dowolnie dużą dodatnią liczbę całkowitą w postaci łańcucha znaków. Liczba może być poprzedzona zerami, więc `"0123"` jest poprawnym wejściem programu. Zadaniem jest napisanie funkcji `isCyclic`, która sprawdzi czy dana liczba jest liczbą cykliczną.

    isCyclic("142857") == true
    isCyclic("012233") == false

W przykładzie pierwsza liczba jest liczbą cykliczną. Druga linijka pokazuje przykład, dla którego `isCyclic` powinna zwrócić wartość `false`.

## Od czego zależy złożoność

W przypadku tego zadania danymi wejściowymi jest łańcuch znaków. W zadaniach tego typu długość takiego łańcucha używana jest do szacowania złożoności obliczeniowej i pamięciowej. Zatem `n` użyte poniżej odnosi się właśnie do długości wejściowego łańcucha znaków.

### Najprostsze rozwiązanie problemu

Zacznę od najprostszego rozwiązania problemu. Parametrem funkcji jest łańcuch znaków reprezentujący liczbę. Żeby zobaczyć czy ta liczba jest cykliczna wygeneruję wszystkie jej permutacje cykliczne i będę sprawdzał czy mnożąc liczbę przez kolejne wartości od 1 do N wynik będzie znajdował się we wcześniej przygotowanych permutacjach. Proszę spójrz na przykładowe rozwiązanie:

```java
public boolean isCyclicNaive(String number) {
    String[] permutations = new String[number.length()];

    for (int index = 0; index < permutations.length; index++) {
        permutations[index] = number.substring(index) + number.substring(0, index);
    }

    BigInteger value = new BigInteger(number);
    String formatString = "%0" + number.length() + "d";

    outerLoop: for (int multiplicator = 2; multiplicator <= number.length(); multiplicator++) {
        BigInteger multiplication = value.multiply(BigInteger.valueOf(multiplicator));
        String formattedResult = String.format(formatString, multiplication);
        for (String permutation : permutations) {
            if (formattedResult.equals(permutation)) {
                continue outerLoop;
            }
        }
        return false;
    }

    return true;
}
```

Pierwsza pętla odpowiedzialna jest za tworzenie permutacji cyklicznych. Wewnątrz drugiej pętli sprawdzam czy mnożąc liczbę przez kolejne wartości od 2 do N uzyskam jedną z wcześniej przygotowanych permutacji. Posługuję się tutaj typem `BigInteger` aby móc pracować na liczbach większych niż te, które mogę przechowywać w zmiennej typu `long`.

#### Złożoność obliczeniowa

Pierwsza pętla ma złożoność `Ο(n^2)`. Dzieje się tak ponieważ metoda `substring` ma złożoność `Ο(n)`. Kolejna pętla jest zagnieżdżona i ma złożoność `Ο(n^3)`. Tym razem złożoność "psuje" operacja `multiply`, która ma złożoność obliczeniową `Ο(n^2)`. Więc finalnie złożoność obliczeniowa tego algorytmu to `O(n^3)`.

#### Złożoność pamięciowa

W przypadku tego algorytmu przechowuję listę permutacji w tablicy. Tablica zawiera `N` permutacji. Każda permutacja ma długość `N`. Zatem finalna złożoność pamięciowa to `Ο(n^2)`.

### Rozwiązanie bazujące na właściwościach liczb cyklicznych

Czytając o [liczbach cyklicznych](https://en.wikipedia.org/wiki/Cyclic_number) dowiedziałem się kilku istotnych rzeczy:

 - liczby cykliczne tworzone są na podstawie liczb pierwszych,
 - długość liczby cyklicznej jest o jeden większa niż liczba pierwsza użyta do generowania liczby cyklicznej,
 - liczba cykliczna jest cyklicznym rozwinięciem ułamka `1/liczba pierwsza do generacji`.

Mając takie informacje podszedłem do problemu od drugiej strony. Zamiast sprawdzić czy dana liczba jest cykliczna wygenerowałem liczbę, która powstałaby na podstawie dzielenia `1/liczba pierwsza do generacji`. Następnie porównuję tak uzyskaną liczbę z tą przekazaną jako argument metody. Jeśli są sobie równe wówczas przekazana liczba jest liczbą cykliczną. Proszę spójrz na implementację:

```java
public boolean isCyclicGeneration(String number) {
    int base = 10;
    int generatingPrime = number.length() + 1;

    StringBuilder representation = new StringBuilder();

    int step = 0;
    int reminder = 1;
    do {
        step++;
        int currentValueToDivide = reminder * base;
        int currentDigit = currentValueToDivide / generatingPrime;
        reminder = currentValueToDivide % generatingPrime;
        representation.append(currentDigit);
    } while (reminder != 1 && step < generatingPrime);

    return number.equals(representation.toString());
}
```

Na początku ustawiam niezbędne zmienne. Następnie wewnątrz pętli obliczam kolejne wartości ułamka. Tak uzyskane liczby dodaję do bufora `representation`, który następnie porównuję z przekazaną liczbą. 

Warunek `reminder != 1` wykrywa wystąpienie okresu w rozwinięciu dziesiętnym ułamka. Więcej na temat "okresu ułamka" przeczytasz w artykule opisującym [liczby zmiennoprzecinkowe]({% post_url 2017-11-06-liczby-zmiennoprzecinkowe %}).

Warunek `step < generatingPrime` jest potrzebny, aby uniknąć nieskończonej pętli. Taki przypadek mógłby mieć miejsce jeśli metoda jako parametr otrzymałaby liczbę, która nie jest cykliczna.

#### Złożoność obliczeniowa

W przypadku tego rozwiązania występuje wyłącznie jedna pętla. Zatem złożoność obliczeniowa tego algorytmu to `Ο(n)`.

#### Złożoność pamięciowa

Algorytm do działania potrzebuje kilku zmiennych. Jedna z nich, `representation`, urośnie do długości `N`. Zatem w tym przypadku złożoność pamięciowa tego algorytmu to `O(n)`.

### Bardziej wydajne rozwiązanie problemu

Masz jakiś pomysł? Z chęcią poznam Twoje podejście do rozwiązania tego problemu. Wrzuć swój kod na githuba i podziel się rozwiązaniem. Pamiętaj, żeby przetestować poprawność swojego rozwiązania. Możesz to zrobić przy pomocy testów jednostkowych, które [przygotowałem](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/blob/master/08_cyclic_number/src/test/java/pl/samouczekprogramisty/szs/cyclic/CyclicNumberFinderTest.java).

## Wyślij mi swoje zadanie

Zadanie omówione w tym artykule zostało przesłane przez jednego z czytelników. Jeśli chcesz abym spróbował omówić zadanie, na które Ty trafiłeś daj znać. Zastrzegam jednak, że nie jestem alfą i omegą. Potrafię sobie wyobrazić problemy, na które nie znajdę najlepszego rozwiązania. Niemniej jednak postaram się rozwiązać to zadanie w najlepszy znany mi sposób. Zadania możesz wysłać na mój adres e-mail _marcin [małpka] samouczekprogramisty.pl_.

{% include zadanie-z-rozmowy-notice.md %}

## Podsumowanie

Po przeczytaniu artykułu znasz dwa sposoby rozwiązania zadanego problemu. Znasz złożoność pamięciową i obliczeniową każdego z rozwiązań. Jesteś o jedno zadanie lepiej przygotowany do rozmowy kwalifikacyjnej ;).

Przykładowe rozwiązania, przedstawione w artykule znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/08_cyclic_number/src). Kod zawiera także [testy jednostkowe]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}), których użyłem do weryfikacji poprawności działania algorytmów.

Jeśli nie chcesz pominąć kolejnych artykułów z tej serii dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Jak zwykle, jeśli masz jakiekolwiek pytania proszę zadaj je w komentarzach. Postaram się pomóc ;). Do następnego razu!
