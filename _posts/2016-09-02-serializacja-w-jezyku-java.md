---
title: Serializacja w języku Java
date: '2016-09-02 17:26:33 +0200'
categories:
- Kurs programowania Java
permalink: /serializacja-w-jezyku-java/
header:
    teaser: /assets/images/2016/08/02_serializacja_artykul.jpg
    overlay_image: /assets/images/2016/08/02_serializacja_artykul.jpg
excerpt: W artykule tym dowiesz się czym jest serializacja obiektów w Javie. Przeczytasz o klasach takich jak `ObjectInputStream` czy `ObjectOutputStream` i dowiesz się czym różnią się od innych strumieni. Poznasz nowe słowo kluczowe `transient`. Po przeczytaniu artykułu będziesz w stanie napisać swoją mini bazę danych z użyciem mechanizmu serializacji. Zapraszam do lektury.
---

{% include toc %}

{% include kurs-java-notice.md %}

## Czym jest serializacja

W jednym z poprzednich artykułów przeczytałeś o [strumieniach danych]({% post_url 2016-08-17-operacje-na-plikach-w-jezyku-java %}), które pozwalały na zapisywanie oraz odczytywanie danych. Poznałeś wówczas między innymi klasy `DataInputStream` oraz `DataOutputStream`. Klasy te pomagają zapisywać typy proste i łańcuchy znaków.

Serializacja to wbudowany mechanizm zapisywania obiektów, który pozwala na binarny zapis całego drzewa obiektów. Oznacza to tyle, że jeśli mamy obiekt X, który posiada referencję do obiektu Y to serializując X również Y zostanie automatycznie zapisany w strumieniu wyjściowym.

Tak zapisany obiekt możesz później otworzyć przy kolejnym uruchomieniu programu. Jednak serializacja ma więcej zastosowań.

Dzięki temu mechanizmowi można na przykład przesyłać obiekty przez sieć. Obiekt, który stworzyliśmy na jednym komputerze (wewnątrz pamięci jednej wirtualnej maszyny Java) może być zserializowany, przesłany przez sieć i zdeserializowany na drugim komputerze tworząc nową instancję obiektu (wewnątrz pamięci drugiej wirtualnej maszyny Javy). Na obu tych komputerach wirtualna maszyna Javy musi mieć dostęp do skompilowanej wersji klasy.

## Warunki wymagane do serializacji

Chociaż serializacja dostępna jest automatycznie dla większości obiektów z biblioteki standardowej to jeśli chcesz móc serializować instancje klas, które sam napiszesz musisz spełnić kilka warunków.

### Interfejs [`java.io.Serializable`](https://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html)

