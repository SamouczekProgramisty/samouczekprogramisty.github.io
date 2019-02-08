---
title: Wzorzec projektowy adapter
last_modified_at: 2019-02-08 19:07:18 2019 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-adapter/
header:
    teaser: /assets/images/2019/01/26_wzorzec_projektowy_adapter_artykul.jpg
    overlay_image: /assets/images/2019/01/26_wzorzec_projektowy_adapter_artykul.jpg
    caption: "[&copy; AlexanderStein](https://pixabay.com/en/plug-jack-stereo-jack-plug-adapter-185031/)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o adapterze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe)
{:.notice--info}

## Problem do rozwiązania

Pewnie wiesz, że w różnych krajach gniazdka mogą wyglądać inaczej niż to, co możesz zobaczyć na co dzień. Charakterystyka prądu w takim gniazdku także może być różna. Załóżmy, że jedziesz do Wielkiej Brytanii, albo do Stanów Zjednoczonych. Zabierasz ze sobą laptopa i ładowarkę. Bateria wystarcza Ci na czas lotu. Po przylocie na miejsce chcesz uzupełnić baterię w pierwszym wolnym gniazdku na lotnisku.

Tu pojawia się problem. Wtyczka z Twojej ładowarki nie pasuje do gniazdka. Można powiedzieć, że gniazdko i wtyczka nie są ze sobą kompatybilne. Przypominasz sobie jednak, że przezornie udało Ci się zapakować przejściówkę. Przejściówka sprawi, że możesz podłączyć swoją ładowarkę do gniazdka.

Problem tego typu może także występować w projektach informatycznych. Przejściówka, która pozwala włączyć wtyczkę do innego gniazdka to nic innego jak adapter.

Problemem do rozwiązania jest zatem użycie obiektu, w miejscu gdzie jego interfejs nie jest obsługiwany. Adapter rozwiązuje ten problem "tłumacząc" go na coś zrozumiałego dla klienta.

## Błyskawiczny kurs UML

Zanim przejdę do omówienia diagramów, które pokazują powiązania klas i interfejsów w tym wzorcu projektowym musisz dowiedzieć się czegoś o UML'u.

UML (ang. _Unified Modeling Language_) składa się z kilkunastu rodzajów diagramów. Jest to zestaw, który pozwala na wizualną reprezentację projektu informatycznego. W ramach serii opisującej wzorce projektowe będę korzystał z zupełnych podstaw tej notacji. Będę używał głównie diagramów klas. Chociaż nie jestem wielkim fanem UML'a, to taki sposób prezentacji w tym przypadku wydaje mi się najlepszy.

Do zrozumienia diagramów z tego artykuły wystarczy Ci ten przykład:

{% include figure image_path="/assets/images/2019/01/29_uml_diagram.svg" caption="Przykładowy diagram UML." %}

Na tym diagramie możesz zobaczyć:

- trzy klasy – prostokąty z napisami `User`, `LinkedList`, `Object`,
- dwa interfejsy – prostokąty oznaczone adnotacją `<<interfejs>>` z napisami `List`, `Collection`,
- dziedziczenie – strzałka z ciągłą linią i z pustym grotem, na przykład pomiędzy `LinkedList` a `Object` czy `List` a `Collection`,
- implementację interfejsu – strzałka z przerywaną linią i z pustym grotem pomiędzy `LinkedList` a `List`,
- zależność – strzałkę z ciągłą linią pomiędzy `User` a `LinkedList`.

Kod w języku Java zgodny z tym diagramem może wyglądać tak (część diagramu dotycząca elementów biblioteki standardowej nie jest tu widoczna):

```java
public class User extends Object {
    private LinkedList<String> notes;
}
```

Te podstawy w zupełności wystarczą Ci do zrozumienia poniższych przykładów.

## Wzorzec adapter

### Diagramy klas

Istnieją dwa sposoby implementacji adaptera. Jeden z nich używa kompozycji, drugi dziedziczenia. Diagramy poniżej pokazują tę subtelną różnicę:

{% include figure image_path="/assets/images/2019/01/29_adapter_kompozycja.svg" caption="Wzorzec adapter zaimplementowany przy pomocy kompozycji." %}

{% include figure image_path="/assets/images/2019/01/29_adapter_dziedziczenie.svg" caption="Wzorzec adapter zaimplementowany przy pomocy dziedziczenia." %}

W obu przypadkach klasa `DoAdaptacji` nie implementuje bezpośrednio interfejsu `Zależność`. Ten interfejs implementuje klasa `Adapter`. Także w obu przypadkach `Klient` reprezentuje klasę, która używa interfejsu `Zależność`. Zatem użycie klasy `Adapter` pozwala na pośrednie użycie klasy `DoAdaptacji` przez klasę `Klient`.

