---
title: Samouczek na rozmowie – łańcuchy białkowe
last_modified_at: 2018-11-18 14:00:20 +0100
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /samouczek-na-rozmowie-sekwencje-lancuchy-bialkowe/
header:
    teaser: /assets/images/2019/02/25_zadanie_z_rozmowy_kwalifikacyjnej_lancuchy_bialkowe_artykul.jpg
    overlay_image: /assets/images/2019/02/25_zadanie_z_rozmowy_kwalifikacyjnej_lancuchy_bialkowe_artykul.jpg
    caption: "[&copy; PublicDomainPictures](https://pixabay.com/illustrations/dna-biology-science-dna-helix-163710/)"
excerpt: Ten artykuł jest poświęcony zadaniu z rozmowy kwalifikacyjnej. Po lekturze tego artykułu dowiedz się jak rozwiązać zadanie, które trafił na rozmowie jeden z Czytelników – Marek. Artykuł zawiera kilka propozycji rozwiązania, które pozwolą spojrzeć Ci na problem z różnej strony.
---

{% include samouczek-na-rozmowie.md %}

W artykule tym pokazuję zadanie, które przesłał mi jeden z Czytelników – Marek. Marku, jeszcze raz bardzo dziękuję!

W artykule dotyczącym [zadania z zagnieżdżoną strukturą]({% post_url 2018-08-26-zadanie-zagniezdzona-struktura %}) dokładnie opisywałem moje podejście do rozwiązania tego typu zadań. Zachęcam Cię do przeczytania tego artykułu. Poniżej tylko krótkie przypomnienie wskazówek, które tam zebrałem:

- w przypadku niepełnego opisu zadania załóż coś. W rozwiązaniu zadania opisz swoje założenia,
- staraj się zawsze dostarczać testy automatyczne razem ze swoim rozwiązaniem, nawet jeśli nie są wymagane,
- dokumentuj swój kod tam gdzie jest to niezbędne, używanie docstring'ów może być dobrym rozwiązaniem,
- jeśli nie masz pomysłu na optymalne rozwiązanie zadania zacznij od najprostrzego podejścia.

## Treść zadania

Genetycy zajmują się nowym typem łańcuchów białkowych, które składają się z ciągu aminokwasów pewnego typu. Wyróżniono 20 rodzajów tych aminokwasów i oznaczono je dużymi literami alfabetu angielskiego – od litery A do T. Łańcuch białkowy można zatem zapisać jako słowo składające się z dużych liter od A do T, na przykład "BDDFPQPPRRAGGHPOPDKJKPEQAAER".

Mając dany łańcuch białkowy genetycy mogą zamienić w nim dwa dowolne aminokwasy miejscami, na przykład łańcuch "AABBCC" mogą zamienić na "ACBBCA", a ten z kolei na przykład na "BCBACA". 

Genetyk posiada komputerowy zapis dwóch łańcuchów białkowych i zastanawia się, czy drugi z nich mógł powstać z pierwszego poprzez wykonywanie dowolnej liczby zamian miejsc aminokwasów.  

Napisz program, który będzie posiadał funkcję:

```java
boolean changePossible(String s1, String s2)
```

Powinna ona sprawdzić, czy możliwe jest uzyskanie łańcucha białkowego `s2` z łańcucha białkowego `s1`.

Ponieważ rzeczywiste łańcuchy białkowe składają się z około 10<sup>8</sup> aminokwasów, należy zadbać o dobrą wydajność algorytmu.

Dane są zapisane w pliku tekstowym. Każdy z łańcuchów jest zapisany w osobnej linii i porównujemy łańcuch z linii nieparzystej z łańcuchem z linii
parzystej. Przykładowy plik: 

    ACBBCA
    BCBACA

