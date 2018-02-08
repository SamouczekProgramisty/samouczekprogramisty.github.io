---
title: Protokół HTTP
categories:
- Kurs aplikacji webowych
permalink: /protokol-http/
header:
    teaser: /assets/images/2018/02/08_protokol_http_artykul.jpg
    overlay_image: /assets/images/2018/02/08_protokol_http_artykul.jpg
    caption: "[&copy; adrienneserra](https://www.flickr.com/photos/adrienneserra/2037060375/sizes/l)"
excerpt: W artykule tym dowiesz się więcej o protokole HTTP. Przeczytasz o ciasteczkach, nagłówkach i czasownikach HTTP. Dowiesz się czym jest idempotentość. Poznasz najczęściej stosowane nagłówki. W artykule tym zebrałem podstawową więdzę na temat prokokołu HTTP niezbędną do tworzenia aplikacji webowybch.
---

## Czym jest protokół HTTP

Według <a href="https://sjp.pwn.pl/sjp/protokol;2572786.html">słownika języka polskiego</a> protokół to:

> zasady wymiany informacji i współpracy programów i urządzeń komputerowych

Zatem protokół HTTP (ang. _Hypertext Transfer Protocol_) to zasady wymiany informacji i współpracy programów. Programami są serwery i klienty. Programy te wysyłają żądania (klienty) lub odpowiedzi (serwery). Przykładem klienta HTTP może być [przeglądarka internetowa](https://www.opera.com/)[^praca]. Klienty mogą interpretować uzyskane odpowiedzi, na przykład przeglądarka internetowa potrafi wyświetlić stronę internetową, która została przesłana przez serwer.

Nawiasem mówiąc przeglądarka robi całkiem sporo rzeczy w tle... Wiesz, że do wyświetlania strony www.amazon.com przeglądarka wykonuje około 300 żądań HTTP? W końcowej części artykułu pokażę Ci jak to się dzieje.
{: .notice--info}

[^praca]: Ot, taki "patriotyzm lokalny" - aktualnie pracuję w firmie Opera Software ;).

