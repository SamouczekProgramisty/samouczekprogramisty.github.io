---
title: Filtry w aplikacjach webowych
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- DSP2017
- Kurs aplikacji webowych
permalink: /filtry-w-aplikacjach-webowych/
header:
    teaser: /assets/images/2017/04/15_filtry_artykul.jpeg
    overlay_image: /assets/images/2017/04/15_filtry_artykul.jpeg
    caption: "[&copy; infobunny](https://www.flickr.com/photos/infobunny/5458629578/sizes/l)"
excerpt: W artykule przeczytasz o komponentach używanych w praktycznie każdej aplikacji webowej. Mowa tu o filtrach. Wysokopoziomowe biblioteki pomagające tworzyć aplikacje webowe (takie jest Spring MVC) bazują na tych podstawowych mechanizmach. Dowiesz się czym jest filtr i do czego jest używany. Na końcu będziesz mógł wykorzystać zdobytą wiedzę wykonując proste ćwiczenia. Zapraszam do lektury.
disqus_page_identifier: 841 http://www.samouczekprogramisty.pl/?p=841
---

{% capture notice %}
Artykuł ten zakłada, że wiesz czym są serwlety i adnotacje. Pownieneś potrafić już napisać serwlet i używać adnotacji. Powinieneś wiedzieć czym są parametry URL i jak z nimi pracować. Jeśli chcesz uzupełnić wiedzę z tego zakresu zapraszam do artykułów:

- [serwlety w aplikacjach internetowych]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %}),
- [parametry URL, ciasteczka, nagłówki i sesje]({% post_url 2017-04-01-naglowki-sesje-i-ciasteczka %}),
- [adnotacje w języku Java]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}).
{% endcapture %}

<div class="notice--info">
  {{ notice | markdownify }}
</div>

## Czym jest filtr

Filtry to nic innego jak klasy, które są wywoływane przed uruchomieniem właściwego serwletu. Po wykonaniu serwletu odpowiedź wraca przez ten sam filtr do klienta, który wysłał żądanie. Przed serwletem może być wywołanych wiele filtrów.

Poniższy rysunek pokazuje zapytanie od klienta, które przechodzi przez dwa filtry. Następnie uruchamiany jest serwlet. Przed przekazaniem odpowiedzi wracamy do tych samych filtrów w odwrotnej kolejności.

{% include figure image_path="/assets/images/2017/04/15_filter_chain.jpeg" caption="Łańcuch wywołania filtrów." %}

Filtry oznacza się adnotacją [`@WebFilter`]({{ site.doclinks.javax.servlet.annotation.WebFilter }})[^webfilter]. Podobnie jak wszystkie inne elementy specyfikacji serwletów także filtry mają swój cykl życia.

[^webfilter]: Do tej pory nie wspomniałem Ci jeszcze o pliku `web.xml`, w którym także można filtry konfigurować. Aby niepotrzebnie nie komplikować plik ten opiszę w [osobnym artykule]({% post_url 2017-04-27-deskryptor-wdrozenia-w-aplikacjach-webowych %}).

## Cykl życia filtrów

