---
title: Serwlety w aplikacjach webowych
last_modified_at: 2018-09-10 22:37:19 +0200
categories:
- DSP2017
- Kurs aplikacji webowych
permalink: /serwlety-w-aplikacjach-webowych/
header:
    teaser: /assets/images/2017/03/25_serwlety_w_aplikacjach_webowych_artykul.jpeg
    overlay_image: /assets/images/2017/03/25_serwlety_w_aplikacjach_webowych_artykul.jpeg
    caption: "[&copy; rafa2010](https://www.flickr.com/photos/rafa2010/15353313381/sizes/l)"
excerpt: W artykule tym przeczytasz o serwletach. Poznasz podstawy protokołu HTTP. Dowiesz się czym są serwlety i jak je pisać. Dowiesz się także czym jest plik war i przeczytasz o jego strukturze. Po lekturze tego artykułu zrozumiesz co kryje się pod spodem Spring MVC. Napiszesz też swoją aplikację webową, używającą serwletów. Zapraszam do lektury.
disqus_page_identifier: 799 http://www.samouczekprogramisty.pl/?p=799
---

{% capture notice-info %}
Chociaż artykuł ten pisany jest z myślą o początkujących, do jego pełnego zrozumienia przyda się wiedza, którą zawarłem w kliku innych artykułach. Zachęcam do zapoznania się z nimi przed podejściem do tego artykułu:

- [Wstęp do aplikacji webowych]({% post_url 2017-03-17-wprowadzenie-do-aplikacji-webowych %})
- [Wstęp do Gradle]({% post_url 2017-01-19-wstep-do-gradle %})
- [Java z linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %})
{% endcapture %}

<div class="notice--info">
    {{ notice-info | markdownify }}
</div>

Artykuł ten bazuje na specyfikacji serwletów w wersji 3.1, która jest częścią specyfikacji Java Enterprise Edition 7. Planowany termin wydania specyfikacji Java Enterprise Edition 8 to koniec 2017 roku, w ramach tej specyfikacji wydana ma być także nowa specyfikacja serwletów w wersji 4.0.
{: .notice--info}

## Wprowadzenie do protokołu HTTP

Napisałem osobny artykuł na temat [protokołu HTTP]({% post_url 2018-02-08-protokol-http %}). Tutaj przedstawię jedynie niezbędne podstawy.

Aby zacząć poważnie myśleć o tworzeniu aplikacji webowych niezbędna jest wiedza dotycząca protokołu HTTP (ang. Hypertext Transfer Protocol). Poniżej znajdziesz kilka podstawowych informacji, które będą Ci potrzebne w pracy z aplikacją webową.
- Protokół HTTP jest oparty na komunikacji pomiędzy klientem a serwerem. Klientem może być na przykład przeglądarka internetowa. Serwer to aplikacja, która odpowiada na żądania klienta.
- Komunikacja pomiędzy klientem a serwerem oparta jest na żądaniach (ang. _request_) i odpowiedziach (ang. _response_). Klient wysyła żądanie, na które serwer udziela odpowiedzi.
- Zarówno żądania, jak i odpowiedzi mogą zawierać nagłówki i treść. Nagłówki służą do przekazania części informacji. W nagłówku na przykład zawarte mogą być informacje o przeglądarce, z której wysłano żądanie. Treścią odpowiedzi może być na przykład zawartość strony internetowej.
- Protokół HTTP oparty jest o tak zwane “czasowniki HTTP”. Można powiedzieć, że czasownik ten określa rodzaj żądania jakie wysyła klient. Wszystkich czasowników jest 9, podstawowe rodzaje żądań to GET, POST, PUT, DELETE.
- W większości przypadków używane są żądania typu GET i POST. Na przykład do wysłania informacji, które uzupełniłeś w formularzu używa się żądania typu POST. Natomiast zwykłe otworzenie strony, wpisanie adresu strony w przeglądarce to żądanie typu GET.

### Adres URL

