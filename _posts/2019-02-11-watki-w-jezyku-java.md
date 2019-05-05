---
title: Wątki w języku Java
last_modified_at: 2019-05-05 21:25:49 +0200
categories:
- Kurs programowania Java
permalink: /watki-w-jezyku-java/
header:
    teaser: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    caption: "[&copy; Héctor J. Rivas](https://unsplash.com/photos/87hFrPk3V-s)"
excerpt: Artykuł ten opisuje wątki w języku Java. Po jego lekturze dowiesz się czym jest wątek, jaki ma cykl życia i jak go uruchomić. Dowiesz się czym jest synchronizacja i poznasz jej podstawowe mechanizmy. Dowiesz się też jakie mogą być konsekwencje jej braku. Poznasz dwa słowa kluczowe i fragment biblioteki standardowej pomagającej w pisaniu wielowątkowego kodu. Po lekturze tego artykułu będziesz wiedzieć co oznacza wyścig w kontekście programowania wielowątkowego. Na końcu artykułu czekają na Ciebie zadania, w których przećwiczysz zdobytą wiedzę.
---

W artykule w zupełności pomijam zagadnienie procesów i zrównoleglania wykonywania zadań przy ich pomocy. Nie poruszam też tematu "event-loop" i przetwarzania asynchronicznego, które niejako związane są z wątkami. Pomijam także dokładny opis klas biblioteki standardowej z pakietu `java.util.concurrent` czy temat programowania reaktywnego. Każde z tych zagadnień to temat na co najmniej jeden osobny artykuł.
{:.notice--info}

## Stwórz swój pierwszy wątek

Zacznę od przykładu. Poniższy fragment kodu tworzy nowy wątek. Wewnątrz tego wątku znajduje się pętla, która wypisuje wszystkie liczby od 0 do 4, po czym kończy swoje działanie. Dokładnie taka sama pętla znajduje się w wątku głównym:

```java
public static void main(String[] args) {
    System.out.println("MT start");
    Thread thread = new Thread(() -> {
        System.out.println("T0 start");
        for (int i = 0; i < 5; i++) {
            System.out.println("T0 " + i);
        }
        System.out.println("T0 stop");
    });
    thread.start();
    for (int i = 0; i < 5; i++) {
        System.out.println("MT " + i);
    }
    System.out.println("MT stop");
}
```

Wynik działania tej metody może być następujący. W Twoim przypadku może on być zupełnie inny. Uruchom tę metodę kilka razy porównując otrzymany wynik:

    MT start
    MT 0
    T0 start
    MT 1
    T0 0
    T0 1
    T0 2
    MT 2
    T0 3
    MT 3
    T0 4
    T0 stop
    MT 4
    MT stop

Zanim przejdę do dokładnego omówienia tego fragmentu kodu musisz dowiedzieć się czegoś więcej o wątkach i sposobie ich działania.

## Wątki w teorii

### Program bez wątków

Wyobraź sobie problem, którego rozwiązanie wymaga wykonania trzech zadań. Udało Ci się napisać program, który ten problem rozwiązuje. Uruchamiasz ten program na komputerze. Każde z zadań uruchamiane jest po zakończeniu poprzedniego. Na diagramie może wyglądać to tak:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks.svg" caption="Trzy zadania uruchomione sekwencyjne na jednym procesorze." %}

Gwiazdka reprezentuje rdzeń procesora. Różnokolorowe prostokąciki reprezentują trzy zadania do wykonania. Długość prostokącików reprezentuje czas trwania poszczególnych zadań. Zadania uruchamiane są po kolei. Po tym jak skończy się zadanie zielone rozpoczyna się zadanie niebieskie. Można powiedzieć, że zadania uruchamiane są sekwencyjnie.

### Program wielowątkowy

Przed procesorami wielordzeniowymi wątki były "oszustwem". Procesor był jeden, mógł pracować wyłącznie nad jednym zadaniem. Wymyślono jednak inne rozwiązanie.

#### Szatkowanie czasu :)

Mam na myśli _time slicing_. Mechanizm dzięki, któremu jeden rdzeń procesora może uruchamiać wiele wątków. Nie dzieje się to jednak równolegle.

Diagram poniżej prezentuje dokładnie te same zadania. Tym razem każde z nich uruchamiane jest w osobnym wątku, mamy zatem trzy wątki. Mechanizm nadzorujący ich pracę zapewnia, że co jakiś czas aktualny wątek zostanie zatrzymany. Mówi się wtedy, że wątek został wywłaszczony. Kolejny wątek zostaje wybudzony, dostaje czas procesora i jest przez niego wykonywany. Suma długości prostokącików w danym kolorze jest dokładnie taka sama jak w&nbsp;poprzednim przykładzie:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks_threads.svg" caption="Trzy zadania uruchomione w wątkach na jednym procesorze." %}

Takie podejście ma swoje zalety, jednak nie prowadzi do krótszego czasu działania programu. Wręcz przeciwnie, zatrzymywanie i wybudzanie wątków zajmuje czas. Proszę spójrz na diagram poniżej, który pokazuje czas trwania obu podejść:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks_threads_comparison.svg" caption="Porównanie czasu trwania dwóch podejść na jednym procesorze." %}

