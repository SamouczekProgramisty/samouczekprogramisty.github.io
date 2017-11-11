---
title: Podstawy złożoności obliczeniowej
categories:
- Programowanie
- Wiedza ogólna
permalink: /podstawy-zlozonosci-obliczeniowej/
header:
    teaser: /assets/images/2017/11/13_zlozonosc_obliczeniowa_artykul.jpg
    overlay_image: /assets/images/2017/11/13_zlozonosc_obliczeniowa_artykul.jpg
    caption: "[&copy; lytfyre](https://www.flickr.com/photos/lytfyre/6489338411/sizes/l)"
excerpt: W artykule tym przeczytasz o złożoności obliczeniowej. Dowiesz się dlaczego jest ona ważna i kiedy jest wykorzystywana. Przeczytasz o tym czym jest notacja Ο (dużego O), Ω (omega) i Θ (theta). Na przykładach algorytmów poznasz najczęściej używane funkcje w notacji &Omicron;. Po lekturze określenia złożoność liniowa czy złożoność logarytmiczna nie powinny być dla Ciebie problemem. Zapraszam!
---

{% capture wstep %}
Artykuł ten zawiera jedynie podstawy związane z zagadnieniem złożoności obliczeniowej. Bynajmniej nie wyczerpuje tematu. Teoria obliczeń to osobny dział informatyki. Jeśli chcesz go zgłębić zachęcam Cię do przejrzenia dodatkowych materiałów do nauki.

Mam świadomość, że tłumaczenie złożoności obliczeniowej bez wspomniania o maszynie Turinga to profanacja. Jednak dla zupełnie początkujących w temacie takie podejście wydaje mi się łatwiejsze.
{% endcapture %}

<div class="notice--warning">
  {{ wstep | markdownify }}
</div>

## Teoria obliczeń

Teoria obliczeń to dział informatyki. Jedną z gałęzi tego działu jest teoria złożoności obliczeniowej. W uproszczeniu można powiedzieć, że zajmuje się ona oszacowaniem wydajności czasowej i pamięciowej algorytmów. Teoria złożoności obliczeniowej bazuje na wielu modelach, które służą do łatwego porównywania algorytmów.

## Dlaczego używamy złożoności obliczeniowej

Komputerów na świecie są miliony. Wiele z nich bardzo się od siebie różni. Mają różny procesor, inny moduł RAM. Część z nich używa bardziej wydajnych dysków, które pozwalają na szybszy dostęp do danych. Dla części z nich dane dostępne są na zdalnych maszynach, do których trzeba łączyć się przez sieć. Są też megakomputery, maszyny o ogromnej mocy obliczeniowej.

W związku z tą różnorodnością pojawia się pytanie. W jaki sposób mierzyć wydajność poszczególnych algorytmów? Mierzenie czasu jest mało praktyczne. Nie ma ono większego sensu z powodu różnorodności sprzętu. Otrzymane wyniki nie byłby miarodajne w przypadku innego komputera.

Pojawia się zatem potrzeba wspólnej miary, niezależnej od zmiennych czynników. Miara ta ma pomóc zorientować się w wydajności danego algorytmu, przyporządkować go do zdefiniowanej klasy algorytmów. Tutaj w grę wkraczają modele, o których wspomniałem wcześniej. Modele te upraszczają zawiłości związane z różnorodnością sprzętu. Dzięki modelom możemy określać złożoność obliczeniową jako funkcję.

## Złożoność obliczeniowa a funkcja

Złożoność obliczeniową określamy jako funkcję danych wejściowych algorytmu. Mam nadzieję, że będzie Ci to łatwiej zrozumieć na przykładzie. Załóżmy, że mamy tablicę liczb. Problemem do rozwiązania jest znalezienie sumy tych liczb. Jeśli tablicę wejściową określimy jako `t` wówczas funkcja `funkcja(t)` (czy `f(t)`) będzie pozwalała określić jaka jest złożoność obliczeniowa danego algorytmu. 

O ile dla naukowców znalezienie dokładnej funkcji może być bardzo istotne, to w praktyce wystarczą jej oszacowania. Takie oszacowania to notacja Ο (dużego O), notacja Ω (omega) i notacja Θ (theta).

