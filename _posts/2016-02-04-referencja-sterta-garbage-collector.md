---
title: Referencja, sterta i garbage collector - obiektów w Javie ciąg dalszy
date: '2016-02-04 21:13:16 +0100'
categories:
- Kurs programowania Java
permalink: /referencja-sterta-garbage-collector/
header:
    teaser: /assets/images/2016/02/04_referencja_sterta_garbage_collector_artykul.jpeg
    overlay_image: /assets/images/2016/02/04_referencja_sterta_garbage_collector_artykul.jpeg
    caption: "[&copy; sixteen-miles](https://www.flickr.com/photos/sixteen-miles/3757672365)"
excerpt: W dzisiejszym artykule kolejna porcja wiedzy na temat obiektów i programowania obiektowego w języku Java. Dowiesz się czym jest referencja i czym różni się od obiektu. Przeczytasz o magicznym "garbage collectorze" i dowiesz się do czego on służy. Poznasz różnicę między literałem `"tekst"` i `new String("tekst")` i dlaczego ma ona znaczenie. Poznasz typ `null` oraz `NullPointerException`. Innymi słowy, kolejna część niezbędnika każdego programisty Java. Zapraszam do lektury :)
disqus_page_identifier: 217 http://www.samouczekprogramisty.pl/?p=217
---

{% include kurs-java-notice.md %}

## Sterta i stos w wirtualnej maszynie Java

Z poprzednich artykułów wiesz, że maszyna wirtualna Javy zarządza za Ciebie pamięcią. Oznacza to tyle, że miejsce na obiekty, które tworzysz jest rezerwowane (i zwalniane jeśli obiekt nie jest już wykorzystywany) w tej pamięci. Pamięć ta nazywana jest stertą (ang. _heap space_).

Maszyna wirtualna Javy startuje zapewniając sobie miejsce na stertę w pamięci RAM (ang. _Random Access Memory_). Mówimy, ze alokuje tę pamięć. Na przykład jeśli Twój komputer ma 4GB pamięci RAM maszyna wirtualna podczas startu może przydzielić sobie 512MB. Obszar ten potencjalnie może się powiększyć w zależności od ustawień maszyny wirtualnej i dostępnej pamięci.

> Tutaj drobna dygresja na temat dysku i pamięci operacyjnej. W czasach dysków HDD (ang. _Hard Disk Drive_) czas dostępu do pamięci RAM był znacząco krótszy. Obecnie przy dyskach SSD (ang. _Solid State Drive_) różnica nadal istnieje jednak nie jest tak duża.
>
> Dzięki temu krótkiemu czasowi dostępu do pamięci RAM programy mogły być bardziej wydajne – działać "szybciej". Załóżmy że przeczytanie 1MB z pamięci ram zajmuje 1 sekundę (w rzeczywistości jest to około 250 nanosekundy więc cztery miliony razy krócej!), w takiej skali przeczytanie 1MB z dysku HDD zajmuje 1 minutę i 20 sekund, a przesłanie pakietu (paczki danych mniejszej niż 1MB) przez internet z Kalifornii do Holandii i z powrotem aż 10 minut!

{% include newsletter-srodek.md %}

## Czym różni się obiekt od referencji i zmiennej?

Każdy obiekt w Javie zajmuje jakiś obszar na wspomnianej stercie. Zmienne, które wskazują na obiekty na stercie zawierają referencje. Referencje możemy przedstawić jako „sznurki” łączące zmienną z właściwym obiektem na stercie (obszarem pamięci na stercie gdzie znajduje się obiekt). Referencji (sznurków) do obiektu może być wiele. Proszę spójrz na przykład:

```java
public class ObjectVersusReference {
    public static void main(String[] args) {
        Object referenceToObjectX = new Object();
        Object anotherReferenceToObjectX = referenceToObjectX;
        Object refferenceToObjectY = new Object();

        System.out.println(referenceToObjectX.toString());
        System.out.println(anotherReferenceToObjectX.toString());
        System.out.println(refferenceToObjectY.toString());
    }
}
```

W pierszej linijce metody `main` tworzona jest nowa zmienna typu `Object` o nazwie `referenceToObjectX`. W kolejnej linijce tworzona jest kolejna zmienna, która jest kopią isteniejącej już zmiennej. Trzecia linijka to wywołanie konstruktora, czyli utworzenie nowego obiektu i przypisanie go do zmiennej `referenceToObjectY`. Innymi słowy zmienne `referenceToObjectX` oraz `anotherReferenceToObjectX` zawierają tę samą referencję do tego samego obiektu na stercie.

