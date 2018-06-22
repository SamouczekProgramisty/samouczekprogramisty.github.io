---
title: Wyjątki w języku Java
date: '2016-01-31 12:02:17 +0100'
categories:
- Kurs programowania Java
permalink: /wyjatki-w-jezyku-java/
header:
    teaser: /assets/images/2016/01/31_wyjatki_w_jezyku_java_artykul.jpeg
    overlay_image: /assets/images/2016/01/31_wyjatki_w_jezyku_java_artykul.jpeg
    caption: "[&copy; Marcin Pietraszek ;)](http://marcin.pietraszek.pl)"
excerpt: "Tylko ten nie popełnia błędów, kto nic nie robi. My dzisiaj będziemy popełniać błędy i będziemy starali się je poprawiać. Przekładając to co powiedział Napoleon na kontekst programowania w artykule przeczytasz o wyjątkach w języku Java i ich obsłudze.

Dowiesz się czym jest wyjątek i jaką rolę pełni w programowaniu. Dowiesz się kiedy powinniśmy używać wyjątków. Postaram się też przekazać Ci kilka dobrych praktyk związanych z używaniem w wyjątków. Zaczynamy! :)"
disqus_page_identifier: 207 http://www.samouczekprogramisty.pl/?p=207
---

{% include kurs-java-notice.md %}

## Czym jest wyjątek?

Wyjątek (ang. _exception_) jest specjalną klasą. Jest ona specyficzna ponieważ w swoim łańcuchu dziedziczenia ma klasę `java.lang.Throwable`. Instancje, które w swojej hierarchii dziedziczenia mają tą klasę mogą zostać „rzucone” (ang. _throw_) przerywając standardowe wykonanie programu.

Przykładem może być tutaj walidacja argumentów metody. Załóżmy, że nasza metoda jako argument przyjmuje liczbę godzin i zwraca liczbę sekund, odpowiadających przekazanemu argumentowi. Możemy założyć, że akceptujemy wyłącznie argumenty dodatnie lub 0.

Innymi słowy jeśli metoda zostanie wywołana z argumentem mniejszym od 0 możemy uznać to za nieprawidłowe wywołanie i zasygnalizować taką sytuację rzucając wyjątek.

```java
public int getNumberOfSeconds(int hour) {
    if (hour < 0) {
        throw new IllegalArgumentException("Hour must be >= 0: " + hour);
    }
    return hour * 60 * 60;
}
```

W przykładzie powyżej użyliśmy wyjątku występującego w standardowej bibliotece języka Java: `java.lang.IllegalArgumentException`. Do rzucania wyjątku używamy słowa kluczowego `throw`.

{% include newsletter-srodek.md %}

### Co się dzieje po rzuceniu wyjątku?

Wyobraź sobie kilka metod, które wywołują siebie nawzajem. Te kilka wywołań nazywamy stosem wywołań. Proszę zwróć uwagę na przykład poniżej:

```java
package pl.samouczekprogramisty.kursjava.exception;

public class StackTraceExample {
    public static void main(String[] args) {
        StackTraceExample example = new StackTraceExample();
        example.method1();
    }

    public void method1() {
        method2();
    }

    public void method2() {
        method3();
    }

    public void method3() {
        throw new RuntimeException("BUM! BUM! BUM!");
    }
}
```

W naszym przykładzie w metodzie `main` tworzymy instancję klasy `StackTraceExample` i na instancji wywołujemy metodę `method1`, metoda ta wywołuje z kolei metodę `method2`. `method2` wywołuje `method3`, która rzuca wyjątek `java.lang.RuntimeException` (kolejny wyjątek z biblioteki standardowej).

Tą listę metod wywołujących siebie nawzajem nazywamy stosem wywołań. W naszym przypadku stos wygląda następująco:

1. `main`
2. `method1`
3. `method2`
4. `method3`

