---
title: Modyfikatory dostępu w języku Java
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- Kurs programowania Java
permalink: /modyfikatory-dostepu-w-jezyku-java/
header:
    teaser: /assets/images/2017/10/29_modyfikatory_dostepu_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2017/10/29_modyfikatory_dostepu_w_jezyku_java_artykul.jpg
    caption: "[&copy; photophilde](https://www.flickr.com/photos/photophilde/6778009240/sizes/o/)"
excerpt: W artykule tym przeczytasz o modyfikatorach dostępu w języku Java. Dowiesz się czym różnią się między sobą modyfikatory `public`, `protected` i `private`. Poznasz też zastosowanie czwartego modyfikatora dostępu – braku każdego z poprzednich. Zobaczysz różnice pomiędzy modyfikatorami na przykładowych fragmentach kodu. Na koniec będzie czekało na Ciebie zadanie do rozwiązania, w którym przećwiczysz wiedzę zdobytą po przeczytaniu.
---

{% capture wymagania %}
Artykuł ten wymaga podstawowej wiedzy na temat języka Java. Z tego powodu, aby móc w pełni z niego skorzystać, warto zapoznać się z wcześniejszymi artykułami:

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

## Czym są modyfikatory dostępu

Modyfikatory dostępu to słowa kluczowe, które mają wpływ na widoczność elementu który poprzedzają. Są to słowa kluczowe `public`, `protected` i `private`. Brak jakiegokolwiek ze wspomnianych słów kluczowych także ma wpływ na dostępność danego elementu. Czasami brak modyfikatora dostępu określa się jako dostęp typu "package".
Modyfikatory dostępu mogą być stosowane na przykład przed definicją klasy, czy interfejsu. Możemy ich także używać przed polami klasy, metodami czy [typami wewnętrznymi]({% post_url 2016-10-13-klasy-wewnetrzne-i-anonimowe-w-jezyku-java %}).

## Rodzaje modyfikatorów dostępu

### Modyfikator `public`

Słowo kluczowe `public` jest modyfikatorem dostępu, który pozwala na najbardziej swobodny dostęp do elementu, który poprzedza. `public` może być używane przed definicjami klas, pól w klasach, metod czy typów wewnętrznych. Zakładając, że klasa poprzedzona jest `public` i element w tej klasie jest także `public`, jest on dostępny dla wszystkich[^moduly].

[^moduly]: Jak wspomniałem we wstępie pomijam tutaj moduły, które mogą ograniczyć dostęp do elementów poprzedzonych słowem kluczowym `public`.

Poniższy fragment kodu pokazuje kasę `PublicVisitCounter`. Klasa ta implementuje licznik odwiedzin. Założenie jest takie, że każdy użytkownik wywoła metodę `increment`. Dzięki takiej klasie można w łatwy sposób zliczyć liczbę wizyt na stronie:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.public_keyword;

public class PublicVisitCounter {
    public int userCount = 0;

    public void increment() {
        userCount++;
    }
}
```

Klasa dostępna jest dla wszystkich, ze względu na modyfikator `public`. Zawiera jedno pole `userCount`, metodę `increment` i domyślny konstruktor. Każdy z tych elementów ma dostęp typu `public`. Oznacza to tyle, że jest dostępny dla wszystkich.

Ma to swoje konsekwencje. Wyobraźmy sobie klasę `MaliciousUser`, która informuje `PublicVisitCounter` o swojej wizycie na stronie:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.public_keyword;

public class MaliciousUser {
    public void countMyVisit(PublicVisitCounter counter) {
        counter.increment();
        counter.userCount = -10;
    }
}
```

Jak widzisz, dzięki modyfikatorowi `public` przed polem `userCount` instancja `MaliciousUser` ma dostęp do pola `userCount`. W takim przypadku możemy mówić o tym, że obiekt `PublicVisitCounter` udostępnia swój stan na zewnątrz. Nie jest to dobrą praktyką.

### Modyfikator `protected`

Modyfikator `protected` ma znaczenie w przypadku dziedziczenia. Elementy poprzedzone tym modyfikatorem dostępu są udostępnione dla danej klasy i jej podklas. Dodatkowo elementy oznaczone modyfikatorem `protected` dostępne są dla innych klas w tym samym pakiecie. Modyfikatora `protected` nie można stosować przed klasami[^wewnetrzne]. Proszę spójrz na przykład poniżej:

[^wewnetrzne]: Chyba, że są to klasy wewnętrzne. W takim przypadku modyfikator `protected` jest dozwolony.

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.protected_keyword;

public class Pen {
    protected String color;

    public Pen(String color) {
        this.color = color;
    }
}
```

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.protected_keyword.different_package;

public class BallPen extends Pen {
    protected String manufacturer;

    public BallPen(String color, String manufacturer) {
        super(color);
        this.manufacturer = manufacturer;
    }

    @Override
    public String toString() {
        return manufacturer + " " + color;
    }
}
```