Po co zatem stosować takie podejście? Najważniejszym argumentem jest to, że w tym przypadku każde z zadań jest delikatnie popychane do przodu. Wyobraź sobie inną sytuację. Załóżmy, że dwa zadania zajmują wyraźnie mniej czasu niż trzecie:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_uneven_tasks.svg" %}

W takim przypadku zadania niebieskie i białe muszą czekać na zakończenie zadania zielonego. Zastosowanie wątków w tym przypadku może prowadzić do dużo szybszego zakończenia zadań niebieskiego i białego (chociaż nadal sumaryczny czas, wraz z przełączeniami wątków, będzie dłuższy):

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_uneven_tasks_threads.svg" %}

Takie podejście pozwala na uniknięcie tak zwanego zagłodzenia (ang. _starving_) wątków. W&nbsp;powyższym przykładzie bez szatkowania czasu wątek z&nbsp;zadaniem zielonym zagłodziłby wątki z zadaniami niebieskim i białym.

"Szatkowanie czasu" daje wrażenie równoległej pracy wielu wątków, jednak w rzeczywistości w&nbsp;danym momencie tylko jedno zadanie jest uruchomione. Inaczej wygląda sytuacja w przypadku procesorów mających wiele rdzeni.

#### Procesory wielordzeniowe

Procesory wielordzeniowe dają rzeczywistą możliwość uruchamiania wielu zadań równolegle. W&nbsp;takim przypadku, jeśli każde z zadań uruchomione zostanie w osobnym wątku wówczas sytuacja wygląda jak na diagramie poniżej[^cztery]:

[^cztery]: Możesz założyć, że program został uruchomiony na procesorze czterordzeniowym. Czwarty rdzeń nie był uwzględniony na diagramie.

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_3_cpu_3_tasks_threads.svg" %}

Uruchomienie programu bez wątków na komputerze z procesorem wielordzeniowym nie przyspieszyłoby jego działania – jeden rdzeń sekwencyjnie realizowałby każde z zadań.

#### Połączenie obu podejść

W rzeczywistości spotkasz się połączeniem obu podejść[^rdzenie]. Proszę spójrz na diagram poniżej. Pokazuje on przykładowe wykonanie zadania na dwóch rdzeniach. Dla porównania pokazałem też sekwencyjne wykonanie tych samych zadań:

[^rdzenie]: Raczej mało prawdopodobne jest to, że masz komputer, który ma tylko jeden rdzeń procesora.

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_2_cpu_3_tasks_threads_comparison.svg" caption="Trzy zadania uruchomione w wątkach na dwóch procesorach." %}

### Wspólne dane

Wątki korzystają z tych samych danych. Mówi się, że wątki współdzielą przestrzeń adresową. Oznacza to tyle, że obiekty dostępne dla jednego wątku są widoczne także w innych wątkach[^threadlocal].

[^threadlocal]: Dla uproszczenia pomijam tutaj [`ThreadLocal`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/ThreadLocal.html).

Proszę pamiętaj, że zmienne dostępne są dla wszystkich wątków. W związku z tym wszystkie wątki mogą te zmienne modyfikować. Pociąga to za sobą bardzo poważne konsekwencje. Opiszę je dokładniej w dalszej części artykułu.

{% include newsletter-srodek.md %}

## Tworzenie nowego wątku

Każdy wątek w języku Java związany jest z klasą [`Thread`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html). Wątek można utworzyć na dwa sposoby.

### Dziedziczenie po klasie `Thread`

Pierwszym ze sposobów jest utworzenie własnej klasy, która dziedziczy po klasie [`Thread`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html):

```java
public class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("I'm inside thread!");
    }
}

Thread thread = new MyThread();
```

W tym przypadku należy nadpisać metodę [`run`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#run()) – to właśnie ona zostaje wykonana jako ciało wątku.

### Implementacja interfejsu `Runnable`

Drugim sposobem jest utworzenie wątku przy pomocy konstruktora, który przyjmuje obiekt implementujący interfejs [`Runnable`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Runnable.html):

```java
public static class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("I'm inside runnable!");
    }
}

Thread thread = new Thread(new MyRunnable());
```

Tym razem ciałem wątku jest implementacja metody [`run`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Runnable.html#run()) z interfejsu [`Runnable`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Runnable.html).

Zauważ, że możesz utworzyć wątek posługując się [klasami anonimowymi]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}#klasy-anonimowe):

```java
Thread thread = new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("I'm inside runnable!");
    }
});
```

Interfejs `Runnable` jest [interfejsem funkcyjnym]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}#interfejs-funkcyjny). W związku z tym zapis ten można uprościć stosując [wyrażenia lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}):

```java
Thread thread = new Thread(() -> System.out.println("I'm inside runnable!"));
```

## Cykl życia wątku

Utworzenie instancji wątku to dopiero początek. Każdy wątek ma swój cykl życia. Wątki mogą znajdować się w jednym z sześciu stanów. Dopuszczalne stany wątku znajdują się w [klasie wyliczeniowej]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}) [`Thread.State`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html):