Zaletą stosowania tego wzorca projektowego jest to, że klasa `DoAdaptacji` nie musi być modyfikowana, aby spełnić interfejs wymagany przez klasę `Klient`. Czasami nawet taka modyfikacja nie jest możliwa.

{% include newsletter-srodek.md %}

### Przykładowa implementacja adaptera

Wyobraź sobie sytuację, w której mamy macierz kwadratową. Macierz reprezentowana jest przez obiekt implementujący interfejs `Matrix`:

```java
public interface Matrix {
    int get(int x, int y);
    int size();
}
```

Dodatkowo istnieje klasa `MatrixOperations`, która definiuje zestaw metod operujących na takich macierzach. Przykład poniżej pokazuje metodę `largest`, która zwraca największy element z macierzy:

```java
public class MatrixOperations {
    public static int largest(Matrix m) {
        if (m.size() == 0) {
            throw new IllegalArgumentException("Matrix is empty!");
        }
        int largest = m.get(0, 0);
        for (int x = 0; x < m.size(); x++) {
            for (int y = 0; y < m.size(); y++) {
                if (m.get(x, y) > largest) {
                    largest = m.get(x, y);
                }
            }
        }
        return largest;
    }
}
```

Przekładając to na diagramy, które pokazałem wyżej to:

* `Klient` – `MatrixOperations`,
* `Zależność` – `Matrix`.

#### Adapter przy użyciu kompozycji

Standardowo macierz można reprezentować przez tablicę dwuwymiarową. `ArrayMatrix` to adapter, który wykorzystuje kompozycję. W tym przypadku opakowuje on tablicę dwuwymiarową – `int[][]`, udostępniając interfejs `Matrix`:

```java
public class ArrayMatrix implements Matrix {
    private final int[][] matrix;

    public ArrayMatrix(int[][] matrix) {
        this.matrix = matrix;
    }

    @Override
    public int get(int x, int y) {
        return matrix[y][x];
    }

    @Override
    public int size() {
        return matrix.length;
    }
}
```

W tym przypadku:

* `Adapter` – `ArrayMatrix`,
* `DoAdaptacji` – `int[][]`.

Wszystko ładnie działa. Do czasu. Pojawiło się wymaganie, które zakłada, że musisz przechować bardzo dużą i [rzadką macierz](https://pl.wikipedia.org/wiki/Macierz_rzadka). Rzadka macierz to taka, w której większość elementów ma wartość `0`. Jest to problem, ponieważ `ArrayMatrix` wymaga ciągłych obszarów pamięci. Dodatkowo marnuje ją przechowuje wartości `0`, które można pominąć.

Z pomocą przychodzi inna implementacja adaptera.

#### Adapter przy użyciu dziedziczenia

Tym razem adapter wykorzystuje dziedziczenie:

```java
public class MapMatrix extends HashMap<String, Integer> implements Matrix {
    private final int size;

    public MapMatrix(int size) {
        this.size = size;
    }

    @Override
    public int get(int x, int y) {
        assertBoundaries(x, y);
        return this.getOrDefault(key(x, y), 0);
    }
    
    public void set(int x, int y, int value) {
        assertBoundaries(x, y);
        put(key(x, y), value);
    }

    @Override
    public int size() {
        return size;
    }

    private String key(int x, int y) {
        return x + "," + y;
    }

    private void assertBoundaries(int x, int y) {
        if (x < 0 || x > size || y < 0 || y > size) {
            throw new IllegalArgumentException(key(x, y));
        }
    }
}
```

W tym przypadku:

* `Adapter` – `MapMatrix`,
* `DoAdaptacji` – `HashMap`.

## Ćwiczenie do wykonania

Ćwiczenie polega na zaimplementowaniu adaptera. Przerób adapter `MapMatrix` w taki sposób, aby wykorzystywał kompozycję.

## Dodatkowe materiały do nauki

Bez wątpienia klasyką tematu jest książka [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Zachęcam Cię też do zajrzenia do [kodu źródłowego](https://github.com/SamouczekProgramisty/WzorceProjektowe/tree/master/01_adapter/src/main/java/pl/samouczekprogramisty/patterns), który użyłem w tym artykule.

## Podsumowanie

Po przeczytaniu tego artykułu wiesz czym jest wzorzec projektowy adapter. Znasz przykłady zastosowania tego wzorca. Rozwiązując ćwiczenie udało Ci się zastosować tę wiedzę w praktyce.

Mam nadzieje, że artykuł przypadł Ci do gustu. Na koniec mam do Ciebie prośbę. Jeśli ktoś z Twoich znajomych mógłby skorzystać z tego artykułu proszę przekaż mu linka. Dzięki temu pomożesz mi dotrzeć do nowych Czytelników. Z góry dziękuję!

Jeśli nie chcesz pominąć nowych artykułów polub Samouczka na Facebook'u i zapisz się do samouczkowego newslettera. Trzymaj się!
