---
title: Nagłówki, sesje i ciasteczka
date: 2018-07-18 20:43:32 +0200
categories:
- DSP2017
- Kurs aplikacji webowych
permalink: /naglowki-sesje-i-ciasteczka/
header:
    teaser: /assets/images/2017/04/01_naglowki_ciasteczka_sesje_artykul.jpeg
    overlay_image: /assets/images/2017/04/01_naglowki_ciasteczka_sesje_artykul.jpeg
    caption: "[&copy; nitot](https://www.flickr.com/photos/nitot/6124595416/sizes/l)"
excerpt: W pierwszej części artykułu opisującej serwlety dowiedziałeś się podstaw dotyczących serwletów. W tym artykule będziesz mógł poszerzyć tę wiedzę. Dowiesz się jakie możliwości dają klasy `HttpServletRequest` i `HttpServletResponse`. Wyjaśnię Ci czym jest sesja i jak pracować z `HttpSession`. Przeczytasz także o nagłówkach i ciasteczkach, nauczysz się tworzyć je samodzielnie. Na końcu czeka także ćwiczenie, w którym zastosujesz wiedzę w praktyce. Zapraszam do lektury.
disqus_page_identifier: 817 http://www.samouczekprogramisty.pl/?p=817
---

## Wprowadzenie

Zacznijmy od żądań i odpowiedzi. Wiesz już, o hierarchii dziedziczenia serwletów `Servlet`, `GenericServlet` i `HttpServlet`. W przypadku klasy opakowującej żądanie i odpowiedź sytuacja wygląda podobnie. Istnieją bazowe interfejsy [`ServeltRequest`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html) i [`ServletResponse`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletResponse.html).

W przypadku serwletów opartych o protokół HTTP interfejsy te są rozszerzane przez [`HttpServletRequest`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) i [`HttpServletResponse`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html). Rozszerzone interfejsy zawierają metody specyficzne dla protokołu HTTP.

Zauważ, że piszę tu wyłącznie o interfejsach. Są to interfejsy określone przez specyfikację serwletów. Kontener serwletów, który implementuję tę specyfikację dostarcza także konkretnych implementacji. To właśnie kontener odpowiedzialny jest za tworzenie instancji klas, które implementują te interfejsy.

Z [poprzedniego artykułu opisującego serwlety]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %}) wiesz już z jakich elementów składa się adres URL. Klasy opakowujące żądanie pozwalają na pracę z poszczególnymi elementami adresu URL. Jedą z części tego adresu są parametry.

W artykule i przykładach używam bardzo prostego mechanizmu do generowania widoków. Nie jest to sposób "poprawny". To są jedynie przykłady, które mają wprowadzić Cię w “świat aplikacji webowych”. W kolejnych artykułach poznasz lepszą metodę na generowanie stron HTML.
{: .notice--warning}

## `HTTPServletRequest`

### Parametry URL

Jedną z części adresu URL są parametry. Są one dostępne po znaku `?`. Parametry zapisane są w formie klucz=wartość, z tym że jeden parametr może wystąpić wiele razy. Poszczególne pary klucz=wartość rozdzielone są znakami `&`.

W interfejsie `HttpServletRequest` istnieje kilka metod, które pozwalają na pracę z parametrami. Proszę spójrz na przykład poniżej.

```java
@WebServlet("/parameters")
public class ParametersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter responseWriter = resp.getWriter();
        responseWriter.write("<html><body>");
        for (Map.Entry<String, String[]> entry : req.getParameterMap().entrySet()) {
            responseWriter.write("<p>" + entry.getKey() + ": " + Arrays.toString(entry.getValue()) +"</p>");
        }
        responseWriter.write("</body></html>");
    }
}
```

