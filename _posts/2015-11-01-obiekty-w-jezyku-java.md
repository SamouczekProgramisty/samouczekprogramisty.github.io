---
last_modified_at: 2018-11-18 13:09:11 +0100
title: Obiekty w języku Java
categories:
- Kurs programowania Java
- Programowanie
permalink: /obiekty-w-jezyku-java/
header:
    teaser: /assets/images/2015/11/01_obiekty_w_jezyku_java.jpg
    overlay_image: /assets/images/2015/11/01_obiekty_w_jezyku_java.jpg
excerpt: "Czas na kolejny etap kursu programowania języka Java. W dzisiejszym odcinku wystąpią nowi bohaterowie – obiekty i pakiety. Zobaczymy też starych gości: kilka dobrych praktyk i dokładne opisy poparte przykładami. Bez wątpienia przyda się wiedza z poprzednich artykułów. Na końcu jak zwykle czeka na Ciebie ćwiczenie. Do dzieła!"
disqus_page_identifier: 75 http://www.samouczekprogramisty.pl/?p=75
---

{% include kurs-java-notice.md %}

## Pakiet

Programy komputerowe składają się z wielu plików. Przy dużym projekcie składającym się z kilku tysięcy plików kluczowe staje się odpowiednie zarządzanie plikami z kodem źródłowym programu. Bez takiego zarządzania wydajność programisty mocno spada.

Więc czym jest pakiet? Pakiet wraz z nazwą klasy tworzy swego rodzaju “unikalny adres”. Podobnie jak ludzie mają swoje adresy tak klasy mają swoje pakiety, które pomagają zlokalizować klasy w trakcie działania programu.

```java
package pl.samouczekprogramisty.kursjava;
```

Rozbijmy tę linię kodu na części pierwsze:
- `package` – to słowo kluczowe podobnie jak `class` czy `if`, informuje kompilator o tym w jakim pakiecie znajduje się plik,
- `pl.samouczekprogramisty.kursjava` – właściwa nazwa pakietu. Podobnie jak w przypadku omówionego w poprzednim artykule [nazewnictwa metod]({% post_url 2015-10-22-metody-w-jezyku-java %}) tutaj obowiązują podobne zasady. Dla uproszczenia możemy powiedzieć, że dozwolone są małe litery oraz znak kropki.

Istnieje kilka zarezerwowanych nazw pakietów. Służą one do odróżnienia klas dostarczonych wraz z wirtualną maszyną Javy od klas tworzonych przez programistów. Innymi słowy pakiety tworzone przez Ciebie nie mogą zaczynać się od `java.` ani od `javax.`.

Pakiety służą do grupowania klas, [interfejsów]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}), [typów wyliczeniowych]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}) czy [adnotacji]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}). Jeśli czytasz artykuły chronologicznie te terminy prawdopodobnie są dla Ciebie nowe. Nie przejmuj się, opisałem je dokładnie w kolejnych artykułach.

Jak udało Ci się zauważyć nazwy pakietów są specyficzne. Przyjęło się, że za pakiet używa się odwróconej nazwy domeny. Takie podejście pozwala na łatwiejsze uniknięcie konfliktów. W przypadku naszego kursu użyłem `pl.samouczekprogramisty.kursjava`. Istotne jest tutaj odwzorowanie struktury katalogów. Każdy człon pakietu odpowiada katalogowi na dysku.

{% include figure image_path="/assets/images/2015/11/01_kurs_java2_pakiety.png" caption="Pakiety w języku Java" %}

W pliku źródłowym może znajdować się wyłącznie jedna linia z pakietem. Musi znajdować się na początku pliku. Nie jest to linia obowiązkowa, jednak używanie domyślnego pakietu nie jest dobrą praktyką[^pakiet].

[^pakiet]: Jeśli nie umieścisz żadnej deklaracji pakietu, dany typ (klasa, interfejs etc.) zostanie umieszczony w domyślnym, pustym pakiecie.

Nazwy pakietów powinny odwzorowywać ich zawartość. Np pakiet `pl.samouczekprogramisty.animals` mógłby zawierać klasę `Dog`, ale już klasa `Owner` powinna znaleźć się prawdopodobnie w innym miejscu.

{% include newsletter-srodek.md %}

## Klasa

Klasy służą do grupowania atrybutów i metod, pakietów używamy do grupowania klas. Zanim pokażę Ci przykład kodu przejdziemy przez parę funkcji IDE, które na pewno przydadzą się w przyszłości.

### Skróty klawiaturowe

IDE czy zwykły edytor tekstu są narzędziami pracy programisty. Znajomość narzędzi pracy znacząco zwiększa wydajność pracy. Innymi słowy bardzo przydatne jest używanie skrótów klawiaturowych. Postaram się przybliżyć Wam kilka z nich.

