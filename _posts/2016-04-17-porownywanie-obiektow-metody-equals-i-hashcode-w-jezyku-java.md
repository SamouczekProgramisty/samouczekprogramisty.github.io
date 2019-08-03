---
last_modified_at: 2019-02-13 15:22:30 +0100
title: Porównywanie obiektów, metody equals i hashCode w języku Java
categories:
- Kurs programowania Java
permalink: /porownywanie-obiektow-metody-equals-i-hashcode-w-jezyku-java/
header:
    teaser: /assets/images/2016/04/17_equals_hashcode_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2016/04/17_equals_hashcode_w_jezyku_java_artykul.jpg
    caption: "[&copy; badgreeb\_records](https://www.flickr.com/photos/badgreeb\_records/6453502559)"
excerpt: W dzisiejszym artykule będziesz mógł przeczytać o właściwym sposobie porównywania obiektów i typów prostych w języku Java. Dowiesz się do czego służą metody `equals` oraz `hashCode` oraz przeczytasz o tak zwanym kontrakcie między tymi metodami. Na koniec będzie na Ciebie czekało małe ćwiczenie do wykonania samodzielnie. Zapraszam do artykułu.
disqus_page_identifier: 286 http://www.samouczekprogramisty.pl/?p=286
---

{% include kurs-java-notice.md %}

## Porównywanie typów prostych

Do sprawdzenia "równości" typów prostych służą operatory `==` oraz `!=`. Dzięki nim możemy porównać ze sobą każdą zmienną typu prostego. Wynikiem takiego porównania jest wartość typu `boolean` – `true` jeśli porównywane obiekty są równe i `false` w przeciwnym wypadku. Proszę spójrz na przykład poniżej:

```java
System.out.println("10 == 10: " + (10 == 10));
System.out.println("10 != 10: " + (10 != 10));
System.out.println("true == true: " + (true == true));
System.out.println("true != true: " + (true != true));
System.out.println("'a' == 'a': " + ('a' == 'a'));
System.out.println("'a' != 'a': " + ('a' != 'a'));
System.out.println("500L == 500L: " + (500L == 500L));
System.out.println("500L != 500L: " + (500L != 500L));
```

Kolejne linijki porównują odpowiednio:
- liczby typu `int`,
- zmienne typu `boolean`,
- znaki typu `char`,
- liczby typu `long`.

### Priorytety operatorów

Drobna dygresja dotycząca priorytetów operatorów. W języku Java wszystkie operatory mają tak zwany priorytet. Oznacza to tyle, że priorytet operatorów określa kolejność wykonywania działań. Proszę spójrz na przykład niżej

```java
10 == 4 + 6
4 + 6 == 10
3 * 5 + 2
```

Operator `+` ma wyższy priorytet niż operator `==`. W związku z tym operacja dodawania wykonana zostanie jako pierwsza i porównanie zwróci true. Podobnie `*` ma wyższy priorytet niż `+`. Zatem na początku wykonana zostanie operacja mnożenia a na końcu dodawanie.

Czasami jednak domyślny priorytet operatorów nie jest odpowiedni, chcielibyśmy wykonać operacje w innej kolejności. Z pomocą przychodzą nawiasy, które pozwalają na modyfikację zachowania programu. Przykład poniżej pomaga zrozumieć jak to działa:

```java
3 * (5 + 2)
```

Mimo tego, że operator `*` ma wyższy priorytet niż `+` operacja mnożenia zostanie wykonana jako druga. Pierwsze zostanie wykonane dodawanie ponieważ zostało otoczone parą nawiasów.

Po tym wstępie mogę wyjaśnić dlaczego w przykładzie poniżej potrzebujemy nawiasów:

```java
"10 == 10: " + 10 == 10 // compilation error!
"10 == 10: " + (10 == 10)
```

Bez dodatkowej pary nawiasów pierwszeństwo miałby operator `+`. `"10 == 10: " + 10 == 10` inaczej możemy zapisać jako `"10 == 10: 10"  == 10`, a taki zapis nie jest poprawny. Jest błędny, ponieważ operatorem `==` nie możemy porównać instancji typu `String` i wartości typu `int`.

{% include newsletter-srodek.md %}

## Porównywanie zmiennoprzecinkowych typów prostych