Poniżej pokazałem to co zostanie wypisane na konsoli po uruchomieniu powyższego przykładu

```java
java.lang.Object@7f31245a
java.lang.Object@7f31245a
java.lang.Object@6d6f6e28
```

`java.lang.Object@7f31245a` to nic innego jak wynik domyślnej implementacji metody `toString` znajdującej się w klasie `Object`. Metoda ta zwraca nazwę klasy wraz z pakietem oraz adres obiektu na stercie. 7f31245a to adres obiektu (oczywiście w Twoim przypadku te numery mogą być różne – Java może przydzielić tym obiektom inny adres przy każdym uruchomieniu)[^adres].

[^adres]: Właściwie to zależy od implementacji maszyny wirtualnej Javy, nie mamy gwarancji, że ten numerek będzie adresem.

Zauważyłeś, że dwie pierwsze linijki są takie same? To nic innego jak konsekwencja tego, że referencje są "sznurkami" wskazującymi na obiekty. Mamy dwie różne zmienne, które wskazują na ten sam adres na stercie. Jaka jest tego konsekwencja? Jeśli zmienimy zawartość obiektu pod tym adresem obie referencje będą pokazywały, nową, zmienioną wersję obiektu. Rzuć okiem na przykład.

```java
public class ObjectFieldsChanging {
    private int attribute;
 
    public ObjectFieldsChanging(int attribute) {
        this.attribute = attribute;
    }
 
    public int getAttribute() {
        return attribute;
    }
 
    public void setAttribute(int attribute) {
        this.attribute = attribute;
    }
 
    public static void main(String[] args) {
        ObjectFieldsChanging reference1 = new ObjectFieldsChanging(123);
        ObjectFieldsChanging reference2 = reference1;
 
        System.out.println(reference1.getAttribute());
        System.out.println(reference2.getAttribute());
 
        reference1.setAttribute(1);
 
        System.out.println(reference1.getAttribute());
        System.out.println(reference2.getAttribute());
    }
}
```

Zmieniliśmy obiekt tylko pod jedną ze zmiennych, ale w związku z tym, że obie pokazują na ten sam adres na stercie zmiana dotyczyła obu.

Przypisanie nowej instancji obiektu do istniejącej zmiennej oczywiście "przepina sznurek" do innego miejsca na stercie (zmienna jest referencją do nowego obiektu, innego miejsca w pamięci).

```java
ObjectFieldsChanging reference1 = new ObjectFieldsChanging(123);
ObjectFieldsChanging reference2 = reference1;
reference2 = new ObjectFieldsChanging(3);
```

> Kolejna dygresja, jeśli po powyższych wyjaśnieniach masz mętlik w głowie pomiń ten akapit przy pierwszym czytaniu. Obiekty trzymane są na stercie, zmienne trzymane są na stosie (ang. _stack_) :). "Niestety" nie wszystkie zmienne wskazują na obiekty na stosie. Jeśli utworzysz zmienną lokalną (nie będącą atrybutem klasy) typu prostego (np. `int` czy `double`) wylądują one bezpośrednio na stosie. Referencja to nic innego jak numer, adres w pamięci. W przypadku zmiennych przechowywanych na stosie ten adres zostaje zastąpiony właściwą wartością zmiennej (np. liczbą 123).

## Różnica między `"string"` a `new String("string")`

Wiesz już, że obiekty zajmują obszar na stercie. Java stara się być trochę mądrzejsza i ograniczać ilość zajętego miejsca. Jedną z takich optymalizacji jest zachowanie w przypadku literałów reprezentujących typ `String`.

```java
String x1 = new String("x");
String x2 = new String("x");
String x3 = "x";
String x4 = "x";
```

Dwie pierwsze linijki to dwie zmienne, dwie referencje i dwa różne obiekty (które mają w taką samą zawartość). Dwie ostatnie linijki to dwie zmienne, dwie referencje i jeden obiekt. Obie referencje pokazują na obiekt utworzony w 3 linijce. Innymi słowy konstruktor tworzy kopię przekazanego literału. Literał może czasami ograniczyć ilość zużytego miejsca na stercie.

## Garbage Collector w wirtualenej maszynie Javy