Po lewej stronie widzisz okno do przeglądania struktury projektu. To okienko możecie włączać/wyłączać używając skrótu `<Alt + 1>`[^notacja]. Po kliknięciu w obszar tego okienka przyda się skrót `<Alt + Ins>`. W tym kontekście przyda się on do stworzenia nowego pakietu oraz pliku z naszą pierwszą klasą. Po naciśnięciu tego skrótu pokaże się Ci takie okienko.

[^notacja]: Taka notacja oznacza jednoczesne naciśnięcie dwóch klawiszy, w tym przypadku jest to `Alt` i `1`.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_nowy_pakiet.png" caption="Tworzenie pakietu" %}

Gdy mamy już nasz pakiet używając tego samego skrótu możemy stworzyć klasę. W naszym przykładzie stworzyłem pakiet `pl.samouczekprogramisty.kursjava.engine` a w nim klasę `Cogwheel`.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_new_package.png" caption="Tworzenie klasy" %}

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2.nowy_pakiet_dialog.png" caption="Tworzenie pakietu, dialog" %}

```java
package pl.samouczekprogramisty.kursjava.engine;

/**
 * Created by <uzytkownik> on <data>.
 */
public class Cogwheel {
}
```

Podobnie jak poprzednio teraz linijka po linijce przeanalizuję wygenerowany kod. Pierwsza linijka nie jest już dla Ciebie niczym nowym, ot zwykła deklaracja pakietu. Ciekawsze są kolejne linie.

## Komentarze w kodzie

Kolejne 3 linie to komentarz w kodzie. Komentarz w kodzie to dodatkowa wiadomość dla programisty. Czasami dodanie komentarza nad fragmentem bardziej skomplikowanego kodu pomaga w jego zrozumieniu. Komentarz jest pomijany w trakcie wykonywania programu.

W języku Java występują 2 typy komentarzy:

- komentarze w kilku liniach – przykład widzisz powyżej, wszystko co znajduję się pomiędzy `/**` a `*/` traktowane jest jako komentarz.
- komentarz jednoliniowy – wszystko co znajduje się za `//` do końca linii traktowane jest jako komentarz. Parę przykładów pokazałem poniżej:

```java
int count = 3; // number of already read books
// flag indicating if book was read
boolean wasRead = false;
```

## Definicja klasy

Kolejne 2 linijki to już właściwa definicja klasy:

```java
public class Cogwheel {
}
```

Poniżej opiszę każdy z elementów osobno:
- `public` – modyfikator dostępu. Temat [modyfikatorów dostępu]({% post_url 2017-10-29-modyfikatory-dostepu-w-jezyku-java %}) opisałem dokładniej w osobnym artykule. Na tym etapie możesz założyć, że przed klasą stawiamy słowo kluczowe `public` i oznacza ono, że jest ona widoczna dla innych klas,
- `class` – słowo kluczowe informujące kompilator o tym, że ma do czynienia z definicją klasy,
- `Cogwheel` – nazwa klasy. Przyjęło się, że nazwę klasy zaczynamy wielką literą. Podobnie jak w przypadku pakietów nie możesz używać wszystkich znaków. Dla uproszczenia możesz założyć, że nazwa klasy musi zaczynać się wielką literą, później możesz używać wielkich/mały liter bądź cyfr,
- `{}` – para nawiasów określająca tak zwany blok, podobnie jak w metodzie grupuje on kilka instrukcji. Wszystkie linie kodu znajdujące się między nawiasami klamrowymi składają się na pełną definicję klasy.

Poniżej ta sama klasa ale już trochę bardziej rozbudowana

```java
public class Cogwheel {
    private int size;
    private int numberOfCogs;

    public Cogwheel() {
    }

    public Cogwheel(int size, int noCogs) {
        this.size = size;
        numberOfCogs = noCogs;
    }
}
```

Pierwszy nowy element to tak zwany atrybut klasy:

```java
private int size;
```

- `private` – modyfikator dostępu. Tym razem jest to słowo kluczowe `private`. Oznacza tyle, że dany element (w tym przypadku atrybut) dostępny jest wyłącznie z wnętrza danej klasy,
- `int` – znany już typ,
- `size` – nazwa atrybutu. Konwencja nazewnicza zakłada, że nazwy atrybutów piszemy małą literą. Podobnie jak poprzednio w nazwach możemy używać małych liter, wielkich liter i cyfr.

Kolejne dwie metody to tak zwane konstruktory. Zauważ, że ich definicje są specjalne – nie mają typu zwracanego. Konstruktor służy, jak sama nazwa wskazuje, do tworzenia nowych instancji klasy. Każda klasa musi mieć konstruktor. Konstruktory to specjalne metody, które inicjalizują instancje klas.

