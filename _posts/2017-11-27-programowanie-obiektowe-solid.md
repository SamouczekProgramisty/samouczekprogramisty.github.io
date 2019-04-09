---
title: SOLID czyli dobre praktyki w programowaniu obiektowym
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- Wiedza ogólna
- Programista rzemieślnik
permalink: /solid-czyli-dobre-praktyki-w-programowaniu-obiektowym/
header:
    teaser: /assets/images/2017/11/27_solid_dobre_praktyki_w_programowaniu_obiektowym_artykul.jpg
    overlay_image: /assets/images/2017/11/27_solid_dobre_praktyki_w_programowaniu_obiektowym_artykul.jpg
    caption: "[&copy; fdecomite](https://www.flickr.com/photos/fdecomite/5846492896/sizes/l)"
excerpt: W artykule tym przeczytasz o dobrych praktykach. Praktyki te opisane są przez akronim S.O.L.I.D. Można powiedzieć, że stały się one standardem w obiektowym podejściu do rozwijania oprogramowania. Po lekturze artykułu będziesz znał poszczególne składowe akronimu S.O.L.I.D. Przykładowe fragmenty kodu pozwolą zobaczyć Ci te wytyczne w praktyce. Zapraszam do lektury.
---

Artykuł ten zakłada, że znasz już podstawy języka programowania. Najlepiej gdybyś miał już za sobą drobny projekt, na przykład prosty kalkulator. Abyś mógł wynieść coś z tego artykułu musisz wiedzieć czym są [interfejsy]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}) i [dziedziczenie]({% post_url 2016-01-24-dziedziczenie-w-jezyku-java %}). Przydatne mogą być też pozostałe artykuły z [kursu programowania w języku Java]({{ "/kurs-programowania-java" | absolute_url }}).
{:.notice--info}

## Czym jest SOLID

