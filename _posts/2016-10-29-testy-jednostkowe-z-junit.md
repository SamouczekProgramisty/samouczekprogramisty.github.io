---
title: Testy jednostkowe z JUnit
date: '2016-10-29 10:48:40 +0200'
categories:
- Programista rzemieślnik
permalink: /testy-jednostkowe-z-junit/
header:
    teaser: /assets/images/2016/10/29_testy_jednostkowe_junit_artykul.jpg
    overlay_image: /assets/images/2016/10/29_testy_jednostkowe_junit_artykul.jpg
    caption: "[&copy; andercismo](https://www.flickr.com/photos/andercismo/2349098787/sizes/l)"
excerpt: Artykuł ten poświęcony jest tematyce testów jednostkowych. Po jego przeczytaniu dowiesz się czym są testy jednostkowe i dlaczego są one istotne. Poznasz podstawy biblioteki JUnit i nauczysz się jak jej używać. Dowiesz się czym są testy automatyczne i poznasz klika skrótów klawiaturowych IntliJ Idea pomocnych przy pisaniu testów. Postaram się też pokazać kilka dobrych praktyk dotyczących pisania testów. Na koniec przećwiczysz materiał z tego artykułu rozwiązując zestaw zadań.
disqus_page_identifier: 478 http://www.samouczekprogramisty.pl/?p=478
---

## Po co testujemy oprogramowanie

Oczywista odpowiedź jest prosta – żeby nie było błędów :). Błędy powodują frustrację użytkowników, a to jest coś czego chcemy uniknąć. Ile razy chciałeś rzucić myszką/klawiaturą/laptopem jak coś nie działało jak powinno? Brzmi znajomo? ;)

Wszystkie powody testowania komercyjnego oprogramowania sprowadzają się do pieniędzy. Im wcześniej wykryjemy błąd, tym niższy jest koszt jego naprawienia. Pisanie testów jednostkowych pozwala wykryć błędy w najwcześniejszej możliwej fazie, w trakcie pisania kodu programu. Dlatego każdy porządny programista powinien testować kod, który napisze. Oddając kod do użytku powinien być pewny, że działa jak powinien.

Pojawia się tu jednak pewien problem. Manualne testowanie to żmudna, czasochłonna i mozolna praca. Bardzo tu łatwo o drobne przeoczenie kończące się błędem w programie. Do tego w projektach IT wymagania zmieniają się bardzo często więc takie testy także muszą być bardzo często przeprowadzane.

W związku z tym programiści testują swój kod pisząc testy jednostkowe.

## Czym jest test jednostkowy

Test jednostkowy (ang. _unit test_) to sposób testowania programu, w którym wydzielamy mniejszą jego część, jednostkę i testujemy ją w odosobnieniu. W naszym przypadku taką jednostką do testowania może być pojedyncza klasa czy metoda, którą napiszemy.