Konstruktory wywołuje się dokładnie tak samo jak inne metody, dodatkowo używamy słowa kluczowego `new`:

```java
cogwheel = new Cogwheel();
cogwheel = new Cogwheel(1, 2);
```

Pierwszy konstruktor to konstruktor bezparametrowy. Kolejny przyjmuje argument `size` i `noCogs` ale to dla Ciebie nic nowego, o argumentach wiesz wszystko z [artykułu o metodach w języku Java]({% post_url 2015-10-22-metody-w-jezyku-java %}). Nowością tutaj jest ciało konstruktora.

```java
this.size = size;
numberOfCogs = noCogs;
```

Obie linie przypisują wartość do atrybutu klasy. Pierwsza zawiera dodatkowe słowo kluczowe `this` aby odróżnić parametr `size` od atrybutu `size`. W następnej linii widzisz, że `this` nie jest wymagane jeśli jednoznacznie jesteśmy w stanie zidentyfikować atrybut.

## Generowanie konstruktorów

IDE może nam pomóc przy pisaniu konstruktorów. Po naciśnięciu znanego już skrótu `<Alt + Insert>` w edytorze klasy pokaże się takie okienko.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_konstruktor.png" caption="Tworzenie konstruktora" %}

W kolejnym można wybrać atrybuty klasy, które mają być przekazywane jako parametry.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_parametry_konstruktora.png" caption="Wybieranie parametrów konstruktora" %}

Zauważ, że w poprzednim przykładzie klasy `Cogwheel` nie umieściłem definicji żadnego konstruktora. Kilka akapitów wcześniej napisałem, że każda klasa musi mieć konstruktor. Więc jak to właściwie jest z tym konstruktorem? Otóż kompilator tworzy domyślny konstruktor automatycznie jeśli programista nie zdefiniuje żadnego innego konstruktora.

Jeśli utworzysz jakikolwiek inny konstruktor przyjmujący parametry kompilator nie doda domyślnego, bezparametrowego konstruktora.

## Kolejny przykład klasy

Poniżej już troszkę bardziej skomplikowany przykład. Proszę przeczytaj poniższy fragment kodu.

```java
package pl.samouczekprogramisty.kursjava;
 
import pl.samouczekprogramisty.kursjava.engine.Cogwheel;
 
public class Engine {
    private boolean started;
    private Cogwheel cogwheel;
 
    public Engine() {
        cogwheel = new Cogwheel(4, 450);
        started = true;
    }
    public Engine(Cogwheel cogwheel) {
        this.cogwheel = cogwheel;
    }
 
    public void start() {
        started = initiateStartingSequence();
    }
    private boolean initiateStartingSequence() {
        return true;
    }
    public void stop() {
        started = false;
    }
    public boolean isStarted() {
        return started;
    }
    public void setStarted(boolean started) {
        this.started = started;
    }
}
```

Poza używaniem typów, które już znasz, możesz używać już istniejących klas. Właśnie w ten sposób klasa `Engine` ma atrybut typu `Cogwheel`. Zwróć uwagę, że klasa `Engine` znajduje się w innym pakiecie niż klasa `Cogwheel`. Kompilator musi wiedzieć gdzie szukać tej klasy, właśnie z tego powodu dodaje się linijkę importującą tę klasę:

```java
import pl.samouczekprogramisty.kursjava.engine.Cogwheel;
```

> Deklaracja importu to coś zupełnie innego niż deklaracja pakietu, importów w klasie może być wiele (możemy korzystać z wielu innych klas), natomiast nasza klasa może być wyłącznie w jednym pakiecie.
>
> Jeśli importujesz wiele klas z jednego pakietu zamiast wypisywać je wszystkie możemy użyć `*` np `import pl.samouczekprogramisty.kursjava.engine.*;`
Tutaj przychodzi z pomocą IDE. Okazuje się, że programista używający IDE nie musi pisać tych linii, IDE dodaje te linijki automatycznie. IDE także pomaga przy pisaniu samego kodu. W trakcie pisania zobaczysz menu kontekstowe podpowiadające programiście fragmenty kodu. Skrótami klawiaturowymi, które jeszcze mogą przy tym pomóc są `<Ctrl + Space>` i `<Ctrl + Shift + Space>`. Oba z nich pomagają programiście, drugi jest bardziej „inteligenty” podpowiadając wyłącznie kod, który jest poprawny w danym kontekście.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_podpowiadanie.png" caption="Pomoc IDE" %}

### Metody nie zwracające żadnej wartości

Zwróćmy jeszcze uwagę na metodę

```java
public void start() {
    started = initiateStartingSequence();
}
```

Nowe dla Ciebie jest słowo kluczowe `void` w miejscu typu zwracanego. To słowo kluczowe informuje, że dana metoda nie zwraca żadnej wartości. W ciele tej metody do atrybutu `started` przypisuję wartość zwróconą przez metodę `initiateStartingSequence`.

