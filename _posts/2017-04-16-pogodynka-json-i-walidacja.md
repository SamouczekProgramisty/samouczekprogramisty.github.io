---
title: Pogodynka - JSON i walidacja
last_modified_at: 2018-04-03 22:45:34 +0200
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /pogodynka-json-i-walidacja/
header:
    teaser: /assets/images/2017/04/16_pogodynka_05_artykul.jpg
    overlay_image: /assets/images/2017/04/16_pogodynka_05_artykul.jpg
    caption: "[&copy; littlekoshka](https://www.flickr.com/photos/littlekoshka/4647737233/sizes/l)"
excerpt: Kolejny raport z frontu Pogodynki. Tym razem krótko, w kilku żołnierskich słowach opiszę o postępy w Pogodynce.
disqus_page_identifier: 856 http://www.samouczekprogramisty.pl/?p=856
toc: false
---

## Zabawa z JSONem

Nie mogę powiedzieć, że zrobiłem to “w tym tygodniu”. Nad pogodynką pracowałem wyłącznie dzisiaj :). Pierwszym problemem, który musiałem rozwiązać była serializacja i deserializacja obiektów klasy [DateTime](http://joda-time.sourceforge.net/apidocs/org/joda/time/DateTime.html) z biblioteki [Joda](http://www.joda.org/joda-time/).

Okazuje się, że biblioteka [Gson](https://github.com/google/gson), którą wybrałem domyślnie robi to w “dziwaczny sposób”. Jako proste i przejrzyste rozwiązanie zaimplementowałem swój własny konwerter DateTime -\> String -\> DateTime. Data przekazywana jest jako łańcuch znaków zapisany w formacie [ISO8601](https://en.wikipedia.org/wiki/ISO_8601).

Na tym etapie funkcjonalność testowałem wyłącznie z linii poleceń używając programu curl. Przykładowe zapytanie, które wysyła pomiar temperatury do komponentu Data Vault może wyglądać następująco:

    $ curl -H 'Content-Type: application/json' http://localhost:8080/datavault/temperatures -d '{"temperature": 123, "whenMeasured": "2017-04-16T17:06:36.652+02:00"}' -v
    * Trying 127.0.0.1...
    * Connected to localhost (127.0.0.1) port 8080 (#0)
    > POST /datavault/temperatures HTTP/1.1
    > Host: localhost:8080
    > User-Agent: curl/7.47.0
    > Accept: */*
    > Content-Type: application/json
    > Content-Length: 69
    >
    * upload completely sent off: 69 out of 69 bytes
    < HTTP/1.1 201 Created
    < Date: Sun, 16 Apr 2017 18:32:07 GMT
    < Content-Type: application/json;charset=UTF-8
    < Content-Length: 30
    < Server: Jetty(9.2.15.v20160210)
    <
    * Connection #0 to host localhost left intact
    {"result":"Temperature added"}

W wyniku widzimy “piękną” odpowiedź w formacie JSON. Oczywiście sama temperatura jeszcze się nigdzie nie zapisuje – nie podłączyłem do tego bazy danych. Zajmę się tym w najbliższym tygodniu.

Cała konwersja możliwa jest dzięki klasie [CustomDateTimeAdapter](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/configuration/conversion/CustomDateTimeAdapter.java). Następnie do automatycznego mechanizmu konwersji Springa [dodaję](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/configuration/WebAppConfiguration.java#L27) to właśnie rozszerzenie. Dzięki takiej konfiguracji obiekty zawierające instancję DateTime poprawnie tworzone są na podstawie zapytań zawierających dane w formacie JSON.

## Walidacja danych wejściowych

Nie można ufać użytkownikom. Nawet jeśli jedynym użytkownikiem w trym przypadku jest aplikacja, którą ja napisałem. Zakrawa to trochę o schizofrenię, ale takie są “dobre praktyki” pisania aplikacji. Dane wejściowe trzeba walidować, koniec i kropka.

Specyfikacja [Bean Validation 1.0](https://jcp.org/en/jsr/detail?id=303) doczekała się swojego następcy [Bean Validation 1.1](https://jcp.org/en/jsr/detail?id=349) i [Bean Validation 2.0](https://jcp.org/en/jsr/detail?id=380). Aktualnie wersja 1.1 jest “obowiązującą”. Jako implementację walidatora wybrałem [Hibernate](http://hibernate.org/validator/).

Proste dołączenie biblioteki w pliku [datavault.gradle](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/datavault.gradle) wraz z użyciem adnotacji [@NotNull](http://docs.oracle.com/javaee/7/api/javax/validation/constraints/NotNull.html) i [@Valid](http://docs.oracle.com/javaee/7/api/javax/validation/Valid.html) pokazuje siłę Springa:

    curl -H 'Content-Type: application/json' http://localhost:8080/datavault/temperatures -d '{"temperature": 123}' -v
    * Trying 127.0.0.1...
    * Connected to localhost (127.0.0.1) port 8080 (#0)
    > POST /datavault/temperatures HTTP/1.1
    > Host: localhost:8080
    > User-Agent: curl/7.47.0
    > Accept: */*
    > Content-Type: application/json
    > Content-Length: 20
    >
    * upload completely sent off: 20 out of 20 bytes
    < HTTP/1.1 400 Bad Request
    < Date: Sun, 16 Apr 2017 18:46:30 GMT
    < Content-Type: application/json;charset=UTF-8
    < Content-Length: 52
    < Server: Jetty(9.2.15.v20160210)
    <
    * Connection #0 to host localhost left intact
    {"errors":["Field whenMeasured must not be empty!"]}

## Kontroler – serce aplikacji

Ta aplikacja to w praktyce jeden kontroller. Dodatkowo aplikacja zawiera drobną konfigurację rozszerzającą domyślne ustawienia.

```java
@Controller
@RequestMapping("/temperatures")
public class TemperatureController {

    private static final Logger LOG = LoggerFactory.getLogger(TemperatureController.class);

    private final TemperatureService temperatureService;

    private final MessageSource messageSource;

    @Autowired
    public TemperatureController(TemperatureService temperatureService, MessageSource messageSource) {
        this.messageSource = messageSource;
        this.temperatureService = temperatureService;
    }

    @PostMapping(consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity addTemperature(@Valid @RequestBody TemperatureMeasurement temperature, Errors errors) {
        if (errors.hasErrors()) {
            List<String> errorMessages = errors.getAllErrors().stream()
                .map(e -> messageSource.getMessage(e.getCode(), e.getArguments(), null))
                .collect(Collectors.toList());
            return new ResponseEntity<>(Collections.singletonMap("errors", errorMessages), HttpStatus.BAD_REQUEST);
        }

        temperatureService.addTemperature(temperature);

        return new ResponseEntity<>(Collections.singletonMap("result", "Temperature added"), HttpStatus.CREATED);
    }

    @GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public Map<String, List<TemperatureMeasurement>> listTemperatures() {
        LOG.debug("Listing all temperatures");
        List<TemperatureMeasurement> temperatures = temperatureService.getTemperatures();
        Map<String, List<TemperatureMeasurement>> responseMap = new HashMap<>();
        responseMap.put("temperatures", temperatures);
        return responseMap;
    }
}
```

## Podsumowanie

Czasu już dużo nie zostało. Teraz zamierzam pracować nad pogodynką także w tygodniu, nie tylko w weekendy jak do tej pory. Trzymajcie za mnie kciuki ;)
