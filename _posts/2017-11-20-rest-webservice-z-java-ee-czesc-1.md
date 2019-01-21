---
title: REST web service z Java EE część 1
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- Kurs aplikacji webowych
permalink: /rest-web-service-z-java-ee-czesc-1/
header:
    teaser: /assets/images/2017/11/20_rest_web_service_artykul.jpg
    overlay_image: /assets/images/2017/11/20_rest_web_service_artykul.jpg
    caption: "[&copy; exfordy](https://www.flickr.com/photos/exfordy/2486394359/sizes/l)"
excerpt: Po lekturze tego artykułu będziesz wiedział czym jest web service. Przeczytasz o tym czym jest REST. Dowiesz się dlaczego zdobył taką popularność. Zainstalujesz swój pierwszy kontener aplikacji. Artykuł na przykładzie pokaże Ci w jaki sposób możesz napisać swój web service z użyciem implementacji JAX-RS.
---

{% include kurs-web-java-notice.md %}

## Słownik pojęć

Na początku postaram się wytłumaczyć pojęcia, które będą używane w dalszej części artykułu.

### Czym jest web service

Wyobraź sobie obiekt. Obiekt ma zestaw metod. W normalnych warunkach metody na tym obiekcie możemy wywoływać wyłącznie w tym samym programie, w ramach tej samej wirtualnej maszyny Java. W uproszczeniu web service[^tlumaczenie] to mechanizm umożliwiający wywołanie jakiejś funkcjonalności za pośrednictwem internetu. Istnieje kilka podejść do tworzenia web service'ów.

[^tlumaczenie]: Zawsze staram się tłumaczyć angielskie terminy. Jednak w tym przypadku poddałem się. Jak przetłumaczyć web service? Usługa sieciowa? Serwis internetowy? Takie tłumaczenie wprowadzałoby więcej zamieszania niż pożytku. Zostanie więc web service, jeśli masz jakiś pomysł jak to przetłumaczyć daj znać ;).

Jednym z nich jest tak zwany REST.

### Czym jest REST

REST to rozwinięcie _Representational State Transfer_. REST to zbiór praktyk, które określają w jaki sposób powinniśmy implementować web service'y. REST kręci się wokół tak zwanych encji (ang. _resource_). Encja to obiekt, który reprezentuje byt w aplikacji. Może to być na przykład obiekt reprezentujący rezerwację stolika, użytkownika aplikacji czy kredyt w banku.

Operacje na encjach wykonuje się za pomocą zapytań HTTP. Do encji dobieramy się używając odpowiednich typów zapytań. Typy zapytań określone są przez czasowniki HTTP: `GET`, `POST`, `PUT` i `DELETE`. Czasowniki te wraz z adresem URL definiują dokładnie jaką operację chcemy wykonać na danej encji.

| Czasownik | Przykład                 | Znaczenie                                  | 
| --------- | ------------------------ | ------------------------------------------ | 
| `GET`     | `GET /rezerwacja/123`    | Pobranie rezerwacji o identyfikatorze 123  | 
| `PUT`     | `PUT /rezerwacja/123`    | Edycja rezerwacji o identyfikatorze 123    | 
| `POST`    | `POST /rezerwacja`       | Utworzenie nowej rezerwacji                | 
| `DELETE`  | `DELETE /rezerwacja/123` | Usunięcie rezerwacji o identyfikatorze 123 |

Zanim powstał REST, web service'y w języku Java tworzono w oparciu o SOAP (ang. _Simple Object Access Protocol_). SOAP w porównaniu do REST jest dużo bardziej złożony. SOAP oparty jest o XML'a i jest dość rozwlekłym protokołem. Moim zdaniem REST zdobył dużą przewagę właśnie swoją prostotą w porównaniu do SOAP. REST jest _de facto_ standardem jeśli chodzi o tworzenie web service'ów w większości aplikacji webowych.