Klasa `Pen` posiada pole `color`, które poprzedzone jest słowem `protected`. Dzięki temu klasa `BallPen` ma dostęp do tego pola. Używa go w implementacji metody `toString`. Proszę zwróć uwagę na to, że obie klasy znajdują się w różnych pakietach. Mimo to słowo kluczowe `protected` pozwala na dostęp do pola `color`.

Jak wspomniałem wcześniej ten modyfikator dostępu pozwala także na dostęp dla klas z tego samego pakietu. Ten przypadek pokazuje klasa poniżej:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.protected_keyword;

public class PenOwner {
    private Pen pen;

    public PenOwner(Pen pen) {
        this.pen = pen;
    }

    @Override
    public String toString() {
        return "Mam pioro w kolorze " + pen.color;
    }
}
```

W tym przypadku `PenOwner` ma dostęp do pola `color` ponieważ obie klasy znajdują się w tym samym pakiecie `pl.samouczekprogramisty.kursjava.accessmodifiers.protected_keyword`.

{% include newsletter-srodek.md %}

### Brak modyfikatora dostępu

Brak modyfikatora dostępu również ma znaczenie. W przypadku gdy pominiemy modyfikator dostępu wówczas dana klasa czy element jest dostępna wyłącznie wewnątrz tego samego pakietu. Jest to podzbiór uprawnień, które nadaje modyfikator `protected`. Proszę spójrz na przykład poniżej:

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.missing_keyword;

public class Car {
    public static final double FUEL_TANK_CAPACITY = 50.0;

    double fuelLevel = 12.5;
}
```

```java
package pl.samouczekprogramisty.kursjava.accessmodifiers.missing_keyword;

public class FuelStation {
    public void fillUp(Car car) {
        double toFill = Car.FUEL_TANK_CAPACITY - car.fuelLevel;
        System.out.println("Tankuje " + toFill + " litrow.");
        car.fuelLevel = Car.FUEL_TANK_CAPACITY;
    }
}
```

### Modyfikator `private`

Słowo kluczowe `private` jest najbardziej restrykcyjnym modyfikatorem dostępu. Może być stosowane wyłącznie przed elementami klasy, w tym przed klasami wewnętrznymi. Oznacza on tyle, że dany element (klasa, metoda, czy pole) widoczny jest tylko i wyłącznie wewnątrz klasy. Proszę spójrz na zmodyfikowaną klasę licznika:

[^wewnetrzne_brak]: Chyba, że są to klasy wewnętrzne. W takim przypadku brak modyfikatora dostępu jest dozwolony.

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

## Porównanie modyfikatorów dostępu

Informacje na temat działania modyfikatorów dostępu można zebrać je w następującej tabeli:

| Modyfikator       | Klasa | Pakiet | Podklasa | Inni | Poprawny dla klas |
| :----------       | :---: | :----: | :------: | :--: | :---------------: |
| `public`          | tak   | tak    | tak      | tak  | tak               |
| `protected`       | tak   | tak    | tak      | nie  | nie               |
| brak modyfikatora | tak   | tak    | nie      | nie  | tak               |
| `private`         | tak   | nie    | nie      | nie  | nie               |

## Enkapsulacja, czyli kiedy używać modyfikatorów dostępu

Enkapsulacja (ang. _encapsulation_), czy inaczej hermetyzacja to sposób na ukrycie szczegółów implementacji klasy. Enkapsulacja to bardzo ważny element programowania obiektowego. Pozwala to na pełną kontrolę nad zachowaniem i stanem danego obiektu.

Dobrą praktyką jest stosowanie najbardziej restrykcyjnych modyfikatorów dostępu. Sprowadza się to do użycia `private` dla wszystkich pól i metod, które powinny być używane "wewnątrz". Pozostałe elementy, które stanowią interfejs komunikacji oznaczamy słowem kluczowym `public`. Brak modyfikatora dostępu czy `protected` mają znaczenie w przypadku bardziej złożonych relacji pomiędzy obiektami.

Fragment kodu poniżej pokazuje licznik, który poprawnie ukrywa swój stan. Pozwala on na modyfikację czy dostęp do `userCount` wyłącznie poprzez publiczny interfejs – metody `increment` i `getUserCount`:

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

## Dodatkowe informacje

## Modyfikatory dostępu a interfejsy i typy wyliczeniowe

Chciałbym Cię uczulić na przypadek interfejsów. Brak modyfikatora dostępu w definicji interfejsu oznacza, że dana metoda ma modyfikator `public`. Proszę spójrz na przykład poniżej:

```java
@FunctionalInterface
public interface Supplier<T> {
    T get();
}
```

Jest to interfejs [`Supplier`]({{ site.doclinks.java.util.function.Supplier }}) dostępny w standardowej bibliotece języka Java. Jak widzisz przed metodą `get` nie ma żadnego modyfikatora. W przypadku interfejsów oznacza to, że dana funkcja jest dostępna publicznie.

