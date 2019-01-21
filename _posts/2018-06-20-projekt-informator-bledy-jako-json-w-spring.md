---
title: Projekt Informator zasilenie bazy, Spring i błędy jako JSON
last_modified_at: 2018-06-27 00:20:03 +0200
categories:
- Projekty
- Projekt Informator
permalink: /projekt-informator-zasilenie-bazy-spring-i-bledy-jako-json/
header:
    teaser: /assets/images/2018/06/20_projekt_informator_zasilenie_bazy_spring_i_bledy_jako_json.jpeg
    overlay_image: /assets/images/2018/06/20_projekt_informator_zasilenie_bazy_spring_i_bledy_jako_json.jpeg
    caption: "[&copy; hengstream](https://unsplash.com/photos/pjJdOE2XBRU)"
excerpt: Odpowiedzi z błędami z webservice'ów powinny być formatowane podobnie jak oczekiwane dane. Oznacza to, że w większości przypadków także komunikaty błędów powinny być reprezentowane w formacie JSON. Artykuł ten na przykładzie pokazuje konfigurację, która pozwala na otrzymanie spójnych odpowiedzi z webservice'u. W artykule opisuję też sposób zasilenia bazy danych rzeczywistymi danymi.
---

## Projekt Informator

Projekt informator to REST'owy web service, działający w oparciu o Spring i Hibernate. Jeśli chcesz przeczytać więcej o projekcie i jego założeniach zapraszam do [wprowadzenia]({% post_url 2018-03-20-projekt-informator-wprowadzenie %}).

W jednym z poprzednich artykułów przeczytasz też o [wdrożeniu projektu w chmurze]({% post_url 2018-04-03-projekt-informator-wdrozenie-w-chmurze %}).

{% include wspolpraca-infoshare-2018.md %}

## Baza danych

W projekcie do mapowania obiektowo relacyjnego używam biblioteki Hibernate jako implementacji JPA (ang. _Java Persistence API_). W tym przypadku tworzenie schematu bazy danych zostawiam JPA. Poniżej widzisz konfigurację obiektu zarządzanego przez kontener Spring'a. Służy on do tworzenia instancji implementującej interfejs [`EntityManager`](https://javaee.github.io/javaee-spec/javadocs/javax/persistence/EntityManager.html):

```java
@Bean
LocalContainerEntityManagerFactoryBean entityManagerFactory() {
    LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
    factory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
    factory.setPackagesToScan("pl.samouczekprogramisty.informator.model");
    factory.setDataSource(dataSource());

    Properties jpaProperties = new Properties();
    jpaProperties.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
    jpaProperties.setProperty("hibernate.show_sql", "true");
    jpaProperties.setProperty("hibernate.format_sql", "true");
    jpaProperties.setProperty("hibernate.hbm2ddl.auto", "validate");
    // create database schema if missing
    jpaProperties.setProperty("javax.persistence.schema-generation.database.action", "create");
    factory.setJpaProperties(jpaProperties);

    return factory;
}
```

{% include newsletter-srodek.md %}

### Zasilenie bazy danych

Niestety organizatorzy konferencji nie przygotowali źródła danych, które w łatwy sposób można użyć do zasilenia bazy danych. Jedyne źródło to oficjalna strona www konferencji. Na początku skupiłem się nad zasileniem tabeli zawierającej dane dotyczące prelegentów. W projekcie Informator prelegent reprezentowany jest przez instancję klasy `Speaker`:

```java
@Entity
public class Speaker {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "speaker_seq")
    @SequenceGenerator(name = "speaker_seq")
    private Integer id;

    private Integer infoshareId;

    private Category category;

    private String name;

    private URL linkedinProfile;
    private URL twitterProfile;
    private URL facebookProfile;
    private URL githubProfile;

    @Column(columnDefinition = "text")
    private String description;

    // getters/setters
}
```

Analizując [zapytania HTTP]({% post_url 2018-02-08-protokol-http %}), które są wykonywane w tle zauważyłem adres w postaci:

    https://infoshare.pl/speaker2.php?cid=48&id=XXX&year=2018&agenda_id=99999&fancybox=true

W adresie tym `XXX` zastąpione jest identyfikatorem prelegenta. Strona z prelegentami zawiera listę wszystkich osób występujących na każdej ze scen. Żeby wyciągnąć informacje o wszystkich prelegentach potrzeba ponad 200 zapytań.

