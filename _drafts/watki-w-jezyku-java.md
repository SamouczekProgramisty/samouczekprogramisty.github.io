---
title: Wątki w języku Java
last_modified_at: 2019-02-02 23:18:31 +0100
categories:
- Kurs programowania Java
permalink: /watki-w-jezyku-java/
header:
    teaser: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    caption: "[&copy; Héctor J. Rivas](https://unsplash.com/photos/87hFrPk3V-s)"
excerpt: Artykuł ten opisuje wątki w języku Java. Po jego lekturze dowiesz się czym jest wątek, jaki ma cykl życia i jak go uruchomić. Dowiesz się czym jest synchronizacja i poznasz jej podstawowe mechanizmy. Dowiesz się też jakie mogą być konsekwencje jej braku. Poznasz trzy słowa kluczowe i fragment biblioteki standardowej pomagającej w pisaniu wielowątkowego kodu. Po lekturze tego artykułu będziesz wiedzieć co oznacza wyścig w kontekście programowania wielowątkowego. Na końcu artykułu czeka na Ciebie zadanie, w którym przećwiczysz zdobytą wiedzę.
---

W artykule w zupełności pomijam zagadnienie procesów i zrównoleglania wykonywania zadań przy ich pomocy. Nie poruszam też tematu "event-loop" i przetważania asynchronicznego, które niejako związane są z wątkami.
{:.notice--info}

## Stwórz swój pierwszy wątek

Zacznę od przykładu. Poniższy fragment kodu tworzy nowy wątek. Wewnątrz tego wątku znajduje się pętla, która wypisuje wszystkie liczby od 0 do 4, po czym kończy swoje działanie. Dokładnie taka sama pętla znajduje się w wątku gównym:

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

## Wątki na obrazkach

### Program bez wątków

Wyobraź sobie problem, którego rozwiązanie wymaga wykonania trzech zadań. Udało Ci się napisać program, który ten problem rozwiązuje. Uruchamiasz ten program na komputerze. Każde z zadań uruchamiane jest po zakończeniu poprzedniego. Na diagramie może wyglądać to tak:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks.svg" caption="Trzy zadania uruchomione sekwencyjne na jednym procesorze." %}

Gwiazdka reprezentuje rdzeń procesora. Różnokolorowe prostokąciki reprezentują trzy zadania do wykonania. Długość prostokącików reprezentuje czas trwania poszczególnych zadań. Zadania uruchamiane są po kolei. Po tym jak skończy się zadanie zielone rozpoczyna się zadanie niebieskie. Można powiedzieć, że zadania uruchamiane są sekwencyjnie. 

### Program wielowątkowy

Przed procesorami wielordzeniowymi wątki były "oszustwem". Procesor był jeden, mógł pracować wyłącznie nad jednym zadaniem. Wymyślono jednak inne rozwiązanie.

#### Szatkowanie czasu :)

Mam na myśli _time slicing_. Mechanizm dzięki, któremu jeden rdzeń procesora może uruchamiać wiele wątków. Nie dzieje się to jednak równolegle.

Diagram poniżej prezentuje dokładnie te same zadania. Tym razem każde z nich uruchamiane jest w osobnym wątku, mamy zatem trzy wątki. Mechanizm nadzorujący ich pracę zapewnia, że co jakiś czas aktualny wątek zostanie zatrzymany. Kolejny wątek zostaje wybudzony, dostaje czas procesora i jest przez niego wykonywany. Suma długości prostokącików w danym kolorze jest dokładnie taka sama jak w poprzednim przykładzie:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks_threads.svg" caption="Trzy zadania uruchomione w wątkach na jednym procesorze." %}

Takie podejście ma swoje zalety, jednak nie prowadzi do krótszego czasu działania programu. Wręcz przeciwnie, zatrzymywanie i wybudzanie wątków zajmuje czas. Proszę spójrz na diagram poniżej, który pokazuje czas trwania obu podejść:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_tasks_threads_comparison.svg" caption="Porównanie czasu trwania dwóch podejść na jednym procesorze." %}

