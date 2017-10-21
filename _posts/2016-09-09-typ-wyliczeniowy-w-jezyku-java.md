---
title: Typ wyliczeniowy w języku Java
date: '2016-09-09 15:30:32 +0200'
categories:
- Kurs programowania Java
permalink: /typ-wyliczeniowy-w-jezyku-java/
header:
    teaser: /assets/images/2016/09/09_typ_wyliczeniowy_artykul.jpg
    overlay_image: /assets/images/2016/09/09_typ_wyliczeniowy_artykul.jpg
excerpt: W artykule tym przeczytasz o typie wyliczeniowym. Poznasz słowo kluczowe `enum`. Na koniec czeka na Ciebie zestaw zadań, w którym przećwiczysz wiedzę z tego artykułu. Dowiesz się kiedy używamy typu enum. Napiszesz też prosty kalkulator w oparciu o Twój typ wyliczeniowy. Zapraszam do lektury.
disqus_page_identifier: 400 http://www.samouczekprogramisty.pl/?p=400
---

{% include toc %}

{% include kurs-java-notice.md %}

## Enum, typ wyliczeniowy

Wyobraź sobie, że mamy klasę `Tshirt`, która posiada kilka atrybutów takich jak kolor, rozmiar czy producent. O ile producentów koszulek, podobnie jak ich kolorów jest dość dużo to rozmiary są już bardzo często wspólne dla różnych producentów. Rozmiary możemy wyliczyć: S, M, L czy XL. I właśnie do przechowywania danych tego typu Java ma specjalny typ. Jest to enum zwany także typem wyliczeniowym. Przejdźmy od razu do przykładu:

```java
public enum SimpleSize {
    S,
    M,
    L,
    XL
}
```

Fragment kodu powyżej pokazuje typ wyliczeniowy `TshirtSize`, który może mieć jedną z czterech wartości `S`, `M`, `L` lub `XL`. Kolejne wartości typu wyliczeniowego oddzielamy przecinkiem.

Konwencja nadawania nazw zaleca aby wartości dla typu enum pisane były drukowanymi literami. Zatem `TshirtSize.S` jest w porządku, podczas gdy `TshirtSize.s` już nie.

Proszę spójrz na przykład użycia:

```java
public class Tshirt {
    private TshirtSize size;
    private String manufacturer;

    public Tshirt(TshirtSize size, String manufacturer) {
        this.size = size;
        this.manufacturer = manufacturer;
    }

    public static void main(String[] args) {
        Tshirt tshirt = new Tshirt(TshirtSize.L, "Polex");
        System.out.println(tshirt.size);
    }
}
```

Jak widzisz w przykładzie wyżej mamy klasę `Tshirt`, reprezentującą koszulkę, która jako jeden z atrybutów ma właśnie rozmiar, który jest typu `TshirtSize`.

Do wartości typu wyliczeniowego odnosimy się jak do pól statycznych klasy, zatem w naszym przypadku do rozmiaru L możemy odwołać się jako `TshirtSize.L`. Dzieję się tak ponieważ w rzeczywistości wartości typu wyliczeniowego mają automatycznie dodane modyfikatory `public static final`.

### Typ wyliczeniowy a blok `switch`

W jednym z [poprzednich artykułów]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}) poznałeś konstrukcję `switch`. W tamtej części wspomniałem, o tym, że wewnątrz tej konstrukcji możemy używać liczb całkowitych czy łańcuchów znaków. Pominąłem wówczas jedną z dodatkowych wartości konstrukcji `switch`. Otóż wewnątrz możemy użyć także typu wyliczeniowego jak w przykładzie poniżej:

```java
switch (tshirt.size) {
    case S:
        System.out.println("Kupiles koszulke w rozmiarze small");
        break;
    case M:
        System.out.println("Kupiles koszulke w rozmiarze medium");
        break;
    case L:
        System.out.println("Kupiles koszulke w rozmiarze large");
        break;
    case XL:
        System.out.println("Kupiles koszulke w rozmiarze extra large");
        break;
}
```

W takim przypadku w zależności od wartości zmiennej size zostanie wywołana odpowiedni blok konstrukcji `switch`. Proszę zauważ, że w tym przypadku kompilator dokładnie wie jakiego typu są wartości `L`, `M`, `S` czy `XL` i nie możemy się do nich odwoływać poprzez pełną nazwę `TshirtSize.M`.