O ile sprawdzanie równości wartości liczb całkowitych nie jest trudne to ta sama operacja dla typów zmiennoprzecinkowych jest trochę bardziej skomplikowana. W związku ze sposobem reprezentacji liczb zmiennoprzecinkowych typu `float` i `double` w pamięci komputera nie jest możliwe ich dokładne porównywanie. Operacja taka jest dopuszczalna ale może prowadzić do dziwnych rezultatów (na przykład, liczby, które teoretycznie powinny być równe według komputera nie są).

W związku z tym liczby zmiennoprzecinkowe powinno się porównywać z pewną dokładnością.

```java
System.out.println("0.3 == 0.1 + 0.2: " + (0.3 == 0.1 + 0.2)); // !!!
System.out.println("0.3 == 0.1 + 0.2: " + (Math.abs(0.3 - (0.1 + 0.2)) < 0.000001));
```

W przykładzie powyżej została użyta metoda `Math.abs()`. Metoda ta zwraca [wartość bezwzględną](https://pl.wikipedia.org/wiki/Warto%C5%9B%C4%87_bezwzgl%C4%99dna) danej liczby. Następnie wartość tę porównujemy z bardzo małą liczbą. Liczba ta reprezentuje dokładność porównania. Jeśli różnica liczb jest mniejsza niż nasza założona dokładność uznajemy, że porównywane liczby są równe.

## Porównanie obiektów

Używając operatora `==` do porównywania obiektów uzyskamy błędne rezultaty. Do porównania tego typu powinniśmy używać metody equals.

```java
System.out.println("test == test: " + (new String("test") == new String("test")));
System.out.println("test equals test: " + new String("test").equals(new String("test")));
```

Dlaczego tak się dzieje? Otóż w przypadku obiektów operator `==` porównuje referencje obiektów (adresy na stercie). Mając dwie różne instancje obiektów mają one dwa różne adresy w pamięci w związku z tym zawsze ich adresy są różne. Innymi słowy w przypadku obiektów przy pomocy operatora `==` możemy sprawdzić czy dwie referencje wskazują na ten sam obiekt.

```java
String reference1 = new String("something");
String reference2 = reference1;
System.out.println("reference1 == reference2: " + (reference1 == reference2));
```

## Metoda `equals`

Metoda `equals` jest jedną z metod dostępnych w klasie `Object`. W związku z tym, że każdy obiekt w języku Java ma tę klasę w swojej hierarchii dziedziczenia możemy tą metodą wywołać na każdym obiekcie.

W większości przypadków domyślna implementacja metody `equals` nie jest odpowiednia[^porownanie] w związku z tym programista tworzący nowy obiekt musi tę metodę zaimplementować jeśli chce sprawdzać czy instancje tej klasy są równe.

[^porownanie]: Domyślna implementacja zachowuje się jak operator `==`, porównuje adresy obiektów.

Istnieje zestaw wytycznych, które metoda `equals` powinna spełniać aby była poprawnie zaimplementowana. Opiszę je po kolei:

### Metoda `equals` powinna być [zwrotna](https://pl.wikipedia.org/wiki/Relacja_zwrotna)

Oznacza to tyle, że dla każdego obiektu operacja `object.equals(object)` powinna zwrócić `true`.

### Metoda `equals` powinna być [symetryczna](https://pl.wikipedia.org/wiki/Relacja_symetryczna)

Oznacza to tyle, że dla każdej pary obiektów `X` i `Y` powinna zachodzić właściwość jeśli `X.equals(Y) == true` wówczas także `Y.equals(X) == true`.

### Metoda equals powinna być [przechodnia](https://pl.wikipedia.org/wiki/Relacja_przechodnia)

Jeśli mamy trzy obiekty `X`, `Y` i `Z` oraz jeśli `X.equals(Y) == true` i `Y.equals(Z) == true` to także `X.equals(Z)` jest prawdą.

### Metoda `equals` powinna być spójna

Innymi słowy kilkukrotne wywołanie metody `equals` na tych samych obiektach zawsze powinno zwrócić ten sam wynik (zakładając, że obiekty nie były modyfikowane pomiędzy wywołaniami).

### Metoda `equals` powinna zwrócić `false` przy porówaniu z `null`

Dla każdego obiektu `X`, który nie jest `null` porównanie typu `X.equals(null)` powinno zwrócić `false`.

Załóżmy, że mamy klasę `Chair`. Możemy powiedzieć, że krzesła są "równe" jeśli zostały wyprodukowane w tym samym roku, przez tego samego producenta oraz są tego samego modelu. Założenia te zostały zaimplementowane poniżej.

```java
public class Chair {
    private String model;
    private String manufacturer;
    private int productionYear;
 
    public Chair(String model, String manufacturer, int productionYear) {
        this.model = model;
        this.manufacturer = manufacturer;
        this.productionYear = productionYear;
    }   
 
    public String getModel() {
        return model;
    }   
 
    public String getManufacturer() {
        return manufacturer;
    }   
 
    public int getProductionYear() {
        return productionYear;
    }
 
    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (obj instanceof Chair) {
            Chair otherChair = (Chair) obj;
            return model.equals(otherChair.model) &&
                    manufacturer.equals(otherChair.manufacturer) &&
                    productionYear == otherChair.productionYear;
        }
        return false;
    }
 
    @Override
    public int hashCode() {
        return 17 * model.hashCode() + 31 * manufacturer.hashCode() + 7 * productionYear;
    }
}
 
Chair chair1 = new Chair("Adde", "IKEA", 2016); 
Chair chair2 = new Chair("Janinge", "IKEA", 2016); 
Chair chair3 = new Chair("Adde", "IKEA", 2015); 
Chair chair4 = new Chair("Adde", "IKEA", 2016);
 
System.out.println("chair1.equals(chair2): " + chair1.equals(chair2)); 
System.out.println("chair1.equals(chair3): " + chair1.equals(chair3)); 
System.out.println("chair1.equals(chair4): " + chair1.equals(chair4)); 
System.out.println("chair1.equals(null): " + chair1.equals(null));
```

Zauważ, że w naszej implementacji metody `equals` używamy także metody `equals` z typu `String` aby sprawdzić czy model i producent są równi.

Nowy może być także operator `instanceof`, służy on do sprawdzenia czy dana instancja jest typu `Chair`. Po tym sprawdzeniu możemy bezpiecznie rzutować obiekt `obj` i mamy pewność, że nie zostanie rzucony wyjątek `ClassCastException`.

## Metoda `hashCode`

Podobnie jak w przypadku `equals` `hashCode` jest zaimplementowane w klasie `Object`. Zawsze kiedy programista implementuje metodę `hashCode` powinien też zaimplementować metodę`equals`.

Metoda ta zwraca liczbę typu int, która służy do przyporządkowania danego obiektu do grupy. Dzięki metodzie `hashCode` jesteśmy w stanie podzielić wszystkie możliwe instancje danej klasy na rozdzielne grupy. Każda z tych grup reprezentowana jest przez liczbę zwracaną przez metodę `hashCode`.

{% include figure image_path="/assets/images/2016/04/17_hashCode.jpg" caption="`hashCode` zasada działania." %}

Obrazowe przyporządkowanie obiektów do grup zostało przedstawione na diagramie powyżej. Koła i trójkąt zostały przyporządkowane do tej samej grupy, rąb i pięciokąt do grupy Hash#2 natomiast trapez został przyporządkowany do grupy Hash#3.

Metoda `hashCode` wykorzystywana jest przez niektóre kolekcje (tablice na sterydach), o których przeczytasz [w jednym z kolejnych artykułów]({% post_url 2016-08-09-kolekcje-w-jezyku-java %}). Implementacja metody `hashCode` sprowadza się do zwrócenia odpowiedniej liczby, tak zwanego hasha. Przyporządkuje on dany obiekt do grupy używanej w niektórych kolekcjach. Najczęściej metodę `hashCode` implementuje się w oparciu o hashe atrybutów danej instancji. Hashe atrybutów zazwyczaj mnoży się przez liczby pierwsze i sumuje ze sobą. Użycie liczb pierwszych pomaga w uzyskaniu "dobrych hashy". Dobra implementacja `hashCode` pozwala na uzyskanie jak największej liczby grup (hashy), do których przyporządkowujemy obiekty.

Posłużę sie tu klasą `Chair` wspomianą wyżej. Zakładając, że nasza klasa ma trzy atrybuty i żaden z nich nie może mieć wartości `null` przykładowa implemetacja może wyglądać następująco:

```java
@Override
public int hashCode() {
    return 17 * model.hashCode() + 31 * manufacturer.hashCode() + 7 * productionYear;
}
```

W większości przypadków użycie metody [`Objects.hash`]({{ site.doclinks.java.lang.Objects }}#hash-java.lang.Object...-) przy implementacji metody `hashCode` jest dobrym pomysłem.

## Kontrakt między metodami `equals` i `hashCode`

Metody `hashCode` i `equals` są ze sobą powiązane i ich implementacja powinna być spójna. Tą zależność określa się kontraktem między metodami `hashCode` i `equals`.

- Jeśli `X.equals(Y) == true` wówczas wymagane jest aby `X.hashCode() == Y.hashCode()`,
- Kilkukrotne wywołanie metody `hashCode` na tym samym obiekcie, który nie był modyfikowany pomiędzy wywołaniami musi zwrócić tę samą wartość,
- Jeśli `X.hashCode() == Y.hashCode()` to nie jest wymagane aby `X.equals(Y) == true`.

Trzeci przypadek jest ilustrowany na obrazku powyżej gdzie koła i trójkąt mają ten sam `hashCode` jednak koło i trójkąt nie są równe.

## Generatory metod `hashCode` i `equals`

Implementacja tych metod w większości przypadków jest dość prosta. W większości z nich także nie jest to kod zbyt skomplikowany. Jednak za każdym razem pisanie tych metod jest uciążliwe. Z pomocą przychodzi IDE. Polecam generowanie tych metod przy jego pomocy. W przypadku IntelliJ IDEA pomocny może okazać się skrót klawiaturowy `Alt+Insert`. Po jego naciśnięciu pokaże się menu kontekstowe pozwalające na wygenerowanie tych metod.

Dodatkowo warto przyjrzeć się klasie `Objects` i bibliotekom [Guava](https://github.com/google/guava) czy [Apache commons-lang](https://commons.apache.org/proper/commons-lang/). Zawierają one metody pomocnicze użyteczne podczas implementacji metod `hashCode` i `equals`.

## Zadanie

Na koniec krótkie zadanie dla Ciebie. Napisz klasę reprezentującą człowieka, zaimplementuj metody `hashCode` i `equals`. Zastanów się czy to, że ktoś ma to samo imię i nazwisko sprawia, że jest to ta sama osoba? Jaki atrybut może posłużyć do sprawdzenia czy dwie instancje klasy `Human` reprezentują tę samą osobę?

Jeśli będziesz miał problem z rozwiązaniem zadania [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/tree/master/14_porownywanie_obiektow/src/main/java/pl/samouczekprogramisty/kursjava/equality) umieściłem na githubie. Jak zwykle zachęcam do samodzielnych prób, wtedy nauczysz się najwięcej.

## Materiały dodatkowe

Kod źródłowy wszystkich przykładów użytych w artykule znajduje się na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/14_porownywanie_obiektow/src/main/java/pl/samouczekprogramisty/kursjava/equality). Jeśli chcesz poczytać więcej na temat metod `equals` i `hashCode` zapraszam do materiałów dodatkowych:
- [{{ site.doclinks.java.lang.Object }}#equals-java.lang.Object-]({{ site.doclinks.java.lang.Object }}#equals-java.lang.Object-)
- [{{ site.doclinks.java.lang.Object }}#hashCode--]({{ site.doclinks.java.lang.Object }}#hashCode--)
- [{{ doclinks.specs.jls }}jls-15.html#jls-15.21]({{ doclinks.specs.jls }}jls-15.html#jls-15.21)
- [http://kobietydokodu.pl/niezbednik-juniora-kontrakt-hashcode-i-equals](http://kobietydokodu.pl/niezbednik-juniora-kontrakt-hashcode-i-equals/)

## Podsumowanie

Bardzo się cieszę, że dotarłeś do końca artykułu. Mam nadzieję, że był on dla Ciebie ciekawy i przydatny. Na koniec mam do Ciebie prośbę, podziel się artykułem ze swoimi znajomymi, zależy mi na dotarciu do jak największej liczby czytelników. Jeśli nie chcesz przegapić nowych artykułów polub nas na facebooku :) W przypadku jakichkolwiek pytań proszę zdaj je w komentarzach, postaram się odpowiedzieć.

Do następnego razu!