Po co zatem stosować takie podejście? Najważniejszym argumentem jest to, że w tym przypadku każde z zadań jest delikatnie popychane do przodu. Wyobraź sobie inną sytuację. Załóżmy, że dwa zadania zajmują wyraźnie mniej czasu niż pierwsze z nich:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_uneven_tasks.svg" %}

W takim przypadku zadania niebieskie i białe muszą czekać na zakończenie zadania zielonego. Zastosowanie wątków w tym przypadku może prowadzić do dużo szybszego zakończenia zadań niebieskiego i białego (chociaż nadal sumaryczny czas, wraz z przełączeniami wątków, będzie dłuższy):

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_1_cpu_3_uneven_tasks_threads.svg" %}

"Szatkowanie czasu" daje wrażenie równoległej pracy wielu wątków, jednak w rzeczywistości w danym momencie tylko jedno zadanie jest uruchomione. Inaczej wygląda sytuacja w przypadku procesorów mających wiele rdzeni.

#### Procesory wielordzeniowe

Procesory wielordzeniowe dają rzeczywistą możliwość uruchamiania wielu zadań równolegle. W takim przypadku, jeśli każde z zadań uruchomione zostanie w osobnym wątku wówczas sytuacja wygląda jak na diagramie poniżej[^cztery]:

[^cztery]: Możesz założyć, że program został uruchomiony na procesorze czterordzeniowym. Czwarty rdzeń nie był uwzglęniony na diagramie.

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_3_cpu_3_tasks_threads.svg" %}

Uruchomienie programu bez wątków na komputerze z procesorem wielordzeniowym nie przyspieszyłoby jego działania – jeden rdzeń sekwencyjnie realizowałby każde z zadań.

#### Połączenie obu podejść

W rzeczywistości spotkasz się połączeniem obu podejść[^rdzenie]. Proszę spójrz na diagram poniżej. Pokazuje on przykładowe wykonanie zadania na dwóch rdzeniach. Dla porównania pokazałem też sekwencyjne wykonanie tych samych zadań:

[^rdzenie]: Raczej małoprawdopodobne jest to, że masz komputer, który ma tylko jeden rdzeń procesora.

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/02/03_2_cpu_3_tasks_threads_comparison.svg" caption="Trzy zadania uruchomione w wątkach na dwóch procesorach." %}

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

Drugim sposobem jest utworzenie wątku, używając konstruktora, który przyjmuje obiekt implementujący interfejs [`Runnable`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Runnable.html):

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
Trhread thread = new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("I'm inside runnable!");
    }
});
```

Interfejs `Runnable` jest [interfejsem funkcyjnym]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}#interfejs-funkcyjny). W związku z tym zapis ten można uprościć stosując [wyrażenia lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}#interfejs-funkcyjny)

```java
Trhread thread = new Thread(() -> System.out.println("I'm inside runnable!"));
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

Wątek, który skończy swoje działanie, przechodzi do stanu `TERMINATED`.

Omówienie stanów `BLOCKED`, `WAITING` i `TIMED_WAITING` wymaga osobnych sekcji. Zanim jednak do tego przejdę szczegółowo omówię przykład, który pokazałem na początku artykułu.

## Omówienie przykładu

Skoro już znasz podstawy teorii związanej z wątkami mogę przejść do omówienia przykładu z początku artykułu. Dla przypomnienia poniżej znajdziesz kod:

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

Druga linijka metody `main` to utworzenie instancji wątku. W tym przypadku użyłem konstruktora przyjmującego obiekt implementujący interfejs `Runnable`. Ten obiekt utworzyłem przy pomocy wyrażenia lambda. W ciele tego wyrażenia znajduje się pętla wypisująca liczby.

Kolejna linijka kodu, `thread.start();`, uruchamia wątek. Bez niej kod wewnątrz interfejsu `Runnable` nie zostałby wykonany. Po uruchomienu wątku znajdziesz kolejną pętlę wypisującą liczby. Powyższy fragment kodu działa w dwóch wątkach: 
- wątku o domyślnej nazwie `main`, który tworzony jest automatycznie. Wewnątrz niego uruchomiona jest metoda `main`, 
- wątku o domyślnej nazwie `Thread-0`[^nazwa], który utworzyłem i uruchomiłem samodzielnie.

