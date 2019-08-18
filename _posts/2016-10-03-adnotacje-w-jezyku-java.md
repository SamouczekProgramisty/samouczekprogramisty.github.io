---
last_modified_at: 2019-05-02 22:04:31 +0200 
title: Adnotacje w języku Java
categories:
- Kurs programowania Java
permalink: /adnotacje-w-jezyku-java/
header:
    teaser: /assets/images/2016/10/03_adnotacje_artykul.jpg
    overlay_image: /assets/images/2016/10/03_adnotacje_artykul.jpg
    caption: "[&copy; 115327016@N06](https://www.flickr.com/photos/115327016@N06/)"
excerpt: W tym artykule przeczytasz o adnotacjach w języku Java. Poznasz różne zastosowania dla adnotacji. Postaram się wymienić te najbardziej użyteczne, najczęściej używane z biblioteki standardowej. Po przeczytaniu artykułu będziesz w stanie stworzyć też swoje własne adnotacje. Napiszesz program, w którym w trakcie jego działania wyświetlisz informacje o adnotacjach. Zapraszam do lektury.
disqus_page_identifier: 425 http://www.samouczekprogramisty.pl/?p=425
---

{% include kurs-java-notice.md %}

## Adnotacja

Czasami mogłeś zobaczyć w kodzie dziwną konstrukcje z `@` np. `@Override` czy `@NotNull`. To właśnie były adnotacje.

Adnotacje są konstrukcją, która pozwala na przekazywanie dodatkowych informacji na temat kodu. Informacje te mogą być wykorzystane później w kilku miejscach. Każde z tych zastosowań opiszę bardziej szczegółowo w kolejnych akapitach.

Mówi się, że adnotacje służą do przekazywania metadanych. Innymi słowy przekazują one dane o danych – dane o kodzie źródłowym.

"Pod spodem" adnotacja to nic innego jak specjalny rodzaj interfejsu.

### Adnotacje a JavaDoc

Chociaż w obu przypadkach możesz zauważyć znak `@` musisz wiedzieć, że adnotacje to coś zupełnie innego niż dyrektywy JavaDoc.

JavaDoc to standardowy mechanizm do generowania dokumentacji, która zaszyta jest w kodzie źródłowym. Na przykład we fragmencie kodu poniżej widzisz metodę wraz z dokumentacją. Zwróć proszę uwagę, że JavaDoc znajduje się wewnątrz specjalne sformatowanego komentarza wieloliniowego. który rozpoczyna się od `/**`, każda linia wewnątrz komentarza rozpoczyna się od `*`. Wewnątrz komentarza znajdują się specjalne dyrektywy, takie jak `@param` czy `@return`. Opisują one odpowiednio parametr oraz wartość zwracaną metody.

```java
/**
 * Multipies number by 2
 * @param parameter number that should be multipied
 * @return parameter multipied by 2
 */
public int timesTwo(int parameter) {
    return parameter * 2;
}
```

Mogą tam znajdować się również inne dyrektywy takie jak `@see`, `@author` czy `@version`. Na podstawie tak zapisanych informacji o kodzie generowana jest dokumentacja, na przykład dla klasy [`String`]({{ site.doclinks.java.lang.String }}).

Adnotacje, w odróżnieniu od dyrektyw JavaDoc, nie są umieszczane wewnątrz komentarzy a poza nimi.

Taka ilość informacji w zupełności wystarczy Ci aby odróżnić adnotacje od dyrektyw JavaDoc, przejdźmy zatem do zastosowania adnotacji.

{% include newsletter-srodek.md %}

### Zakres adnotacji – dozwolone miejsca gdzie możemy stosować adnotacje

Każda adnotacja określa, w którym miejscu możemy ją stosować. Mamy kilka standardowych miejsc, gdzie możemy wstawić adnotację.
- metoda,
- klasa,
- atrybut klasy,
- parametr metody,
- zmienna lokalna,
- konstruktor,
- adnotacja typu (ang. _type annotations_).


Adnotację umieszczamy zawsze przed konkretnym elementem, na przykład przed klasą.

## Zastosowanie adnotacji

Adnotacje mają trzy główne zastosowania. Poniższe sekcje dokładniej opisują każde z nich.

### Dodatkowe informacje dla kompilatora