Można założyć, że liczba linii będzie zawsze parzysta. Można także założyć również, że plik wejściowy jest poprawny i nie zawiera żadnych białych znaków poza znakami końca linii. Napisz  program  w popularnym języku programowania (C,  C++,  Java,  C#,  Python), który wczyta plik wejściowy z danymi, obliczy i wypisze wynik. Najlepiej będzie, jeśli program będzie czytać dane ze standardowego wejścia i wypisywać wynik na standardowe wyjście, dzięki czemu będzie go można wywołać poleceniem: 

    program.exe < dane.txt 

Jeśli nie potrafisz korzystać ze standardowego wejścia, możesz wczytać plik z danymi w inny sposób. Ważna jest wydajność zastosowanego algorytmu. W rozwiązaniu możesz korzystać z biblioteki klas dostępnych na platformie, w której będziesz programować. 

{% include newsletter-srodek.md %}

## Rozwiązanie zadania

Zadanie można podzielić na dwie części:

* algorytmiczne rozwiązanie problemu,
* spełnienie wymagań związanych z interfejsem użytkownika.

Zacznę od dokładnego omówienia pierwszej części – sposobu implementacji algorytmu.

### Algorytm – naiwne rozwiązanie zadania

Chociaż jest to naiwne rozwiązanie, nie jest trywialne w implementacji. Opiera się ono na przeglądzie zupełnym. Pomysł polega na wygenerowaniu wszystkich możliwych [permutacji](https://pl.wikipedia.org/wiki/Grupa_permutacji) jednej z sekwencji i sprawdzenia czy druga znajduje się wśród tych permutacji. W przykładowej implementacji użyłem rekurencji:

```java
boolean naiveChangePossible(String sequence1, String sequence2) {
    List<String> peramutationsCache = new LinkedList<>();
    permutations(peramutationsCache, "", sequence1);
    return peramutationsCache.contains(sequence2);
}

private void permutations(List<String> permutationsCache, String currentPermutation, String leftCharacters) {
    if (leftCharacters.length() == 0) {
        permutationsCache.add(currentPermutation);
    }
    for (int i = 0; i < leftCharacters.length(); i++) {
        permutations(
            permutationsCache,
            currentPermutation + leftCharacters.charAt(i),
            leftCharacters.substring(0, i) + leftCharacters.substring(i + 1)
        );
    }
}
```

#### Złożoność obliczeniowa

Łańcuch znaków o długości `n` posiada `n!` wszystkich permutacji. Zatem złożoność obliczeniowa potrzebna do ich wygenerowania to `Ο(n!)`. Dodatkowo dla każdej z nich przeprowadzam operację łączenia łańcuchów znaków wewnątrz pętli. Ta operacja ma złożoność `Ο(n)`. Zatem finalna złożoność obliczeniowa tego rozwiązania to `Ο(n^n!)`. 

Spróbuj uruchomić to rozwiązanie kilka razy. Za każdym razem dodawaj po jednej literze do łańcucha znaków. Na ile liter masz cierpliwość ;) ? Pamiętaj, że dla dużych wartości `n` nie masz szans na doczekanie się rozwiązania.

#### Złożoność pamięciowa

W przypadku tego rozwiązania każda permutacja jest dodawana do `permutationsCache`. Każda z permutacji ma tę samą długość – `n`. W związku z tym złożoność pamięciowa tego rozwiązania to `Ο(nn!)`.

### Algorytm – Znacząco lepsze rozwiązanie

Chociaż poprzedni algorytm jest poprawny nie ma szans działać dla większych instancji problemu. Nie wspominając nawet o łańcuchach o długości 10<sup>8</sup> wspomnianych w treści zadania. Można podejść do rozwiązania tego problemu w trochę inny sposób. Proszę spójrz na przykład poniżej:

```java
boolean slightlyBetterChangePossible(String sequence1, String sequence2) {
    char[] s1 = sequence1.toCharArray();
    char[] s2 = sequence2.toCharArray();
    Arrays.sort(s1);
    Arrays.sort(s2);
    return Arrays.equals(s1, s2);
}
```

To rozwiązanie jest lepsze od poprzedniego pod każdym względem. Wykorzystuje ono fakt, że istnieje możliwość otrzymania `sequence2` w wyniku przekształceń `sequence1` jeśli obie sekwencje składają się dokładnie z tych samych liter.

#### Złożoność obliczeniowa

Łatwym sposobem na sprawdzenie czy ta zależność jest spełniona jest sprawdzenie posortowanych liter, które wchodziły w skład łańcuchów. W tym przypadku do sortowania użyłem algorytmu z biblioteki standardowej, którego złożoność obliczeniowa wynosi `Ο(nlog(n))` – złożoność obliczeniowa tego podejścia wynosi `Ο(nlog(n))`.

#### Złożoność pamięciowa

W tym przypadku potrzebna jest tablica zawierająca wszystkie znaki obu łańcuchów. Zatem złożoność pamięciowa tego rozwiązania wynosi `Ο(n)`.

### Algorytm – optymalne rozwiązanie i tablice

Poprzednia wersja algortymu jest zadowalająca. Można ją uruchomić dla dużych instancji problemu i doczekać się rozwiązania ;). Jest jednak jeszcze lepszy sposób. Proszę spójrz na przykład poniżej:

```java
boolean optimalChangePossible(String sequence1, String sequence2) {
    return Arrays.equals(countLetters(sequence1), countLetters(sequence2));
}

private int[] countLetters(String sequence) {
    int[] counters = new int['T' - 'A' + 1];

    for (char c : sequence.toCharArray()) {
        counters[c - 'A']++;
    }

    return counters;
}
```

To rozwiązanie wykorzystuje dokładnie ten sam fakt, na który zwróciłem uwagę poprzednio. Mianowicie istnieje możliwość przekształcenia `sequence1` do `sequence2` jeśli oba łańcuchy składają się dokładnie z tych samych liter.

#### Złożoność obliczeniowa

Kolejność tych liter nie ma znaczenia. Istotna jest jedynie ich liczba. Zatem wystarczy zliczyć wystąpienia każdej z możliwych liter. Taka statystyka zwracana jest przez funkcję `countLetters`. Funkcja ta wykonuje operację dla każdej z `n` liter, zatem jej złożoność obliczeniowa to `Ο(n)`. Funkcja ta wykonan jest dwa razy, w związku z tym złożoność obliczeniowa tego algorytmu to `Ο(n)`.

#### Złożoność pamięciowa

Z treści zadania wiadomo, że litery są z zakresu `A-T`, zatem tablica do pomieszczenia licznika wystąpień dla każdej z liter wymaga dokładnie `'T' - 'A' + 1` elementów — 20. Z racji tego, że jest to stała, niezależna od długości łańcucha wejściowego złożoność pamięciowa tego rozwiązania wynosi `Ο(1)`.

### Algorytm – optymalne rozwiązanie i strumienie

Tym razem jest to wariacja poprzedniego pomysłu. W tym przypadku implementację opartą o tablice zastąpiłem [strumieniami]({% post_url 2018-01-30-strumienie-w-jezyku-java %}):

```java
boolean changePossible(String sequence1, String sequence2) {
    Map<Character, Long> s1Counters = countLettersWithStreams(sequence1);
    Map<Character, Long> s2Counters = countLettersWithStreams(sequence2);
    return s1Counters.equals(s2Counters);
}

private Map<Character, Long> countLettersWithStreams(String sequence1) {
    return sequence1.chars()
            .mapToObj(c -> (char) c)
            .collect(Collectors.groupingBy(c -> c, Collectors.counting()));
}
```

Złożoność pamięciowa i obliczeniowa nie zmieniły się w stosunku do poprzedniego rozwiązania.

### Interfejs użytkownika

Treść zadania zakłada uruchomienie programu w następujący sposób:

    program.exe < dane.txt 

Przekładając to na realia Javy uruchomienie programu może wyglądać następująco

    java -cp 12_dna-1.0-SNAPSHOT.jar pl.samouczekprogramisty.szs.dna.DNASequencer < dane.txt

Jeśli do tej pory nie udało Ci się przeczytać artykułu o [użyciu Javy w linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}) to chyba właśnie nadszedł na to czas ;).

Standardowe wejście w języku Java reprezentowan jest przez obiekt `System.in`. Do czytania wejścia linia po linii użyłem klasy [`BufferedReader`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/BufferedReader.html):

```java
public static void main(String[] args) throws IOException {
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
    while (true) {
        String line = reader.readLine();
        if (line == null) {
            break;
        }
        System.out.println(changePossible(line, reader.readLine()));
    }
}
```

## Wyślij mi swoje zadanie

Jeśli chcesz żebym spróbował rozwiązać Twoje zadanie proszę wyślij je na mój adres e-mail `marcin małpka samouczekprogramisty.pl`. Jeśli tylko będę potrafił je rozwiązać to z chęcią napiszę o tym artykuł.

{% include zadanie-z-rozmowy-notice.md %}

## Podsumowanie

Po lekturze tego artykułu i samodzielnej próbie rozwiązania zadania jesteś o krok bliżej do dobrego przygotowania do rozmowy kwalifikacyjnej. Udało Ci się poznać kilka sposobów rozwiązania tego samego problemu, a może Twoje rozwiązanie jest jeszcze inne?

Nawet jeśli udało Ci się rozwiązać zadanie samodzielnie proszę rzuć okiem na [moją implementację](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/12_dna). Czytając kod innych programistów możesz nauczyć się jeszcze więcej. Nie zapomnij rzucić okiem na [testy jednostkowe]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %})!

Jeśli ktoś z Twoich znajomych przygotowuje się do rozmowy kwalifikacyjnej na stanowisko programisty możesz podzielić się linkiem do tego artykułu, z góry dziękuję. Jeśli nie chcesz pomiąć kolejnych artykułów możesz dopisać się do samouczkowego newslettera i polubić Samouczka na Facebook'u.

Do następnego razu!
