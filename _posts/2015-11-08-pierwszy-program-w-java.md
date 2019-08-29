---
last_modified_at: 2018-08-20 16:31:08 +0200
title: Pierwszy program w Java
categories:
- Kurs programowania Java
permalink: /pierwszy-program-w-java/
header:
    teaser: /assets/images/2015/11/08_pierwszy_program_w_java.png
    overlay_image: /assets/images/2015/11/08_pierwszy_program_w_java.png
excerpt: Dzisiaj napiszesz i uruchomisz swój pierwszy program. Przy okazji dowiesz się czym jest biblioteka standardowa i co się w niej znajduje. Poznasz klasę String z biblioteki standardowej. Dowiesz się też o paru nowych funkcjach IDE. Jak zwykle wszystko zakończymy przykładowym zadaniem do wykonania. Do dzieła!
disqus_page_identifier: 138 http://www.samouczekprogramisty.pl/?p=138
---

{% include kurs-java-notice.md %}

## Zaczynamy!

Zaczynamy z grubej rury, bez patyczkowania się:

- otwórz IDE,
- utwórz nowy projekt,
- utwórz nowy pakiet (`Alt + Insert`),
- utwórz nową klasę (`Alt + Insert`).
  
To już znasz, teraz czas na nowe rzeczy. Wszystkie elementy zostały opisane w poprzednich artykułach z cyklu:
1. [Kurs programowania Java – przygotowanie środowiska]({% post_url 2015-10-18-przygotowanie-srodowiska-programisty %})
2. [Kurs programowania Java – metody]({% post_url 2015-10-22-metody-w-jezyku-java %})
3. [Kurs programowania Java – obiekty i pakiety]({% post_url 2015-11-01-obiekty-w-jezyku-java %})

## Live templates
  
W ciele klasy, która została stworzona w poprzednim punkcie naciśnij `Ctrl + J`. Pokaże się okienko z podpowiedziami. To jest bardzo przydatna funkcja IDE pozwalająca bardzo szybki sposób pisać kod programiście.

Z okienka, które się pokazało wybierz `psvm`. Bum! Cała metoda już "się napisała" :) Teraz w edytorze wpisz `sout` i naciśnij Enter. Bum! Znów cała linijka jest gotowa. Napisaliśmy tylko kilka znaków, a całe ciało metody zostało stworzone za nas.

Poprzednie dwa akapity to nic innego jak funkcja _Live templates_ IDE (dosłownie przetłumaczyć można to na żywe szablony). W trakcie kursu będziemy poznawali kolejne szablony pomagające w pisaniu kodu.

{% include figure image_path="/assets/images/2015/11/08_kurs_5_ctrlj.png" caption="Dialog po naciśnięciu skrótu" %}

## Tworzenie zmiennych lokalnych
  
Następnie wewnątrz `()` wpisz `message`, bądź cokolwiek innego co nadaje się na nazwę zmiennej.

Jak widzisz IDE zaznacza tę nazwę na czerwono pokazując nam błąd. Oczywiście zmienna nie została jeszcze utworzona. Po naciśnięciu `Alt + Enter` pokaże nam okienko z możliwymi sposobami rozwiązania problemu.

Z okienka wybierz _"Create local variable..."_. IDE utworzy nam zmienną, musimy wybrać jej typ. Z dostępnej listy wybierz `String` i przypisz do niego jakiekolwiek zdanie otoczone `""`, jak w przykładzie:

```java
String message = "To jest mój pierwszy łańcuch znaków! Potocznie \"string\".";
```

{% include newsletter-srodek.md %}

## Uruchomienie programu
  
Może nie uwierzysz, ale przy pomocy tych kilku skrótów klawiaturowych napisałeś swój pierwszy program, który możemy uruchomić! Jak to zrobić? Naciśnij skrót `Alt + Shift + F10`.

Z okienka, które się pokazało wybierz nazwę klasy i „Run”. To spowoduje uruchomienie programu, który napisałeś.

