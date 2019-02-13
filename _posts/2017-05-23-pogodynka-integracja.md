---
title: Pogodynka – integracja
last_modified_at: 2017-11-11 22:14:39 +0100
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /pogodynka-integracja/
header:
    teaser: /assets/images/2017/05/23_pogodynka_integracja_artykul.jpeg
    overlay_image: /assets/images/2017/05/23_pogodynka_integracja_artykul.jpeg
    caption: "[&copy; 85182154@N00](https://www.flickr.com/photos/85182154@N00/296492538/sizes/l)"
excerpt: Raport z frontu Pogodynki. Ostatnie dwa dni minęły pod znakiem integracji. Spinałem w całość poszczególne elementy projektu. Pisania kodu było tu niewiele, raczej wyszukiwanie błędów i praca z zakresu “dev-ops”. Niemniej jednak prawie 30% zmian w repozytorium pojawiło się w przeciągu tych dwóch dni.
disqus_page_identifier: 908 http://www.samouczekprogramisty.pl/?p=908
toc: false
---

Jak wspomniałem wyżej większość zmian związanych było z konfiguracją i integracją poszczególnych komponentów. Zacznę od serwera HTTP.

## [nginx](https://nginx.org/en/)

Jak wspomniałem w jednym z poprzednich raportów nie chcę rozdmuchiwać kosztów projektu. Nie chciałem też pisać warstwy widoku w oparciu o JSP. Mógłbym statyczne strony HTML zawrzeć w pliku WAR, jednak nie podoba mi się to rozwiązanie.

Moim zdaniem nie jest to podejście, w którym teraz tworzy się nowe strony WWW. Przy jednym pliku WAR miałbym monolityczną aplikację. Przy podejściu, które zastosowałem mam osobną warstwę z interfejsem użytkownika i osobną, która serwuje dane.