Zbieracz śmieci :) Gargage collector, inaczej GC, jest komponentem wirtualnej maszyny Javy odpowiedzialnym za czyszczenie sterty[^sterta]. Jeśli na stercie znajdą się obiekty, które już nie są używane zostają one usunięte aby zwolnić miejsce dla nowych obiektów.

[^sterta]: Nie tylko sterty, wirtualna maszyna Javy alokuje też pamięć w innych celach, na przykład tak zwany "metaspace", który też jest czyszczony przez GC.

Gdyby nie było tego mechanizmu pamięć nie byłaby zwalniana i po pewnym czasie program nie mógłby działać, nie miałby miejsca na alokację pamięci dla nowo tworzonych obiektów. GC używa różnych zaawansowanych algorytmów, które pozwalają zdecydować czy dany obiekt jest aktualnie wykorzystywany przez działający program.

GC działa w tle, w większości przypadków nawet nie będziesz wiedział kiedy. Wirtualna maszyna sama decyduje kiedy powinna go uruchomić. Istnieją sposoby aby zasugerować uruchomienie GC ale w rzeczywistości nie masz na to wpływu.

GC jest dość skomplikowanym mechanizmem, którego na tym etapie nie musisz w 100% rozumieć. Powinieneś wiedzieć o tym, że jest i odwala za Ciebie mnóstwo pracy :)

GC nie jest rozwiązaniem wszystkich problemów. Dalej możesz napisać program, który zajmie całą dostępną stertę i maszyna wirtualna nie będzie miała możliwości tworzenia nowych obiektów. W takiej sytuacji Twój program zostanie zamknięty, rzucony zostanie wyjątek `java.lang.OutOfMemoryError`.

## `null` i `NullPointerException`

Oj, ten wyjątek zobaczysz wiele razy w trakcie swojej kariery :) Zanim jednak przejdziemy do wyjątku przeczytaj o magicznym `null`.

Będzie to trochę abstrakcyjne ale właśnie tak jest zdefiniowane w specyfikacji języka Java. `Null` jest typem, który nie ma nazwy. W związku z tym, że nie ma nazwy nie ma możliwości utworzyć zmiennej typu `null`. Wyrażenie `null` zwraca referencję do `null`.

```java
Object object = new Object(); // ok
null something = new null(); // compilation error
```

W praktyce jednak można zapomnieć o typie `null` i uznać to jako specjalny literał, który możemy przypisać do zmiennej każdego innego typu (który nie jest typem prostym). Możemy też założyć, że to jest "pusta" wartość zmiennej przechowującej referencję do obiektu.

A co się stanie jeśli wywołamy metodę na referencji wskazującej na `null`? Zostanie rzucony wyjątek `java.lang.NullPointerException`. Innymi słowy za każdym razem kiedy zobaczysz `NullPointerException` (a zobaczysz go nie raz) oznacza to, że zmienna ma wartość `null`.

## Dodatkowe materiały do nauki

- [https://gist.github.com/jboner/2841832](https://gist.github.com/jboner/2841832) - zestawienie czasów na podstawie których przygotowałem jeden z akapitów
- [http://edu.pjwstk.edu.pl/wyklady/ppj/scb/ObRef/ObRef.html](http://edu.pjwstk.edu.pl/wyklady/ppj/scb/ObRef/ObRef.html)
- [http://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.1 null](http://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html#jls-4.1 null)
- [kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/10_obiekty/src/main/java/pl/samouczekprogramisty/kursjava)
- [https://pl.wikipedia.org/wiki/Referencja\_%28informatyka%29](https://pl.wikipedia.org/wiki/Referencja_%28informatyka%29)

## Zadanie

Zadanie będzie nietypowe :) Spróbuj napisać program, który spowoduje przepełnienie sterty i skończy się wyjątkiem `java.lang.OutOfMemoryError`. Od razu powiem, że dla początkującego programisty nie jest to zadanie proste więc należy Ci się podpowiedź. Jak myślisz jak duża tablica z liczbami typu `Long` zmieści się w pamięci? Czy jeden wymiar tablicy zapełni pamięć? :)

## Podsumowanie

Bardzo się cieszę, że dotrwałeś do końca :) Mam nadzieję, że artykuł przypadł Ci do gustu. Na koniec mam do Ciebie prośbę - polub nasz profil na facebooku i podziel się artykułem ze znajomymi. Dzięki temu dotrę do większej grupy czytelników a właśnie na tym mi zależy.

Jeśli masz jakiekolwiek pytania proszę zadaj je w komentarzach, postaram się pomóc :)

Miłego dnia i do następnego razu!