A co stanie się po uruchomieniu tego programu? Oczywiście zostanie rzucony wyjątek, a programista zobaczy stos wywołań metod (ang. _stacktrace_), jak w przykładzie poniżej:

    Exception in thread "main" java.lang.RuntimeException: BUM! BUM! BUM!
        at pl.samouczekprogramisty.kursjava.exception.StackTraceExample.method3(StackTraceExample.java:18)
        at pl.samouczekprogramisty.kursjava.exception.StackTraceExample.method2(StackTraceExample.java:14)
        at pl.samouczekprogramisty.kursjava.exception.StackTraceExample.method1(StackTraceExample.java:10)
        at pl.samouczekprogramisty.kursjava.exception.StackTraceExample.main(StackTraceExample.java:6)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at com.intellij.rt.execution.application.AppMain.main(AppMain.java:140)

W pracy programisty umiejętność czytania tego typu komunikatów jest bardzo istotna. Dzisiaj stacktrace widzisz pierwszy raz, zapewniam Cię, że zobaczysz go jeszcze dużo razy ;)

### Zrozumieć _stacktrace_

Proszę zwróć uwagę na stos wywołań metod, który wspomniałem wyżej i porównaj go ze stacktrace'em. Widzisz pewną zależność? Dokładnie – stacktrace to nic innego jak odwrócony stos wywołań metod od rozpoczęcia programu do miejsca w którym został rzucony wyjątek.

Pierwsza linijka mówi o tym jaki wyjątek został rzucony, kolejne linijki to metody, które były wywoływane. Każda linia składa się z nazwy klasy wraz z pakietem, w nawiasach znajduje się nazwa pliku oddzielona dwukropkiem od numeru linii w tym pliku. W naszym przypadku wyjątek `RuntimeException` został rzucony po wywołaniu metody `pl.samouczekprogramisty.kursjava.exception.StackTraceExample.method3`, która znajduje się w 18 linijce pliku&nbsp;`StackTraceExample.java`.

Ostatnie linijki także pokazują na kod programu, jednak ten nie jest już napisany prze mnie. Program powyżej uruchamiałem z IDE i to właśnie przez InteliJ stacktrace zawiera te 5 dodatkowych linijek.

## Obsługa wyjątków

Już wiesz jak można rzucić wyjątek. Najwyższy czas zacząć je obsługiwać :) Mówimy, że wyjątek jest obsługiwany, jeśli reagujemy na jego wystąpienie i próbujemy "naprawić" program w trakcie jego działania. Możemy też powiedzieć, że łapiemy wyjątek.

Do obsługi wyjątków służy blok `try`/`catch`. Proszę spójrz na przykład poniżej:

```java
int hours = -3;
int numberOfSeconds = 0;
try {
    numberOfSeconds = instance.getNumberOfSeconds(hours);
}
catch (IllegalArgumentException exception) {
    numberOfSeconds = instance.getNumberOfSeconds(hours * -1);
}
System.out.println(numberOfSeconds);
```

Znasz już metodę `getNumberOfSeconds`. Wiesz, że rzuca wyjątek `IllegalArgumentException` jeśli argument jest mniejszy od 0. W przykładzie powyżej otaczamy wywołanie metody blokiem `try {…} catch`. Jeśli kod wewnątrz nawiasów `{ }` rzuci wyjątek i blok `catch` będzie obsługiwał ten typ wyjątku wówczas zostanie wywołany kod w bloku `catch` i wyjątek nie przerwie działania programu.

W przykładzie powyżej pierwsze wywołanie metody rzuci wyjątek ponieważ przekazaliśmy `-3` jako argument. Rzucony wyjątek jest obsługiwany przez klauzulę `catch` (klasa wyjątku "pasuje") więc zostaje wywołany kod wewnątrz bloku.

Pod blokiem `try` może znajdować się wiele bloków `catch`. Pierwszy pasujący zostanie wykonany. Rzucony wyjątek może być obsłużony przez dany blok `catch` jeśli klasa wyjątku w `()` znajduje się w hierarchii dziedziczenia rzuconego wyjątku. Nie jest to skomplikowane, zdecydowanie łatwiej wygląda to na przykładzie