Innym przykładem są wartości typu wyliczeniowego. Poniższy przykład to typ wyliczeniowy [`AccessMode`]({{ site.doclinks.java.nio.file.AccessMode }}) ze standardowej biblioteki. Jego wartości `READ`, `WRITE` i `EXECUTE` są dostępne publicznie mimo braku jakiegokolwiek modyfikatora dostępu:

```java
public enum AccessMode {
    READ,
    WRITE,
    EXECUTE;
}
```
{% capture inne_artykuly %}
Interfejs `Supplier` jest generyczny, często jest wykorzystywany wraz z wyrażeniami lambda. Jeśli chcesz przeczytać więcej na ten temat zapraszam do oddzielnych artykułów:

- [typy generyczne w języku Java]({% post_url 2016-03-26-typy-generyczne-w-jezyku-java %}),
- [wyrażenia lambda w języku Java]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}),
- [typ wyliczeniowe w języku Java]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
  {{ inne_artykuly | markdownify }}
</div>

### Modyfikatory dostępu a dziedziczenie

Dzięki mechanizmowi nadpisywania metod mamy możliwość nadpisywania modyfikatorów dostępu. Jest to możliwe w przypadku [dziedziczenia]({% post_url 2016-01-24-dziedziczenie-w-jezyku-java %}). Jeśli dziedziczymy po innej klasie mamy możliwość rozszerzenia dostępu do danej metody. W praktyce mamy dwie metody, jedną w klasie bazowej i kolejną w klasie potomnej:

```java
public class Tree {
    protected int height = 12;

    protected void prune() {
        if (height > 15) {
            height -= 1;
        }
    }

    public void grow() {
        height += 1;
    }
}
```

```java
public class Oak extends Tree {
    @Override
    public void prune() {
        super.prune();
    }
}
```

Aby uniemożliwić przedefiniowanie metody należy umieścić przed nią słowo kluczowe `final`.

### Modyfikatory dostępu a mechanizm refleksji

Tylko i wyłącznie dla pełnego obrazu napiszę Ci o mechanizmie refleksji. W większości produkcyjnego kodu nie jest on używany. Pozwala on na dostęp do dowolnego elementu klasy pomijając modyfikator dostępu. Proszę spójrz na przykład poniżej:

```java
public class BankAccount {

    private int balance = 100;

    public int getBalance() {
        return balance;
    }
}
```

```java
public class Thief {
    public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {
        BankAccount account = new BankAccount();
        System.out.println("Stan konta: " + account.getBalance());

        Field balance = BankAccount.class.getDeclaredField("balance");
        balance.setAccessible(true);
        balance.set(account, -5000);

        System.out.println("Stan konta: " + account.getBalance());
    }
}
```

Dzięki mechanizmowi refleksji zmieniłem wartość pola prywatnego. Po uruchomieniu takiego programu na konsoli wyświetlą się dwie linijki:

    Stan konta: 100
    Stan konta: -5000

Ogólna reguła brzmi – nie używaj mechanizmu refleksji w produkcyjnym kodzie. Chyba, że wiesz co robisz i rzeczywiście jest to potrzebne ;).
{: .notice--warning}

## Zadanie

Napisz program, który będzie symulował działanie banku. Zaimplementuj następujące interfejsy:

```java
public interface Account {
    void deposit(int amount);
    void withdraw(int amount);
}
```
```java
public interface BankTransfer {
    void transfer(BankAccount from, BankAccount to, int amount);
}
```

Bank przeprowadzający operację przesyłu środków pobiera stałą opłatę 1zł od nadawcy przelewu. Jakich modyfikatorów dostępu użyjesz? Dlaczego akurat tych?

Pamiętaj, że nie ma jednego rozwiązania tego zadania. Jest ich nieskończenie wiele, jedno z przykładowych rozwiązań znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/29_modyfikatory_dostepu/src/main/java/pl/samouczekprogramisty/kursjava/accessmodifiers/exercise/bank).

## Dodatkowe materiały do nauki

Przygotowałem dla Ciebie zestaw kilku linków z materiałami dodatkowymi:
- [fragment kursu na stronie Oracle opisujący modyfikatory dostępu](https://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html),
- [artykuł na Wikipedii na temat hermetyzacji](https://pl.wikipedia.org/wiki/Hermetyzacja_(informatyka)),
- [przykłady kodu użyte w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/29_modyfikatory_dostepu/src/main/java/pl/samouczekprogramisty/kursjava/accessmodifiers).

## Podsumowanie

Modyfikatory dostępu w Javie są bardzo ważne. Po przeczytaniu artykułu wiesz czym do czego służą i jak ich używać. Wiesz czym jest hermetyzacja i dlaczego jest istotna. Dowiedziałeś się czegoś więcej mechanizmie refleksji i wiesz, że nie powinieneś go używać ;). Po rozwiązaniu zadania przećwiczyłeś wiedzę z artykułu w praktyce.

Mam nadzieję, że artykuł był dla Ciebie pomocny. Jeśli tak to proszę podziel się z nim ze swoimi znajomymi. Jeśli nie chcesz pominąć żadnego artykułu w przyszłości proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Do następnego razu!