S.O.L.I.D. to [akronim](https://pl.wikipedia.org/wiki/Skr%C3%B3towiec), który wymyślił [Robert C. Martin](https://en.wikipedia.org/wiki/Robert_C._Martin). Uncle Bob (taki ma pseudonim) jest programistą. Ma sporo doświadczenia, przez wielu uważany jest za swego rodzaju autorytet.

Akronim ten zbiera zestaw wytycznych. Wytyczne te stosuje się podczas pisania programów w sposób obiektowy. Samo słówko _solid_ można przetłumaczyć jako solidny, konkretny, mocny. Ta gra słów pewnie też miała spore znaczenie dla popularności samego akronimu.

Poniżej na przykładach postaram się wyjaśnić poszczególne literki.

### S jak Samodzielny

S pochodzi od _Single Responsibility Principle_. W oryginalnym wydaniu autor mówi o tym, że klasa powinna mieć wyłącznie jeden powód do zmiany. Wytyczna ta sprowadza się do tego, że dana klasa powinna mieć jeden główny cel. Jedną główną odpowiedzialność. Jedną funkcjonalność, którą realizuje.

Klasy, które implementują wyłącznie jedną odpowiedzialność nie są bezpośrednio związane (ang. _coupled_) z inną funkcjonalnością. Moim zdaniem, w większości przypadków łatwiej jest zrozumieć taki kod, który jest odpowiedzialny za jedną rzecz.

Twoje klasy powinny mieć motto: rób jedną rzecz, rób tę rzecz dobrze[^praktyka].

[^praktyka]: Wszystkie te reguły podlegają oczywiście dyskusji. W praktyce często ciężko jest zdefiniować czym ta "jedna" rzecz jest.

#### Przykład

W praktyce możesz pomyśleć o klasie, która przechowuje szczegóły umowy. Taką umowę czasami trzeba wydrukować. Niezbędne jest też obliczenie miesięcznej kwoty abonamentu. W przypadku upakowania tych dwóch odpowiedzialności do jednej klasy może ona wyglądać następująco:

```java
public class Contract {

    private final Date start;

    private final Date end;

    public Contract(Date start, Date end) {
        this.start = start;
        this.end = end;
    }

    public BigDecimal getMonthlySubscriptionFee() {
        // compute based on end and start
        return BigDecimal.ONE;
    }

    public byte[] formatAsPDF() {
        return "...".getBytes();
    }
}
```

Ewidentnie w tym przypadku mamy kilka powodów do zmiany. Jeśli zmieni się wymaganie dotyczące wydruków, czy sposobu obliczania abonamentu musimy zmienić klasę `Contract`. Literka S w SOLID zachęca do rozdzielenia tych zagadnień:

```java
public class Contract {

    private final Date start;

    private final Date end;

    public Contract(Date start, Date end) {
        this.start = start;
        this.end = end;
    }

    public Date getStart() {
        return start;
    }

    public Date getEnd() {
        return end;
    }

    public BigDecimal getMonthlySubscriptionFee() {
        // compute based on end and start
        return BigDecimal.ONE;
    }
}
```

```java
public class PDFFormatter {

    private final Contract contract;

    public PDFFormatter(Contract contract) {
        this.contract = contract;
    }

    public byte[] format() {
        return "...".getBytes();
    }
}
```

{% include newsletter-srodek.md %}

### O jak Otwarty

O pochodzi od _Open/Closed Principle_. W tym miejscu Uncle Bob zwraca uwagę na to aby kod, który tworzymy był "możliwy do rozszerzania i zamknięty na modyfikacje". Sprowadza się do do świadomego użycia kompozycji, [dziedziczenia]({% post_url 2016-01-24-dziedziczenie-w-jezyku-java %}) czy [modyfikatorów dostępu]({% post_url 2017-10-29-modyfikatory-dostepu-w-jezyku-java %}).

#### Przykład

Załóżmy, że firma poza umową chce też wydrukować ulotki. Drukarnia przyjmuje dokumenty w formacie PDF więc i ulotkę trzeba zapisać w tym właśnie formacie. Klasy `Contract` i `PDFFormatter` nie różnią się od poprzedniego przykładu. Aby zrealizować to wymaganie można utworzyć dwie nowe klasy:

```java
public class Leaflet {

    private final String title;

    private final String location;

    public Leaflet(String title, String location) {
        this.title = title;
        this.location = location;
    }

    public String getTitle() {
        return title;
    }

    public String getLocation() {
        return location;
    }
}
```
```java
public class LeafletPDFFormatter {

    private final Leaflet leaflet;

    public LeafletPDFFormatter(Leaflet leaflet) {
        this.leaflet = leaflet;
    }

    public byte[] format() {
        return "...".getBytes();
    }

}
```

Klasa `LeafletPDFFormatter` jest praktycznie taka sama jak klasa `PDFFormatter`. W tym przypadku klasa `PDFFormatter` nie spełnia wytycznych _Open/Closed Principle_. Nie można rozszerzyć jej funkcjonalności bez zmiany jej kodu źródłowego. Proszę spójrz na przykład poniżej:

```java
public class PDFMetadata {

    public final List<String> metadata;

    public PDFMetadata(String... metadata) {
        this.metadata = Arrays.asList(metadata);
    }

    public List<String> getMetadata() {
        return Collections.unmodifiableList(metadata);
    }
}
```
```java
public class Leaflet {

    // ...

    public PDFMetadata getPDFMetadata() {
        return new PDFMetadata(title, location);
    }
}
```
```java
public class Contract {

    // ...

    public PDFMetadata getPDFMetadata() {
        return new PDFMetadata(start.toString(), end.toString());
    }
}
```
```java
public class PDFFormatter {

    private final PDFMetadata metadata;

    public PDFFormatter(PDFMetadata metadata) {
        this.metadata = metadata;
    }

    public byte[] format() {
        return metadata.toString().getBytes();
    }

}
```

W tym przypadku wprowadziłem klasę `PDFMetadata`. Zawiera ona dane niezbędne do przygotowania wydruku PDF. Zarówno klasa `Leaflet` jak i `Contract` zwracają taką reprezentację. Dzięki temu klasa `PDFFormatter` może utworzyć wydruk dla każdej z nich. Zauważ, ze teraz klasa `PDFFormatter` jest otwarta na rozszerzenie. Jeśli Twoja nowa klasa będzie zwracała instancję `PDFMetadata` będzie można ją przekonwertować do formatu PDF.

### L jak [Liskov Barbara](http://www.pmg.csail.mit.edu/~liskov/)

L pochodzi od _Liskov Substitution Principle_. W przypadku tej wytycznej Twój kod powinien współpracować poprawnie z klasą, jak i wszystkimi jej podklasami. Innymi słowy jeśli zależysz od jakiegoś [interfejsu]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}) to wszystkie jego implementacje powinny poprawnie działać z Twoją klasą/metodą.

Stosowanie się do tej zasady pozwala na dostarczenie alternatywnej implementacji danej funkcjonalności bez zmiany Twojego kodu.

#### Przykład

W tym przypadku świetnym przykładem są [kolekcje w języku Java]({% post_url 2016-08-09-kolekcje-w-jezyku-java %}):

```java
public class SubstitutionExample {

    public static void main(String[] args) {
        List<String> someList = new ArrayList<>();
        Set<String> someSet = new HashSet<>();
        Queue<String> someQueue = new PriorityQueue<>();

        SubstitutionExample example = new SubstitutionExample();
        example.doSomethingWithElements(someList);
        example.doSomethingWithElements(someSet);
        example.doSomethingWithElements(someQueue);
    }

    public void doSomethingWithElements(Collection<String> someCollection) {
        for (String element : someCollection) {
            System.out.println("element: " + element);
        }
    }

}
```