```java
try {
    throw new IllegalArgumentException();
}
catch (ArithmeticException exception) {
    // 1
}
catch (RuntimeException exception) {
    // 2
}
catch (Exception exception) {
    // 3
}
```

Blok `catch` 1 nie zostanie wykonany bo `ArithmeticException` nie znajduje się w hierarchii dziedziczenia wyjątku `IllegalArgumentException`. Blok `catch` 2 zostanie wykonany bo `IllegalArgumentException` dziedziczy po `RuntimeException`. Następny blok nie zostanie wykonany ponieważ w przypadku obsługi wyjątku pierwszy pasujący blok `catch` jest wykonywany jako jedyny.

### Obsługa kilku rodzajów wyjątków w jednym bloku `catch`

Może zdarzyć się sytuacja, w której chciałbyś obsłużyć kilka wyjątków a nie mają one wspólnej klasy bazowej. Wówczas w nawiasach po `catch` możesz oddzielić klasy wyjątków symbolem `|` jak w przykładzie poniżej.

```java
try {
    someMagicMethod();
}
catch (ArithmeticException | IllegalArgumentException exception) { 
    // handle exception
}
```

## Rodzaje wyjątków _checked_ oraz _unchecked_

Każdy wyjątek w języku Java dziedziczy po klasie `Throwable`. Wyróżniamy dwa rodzaje wyjątków, tak zwane _"checked exceptions"_ oraz _"unchecked exceptions"_. Różnica między nimi sprowadza się do tego, że te pierwsze muszą być obsłużone przez programistę, wymaga tego kompilator. Przykładowym wyjątkiem typu unchecked jest `IllegalArgumentException`, natomiast `IOException` jest wyjątkiem typu checked.

{% include figure image_path="/assets/images/2016/01/31_wyjatki.gif" caption="Hierarchia dziedziczenia wyjątków" %}

Reguła podziału wyjątków na te dwa rodzaje jest prosta. Jeśli wyjątek w swojej hierarchii dziedziczenia ma `Exception` i nie ma `RuntimeException` jest wyjątkiem typu checked. W każdym innym przypadku jest to wyjątek typu unchecked.

Kiedy zatem stosować wyjątki typu checked? Zalecenie jest proste, za każdym razem kiedy program ma możliwość "naprawienia" zaistniałej sytuacji wyjątkowej powinniśmy rzucić wyjątek typu checked. Reguła ta jednak jest bardzo często łamana ponieważ obsługa tego typu wyjątków wymaga trochę więcej kodu ;)

## Klauzula `throws`

Wyjątek można obsłużyć na dwa sposoby. Jeden już znasz, to otoczenie fragmentu kodu blokami `try/catch`. Drugi sprowadza się do "zepchnięcia" odpowiedzialności obsłużenia wyjątku o poziom niżej, do metody wywołującej. Służy do tego klauzula `throws`, którą dodajemy do deklaracji metody. Spójrz na przykład poniżej:

```java
public class CheckedExceptions {
    public static void main(String[] args) {
        CheckedExceptions instance = new CheckedExceptions();
        try {
            instance.methodWithCheckedException();
        } 
        catch (IOException e) {
            e.printStackTrace();
        }
    }
 
    private void methodWithCheckedException() throws IOException {
        throw new IOException();
    }
}
```

Metoda `methodWithCheckedException` rzuca wyjątek `IOException`, który jest typu checked. Nie obsługuje go jednak wewnątrz ale informuje o tym, że może rzucić taki wyjątek dzięki `throws`. W metodzie `main` mamy standardowy blok `catch`, gdzie wyjątek jest obsłużony.

## Klauzula `finally`

Blok `finally` możemy umieścić po `try`. Kod wewnątrz tego bloku zawsze zostanie wykonany[^wyjatek]. W rzeczywistości blok `try` nie musi mieć żadnej klauzuli `catch` jeśli ma blok `finally`.