Tak dla przypomnienia ;). Funkcje możesz pamiętać z matematyki. Na przykład funkcja `f(x) = ax^2 + bx + c` opisuje [parabolę](https://pl.wikipedia.org/wiki/Parabola_(matematyka\)).
{: .notice--info}

### Oszacowania funkcji

Załóżmy, że mamy do czynienia z funkcją.
$$f(x) = x^3 - 6x^2 + 4x + 12$$

W kolejnych para


#### Notacja Ο (dużego O)

[^grafy]: Wykresy stworzyłem przy pomocy [graphsketch](https://graphsketch.com/).

#### Notacja Ω (omega)

#### Notacja Θ (theta)

## Klasy funkcji przybliżających

Zakła

### `Ο(1)`

Złożoność stała, niezależna od liczby danych wejściowych.

### `Ο(n)`

Złożoność liniwa.

### `Ο(log(n))`

Złożoność logarytmiczna.

### `Ο(nlog(n))`

Złożoność liniowo-logarytmiczna

### `Ο(n^2)`

Złożoność kwadratowa

### `Ο(n^x)`

Złożoność wielomanowa. Złożoność liniowa i złożoność kwadratowa są specyficznymi przypadkami złożoności wielomianowej. Ze względu na częste występowanie wyszczególniłem je jako osobne funkcje.

### `Ο(x^n)`

Złożoność wygkładnicza

### `Ο(n!)`

## Najlepszy, średni i najgorszy przypadek

Ten sam algorytm może zachowywać się zupełnie inaczej w przypadku innych danych wejściowych.

Załóżmy, że naszym problemem do rozwiązania jest znalezienie największej liczby z przedziału `[0, 100]` w tablicy, którą otrzymujemy na wejściu. Algorytm, który rozwiązuje ten problem może wyglądać następująco:

```java
int findMax(int[] numbers) {
	int max = numbers[0];
	for (int number : numbers) {
		if (number > max) {
			max = number;
		}
		if (max == 100) {
			return max;
		}
	}
}
```

Zakładając, że tablica ma długość `N` elementów, wówczas nasz algorytm musi:

1. przejrzeć tylko pierwszy element, jeśli liczba 100 występuje zawsze w pierwszym indeksie tablicy,
2. przejrzeć `N` elementów, jeśli liczba 100 występuje zawsze w ostatnim indeksie tablicy.

Punkt pierwszy to najlepszy przypadek. Przy takich danych wejściowych algorytm zwróci wynik w najkrótszym czasie. Drugi punkt to najgorszy przypadek, wówczas algorytm będzie działał najdłużej. Mówi się także o średnim przypadku, sytuacji, która jest najbardziej prawdopodobna. W przykładzie powyżej w średnim przypadku musielibyśmy prz

W praktyce określenie średniego przypadku nie zawsze jest trywialne. Ponadto w większości przypadków interesuje nas najgorsza możliwa sytuacja - ile będzie trwało _najdłuższe_ uruchomienie algorytmu. 

Z tego właśnie powodu, aby móc łatwiej porównywać algorytmy w większości przypadków używa się najgorszego przypadku do określenia złożoności obliczeniowej algorytmu.

## Dodatkowe matriały do nauki

Informacji na temate teorii obliczeń i złożoności obliczeniowej w internecie jest sporo. Jednak dość ciężko jest znaleźć jakiekolwiek informacje, które są na początkującym poziomie. Niemniej jednak poniżej starałem się zebrać materiały, które mogą być interesujące:

- [Wydkład dotyczący złożoności obliczeniowej na Uniwersytecie Warszawskim](http://wazniak.mimuw.edu.pl/index.php?title=Z%C5%82o%C5%BCono%C5%9B%C4%87_obliczeniowa),
- [Kilka krótkich artykułów opisujących podstawy teorii obliczeń](http://cpp0x.pl/kursy/Teoria-w-Informatyce/424),
- [Computational Complexity: A Modern Approach](http://theory.cs.princeton.edu/complexity/), szkic książki o złożoności obliczeniowej. Jej ostateczna wersja dostępna jest na [Amazonie](http://amzn.to/2zxrqqs)[^afiliacja],
- [Artykuł na temat złożoności obliczeniowej z uniwersytetu Stanford](https://plato.stanford.edu/entries/computational-complexity/),
- [Sekcja Wolfram Alpha poświęcona złożoności obliczeniowej](https://www.wolframalpha.com/examples/ComputationalComplexity.html).

[^afiliacja]: To jest link afiliacyjny. Oznacza to tyle, że jeśli kupisz ten produkt pomożesz mi w dalszym prowadzeniu bloga. Nie jest to związane z żadnymi dodatkowymi kosztami dla Ciebie. Dziękuję! :)

## Podsumowanie