Każde z żądań dotyczy jakiegoś zasobu. Na przykład otwierając stronę [www.samouczekprogramisty.pl](http://www.samouczekprogramisty.pl) w przeglądarce wysyłasz żądanie `GET http://www.samouczekprogramisty.pl`. Ta część po GET to nic innego jak URL (ang. _Uniform Resource Locator_). Innymi słowy adres strony www.

Adres URL może składać się z kilku części

    (scheme://)(user:password@)host(:port)(/)(path)(?query)(#fragment)
    https://marcin:tajnehaslo@www.samouczekprogramisty.pl:80/kurs-programowania-java?parametr=wartosc&innyParametr=wartosc#xxx

W ogromnej większości przypadków część z użytkownikiem i hasłem jest pomijana. Używana jest ona do uwierzytelniania, jednak metoda ta nie jest powszechnie używana. Port także jest pomijany. Pomijamy go ponieważ dla protokołu http domyślny port to właśnie 80 więc nie ma potrzeby go dodawać. Odrzucając rzadziej używane elementy adres url wygląda następująco

    https://www.samouczekprogramisty.pl:80/kurs-programowania-java?parametr=wartosc&innyParametr=wartosc

Mamy tutaj informację o protokole (https), serwerze (www.samouczekprogramisty.pl), ścieżce (/kurs-programowania-java) i parametrach (parametr=wartosc&innyParametr=wartosc).

{% include newsletter-srodek.md %}

## Czym jest serwlet

Serwlet to klasa, która implementuje interfejs [`Servlet`]({{ site.doclinks.javax.servlet.Servlet }}). Instancje tej klasy tworzone są przez kontener serwletów (na przykład Jetty). Instancje te wiedzą jak odpowiadać na żądania, które dostają od klienta.

Do obsługi żądania klienta służy metoda [`service`]({{ site.doclinks.javax.servlet.Servlet }}#service-javax.servlet.ServletRequest-javax.servlet.ServletResponse-). Metoda ta przyjmuje jako parametry żądanie i odpowiedź. Na podstawie parametrów żądania odpowiednio modyfikuje przekazany argument odpowiedzi.

Szczerze mówiąc do tej pory ani razu nie napisałem klasy, która bezpośrednio implementuje ten interfejs. Używa się do tego klas, które upraszczają tworzenie serwletów. Są to klasy [`GenericServlet`]({{ site.doclinks.javax.servlet.GenericServlet }}) i [`HttpServlet`]({{ site.doclinks.javax.servlet.http.HttpServlet }}).

Chociaż specyfikacja serwletów, nie wymaga użycia serwletów z protokołem HTTP w praktyce nie spotkałem się z innym zastosowaniem. Zatem z dwóch wyżej wspomnianych klas powinieneś zapamiętać [`HttpServlet`]({{ site.doclinks.javax.servlet.http.HttpServlet }})[^serwlet].

[^serwlet]: Prawda jest taka, że używając bibliotek pomagających tworzyć aplikacje webowe sam nie będziesz pisał serwletów. Będą to zwykłe klasy, które będą przez bibliotekę wywoływane. Biblioteka dostarczy “główny” serwlet, który będzie przekazywał żądania dalej.

## Interfejs serwletów

Wcześniej wspomniałem Ci już o metodzie `service`. Metodę tę musiałbyś zaimplementować jeśli utworzyłbyś klasę, która implementuje interfejs `Servlet` bezpośrednio. W przypadku klasy, która dziedziczy po `HttpServlet` wystarczy nadpisanie odpowiedniej metody. Na przykład, jeśli twój serwlet ma obsłużyć żądania typu GET musisz zaimplementować metodę `doGet`. Istnieją też metody dla pozostałych “czasowników”, na przykład `doPost` czy `doPut`.

W interfejsie serwletów znajdują się też metody, które są wykorzystywane w trakcie cyklu życia serwletu. Jak wspomniałem wyżej kontener odpowiedzialny jest za tworzenie instancji serwletu. Ponadto kontener zarządza cyklem życia serwletu używając metod z tego interfejsu.

## Cykl życia serwletu

Każda instancja serwletu ma swój cykl życia. Jest to jasno zdefiniowana lista etapów, przez które przechodzi każdy serwelt. Lista ta wygląda następująco:

### Utworzenie instancji serwletu

Kontener wyszukuje klas serwletów i następnie tworzy jedną instancję serwletu[^instancja].

[^instancja]: Chodzi o zachowanie domyślne, kontener może utworzyć kilka instancji jeśli zaimplementujesz interfejs SingleThreadedModel. Takie podejście nie jest jednak polecane.

### Inicjalizacja serwletu

Z racji tego, że to kontener serwletów odpowiedzialny jest za tworzenie instancji klasy serwletu nie ma możliwości przekazania odpowiednich parametrów do konstruktora. Do inicjalizacji stanu serwletu służy metoda [`init`]({{ site.doclinks.javax.servlet.Servlet }}#init-javax.servlet.ServletConfig-) i jest ona wywoływana przez kontener przed rozpoczęciem obsługi żądań przez dany serwlet.

### Obsługa żądań

W trakcie tego etapu kontener serwletów może wielokrotnie użyć tej samej instancji to obsługi wielu żądań. Pociąga to za sobą dość poważne konsekwencje. Możliwa jest sytuacja, w której w tym samym czasie instancja serwletu będzie obsługiwała kilka żądań jednocześnie. Na przykład jest to możliwe, gdy kilku użytkowników wejdzie na ten sam adres. Obsługa każdego żądania to wywołanie przez kontener metody [`service`]({{ site.doclinks.javax.servlet.Servlet }}#service-javax.servlet.ServletRequest-javax.servlet.ServletResponse-).

### Zniszczenie serwletu

Kontener może usunąć daną instancję serwletu. Przed zniszczeniem instancji wywołana zostanie metoda [`destroy`]({{ site.doclinks.javax.servlet.Servlet }}#destroy--). Dzięki temu wewnątrz serweltu masz szansę na “posprzątanie”. Metoda ta może na przykład służyć do zamknięcia połączenia z bazą danych. Nie masz pewności jak długo serwlet będzie żył, o tym decyduje kontener.

## Kontener serwletów

Z poprzednich paragrafów dowiedziałeś się już, że kontener serwletów zarządza cyklem życia serwletów. Nie jest to jedyna odpowiedzialność kontenera. Kontener serwletów odpowiedzialny jest za “wyszukanie” klas odpowiedzialnych za działanie aplikacji.

W pierwszych wersjach specyfikacji niezbędny był do tego plik `web.xml` (tak zwany deskryptor wdrożenia), teraz aplikację webową można skonfigurować przy pomocy adnotacji. Dalej jednak to kontener musi “znaleźć” te klasy.

Poza serwletami istnieją też inne komponenty aplikacji webowej opisane w specyfikacji serlwetów. Na przykład filtry czy “listnenery” (ang. _listener_) (ma ktoś z was pomysł jak przetłumaczyć to słowo na polski :)?). Także i tutaj kontener serwletów pełni kluczową rolę. Kontener zarządza cyklem życia tych elementów.

Przy konstruowaniu odpowiedzi na żądania pomocne są pliki typu JSP (ang. _Java Server Pages_). Powtórzę się – kontener zarządza cyklem życia takich plików.

W przypadku aplikacji webowych możemy mówić o kilku kontekstach. Możemy wyróżnić na przykład kontekst żądania czy kontekst aplikacji. Także tutaj kontener serwletów za nie odpowiada.

Jest jeszcze wiele innych aspektów, za które odpowiada kontener wybiegają jednak poza zakres tego artykułu. Napiszę jeszcze o jednym z nich. Kontener także odpowiedzialny jest za instalowanie aplikacji webowej, wiąże się to z “czytaniem” zawartości pliku war, w którym znajduje się aplikacja webowa.

## Plik war

W artykule opisującym [Javę z linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}) możesz przeczytać o plikach jar. W przypadku aplikacji webowych plik war pełni kluczową rolę.

W skład aplikacji webowej mogą wchodzić:

- serwlety,
- strony jsp,
- inne klasy Java,
- zależności aplikacji webowej,
- statyczne pliki (na przykład html czy css),
- pliki konfiguracyjne opisujące aplikację webową.

Wszystkie te pliki pakowane są w odpowiednią strukturę wewnątrz pliku war.

### Struktura aplikacji webowej

Podobnie jak w przypadku pliku jar jest to zwykłe archiwum zip ze zmienionym rozszerzeniem (war a nie zip). Buduje się go przy pomocy tych samych narzędzi jak plik jar . Struktura przykładowego pliku war jest następująca:

    struktura_pliku.war
    ├── index.html
    ├── publiczny_katalog
    │   └── strona.html
    ├── style.css
    └── WEB-INF
        ├── classes
        │   └── pl
        │   └── samouczekprogramisty
        │   └── SomeServlet.class
        ├── lib
        │   └── some-jar-file.jar
        └── web.xml

Pliki takie jak `index.html`, `publiczny_ktalog/strona.html` czy `style.css` są publicznie dostępne. Oznacza to tyle, że kontener serwletów może serwować te pliki.

Sprawa wygląda zupełnie inaczej w przypadku katalogu `WEB-INF`. Jest to katalog, który zawiera dane, które nigdy nie mogą być bezpośrednio “serwowane” przez kontener. Wewnątrz `WEB-INF` znajdują się inne katalogi:

- `classes` – zawiera on skompilowane klasy aplikacji webowej,
- `lib` – zawiera on spakowane pliki jar potrzebne do działania aplikacji webowej.

Dodatkowo aplikacja webowa może zawierać tak zwany deskryptor wdrożenia (ang. _deployment descriptor_). Jest to plik `web.xml`, który konfiguruje działanie aplikacji webowej. W przypadku prostych aplikacji nie jest on wymagany, całą konfigurację można dostarczyć przy pomocy adnotacji.

## Sekret działania Spring MVC

W codziennej pracy z aplikacjami webowymi programiści bardzo rzadko (wcale?) tworzą swoje serwlety. W ogromnej większości przypadków to biblioteka pomagająca przybudowaniu aplikacji webowych zawiera “główny serwlet”.

Ten serwlet pośredniczy przy wszystkich zapytaniach do danej aplikacji webowej. Następnie w zależności od ścieżki, której dotyczy dane żądanie przekazuje je do odpowiedniej klasy. I to właśnie te klasy pisane są przez programistów.

Dla przykładu w Spring MVC takim “głównym serwletem” jest [`DispatcherServlet`](https://github.com/spring-projects/spring-framework/blob/master/spring-webmvc/src/main/java/org/springframework/web/servlet/DispatcherServlet.java). Zachęcam do zajrzenia do źródeł tego serwletu. Zobaczyć możesz tam jakie mechanizmy użyte są do przekazania żądania dalej.

Jak przeszukasz `DispatcherServlet` i klasy po których dziedziczy dogrzebiesz się do dobrze znanych metod, takich jak [`service`](https://github.com/spring-projects/spring-framework/blob/master/spring-webmvc/src/main/java/org/springframework/web/servlet/FrameworkServlet.java#L833) czy [`doGet`](https://github.com/spring-projects/spring-framework/blob/master/spring-webmvc/src/main/java/org/springframework/web/servlet/FrameworkServlet.java#L853).

## Pierwsza aplikacja webowa

Nadszedł czas, żeby wykorzystać tę wiedzę w praktyce. Proszę spójrz na przykład poniżej:

```java
@WebServlet("/date")
public class DateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DateTime now = DateTime.now();
        PrintWriter responseOutput = response.getWriter();
        responseOutput.append("<html><body>" + now.toString() + "</body></html>");
    }
}
```

[`DateServlet`](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/01_serwlety/src/main/java/pl/samouczekprogramisty/kursaplikacjewebowe/servlets/DateServlet.java) to serwlet, który odpowiada na żądania typu GET wysłane na adres `/date`. Oczywiście w produkcyjnych aplikacjach w inny sposób konstruuje się odpowiedzi, jednak przykład ten pokazuje ogólną zasadę działania.

`response.getWriter()` zwraca instancję klasy `PrintWriter`. Należy traktować ją jako zawartość pliku, która zostanie wysłana w odpowiedzi na żądanie. Jeśli użyjemy tej metody odpowiedź, którą wygenerujemy musi być tekstowa (nie binarna). Ostatnia linijka metody `doGet` to właśnie generowanie treści odpowiedzi, gdzie odpowiadamy aktualną datą umieszczoną wewnątrz podstawowych znaczników html.

Taką klasę serwletu umieszczamy w projekcie. W moim przypadku jego struktura wygląda następująco:

    .
    ├── 01_serwlety
    │   ├── build
    │   ├── build.gradle
    │   └── src
    │   └── main
    │   ├── java
    │   │   └── pl
    │   │   └── samouczekprogramisty
    │   │   └── kursaplikacjewebowe
    │   │   └── serwlety
    │   │   └── DateServlet.java
    │   └── webapp
    ├── build.gradle
    ├── gradle
    │   └── wrapper
    │   ├── gradle-wrapper.jar
    │   └── gradle-wrapper.properties
    ├── gradlew
    ├── gradlew.bat
    └── settings.gradle

Na tym etapie proszę użyj przykładowych plików umieszczonych w [repozytorium kodu](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe). W osobnym artykule wytłumaczę zasadę działania Gradle w przypadku aplikacji webowych. Bazowy plik [`build.gradle`](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/build.gradle) i plik [`01_serwlety/build.gradle`](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/01_serwlety/build.gradle) pozwalają na uruchomienie tak utworzonej aplikacji webowej:

    KursAplikacjeWebowe$ ./gradlew appRun
    :01_serwlety:prepareInplaceWebAppFolder NO-SOURCE
    :01_serwlety:createInplaceWebAppFolder UP-TO-DATE
    :01_serwlety:compileJava UP-TO-DATE
    :01_serwlety:processResources NO-SOURCE
    :01_serwlety:classes UP-TO-DATE
    :01_serwlety:prepareInplaceWebAppClasses UP-TO-DATE
    :01_serwlety:prepareInplaceWebApp UP-TO-DATE
    :01_serwlety:appRun
    10:19:57 INFO Jetty 9.2.15.v20160210 started and listening on port 8080
    10:19:57 INFO 01_serwlety runs at:
    10:19:57 INFO http://localhost:8080/01_serwlety
    Press any key to stop the server.
    > Building 87% > :01_serwlety:appRun

Następnie uruchomienie przeglądarki i wpisanie adresu `http://localhost:8080/01_serwlety/date` powinno pokazać działającą aplikację, która wyświetla datę:

{% include figure image_path="/assets/images/2017/03/25_przegladarka_odpowiedz.jpeg" caption="Odpowiedź z `DataServlet`" %}

## Ćwiczenie do wykonania

Na podstawie [przykładowej aplikacji](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/01_serwlety) napisz serwlet, który wyświetli liczbę sekund, od dnia Twojego urodzenia. Po wejściu na stronę, którą obsługuje dany serwlet powinna pokazać się liczba sekund, od Twoich urodzin.
## Dodatkowe materiały do nauki

Poniżej przygotowałem dla Ciebie kilka dodatkowych linków, które pomogą Ci rozszerzyć wiedzę z tego artykułu:
- [Protokół HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)
- [Specyfikacja serwletów wersja 3.1]({{ site.doclinks.specs.servlet }})
- [Specyfikacje Java EE 7]({{ site.doclinks.specs.jee7 }})
- [Przykłady użyte w tym artykule](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/01_serwlety)

## Podsumowanie

Gratulacje! Udało Ci się przeczytać cały artykuł, a nie należał on do najkrótszych ;). Po jego przeczytaniu wiesz czym jest serwlet. Poznałeś strukturę pliku war, znasz podstawowy zakres odpowiedzialności kontenera serwletów. Poznałeś też część magii, która kryje się pod spodem biblioteki Spring MVC. No i oczywiście utworzyłeś swoją pierwszą dynamiczną aplikację webowową!

Mimo objętości artykułu nie wyczerpałem tematu aplikacji webowych, jest to jeden z serii artykułów opisujących podstawy aplikacji webowych w Javie. Jeśli nie chcesz pominąć kolejnych artykułów polub Samouczka na facebooku i zapisz się do newslettera.

Do następnego razu!