Metoda `doSomethingWithElements` zrobi dokładnie to samo bez wiedzy o tym z jakim podtypem ma do czynienia. Niezależnie od tego czy będzie to `ArrayList` czy `PriorityQueue` metoda zadziała poprawnie.

### I jak Interfejsy

I pochodzi od _Interface Segregation Principle_. Wytyczna ta mówi o tym, abyś rozdzielał interfejs klasy. Interfejs ten powinien być odpowiednio zdefiniowany. Chodzi tu o aby inny fragment kodu, który używa Twojej klasy używał wyłącznie podzbioru metod, który jest w tamtym przypadku istotny. W oryginale wytyczna ta mówi o tym, ze klienty nie powinny być zmuszane do wprowadzania zależności od interfejsów, których nie używają.

Jeśli będziesz stosował się do tej wytycznej to zmiany Twoich klas powinny być łatwiejsze do przeprowadzenia. Dzięki jasno zdefiniowanym interfejsom ryzyko zmiany klas, które używają tych interfejsów będzie mniejsze.

#### Przykład

Załóżmy, ze w swoim interfejsie masz 3 metody:

```java
public interface ObjectFormatter {

    byte[] toPDF(Object someObject);

    String toXML(Object someObject);

    String toJSON(Object someObject);

}
```

Interfejs ten jest używany w trzydziestu innych projektach. W każdym przypadku używa wyłącznie jednej z tych trzech metod. Niestety z jakiegoś powodu musisz zmienić ten interfejs. W konsekwencji każdy z tych projektów musi wprowadzić jakieś zmiany. W praktyce rozdzielenie tego interfejsu na trzy oddzielne może mieć sens:

```java
public interface PDFFormatter {

    byte[] toPDF(Object someObject);

}
```
```java
public interface XMLFormatter {

    String toXML(Object someObject);

}
```
```java
public interface JSONFormatter {

    String toJSON(Object someObject);

}
```

W takim przypadku zmiana jednej z tych metod nie pociąga za sobą zmian w każdym z 30 wspomnianych projektów. 

### D jak oDwrócenie zależności

D pochodzi od _Dependency Inversion Principle_. Wytyczna ta mówi, że wysokopoziomowe klasy nie powinny zależeć od niskopoziomowych detali. Zależność ta powinna być odwrócona poprzez wprowadzenie dodatkowych elementów. Mówi się tu o dodatkowych warstwach abstrakcji, które pozwalają na zmianę kierunku takiej zależności.

Osobiście ciężko było mi tę zasadę zrozumieć bez dobrego przykładu. Mam nadzieję, że ten przytoczony poniżej trochę Ci to ułatwi.

#### Przykład

Przykład poniżej pokazuje klasę `PageCrawler`. Klasa ta ma powinna zwrócić odnośniki znajdujące się na stronie. Poza tym, że widzisz tu pogwałcenie zasady _Single Responsibility Principle_ to jeszcze  _Dependency Inversion Principle_ także nie jest spełnione. Klasa `PageCrawler` zleży od niskopoziomowych detali związanych z obsługą protokołu HTTP i parsowaniem HTML. Zależność ta powinna być odwrócona:

```java
public class PageCrawler {

    public List<String> findLinks(String url) throws IOException {
        HttpURLConnection connection = makeRequest(url);
        validateResponse(connection);
        String content = getResponse(connection);
        return parseLinks(content);
    }

    private List<String> parseLinks(String content) {
        return Collections.emptyList(); // do some magic with content
    }

    private String getResponse(HttpURLConnection connection) throws IOException {
        return connection.getContent().toString();
    }

    private HttpURLConnection makeRequest(String url) {
        return null; //
    }

    private void validateResponse(HttpURLConnection connection) throws IOException {
        if (connection.getResponseCode() != 200) {
            throw new IllegalStateException("Wrong response code!");
        }
        if (connection.getContentLength() < 100) {
            throw new IllegalStateException("Too small response!");
        }
    }
}
```

Poniższy przykład pokazuje wprowadzenie dwóch dodatkowych elementów. Są to odpowiednio `HTTPFetcher` i `HTMLTokenizer`. Klasy te odpowiedzialne są za ukrycie niskopoziomowych detali wymaganych przez `PageCrawler`. W tym przypadku `PageCrawler` zależy od tych dwóch klas. Odwróciłem więc zależność, teraz już wysokopoziomowa klasa (`PageCrawler`) nie zależy od niskopoziomowych detali (protokół HTTP czy parsowanie HTML).

