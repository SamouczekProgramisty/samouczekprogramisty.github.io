---
title: REST web service z Java EE część 2
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- Kurs aplikacji webowych
permalink: /rest-web-service-z-java-ee-czesc-2/
header:
    teaser: /assets/images/2018/01/22_rest_web_service_2_artykul.jpg
    overlay_image: /assets/images/2018/01/22_rest_web_service_2_artykul.jpg
    caption: "[&copy; trevor_dobson_inefekt69](https://www.flickr.com/photos/trevor_dobson_inefekt69/32936864910/sizes/l)"
excerpt: W artykule tym pokazuję przykład webservice'u, który został utworzony wyłącznie w oparciu o technologie z parasola Java EE. Znajdziesz tu praktyczne wykorzystanie wstrzykiwania zależności (CDI), walidacji (Bean Validation) czy obsługi formatu JSON (JSON-P i JSON-B). W praktyce JAX-RS pozwala na łatwe połączenie tych mechanizmów w całość. Artykuł przedstawia prosty webservice, napisany bez Springa. W artykule tym staram się pokazać, że nowoczesna Java EE nie jest taka straszna.
---

{% include kurs-web-java-notice.md %}

## REST Webservice w Java EE 8 

Tematykę REST omówiłem dokładnie w [poprzednim artykule]({% post_url 2017-11-20-rest-webservice-z-java-ee-czesc-1 %}). W tym pokażę przykładową implementację webservice'u używającego wyłącznie technologii opisanych w ramach specyfikacji Java EE 8.

Przykładowa aplikacja będzie używała implementacji następujących specyfikacji:

* JAX-RS: Java API for RESTful Web Services 2.1,
* JSON-B: JavaTM API for JSON Binding 1.0
* Java API for JSON Processing 1.1
* Context and Dependency Injection for Java 2.0
* Java TM Servlet Specification 3.1

W artykule tym rozszerzę przykładowy webservice do zarządzania rezerwacjami. Będzie on posiadał pięć metod odpowiedzialnych odpowiednio za:

* pobieranie listy rezerwacji,
* pobieranie konkretnej rezerwacji,
* tworzenie nowej rezerwacji,
* edycja rezerwacji,
* usunięcie rezerwacji.

## Serwer aplikacji dla JavaEE 8

W poprzednim artykule posłużyłem się kontenerem aplikacji TomEE. Niestety aktualnie kontener ten nie wspiera JEE 8. W związku z tym w tym artykule bazuję na serwerze Glassfish 5.

### Instalacja serwera aplikacji Glassfish                                                                                                                          

Podobnie jak w przypadku serwera TomEE instalacja nie jest skomplikowana. W tym przypadku należy pobrać [najnowszą wersję](https://javaee.github.io/glassfish/download) serwera Glassfish. Następnie należy rozpakować ściągnięty plik do dowolnego folderu. W moim przypadku jest to `/home/mapi/opt/glassfish5`.

Nie wchodząc zbytnio w szczegóły działania serwera Glassfish musisz wiedzieć o programie `asadmin`, który pomaga w administracji serwerem. Program ten znajduje się w katalogu `bin`.

### Podstawowe komendy do zarządzania serwerem

Aby uruchomić serwer musisz wywołać polecenie `asadmin start-domain`. Mając działający serwer aplikacji możesz przejść do następnego kroku.

Możesz pobrać listę aplikacji, które są aktualnie zainstalowane na serwerze przy pomocy polecenia `asadmin list-applications`.

Zainstalować aplikację możesz przy pomocy polecenia `asadmin deploy --contextroot / build/libs/07_rest_crud-1.0-SNAPSHOT.war`. Ścieżka na końcu odpowiada plikowi war z aplikacją webową.

Jeśli chcesz usunąć zainstalowaną aplikację uruchom `asadmin undeploy 07_rest_crud-1.0-SNAPSHOT`. Nazwę aplikacji do usunięcia możesz uzyskać wcześniej wspomniane polecenie `asadmin list-applications`.

## Wstrzykiwanie zależności

Wstrzykiwanie zależności (ang. _dependency injection_) pozwala na oddelegowanie zarządzanie zależnościami do kontenera. Dzięki takiemu podejściu programista nie musi samemu tworzyć instancji obiektów, robi to za niego kontener aplikacji. Kontener aplikacji zarządza cyklem życia takich instancji. To kontener wywołuje konstruktor i kontener utrzymuje referencje do tych obiektów. Także kontener ustawia atrybuty jeśli odpowiadają one instancjom, którymi zarządza.

Takie podejście do zarządzania obiektami znacząco upraszcza aplikacje. Pozwala też tworzyć kod, który można w łatwiejszy sposób przetestować przy pomocy [testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}).