* [`NEW`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#NEW) – nowy wątek, który nie został jeszcze uruchomiony,
* [`RUNNABLE`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#RUNNABLE) – wątek, który może wykonywać swój kod,
* [`TERMINATED`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#TERMINATED) – wątek, który zakończył swoje działanie,
* [`BLOCKED`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#BLOCKED) – wątek zablokowany, oczekujący na zwolnienie współdzielonego zasobu,
* [`WAITING`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#WAITING) – wątek uśpiony,
* [`TIMED_WAITING`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#TIMED_WAITING) – wątek uśpiony na określony czas.

Poniższy diagram pokazuje możliwe przejścia pomiędzy stanami:

{% include figure image_path="/assets/images/2019/02/05_thread_states.svg" caption="Diagram stanów wątku" %}

Przejście ze stanu `NEW` do stanu `RUNNABLE` odbywa się po wywołaniu metody [`start()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#start()) na instancji wątku. Dopiero wtedy wątek może być wykonywany, samo utworzenie instancji nie powoduje jego uruchomienia. Każdy wątek może być uruchomiony dokładnie raz – dokładanie jeden raz może być na nim wywołana metoda `start()`.

Zwróć uwagę na to, że ciałem wątku jest metoda `run` a do jego uruchomienia niezbędne jest wywołanie metody `start`. Oczywiście możesz uruchomić metodę `run` samodzielnie, jednak nie spowoduje to uruchomienia nowego wątku – kod metody `run` będzie wykonywany w aktualnym wątku.
{:.notice--info}

Wątek, który skończy swoje działanie, przechodzi do stanu `TERMINATED`.

Omówienie stanów `BLOCKED`, `WAITING` i `TIMED_WAITING` wymaga osobnych sekcji. Zanim jednak do tego przejdę szczegółowo omówię przykład, który pokazałem na początku artykułu.

## Omówienie przykładu

Skoro już znasz podstawy teorii związanej z wątkami mogę przejść do omówienia przykładu z początku artykułu. Dla przypomnienia:

```java
public static void main(String[] args) {
    System.out.println("MT start");
    Thread thread = new Thread(() -> {
        System.out.println("T0 start");
        for (int i = 0; i < 5; i++) {
            System.out.println("T0 " + i);
        }
        System.out.println("T0 stop");
    });
    thread.start();
    for (int i = 0; i < 5; i++) {
        System.out.println("MT " + i);
    }
    System.out.println("MT stop");
}
```

Druga linijka metody `main` to utworzenie instancji wątku. W tym przypadku użyłem konstruktora przyjmującego obiekt implementujący interfejs `Runnable`. Ten obiekt utworzyłem przy pomocy [wyrażenia lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}). W ciele tego wyrażenia znajduje się pętla wypisująca liczby.

Kolejna linijka kodu, `thread.start();`, uruchamia wątek. Bez niej kod wewnątrz interfejsu `Runnable` nie zostałby wykonany. Po uruchomieniu wątku znajdziesz kolejną pętlę wypisującą liczby. Powyższy fragment kodu działa w dwóch wątkach:
- wątku o domyślnej nazwie `main`, który tworzony jest automatycznie. Wewnątrz niego uruchomiona jest metoda `main`,
- wątku o domyślnej nazwie `Thread-0`[^nazwa], który utworzyłem i uruchomiłem samodzielnie.

[^nazwa]: Tworząc nowe wątki masz możliwość nadawania im nazw, jeśli tego nie zrobisz dostają domyślną w formacie `Thread-<kolejny numer>`. Masz także możliwość pobrania nazwy aktualnie uruchomionego wątku używając `Thread.currentThread().getName()`.

Kilkukrotne uruchomienie tego kodu pokazuje Ci, że działanie tych dwóch wątków może przeplatać się na różne sposoby.

## Wątek w stanie `BLOCKED`

Wątek, który znajduje się w stanie `BLOCKED` oczekuje na pewien zablokowany zasób. W języku Java blokowanie odbywa się przy pomocy tak zwanych monitorów, które służą do synchronizacji wątków. Zanim powiem Ci jak synchronizować wątki między sobą muszę pokazać Ci dlaczego taka synchronizacja jest czasami niezbędna.

### Dlaczego synchronizacja jest potrzebna?

Wiesz już, że wątki współdzielą przestrzeń adresową. Wspomniałem już, że ma to bardzo istotne konsekwencje. Pokażę Ci je na poniższym przykładzie:

```java
class Counter {
    private int value;

    public void increment() {
        value += 1;
    }

    public int getValue() {
        return value;
    }
}

public class RaceCondition {
    public static void main(String[] args) throws InterruptedException {
        Counter c = new Counter();
        Runnable r = () -> {
            for (int i = 0; i < 100_000; i++) {
                c.increment();
            }
        };

        Thread t1 = new Thread(r);
        Thread t2 = new Thread(r);
        Thread t3 = new Thread(r);

        t1.start();
        t2.start();
        t3.start();

        t1.join();
        t2.join();
        t3.join();

        System.out.println(c.getValue());
    }
}
```

Tutaj nowością dla Ciebie jest metoda [`Thread.join()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#join()). Metoda ta zapewnia, że aktualny wątek czeka na zakończenie się wątku, na którym `join` zostało wywołane. W przykładzie powyżej domyślny wątek `main` czeka na zakończenie się wątku `t1`, jak ten się skończy czeka na zakończenie wątku `t2` i następnie `t3`.

Tutaj drobna dygresja. To, że `main` czeka na wątki w kolejności `t1`, `t2` i `t3` nie oznacza, że te wątki skończą się w tej kolejności. W praktyce kolejność ta może być dowolna, w szczególności może także być odwrotna.
{:.notice--info}

W powyższym fragmencie kodu tworzę obiekt `r`, który implementuje interfejs `Runnable`. Następnie używając tej instancji tworzę trzy wątki, uruchamiam je i czekam na ich zakończenie. `r` używa zmiennej lokalnej `c` typu `Counter`. Używa jej do zwiększenia wartości atrybutu `value` o 100'000.

Skoro są trzy wątki, każdy z nich zwiększa wartość zmiennej o 1 i robi to 100'000 razy to wartość `value` powinna wynosić 300'000, prawda? Spróbuj uruchomić ten kod kilka razy. Jakie wyniki otrzymujesz? W moim przypadku pięć kolejnych uruchomień zwróciło takie wyniki:

	235239
	296424
	300000
	281814
	300000

### Wyścig

To co udało Ci się zaobserwować wyżej to tak zwany wyścig (ang. _race condition_). Taka sytuacja zachodzi jeśli kilka wątków jednocześnie modyfikuje zmienną, która do takiej równoległej zmiany nie jest przystosowana. Tylko dlaczego wartość atrybutu `value` miała tak różne wartości? Działo się tak dlatego, że operacja `value += 1` nie jest operacją atomową.

Tutaj należy Ci się kolejne wyjaśnienie. Operacja atomowa to taka operacja, która jest niepodzielna. Operacja atomowa realizowana jest przy pomocy jednej instrukcji w bytecode (w skompilowanej klasie). Operacja `value += 1` nie jest operacją atomową, jest ona równoważna z `value = value + 1`. Wykonanie tej operacji składa się z kilku kroków:

1. pobrania aktualnej wartości `value` do zmiennej tymczasowej (niewidocznej w kodzie źródłowym)[^stos],
2. dodania `1` do zmiennej tymczasowej,
3. przypisanie powiększonej wartości do `value`.

[^stos]: W rzeczywistości zmienną tymczasową jest stos, na którym ląduje wartość atrybutu.

W bytecode ten fragment wygląda tak:

    GETFIELD pl/samouczekprogramisty/kursjava/treads/Counter.value : I
    ICONST_1
    IADD
    PUTFIELD pl/samouczekprogramisty/kursjava/treads/Counter.value : I

#### Przykład zachowania wątków

Pamiętasz szatkowanie czasu, które opisałem na początku artykułu? Odgrywa ono tu kluczową rolę. Wyobraź sobie sytuację, w której wątek zielony wykonał krok 1., 2. i 3. po czym został wywłaszczony. Następnie wątki niebieski i biały wykonały krok 1. Po czym wątek niebieski wykonał kroki 2. i 3. Po chwili to samo stało się z wątkiem białym. Taką sytuację pokazuje poniższy diagram:

{% include figure image_path="/assets/images/2019/02/11_slicing_time_example.svg" caption="Przykład zachowania wątków" %}

Biorąc pod uwagę takie zachowanie wątków, jaką wartość wątek biały przypisał do `value`? Była to wartość `2`, przez co cała praca wątku niebieskiego została nadpisana. Proszę spójrz na tabelkę niżej, która pokazuje tę sytuację:

| Operacja | Wątek     | Krok | Wartość `value`   | Wartość zmiennej tymczasowej |
|:--------:|-----------|------|-------------------|------------------------------|
| 1.       | zielony   | 1.   | 0                 | 0                            |
| 2.       | zielony   | 2.   | 0                 | 1                            |
| 3.       | zielony   | 3.   | 1                 | 1                            |
| 4.       | niebieski | 1.   | 1                 | 1                            |
| 5.       | biały     | 1.   | 1                 | 1                            |
| 6.       | niebieski | 2.   | 1                 | 2                            |
| 7.       | niebieski | 3.   | 2                 | 2                            |
| 8.       | biały     | 2.   | 2                 | 2                            |
| 9.       | biały     | 3.   | 2                 | 2                            |

Jest to jeden z możliwych scenariuszy. W przykładzie powyżej operacja 9. ustawiają wartość `value` na `2` w wątku białym ignorując zwiększenie wartości wykonane przez wątek niebieski w operacji 7.

Aby uniknąć takich sytuacji, uniknąć wyścigów, niezbędna jest synchronizacja pracy wątków.

### Synchronizacja wątków

Każdy obiekt w języku Java powiązany jest z tak zwanym monitorem. Każdy monitor może być w jednym z dwóch stanów: odblokowany albo zablokowany. Monitor może być zablokowany wyłącznie przez jeden wątek w danym momencie. Dzięki tej właściwości to obiekty używane są do tego, żeby synchronizować wątki ze sobą. Służy do tego słowo kluczowe `synchronized`.

#### Blok `synchronized`

Proszę spójrz na delikatnie zmodyfikowany kod klasy `Counter`:

```java
class Counter {
    private int value;

    public void increment() {
        synchronized (this) {
            value += 1;
        }
    }

    public int getValue() {
        return value;
    }
}
```

Spróbuj jeszcze raz uruchomić `RaceCondition` po wprowadzeniu takiej modyfikacji. Jak z wynikami? Tym razem na pewno za każdym razem na konsoli pokaże się liczba 300'000. Dzieje się tak ponieważ ciało metody `increment` objęte jest blokiem `synchronized`. W tym przypadku obiektem, który został użyty jako monitor jest `this` – instancja `Counter`. Blok `synchronized` ma następujący format:

```java
synchronized (obiekt) {
    // synchronizowany kod
}
```

Masz pewność, że wszystko co znajduje się wewnątrz bloku w każdym momencie uruchomione jest przez maksymalnie jeden wątek.

#### Metoda `synchronized`

Słowo kluczowe `synchronized` może być także użyte w innym kontekście. Może także oznaczyć metody, które są synchronizowane. Na przykład:

```java
public synchronized void increment() {
    value += 1;
}
```

W praktyce obie wersje metody `increment` są równoważne. Oznaczenie metody słowem kluczowym `synchronized` równoznaczne jest w umieszczeniem całego ciała metody w bloku `synchronized`. To jaki obiekt użyty jest w roli monitora zależy od rodzaju metody:

- standardowa metoda – jako monitor użyta jest instancja klasy – `this`,
- metoda statyczna – jako monitor użyta jest klasa.

Na przykład dwa poniższe fragmenty kodu są równoważne:

```java
class Counter {
    public synchronized static void sampleStaticMethod() {
        System.out.println('xxx');
    }
}
```

```java
class Counter {
    public static void sampleStaticMethod() {
        synchronized (Counter.class) {
            System.out.println('xxx');
        }
    }
}
```

#### Nie synchronizuj wszystkiego

Synchronizacja wątków pozwala na uniknięcie wielu problemów związanych na przykład z wyścigami. Niestety ma też swoje słabe strony. Pamiętaj, że cały kod, który jest w bloku `synchronized` w danym momencie może być uruchomiony przez maksymalnie jeden wątek. W związku z tym ten fragment kodu traci możliwość równoczesnego uruchomienia na kilku procesorach – spowalnia wykonanie programu wielowątkowego.

Taki fragment kodu, który w danym momencie może być użyty przez maksymalnie jeden wątek nazywany jest sekcją krytyczną. Dobrą zasadą jest ograniczanie sekcji krytycznej – im mniej w niej kodu tym większy zysk z użycia wielu wątków.

Synchronizacja wątków przy pomocy `synchronized` to nie wszystko. Wszystkie obiekty w języku Java, poza monitorami, zawierają specjalny zbiór wątków (ang. _wait set_). Elementami tego zbioru są wątki, które czekają na powiadomienia dotyczące tego obiektu.

## Wątek w stanie `WAITING`

Jednym ze sposobów aby wątek znalazł się w tym stanie jest wywołanie metody [`Thread.join()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#join()). Wiesz już, że w takim przypadku aktualny wątek czeka na zakończenie swojego kolegi.

Wątek znajdzie się w stanie `WAITING` także jeśli w trakcie jego działania zostanie wywołana metoda [`Object.wait()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#wait())[^pomijam].

[^pomijam]: Pomijam tu trzeci możliwy przypadek – wywołanie metody [`LockSupport.park`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/locks/LockSupport.html#park()).

Na Samouczku Programisty takie lakoniczne wytłumaczenie nie przejdzie ;). Zapraszam Cię do przykładu, opisującego drugą sytuację.

### Komunikacja pomiędzy wątkami

Wyobraź sobie sytuację, w której masz dwa wątki. Jeden produkuje pewne dane, drugi je konsumuje. Tego typu mechanizm jest dość często spotykany. Naiwna implementacja tego typu zachowania może wyglądać tak:

Ten przykład pokazuje złe praktyki, zanim zaczniesz pisać wielowątkowy kod w ten sposób przeczytaj wyjaśnienie poniżej wraz z poprawną wersją implementacji!
{:.notice--warning}

```java
public class NaiveConsumerProducer {
    private static final Random generator = new Random();
    private static final Queue<String> queue = new LinkedList<>();

    public static void main(String[] args) {
        int itemCount = 5;
        Thread producer = new Thread(() -> {
            for (int i = 0; i < itemCount; i++) {
                try {
                    Thread.sleep(Duration.ofSeconds(generator.nextInt(5)).toMillis());
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                synchronized (queue) {
                    queue.add("Item no. " + i);
                }
            }
        });
        Thread consumer = new Thread(() -> {
            int itemsLeft = itemCount;
            while (itemsLeft > 0) {
                String item;
                synchronized (queue) {
                    if (queue.isEmpty()) {
                        continue;
                    }
                    item = queue.poll();
                }
                itemsLeft--;
                System.out.println("Consumer got item: " + item);
            }
        });

        consumer.start();
        producer.start();
    }
}
```

W przykładzie tym użyłem [listy wiązanej]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}) jako kolejki. Obiekt `queue` będzie służył jako narzędzie do wymiany danych pomiędzy wątkami.

#### Producent

Zacznę od wątku produkującego dane:

```java
Thread producer = new Thread(() -> {
    for (int i = 0; i < itemCount; i++) {
        try {
            Thread.sleep(Duration.ofSeconds(generator.nextInt(5)).toMillis());
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        synchronized (queue) {
            queue.add("Item no. " + i);
        }
    }
});
```

W ciele wątku znajduje się pętla, która produkuje zadaną liczbę elementów. Nowością dla Ciebie jest metoda [`Thread.sleep()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#sleep(long)). Służy ona do uśpienia wątku[^timed_wait]. Przekazany parametr mówi o&nbsp;minimalnym czasie, przez który dany wątek będzie uśpiony – nie będzie zajmował czasu procesora. W ten sposób symuluję opóźnienia związane z produkcją elementów. To opóźnienie może być różne dla poszczególnych elementów. Użyłem tu instancji klasy [`Random`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Random.html), żeby to symulować.

[^timed_wait]: Metoda ta sprawia, że wątek jest w stanie `TIMED_WAITING` o czym przeczytasz za chwilę.

Na razie pominę obsługę wyjątku [`InterruptedException`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/InterruptedException.html). Nie jest ona istotna w tym przykładzie, omówię ją dokładnie w jednym z kolejnych akapitów.

Następnie w bloku `synchronized` dodaje nowy element. Zwróć uwagę, że do synchronizacji używam tu obiektu `queue`. Dzięki temu mam pewność, że nie nastąpi wyścig podczas dodawania czy usuwania elementów z kolejki. 

Wątek kończy swoje działanie po wyprodukowaniu wszystkich elementów.

#### Konsument

Wątek konsumujący wyprodukowane elementy wygląda tak:

Ten przykład pokazuje złe praktyki, zanim zaczniesz pisać wielowątkowy kod w ten sposób przeczytaj wyjaśnienie poniżej wraz z poprawną wersją implementacji!
{:.notice--warning}

```java
Thread consumer = new Thread(() -> {
    int itemsLeft = itemCount;
    while (itemsLeft > 0) {
        String item;
        synchronized (queue) {
            if (queue.isEmpty()) {
                continue;
            }
            item = queue.poll();
        }
        itemsLeft--;
        System.out.println("Consumer got item: " + item);
    }
});
```

Wątek konsumujący dane także używa [pętli]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}). Tym razem jest to pętla `while`, która wykonuje się dopóki oczekiwana liczba elementów nie zostanie pobrana z kolejki. Także tutaj wątek używa bloku `synchronized`, w który sprawdza czy elementy są w kolejce i do ewentualnego ich pobrania.

Program działa. Ma jednak pewien subtelny błąd. Zwróć uwagę na wątek konsumenta. Wątek ten działa bez przerwy. Bez przerwy zajmuje czas procesora[^wywlaszczenia]. Co więcej, przez większość swojego czasu kręci się wewnątrz pętli sprawdzając czy kolejka jest pusta. Jako drobne ćwiczenie dla Ciebie zostawiam dodanie licznika iteracji – ile razy pętla wykonała się w Twoim przypadku?

[^wywlaszczenia]: Pomijam wywłaszczenia, które znasz z początku artykułu.

Jak można ten problem rozwiązać? Jednym ze sposobów może być usypianie wątku konsumenta używając metody [`Thread.sleep()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#sleep(long)), którą już znasz. To także byłoby marnowanie zasobów – skąd możesz wiedzieć jak długo zajmie produkowanie kolejnego elementu?

Z pomocą przychodzi mechanizm powiadomień.

### Jak działa mechanizm powiadomień

Wiesz już, że każdy obiekt powiązany jest z monitorem używamy w trakcie synchronizacji. Podobnie wygląda sprawa w przypadku mechanizmu powiadomień. Każdy obiekt w języku Java posiada zbiór   powiadamianych wątków (ang. _waiting set_).

Wewnątrz tego zbioru znajdują się wątki, które czekają na powiadomienie dotyczące danego obiektu. Jedynym sposobem, żeby modyfikować zawartość tego zbioru jest używanie metod dostępnych w klasie `Object`:

- [`Object.wait()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#wait()) – dodanie aktualnego wątku do zbioru powiadamianych wątków,
- [`Object.notify()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notify()) – powiadomienie i wybudzenie jednego z oczekujących wątków,
- [`Object.notifyAll()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notifyAll()) – powiadomienie i wybudzenie wszystkich oczekujących wątków.

#### Poprawny producent

Poprawna wersja producenta używa metody [`notify`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notify()) albo [`notifyAll`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notifyAll()) informując w ten sposób konsumentów o nowym elemencie:

```java
Thread producer = new Thread(() -> {
    for (int i = 0; i < itemCount; i++) {
        try {
            Thread.sleep(Duration.ofSeconds(generator.nextInt(5)).toMillis());
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        synchronized (queue) {
            queue.add("Item no. " + i);
            queue.notify();
        }
    }
});
```

#### Poprawny konsument

Poprawna wersja konsumenta oczekuje pasywnie na informację od producenta o nowym elemencie:

```java
Thread consumer = new Thread(() -> {
    int itemsLeft = itemCount;
    while (itemsLeft > 0) {
        String item;
        synchronized (queue) {
            while (queue.isEmpty()) {
                try {
                    queue.wait();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }
            item = queue.poll();
        }
        itemsLeft--;
        System.out.println("Consumer got item: " + item);
    }
});
``` 

Należy Ci się drobne wyjaśnienie nowego fragmentu:

```java
while (queue.isEmpty()) {
    try {
        queue.wait();
    } catch (InterruptedException e) {
        throw new RuntimeException(e);
    }
}
```

Specyfikacja języka Java pozwala na fałszywe wybudzenia (ang. _spurious wake-ups_). Są to wybudzenia, które mogą wystąpić nawet gdy nie było odpowiadającego im powiadomienia – wywołania metody `notify`. Dlatego właśnie sprawdzenie warunku (`queue.isEmpty()`) musi być wykonane w pętli.

## Wątek w stanie `TIMED_WAITING`

Tym razem będzie krótko ;). Stan `TIMED_WAITING` jest podobny do stanu `WAITING`. W tym przypadku wątek oczekuje przez pewien czas, nie krótszy niż podany jako argument do jednej z metod[^pomijam2]:

[^pomijam2]: Także tutaj pomijam metody z klasy `LockSupport`: [`LockSupport.partNanos`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/locks/LockSupport.html#parkNanos(java.lang.Object,long)) i [`LockSupport.parkUntil`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/locks/LockSupport.html#parkUntil(java.lang.Object,long)).

- [`Object.wait()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#wait(long)) – dodanie aktualnego wątku do zbioru powiadamianych wątków i wybudzenie go po określonym czasie,
- [`Thread.sleep()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#sleep(long)) – wątek wywołujący tę metodę usypia na określony czas,
- [`Thread.join()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#join(long)) – oczekiwanie na zakończenie wątku przez określony czas.

## Przerywanie wątku

W jednym z poprzednich przykładów wspomniałem o wyjątku [`InterruptedException`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/InterruptedException.html). Wyjątek ten sygnalizuje sytuację, w której wątek został przerwany. Wątek może zostać przerwany po wywołaniu na jego instancji metody [`Thread.interrupt`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#interrupt()).

W momencie kiedy wątek zostaje przerwany ustawiana jest na nim specjalna flaga, która o tym informuje.

Jeśli chcesz sprawdzić, czy aktualny wątek jest przerwany możesz wywołać statyczną metodę [`Thread.interrupted`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#interrupted()). Wywołanie tej metody zwraca `true` jeśli wątek był przerwany jednocześnie usuwając flagę, o której wspomniałem przed chwilą.

## Synchronizacja inaczej – `volatile`

Java udostępnia jeszcze jeden mechanizm, który pozwala na synchronizację. Mam tu na myśli słowo kluczowe `volatile`. Specyfikacja języka Java mówi, że każdy odczyt atrybutu poprzedzonego tym słowem kluczowym następuje po jego zapisie. Innymi słowy, modyfikator `volatile` gwarantuje, że każdy wątek czytający dany atrybut zobaczy najnowszą zapisaną wartość tego atrybutu.

Dzięki temu możesz osiągnąć synchronizację wartości danego pola pomiędzy wątkami. Musisz jednak uważać na modyfikacje, które nie są atomowe – przed zmianami tego typu `volatile` niestety Cię nie uchroni. W takim przypadku niezbędna będzie synchronizacja, którą opisałem wcześniej.

Poniższy fragment kodu pokazuje poprawne użycie modyfikatora `volatile`:

```java
public class VolatileExample {
    private static volatile boolean isDone = false;

    public static void main(String[] args) {
        Thread backgroundJob = new Thread(() -> {
            try {
                Thread.sleep(Duration.ofSeconds(2).toMillis());
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            System.out.println("I'm done with my job!");
            isDone = true;
        });
        Thread heavyWorker = new Thread(() -> {
            LocalDateTime start = LocalDateTime.now();
            while (!isDone) {
                // constantly doing some important stuff
            }
            long durationInMillis = ChronoUnit.MILLIS.between(start, LocalDateTime.now());
            System.out.println("I've been notified about finished job after " + durationInMillis + " milliseconds.");
        });

        heavyWorker.start();
        backgroundJob.start();
    }
}
```

W ramach ćwiczenia możesz spróbować uruchomić powyższy kod usuwając modyfikator `volatile` dla pola `isDone`. Jak zachowuje się ten program po takiej modyfikacji?

## Wątki są skomplikowane

Tworzenie programów wielowątkowych jest trudne. Unikanie zakleszczeń, odpowiednia synchronizacja, unikanie wyścigów nie jest trywialne. Nie przejmuj się, jeśli nie zrozumiesz tego zagadnienia od razu. Pisanie wydajnego, bezpiecznego kodu wielowątkowego to coś, z czym nawet bardzo doświadczeni programiści mogą mieć sporo problemów.

Odnajdowanie i naprawianie błędów w programach, które używają wielu wątków to także ciężkie zadanie. Sytuacja, w której kod działa idealnie w trakcie testów, a zachowuje się dziwnie w środowisku wielowątkowym jest czymś powszechnym.

Zanim zaczniesz pisać kod, który ma być wielowątkowo bezpieczny spróbuj znaleźć gotową implementację w pakiecie [`java.util.concurrent`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/package-summary.html). Używając klas z tego pakietu na pewno unikniesz sporo ciężkich do zdiagnozowania błędów.

## Dodatkowe materiały do nauki

Przygotowałem dla Ciebie zestaw linków, które mogą pomóc Ci spojrzeć na temat wątków z innej strony:

- [Tutorial na stronie Oracle'a dotyczący wątków](https://docs.oracle.com/javase/tutorial/essential/concurrency/index.html),
- [Rozdział w Java Language Specification dotyczący wątków](https://docs.oracle.com/javase/specs/jls/se11/html/jls-17.html),
- [Sekcja w Java Language Specification dotycząca metod synchronizowanych](https://docs.oracle.com/javase/specs/jls/se11/html/jls-8.html#jls-8.4.3.6),
- [Sekcja w Java Language Specification dotycząca bloku synchronizowanego]( https://docs.oracle.com/javase/specs/jls/se11/html/jls-14.html#jls-14.19),
- [Artykuł opisujący użycie zmiennych `volatile`](https://www.ibm.com/developerworks/java/library/j-jtp06197/),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/34_watki/src/main/java/pl/samouczekprogramisty/kursjava/treads)

Jeśli znasz źródło, które Twoim zdaniem warte jest uwagi daj znać – dodam je do listy.

## Zadania

Przygotowałem dla Ciebie zadania, które pomogą Ci przećwiczyć wiedzę przedstawioną w artykule w praktyce. Pamiętaj, że zawsze możesz rzucić okiem na [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/34_watki/src/main/java/pl/samouczekprogramisty/kursjava/treads/exercise). Jak zwykle zachęcam Cię do samodzielnej próby rozwiązania tych zadań, w ten sposób nauczysz się najwięcej.

### Przedstaw się

Napisz metodę, która przyjmuje liczbę całkowitą. Wywołanie metody powinno uruchomić wątek 0., wewnątrz tego wątku powinien zostać uruchomiony wątek 1. Wątek 1. powinien uruchomić wątek 2. itd. do osiągnięcia zadanej liczby wątków. Każdy z wątków powinien wypisać na konsolę swoją domyślną nazwę.

Na przykład wywołanie metody:

```java
startNestedThreads(3);
```

Powinno skończyć się uruchomieniem 3 wątków i wypisaniem tekstu na konsolę:

```
Thread-0
Thread-1
Thread-2
```

### Przedstaw się II

Zmodyfikuj program z poprzedniego punktu w taki sposób, aby wątki wypisywały swoją nazwę w kolejności odwrotnej do ich tworzenia. Tzn. wątek uruchomiony jako pierwszy powinien wypisać swoją nazwę jako ostatni. Na przykład wywołanie metody:

```java
startNestedThreads(3);
```

Powinno skończyć się uruchomieniem 3 wątków i wypisaniem tekstu na konsolę:

```
Thread-2
Thread-1
Thread-0
```

### Wielowątkowe `Hello world!`

Napisz program, który uruchomi trzy wątki. Pierwszy z nich będzie wypisywał w pętli ciąg znaków `Hello `, drugi `world`, trzeci `!\n` (wykrzyknik ze znakiem nowej linii). Na przykład:
 
 ```java
Thread t1 = new Thread(() -> {
    for(int i = 0; i < 4; i++) {
        System.out.print("Hello ");
    }
});
t1.start();

Thread t2 = new Thread(() -> {
    for(int i = 0; i < 4; i++) {
        System.out.print("world");
    }
});
t2.start();

Thread t3 = new Thread(() -> {
    for(int i = 0; i < 4; i++) {
        System.out.println("!");
    }
});
t3.start();
```

Uzupełniając powyższy kod o podstawowe mechanizmy synchronizacji wątków spraw, że program po zakończeniu wypisze linijki tekstu zawierające `Hello world!`:

```
Hello world!
Hello world!
Hello world!
Hello world!
```

Czy Twój program nadal będzie dział poprawnie jeśli będzie wypisywał "Hello world!" 10'000 razy?

## Podsumowanie

Po lekturze tego artykułu wiesz czym są wątki. Wiesz jak je tworzyć i uruchamiać. Znasz podstawowe mechanizmy ich synchronizacji. Udało ci się też poznać kilka definicji związanych z programowaniem współbieżnym. Po wykonaniu zadań wiesz, że potrafisz wykorzystać tę wiedzę w praktyce – gratulacje!

Bałem się tego artykułu. Od samego początku pracy nad kursem Javy przesuwałem go w czasie. Teraz, po jego ukończeniu wiem dlaczego ;). Żaden artykuł na blogu nie kosztował mnie tyle pracy. Mam nadzieję, że efekt przypadł Ci do gustu. Proszę podziel się nim z osobami, którym może pomóc. Dzięki temu uda mi się dotrzeć do nowych Czytelników, a na tym właśnie mi zależy – z góry bardzo dziękuję!

Jeśli nie chcesz pominąć kolejnych artykułów dopisz się do samouczkowego newsletter'a i polub Samouczka na Facebook'u. To tyle na dzisiaj, trzymaj się i do następnego razu!