Testy jednostkowe można pisać bez bibliotek zewnętrznych jednak jest to uciążliwe. Dodatkowo warto używać istniejących bibliotek ponieważ IDE dobrze integrują się tymi bibliotekami. W tym artykule użyłem biblioteki [JUnit](http://junit.org).

Spójrz na fragment kodu poniżej. Klasa ta reprezentuje zakres liczb, ma ona jedną metodę, która sprawdza czy liczba przekazana jako argument należy do danego zakresu.

```java
public class Range {
    private final long lowerBound;
    private final long upperBound;

    public Range(long lowerBound, long upperBound) {
        this.lowerBound = lowerBound;
        this.upperBound = upperBound;
    }

    public boolean isInRange(long number) {
        return number >= lowerBound && number <= upperBound;
    }
}
```

Poniżej przykład prostego testu jednostkowego, który sprawdza czy, liczba 15 jest w zakresie liczb od 10 do 20.

```java
@Test
public void shouldSayThat15rIsInRange() {
    Range range = new Range(10, 20);
    Assert.assertTrue(range.isInRange(15));
}
```

Test jednostkowy to metoda testująca naszą jednostkę, metodę w innej klasie z dodaną adnotacją [`@Test`](http://junit.org/junit4/javadoc/latest/org/junit/Test.html). `shouldSayThat15IsInRange` jest testem, wewnątrz którego tworzę instancję klasy `Range` i wywołuję metodę sprawdzającą czy 15 jest wewnątrz zakresu.

Wynik tej metody jest przekazywany do metody [`Asssert.assertTrue()`](http://junit.org/junit4/javadoc/latest/org/junit/Assert.html#assertTrue(boolean)), jest to tak zwana asercja. Asercje to metody dostarczone przez bibliotekę JUnit, które pomagają przy testowaniu.

W naszym przykładzie, jeśli metoda `isInRange` zwróci `false`, wówczas asercja `assertTrue` rzuci wyjątek, który przez IDE zostanie zinterpretowany jak test jednostkowy, który pokazuje błąd działania testowanego kodu. Mówimy wówczas, że „test nie przeszedł”, „wywalił się” :).

Testy jednostkowe łączymy w klasy z testami, bardzo często nazywamy je tak samo jak klasy, które testujemy dodając do nich `Test` na końcu. W naszym przypadku klasa z testami dla klasy `Range` nazywa się `RangeTest`.

{% include newsletter-srodek.md %}

### Przykłady użycia asercji

Po co używać asercji? Otóż gotowe asercje tworzą komunikaty błędów (w trakcie testów jednostkowych), które ułatwiają znalezienie błędu. Komunikaty te są bardziej czytelne niż standardowy wyjątek [`AssertionError`](https://docs.oracle.com/javase/8/docs/api/java/lang/AssertionError.html)[^assert].

[^assert]: W języku Java istnieje także słowo kluczowe `assert`, po którym musi wystąpić wartość logiczna, jeśli jest ona fałszem kończy się to rzuceniem wyjątku `AssertionError` – np. `assert false` rzuci wyjątek.

Asercje w bibliotece JUnit to nic innego jak metody statyczne w klasie [`Assert`](http://junit.org/junit4/javadoc/latest/org/junit/Assert.html). Poniżej przedstawię Ci kilka najczęściej stosowanych asercji[^assert_that].

[^assert_that]: Pominę tutaj metodę `assertThat`, którą omówię bardziej szczegółowo w kolejnych artykułach.

- `assertTrue` sprawdza czy przekazany argument to `true`,
- `assertFalse` sprawdza czy przekazany argument to `false`,
- `assertNull` sprawdza czy przekazany argument to `null`,
- `assertNotNull` sprawdza czy przekazany argument nie jest `null`em,
- `assertEquals` przyjmuje dwa parametry wartość oczekiwaną i wartość rzeczywistą, jeśli są różne rzuca wyjątek,
- `assertNotEquals` przyjmuje dwa parametry wartość oczekiwaną i wartość rzeczywistą, rzuci wyjątek jeśli są równe.

### Importy statyczne

Tutaj drobna dygresja, w języku Java musimy importować klasy z innych pakietów, które chcemy użyć w definicji naszej klasy. Poza standardową konstrukcją ze słowem kluczowym `import` istnieją także tak zwane importy statyczne.

Import statyczny pozwala na zaimportowanie metody/wszystkich metod statycznych znajdujących się w definicji jakiejś klasy. Proszę spójrz na przykład poniżej.

```java
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.*;
```

W pierwszej linijce importujemy metodę `assertFalse` z klasy `Assert`, druga linijka to importowanie wszystkich metod statycznych z tej klasy. Dzięki takim importom później w definicji klasy nie musimy używać nazwy klasy używając danej metody statycznej:

```java
assertFalse(false);
assertTrue(true);
```

Z racji tego, że dużo metod pomocniczych (na przykład asercje) w przypadku pisania testów to metody statyczne, bardzo często używamy tam importów statycznych.

### Testowanie metod rzucających wyjątki

Czasami zdarza się, że chcemy przetestować pewną sytuację wyjątkową. Na przykład nie powinniśmy móc utworzyć instancji klasy `Range` z niepoprawnymi argumentami.

```java
public Range(long lowerBound, long upperBound) {
    if (lowerBound > upperBound) {
        throw new IllegalArgumentException("lowerBound is bigger than upperBound!");
    }
    this.lowerBound = lowerBound;
    this.upperBound = upperBound;
}
```

Wywołanie konstruktora w teście z niepoprawnymi argumentami kończyłoby się od razu rzuceniem wyjątku, czyli testem jednostkowym, który nie przeszedł.

Z pomocą w takiej sytuacji przychodzi element `expected` adnotacji `@Test`. Przykład jego użycia widzisz poniżej:

```java
@Test(expected = IllegalArgumentException.class)
public void shouldThrownIllegalArgumentExceptionOnWrongParameters() {
    new Range(20, 10);
}
```

Taki test jednostkowy nie przejdzie jeśli wyjątek nie zostanie rzucony. Mimo tego, że w teście nie ma żadnej asercji testuje on właśnie rzucenie wyjątku.

Istnieje też inny sposób. Możesz go użyć jeśli chcesz mieć dostęp do instancji rzuconego wyjątku. Pokazałem go w przykładzie poniżej:

```java
@Test
public void shouldHaveProperErrorMessage() {
    try {
        new Range(20, 10);
        fail("Exception wasn't thrown!");
    }
    catch (IllegalArgumentException exception) {
        assertEquals("lowerBound is bigger than upperBound!", exception.getMessage());
    }
}
```

Użyta tu statyczna metoda `Assert.fail()` powoduje zakończenie testu niepowodzeniem. Zostanie ona wywołąna wyłącznie jeśli wyjątek nie zostanie rzucony.

### Przygotowanie testów i cykl życia testów

Czasami zdarza się, że kilka testów jednostkowych wymaga pewnego „przygotowania”. Na przykład trzeba utworzyć instancję, którą będziemy później testowali. Twórcy biblioteki JUnit przyszli nam z pomocą. Istnieje adnotacja `@Before`, którą możemy dodać do metody w klasie z testami. Metoda ta zostanie uruchomiona przed każdym testem jednostkowym. Proszę spójrz na przykład poniżej.

```java
public class RangeTest {
    private Range range;
 
    @Before
    public void setUp() {
        range = new Range(10, 20);
    }
 
    @Test
    public void shouldSayThat15rIsInRange() {
        assertTrue(range.isInRange(15));
    }
 
    @Test
    public void shouldSayThat5IsntInRange() {
        assertFalse(range.isInRange(5));
    }
}
```

W naszym przykładzie metoda `setUp` zostanie wywołana przed uruchomieniem każdego z testów. Dzięki temu nie musimy tworzyć instancji wewnątrz testu. Odpowiednie użycie tej adnotacji pomaga pisać krótsze testy jednostkowe.

#### Cykl życia klasy z testami jednostkowymi

Adnotacja `@Before` jest jedną z czterech adnotacji, które pozwalają na wykonanie fragmentów kodu przed/po testach. Pozostałe trzy to:
- `@After` – metoda z tą adnotacją uruchamiana po każdym teście jednostkowym, pozwala na „posprzątanie” po teście,
- `@AfterClass` – metoda statyczna z tą adnotacją uruchamiana jest raz po uruchomieniu wszystkich testów z danej klasy,
- `@BeforeClass` – metoda statyczna z tą adnotacją uruchamiana jest raz przed uruchomieniem pierwszego testu z danej klasy.

Proszę spójrz na przykład poniżej:

```java
public class TestLifecycle {
    @Before
    public void setUp() {
        System.out.println("set up");
        System.out.flush();
    }
 
    @After
    public void tearDown() {
        System.out.println("tear down");
        System.out.flush();
    }
 
    @BeforeClass
    public static void setUpClass() {
        System.out.println("set up class");
        System.out.flush();
    }
 
    @AfterClass
    public static void tearDownClass() {
        System.out.println("tear down class");
        System.out.flush();
    }
 
    @Test
    public void test1() {
        System.out.println("test 1");
        System.out.flush();
    }
 
    @Test
    public void test2() {
        System.out.println("test 2");
        System.out.flush();
    }
}
````

Jeśli uruchomisz tę klasę na konsoli pojawi się:

    set up class
    set up
    test 1
    tear down
    set up
    test 2
    tear down
    tear down class

## Testy jednostkowe a testy automatyczne

Testy jednostkowe bardzo często są testami automatycznymi. Test automatyczny to taki, który możemy wykonywać automatycznie :) Zaletą takiego podejścia jest to, że w momencie zmiany kodu możemy raz napisany test uruchomić ponownie wiedząc od razu czy napisany wcześniej fragment działa poprawnie czy nie. Pomagają przy tym wcześniej omówione asercje.

Bardzo często testy jednostkowe uruchamiane są automatycznie podczas pracy nad projektem. Służą do tego osobne środowiska, w których testy te są uruchamiane.

Istnieją także mechanizmy, które w trakcie pracy programisty wykrywają zmiany w części klas i automatycznie uruchamiają dla tych klas testy jednostkowe informując programistę o wynikach. Dzięki temu bardzo szybko jesteśmy w stanie dowiedzieć się czy zmiany, które wprowadziliśmy nie popsuły wcześniejszej funkcjonalności.

## Dobre praktyki przy pisaniu testów

Poniżej postaram się zebrać dla Ciebie kilka dobrych praktyk, do których warto się stosować w czasie pisania testów:
- Po pierwsze, pisz testy jednostkowe. Koniecznie. Zawsze.
- Staraj się pisać testy jednostkowe, które są małe i dotyczą małego wycinka funkcjonalności. Później o wiele łatwiej jest zrozumieć taki test.
- Nadawaj metodom z testem nazwy, które pomagają zrozumieć co dany test powinien sprawdzić.
- Kolejność testów jednostkowych w klasie nie powinna mieć znaczenia. Innymi słowy nie możemy polegać na tym, że jako pierwszy musi się uruchomić `test1` a po nim `test2`. Testy uruchomione w odwrotnej kolejności także powinny mieć dokładnie taki sam efekt.
- Pisz testy jednostkowe tak, żeby nie zależały na Twojej lokalnej konfiguracji. Na przykład test jednostkowy czytający plik z Twojego dysku z katalogu `C:\mój\katalog\domowy` (czy `/home/uzytkownik`) nie jest dobrym rozwiązaniem.
- Pisz testy jednostkowe niezależne od zewnętrznych systemów. Innymi słowy testuj tylko „jednostkę”, nic ponadto. Jeśli klasa, którą testujesz potrzebuje dostępu np. do bazy danych użyj mocka czy stuba do jej zastąpienia w trakcie testów[^mock] .
- Testuj warunki brzegowe i sytuacje wyjątkowe. Załóżmy, że masz metodę, która przyjmuje tablicę, która musi mieć maksymalnie trzy elementy. Napisz kilka testów:
  - przekazując `null` zamiast tablicy,
  - przekazujac pustą tablicę,
  - przekazujac tablicę z trzema elementami,
  - przekazując tablicę z czterema elementami.

[^mock]: O mockach czy stubach przeczytasz w kolejnych artykułach, jeśli jest to Twoja pierwsza styczność z testami możesz ten punkt pominąć.

Dzięki takim testom będziesz pewien, jak zachowuje się Twoja metoda w sytuacjach wyjątkowych.
- Testowany kod nie powinien być w tym samym miejscu, w którym są testy. Sprowadza się to do tego, że kod umieszczamy w katalogu np. `src`, testy natomiast w katalogu `test`. Oba katalogi pod spodem mają odpowiednią strukturę odzwierciedlającą pakiety. Jest to ważne ponieważ później przy większych projektach testy nie „mieszają się” z kodem programu.
- Staraj się pisać testy, które są szybkie. Przy pierwszych programach nie jest to problemem, jednak przy większych projektach uruchamianie testów może być czasochłonne.
- Uruchamiaj testy jednostkowe możliwie często. Uwierz mi, to Ci się opłaci :). Punkt ten jest powiązany z punktem poprzednim – nie będziesz uruchamiał często testów, które trwają długo.
- Jeśli zauważysz, że część testów jednostkowych wymaga dokładnie takiego samego „przygotowania” wydziel je do osobnej klasy i użyć metod z adnotacją `@Before` lub `@BeforeClass`.


## Testy jednostkowe w IntejiJ Idea

Zacznijmy od utworzenia testu jednostkowego dla istniejącej klasy. Z pomocą przychodzi skrót klawiaturowy `<Ctrl + Shift + T>` – naciśnij tę kombinację na nazwie klasy dla której chcesz utworzyć test. Pokaże się wówczas dialog pomagający utworzyć nową klasę testu.

{% include figure image_path="/assets/images/2016/10/29_nowy_test_dialog.png" caption="Tworzenie nowego testu." %}

InteliJ jest na tyle mądry, że wykrywa brak biblioteki JUnit w projekcie. W oknie dialogowym widać wówczas przycisk „Fix it”, który automatycznie dodaję tę bibliotekę.

{% include figure image_path="/assets/images/2016/10/29_nowy_test_dialog2.png" caption="Tworzenie nowego testu." %}

Kolejnym skrótem klawiaturowym, który może się przydać podczas pisania testów jednostkowych jest `<Alt + Insert>`, naciśnięcie tego skrótu wewnątrz klasy grupującej testy pozwala nam w łatwy sposób stworzyć kolejny test.

{% include figure image_path="/assets/images/2016/10/29_test_generowanie_kodu.png" caption="Generowanie kodu w testach." %}

W końcu kombinacja `<Ctrl + Shift + F10>` pozwala na uruchomienie testów jednostkowych wewnątrz IDE. W zależności od tego na czym znajduje się nasz kursor myszy, ten skrót klawiaturowy może uruchomić pojedynczą metodę z testem, klasę grupującą testy czy pakiet z kilkoma klasami testowymi.

{% include figure image_path="/assets/images/2016/10/29_testy_ok.png" caption="Testy bez błędów." %}

## Zadanie do rozwiązania

Napisz program, który będzie reprezentował koszyk w sklepie internetowym. Do koszyka reprezentowanego przez klasę `Basket` możemy dodawać bądź usuwać kolejne przedmioty. Każdy przedmiot powien mieć nazwę i cenę jednostkową. Koszyk powinien także pozwalać na dodanie/usunięcie od razu kilku egzemplarzy przedmiotu ze sklepu. Koszyk powinien także być w stanie policzyć sumaryczną wartość zamówienia oraz wyświetlić swoją zawartość. Pamiętaj o poprawnym obsłużeniu sytuacji wyjątkowych np. usunięcie elementów z pustego koszyka czy dodaniu ujemej liczby przedmiotów.

Napisz zestaw testów jednostkowych potwierdzających poprawne działanie Twojego koszyka z zakupami.

Drobna podpowiedź z przykładowym zestawem klas, które mogą rozwiązać ten problem:

- `Item`, która posiada dwa atrybuty `double price`[^double] oraz `String name`,
- `Basket`, który posiada atrybut `Map orderedItems` reprezentujący zamówione towary wraz z ich ilością.

[^double]: `double` nie jest dobrym typem do reprezentowania cen, na potrzeby tego przykładu jednak wystarczy. Dlaczego tak się dzieje przeczytasz w osobnym artykule.

Przygotowałem też przykładowe rozwiązanie, znajduje się w [repozytorium na githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/22_testy_jednostkowe/src/main/java/pl/samouczekprogramisty/kursjava/shop/exercise) wraz z zestawem [testów jednostkowych](https://github.com/SamouczekProgramisty/KursJava/tree/master/22_testy_jednostkowe/src/test/java/pl/samouczekprogramisty/kursjava/shop/exercise). Zachęcam jednak do samodzielnej próby rozwiązania zadania. Uwierz mi, że wtedy nauczysz się najwięcej :).

## Dodatkowe materiały do nauki

- [Test jednostkowy na Wikipedii](https://pl.wikipedia.org/wiki/Test_jednostkowy)
- [Strona biltioteki JUnit](http://junit.org)
- [Dokumentacja biblioteki JUnit](http://junit.org/junit4/javadoc/latest/index.html)
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/22_testy_jednostkowe)

## Podsumowanie

W artykule przeczytałeś o testach jednostkowych. Poznałeś zestaw dobrych praktyk dotyczących pisania testów, nauczyłeś się podstaw biblioteki JUnit. Wiesz czym jest test automatyczny i dlaczego takie testy są istotne. Całość przećwiczyłeś w sposób praktyczny rozwiązując zadanie końcowe.

Na koniec mam do Ciebie prośbę. Zależy mi na dotarciu do jak największej liczby czytelników – proszę podziel się linkiem do artykułu ze znajomymi. Jeśli nie chcesz ominąć kolejnych artykułów możesz polubić moją stronę na facebooku ;). Do następnego razu!