### Typ wyliczeniowy to też klasa

Podobnie jak w przypadku normalnych klas tak i w przypadku typów wyliczeniowych może on posiadać atrybuty czy metody. Możesz także stworzyć klasę wyliczeniową, która będzie miała swój własny konstruktor inny od domyślnego. Spójrz na przykład poniżej

```java
public enum TshirtSize {
    S(48, 71, 36),
    M(52, 74, 38),
    L(56, 76, 41),
    XL(61, 79, 41);
 
    private int chestWidth;
    private int shirtLength;
    private int sleeveLength;
 
    TshirtSize(int chestWidth, int shirtLength, int sleeveLength) {
        this.chestWidth = chestWidth;
        this.shirtLength = shirtLength;
        this.sleeveLength = sleeveLength;
    }   
 
    public int getChestWidth() {
        return chestWidth;
    }
 
    public int getShirtLength() {
        return shirtLength;
    }
 
    public int getSleeveLength() {
        return sleeveLength;
    }
}
```

W przykładzie nasz enum został rozszerzony o trzy atrybuty: szerokość klatki piersiowej, długość koszulki i długość rękawa. Dzięki dodaniu atrybutów do typu wyliczeniowego wszystkie potrzebne dane związane z jednym rozmiarem mamy zgrupowane w jednym miejscu.

Każdy typ wyliczeniowy, który napiszesz domyślnie tworzony jest jako typ `final`. Ograniczone są także modyfikatory dostępu, które możesz użyć, w przypadków enumów dopuszczalny jest wyłącznie modyfikator `public` lub brak jakiegokolwiek modyfikatora dostępu.