W przykładzie tym widzisz serwlet, który w odpowiedzi wypisuje wszystkie parametry z adresu URL żądania. Poza metodą [`getParameterMap`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameterMap--) możesz użyć także kilku innych:
- [`getParameter()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameter-java.lang.String-)
- [`getParameterNames()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameterNames--)
- [`getParameterValues()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameterValues-java.lang.String-)

Po uruchomieniu aplikacji, która posiada taki serwlet i wpisaniu w przeglądarce adresu

    http://localhost:8080/02_serwlety/parameters?parameter1=value1&parameter2=value2&parameter1=value11

Powinna wyświetlić się strona zawierająca dwie linijki:

    parameter2: [value2]
    parameter1: [value1, value11]

#### Żądania POST a parametry

Powyżej opisałem sytuację, w której parametry przesyłane są jako fragment adresu URL żądania. Dzieje się tak w przypadku żądań typu GET. W przypadku wysyłania formularzy (zazwyczaj zapytania typu POST), parametry te przesyłane są w ciele żądania. Nie są one częścią adresu.

Mimo tego, że parametry przesyłane są w inny sposób możesz z nimi pracować używając tego samego zestawu metod.

{% include newsletter-srodek.md %}

### Adres URL

Obiekt opakowujący żądanie pozwala także na pracę z adresem URL, którego żądanie dotyczy. Zestaw metod pozwala na pobranie informacji na temat adresu żądania:
- [`getContextPath()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getContextPath--) zwraca fragment ścieżki, która jest “podstawą” wszystkich ścieżek obsługiwanych przez daną aplikację. W przypadku prostego instalowania aplikacji przy pomocy gradle będzie to nazwa pliku war,
- [`getServletPath()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getServletPath--) zwraca fragment ścieżki, która została użyta w konfiguracji serwletu,
- [`getRequestURL()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getRequestURL--) metoda zwraca adres URL żądania bez parametrów zawartych w adresie,
- [`getRequstURI()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getRequestURI--) zwraca adres URI (ang. _Uniform Resource Identifier_). Od aresu URL różni się on tym, że nie zawiera protokołu, serwera i portu.

Zakładając, że nasz sewlet obsługuje ścieżkę /path wówczas wywołanie powyższych metod po żądaniu

    http://localhost:8080/02_serwlety/path?xxx=yyy

Powinno zwrócić następujące wartości:
- `getContextPath() /02_serwlety`
- `getServletPath() /path`
- `getRequestURI() /02_serwlety/path`
- `getRequestURL() http://localhost:8080/02_serwlety/path`

Przykładowy serwlet, który używa tych metod możesz znaleźć na [samouczkowym githubie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/02_serwlety/src/main/java/pl/samouczekprogramisy/kursaplikacjewebowe/servlets/PathServlet.java).
## `HttpServletResponse`

Obiekt, implementujący ten interfejs także tworzony jest przez kontener serwletów. Służy on do przygotowania odpowiedzi na żądanie wysłane do serwera. W przypadku obiektu odpowiedzi musisz wiedzieć o następujących metodach
- [`getOutputStream()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletResponse.html#getOutputStream--) zwraca instancję [`ServletOutputStream`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletOutputStream.html), która służy do tworzenia odpowiedzi zawierającej dane binarne,
- [`getWriter()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletResponse.html#getWriter--) zwraca instancję `PrintWriter`, która służy do tworzenia odpowiedzi zawierającej tekst.


Ważne jest aby pamiętać, że w trakcie obsługi żądania możemy posługiwać się wyłącznie jedną z tych metod.
## Nagłówki

Specyfikacja protokołu HTTP definiuje tak zwane nagłówki. Nagłówki dołączane są zarówno do żądań jak i odpowiedzi. Nagłówki to nic innego jak pary klucz-wartość, które zapisane są w formacie `nazwa nagłówka: treść nagłówka`. Na przykład

    Content-Type: text/html; charset=utf-8
    Content-Length: 13358

Przeglądarki internetowe posiadają wbudowane “narzędzia developerskie”, które pozwalają na podejrzenie nagłówków. Jeśli chcesz dowiedzieć się więcej o tych narzędziach zachęcam do odwiedzenia strony dedykowanej dla Twojej przeglądarki
- [Firefox](https://developer.mozilla.org/en-US/docs/Tools)
- [Chrome](https://developer.chrome.com/devtools)
- [Opera](http://www.opera.com/dragonfly/)
- [Internet Explorer](https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide)

{% include figure image_path="/assets/images/2017/04/01_headers.jpg" caption="Narzędzia developerskie - nagłówki" %}

Obiekty `HttpServletResponse` i `HttpServletRequest` pozwalają na pracę z nagłówkami przy pomocy metod:

- [`setHeader()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html#setHeader-java.lang.String-java.lang.String-)
- [`addHeader()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html#addHeader-java.lang.String-java.lang.String-)

Pierwsza z nich ustawia wartość nagłówka, druga dodaje nową wartość nagłówka (i tworzy go jeśli wcześniej nie był ustawiony). W rzeczywistości nagłówek mający wiele wartości to dalej jedna para klucz-wartość. W tym przypadku wartość zawiera kilka elementów oddzielonych przecinkami.

Nagłówki możesz pobierać z obiektu żądania używając metod:

- [`getHeaderNames()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getHeaderNames--)
- [`getHeader()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html#getHeader-java.lang.String-)
- [`getHeaders()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getHeaders-java.lang.String-)

Poniższy serwlet używa tych metod aby ustawić kilka nagłówków. W odpowiedzi na żądanie tworzy stronę, która zawiera listę ustawionych nagłówków. Jak zwykle mocno zachęcam do eksperymentowania, sam zobacz jak taki serwlet działa.

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    PrintWriter responseWriter = resp.getWriter();
 
    responseWriter.write("<html><body>");
    Enumeration<String> headerNames = req.getHeaderNames();
    while (headerNames.hasMoreElements()) {
        String headerName = headerNames.nextElement();
        Enumeration<String> headerValues = req.getHeaders(headerName);
        while (headerValues.hasMoreElements()) {
            String headerValue = headerValues.nextElement();
            responseWriter.write("<p>" + headerName + ": " + headerValue + "</p>");
        }
    }
 
    resp.addHeader("my-custom-header", "value1");
    resp.addHeader("my-custom-header", "value2");
    resp.setIntHeader("my-custom-int-header", 123);
 
    responseWriter.write("</body></html>");
}
```

### Zastosowanie nagłówków

Nagłówki jako część protokołu HTTP pełnią bardzo istotną rolę. Dla przykładu poniżej pokazuję zestaw nagłówków wysyłanych wraz z każdą odpowiedzią dla adresu www.samouczekprogramisty.pl:

    $ curl -I www.samouczekprogramisty.pl
    HTTP/1.1 200 OK
    Set-Cookie: PHPSESSID=xxxxxxxxxxxxxxxxxxxxxx; path=/
    Expires: Thu, 19 Nov 1981 08:52:00 GMT
    Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0
    Pragma: no-cache
    Content-Type: text/html; charset=UTF-8
    Link: <http://www.samouczekprogramisty.pl/wp-json/>; rel="https://api.w.org/"
    Date: Sun, 02 Apr 2017 10:46:08 GMT
    Accept-Ranges: bytes
    Server: LiteSpeed
    Connection: Keep-Alive

Użyłem do tego programu `curl`, który pozwala na wysyłanie żądań HTTP z linii poleceń. Fragment powyżej powoduje wysłanie żądania typu HEAD, które zwraca wyłącznie nagłówki (bez właściwej zawartości strony). Przykładowe zastosowanie nagłówków:
- Pozwalają na ustawianie ciasteczek (przeczytasz o nich w kolejnym akapicie) (`Set-Cookie`),
- Pozwalają na określenie zawartości strony. To dzięki nim przeglądarka wie jak interpretować odpowiedź, którą dostanie. To nagłówek określa czy w odpowiedzi znajduje się plik HTML (`Content-Type: text/html; charset=UTF-8`). Czy może są dane binarne reprezentujące obrazek do wyświetlenia (`Content-Type: image/jpeg`),
- Mogą przyspieszyć ładowanie strony w przeglądarce. Jeśli odwiedziłeś już jakąś stronę to przeglądarka mogła zapisać część danych, które wyświetliła (w tym część nagłówków). Następnym razem nie wyśle żądania typu GET (aby pobrać całą zawartość) a jedynie HEAD (aby pobrać nagłówki). Po sprawdzeniu nagłówków stwierdzi, że dane się nie zmieniły i wyświetli poprzednio zapamiętaną zawartość (`Cache-Control: public, max-age=63115200`, `Last-Modified: Thu, 16 Mar 2017 17:12:14 GMT`).
- Takie sprawdzenie może odbyć się też w inny sposób. Przeglądarka może wysłać zapytanie typu GET dołączając odpowiednie nagłówki. Później żądanie z nagłówkami interpretowane jest przez serwer. Jeśli serwer stwierdzi, że przeglądarka ma aktualną treść (potwierdza to nagłówek), wówczas wysyła odpowiedź informującą przeglądarkę, że jej kopia treści jest najnowsza. W takim przypadku zamiast przesyłać przez sieć obrazek o wielkości 400kB wysyła odpowiedź, która ma dużo mniej danych - kilka kilobajtów (`ETag: "9db5f14aeaa00872"`,
- Nagłówki to metadane (dane o danych). Zdarza się, że są wykorzystywane do przesyłania dodatkowych informacji na temat danego żądania/odpowiedzi.

Mimo tego, że nagłówki są powszechnie stosowane w codziennej pracy z aplikacjami webowymi (szczególnie na początku) nie są one "kluczowe". Większość z nich ustawiają za nas biblioteki zewnętrzne. Niemniej jednak dobrze jest wiedzieć o tym, że istnieją i do czego służą.

## Ciasteczka

Ciasteczka to mechanizm opisany w specyfikacji protokołu HTTP. W uproszczeniu można powiedzieć, że ciasteczka to informacje, które dołączane są do żądania i mogą być ustawiane w odpowiedzi. Ciasteczka połączone są z adresem, pod który wysyłane jest żądanie. Przeglądarka internetowa wysyłając żądanie pod adres www.samouczekprogramisty.pl wyszukuje jakie ciasteczka ma zapisane dla tej domeny i dołącza je automatycznie do każdego żądania.

{% include figure image_path="/assets/images/2017/04/01_ciasteczka-diagram.jpeg" caption="Ciasteczka - diagram" %}

Po stronie serwera, w odpowiedzi można ustawiać ciasteczka. Można to robić przy pomocy nagłówka `Set-Cookie`. Z racji tego, że jest to bardzo popularny mechanizm istnieje osobny zestaw metod, które pomagają pracować z ciasteczkami:

- [`addCookie()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html#addCookie-javax.servlet.http.Cookie-)
- [`getCookies()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getCookies--)

Samo ciasteczko reprezentowane jest przez klasę [`Cookie`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/Cookie.html). Podstawowymi atrybutami ciasteczka jest jego nazwa i wartość.

Dodatkowo możesz ustawić też inne atrybuty, takie jak czas życia ciasteczka. Jeśli jest on ustawiony, wówczas przeglądarka dołącza ciasteczka do żądań tak długo jak są one “ważne”.

Przykładowy serwlet poniżej w odpowiedzi generuje stronę, która wyświetla wszystkie dostępne ciasteczka. Ustawia też jedno ciasteczko o nazwie custom-cookie, jego czas życia ustawiony jest na 10 sekund.

```java
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    PrintWriter responseWriter = resp.getWriter();
 
    responseWriter.write("<html><body>");
    for (Cookie cookie : req.getCookies()) {
        responseWriter.write("<p>" + cookie.getName() + " " + cookie.getValue() + "</p>");
    }
 
    Cookie cookie = new Cookie("custom-cookie", "bum bum cyk cyk");
    cookie.setMaxAge(10);
    resp.addCookie(cookie);
 
    responseWriter.write("</body></html>");
}
```

Przy drugim otworzeniu strony generowanej przez ten serwlet[^czas] zobaczysz ciasteczko custom-cookie

[^czas]: Jeśli zrobisz to szybciej niż 10 sekund po pierwszym wywołaniu.

Wcześniej opisane narzędzia developerskie dostępne w przeglądarkach internetowych pozwalają na podejrzenie zawartości ciasteczek.

{% include figure image_path="/assets/images/2017/04/01_cookies.png" caption="Narzędzia developerskie - ciasteczka" %}

### Zastosowanie ciasteczek

Jak wiesz z poprzedniego artykułu protokół HTTP jest bezstanowy. Ciasteczka pomagają obejść tę właściwość. Bardzo często ciasteczka wykorzystywane są do zapisania informacji czy użytkownik jest zalogowany w aplikacji. Aplikacja sprawdza czy takie ciasteczko istnieje, jeśli tak udostępnia użytkownikowi jakieś dane. Jeśli ciasteczka brakuje wówczas przekierowuje go na stronę logowania.

Po zalogowaniu aplikacja ustawia ciasteczko, które następnie dołączane jest do kolejnych żądań automatycznie.

Użytkownik ma możliwość ustawienia przeglądarki internetowej w ten sposób aby nie zapamiętywała ciasteczek. Nie jest to popularne, ale warto wiedzieć, że jest taka możliwość.

Podobnie jak w przypadku nagłówków - w codziennej pracy z aplikacjami webowymi często nie używa się ciasteczek bezpośrednio. Dzieje się to niejako "pod spodem" - zewnętrzne biblioteki wykorzystują ten mechanizm.

## Sesja

Można powiedzieć, że sesja to połączenie kilku żądań/odpowiedzi w jedną całość. Dzięki temu aplikacja webowa może powiązać te żądania z jednym użytkownikiem. Sesje najczęściej zaimplementowane są przy pomocy ciasteczek. Specyfikacja serwletów określa nawet domyślną nazwę takiego ciasteczka - jest to `JSESSIONID`.

Innym mechanizmem, na którym może być oparta sesja jest przepisywanie adresu URL (ang. _URL rewriting_). Polega ono na dołączaniu identyfikatora sesji do adresu. W takim przypadku adres może wyglądać następująco `http://www.samouczekprogramisty.pl/kurs-programowania-java;jsessionid=1234`. To kontener serwletów decyduje o metodzie, która powinna być użyta do “podtrzymywania” sesji.

Podobnie jak w przypadku ciasteczek sesja ma swój dedykowany obiekt. Po stronie serwera sesja reprezentowana jest przez [`HttpSession`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html).

### Czas trwania sesji

Sesja nie jest trzymana wiecznie. To jak długo powinna być utrzymywana przez kontener serwletów określone jest przez parametr metody [`setMaxInactiveInterval`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html#setMaxInactiveInterval-int-). Określa on w sekundach jak długo pomiędzy żądaniami klienta sesjsa powinna być utrzymywana.

### Atrybuty sesji

Sesję można porównać do mapy, w której przechowujemy pary klucz-wartość. Są to atrybuty sesji. Dzięki nim mamy możliwość przekazywania informacji wewnątrz aplikacji webowej pomiędzy żądaniami klienta. Poniższy zestaw metod pozwala na pracę z atrybutami sesji:
- [`getAttributeNames()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html#getAttributeNames--)
- [`getAttribute()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html#getAttribute-java.lang.String-)
- [`removeAttribute()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html#removeAttribute-java.lang.String-)
- [`setAttribute()`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSession.html#setAttribute-java.lang.String-java.lang.Object-)

Wartościami atrybutów są obiekty, jednak musisz pamiętać o tym aby nie były one “duże”. Atrybuty sesji powinny być także serializowalne. Jeśli nie miałeś do czynienia z serializacją zapraszam do artykułu poświęconemu [serializacji w języku Java]({% post_url 2016-09-02-serializacja-w-jezyku-java %}).

### Mechanizm przechowywania sesji

Sesje mogą być przechowywane w pamięci kontenera serwletów. Nie jest to jedyna metoda ich przechowywania. Naiwny mechanizm może być oparty o ciasteczka, w takim przypadku wszystkie atrybuty sesji byłyby ciasteczkami.

Kontener serwletów do zapisywania sesji może użyć standardowych plików. Sesja może być także zapisana w różnych bazach danych. To w jaki sposób będzie to realizowane zależy od konfiguracji kontenera serwletów. W podstawowych przypadkach nie musisz się przejmować tą konfiguracją.

```java
@WebServlet("/session")
public class SessionServlet extends HttpServlet {
 
    public static final String VISIT_COUNTER_ATTR = "visitCounter";
 
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter responseWriter = resp.getWriter();
 
        responseWriter.write("<html><body>");
 
        HttpSession session = req.getSession();
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            responseWriter.write("<p>" + attributeName + ": " + session.getAttribute(attributeName) + "</p>");
        }
        responseWriter.write("</body></html>");
        increaseVisitCounter(session);
    }
 
    private void increaseVisitCounter(HttpSession session) {
        Object counter = session.getAttribute(VISIT_COUNTER_ATTR);
        Integer numberOfVisits;
        if (counter != null) {
            numberOfVisits = (Integer) counter + 1;
        }
        else {
            numberOfVisits = 1;
        }
        session.setAttribute(VISIT_COUNTER_ATTR, numberOfVisits);
    }
}
```

## Ćwiczenie do wykonania

Napisz serwlet, który pobierze wartość wszystkich parametrów przekazanych w adresie. Pobierze wszystkie parametry, których wartości są liczbami całkowitymi, następnie sumę tych parametrów wyświetli na ekranie. Serwlet ten powinien dodatkowo w sesji zapamiętać sumaryczną wartość wszystkich takich operacji. Ta całkowita suma także powinna być wyświetlona

Na przykład, pierwsze żądanie pod adres `/serwlet?parametr=123&inny-parametr=abc&test=-3` powinno wyświetlić stronę:

    requestSum: 120
    totalSum: 120

Kolejne żądanie pod adres `/serwlet?parametr=336` powinno wyświetlić stornę

    requestSum: 336
    totalSum: 456

W przypadku jakichkolwiek problemów z wykonaniem ćwiczenia możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/02_serwlety/src/main/java/pl/samouczekprogramisy/kursaplikacjewebowe/servlets/exercise/ExerciseServlet.java).

## Dodatkowe materiały do nauki

- [Artykuł na wikipedi na temat ciasteczek](https://en.wikipedia.org/wiki/HTTP_cookie),
- [Lista standardowych nagłówków HTTP](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields),
- [Specyfikacja serwletów](http://download.oracle.com/otndocs/jcp/servlet-3_1-fr-eval-spec/index.html),
- [Specyfikacja protokołu HTTP/1.1](http://www.ietf.org/rfc/rfc2616.txt),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/02_serwlety/src/main/java/pl/samouczekprogramisy/kursaplikacjewebowe/servlets).

## Podsumowanie

Po lekturze tego artykułu znasz już zestaw podstawowych klocków, z których buduje się aplikacje webowe. Wiesz już czym są parametry adresu URL i jak z nimi pracować. Znasz mechanizm nagłówków. Potrafisz powiedzieć czym jest ciasteczko i sesja. Po wykonaniu ćwiczenia znasz te zagadnienia także od praktycznej strony. Innymi słowy kawał wiedzy ;).

Na koniec mam do Ciebie prośbę. Zależy mi na dotarciu do jak największego grona Samouków takich jak Ty. Podziel się proszę linkiem do artykułu ze swoimi znajomymi. Mam nadzieję, że im także spodoba się artykuł.

Jeśli nie chcesz ominąć kolejnych artykułów dopisz się do samouczkowego newslettera i polub stronę na facebooku. Do następnego razu!