Jest to tak zwany interfejs znacznikowy, innymi słowy nie zwiera on żadnej metody. Służy on do pokazania wirtualnej maszynie, że instancje danej klasy implementującej ten interfejs mogą być serializowane. Musisz implementować ten interfejs jeśli chcesz aby twoje klasy były serilizowalne. Jeśli będziesz próbował zserializować klasę, która nie implementuje tego interfejsu zostanie rzucony wyjątek typu [`NotSerializableException`](https://docs.oracle.com/javase/8/docs/api/java/io/NotSerializableException.html).
### Konstruktor bezparametrowy

Tutaj reguła niestety nie jest trywialna. Pierwsza klasa w hierarchii dziedziczenia, która nie jest serializowalna musi mieć dostępny konstruktor bezparametrowy. Łatwiej to będzie zrozumieć na przykładzie:

```java
public class Fruit {}
public class Apple extends Fruit implements Serializable {}
public class Tomato implements Serializable {}
```

W przykładzie powyżej klasa `Fruit` musi mieć konstruktor bezparametrowy abyśmy mogli poprawnie serializować instancje klasy `Apple`. Natomiast ani `Apple`, ani `Tomato` takiego konstruktora już nie wymagają (`Tomato` dziedziczy po `Object`, który taki konstruktor posiada).

Dodatkowo istnieje interfejs [`java.io.Externalizable`](https://docs.oracle.com/javase/8/docs/api/java/io/Externalizable.html) (opiszę go dokładnie kilka akapitów niżej), który również zapewnia, że obiekty go implementujące są serializowalne. Jednak w tym przypadku obiekt taki musi także zapewnić konstruktor bezparametrowy, który jest wywoływany w trakcie deserializacji.

### Określić pola, które nie są serializowalne

Ten krok jest opcjonalny, jednak w bardziej zaawansowanych przypadkach niezbędny. Wyobraź sobie, że napisałeś klasę `Human`, która jako jeden z atrybutów posiada wiek zapisany w minutach od urodzenia. Zapisanie tego pola mogłoby prowadzić do odczytania niepoprawnego stanu (zapisujemy obiekt dzisiaj, odczytujemy jutro, wiek w minutach jest zupełnie inny).

Tutaj dochodzimy do słowa kluczowego `transient`. Otóż słowo to może być stosowane przed atrybutami klasy. Oznacza ono, że dany atrybut nie jest serializowalny i zostanie pominięty przez mechanizm serializacji[^serializacja].

[^serializacja]: Istnieje też inny, mniej popularny sposób ominięcia pól podczas serializacjim– użycie pola `serialPersistentFields` (jest ono dokładniej opisane w [specyfikacji](http://docs.oracle.com/javase/8/docs/platform/serialization/spec/serial-arch.html#a6250)).

## Przykład serializacji obiektu

Proszę zwróć uwagę na fragment kodu poniżej, który pokazuje jak mechanizm serializacji działa w praktyce.

```java
try (ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream("objects.bin"))) {
    outputStream.writeObject(Integer.valueOf(1));
    outputStream.writeObject(Integer.valueOf(2));
}

try (ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream("objects.bin"))) {
    Integer number = (Integer) inputStream.readObject();
    System.out.println(number);
    number = (Integer) inputStream.readObject();
    System.out.println(number);
}
```

W pierwszym bloku [try-with-resources]({% post_url 2016-08-25-konstrukcja-try-with-resources-w-jezyku-java %}) otwieramy strumień typu [`ObjectOutputStream`](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectOutputStream.html), na którym następnie wywołujemy metodę `writeObject` zapisując do strumienia dwie liczby.

W kolejnym bloku dzięki instancji [`ObjectInputStream`](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectInputStream.html) odczytujemy wcześniej zapisane obiekty. Obiekty odczytywane są w takiej samej kolejności w jakiej zostały zapisane, w naszym przypadku na konsoli zostaną wyświetlone liczby 1 a później 2.

## Serializacja drzewa obiektów

Wspomniałem już wcześniej, że mechanizm serializacji automatycznie obsługuje drzewa obiektów. W przykładzie poniżej pokazana jest właśnie taka sytuacja. Instancja klasy `Car` posiada atrybuty typów `Engine` oraz `Tyre[]`. Serializując a następnie deserializując instancję tej klasy wszystkie jej atrybuty zostały także zapisane.

```java
Tyre[] tyres = new Tyre[] {new Tyre(16), new Tyre(16), new Tyre(16), new Tyre(16)};
Engine engine = new Engine("some model");
Car serializedCar = new Car(engine, tyres);
try (ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream("object-graph.bin"))) {
    outputStream.writeObject(serializedCar);
}

Car deserializedCar = null;
try (ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream("object-graph.bin"))) {
    deserializedCar = (Car) inputStream.readObject();
    System.out.println(deserializedCar.getEngine().getModel());
    System.out.println(deserializedCar.getTyres().length);
}

System.out.println(serializedCar == deserializedCar);
```

Zwróć proszę uwagę na ostatnią linię. W linijce tej porównywane są dwa adresy instancji klasy `Car` (pamiętasz [różnicę między `==` a `equals`]({% post_url 2016-04-17-porownywanie-obiektow-metody-equals-i-hashcode-w-jezyku-java %})?). Oczywiście linijka ta wyświetli `false` na konsoli co dowodzi, że w procesie deserializacji został stworzony zupełnie nowy obiekt klasy `Engine`.

## Deserializacja atrybutów `transient`

Zaraz, jak to? Przecież kilka akapitów wyżej napisałem, że atrybuty poprzedzone słowem kluczowym transient nie są serializowane. Tak to prawda, jednak podczas deserializacji atrybuty tego typu należy zainicjalizować pewną wartością. Otóż dla każdego typu mamy taką domyślną wartość:
- `boolean` - `false`,
- liczby całkowite (`int`, `long`, itd.) - `0`,
- liczby ułamkowe (`float`, `duble`) - `0.0`,
- obiekty (`Integer`, `Float`, `String`, `CustomClass`, itd.) - `null`

```java
public class Human implements Serializable {
    private static final long serialVersionUI<code>D = 1L;

    private transient Integer age;
    private String name;

    public Human(String name, Integer age) {
        this.age = age;
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public String getName() {
        return name;
    }

    public static void main(String[] args) throws IOException, ClassNotFoundException {
        Human human = new Human("Krzysiek", 21);

        try (ObjectOutputStream output = new ObjectOutputStream(new FileOutputStream("human.bin"))) {
            output.writeObject(human);
        }

        try (ObjectInputStream input = new ObjectInputStream(new FileInputStream("human.bin"))) {
            Human readHuman = (Human) input.readObject();
            System.out.println(readHuman.getName());
            System.out.println(readHuman.getAge());
        }
    }
}
```

W przykładzie powyżej po deserializacji pole `age` będzie miało wartość `null` ponieważ jest to wartość domyślna dla atrybutów poprzedzonych słowem kluczowym `transient`, które są obiektami.
## Pola statyczne a serializacja

Serializacja dotyczy instancji klasy, nie samej klasy. Zatem jeśli zmodyfikowałeś pole statyczne a następnie zdeserializowałeś taki obiekt wprowadzone zmiany zostaną pominięte. Proszę spójrz na przykład poniżej.

```java
StaticSerialization object = new StaticSerialization();
object.someField = 200;
System.out.println(object.someField);

try (ObjectOutputStream output = new ObjectOutputStream(new FileOutputStream("static.bin"))) {
    output.writeObject(object);
}
```

W przykładzie tym modyfikujemy wartość pola statycznego `someField` a następnie serializujemy instancję klasy do pliku.

```java
try (ObjectInputStream input = new ObjectInputStream(new FileInputStream("static.bin"))) {
    StaticSerialization otherObject = (StaticSerialization) input.readObject();
    System.out.println(otherObject.someField);
}
```

W drugim uruchomieniu programu (w którym nie zmodyfikowaliśmy wartości atrybutu statycznego `someField`) deserializujemy ten sam plik. W tym przypadku otrzymamy wartość 100 a nie 200, które miał obiekt zapisywany do pliku.

To co trzeba zapamiętać to to, że pola statyczne nie są serializowane a są pobierane z _aktualnej_ definicji klasy (nie z klasy z momentu serializacji).

Możemy powiedzieć, że atrybuty `static` są też domyślnie `transient`. Jak zatem takie zmiany odzwierciedlić podczas deserializacji? Jest na to sposób :)

## Specjalna obsługa serializacji/deserializacji

W specyficznych przypadkach masz możliwość zmodyfikowania domyślnego zachowania mechanizmu serializacji. Możesz to zrobić jeśli zaimplementujesz poniższe metody.

```java
private void readObject(java.io.ObjectInputStream stream) throws IOException, ClassNotFoundException
private void writeObject(java.io.ObjectOutputStream stream) throws IOException
```

Poniższy przykład powinien Ci pomóc w zrozumieniu tego mechanizmu

```java
public class CustomSerialization implements Serializable {
    private static final long serialVersionUID = 1L;
 
    private transient int someField;
    private String otherField;
 
    public CustomSerialization(int someField, String otherField) {
        this.someField = someField;
        this.otherField = otherField;
    }
 
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        CustomSerialization writtenObject = new CustomSerialization(10, "something");
 
        try (ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream("custom-serialization.bin"))) {
            outputStream.writeObject(writtenObject);
        }
 
        try (ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream("custom-serialization.bin"   ))) {
            CustomSerialization readObject = (CustomSerialization) inputStream.readObject();
            System.out.println(readObject.someField);
            System.out.println(readObject.otherField);
        }
    }
 
    private void readObject(ObjectInputStream stream) throws IOException, ClassNotFoundException {
        someField = stream.readInt();
        otherField = stream.readUTF();
    }
 
    private void writeObject(ObjectOutputStream stream) throws IOException {
        stream.writeInt(someField);
        stream.writeUTF(otherField + " SERIALIZED!");
    }
}
```

Jak widzisz obie metody są tu zaimplementowane. `writeObject` jako argument dostaje strumień, do którego powinniśmy zapisać nasz obiekt. W przykładzie zapisuję zarówno wartość pola z modyfikatorem `transient` jak i delikatnie zmienioną wartość atrybutu `otherField`.

Metoda `readObject` jako jedyny argument przyjmuje strumień, z którego powinniśmy odczytać stan obiektu. Podobnie jak w przypadku samej serializacji, pola odczytujemy w tej samej kolejności w której je wcześniej zapisywaliśmy.

Warto tutaj zwrócić uwagę na to, że klasa `ObjectInputStream` posiada metodę [`defaultReadObject`](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectInputStream.html#defaultReadObject—), która przeprowadza standardową deserializację, którą możesz rozszerzyć. Podobnie wygląda to w przypadku klasy `ObjectOutputStream` i metody [`defaultWriteObject`](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectOutputStream.html#defaultWriteObject--). Metody te mogą być wywołane wyłącznie w trakcie (de)serializacji obiektu.

## Serializacja a dziedziczenie

W poprzednich przykładach użyliśmy klasy `Engine`, która implementuje interfejs `Serializable`. Załóżmy, że utworzyliśmy klasę `DieselEngine`, która dziedziczy po `Engine`. Automatycznie instancje klasy `DieselEngine` będą implementowały interfejs `Serializable` (dziedzicząc go z `Engine`). Co powinniśmy zrobić jeśli nie chcielibyśmy aby nasz `DieselEngine` był serializowalny? Należy użyć wspomnianego już wyjątku `NotSerializableException` jak w przykładzie poniżej:

```java
public class DieselEngine extends Engine {
    public DieselEngine() {
        super("diesel");
    }
 
    private void writeObject(ObjectOutputStream out) throws IOException {
        throw new NotSerializableException("DieselEngine isn't serializable!");
    }
 
    private void readObject(ObjectInputStream in) throws IOException {
        throw new NotSerializableException("DieselEngine isn't serializable!");
    }
}
```

## Pełny wpływ na mechanizm serializacji

Istnieje jeszcze jeden, dużo mniej popularny sposób zapewnienia iż obiekt może być serializowany. Jest nim interfejs `Externalizable`. W tym przypadku interfejs ten zawiera dwie metody, które musimy zaimplementować. Dodatkowo takie klasy muszą mieć konstruktor bezparametrowy, reszta pozostaje bez zmian. W przypadku tego podejścia cały protokół serializacji, kolejność zapisanych pól, format etc. leży po naszej stronie. Poniżej prosty przykład, w którym używam właśnie takiego podejścia.

W tym przypadku do utworzenia obiektu mechanizm serializacji używa standardowego konstruktora bezparametrowego. Po czym wywołuje na tej instancji metodę `readExternal`.

```java
public class CustomProtocolSerialization implements Externalizable {
    private String field;
 
    public CustomProtocolSerialization() {
    }
 
    public CustomProtocolSerialization(String field) {
        this.field = field;
    }
 
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        CustomProtocolSerialization object = new CustomProtocolSerialization("field value");
 
        try (ObjectOutputStream output = new ObjectOutputStream(new FileOutputStream("externalizable.bin"))) {
            output.writeObject(object);
        }
 
        try (ObjectInputStream input = new ObjectInputStream(new FileInputStream("externalizable.bin"))) {
            CustomProtocolSerialization readObject = (CustomProtocolSerialization) input.readObject();
            System.out.println(readObject.field);
        }
    }
 
    public void writeExternal(ObjectOutput out) throws IOException {
        out.writeUTF(field);
    }
 
    public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
        field = in.readUTF();
    }
}
```

## Pole `serialVersionUID`

Dodatkowo musisz wiedzieć o statycznym polu w klasie o nazwie `serialVersionUID`. Jego pełna definicja wygląda następująco:

```java
private static long serialVersionUID;
```

Pole to ma specyficzne zastosowanie. Mechanizm serializacji używa go do upewnienia się, że deserializowany obiekt „pasuje” do danych zapisanych w strumieniu. Wie o tym na podstawie wartości tego pola. Jeśli w zdeserializowanym obiekcie wartość tego pola jest taka sama jak aktualnej definicji klasy wówczas można bezpiecznie przeprowadzić deserializację.

Kiedy taka sytuacja może wystąpić? Załóżmy, że dzisiaj napiszesz klasę `Human`, zdeserializujesz jej instancję i zapiszesz w pliku na dysku. Po jakimś czasie wprowadzisz zmiany w klasie i będziesz chciał odczytać starą wersję z pliku. W niektórych przypadkach taka operacja nie będzie dozwolona. Właśnie wtedy pole `serialVersionUID` może pomóc w wykryciu takiej sytuacji.

Pole to możesz ustawić samodzielnie, jeśli tego nie zrobisz kompilator wygeneruje tę wartość za Ciebie na podstawie definicji klasy.

## Materiały dodatkowe

Na początek zestaw dokumentacji do klas, związanych z tematem, jak zwykle znajdziesz tam ogrom informacji.
- [Serializable](https://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html)
- [Externalizable](https://docs.oracle.com/javase/8/docs/api/java/io/Externalizable.html)
- [ObjectOutputStream](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectOutputStream.html)
- [ObjectInputStream](https://docs.oracle.com/javase/8/docs/api/java/io/ObjectInputStream.html)
- [NotSerializableException](https://docs.oracle.com/javase/8/docs/api/java/io/NotSerializableException.html)

Dodatkowo możesz zajrzeć do [specyfikacja mechanizmu serializacji](https://docs.oracle.com/javase/8/docs/platform/serialization/spec/serialTOC.html) albo [artykułu na stronie Oracle](http://www.oracle.com/technetwork/articles/java/javaserial-1536170.html). Znalazłem też inne opracowanie, które poruszą także zagadnienie [serializacji, także do formatu XML](http://wazniak.mimuw.edu.pl/index.php?title=PO_Serializacja). Możesz też rzucić okiem na [przykłady użyte w tym artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/18_serializacja/src/main/java/pl/samouczekprogramisty/kursjava/serialization).

## Zadania

Na koniec jak zwykle zadania dla Ciebie do przećwiczenia materiału z tego artykułu.
- Napisz program, który poprosi użytkownika o wprowadzenie kilku imion, imiona te zapisz w liście a następnie zserializuj ją do pliku. Napisz metodę, która odczyta ten plik i wyświetli zawartość listy na konsoli. Wiesz, że właśnie napisałeś prostą bazę danych? ;)
- Napisz klasę `Human`, która będzie miała dwa atrybuty `name` typu `String` oraz `age` typu `int`. Jak należałoby serializować instancje tej klasy aby zawsze poprawnie deserializować wiek (z dokładnością do roku)? (Wskazówka, możesz użyć metody `Calendar.getInstance().get(Calendar.YEAR)`, która zwraca aktualny rok)

Przygotowałem też dla Ciebie [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/18_serializacja/src/main/java/pl/samouczekprogramisty/kursjava/serialization/exercise) powyższych zadań, jednak traktuj je proszę jako ostatnią deskę ratunku :) Więcej nauczysz się próbując samemu rozwiązać powyższe zadania.

## Podsumowanie

Po przeczytaniu tego artykułu wiesz już czym są klasy `ObjectOutputStream` i `ObjectInputStream`. Znasz zasady serializacji, poznałeś słowo kluczowe `transient`. Teraz jesteś w stanie zapisać i odczytać każdą instancję klasy, którą stworzysz.

Bardzo się cieszę, że przeczytałeś cały artykuł. Na koniec mam do Ciebie prośbę. Proszę przekaż adres bloga swoim znajomym, w grupie uczy się raźniej ;) Jeśli nie chcesz ominąć nowych artykułów dopisz się do newslettera i polub stronę Samouczka na facebooku. Miłego dnia i do następnego razu :)

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/28653536@N07/.