[^wyjatek]: Są pewne sytuacje kiedy to nie jest prawdą, np. jeśli wirtualna maszyna Javy zostanie wyłączona.

```java
try {
    throw new RuntimeException();
}
finally {
    System.out.println("Surprise!");
}
```

Może być także sytuacja w której mamy zarówno `try`, `catch` jak i `finally`. Jeśli wewnątrz try zostanie rzucony wyjątek, który jest obsługiwany przez blok `catch` to dodatkowo, jako ostatni, uruchomi się blok `finally`.

## Dobre praktyki przy używaniu wyjątków

Poniżej zebrałem dla Ciebie zestaw kilku dobrych praktyk przy pracy z wyjątkami:
- Pierwsza i najważniejsza zasada, blok `try` powinien być jak najmniejszy. Takie podejście bardzo ułatwia znajdowanie błędów w bardziej skomplikowanych programach. Dzięki małemu blokowi `try` także możemy napisać lepszy kod do obsługi wyjątku – wiemy dokładnie z którego miejsca wyjątek może zostać rzucony więc wiemy także jak najlepiej na niego zareagować.
- Blok `finally` bardzo często jest niezbędny. Szczególnie jeśli operujemy na instancjach, które wymagają "zamknięcia".
- Używaj klas wyjątków, które idealnie pasują do danej sytuacji. Jeśli nie ma takiego wyjątku w bibliotece standardowej utwórz własną klasę wyjątku.
- Tworząc instancję wyjątków podawaj możliwie najdokładniejszy opis w treści wyjątku. Pozwala to na dużo łatwiejsze znajdowanie błędów w programie jeśli komunikat wyjątku jest szczegółowy.
- Nie zapominaj o używaniu wyjątków typu checked. Chociaż wymagają trochę więcej kodu i generują często irytujące błędy kompilacji ich używanie jest czasami wskazane.

## Zadanie

Napisz program, który pobierze od użytkownika liczbę i wyświetli jej pierwiastek. Do obliczenia pierwiastka możesz użyć istniejącej metody `java.lang.Math.sqrt()`. Jeśli użytkownik poda liczbę ujemną rzuć wyjątek `java.lang.IllegalArgumentException`. Obsłuż sytuację, w której użytkownik poda ciąg znaków, który nie jest liczbą.

Zachęcam do samodzielnego rozwiązania zadania, jeśli rozwiązujesz zadanie samodzielnie uczysz się najwięcej. Jeśli jednak chciałbyś zobaczyć przykładowe rozwiązanie, to umieściłem je na [githubie](https://github.com/SamouczekProgramisty/KursJava/blob/master/09_wyjatki/src/main/java/pl/samouczekprogramisty/kursjava/exception/exercise/Exercise.java).

## Dodatkowe materiały do nauki

- [http://docs.oracle.com/javase/tutorial/essential/exceptions/index.html](http://docs.oracle.com/javase/tutorial/essential/exceptions/index.html)
- [https://docs.oracle.com/javase/specs/jls/se8/html/jls-11.html](https://docs.oracle.com/javase/specs/jls/se8/html/jls-11.html)
- [https://www.youtube.com/watch?v=Nl16BzP6Fao](https://www.youtube.com/watch?v=Nl16BzP6Fao)
- [kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/09_wyjatki/src/main/java/pl/samouczekprogramisty/kursjava/exception)

## Podsumowanie

Bardzo się cieszę, że dobrnąłeś tak daleko. Mam nadzieję, że artykuł przypadł Ci do gustu. Na koniec mam do Ciebie prośbę, podziel się artykułem ze swoimi znajomymi, którzy mogą być zainteresowani tym tematem. Niezmiennie zależy mi na tym, żeby dotrzeć do jak największej grupy czytelników :) Jeśli nie chcesz ominąć kolejnych artykułów polub nasz profil na facebooku i dopisz się do newslettera.

Do następnego razu i życzę Ci udanego dnia :)