Wstrzykiwanie zależności to funkcjonalność, dzięki której Spring stał się tak popularny. W początkowych fazach istnienia biblioteki Spring jej możliwości sprowadzały się do przyjaznego zarządzania zależnościami.
{: .notice--info}

Proszę spójrz na przykład:

```java
public class ReservationWebservice {
    @Inject
    private ReservationDAO dao;
}

@ApplicationScoped
public class ReservationDAO {
}
```

Fragment kodu powyżej używa mechanizmu wstrzykiwania zależności. Klasa `ReservationWebservice` potrzebuje instancji klasy `ReservationDAO`[^dao]. Atrybut `dao` może zostać wstrzyknięty dzięki mechanizmowi DI (ang. _Dependency Injection_). Adnotacja [`@Inject`](https://javaee.github.io/javaee-spec/javadocs/javax/inject/Inject.html) informuje kontener o tym, że ten atrybut powinien zostać wstrzyknięty. 

[^dao]: DAO to akronim od _Data Access Object_. Jest to często spotykany sposób na oznaczenie klas, które odpowiedzialne są za dostęp do danych.

Klasa `ReservationDAO` poprzedzona jest adnotacją [`@ApplicationScoped`](https://javaee.github.io/javaee-spec/javadocs/javax/enterprise/context/ApplicationScoped.html). Adnotacja ta informuje kontener o tym, że instancja tej klasy powinna być możliwa do wstrzyknięcia. Instancja będzie dostępna w kontekście aplikacji. Oznacza to tyle, że kontener utworzy wyłącznie jedną instancję tej klasy w trakcie działania aplikacji[^serwery].

[^serwery]: Mam na myśli tutaj jedną instancję klasy na każdą wirtualną maszynę Javy. Jeśli aplikacja uruchomiona jest w kliku kontenerach wówczas każdy z nich będzie miał osobną instancję.

{% capture beans %}
Mechanizm wstrzykiwania zależności powinien być domyślnie dostępny jak tylko kontener wykryje klasy, które powinien wstrzykiwać. Niestety jednak nie udało mi się zmusić do tego Glassfisha 5. 

Obszedłem to poprzez dodanie pustego pliku [`beans.xml`](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/07_rest_crud/src/main/webapp/WEB-INF/beans.xml), który także włącza ten mechanizm.
{% endcapture %}

<div class="notice--warning">
    {{ beans | markdownify }}
</div>

## Model - rezerwacja

Rezerwacje, którymi zarządza webservice są reprezentowane przez osobną klasę `Reservation`:

```java
public class Reservation {

    @NotEmpty
    private String name;

    @NotNull
    @Positive
    private Integer tableNumber;

    @FutureOrPresent
    @NotNull
    private LocalDateTime start;

    @Future
    @NotNull
    private LocalDateTime end;

    // getters/setters
}
```

Klasa ta zawiera atrybuty opisujące rezerwację takie jak nazwisko rezerwującego, numer stolika czy początek i koniec rezerwacji. Rezerwacja jest prawidłowa wyłącznie jeśli atrybuty uzupełnione są poprawnymi danymi. Poprawność instancji klasy `Reservation` zapewniona jest przez [mechanizm walidacji]({% post_url 2017-12-04-walidacja-obiektow-w-jezyku-java %}).

### Walidacja

Walidacja obiektów dostarczona jest przez implementację specyfikacji Bean Validation. Każdy kontener aplikacji, który jest kompatybilny z Java EE 8 (jak Glassfish 5 wspomniany wyżej), musi dostarczać implementację tej specyfikacji.

Samą [walidację obiektów]({% post_url 2017-12-04-walidacja-obiektow-w-jezyku-java %}) omówiłem bardziej szczegółowo w osobnym artykule. Tutaj widzisz jej użycie w kontekście aplikacji webowej. 

Instancja walidatora tworzona jest przez kontener automatycznie. Kontener także wywołuje mechanizm walidacji. Mechanizm ten wywoływany jest za każdym razem w metodach obsługujących podstawowe operacje. Przykład poniżej pokazuje użycie adnotacji [`@Valid`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/Valid.html) w metodzie odpowiedzialnej za tworzenie nowej instancji rezerwacji.

```java
@POST
public Response createReservation(@Valid Reservation reservation) {
    //...
}
```

Kontener na podstawie zapytania wysłanego przez użytkownika tworzy instancję klasy `Reservation`, następnie sprawdza czy instancja ta jest poprawna. Jeśli dane przesłane przez użytkownika są poprawne wówczas wywołuje ciało metody. Jeśli dane nie pozwolą na utworzenie poprawnej instancji wówczas zostanie rzucony [wyjątek](%{ post_url 2016-01-31-wyjatki-w-jezyku-java %})[`ValidationException`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/ValidationException.html).

W akapicie opisującym instancje oznaczone adnotacją [`@Provider`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/ext/Provider.html) opiszę ten mechanizm dokładniej.

{% include newsletter-srodek.md %}

### Dostęp do danych

W normalnej wersji aplikacji dane zapisywane są w dedykowanej bazie danych[^baza]. Na potrzeby tej aplikacji symuluję bazę danych przy pomocy [mapy]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}) przechowywanej w pamięci. Oczywistym minusem jest to, że dane nie są zachowywane po wyłączeniu aplikacji. Na potrzeby tego artykułu taki mechanizm jest wystarczający:

[^baza]: Raz jest to zwykła baza relacyjna, innym razem może to być plik na dysku. W przypadku niektórych aplikacji wymaganiem może okazać się użycie innych mechanizmów jak na przykład bazy "nosql", czy rozproszone systemy plików. Wszystko zależy od wymagań stawianych przed daną aplikacją.

```java
@ApplicationScoped
public class ReservationDAO {
    private final Map<Integer, Reservation> reservations = Collections.synchronizedMap(new TreeMap<>());;

    private final AtomicInteger lastId = new AtomicInteger(0);

    public Collection<Reservation> getAll() {
        return reservations.values();
    }

    public Reservation getById(Integer id) {
        return reservations.get(id);
    }

    public Reservation updateReservation(Integer id, Reservation reservation) {
        return reservations.put(id, reservation);
    }

    public Reservation deleteReservation(Integer id) {
        return reservations.remove(id);
    }

    public int createReservation(Reservation reservation) {
        int id = lastId.getAndIncrement();
        reservations.put(id, reservation);
        return id;
    }
}
```

Klasa `ReservationDAO` pozwala na łatwy dostęp do instancji klasy `Reservation` przechowywanych w pamięci. Pozwala na utworzenie, pobranie, usunięcie i edycję rezerwacji.

Jak wspomniałem wyżej w akapicie opisującym wstrzykiwanie zależności, instancja klasy `ReservationDAO` jest zarządzana przez kontener aplikacji. W ramach całej aplikacji zostanie utworzona wyłącznie jedna instancja tej klasy. Ta instancja będzie wykorzystywana przez klasę obsługującą żądania wysyłane przez użytkownika.

## Aplikacja

```java
@ApplicationPath("/rest")
public class RegistrationApplication extends Application {
}
```

Adnotacja [`@ApplicationPath`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/ApplicationPath.html) informuje kontener aplikacji o początkowym członie adresu URL pod jakim działa dana aplikacja. W przykładzie wyżej informuję kontener o tym, że adresy URL dla wszystkich webservice'ów w tej aplikacji poprzedzone są `/rest`. 

Adnotacja ta może zostać dodana wyłącznie do instancji klasy [`Application`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/core/Application.html). Klasa ta dostarcza dodatkowych metadanych o aplikacji. W moim przypadku jedyną wymaganą informacją dodatkową jest ta dostarczona przez adnotację.

## Webservice

Teraz znasz komponenty, które są wykorzystywane przez webservice. Nadszedł czas na klasę obsługują żądania użytkownika:

```java
@Path("/reservation")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ReservationWebservice {

    @Inject
    private ReservationDAO dao;

}
```