```java
public class HTTPFetcher {

    public String fetch(String url) throws IOException {
        return "HTTP request details goes here";
    }
}
```
```java
public class HTMLTokenizer {

    public List<String> tokenize(String response) {
        return Collections.emptyList(); // details about HTML handling goes here
    }
}
```
```java
public class PageCrawler {

    private final HTTPFetcher fetcher;

    private final HTMLTokenizer tokenizer;

    public PageCrawler(HTTPFetcher fetcher, HTMLTokenizer tokenizer) {
        this.fetcher = fetcher;
        this.tokenizer = tokenizer;
    }

    public List<String> findLinks(String url) throws IOException {
        String response = fetcher.fetch(url);
        List<String> tokens = tokenizer.tokenize(response);
        return findLinks(tokens);
    }

    private List<String> findLinks(List<String> tokens) {
        return tokens; // pick only links here
    }
}
```

## Nie rób nic na ślepo

Z mojego doświadczenia wynika to, że nie można na ślepo stosować się do wszystkich reguł. Mogą zdarzyć się sytuacje, w których w swojej codziennej pracy znajdziesz przypadek gdzie złamanie wytycznych SOLID ma sens. Możliwe, że czasami napisanie klasy, która ma dziesięć różnych zakresów odpowiedzialności jest dobre. Możliwe, że to dopiero przyczółek do dalszej pracy nad kodem.

Postaraj się zrozumieć poszczególne wytyczne. Zacznij je rozważnie stosować dopiero po pełnym ich zrozumieniu. Robienie czegoś na ślepo tylko dlatego, że przeczytało się o tym w dowolnym miejscu moim zdaniem mija się z celem. Zastanów się nad SOLID, zrozum i dopiero wtedy zacznij stosować. Oczywiście tylko w przypadkach gdzie ma to sens :). Istotna jest także sama świadomość istnienia takich wytycznych. Prawdą jest, że nie wszyscy programiści są ich świadomi.

## Dodatkowe materiały do nauki

Z racji tego, że akronim ten jest powszechnie używany znajdziesz sporo informacji na jego temat w internecie. Poniżej zebrałem materiały źródłowe:

- [SOLID opisany przez Robert'a C. Martin'a](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod),
- [Single Responsibility Principle](https://drive.google.com/file/d/0ByOwmqah_nuGNHEtcU5OekdDMkk/view),
- [Open-Closed Principle](https://drive.google.com/file/d/0BwhCYaYDn8EgN2M5MTkwM2EtNWFkZC00ZTI3LWFjZTUtNTFhZGZiYmUzODc1/view),
- [Liskov Substitution Principle](https://drive.google.com/file/d/0BwhCYaYDn8EgNzAzZjA5ZmItNjU3NS00MzQ5LTkwYjMtMDJhNDU5ZTM0MTlh/view),
- [Interface Segregation Principle](https://drive.google.com/file/d/0BwhCYaYDn8EgOTViYjJhYzMtMzYxMC00MzFjLWJjMzYtOGJiMDc5N2JkYmJi/view),
- [Dependency Inversion Principle](https://drive.google.com/file/d/0BwhCYaYDn8EgMjdlMWIzNGUtZTQ0NC00ZjQ5LTkwYzQtZjRhMDRlNTQ3ZGMz/view).

Dodatkowo poniżej mam dla Ciebie książkę autorstwa twórcy akronimu S.O.L.I.D. Moim zdaniem jest to jedna z obowiązkowych pozycji na liście lektur każdego programisty:

- [The Clean Code](http://amzn.to/2ztqaSg)[^afiliacja],
- [Przykłady użyte w treści artykułu](https://github.com/SamouczekProgramisty/MaterialyRozne/tree/master/03_solid/src/main/java/pl/samouczekprogramisty/misc/solid).

[^afiliacja]: To jest link afiliacyjny. Oznacza to tyle, że jeśli kupisz ten produkt z tego odnośnika pomożesz mi w dalszym prowadzeniu bloga. Nie jest to związane z żadnymi dodatkowymi kosztami dla Ciebie. Dziękuję! :)

## Podsumowanie

Dzisiejszy artykuł był mocno teoretyczny. Przeczytałeś nim o akronimie SOLID. Na przykładach zobaczyłeś jak wyglądają poszczególne składowe tego akronimu. Mam nadzieję, że zachęci Cię to do pisania solidnego kodu ;).

Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku w przyszłości proszę dopisz się do newslettera i polub Samouczka na Facebooku. Jeśli będziesz miał jakiekolwiek pytania czy wątpliwości proszę zadaj je w komentarzu, postaram się pomóc. Do następnego razu :).