Aby obsłużyć taką konfigurację i używać wyłącznie jednej instancji [VPS](https://en.wikipedia.org/wiki/Virtual_private_server) (ang. _Virtual Private Server_) użyłem serwera nginx.

Na tej samej instancji uruchomiony jest serwer Tomcat. W związku z konfiguracją firewall’a na tej maszynie nie jest on jednak dostępny bezpośrednio. nginx skonfigurowałem jako “reverse proxy”. Sprowadza się to do tego, że część żądań przesyłana jest przez nginx to Tomcata. Pozostała część to serwowanie statycznych stron.

W uproszczeniu konfiguracja ta podobna jest do tej pokazanej na diagramie poniżej:

{% include figure image_path="/assets/images/2017/05/23_nginx_diagram.jpeg" caption="Nginx – reverse proxy." %}

Interfejs użytkownika wykorzystywał będzie aplikację webową do pobrania informacji o dotychczasowych odczytach temperatury.

## [PostgreSQL](https://www.postgresql.org/)

Baza danych, którą skonfigurowałem do pracy z projektem nie nadaje się na produkcję. Mowa tu o [HyperSQL](http://hsqldb.org). Do produkcyjnego działania potrzebna jest baza z prawdziwego zdarzenia. I tak pojawił się PosgreSQL.

Przy pomocy puppet’a skonfigurowałem serwer bazy danych, utworzyłem bazę i dodałem odpowiednich użytkowników. Użytkownik, którego używam w aplikacji ma uprawnienia tylko do części elementów. Konfigurację możesz zobaczyć na [githubie](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/puppet/modules/pogodynka/manifests/database.pp).

Dodatkowo sama baza danych zainstalowana jest na tym samym VPS co Tomcat. Dzięki temu nie ma potrzeby “otwierać” bazy danych na świat. Dostępna jest ona wyłącznie lokalnie. Zapewnia to sama konfiguracja PostgreSQL oraz reguł firewall’a.

## Raspberry PI

Stwierdziłem, że skoro mam już Puppeta to wykorzystam go także po stronie Raspberry PI. Podzieliłem manifesty w ten sposób, że konfiguracja Malinki także jest jasno opisana. Całość znajduje się w pliku [node\_thermometer.pp](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/puppet/modules/pogodynka/manifests/node_thermometer.pp).

Dzięki takiemu podejściu mam spójny sposób na konfigurację wszystkich “serwerów” jakie używam. Dodatkowo nie muszę już manualnie zarządzać wpisami w crontab. Robi to za mnie [puppet](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/puppet/modules/pogodynka/manifests/node_thermometer.pp#L27).

## Konfiguracja serwera Tomcat

Aplikacje [Datavault](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/datavault) i [Thermometer](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/thermometer) starałem się pisać w taki sposób aby móc udostępnić kod publicznie.

Ma to pewne konsekwencje. Mianowicie pewne elementy takie jak hasła nie powinny być publicznie dostępne. Aby to obejść użyłem zmiennych środowiskowych. Używam takiej zmiennej na przykład aby pobrać [hasło użytkownika bazy danych](https://github.com/SamouczekProgramisty/Pogodynka/blob/5c5334e0dc5878cb62d4c864a5035ca54c607373/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/configuration/JPAConfigration.java).

Zmienne te są ustawione na serwerze za pomocą [puppet’a](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/puppet/modules/pogodynka/manifests/tomcat.pp#L21). Ich wartość pobierana jest za pośrednictwem mechanizmu hiera (opisałem go w jednym z poprzednich [artykułów opisujących projekt Pogodynka]({% post_url 2017-05-07-pogodynka-konfiguracja-bazy-danych %})) więc nie są to dane dostępne publicznie.

## Zmiany w kodzie

Jak wspomniałem zmian w kodzie Javy było niewiele. Można je podzielić na dwie części:
- wspólne interfejsy,
- uwierzytelnianie.

### Wspólne interfejsy

Pogodynka składa się z trzech modułów: Datavault, Thermometer i Frontend. Thermometer wysyła dane do Datavault używając zapytania HTTP. Zapytanie to zawiera dane w formacie JSON.

W aplikacji Thermometer wysyłałem dane sformatowane w trochę inny sposób niż było to oczekiwane przez Datavault. Jako konsekwencja Datavault zwracał odpowiedzi ze statusem 400 na każde żądanie wysłane z Thermometer. Uwspólnienie formatu rozwiązało problem.

### Uwierzytelnianie

Chociaż dane z termometru są publicznie dostępne to powinny być dostępne wyłącznie do odczytu. Możesz to sprawdzić otwierając [stronę pogodynki](http://pogodynka.pietraszek.pl).

Zależy mi na tym aby te dane były rzetelne. Sprowadza się to do tego, że tylko określeni użytkownicy powinni móc dodawać informacje o aktualnych odczytach.

Nie chciałem zbytnio komplikować mechanizmu uwierzytelniania/autoryzacji więc poszedłem po najmniejszej linii oporu. Mianowicie przy żądaniu wysyłającym nowy pomiar sprawdzana jest zawartość pewnego nagłówka. Jeśli zawartość ta jest błędna żadne dane nie są dodawane do bazy. W odpowiedzi wysyłany jest kod 403.

Ta tajna wartość nagłówka również przechowywana jest w zmiennej środowiskowej.

## Brakujące elementy

### Czujnik zewnętrzny

Aktualnie całość działa w oparciu o czujnik wewnętrzny. Takie podejście raczej nie przejdzie próby deszczu ;). Kupiłem czujnik zewnętrzny, Mam nadzieję, że jutro już będzie uruchomiony.

{% include figure image_path="/assets/images/2017/05/23_czujnik_wodoodporny.jpeg" caption="Woododporny czujnik temperatury." %}

### Interfejs użytkownika

Chociaż szablon interfejsu użytkownika jest już dostępny, nie jest on prawidłowy. Aby miał on sens musi pobierać dane o temperaturach z Datavault. Właśnie na tej części skupię się w przeciągu najbliższych dni.

## Podsumowanie

Integrację mogę uznać za ukończoną. Monitoring całości opisany w początkowych odcinkach także działa. Zostały ostatnie szlify. Myślę, że mam duże szanse ukończyć projekt w terminie. Konkurs “Daj się poznać” trwa do 31.05.2017 więc zostało jeszcze parę dni. Trzymajcie kciuki i do następnego razu!