Wysłane zapytanie informuje także web service o preferowanej formie odpowiedzi. Dzieje się to zazwyczaj przy pomocy nagłówków HTTP. Na przykład nagłówek zapytania `Accept: application/json` informuje web service, że klient oczekuje odpowiedzi w formacie [JSON](https://www.json.org/).

Jest to tylko krótkie wprowadzenie, jeśli chcesz dowiedzieć się więcej na temat REST odsyłam Cię do materiałów dodatkowych.

#### `PUT` czy `POST`?

W tabeli wyżej wspomniałem o tym, że to zapytania typu `POST` powinny tworzyć nową instancję a zapytania typu `PUT` powinny ją edytować. Dla pełni informacji muszę Ci powiedzieć, że z tego co wiem, nie jest to nigdzie ustandaryzowane. 

Spotkasz się zarówno z takim podejściem jak w tabeli wyżej jak i odwrotnym, w którym to zapytania typu `POST` służą do edycji encji.

### Czym jest Java EE

W jednym zdaniu. Java EE to platforma, która oparta jest na zbiorze specyfikacji. Technologie opisane w tych specyfikacjach są używane głównie do tworzenia aplikacji webowych.

{% include figure image_path="/assets/images/2017/11/20_java_ee_logo.png" caption="Logo Java EE" %}

Teraz należy Ci się rozwinięcie. Język Java już znasz. Java wraz z zestawem biblioteki standardowej to Java SE (ang. _Standard Edition_). Istnieje również taki twór jak Java EE (ang. _Enterprise Edition_). Jak napisałem wyżej Java EE to nic innego jak zbiór różnych specyfikacji. Można powiedzieć, że Java EE rozbudowuje możliwości Java SE. Oczywiście podstawą tutaj jest język programowania Java. Java EE w wersji 8 została opublikowana 31 sierpnia 2017 roku. Java EE w wersji 8 to [41 osobnych specyfikacji](http://www.oracle.com/technetwork/java/javaee/tech/java-ee-8-3890673.html)! Jedną ze specyfikacji jest Java Servlets. Opisywałem ją w poprzednich artykułach w ramach [kursu]({{ "/kurs-aplikacji-webowych/" | absolute_url }}).

Java Servlets jest specyfikacją, którą można używać w kontenerach serwletów. Niestety nie wszystkie ze wspomnianych 41 specyfikacji można używać w kontenerze serwletów. Java API for RESTful Web Services (w skrócie JAX-RS) jest tu dobrym przykładem. Aby móc używać tej technologii potrzebujemy kontenera aplikacji.

{% include newsletter-srodek.md %}

### Kontener aplikacji a kontener serwletów

Apache Tomcat, którego używałem do tej pory w ramach kursu jest kontenerem serwletów. Umożliwia on uruchamianie aplikacji webowych, które używają podzbioru specyfikacji Java EE (na przykład specyfikacji serwletów).

Pisanie web service'ów w oparciu o JAX-RS wymaga kontenera aplikacji. Jednym z kontenerów aplikacji jest [Apache TomEE](http://tomee.apache.org).

## Instalacja kontenera aplikacji

Jest wiele kontenerów aplikacji. W tym kursie będę używał Apache TomEE. Jest to jeden z darmowych kontenerów. Aby go zainstalować pobierz [TomEE PluME](http://tomee.apache.org/download-ng.html) i rozpakuj plik ZIP do dowolnego folderu. To tyle, instalację kontenera aplikacji masz już za sobą.

Ważne jest, żebyś pobrał wersję TomEE PluME, lub TomEE+. Te wersje [wspierają specyfikację JAX-RS](http://tomee.apache.org/comparison.html).

{% include figure image_path="/assets/images/2017/11/20_tomee_plume_download.png" caption="Pobieranie TomEE Plume" %}

## Web service z JAX-RS

### `build.gradle`

Nadszedł czas na to, żeby utworzyć swój pierwszy web service. Do budowania aplikacji użyłem [Gradle]({% post_url 2017-01-19-wstep-do-gradle %}). Plik `build.gradle` wygląda następująco:

    apply plugin: 'java'
    apply plugin: 'idea'
    apply plugin: 'maven'
    apply plugin: 'war'
    apply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'

    repositories {
        mavenCentral()
    }

    sourceCompatibility = 1.8
    group = 'pl.samouczekprogramisty.kursaplikacjewebowe'
    version = '1.0-SNAPSHOT'

    dependencies {
        providedCompile group: 'javax.servlet', name: 'javax.servlet-api', version: '3.1.0'
        providedCompile group: 'javax.ws.rs', name: 'javax.ws.rs-api', version: '2.1'

        testCompile group: 'junit', name: 'junit', version: '4.12'
        testCompile group: 'org.hamcrest', name: 'hamcrest-all', version: '1.3'
        testCompile group: 'org.mockito', name: 'mockito-all', version: '1.10.19'
    }
    
    task explodedWar(type: Copy) {
        into "$buildDir/explodedWar"
        with war
    }
    
    war.dependsOn explodedWar

Najbardziej istotnym fragmentem jest `providedCompile group: 'javax.ws.rs', name: 'javax.ws.rs-api', version: '2.1'`[^jee7]. Jest to zależność, która zawiera klasy określone przez specyfikację JAX-RS. `providedCompile` mówi Gradle o tym, że zależność jest wymagana przez aplikację wyłącznie w trakcie kompilacji. Nie zostanie umieszczona w wynikowymi pliku war. Nie jest ona tam potrzebna ponieważ jest dostępna na [classpath]({% post_url 2017-03-08-java-z-linii-polecen %}) kontenera aplikacji.

[^jee7]: W rzeczywistości mimo, że importuję tu API w wersji 2.1 serwer TomEE, którego używam (7.0.4) wspiera wersję 2.0.

### Pierwszy web service

Utwórz klasę, która będzie odpowiedzialna za encję `Reservation`. Może to być na przykład `ReservationWebservice`:

```java
package pl.samouczekprogramisty.kursaplikacjewebowe.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/reservation")
public class ReservationWebservice {
    @GET
    public Response listReservations() {
        return Response.ok("Oto wszystkie rezerwacje :)").build();
    }
}
```

Jest to standardowa klasa Javy, tak zwane POJO (ang. _Plain Old Java Object_). Zawiera ona jedną metodą, `listReservations`. Dodatkowo znajdują się w niej dwie [adnotacje]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}): [`@Path`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/Path.html) i [`@GET`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/GET.html). Metoda ta zwraca instancję obiektu [`Response`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/core/Response.html).

Ta kombinacja to Twój pierwszy web service. Adnotacja [`@Path`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/Path.html) informuje JAX-RS o tym pod jakim URL dana klasa/metoda powinna odpowiadać. Adnotacja [`@GET`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/GET.html) mówi o tym jaki czasownik HTTP jest obsługiwany przez daną metodę.

Następnie zbuduj aplikację używając polecenia:

    gradle war

Po jego wykonaniu w katalogu `build/libs` projektu powinien znaleźć się plik war. Przekopiuj go do katalogu `webapps` w miejscu gdzie zainstalowałeś TomEE. W moim przypadku wygląda to następująco:

    cp /home/mapi/KursAplikacjeWebowe/06_rest_endpoint/build/libs/06_rest_endpoint-1.0-SNAPSHOT.war /home/mapi/opt/apache-tomee/webapps/rest.war

Zauważ, że w trakcie kopiowania zmieniłem nazwę pliku war z `06_rest_endpoint-1.0-SNAPSHOT.war` na `rest.war`. Zrobiłem tak, ponieważ TomEE, podobnie jak Tomcat używa nazwy pliku war jako fragmentu adresu URI aplikacji. Szybciej napiszę `rest` niż `06_rest_endpoint-1.0-SNAPSHOT`.

Po przekopiowaniu pliku war uruchom serwer TomEE. Możesz to zrobić przy pomocy pliku `catalina.sh`[^windows]:

    /home/mapi/opt/apache-tomee/bin/catalina.sh run

[^windows]: Jeśli pracujesz w systemie Windows wówczas plik ten nazywa się `catalina.bat`.

Jeśli zrobiłeś wszystko zgodnie z powyższą instrukcją masz swój pierwszy działający web service. Gratulacje ;). Aby móc zobaczyć go w działaniu odwiedź stronę: `http://localhost:8080/rest/reservation`. Powinieneś zobaczyć napis `Oto Wszystkie rezerwacje :)`.

## Jak działa web service z użyciem JAX-RS

Skoro napisałeś już swój pierwszy web service warto zrozumieć co dzieje się pod spodem. Nie ma tam żadnej magii. Jedynie trochę pracy po stronie kontenera aplikacji.

Otóż w naszym przypadku specyfikacja JAX-RS wymaga od kontenera aplikacji utworzenia specjalnego serwletu. Serlwet ten ma za zadanie obsługiwać wszystkie żądania, które wysyłane są do naszej aplikacji.

Kontener aplikacji musi przeskanować wszystkie klasy w naszej aplikacji pod kątem adnotacji JAX-RS. Jeśli znajdzie te adnotacje w klasach zapamiętuje je. Następnie używa tych klas do obsługi żądań wysyłanych przez klienty[^uproszczenie].

[^uproszczenie]: Oczywiście jest to uproszczenie. W praktyce proces jest trochę bardziej rozbudowany. Proces ten opisany jest w sekcji 3.7 specyfikacji "Matching Requests to Resource Methods". Domyślnie nowa instancja klasy obsługującej zapytanie tworzona jest dla każdego zapytania. W większości przypadków nie jest to zachowanie, które chcesz zostawić na produkcyjnym środowisku.

Więc w tym przypadku, wysłanie żądania na adres `http://localhost:8080/rest/reservation` spowoduje wywołanie tego serwletu. Następnie serwlet stworzy instancję klasy 
`ReservationWebservice`. Na tej instancji wywoła metodę `listReservations`. Wartość zwrócona przez tę metodę zostanie użyta do przygotowania odpowiedzi dla klienta.

### REST bez użycia JAX-RS

Jak widzisz z powyższego opisu JAX-RS jest jedynie nakładką na mechanizm serwletów. Jeśli czytałeś poprzednie artykuły w ramach kursu to wiesz, że serwlety są sercem ogromnej większości aplikacji webowych napisanych w Javie. 

Skoro jest to nakładka, to można tę samą funkcjonalność uzyskać bez niej. Innymi słowy można pisać REST'owe web service'y bez użycia JAX-RS, używając standardowego kontenera serwletów. Jednak JAX-RS sporo upraszcza, pozwala programiście używać wyższego poziomu abstrakcji. Nie musisz pamiętać o `doGet` czy innych metodach z API serwletów.

## Pozostałe metody web service'u

Metody te to jedynie szablony, które mają pokazać Ci przykład użycia adnotacji udostępnionych przez JAX-RS.

### Pobieranie encji. Metoda `GET`

Poprzednia metoda `listReservations` odpowiadała na żądanie do ścieżki `/reservation` i zwracała (teoretycznie) wszystkie rezerwacje. Tym razem chcemy zwrócić pojedynczą rezerwację. Proszę spójrz na przykład poniżej:

```java
@GET
@Path("{id}")
public Response getReservation(@PathParam("id") Integer id) {
    return Response.ok("Oto rezerwacja o identyfikatorze " + id + " :)").build();
}
```

Jak widzisz w tym przypadku metoda `getReservation` dekorowana jest adnotacją [`@Path`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/Path.html). Metoda ta zostanie wywołana do obsłużenia zapytania wysłanego pod adres `/reservation/{id}`. Składnia `{id}` użyta jest do przechwytywania części adresu URL. Dzięki tej składni i użyciu adnotacji [`@PathParam`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/PathParam.html) część tej ścieżki zostanie przekazana w trakcie wywołania metody `getReservation`. Na przykład zapytanie `GET /reservation/123` spowoduje wywołanie tej metody z argumentem `id` o wartości `123`.

### Edycja encji. Metoda `PUT`

```java
@PUT
@Path("{id}")
public Response updateReservation(@PathParam("id") Integer id) {
    return Response.ok("Zmodyfikowaliśmy rezerwację o numerze " + id + " :)").build();
}
```

W tym przypadku nowa jest dla Ciebie jedynie adnotacja [`@PUT`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/PUT.html). Informuje ona kontener aplikacji o tym, że metoda `updateReservation` powinna być wywołana jeśli klient wyśle zapytanie `PUT /reservation/{id}`.

### Usuwanie encji. Metoda 'DELETE`

```java
@DELETE
@Path("{id}")
public Response deleteReservation(@PathParam("id") Integer id) {
    return Response.ok("Usunęliśmy rezerwację o numerze " + id + " :)").build();
}
```

### Dodawanie encji. Metoda 'POST`

```java
@POST
public Response createReservation() {
    return Response.ok("Rezerwacja została utworzona!").build();
}
```

## Testowanie zapytań typu `PUT`, `DELETE`

Do przetestowania zapytań typu `PUT` czy `DELETE` w przeglądarce potrzebujesz odrobiny HTML'a i kodu w języku JavaScript. Przygotowałem dla Ciebie [prostą stronę]({{ "/testuj-web-service/" | absolute_url }}), która może Ci w tym pomóc.

Jeśli Twoja instancja TomEE będzie uruchomiona i aplikacja będzie zainstalowana, to po odpowiednim wypełnieniu pól zostanie wysłane żądanie. 

### Słów kilka o CORS

CORS (ang. _Cross-Origin Resource Sharing_) jest mechanizmem używanym przez przeglądarki. Polega on na dodawaniu odpowiednich nagłówków do odpowiedzi serwera. Zawartość tych nagłówków informuje przeglądarkę czy może używać wyników tego zapytania.

Mechanizm ten użyty jest do podniesienia bezpieczeństwa używania stron internetowych. Na chwilę obecną musisz wiedzieć, że aby móc używać [strony do testowania]({{ "/testuj-web-service/" | absolute_url }}) Twój web service musi dodawać odpowiednie nagłówki do odpowiedzi.

Innymi słowy zamiast wysyłać prostą odpowiedź:

```java
Response.
    ok("Usunęliśmy rezerwację o numerze " + id + " :)").
    build();
```

Musiałbyś dodać zestaw nagłówków:

```java
Response.
    ok("Usunęliśmy rezerwację o numerze " + id + " :)").
    header("Access-Control-Allow-Origin", "*")
    header("Access-Control-Allow-Headers", "Content-Type")
    header("Access-Control-Allow-Methods", "DELETE")
    build();
```

Jest to wymagane dla każdego zapytania, które będzie uruchamiane ze strony do testowania. Jest to spowodowane tym, że adres URL źródła zapytania jest inny niż adres URL web service'u[^cors]. W związku z tym, że trzeba to umieścić w wielu miejscach JAX-RS przychodzi z pomocą.

[^cors]: W tym przypadku porównywany jest protokół (np. http), domena (np. www.samouczekprogramisty.pl) i port (np. 8080).

## Adnotacja `@Provider` 

Więcej o tej adnotacji przeczytasz w drugiej części artykułu. Dzisiaj opiszę jedynie część jej możliwości.
{: .notice--info}

JAX-RS udostępnia adnotację [`@Provider`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/ext/Providers.html). Służy ona do oznaczenia komponentów, które powinny być automatycznie odkryte przez kontener aplikacji. Tą adnotacją oznacza się klasy, które są odpowiedzialne za przekrojowe zadania (ang. _cross-cutting_) związane z aplikacją.

Przykładem takiego przekrojowego zadania może być automatyczne dodawanie nagłówków do każdej odpowiedzi. Ta funkcjonalność pozwala na łatwą implementację wymagań narzucanych przez CORS:

```java
@Provider
public class CORSFilter implements ContainerResponseFilter {
    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        MultivaluedMap<String, Object> headers = responseContext.getHeaders();
        if (!headers.containsKey("Access-Control-Allow-Origin")) {
            headers.add("Access-Control-Allow-Origin", "*");
        }
        if (!headers.containsKey("Access-Control-Allow-Headers")) {
            headers.add("Access-Control-Allow-Headers", "Content-Type");
        }
        if (!headers.containsKey("Access-Control-Allow-Methods")) {
            headers.add("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE");
        }
    }
}
```

Klasa `CORSFilter` implementuje interfejs [`ContainerResponseFilter`](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/container/ContainerResponseFilter.html). Interfejs ten zawiera metodę `filter`, która pozwala między innymi na dodanie nagłówków do każdej odpowiedzi. 

## Dodatkowe materiały do nauki

Jest tego sporo, głównie w języku angielskim:

- [Przykłady kodu użyte w artykule](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/06_rest_endpoint/src/main/java/pl/samouczekprogramisty/kursaplikacjewebowe/rest),
- [Tutorial dotyczący JAX-RS przygotowany przez Oracle](https://javaee.github.io/tutorial/jaxrs.html#GIEPU),
- [Praca doktorska Roy'a Fielding'a, gdzie po raz pierwszy użyto określenia REST](https://www.ics.uci.edu/~fielding/pubs/dissertation/fielding_dissertation.pdf),
- [Rozdział w wyżej wspomnianej pracy na temat REST](https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm),
- [REST API Tutorial](http://www.restapitutorial.com/),
- [Artykuł o REST na anglojęzycznej wersji Wikipedii](https://en.wikipedia.org/wiki/Representational_state_transfer),
- [Specyfikacja JAX-RS 2.1](http://download.oracle.com/otndocs/jcp/jaxrs-2_1-final-eval-spec/index.html),
- [Dokumentacja API JAX-RS](https://javaee.github.io/javaee-spec/javadocs/javax/ws/rs/package-summary.html),
- [Artykuł na stronie Mozilli o CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS),
- [Artykuł na temat dojrzałości architektury REST](https://martinfowler.com/articles/richardsonMaturityModel.html),

## Podsumowanie

Dzisiaj udało Ci się zdobyć sporo wiedzy. Dowiedziałeś się czym jest REST. Co składa się na platformę Java EE. Poznałeś część funkcjonalności jednej ze specyfikacji znajdującej się pod parasolem Java EE. Zainstalowałeś kontener aplikacji, no i przede wszystkim napisałeś swój pierwszy web service przy pomocy JAX-RS.

W kolejnym artykule z tej serii zajmę się implementacją bardziej użytecznego web service'u. Jeśli nie chcesz pominąć kolejnych artykułów na blogu dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Do następnego razu!