### Słowo kluczowe `this`

Proszę zwróć uwagę na dwa poniższe fragmenty kodu:

```java
public class Engine {
    private Cogwheel cogwheel;

    public Engine(Cogwheel cogwheel) {
        this.cogwheel = cogwheel;
    }
}
```

```java
public class Engine {
    private Cogwheel cogwheel;

    public Engine(Cogwheel otherCogwheel) {
        cogwheel = otherCogwheel;
    }
}
```

W pierwszym przypadku w konstruktorze zostało użyte słowo kluczowe `this`. Było ono potrzebne aby kompilator był w stanie odróżnić parametr `cogwheel` od atrybutu klasy `cogwheel`. W drugim przypadku słowo to nie było konieczne ponieważ w tym kontekście od razu wiadomo czym jest `cogwheel` – jest atrybutem klasy. Oba konstruktory robią dokładnie to samo, przypisują wartość parametru to atrybutu nowej instancji.

## Gettery i settery

Znasz już 2 modyfikatory dostępu, `private` i `public`. Wiesz też, że atrybuty, metody które poprzedzone są modyfikatorem `private` są dostępne wyłącznie w danej klasie. Jak więc z zewnątrz można dowiedzieć się jaka jest wartość atrybutu `started` w instancji klasy `Engine`? Z pomocą przychodzą tak zwane "gettery" i "settery". Jest to nic innego jak specyficzne metody, których jedynym zadaniem jest odpowiednio pobranie bądź ustawienie wartości atrybutu. Poniżej przykłady:

```java
engine = new Engine(); // tworzymy instancje klasy
engine.isStarted(); // zwraca wartość atrybutu
engine.setStarted(true); // ustawia wartość atrybutu started w instancji engine
```

Gettery i settery to metody, których nazwy są określone przez specyfikację [Java Beans](http://www.oracle.com/technetwork/java/javase/documentation/spec-136004.html). W skrócie:
- metody pobierające wartość atrybutu mają nazwę `get` typ zwracany odpowiada typowi atrybutu. Metoda nie przyjmuje żadnego parametru. Specyfikacja dopuszcza pewien wyjątek w nazwie jeśli atrybut jest typu `boolean`. W takim przypadku możemy użyć nazwy `is`, reszta pozostaje bez zmian.

```java
public boolean isStarted() // zwraca wartość atrybutu started
public boolean getStarted() // zwraca wartość atrybutu started
public Cogwheel getCogwheel() // zwraca wartość atrybutu cogwheel
```

- metoda ustawiająca wartość atrybutu. Nową wartością jest parametr przekazany do tej metody. Nazwa metody musi pasować do wzorca `set`. Metoda musi przyjmować jeden parametr odpowiadający typowi atrybutu i nie może zwracać żadnej wartości.

```java
public void setStarted(boolean started) // ustawia wartość atrybutu started
public void setCogwheel(Cogwheel cogwheel) // ustawia wartość atrybutu cogwheel
```

### Generowanie getterów setterów

Podobnie jak w przypadku generowania konstruktorów IDE pomaga w generowaniu getterów/setterów. W edytorze pomaga przy tym skrót `<Alt + Enter>` naciśnięty gdy kursor znajduje się na nazwie atrybutu.

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_wybieranie_parametrow_konstruktora.png" caption="Wybieranie parametrów konstruktora" %}

Metody te można także wygenerować przy pomocy skrótu `<Alt + Insert>` naciśniętego w edytorze i wybraniu opcji "Getter and Setter".

{% include figure image_path="/assets/images/2015/11/01_kurs_java_2_getter_setter.png" caption="Tworzenie getterów i setterów" %}

## Ćwiczenie

Najwyższy czas na Twoje ćwiczenie. W ramach ćwiczenia utwórz nowy projekt, w nim utwórz 2 różne pakiety. W pakietach utwórz klasy odpowiadające kilku rodzajom zwierząt wraz z kilkoma atrybutami. Postaraj się używać przy tym poznanych dzisiaj skrótów. Jeśli chcesz, możesz spojrzeć na przykładowe rozwiązanie, które umieściłem na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/02_obiekty/src/main/java/pl/samouczekprogramisty/kursjava/objects/exercise).

## Podsumowanie

Bardzo się cieszę, że doczytałeś do tego miejsca! Jak poszło Ci z ćwiczeniem? Proszę daj znać w komentarzach. Jeśli podobają Ci się artykuły na blogu byłbym bardzo wdzięczny gdybyś polecił blog swoim znajomym. Jak już powtarzałem – w grupie łatwiej się uczy :) Polub stronę na Facebooku, a nie przegapisz żadnego nowego artykułu. Do zobaczenia!