Z racji tego, że jest to dość żmudne i czasochłonne zadanie napisałem [skrypt](https://github.com/kbl/gopher_exercises/blob/master/infoparse/infoparse.go)[^go], który wyciąga niezbędne dane. W wyniku działania tego skryptu powstał plik [`speakers.sql`](https://github.com/SamouczekProgramisty/Informator/blob/master/src/main/resources/speakers.sql). Wewnątrz tego pliku znajdują się instrukcje SQL (ang. _Structured Query Language_), które dodają wiersze do tabeli `speaker`. Przykładowe zapytanie z tego pliku wygląda następująco:

[^go]: Po godzinach pracy, w wolnym czasie uczę się [języka Go](https://golang.org/). Wiem, że najlepszy sposób na naukę to praktyka. Dlatego właśnie napisałem ten skrypt używając tego języka. Mam świadomość, że nie jest idealny i wymaga sporo poprawek, ale jak na początek nauki jest OK ;).

```sql
INSERT INTO speaker (
	id,
	infoshareid,
	category,
	description,
	facebookprofile,
	githubprofile,
	linkedinprofile,
	twitterprofile,
	name
)
VALUES (
	nextval('speaker_seq'),
	954,
	0, 'Stephen Haunts is a veteran sof(...)',
	NULL,
	NULL,
	NULL,
	'https://twitter.com/stephenhaunts',
	'Stephen Haunt'
);
```

## Formatowanie odpowiedzi

Mając rzeczywiste dane w bazie danych webservice może odpowiadać bardziej sensownymi danymi:

    $ curl http://localhost:8080/speakers/7 -s | json_pp
    {
       "category" : "STARTUP",
       "description" : "Kamila Wincenciak is a member of Ali(...)",
       "name" : "Kamila Wincenciak",
       "githubProfile" : null,
       "twitterProfile" : null,
       "facebookProfile" : null,
       "linkedinProfile" : "https://www.linkedin.com/in/kamila-wincenciak-27560130/"
    }

Zabrałem się za kolejny etap, czyli obsługę błędów. Przypadkami, które trzeba obsłużyć są brak rekordu w bazie i złe dane wprowadzone przez użytkownika. Oba przypadki pokazane są poniżej. Proszę zwróć uwagę na zwracane [nagłówki]({% post_url 2018-02-08-protokol-http %}#nag%C5%82%C3%B3wki-http) i [status odpowiedzi]({% post_url 2018-02-08-protokol-http %}#statusy-http):

    $ curl http://localhost:8080/speakers/-1 -vs | json_pp
    *   Trying 127.0.0.1...
    * Connected to localhost (127.0.0.1) port 8080 (#0)
    > GET /speakers/-1 HTTP/1.1
    > Host: localhost:8080
    > User-Agent: curl/7.47.0
    > Accept: */*
    > 
    < HTTP/1.1 404 
    < Content-Type: application/json
    < Content-Length: 148
    < Date: Wed, 20 Jun 2018 21:09:42 GMT
    < 
    { [148 bytes data]
    * Connection #0 to host localhost left intact
    {
       "responseCode" : 404,
       "exceptionClass" : "pl.samouczekprogramisty.informator.exceptions.NotFoundException",
       "message" : "Speaker with id -1 wasn't found!"
    }


    $ curl http://localhost:8080/speakers/aa -vs | json_pp
    *   Trying 127.0.0.1...
    * Connected to localhost (127.0.0.1) port 8080 (#0)
    > GET /speakers/aa HTTP/1.1
    > Host: localhost:8080
    > User-Agent: curl/7.47.0
    > Accept: */*
    > 
    < HTTP/1.1 400 
    < Content-Type: application/json
    < Content-Length: 108
    < Date: Wed, 20 Jun 2018 21:09:16 GMT
    < Connection: close
    < 
    { [108 bytes data]
    * Closing connection 0
    {
       "message" : "For input string: \"aa\"",
       "responseCode" : 400,
       "exceptionClass" : "java.lang.NumberFormatException"
    }

### Konfiguracja Spring a obsługa błędów

Aby móc w ten sposób formatować błędy użyłem kombinacji adnotacji [`ControllerAdvice`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/bind/annotation/ControllerAdvice.html) i [`ExceptionHandler`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/bind/annotation/ExceptionHandler.html):

```java
@ControllerAdvice
@SuppressWarnings("unused")
@ResponseBody
public class InformatorExceptionHandler {

    private static ObjectMapper mapper = new ObjectMapper();

    public static class ErrorResponse {
        private static final MultiValueMap<String, String> HEADERS = new LinkedMultiValueMap<>(
                Collections.singletonMap(HttpHeaders.CONTENT_TYPE, Collections.singletonList(MediaType.APPLICATION_JSON_VALUE))
        );
        private final Exception exception;
        private HttpStatus responseStatus;

        ErrorResponse(HttpStatus responseStatus, Exception exception) {
            this.exception = exception;
            this.responseStatus = responseStatus;
        }

        ResponseEntity<String> buildResponse() {
            try {
                return new ResponseEntity<>(mapper.writeValueAsString(this), HEADERS, responseStatus);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        }

        // getters
    }

    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<String> handleNotFound(NotFoundException exception) {
        return new ErrorResponse(HttpStatus.NOT_FOUND, exception).buildResponse();
    }

    @ExceptionHandler(NumberFormatException.class)
    public ResponseEntity<String> handleNumberFormat(NumberFormatException exception) {
        return new ErrorResponse(HttpStatus.BAD_REQUEST, exception).buildResponse();
    }
}
```

Klasa oznaczona adnotacją `ControllerAdvice` zawiera w sobie metody, które są użyte w wielu kontrolerach. Możemy powiedzieć, że są to metody przekrojowe. Przykładem takich metod są te oznaczone adnotacją `ExceptionHandler`. Każda z nich odpowiada za obsługę innego typu wyjątku.

Niestety w tym przypadku Spring nie deserializuje obiektu odpowiedzi do żądanego formatu dlatego napisałem klasę pomocniczą `ErrorResponse`, która przygotowuje odpowiedź w formacie JSON.

# Podsumowanie

Aplikacja aktualnie jest w stanie wyświetlić informacje o prelegencie na podstawie rzeczywistych danych pobranych ze strony organizatora konferencji. Dodatkowo aplikacja poprawnie reaguje na różnego rodzaju błędy odpowiadając w formacie JSON. Zachęcam Cię do przeanalizowania [kodu źródłowego aplikacji](https://github.com/SamouczekProgramisty/Informator), w ten sposób utrwalisz zdobytą wiedzę.

Po przeczytaniu tego artykułu i przejrzeniu kodu źródłowego wiesz w jaki sposób można obsługiwać błędy w webservice'ach. Poznałeś też sposób na zasilanie bazy danych na podstawie informacji umieszczonych na innych stronach.

Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Proszę podziel się linkiem do artykułu ze znajomymi, którym może on pomóc. Może to dzięki Tobie uda mi się dotrzeć do nowych czytelników? ;)

Do następnego razu!