W dolnej część IDE pokaże się okno wyświetlające nasz program. Proste prawda? Nagrałem też filmik, pokazujący jak doszedłem do gotowej klasy. Możesz go obejrzeć na kanale [youtube](https://www.youtube.com/embed/wYK5iwYkjs4)

{% include figure image_path="/assets/images/2015/11/08_kurs_5_dialog_do_uruchamiania.png" caption="Dialog uruchomienia programu" %}

Istnieje również skrót `Shift + F10`, który pozwala na uruchomienie aktualnie edytowanej klasy (jeśli taka możliwość istnieje).

## Omówienie kodu programu
  
Najwyższy czas na analizę kodu, który napisaliśmy.

```java
package pl.samouczekprogramisty.kursjava;
 
public class Main {
    public static void main(String[] args) {
        String message = "To jest mój pierwszy łańcuch znaków! Potocznie \"string\".";
        System.out.println(message);
    }
}
```
  
Linijka z pakietem to dla Ciebie nic nowego, więcej na temat pakietu przeczytasz w artykule . Później definiujemy klasę, również nic nowego. W tym samym artykule przeczytasz więcej o klasach.

Następna linijka to już dwie nowe rzeczy.

```java
public static void main(String[] args)
```

### Metody statyczne
  
Ten fragment kodu to nic innego jak definiowanie metody. Więcej o metodach przeczytasz w [artykule o metodach w języku Java]({% post_url 2015-10-22-metody-w-jezyku-java %}). Nowe jest jednak słowo kluczowe `static`. Przy pomocy tego słowa kluczowego definiujemy metody statyczne.

Jak pamiętasz do wywołania metody potrzebujemy instancji klasy:

```java
Engine engine = new Engine();
engine.start();
```
  
Metody statyczne różnią się od zwykłych metod tym, że do ich wywołania nie potrzebujemy instancji klasy. Taką metodę możemy wywołać na klasie. Biorąc nasza przykładową klasę Main z metodą main wywołanie wyglądałoby następująco.

```java
Main.main();
```

### Typ tablicowy
  
Kolejna nowa rzecz to typ przekazywanego argumentu. `String[]` oznacza tablicę obiektów typu `String`. O tablicach więcej przeczytasz w jednym z kolejnych artykułów. Klasę `String` omówimy jednak trochę dokładnej, kilka akapitów poniżej.

```java
System.out.println(message);
```

  
Ta konstrukcja jest trochę bardziej skomplikowana. Odwołujemy się tutaj do atrybutu `out` klasy `System`. `System.out` także jest obiektem, jest to obiekt klasy `java.io.PrintStream`. Klasa ta definiuje wiele metod, jedną z nich jest `println`, która wypisuje to co przekażemy jej jako parametr w osobnej linii[^uproszczenie].

[^uproszczenie]: To jest spore uproszczenie, tutaj musielibyśmy mówić o strumieniach, plikach, IO itd. dzisiaj to pominiemy, skupimy się na tym w przyszłości.

### Klasa `String`
  
W każdym języku programowania, który znam istnieje sposób na zapisanie łańcucha znaków w sposób zrozumiały dla komputera. W języku Java do tego celu używamy klasy `String`.

```java
String someRandomWord = "słowo";
```

Jak widzisz w linijce tworzymy zmienną `someRandomWord` typu `String` i przypisujemy jej wartość `"słowo"`. Wszystko co jest otoczone `"` oznacza String. Jest to konstrukcja wbudowana w język Java. Do utworzenia instancji obiektu String nie potrzebujemy konstruktora, wystarczy otoczyć łańcuch znaków `""` jak w przykładzie wyżej.

Jeśli wewnątrz łańcucha znaków chcesz umieścić `"` musisz go poprzedzić ukośnikiem `\` jak w przykładzie poniżej.

```java
String escapedCharacter = "This is an \" escaped charecter";
```
  
Łańcuchy znaków możemy ze sobą łączyć przy pomocy symbolu `+`.

```java
String productName = "Coca" + "Cola";
```

#### Kilka metod klasy `String`
  
Podobnie jak inne klasy String ma zestaw metod, których możemy użyć. Poniżej kilka z nich:
- `length` – zwraca długość łańcucha znaków

```java
int length = productName.length(); // w naszym przypadku zwraca 8
```
  
- `contains` – sprawdza czy w łańcuchu znaków znajduje się ten przekazany jako parametr

```java
productName.contains(„ocaCol”); // w naszym przypadku zwraca true
productName.contains(„Pepsi”); // w naszym przypadku zwraca false
```
  
- `endsWith` – spradza czy łańcuch kończy się przekazanym argumentem

```java
productName.endsWith(„ola”); // w naszym przypadku zwraca true
productName.endsWith(„oca”); // w naszym przypadku zwraca false
```
  
Metod jest sporo. Ponownie z pomocą przychodzi IDE. Wystarczy, że napiszesz `.` (kropkę) po instancji i od razu dostaniesz podpowiedzi z metodami, które możesz wywołać.

{% include figure image_path="/assets/images/2015/11/08_kurs_5_metody_string.png" caption="Dialog z metodami klasy `String`" %}

### JavaDoc
  
Przypadkiem nie próbuj ich zapamiętać! Owszem parę podstawowych wejdzie Ci w krew po pewnym czasie ale zakuwanie ich z kartką w ręku nie ma najmniejszego sensu. Z pomocą przychodzi dokumentacja. Każda klasa z biblioteki standardowej ma dokładną dokumentację opisującą wszystkie metody, ich argumenty i typy zwracane.

Na przykład dokumentację dla klasy `String` możesz znaleźć pod tym adresem [{{ site.doclinks.java.lang.String }}]({{ site.doclinks.java.lang.String }}).

Pewnie pamiętasz jak na początku w artykule [opisującym czym jest programowanie]({% post_url 2015-10-07-czym-wlasciwie-jest-programowanie %}) przekonywałem, że angielski to podstawa? :)

### Biblioteka standardowa
  
String i dużo innych klas są częścią tak zwanej biblioteki standardowej. Jest to nic innego jak zestaw klas dostarczony wraz z językiem dostępny dla programisty. Znajdują się w w niej różne klasy używane na co dzień przez programistów np. `java.io.PrintStream`, `java.lang.String` czy `java.lang.System`, które poznałeś w tym artykule.

## Zadanie
  
Napisz program, który wyświetli trzy różne zdania opisujące aktualną pogodę. W czwartej linii wypisz sumaryczną długość trzech poprzednich zdań.

## Podsumowanie
  
Prawda, że nie było tak strasznie? Jeśli podobał Ci się dzisiejszy artykuł proszę polub [stronę na Facebook'u](https://www.facebook.com/SamouczekProgramisty).

Zależy mi na tym, żeby dotrzeć do jak największej liczby osób, które chcą się nauczyć programować, jeśli mógłbyś przekazać im informację o stronie byłbym ogromnie wdzięczny. Do następnego razu!