Każdy z filtrów ma swój cykl życia. Podobnie jak w serwletach mamy tu metody `init` i `destroy`. Właściwa praca serwletu odbywa się wewnątrz metody `doFilter`.
- [`init`]({{ site.doclinks.javax.servlet.Filter }}#init-javax.servlet.FilterConfig-) – metoda odpowiedzialna za inicjalizację serwletu. Musi się powieść aby kontener serwletów używał tego filtra,
- [`doFilter`]({{ site.doclinks.javax.servlet.Filter }}#doFilter-javax.servlet.ServletRequest-javax.servlet.ServletResponse-javax.servlet.FilterChain-) – tu odbywa się właściwa praca filtra. Metoda ta wywołana jest przed przekazaniem żądania do klasy serwletu,
- [`destroy`]({{ site.doclinks.javax.servlet.Filter }}#destroy--) – metoda, w które filtr ma szansę “posprzątać” po sobie :)

{% include newsletter-srodek.md %}

## Mapowanie filtrów

Adnotacja `@WebFilter` posiada kilka elementów. Opiszę te, które pozwalają na przypisywanie filtrów do poszczególnych serwletów/zasobów:
- `urlPatterns` – lista szablonów adresów URL do których filtr powinien być zaaplikowany,
- `servletNames` – lista nazw serwletów. Każdy serwlet może mieć nazwę, którą możesz ustawić za pomocą elementu name adnotacji `@WebServlet`,
- `value` – domyślny element, stosowany zamiennie z `urlPatterns`.

Szablony adresów URL pozwalają na mapowanie filtrów do adresów URL. Wewnątrz tych szablonów możesz używać znaku `*`, który pozwala na dopasowanie większej liczby adresów URL. Spójrz na kilka przykładów:
- `/some/url/address` – szablon pasuje tylko do jednego adresu URL - `/some/url/pattern`,
- `/some/other/resource.*` – szablon pasuje do wielu adresów URL różniących się rozszerzeniami. Na przykład `/some/other/resource.html` czy `/some/other/resource.jpeg`,
- `/some/*/address` – szablon pasuje do wielu adresów URL. Na przykład `/some/url/address` czy `/some/picture/addresss`,
- `*` – szablon pasuje do wszystkich adresów URL. Jeśli stworzysz filtr, który będzie miał taki szablon będzie on aplikowany do wszystkich zapytań.

Kilka przykładów z użyciem adnotacji:
- `@WebFilter("/chainingServlet")` – filtr będzie zaaplikowany wyłącznie do żądań dotyczących adresu `/chainingServlet`,
- `@WebFilter(urlPatterns = "/chainingServlet", servletNames = "someRandomServletName")` – filtr będzie zaaplikowany do żądań dotyczących adresu `/chainingServlet` i żądań obsługiwanych przez serwlet o nazwie someRandomServletName
- `@WebFilter(urlPatterns = {"/some/*/thing", "/other/*/thing"})` – filtr będzie zaaplikowany do żądań dotyczących wielu adresów pasujących do jednego z wzorców.

## Łańcuch filtrów
Na diagramie pokazanym wyżej widziałeś dwa filtry. Filtrów uruchomionych przed właściwym serwletem może być wiele. Tworzą one tak zwany łańcuch filtrów (ang. _filter chain_). Łańcuch ten reprezentowany jest przez instancję klasy implementującej interfejs [`FilterChain`]({{ site.doclinks.javax.servlet.FilterChain }}). Instancja ta przekazana jest jako parametr do metody `doFilter` wewnątrz filtra.

Interfejs ten zawiera wyłącznie jedną metodę [`doFilter`]({{ site.doclinks.javax.servlet.FilterChain }}#doFilter-javax.servlet.ServletRequest-javax.servlet.ServletResponse-), która wykonuje kolejny filtr w łańcuchu. Jeśli filtr był ostatnim spowoduje to wywołanie właściwego serwletu.

Pociąga to za sobą ważną konsekwencję. Jeśli wewnątrz filtra nie wywołasz tej metody właściwe żądanie nigdy nie dotrze do serwletu.

## Przykłady użycia filtrów

Zacznijmy od definicji prostego serwletu. Serwlet w odpowiedzi wyświetla wszystkie atrybuty żądania. Jeśli żaden atrybut nie jest ustawiony, w odpowiedzi wysłana zostanie pusta strona HTML.

```java
@WebServlet(urlPatterns = "/simpleServlet", name = "simpleServletName")
public class SimpleServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter responseWriter = resp.getWriter();
 
        responseWriter.write("<html><body>");
        Enumeration<String> attributeNames = req.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = req.getAttribute(attributeName);
            responseWriter.write("<p>" + attributeName + ": " + attributeValue + "</p>");
        }
        responseWriter.write("</html></body>");
    }
}
```

Następnie filtr, który dodaje jeden atrybut wewnątrz metody `doFilter`:

```java
@WebFilter(servletNames = "simpleServletName")
public class SimpleFilter implements Filter {
 
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
 
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println("before");
        request.setAttribute("simpleServletAttribute", "simpleServlet");
        chain.doFilter(request, response);
        System.out.println("after");
    }
 
    @Override
    public void destroy() {
    }
}
```

Po uruchomieniu takiej aplikacji i wysłaniu żądania na adres `/simpleServlet` powinieneś zobaczyć jeden atrybut dodany prez filtr.

## Kolejność wykonywania filtrów

Wiesz już, że do jednego zasobu/serwletu można aplikować wiele filtrów. Bardzo często kolejność ich wykonania jest bardzo istotna. Na przykład nie ma potrzeby kompresowania odpowiedzi jeśli użytkownik nie ma prawa do wykonania danego żądania. Równie ważne jest logowanie wszystkich żądań, niezależnie od tego czy użytkownik ma do nich prawo czy nie.

Mając zatem trzy filtry:

- loggingFilter – loguje podstawowe informacje o żądaniu,
- authenticationFilter – weryfikuje tożsamość użytkownika,
- compressionFilter – kompresuje odpowiedź.

Muszą one być uruchomione w dokładnej tej kolejności: loggingFilter, authenticationFilter, compressionFilter, aby aplikacja działa poprawnie.

Tutaj mam dla Ciebie smutną wiadomość. Używając adnotacji, bez pliku `web.xml` (nazywanego deskryptorem wdrożenia) nie mamy nad tym kontroli. Specyfikacja serwletów nie definiuje kolejności filtrów definiowanych wyłącznie przy pomocy adnotacji `@WebFilter`. Co za tym idzie kolejność ta może być różna w różnych implementacjach i nie powinieneś na niej polegać.

Sprawa wygląda zupełnie inaczej w przypadku użycia pliku `web.xml`. W tym przypadku kolejność jest dobrze zedfiniowana:

- wszystkie filtry pasujące do danego żądania używające `urlPattern` według kolejności w pliku `web.xml`,
- wszystkie filtry pasujące do danego żądania używające `servletName` według kolejności w pliku `web.xml`.

Na tym etapie ważne jest żebyś wiedział o tym ograniczaniu. Sam plik `web.xml` opiszę w osobnym artykule, wtedy też dowiesz się jak dokładnie określać kolejność wykonania filtrów.

## Zastosowanie filtrów

Teraz jak już wiesz jak wyglądają filtry musisz dowiedzieć się o ich zastosowaniu. Filtry pozwalają na uniknięcie duplikacji kodu. Najczęściej to właśnie dzięki filtrom realizowane są następujące funkcjonalności:
- uwierzytelnianie – sprawdzenie czy użytkownik ma prawo do uzyskania odpowiedzi na dane żądanie. Innymi słowy, sprawdzenie czy jest zalogowany,
- logowanie, audyt – tworzenie logów aplikacji webowej, część informacji (na przykład URL żądania) można logować już na etapie filtrów,
- kompresja – filtry kompresują odpowiedź. Dzięki zmniejszonej objętości przeglądarka szybciej dostaje odpowiedź,
- cache – czasami przez uruchomieniem serwletu można stwierdzić, że odpowiedź się nie zmieniła.


Poplularny Spring MVC także używa filtrów. Kilka z nich znajduje się w osobnym [pakiecie](https://github.com/spring-projects/spring-framework/tree/master/spring-web/src/main/java/org/springframework/web/filter). Na przykład:
- [`CharacterEncodingFilter`](https://github.com/spring-projects/spring-framework/blob/master/spring-web/src/main/java/org/springframework/web/filter/CharacterEncodingFilter.java) ustawia kodowanie znaków użyte w żadaniu, odpowiedzi[^kodowanie],
- [`CommonsRequestLoggingFilter`](https://github.com/spring-projects/spring-framework/blob/master/spring-web/src/main/java/org/springframework/web/filter/CommonsRequestLoggingFilter.java) logowanie, filtr loguje informacje o przychodzących żądaniach.

[^kodowanie]: Upraszczając, kodowanie znaków to sposób w jaki reprezentujemy tekst. To dzięki niemu wiadomo jak interpretować polskie znaki. Jeśli używa się błędnego kodowania mogą pojawić się "krzaki".

## Ćwiczenia

Na koniec czekają na Ciebie dwa ćwiczenia, w których przećwiczysz wiedzę dotyczącą filtrów w praktyce.
1. Napisz serwlet, który wyświetli wszystkie atrybuty żądania. Serwlet powinien być poprzedzony dwoma filtrami, każdy z nich powinien ustawić co najmniej jeden atrybut żądania,
2. Napisz filtr, który zablokuje wykonanie serwletu jeśli w adresie URL występuje jakikolwiek parametr o wartości “blokuj”.

Jak zwykle, pytaj jeśli ukniesz na którymś etapie. W ostateczności możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/03_filtry/src/main/java/pl/samouczekprogramisty/kursaplikacjewebowe/filters). Zachęcam jednak do samodzielnego rozwiązania ćwiczeń, wtedy nauczysz się najwięcej.

## Podsumowanie

Filtry w aplikacjach webowych pełnią bardzo ważną rolę. Dzisiaj udało Ci się tę rolę poznać. Wiesz czym jest filtr, wiesz także jak używać łańcuch filtrów. Poznałeś przykłady filtrów w Spring MVC. Przykładowe ćwiczenia pozwoliły Ci utrwalić materiał. Innymi słowy poznałeś kolejny klocek niezbędny do budowy aplikacji webowych. Gratulacje! Pochwal się o tym znajomym przesyłając im link do tego artykułu ;).

Jeśli nie chcesz pominąć kolejnych artykułów na blogu proszę dopisz się do samouczkowego newslettera i polub stronę na facebooku. Do następnego razu!