Typ wyliczeniowy nie może określić żadnej nadklasy po której dziedziczy. Dzieje się tak ponieważ każdy enum domyślnie dziedziczy po [`java.lang.Enum`](https://docs.oracle.com/javase/8/docs/api/java/lang/Enum.html). Dzięki tej nadklasie wszystkie typy wyliczeniowe zyskują kilka dodatkowych metod opisanych w kolejnych akapitach.

Jeśli nasz enum ma także metody czy konstruktory to lista jego wartości musi znajdować się na początku.

### Słów kilka o konstruktorze enuma

Mimo tego, że jesteś w stanie utworzyć swój konstruktor dla typu wyliczeniowego to nie możesz go wywołać poza definicją enuma. Każde inne użycie powoduje błąd kompilacji. To ile wartości ma typ wyliczeniowy określasz w kodzie, nie możesz tworzyć nowych instancji w trakcie działania programu. Konstruktor domyślne ma przypisane słowo kluczowe private „dodawane przez kompilator”.

### Porównywanie typów wyliczeniowych

Poza konstrukcją `switch` typy wyliczeniowe możemy także stosować w blokach `if`. Możemy porównywać ich wartości przy pomocy operatora `==`. Oczywiście metoda `equals` też będzie działała jak się tego spodziewasz. W rzeczywistości wewnątrz metody `equals` w typie wyliczeniowym do porównania użyty jest właśnie operator `==`.

### Metody dostępne w każdym typie wyliczeniowym

Dzięki nadklasie `Enum`, o której wspomniałem w jednym z poprzednich akapitów mamy dostęp do kilku dodatkowych metod.

`ordinal`, metoda zwraca indeks aktualnej wartości typu wyliczeniowego. Indeks pierwszego elementu to zawsze 0. W związku z tym kolejność definiowania wartości typu wyliczeniowego jest istotna.

Przydatna jest także metoda `name`, która zwraca nazwę wartości typu wyliczeniowego. W naszym przypadku `TshirtSize.L.name()` zwróci `"L"`.

Wszystkie typy wyliczeniowe mają także przydatne metody statyczne. Jedną z nich jest metoda `values`. Pozwala ona na iterowanie po wartościach typu wyliczeniowego. Zwraca tablicę wartości typu wyliczeniowego

Dostępna jest także metoda `valueOf`, która przyjmuje łańcuch znaków i zwraca wartość typu wyliczeniowego. W naszym przypadku `TshirtSize.valueOf("L")` zwróci `TshirtSize.L`.

## Kiedy i po co używać typów wyliczeniowych

Typów wyliczeniowych/enumów używamy w momencie jeśli jakiś atrybut/zmienna może mieć określoną, ograniczoną listę wartości. Zastosowanie typu wyliczeniowego może pomóc ograniczyć liczbę błędów, na przykład w miejscu gdzie normalnie używalibyśmy łańcucha znaków reprezentującego rozmiar używamy dokładnie zdefiniowanego typu wyliczeniowego.

Dzięki typom wyliczeniowym możemy w jednym miejscu zgrupować wszystkie dopuszczalne wartości. Pozwala to także na łatwe rozszerzanie tej listy.

## Metody abstrakcyjne w typie wyliczeniowym

Poza zwykłymi metodami, konstruktorami czy atrybutami enumy mogą posiadać metody abstrakcyjne. Tylko gdzie mielibyśmy je zaimplementować jeśli jedyne instancje typu wyliczeniowego musimy zdefiniować w klasie? Proszę spójrz na przykład poniżej.

```java
public enum Formatter {
    CALM {
        public String format(String message) {
            return "Here is your message: " + message;
        }
    },
    NERVOUS {
        public String format(String message) {
            return "ARGH! STOP BOTHERING ME WITH YOUR MESSAGE! " + message + " I'M NOT GOING TO ACCEPT ANYTHING MORE!";
        }
    };
 
    public abstract String format(String message);
}
```

Konstrukcja taka jak na przykładzie powyżej to nic innego jak zdefiniowanie ciała metody `format` wewnątrz poszczególnych wartości. Dzięki takiemu podejściu metody `Formatter.CALM.format()` i `Formatter.NERVOUS.format()` mogą mieć różną implementację.

## Materiały dodatkowe

Przygotowałem dla Ciebie zestaw materiałów dodatkowych jeśli chciałbyś poczytać na temat typów wyliczeniowch w innych miejscach.
- [https://rpodhajny.wordpress.com/2009/02/17/typ-enum](https://rpodhajny.wordpress.com/2009/02/17/typ-enum)
- [https://www.youtube.com/watch?v=IHcTGxFQSm8](https://www.youtube.com/watch?v=IHcTGxFQSm8)
- [https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html)
- [https://docs.oracle.com/javase/8/docs/api/java/lang/Enum.html](https://docs.oracle.com/javase/8/docs/api/java/lang/Enum.html)
- [https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8.9](https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8.9)
- [http://tutorials.jenkov.com/java/enums.html](http://tutorials.jenkov.com/java/enums.html)

Kod źródłowy dla wszystkich przykładów użytych w artykule znajduje się na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/19_typ_wyliczeniowy/src/main/java/pl/samouczekprogramisty/kursjava/enums).

## Zadania

1. Napisz klasę `Human`, która będzie reprezentowała człowieka. Niech klasa ta posiada atrybuty takie jak imię, wiek, kolor oczu, kolor włosów. Niech te dwa ostatnie atrybuty będą typami wyliczeniowymi. Stwórz instancję takiej klasy.
2. Napisz typ wyliczeniowy `Computation`, który będzie reprezentował prosty kalkulator. Niech typ ten posiada następujące wartości `MULTIPY`, `DIVIDE`, `ADD`, `SUBTRACT`. Niech typ ten posiada metodę `public double perform(double x, double y)`, która zwróci wynik odpowiedniej operacji. Na przykład `Computation.ADD.perform(1, -5)` powinno zwrócić -4.

Przygotowałem dla Ciebie przykładowe rozwiązania. Proszę jednak abyś spróbował rozwiązać zadania samodzielnie, wówczas najwięcej się nauczysz. Kod rozwiązań znajdziesz w [repozytorium na githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/19_typ_wyliczeniowy/src/main/java/pl/samouczekprogramisty/kursjava/enums/exercise).

## Podsumowanie

Po przeczytaniu artykułu i zrobieniu zadań wiesz już wszystko na temat typów wyliczeniowych w Javie. Żadne zakamarki enumów nie są Ci obce :) Na koniec mam do Ciebie prośbę, proszę podziel się informacją o blogu ze swoimi znajomymi, udostępnienie linka do artykułu na facebooku naprawdę pomaga mi dotrzeć do jak największej liczby czytelników a na tym właśnie mi zależy. Jeśli masz jakiekolwiek pytania zadaj je w komentarzach, postaram się pomóc.

A.. zapomniałbym, jeśli chcesz być jako pierwszy informowany o nowościach na stronie zapisz się do mojego newslettera :)

Do następnego razu!