Komunikacja pomiędzy serwerem a klientem oparta jest na wielu innych protokołach. Ten zestaw porotokółów nazywa się modelem [ISO/OSI](https://pl.wikipedia.org/wiki/Model_OSI). Model ten zawiera wartstwy. Każda warstwa, na bazie poprzednich, udostępnia dodatkowe funkcjonalności. Protokół HTTP znajduje się w najwyższej warstwie modelu, [warstwie aplikacji](https://pl.wikipedia.org/wiki/Model_OSI#Warstwa_7:_aplikacji).
{: .notice--info}

Klienty wysyłają żądania. Każde żadanie powiązane jest z zasobem. Zasobem może być obrazek, strona HTML czy plik z kodem JavaScript. Sam protokół HTTP nie określa czym dokładnie jest zasób. Określa jedynie sposób w jaki można dostać się do zasobów. Każdy zasób ma swój unikalny identyfikator. Ten identyfikator to URI (ang. _Uniform Resource Identifier_). 

Protokół HTTP dokładnie określa format komunikacji pomiędzy klientami i serwerami. Komunikacja ta oparta jest na wspomnianych już żądaniach i odpowiedziach. Protokół HTTP określa format tych wiadomości.

Protokół HTTP jest bezstanowy. Oznacza to tyle, że każde zapytanie może być interpretowane w oderwaniu od pozostałych.

Poza klientami i serwerami w komunikacji występują dodatkowe węzły. Na przykład mogą to być serwery, które zachowują kopię odpowiedzi przyspieszając komunikację. Mogą to być także elementy sieciowe pozwalające na sprawne dotarcie żądania do serwera. W tym artykule pominę te kwestie, moim zdaniem ich znajomość nie jest niezbędna do tworzenia aplikacji webowych.

Teraz wprowadzę Cię w poszczególne elementy składające się na protokół HTTP.

## Adres czyli URL

Wspomniałem wcześniej o URI. Podzbiorem URI są URL (ang. _Uniform Resource Locator_). URI możnta traktować jako zbiór znaków który pozwala na unikalną identyfikację zasobu. URL natomiast poza tym unikalnym identyfikatorem zawiera informację dotyczącą "położenia" danego zasobu. Często określenia te stosowane są zamiennie. 


Adres URL ma postać:

    scheme:[//[user[:password]@]host[:port]][/path][?query][#fragment]

Przykładowy adres URL może wyglądać następująco:

    http://marcin:tajne@www.samouczekprogramisty.pl:80/nie/ma/tej?strony=1#identyfikator


| Część adresu | Przykładowa wartość         |
| ------------ | --------------------------- |
| scheme       | http                        |
| user         | marcin                      |
| password     | tajne                       |
| host         | www.samouczekprogramisty.pl |
| port         | 80                          |
| /path        | /nie/ma/tej                 |
| ?query       | ?strony=1                   |
| #fragment    | #identyfikator              |


Zgodnie ze specyfikacją HTTP wielkość liter nie ma znaczenia w częściach schema i host. Wielkość liter w pozostałych elementach ma znaczenie[^litery].

[^litery]: To czy wielkość liter jest rozróżniana zależy od aplikacji obsługującej dane żądanie.

Poniżej opiszę poszczególne części adresu URL.

### scheme

W praktyce ta część adresu używana jest do określenia protokołu, najczęściej zobaczysz tu `http` czy `https`. W uproszczeniu można powiedzieć, że HTTPS (ang. _Hypertext Transfer Protocol Secure_) jest rozszerzeniem protokołu HTTP. To rozszerzenie pozwala na szyfrowanie połączenia pomiędzy klientem a serwerem.

### user:password

user:password służą do uwierzytelniania. Uwierzytelnianie to proces, który polega na udowodnieniu, że klient wysyłający dane żądanie jest tym za kogo się podaje. Mechanizmu uwieżytelniania używasz praktycznie w każdym serwisie gdzie masz założone konto. 

W tym przypadku nazwa użytkownika i hasło przesyłane są jako część URL. Nie jest to bezpieczne w przypadku używania protokołu HTTP. Nawet przy komunikacji protokołem HTTPS adres URL może być zapamiętany przez przeglądarkę. Daje to możliwość przechwycenia nazwy użytkownika i hasła. W związku z tym nie jest to bezpieczny sposób na przesyłanie hasła czy nazwy użytkownika i należy go unikać[^wewnetrzna].

[^wewnetrzna]: Potrafię sobie wyobrazić wyjątki od tej reguły. Na przykład w komunikacji, w której adres URL jest przesyłany zaszyfrowanym kanałem.

### host

W przypadku protokołu HTTP sprowadza się to do nazwy domeny internetowej lub adresu IP. Przykładem domeny może być <a href="http://www.samouczekprogramisty.pl">www.samouczekprogramisty.pl</a>. Przykładowy adres IPv4 to `192.30.253.112`. Jaka strona kryje się pod tym adresem :)?

[DNS](https://pl.wikipedia.org/wiki/Domain_Name_System) (ang. _Domain Name System_) jest protokołem, który pozwala na tłumacznie [adresów IP](https://pl.wikipedia.org/wiki/Adres_IP) na nazwy domen.
{: .notice--info}

### port

Port to numer. Numer ten jest wykorzystywany przez serwer. Serwer nasłuchuje ruch na danym porcie. Protokoły mają swoje standardowe porty. Na przykład standardowym portem protokołu HTTP jest 80. Protokół HTTPS natomiast używa portu 443. W praktyce, ze względu na domyślne wartości, porty te często się pomija. Odpowiednia wartość pola scheme pozwala na określenie czy użytkownikowi chodzi o port 80 czy 443.

Możesz także uruchomić serwer, który nasłuchuje na innym porcie. Przykładem może tu być Tomcat, który domyślnie uruchamia się na porcie 8080. W takim przypadku podanie portu jest konieczne.

### path

Ta część adresu URL jest ścieżką, która określa zasób. Na przykład w adresie `www.samouczekprogramisty.pl/kurs-programowania-java` ścieżką jest `/kurs-programowania-java`.

### query

Zawiera dodatkowe dane identyfikujące dany zasób. Ta część oddzielona jest od ścieżki znakiem `?`. W praktyce zawiera pary `klucz=wartość` połączone znakiem `&`. Na przykład:

    ?parametr=wartosc&format=json

### fragment

Ostatnia część adresu URL. W praktyce wykorzystywana jest do określenia fragmentu strony HTML, która powinna zostać pokazana użytkownikowi. Na przykład adres [http://www.samouczekprogramisty.pl/strumienie-w-jezyku-java/#właściwości-strumieni](http://www.samouczekprogramisty.pl/strumienie-w-jezyku-java/#właściwości-strumieni) przeniesie Cię do sekcji opisującej właściwości strumieni.

## Żądanie i odpowiedź

{% capture devtools %}
W dalszej części artykułu będę używał programu [curl](https://curl.haxx.se/) jako klienta HTTP. Jest to program, który pozwala na łatwe wysyłanie zapytań do serwerów z linii poleceń.

Jeśli nie chcesz używać tego programu możesz użyć narzędzi dla programistów dostępnych w Twojej przeglądarce:

* [Chrome](https://developer.chrome.com/devtools),
* [Firefox](https://developer.mozilla.org/son/docs/Tools),
* [Safari](https://developer.apple.com/safari/tools/),
* [Opera](http://www.opera.com/dragonfly/),
* [Edge](https://docs.microsoft.com/en-us/microsoft-edge/devtools-guide).
{% endcapture %}

<div class="notice--info">
    {{ devtools | markdownify }}
</div>

Teraz przeanalizuję przykładowe zapytanie wraz z odesłaną odpowiedzią. Użyję do tego publiczego API Github'a. Github używa HTTPS, w analizie żądania/odpowiedzi pominę fragmenty dotyczące HTTPS.

### Żądanie HTTP

Klient wysyła żądanie do serwera w formie wiadomości. Wiadomość ta ma dokładnie zdefiniowany format:

 - linia określająca czasownik HTTP, zasób i wersję protokołu,
 - linie zawierające nagłówki,
 - pustą linię określającą koniec nagłówków,
 - ciało wiadomości (jeśli istnieje).

Jak wspomniałem wyżej użyję programu curl. Dodatoko użyję przełącznika `-v`. Włącza on tryb lania wody ;). Wtedy curl raportuje dużo więcej informacji. Dane wysłane do serwera poprzedzone są znakiem `>`. Odpowiedź poprzedzona jest `<`. Poniżej pokazuję zapytanie do API githuba. Wysyłam żądanie na adres `https://api.github.com/users/kbl`:


    $ curl -v https://api.github.com/users/kbl
    // ciach usunąłem część związaną z HTTPS
    > GET /users/kbl HTTP/1.1
    > Host: api.github.com
    > User-Agent: curl/7.52.1
    > Accept: */*
    > 

Zacznę od analizowania pierwszej linijki `GET /users/kbl HTTP/1.1`. Na początku zawiera ona czasownik HTTP - `GET` (czasowniki opiszę dokładniej poniżej). Następnie zawiera część adresu URL, wszystko od częśći "path". W moim przypadku jest to `/users/kbl`. Kolejną częścią jest protokół wraz z wersją `HTTP/1.1`.

Trzy kolejne linijki zawierają tak zwane nagłówki HTTP, nagłówkom także poświęcę osobny podpunkt poniżej.

W przypadku tego żądania, ciało wiadomości jest puste. Widzisz więc tylko pustą liniję oddzielającą nagłówki od pominiętego ciała wiadomości.

### Odpowiedź HTTP

Serwer odpowieada na żądanie klienta wysyłając odpowiedź[^kilka]. Podobnie jak w przypadku zapytania format jest dokładnie określony:

 - linijka z wersją protokołu i statusem odpowiedzi,
 - linie zawierające nagłówki, 
 - pustą linię określającą koniec nagłówków,
 - ciało wiadomości (jeśli istnieje).

[^kilka]: Na jedno żądanie serwer może wysłać kilka odpowiedzi, na przykład dzieląc dużą odpowiedź na kilka mniejszych.

Tym razem odpowiedź, jest dużo dłuższa:

    < HTTP/1.1 200 OK
    < Server: GitHub.com
    < Date: Tue, 06 Feb 2018 19:36:28 GMT
    < Content-Type: application/json; charset=utf-8
    < Content-Length: 1218
    < Status: 200 OK
    < X-RateLimit-Limit: 60
    < X-RateLimit-Remaining: 55
    < X-RateLimit-Reset: 1517949218
    < Cache-Control: public, max-age=60, s-maxage=60
    < Vary: Accept
    < ETag: "268c03d98e6e20c7824364d61b3f51b0"
    < Last-Modified: Mon, 09 Oct 2017 19:42:33 GMT
    < X-GitHub-Media-Type: github.v3; format=json
    < Access-Control-Expose-Headers: ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval
    < Access-Control-Allow-Origin: *
    < Content-Security-Policy: default-src 'none'
    < Strict-Transport-Security: max-age=31536000; includeSubdomains; preload
    < X-Content-Type-Options: nosniff
    < X-Frame-Options: deny
    < X-XSS-Protection: 1; mode=block
    < X-Runtime-rack: 0.030276
    < X-GitHub-Request-Id: 8AAA:602C:92D77:140069:5A7A03BC
    < 
    {
      "login": "kbl",
      // ciach
      "created_at": "2009-04-14T08:28:56Z",
      "updated_at": "2017-10-09T19:42:33Z"
    }

Pierwsza linijka to wspomniany wcześniej protokół `HTTP/1.1`. Następnie status odpowiedzi `200 OK`, podobnie jak w przypadku nagłówków i czasowników więcej o statusie przeczytasz w osobnym podpunkcie.

Kolejne 22 linijki to nagłówki, po których występuje pusta linija. Podobnie jak przy żądaniu oddziela ona nagłówki od ciała wiadomości.

W przypadku odpowiedzi ciało wiadomości zawiera dane w formacie JSON - zasób. Dla czytelności pominąłem tu większość ciała odpowiedzi. Zachęcam Cię do eksmerymentowania z własnymi zapytaniami :). Do tych eksperymentów może Ci się przydać [dokumentacja API](https://developer.github.com/v3/).

## Czasowniki HTTP

Specyfikacja HTTP definiuje 8 czasowników[^rozszerzenie]. Każdy z tych czasowników powiązany jest z żądaniem wysyłanym przez klienta. Każde z żądań ma swoje zastosowania.

[^rozszerzenie]: [RFC5789](https://tools.ietf.org/html/rfc5789) rozszerza tę grupę o czasownik PATCH.

Zanim przejdę do omówienia poszczególnych czasowników musisz wiedzieć czym jest cache[^polski]. Cache to mechanizm, który pozwala na zmniejszenie czasu oczekiwania na odpowiedź. Zakładając, że wykonasz dwa zapytania pod rząd o ten sam zasób wynik pierwszego zapytania może być zapisany w cache'u. W związku z tym drugie zapytanie może nie dotrzeć do serwera, odpowiedź może zostać pobrana z cache'a.
{: .notice--info}

[^polski]: Tutuaj podobnie jak z webservice'em postanowiłem nie tłumaczyć tego określenia. Jest ono na tyle powszechne, że nawet nie wiem jakie byłoby dobre tłumaczenie. Schowek? Skrytka? ;)

### GET

Jest to podstawowe żądanie. Każde otworzenie strony internetowej zaczyna się od zapytania typu GET. Przeglądarka wysyła żądanie typu GET żeby otworzyć stronę internetową. Specyfikacja mówi, że żądanie to służy do pobrania aktualnej reprezentacji zasobu. W praktyce może to oznaczać pobranie aktualnej wersji strony znajdującej się pod danym adresem. Zakłada się, że żądania typu GET nie posiadają dołączonego ciała wiadomości.

Odpowiedź na żądania typu GET może być przechowywana w cache'u.

### HEAD

Zapytanie typu HEAD jest podobne do GET. Różni się jednym ważnym szczegółem. W przypadku tego zapytania odpowiedź serwera nie może zawierać ciała wiadomości. Zapytania tego typu są używane do sprawdzenia czy dany zasób się zmienił, czy do sprawdzania poprawności odnośników. Zysk z używania tego zapytania polega na tym, że ciało wiadomości nie jest przesyłane. Wyobraź sobie plik PDF, który zawiera 10MB danych. Można wysłać zapytanie typu HEAD, żeby sprawdzić czy zawartość tego pliku uległa zmianie. To czy plik jest nowszy można określić na podstawie nagłówków, które będą dołączone do odpowiedzi.

Odpowiedź na żądania typu HEAD może być przechowywana w cache'u.

### POST

Specyfikacja mówi, że żądania typu POST są przetwarzane przez serwer zgodnie z założeniami dla danego zasobu. Taki skomplikowany opis sprowadza się do:

 - używania POST do przesyłania zawartości formularzy,
 - dodawania nowego zasobu,
 - dodawanie danych do istniejącego zasobu.

Odpowiedzi na żądania typu POST nie jest przechowywana w cache'u[^wyjatek].

[^wyjatek]: W wiekszości przypadków, specyfikacja dopuscza wyjątki od tej reguły.

### PUT

W codziennym użytkowaniu żądania typu PUT służą do aktualizacji danego zasobu. Zgodnie ze specyfikacją ciało wiadomości powinno posłużyć do ustawienia stanu zasobu na serwerze. Zatem w przypadku gdy zasób nie istniał żądanie tego typu powinno go utworzyć. Jeśli zasób istnieje wówczas jego stan powinien być ustawiony na ten przekazany w ciele wiadomości.

W większości znanych mi przypadków ten pierwszy aspekt jest pomijany, prawodopodobnie dla uproszczenia logiki aplikacji. 

Główna róznica pomiędzy zapytaniami POST i PUT polega na sposobie interpretowania ciała wiadomości. W przypadku zapytania typu POST to zasób decyduje jak przetworzyć otrzymaną wiadomość. W przypadku żadania typu PUT otrzymana wiadomość powinna posłużyć do ustawić wartość zasobu.

Odpowiedzi na żądanie typu PUT nie powinny być przechowywane w cache'u.

#### Idempotentnosć

Oznacza to tyle, że zapytania typu post są idempotentne. Zapytania, które są idempotentne można powtarzać wielokrotnie i zawsze doprowadzą one do tego samego stanu danego zasobu.

### DELETE

Zapytania tego typu służą do usuwania zasobów. Na przykład w którymś z wczesniejszych zapytań dany zasób może być utworzony przy pomocy żądania typu POST. Następnie może on być usunięty przy pomocy DELETE. Odpowiedzi na żądania tego typu nie powinny zawierać ciała wiadomości.

Odpowiedzi na żądania typu DELETE nie powinny być umieszczane w cache'u.

### CONNECT

Żądania tego typu służą do uwtorzenia połączenia pomiędzy klientem a serwerem docelowym (za pośrednictwem proxy). W praktyce nie będziesz używał tego typu żądań w trakcie pisania aplikacji webowych. Mi się to nigdy do tej pory nie zdarzyło :). 

### OPTIONS

Żądania typu OPTIONS używane są do pobrania informacji na temat możliwości komunikacji dla danego zasobu. W praktyce żądania tego typu używane są do sprawdzenia jakie żąddania są obsługiwane przez serwer. Żądanie tego typu także wykorzystywane jest w mechanizmie [CORS](https://pl.wikipedia.org/wiki/Cross-Origin_Resource_Sharing).

Odpowiedzi na żądania typu OPTIONS nie powinny być przechowywane w cache'u.

### TRACE

Żądanie tego typu służy do testowania. W odpowiedzi na to żądanie serwer powinien wysłać zapytanie, które otrzymał. Możliwa jest drobna modyfikacja otrzymanych nagłówków, na przykład serwer może usunąć nagłówki zawierające dane wrażliwe (na przykład ciasteczka). Żądanie typu TRACE nie może zawierać ciała wiadomości.

Odpowiedzi na żądanie typu TRACE nie powinny być umieszczane w cache'u.

## Nagłówki HTTP

Nagłowki dołączane są przez klienty do wysyłanych zapytań i przez serwery do wysyłanych odpowiedzi. Mają one postać `nazwa-nagłówka: wartość-nagłówka`. Zgodnie ze specyfikacją wielkość liter w nazwach nagłówków nie ma znaczenia. Wielkość liter w wartości nagłówka może mieć znaczenie, zależy to od aplikacji. Chociaż istnieje [cała masa standardowych nagłówków](https://www.iana.org/assignments/message-headers/message-headers.xhtml) możesz tworzyć swoje własne.

Nagłówki wykorzystywane są do przesyłania metadanych na temat zasobów. Mogą zawierać na przykład infomacje o formacie, statusie odpowiedzi czy dacie. Poniżej postaram się wyjaśnić kilka najczęściej spotykanych nagłówków:

| Nagłówek      | Znaczenie                                                      |
| Date          | Zawiera datę mówiącą od czasie wygenerowania żądania/odpwiedzi |
| Cache-Control |
| Connection    |

## Ciasteczka

Co prawda ciasteczka to nic innego jak nagłówki, jednak poświęcę im osobny podpunkt. W osobnym artykule możesz przeczytać o [ciasteczkach w kontekście specyfikacji serwletów]({% post_url 2017-04-01-naglowki-sesje-i-ciasteczka %}).

Wiesz już, że protokół HTTP jest bezstanowy. Serwer HTTP nie może powiązać ze sobą zapytać pochodzących od tego samego klienta w jedną paczkę. Z pomocą przychodzą ciasteczka. Ciasteczka to specyficzne nagłówki, które są obsługiwane przez klienty. 

Serwer w odpowiedzi może wysłać nagłówek, który utwory ciasteczko. Ciasteczko to jest przypisane do domeny (część host i path adresu URL). W każdym kolejnym zapytani do tej domeny klient dołącza nagłówki ciasteczek. Dzięki temu aplikacja na serwerze może połączyć pojedyncze zapytania w sesje.

Pewnie kojarzysz formularze logowania, w których możesz zaznaczyć "zapamiętaj mnie". Zaznaczenie tego pola powoduje wysłanie odpowiedzi przez serwer, w której znajduje się nagłówek z ciasteczkiem. To ciasteczko zawiera unikalny klucz, który później jest dołaczany przez klienta do każdego żądania do danej domeny. Dzięki temu każde kolejne zapytanie ma nagłowek z tym tokenem. Aplikacja na serwerze widząc ten token może potwierdzić tożsamość użytkownika.

Niestety ciasteczka wykorzystywane są także do złych celów. Ciasteczka mogą być wykorzystywane jako jeden ze sposobów do śledzenia Twojego ruchu w sieci. Zdarzyło Ci się kliknąć na reklamę a później ta reklama pokazywała Ci się bez przerwy? Ciasteczka także mogły się do tego przyczynić[^zaawansowane].

[^zaawansowane]: Ciasteczka nie są jedynym narzędziem używanym do śledzenia użytkownika. Podobnie sprawa wygląda z reklamami, to nie tylko ciasteczka mogą służyć do wybierania tych do wyświetlenia dla Ciebie.

## Prawie 300 zapytań aby wyświetlić stronę

Teraz jak już wiesz czym jest protokół HTTP wyjaśnię "tajemnicę" około 300 zapytań. 

{% include figure image_path="/assets/images/2018/02/06_amazon_zapytania.jpeg" caption="Do wyświetlenia www.amazon.com potrzeba około 300 zapytań" %}

Przeglądarka jest klientem HTTP. Klienty mogą interpretować odpowiedź wysyłaną od serwera. Wpisując w pasek adresu `www.amazon.com` i naciskając ENTER wysyłasz jedno zapytanie. Jest to zapytanie typu GET o zasób `www.amazon.com`. W odpowiedzi serwer zwraca dokument HTML. 

Dokument ten jest interpretowany przez przeglądarkę, zawiera on znaczniki HTML. Takie jak `img`, `script` czy `style`. Każdy z tych znaczników może kończyć się kolejnym zapytaniem typu GET. Dodatkowo kod JavaScript interpretowany przez przeglądarkę może wykonywać dodatkowe zapytania. W sumie do wyświetlenia strony głównej sklepu Amazon potrzeba tych zapytań około 300. A wszystko zaczęło się od jednego, niewinnego GET :).



jak działa cache http
jak działa uwierzytelnianie http
header cache-control
header size-limit

## Dodatkowe materiały

- [Zbiór materiałów fundacji Mozilla dotyczących HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP),
- Zbiór RFC dla HTTP 1.1:
-- [RFC 7230](https://tools.ietf.org/html/rfc7230)
-- [RFC 7231](https://tools.ietf.org/html/rfc7231)
-- [RFC 7232](https://tools.ietf.org/html/rfc7232)
-- [RFC 7233](https://tools.ietf.org/html/rfc7233)
-- [RFC 7234](https://tools.ietf.org/html/rfc7234)
-- [RFC 7235](https://tools.ietf.org/html/rfc7235)
- [RFC dla URI](https://tools.ietf.org/html/rfc3986)

# Podsumowanie