Adnotację [`@Path`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/Path.html) znasz z [poprzedniej części artykułu]({% post_url 2017-11-20-rest-webservice-z-java-ee-czesc-1 %}). Określa ona ścieżkę, która obsługiwana jest przez daną klasę.

Nowe są dla Ciebie adnotacje [`@Consumes`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/Consumes.html) i [`@Produces`](https://javaee.github.io/javaee-spec/javadocs/javax/enterprise/inject/Produces.html). Odpowiadają one odpowiednio za określenie typu danych konsumowanych i produkowanych przez webservice. W tym przypadku są to dane w formacie [JSON](https://www.json.org/).

Jeśli użytkownik wyśle zapytanie zawierające dane w innym formacie wówczas kontener automatycznie odpowie zwracając kod [415](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/415). Kod ten informuje klienty o tym, że format danych nie jest wspierany. 

Wewnątrz klasy widzisz atrybut, który zostanie wstrzyknięty przez kontener aplikacji. Jest to instancja klasy `ReservationDAO` pozwalająca na dostęp do aktualnie dostępnych rezerwacji.

Zgodnie ze specyfikacją JAX-RS dla każdego żądania przychodzącego od użytkownika zostanie utworzona nowa instancja klasy `ReservationWebservice`. Po raz kolejny to kontener aplikacji zajmuje się tworzeniem tych instancji.

### Pobranie listy rezerwacji

Kod odpowiedzialny za pobranie wszystkich rezerwacji nie jest zbyt skomplikowany:

```java
@GET
public Response listReservations() {
    return Response.ok(dao.getAll()).build();
}
```

Metoda `listReservations` poprzedzona jest adnotacją [`@GET`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/GET.html). Nie zawiera dodatkowej adnotacji `@Path`, więc wszystkie żądania wysłane pod adres `GET /rest/reservation` zostaną obsłużone przez tę metodę. Do sprawdzenia jej działania możesz użyć programu [`curl`](https://curl.haxx.se/)

    curl -H "Content-Type: application/json" http://localhost:8080/rest/reservation

`-H "Content-Type: application/json"` dodaje nagłówek do żądania. Określa on format zawartości zapytania. To właśnie ten nagłówek sprawdzany jest przez adnotację `@Consumes`.

Wewnątrz metody buduję odpowiedź. Ciałem tej odpowiedzi jest lista rezerwacji zwrócona przez `dao`. Dzięki adnotacji `@Produces` JAX-RS wymusza format odpowiedzi. W moim przypadku jest to JSON. 

Kontener automatycznie przekonwertuje instancję klasy `Reservation` do formatu JSON. Dzieje się to dzięki implementacji specyfikacji JSON-B i JSON-P.

### Pobieranie pojedynczej rezerwacji

Pobieranie pojedynczej rezerwacji również bazuje na atrybucie `dao`: 

```java
@GET
@Path("{id}")
public Response getReservation(@PathParam("id") @Min(0) Integer id) {
    Reservation reservation = dao.getById(id);
    if (reservation != null) {
        return Response.ok(reservation).build();
    }
    return Response.status(Response.Status.NOT_FOUND).build();
}
```

Dodatkowa adnotacja `@Path` rozszerza tę umieszczoną nad klasą `ReservationWebservice`. W wyniku tego metoda `getReservation` obsługuje wszystkie żądania wysłane przez klienty na adres `GET /reservation/{id}`. `id` jest identyfikatorem rezerwacji pobieranym z adresu URL dzięki adnotacji [`@PathParam`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/PathParam.html).

Zwróć także uwagę na użycie adnotacji [`@Min`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/constraints/Min.html). Adnotacja ta uruchomi mechanizm walidacji dla parametru `id`. Mechanizm ten sprawdzi czy liczba przekazana w adresie ma wartość większą, bądź równą 0. Jeśli wartość parametru jest niepoprawna zostanie rzucony wyjątek.

Wewnątrz ciała metody odwołuję się do atrybutu `dao` pobierając rezerwację na podstawie identyfikatora pobranego od użytkownika. `dao` zwróci wartość `null` jeśli rezerwacja o danym identyfikatorze nie zostanie odnaleziona. W takim przypadku klient uzyska odpowiedź z kodem [404](https://developer.mozilla.org/uk/docs/Web/HTTP/Status/404) informującą o braku szukanego elementu.

Jeśli `dao` znajdzie rezerwację o zadanym identyfikatorze, wówczas zostanie ona przekazana w odpowiedzi. Także tutaj zostanie ona przekształcona do formatu JSON.

Także w tym przypadku `curl` może pomóc w wysłaniu zapytania:

    curl -H "Content-Type: application/json" http://localhost:8080/rest/reservation/0 

### Usuwanie rezerwacji

Usuwanie rezerwacji niewiele różni się od pobierania pojedynczej wartości:

```java
@DELETE
@Path("{id}")
public Response deleteReservation(@PathParam("id") @Min(0) Integer id) {
    Reservation reservation = dao.deleteReservation(id);
    if (reservation != null) {
        return Response.ok(reservation).build();
    }
    return Response.status(Response.Status.NOT_FOUND).build();
}
```

W tym przypadku kombinacja adnotacji [`@DELETE`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/DELETE.html) i `@Path` wskazuje, że metoda ta zostanie wywołana w przypadku wysłania żądania na adres `DELETE /reservation/{id}`. Podobnie jak w przypadku pobierania rezerwacji mechanizm walidacja sprawdza poprawność przekazanego parametru `id`.

W przypadku tej metody `dao` użyte jest do usunięcia rezerwacji o podanym identyfikatorze.

Przykładowe wywołanie `curl` usuwające rezerwację o identyfikatorze 0:

    curl -H "Content-Type: application/json" http://localhost:8080/rest/reservation/0 -X DELETE

### Utworzenie rezerwacji

Podczas tworzenia rezerwacji webservice wymusza poprawność danych przekazanych przez użytkownika. To adnotacja [`@Valid`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/Valid.html) wymusza sprawdzenie poprawności danych: 

```java
@POST
public Response createReservation(@Valid Reservation reservation) {
    int newId = dao.createReservation(reservation);
    URI location;
    try {
        location = new URI("reservation/" + newId);
    } catch (URISyntaxException e) {
        throw new RuntimeException(e);
    }
    return Response.created(location).build();
}
```

Jeśli wszystkie wymagania określone w klasie `Reservation` zostaną spełnione zostanie wywołana metoda `createReservation`. W przeciwnym wypadku zostanie rzucony wyjątek `ValidationException`.

W ciele metody `createReservation` wywołuję `dao.createReservation`. To wywołanie zapisuje nową rezerwację w bazie danych. W wyniku wywołania tej metody zwrócony jest nowy identyfikator dla tej rezerwacji. Pomaga on w utworzeniu adresu URL, który zostaje zwrócony w odpowiedzi. 

Także i tutaj `curl` może zostać użyty do wysłania zapytania. Tym razem w ciele zapytania muszę przesłać dane w formacie JSON, które reprezentują nową rezerwację. Przykładowe zapytanie może wyglądać następująco:

    curl -H "Content-Type: application/json" http://localhost:8080/rest/reservation -X POST -d '{"start": "2018-01-22T20:00", "tableNumber": 1, "name": "Marcin", "end": "2018-01-22T21:20"}'

Parametr `-d` służy do przekazania zawartości zapytania. W tym przypadku jest to JSON, który reprezentuje dane potrzebne do utworzenia instancji klasy `Reservation`.

    {
        "name": "Marcin",
        "tableNumber": 1,
        "start": "2018-01-22T20:00",
        "end": "2018-01-22T21:20"
    }

W przykładzie powyżej instancja reprezentowana jest przez mapę. Kluczami są nazwy atrybutów, na przykład `name` czy `start`. Atrybuty klasy zostaną uzupełnione wartościami przekazanymi w mapie. Oczywiście format wartości musi być odpowiedni. Automatyczna transformacja pomiędzy formatem JSON a klasą Java możliwa jest dzięki specyfikacjom JSON-B i JSON-P.

### Modyfikacja rezerwacji

Modyfikacja rezerwacji nie zawiera nowych mechanizmów. Jest dość podobna do tworzenia nowej instancji:

```java
@PUT
@Path("{id}")
public Response updateReservation(@PathParam("id") @Min(0) Integer id, @Valid Reservation reservation) {
    boolean hasReservation = dao.getById(id) != null;
    if (hasReservation) {
        dao.updateReservation(id, reservation);
        return Response.noContent().build();
    }
    return Response.status(Response.Status.NOT_FOUND).build();
}
```

## Własna klasa [`@Provider`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/ext/ExceptionMapper.html)

W [poprzedniej części]({% post_url 2017-11-20-rest-webservice-z-java-ee-czesc-1 %}) artykułu użyłem tej adnotacji to utworzenia filtra, który dodawał nagłówki. Tym razem posłuży ona do pomocy przy walidacji.

Specyfikacja JAX-RS pozwala na utworzenie klasy, która będzie odpowiedzialna za obsługę wyjątków, które wystąpiły w trakcie przetwarzania żądania klienta. To zastosowanie idealnie nadaje się do obsługi błędów walidacji:

```java
@Provider
public class ValidationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {

    public static class ErrorMessage {
        public final String error;
        public ErrorMessage(String error) {
            this.error = error;
        }
    }

    @Override
    public Response toResponse(ConstraintViolationException exception) {
        return Response
                .status(Response.Status.BAD_REQUEST)
                .entity(new ErrorMessage(exception.getMessage()))
                .build();
    }
}
```

Klasa `ValidationExceptionMapper` implementuje interfejs [`ExceptionMapper`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/ext/ExceptionMapper.html). Interfejs ten zawiera wyłącznie jedną metodę `toResponse`. Metoda ta zostaje wywołana jeśli zostanie rzucony wyjątek obsługiwany przez daną klasę.

W moim przypadku tworzę nową odpowiedź, która zwraca kod błędu [400](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400) wraz z dodatkowym komunikatem błędu zwróconym przez mechanizm walidacji. 

{% capture jersey %}
W związku z [błędem](https://github.com/jersey/jersey/issues/3425) w bibliotece Jersey musiałem utworzyć klasę, która obsługuje wyjątek [`ConstraintViolationException`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/ConstraintViolationException.html). Po rozwiązaniu tego błędu klasa ta powinna obsługiwać wyjątek [`ValidationException`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/ValidationException.html).

Zgodnie ze specyfikacją użycie adnotacji [`@Priority`](https://javaee.github.io/javaee-spec/javadocs/javax/annotation/Priority.html) także powinno pomóc obejść ten problem.
{% endcapture %}

<div class="notice--warning">
    {{ jersey | markdownify }}
</div>

## Dodatkowe materiały do nauki

W tym miejscu poproszę Cię o uruchomienie tej aplikacji na swoim komputerze i testowanie jej przy pomocy programu `curl`. Taka zabawa na żywo potrafi sporo nauczyć. Kod źródłowy aplikacji znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/07_rest_crud).

## Zadanie do wykonania

Kod źródłowy aplikacji użytej w artykule znajduje się na samouczkowym githubie. Twoim zadaniem jest rozszerzenie działania tej aplikacji. W obecnym kształcie aplikacja nie sprawdza czy dany stolik nie jest już zarezerwowany. Może to prowadzić do sytuacji, w której ten sam stolik będzie zarezerwowany w tym samym czasie dla więcej niż jednej osoby.

Popraw aplikację w taki sposób, aby nie pozwalała na ponowną rezerwację już zarezerwowanego stolika. Więc jeśli stolik nr 1. jest zarezerwowany w godzinach od 17:00 do 18:30, to rezerwacja na ten sam stolik od 18:10 do 19:00 nie jest możliwa.

## Podsumowanie

W artykule przeczytałeś o praktycznym zastosowaniu kilku specyfikacji z parasola Java EE. Na przykładzie mogłeś zobaczyć użycie walidacji czy wstrzykiwania zależności. Poznałeś też mechanizm obsługi wyjątków, w którym użyłem adnotacji `@Provider`. Użyłeś implementacji specyfikacji JSON-P i JSON-B pozwalających na proste obsługiwanie danych w formacie JSON. Całość opakowana została w webservice, oparty o specyfikację JAX-RS. Mam nadzieję, że przykłady użyte w artykule pozwoliły Ci spojrzeć na Java EE z innej strony.

Jeśli którakolwiek część artykułu nie jest dla Ciebie jasna proszę daj znać. Postaram się pomóc. Jeśli nie chcesz ominąć kolejnych artykułów w przyszłości proszę dopisz się do samouczkowego newslettera i polub stronę Samouczka na Facebooku. Do następnego razu!