Adnotacje mogą służyć jako dodatkowa informacja dla kompilatora. Za przykład może tu posłużyć adnotacja [`@Override`](https://docs.oracle.com/javase/8/docs/api/java/lang/Override.html). Jest to informacja dla kompilatora, że dana metoda przesłania metodę w nadklasie. Adnotacja `@Override` może też być używana do oznaczania metod interfejsu, które implementujemy.

W przypadku tej adnotacji kompilator może wychwycić więcej błędów w trakcie kompilacji. Spójrz na przykład poniżej:

```java
public class EqualsOverride {
    public boolean equal(Object obj) {
        return true;
    }
}
```

Programista chciał nadpisać metodę `equals`. Brakujące `s` na końcu metody sprawia, że w momencie porównywania obiektów tej klasy używamy odziedziczonej metody `equals` z klasy `Object`, która ma zupełnie inną implementację.

Jeśli dodalibyśmy adnotację `@Override` do tej metody, kompilator już na etapie kompilacji znalazłby błąd. Kompilacja nie powiodłaby się ponieważ nasza metoda nie nadpisała żadnej metody z nadklasy. Poniżej przykład metody `equals` z adnotacją.

```java
@Override
public boolean equals(Object obj) {
    return true;
}
```

### Adnotacje przetwarzane w trakcie kompilacji

W trakcie kompilacji także możemy przetwarzać adnotacje. Dzięki nim możemy na przykład automatycznie generować kod czy dać znać kompilatorowi aby zachowywał się trochę inaczej. Przykładem takiej adnotacji jest [`@SuppressWarnings`](https://docs.oracle.com/javase/8/docs/api/java/lang/SuppressWarnings.html) z biblioteki standardowej. Adnotacja ta pozwala nam wstrzymać pewne ostrzeżenie kompilatora.

Proszę spójrz na przykład kodu poniżej.

```java
public static void main(String[] args) {
    List listOfUndefinedObjects = new ArrayList();
    List<Integer> listOfIntegers = (List<Integer>) listOfUndefinedObjects;
}
```

W metodzie `main` tworzymy zmienną lokalną `listOfUndefinedObjects`, która jest zwykłą listą. Nie używam tu typów generycznych. Linijkę niżej natomiast rzutuję tę zmienną na typ `List<Integer>`.

Jeśli w `listOfUndefinedObjects` mielibyśmy instancję klasy `String`, wówczas pobranie elementu z nowej `listOfIntegers` skończyłoby się rzuceniem wyjątku `ClassCastException` (nie możemy rzutować `String` na `Integer`).

Kompilator ostrzega nas o takiej możliwości pokazując ostrzeżenie

    Warning:(10, 56) java: unchecked cast
    required: java.util.List<java.lang.Integer>
    found: java.util.List

Jeśli jesteśmy pewni, że ta operacja jest poprawna (mamy pewność, że będą tam tylko instancje klasy `Integer`) i chcemy aby kompilator takich wyjątków nie pokazywał możemy użyć adnotacji `@SuppressWarnings`

Akurat tę adnotację możemy przypisać do typu, atrybutu, metody, parametru metody, konstruktora czy nawet zmiennej lokalnej, jak zrobiłem to w przykładzie poniżej.

```java
public static void main(String[] args) {
    List listOfUndefinedObjects = new ArrayList();
    @SuppressWarnings("unchecked")
    List<Integer> listOfIntegers = (List<Integer>) listOfUndefinedObjects;
}
```

`@SupressWarnings(„unchecked”)` mówi aby kompilator nie ostrzegał nas o potencjalnych zagrożeniach typu `unchecked` przy tej konkretnej zmiennej.

### Adnotacje przetwarzane w trakcie uruchomienia programu

Adnotacje mogą być także używane w trakcie działania programu. Służy do tego mechanizm refleksji.

Mechanizm refleksji opiszę w osobnym artykule. Na potrzeby tego artykułu wystarczy, że wiesz o jej istnieniu oraz o tym, że dzięki niej możemy w trakcie działania programu pobierać informacje o skompilowanym kodzie.

Przykładem takiej adnotacji jest na przykład [`@PostConstruct`](https://docs.oracle.com/javase/8/docs/api/javax/annotation/PostConstruct.html).

## Składnia definiowania adnotacji

Java Language Specification definiuje adnotację jako specjalny rodzaj interfejsu. Szczerze mówiąc to porównanie nasuwa się samo jak zobaczysz przykładową definicję adnotacji.

```java
public @interface Override {
}
```

Definicja powyżej to nic innego jak znana Ci już adnotacja `@Override`. Zauważ znak `@` przed słowem kluczowym `interface`.

Dodatkowo definicja adnotacji powinna także posiadać informację o tym do jakich elementów może być stosowana. Ponadto znajduje się tam także informacja o tym jak długo dane o adnotacji powinny być przetrzymywane – retencja. Czy tylko w trakcie kompilacji czy także w trakcie uruchomienia programu.

Ta ostatnia cecha (ang. _retention_) jest bardzo istotna gdy chcesz wykorzystywać adnotację w trakcie uruchomienia programu. Pełna definicja adnotacji `@Override` wraz z tymi informacjami przedstawiona jest w przykładzie poniżej

```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
```

### Dopuszczalny kontekst użycia adnotacji

Do określenia gdzie możemy użyć adnotację służy inna „meta-adnotacja” [`@Target`](https://docs.oracle.com/javase/8/docs/api/java/lang/annotation/Target.html). Jeśli ją pominiemy przy definiowaniu nowej adnotacji, możemy jej używać w każdym miejscu. Z jednym małym wyjątkiem – adnotacji typów.

Miejsca gdzie możemy użyć adnotacji określone są przez wartości typu wyliczeniowego [`ElementType`](https://docs.oracle.com/javase/8/docs/api/java/lang/annotation/ElementType.html). Spójrz na przykład poniżej.

```java
@Target(ElementType.FIELD)
public @interface SampleFieldAnnotation {
String id();
}
```

Nasza `@SampleFieldAnnotation` może być użyta wyłącznie przy atrybutach klasy, ponieważ przypisaliśmy do niej `ElementType.FIELD`.

### Retencja adnotacji

Adnotacje, które przypiszesz mają swój "cykl życia". W zależności od typu adnotacji informacja o tym, że była ona przypisana do jakiegoś elementu może (ale nie musi) być "wymazana" przez kompilator w trakcie kompilacji. Zachowanie takie ma sens ponieważ nie potrzebujemy informacji w trakcie uruchomienia programu o adnotacjach, które są wykorzystywane wyłącznie podczas kompilacji. Takie "wymazywanie" adnotacji pozwala na stworzenie bajtkodu (skompilowanej klasy), który ma mniejszą objętość.

Retencję (informacja o tym jak długo informacja o adnotacji powinna być przechowywana) także określamy przy pomocy adnotacji. Służy do tego „meta-adnotacja” `@Retention`. Informacje o adnotacji mogą być:

- usuwane przez kompilator w trakcie kompilacji,
- umieszczanie w skompilowanej klasie, ale nie dostępne w trakcie uruchomienia programu,
- dostępne w trakcie uruchomienia programu.

Wszystkie trzy sposoby określone są przez typ wyliczeniowy [`RetentionPolicy`](https://docs.oracle.com/javase/8/docs/api/java/lang/annotation/RetentionPolicy.html).

Jeśli nie określimy retencji naszej własnej adnotacji (nie dodamy `@Retention`), wówczas przyjmie ona wartość domyślną [`RetentionPolicy.CLASS`](https://docs.oracle.com/javase/8/docs/api/java/lang/annotation/RetentionPolicy.html#CLASS). Innymi słowy, jeśli nie określimy inaczej informacje o adnotacji są zapisywane w pliku class jednak nie są dostępne w trakcie uruchomienia programu.

### Elementy adnotacji

Zauważ, że niektóre adnotacje posiadają „argumenty”. W kontekście adnotacji argumenty te nazywamy elementami. Na przykład w przypadku adnotacji `@SuppressWarnings` przekazywaliśmy informację o tym jakiego typu ostrzeżenia kompilatora chcemy pomijać.

Każda adnotacja może mieć elementy, które możemy uzupełnić przy przypisywaniu adnotacji. Możemy je rozumieć jako „parametry” dla adnotacji. Pozwalają one na przekazanie dodatkowych informacji. Spójrz na przykład poniżej:

```java
public @interface Retention {
    RetentionPolicy value();
}
```

Jak widzisz, składnia definiująca elementy adnotacji używa nawiasów `()`, mogą przypominać one deklaracje metod, co po raz kolejny można skojarzyć z interfejsami.

Adnotacja `@Retention` posiada jeden element o nazwie `value`. Nazwa `value` jest traktowana specjalnie. Jeżeli jest jedyna, możemy ją pomijać gdy używamy danej adnotacji. W przykładzie poniżej oba użycia oznaczają dokładnie to samo.

```java
@Retention(RetentionPolicy.SOURCE)
@Retention(value=RetentionPolicy.SOURCE)
```

#### Elementy adnotacji będące tablicami

Czasami może zdarzyć się tak, że do adnotacji chcesz przekazać kilka wartości dla danego elementu. Wówczas element adnotacji jest typu tablicowego. Dobrym przykładem tutaj jest adnotacja `@Target`, którą widziałeś już wyżej:

```java
public @interface Target {
    ElementType[] value();
}
```

Jak widzisz posiada ona element `value`, który jest tablicą. Podobnie jak w poprzednim przykładzie jedyny element o nazwie `value` może być pominięty. Przykład poniżej pokazuje cztery różne sposoby użycia adnotacji mające ten sam efekt. Nawiasy `{}` służą do określenia tablicy wartości, w tym przykładzie jest to tablica jednoelementowa.

```java
@Target(ElementType.FIELD)
@Target(value=ElementType.FIELD)
@Target({ElementType.FIELD})
@Target(value={ElementType.FIELD})
```

#### Wartości domyślne elementów adnotacji

Istnieje możliwość tworzenia adnotacji, które mają wartości domyślne. Używamy do tego słowa kluczowego `default`. Spójrz na przykład poniżej

```java
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.CONSTRUCTOR, ElementType.METHOD})
public @interface AnnotationWithDefaultValues {
    String firstElement() default "someDefaultValue";
    int [] secondElement() default {1, 2, 3};
    float thirdElement();
}
```

Nasza adnotacja `@AnnotationWithDefaultValues` posiada trzy elementy, dwa z nich mają wartości domyślne. Adnotację tę możemy stosować do atrybutów klasy, konstruktorów i metod. Informacja o tej adnotacji jest dostępna w trakcie wykonania programu.

## Zadanie

Na koniec mam dla Ciebie zadanie. Napisz adnotację `@MyDocumentation`, która będzie miała elementy `author` oraz `comment`. Informacja o tej adnotacji powinna być dostępna w trakcie uruchomienia programu.

Napisałem krótki fragment, kodu używający mechanizmu refleksji, w którym możesz przetestować swoją adnotację. Wstaw adnotację w miejscu komentarza i uruchom program. Używa on mechanizmu refleksji (jej tłumaczenie możemy teraz pominąć).

```java
// TUTAJ DODAJ ADNOTACJE
public class AnnotationProcessor {
 
    private static List SKIP_METHODS = Arrays.asList("equals", "toString", "hashCode", "annotationType");
 
    public static void main(String[] args) throws InvocationTargetException, IllegalAccessException {
        for (Annotation classAnnotation : AnnotationProcessor.class.getDeclaredAnnotations()) {
            printAnnotationDetails(classAnnotation);
        }
    }
 
    private static void printAnnotationDetails(Annotation annotation) throws InvocationTargetException, IllegalAccessException {
        System.out.println("Znalazłem adnotacje: " + annotation);
        for (Method method : annotation.annotationType().getMethods()) {
            if (SKIP_METHODS.contains(method.getName())) {
                continue;
            }
            System.out.println("Nazwa elementu: " + method.getName());
            System.out.println("Wartosc elementu: " + method.invoke(annotation));
            System.out.println("Wartosc domyslna elementu: " + method.getDefaultValue());
            System.out.println();
        }
    }
}
```

Jak zwykle zachęcam Cię do samodzielnego rozwiązania zadania. W przypadku jakichkolwiek wątpliwości [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/tree/master/20_adnotacje/src/main/java/pl/samouczekprogramisty/kursjava/annotations/exercise) umieściłem na githubie.

## Dodatkowe materiały do nauki

Oczywiście Jak zwykle zachęcam do przejrzenia standardowej dokumentacji, jak zwykle znajdziesz tam mnóstwo wiedzy.
- [Rozdział w specyfikacji języka Java dotyczący adnotacji]({{ site.doclinks.specs.jls }}jls-9.html#jls-9.7),
- [Inny artykuł dotyczący adnotacji](http://tutorials.jenkov.com/java/annotations.html),
- [kod źródłowy użyty w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/20_adnotacje/src/main/java/pl/samouczekprogramisty/kursjava/annotations).

## Podsumowanie

W artykule przeczytałeś o adnotacjach, napisałeś swoją pierwszą adnotację i nawet udało Ci się ją wykryć w trakcie działania programu. Wiesz, kiedy i do czego używamy adnotacji. Dzięki temu artykułowi nie zgubisz się w gąszczu adnotacji Springa czy innych bibliotek :)

Jak zwykle, jeśli masz jakiekolwiek pytania zadaj je w komentarzach, w miarę możliwości postaram się pomóc.

Mam nadzieję, że artykuł Ci się podobał, na koniec mam do Ciebie prośbę. Zależy mi na dotarciu do jak największej liczby czytelników. Możesz mi w tym pomóc udostępniając link do bloga czy artykułu swoim znajomym :) Z góry dziękuję i do następnego razu!