[^nazwa]: Tworząc nowe wątki masz możliwość nadawania im nazw, jeśli tego nie zrobisz dostają domyślną w formacie `Thread-<kolejny numer>`. Masz także możliwość pobrania nazwy aktualnie uruchomionego wątku używając `Thread.currentThread().getName()`.

Kilkukrotne uruchomienie tego kodu pokazuje Ci, że działanie tych dwóch wątków może przeplatać się na różne sposoby.

## Wątek w stanie `BLOCKED`


### Synchronizacja wątków


## Wątek w stanie `WAITING`

### `Object.wait()`

## Do czego służą wątki

- synchronized
- wyścig
- synchronize
- thread
- deadlock, lifelock
- threadpool
- thread vs process
- thread vs cpu
- cykl życia
- volatile
- atomowość

### Wykorzystanie 


## 

Załóżmy, że masz napisać program, który sprawdzi czy w którymkolwiek pliku w katalogu występuje słowo "Samouczek". Dla uproszczenia przyjmę, że przeszukanie jednego pliku trwa jedną sekundę. 

Katalog, który masz przeszukać ma 10'000 plików. Sprawdzanie wszystkich plików po kolej potrwa 10'000 sekund, czyli ponad 2 godziny i 46 minut. Długo, chcesz to przyspieszyć.

Z pomocą mogą przyjść wątki. Załóżmy, że Twój komputer ma procesor, który ma 32 rdzenie i uruchomisz 32 wątki, które równocześnie przeszukują pliki. Dzięki temu czas przeszukiwania może być do 32 razy krótszy. Dzięki temu Twój program sprawdzi wszystkie pliki dużo szybciej. Przy takim podejściu sprawdzenie wszystkich plików potrwa niewiele ponad 5 minut.

## Synchronizacja

Wyobraź sobie pętlę. Pętla ma za zadanie operować na wartości licznika reprezentowanego przez obiekt `Counter`. Pętla wygląda tak:

```java

```

Jaką wartość będzie miał

## Wątki są trudne

Tworzenie programów wielowątkowych jest trudne. Unikanie zakleszczeń, odpowiednia synchronizacja, unikanie wyścigów nie jest trywialne. Nie przejmuj się, jeśli nie zrozumiesz tego zagadnienia od razu. Pisanie wydajnego, bezpiecznego kodu wielowątkowego to coś, z czym nawet bardzo doświadczeni programiści mogą mieć sporo problemów.

Odnajdowanie i naprawianie błędów w programach, które używają wielu wątków to także ciężkie zadanie. Sytuacja, w której kod działa idealnie w trakcie testów, a zachowuje się "dziwnie" w środowisku wielowątkowym jest czymś powszechnym.

Zanim zaczniesz pisać kod, który ma być wielowątkowo bezpieczny spróbuj znaleźć gotową implementację w pakiecie [`java.util.concurrent`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/package-summary.html). Używając klas z tego pakietu na pewno unikniesz sporo ciężkich do zdiagnozowania błędów.

## Dodatkowe materiały do nauki

- [Rozdział w Java Language Specification dotyczący wątków](https://docs.oracle.com/javase/specs/jls/se11/html/jls-17.html),
- [Sekcja w Java Language Specification dotycząca metod synchronizowanych](https://docs.oracle.com/javase/specs/jls/se11/html/jls-8.html#jls-8.4.3.6),
- [Sekcja w Java Language Specification dotycząca bloku synchronizowanego]( https://docs.oracle.com/javase/specs/jls/se11/html/jls-14.html#jls-14.19),

## Ćwiczenie

## Podsumowanie

Bałem się tego artykułu. Od samego początku pracy nad kursem Javy przesuwałem go w czasie. Teraz, po jego ukończeniu wiem dlaczego ;).

