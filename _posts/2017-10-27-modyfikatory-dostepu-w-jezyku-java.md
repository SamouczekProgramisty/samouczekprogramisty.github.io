---
title: Modyfikatory dostępu w języku Java
categories:
- Kurs programowania Java
permalink: /modyfikatory-dostepu-w-jezyku-java/
header:
    teaser: /assets/images/2017/10/27_modyfikatory_dostepu_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2017/10/27_modyfikatory_dostepu_w_jezyku_java_artykul.jpg
    caption: "[&copy; photophilde](https://www.flickr.com/photos/photophilde/6778009240/sizes/o/)"
excerpt: W artykule tym przeczytasz o modyfikatorach dostępu w języku java. Dowiesz się czym różnią się między sobą modyfikatory `public`, `protected` i `private`. Poznasz też zastosowanie czwartego modyfikatora dostępu - braku każdego z poprzednich. Zobaczysz różnice pomiędzy modyfikatorami na przykładowych fragmentach kodu. Na koniec będzie czekało na Ciebie zadanie do rozwiązania, w którym przećwiczysz wiedzę z artykułu.
---
                                                
{% include toc %}

{% capture wymagania %}
Artykuł ten wymaga podstawowej wiedzy na temat języka Java. Z tego powodu aby móc w pełni z niego skorzystać warto zapoznać się z wcześniejszymi artykułami:

- [obiekty, klasy i pakiety w języku Java]({% post_url 2015-11-01-obiekty-w-jezyku-java %}),
- [dziedziczenie w języku Java]({% post_url 2016-01-24-dziedziczenie-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
    {{ wymagania | markdownify }}
</div>

{% capture moduly %}
**UWAGA**

Artykuł ten nie zawiera informacji na temat modułów. Moduły zostały wprowadzone do języka Java wraz z wersją 9. Moduły, podobnie jak modyfikatory dostępu także mają wpływ na widoczność. Operują one na pakietach. W artykule tym zakładam, że każdy z pakietów jest eksportowany przez moduł, w którym się znajduje.

Więcej na temat modułów przeczytasz w osobnym artykule.
{% endcapture %}

<div class="notice--warning">
    {{ moduly | markdownify }}
</div>

{{ page.content | number_of_words }}

## Czym są modyfikatory dostępu

Modyfikatory dostępu to słowa kluczowe, które mają wpływ na widoczność elementu który poprzedzają. Są to słowa kluczowe `public`, `protected` i `private`. Brak jakiegokolwiek ze wspomnianych słów kluczowych także ma wpływ na dostępność danego elementu. Czasami brak modyfikatora dostępu określa się jako dostęp typu `package`.

Modyfikatory dostępu mogą być stosowane na przykład przed definicją klasy, czy interfejsu. Możemy ich także używać przed elementami polami klasy, metodami czy [typami wewnętrznymi]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}).

## Rodzaje modyfikatorów dostępu

### Modyfikator `public`

Słowo kluczowe `public` jest modyfikatorem dostępu, który pozwala na najbardziej swobodyn dostęp do elementu, który poprzedza. `public` może być używane przed definicjami klas, pól w klasach, metod czy typów wewnętrznych. Jeśli przed danym elementem występuje słowo kluczowe `public` jest on dostępny dla wszystkich[^moduly].

[^moduly]: Dla uproszczenia pomijam tutaj moduły, które mogą ograniczyć dostęp do elementów poprzedzonych słowem kluczowym `public`.

Poniższy fragment kodu pokazuje kasę `PublicVisitCounter`. Klasa ta implementuje licznik odwiedziń. Założenie jest takie, że każdy użytkownik wywoła metodę `increment`. Dzięki takiej klasie można w łatwy sposób zliczyć liczbę wizyt na stronie:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.world;

public class PublicVisitCounter {

    public int userCount = 0;

    public void increment() {
        userCount++;
    }
}
```

Klasa ta zawiera jedno pole `userCount`, metodę `increment` i domyślny konstruktor. Każdy z tych elementów ma dostęp typu `public`. Oznacza to tyle, że jest dostępny dla wszystkich.

Ma to swoje konsekwencje. Wyobraźmy sobie klasę `MaliciousUser`, która infrormuje `PublicVisitCounter` o swojej wizycie na stronie:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.others;

import pl.samouczekprogramisty.kursjava.accessmodifiers.world.PublicVisitCounter;

public class MaliciousUser {
    public void countMyVisit(PublicVisitCounter counter) {
        counter.increment();
        counter.userCount = -10;
    }
}
```

Jak widzisz, dzięki modyfikatorowi `public` przed polem `userCount` instancja `MaliciousUser` ma dostęp do pola `userCount`. W takim przypadku możemy mówić o tym, że obiekt `PublicVisitCounter` udostępnia swój stan na zewnątrz. Nie jest to dobrą praktyką. Z pomocą przychodzą inne modyfikatory dostępu.

### Modyfikator `private`

Słowo kluczowe `private` jest najbardziej restrykcyjnym modyfikatorem dostępu. Może być stosowane wyłącznie przed elementami klasy (w tym przed klasami wewnętrznymi). Oznacza on tyle, że dany element (klasa, metoda, czy pole) widoczny jest tylko i wyłącznie wewnątrz klasy. Proszę spójrz na zmodyfikowaną klasę licznika:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.encapsulated;

public class EncapsulatedVisitCounter {

    private int userCount = 0;

    public void increment() {
        userCount++;
    }

    public int getUserCount() {
        return userCount;
    }
}
```

W tym przypadku pole `userCount` poprzedzone jest słowem kluczowym `private`. Dzięki niemu stan wewnętrzny klasy nie jest dostępny na zewnątrz. Tylko elementy wewnątrz definicji klasy mają dostęp do tego pola.

### Modyfikator `protected`

Modyfikator `protected` ma znaczenie w przypadku dziedziczenia. Elementy poprzedzone tym modyfikatorem dostępu są udostępnione dla danej klasy i jej podklas. Proszę spójrz na przykład poniżej:

### Enkapsulacja, czyli kiedy używać modyfikatorów dostępu

Enkapsulacja (ang. _encapsulation_), czy inaczej hermetyzacja to sposób na ukrycie szczegółów implementacji danego elementu. Enkapsulacja to bardzo ważny element programowania obiektowego. Dzięki enkapsulacji mamy możliwość 

#### Dlaczego modyfikatory dostępu są ważne

### Porównianie modyfikatorów dostępu

## Modyfikatory dostępu a dziedziczenie

### Nadpisywanie modyfikatorów dostępu

## Modyfikatory dostępu a mechanizm refleksji


Podsumowując informacje na temat modyfikatorów dostępu można zebrać je w następującej tabeli:

| Modyfikator       | Klasa | Pakiet | Podklasa | Inni |
| :----------       | :---: | :----: | :------: | :--: |
| `public`          | tak   | tak    | tak      | tak  |
| `protected`       | tak   | tak    | tak      | nie  |
| brak modyfikatora | tak   | tak    | nie      | nie  |
| `private`         | tak   | nie    | nie      | nie  |

## Zadania

## Dodatkowe materiały do nauki

Przygotowałem dla Ciebie zestaw kilku linków z materiałami dodatkowymi:
 - [Fragment kursu na stronie Oracle opisujący modyfikatory dostępu](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html),
 - [Artykuł na Wikipedii na temat hermetyzacji](https://pl.wikipedia.org/wiki/Hermetyzacja_(informatyka)),

## Podsumowanie

