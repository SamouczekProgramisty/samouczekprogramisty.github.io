---
title: Kontekst serwletu i obiekty nasłuchujące w aplikacjach webowych
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- DSP2017
- Kurs aplikacji webowych
permalink: /kontekst-serwletu-i-obiekty-nasluchujace-w-aplikacjach-webowych/
header:
    teaser: /assets/images/2017/04/21_listener_kontekst_servlet_context_artykul.jpeg
    overlay_image: /assets/images/2017/04/21_listener_kontekst_servlet_context_artykul.jpeg
    caption: "[&copy; fkhucke](https://www.flickr.com/photos/fkhuckel/33244430220/sizes/l)"
excerpt: W artykule przeczytasz o kolejnych podstawowych elementach, niezbędnych do budowania aplikacji webowych w Javie. Dowiedz się czym jest kontekst serwletu (ang. _servlet context_) i jak możesz go używać. Poznasz cykl życia aplikacji webowej i dowiesz się o zdarzeniach (ang. _events_), na które możesz reagować. Całość przećwiczysz rozwiązując zadanie znajdujące się na końcu artykułu.
disqus_page_identifier: 863 http://www.samouczekprogramisty.pl/?p=863
---

## `ServletContext`

Obiekt implementujący [`ServletContext`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html) tworzony jest przez kontener serwletów. Istnieje tylko jeden taki obiekt dla każdej aplikacji webowej[^kilka_jvm]. Służy on głównie do współdzielenia informacji w ramach aplikacji internetowej.

[^kilka_jvm]: Właściwie to, istnieje tylko jeden taki obiekt dla każdej wirtualnej maszyny Java. Jeśli twoja aplikacja webowa jest rozproszona wówczas obiektów implementujących ten interfejs jest tyle, ile instancji JVM.

Czytając poprzednie artykuły z serii:

- [serwlety w aplikacjach webowych]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %}),
- [nagłówki, sesje i ciasteczka w aplikacjach webowych]({% post_url 2017-04-01-naglowki-sesje-i-ciasteczka %}),
- [filtry w aplikacjach webowych]({% post_url 2017-04-15-filtry-w-aplikacjach-webowych %}),

poznałeś inne konteksty/zakresy. Na przykład kontekst zapytania i kontekst sesji HTTP. W każdym z tych kontekstów mogłeś ustawić zestaw atrybutów. Atrybuty te “żyły” tak długo, jak aktywny był dany kontekst.

Podobnie jest tutaj. Z tym, że kontekst serwletu jest tylko jeden i aktywny jest przez cały czas “życia” aplikacji webowej. Podobnie jak w poprzednich przypadkach możesz w nim ustawiać atrybuty.

### Atrybuty kontekstu

Podobnie jak `Servlet` czy `HttpRequest` mają atrybuty, tak samo jest z `ServletContext`. Możesz ustawiać dowolne atrybuty w kontekście. Dzięki temu, że istnieje jeden kontekst dla całej aplikacji możesz w ten sposób przekazywać informacje pomiędzy serwletami.

Do pracy z atrybutami przechowywanymi w obiekcie implementującym `ServletContext` służą metody:

- [`setAttribute`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html#setAttribute-java.lang.String-java.lang.Object-),
- [`getAttribute`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html#getAttribute-java.lang.String-),
- [`getAttributeNames`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html#getAttributeNames--),
- [`removeAttribute`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html#removeAttribute-java.lang.String-).

Instancję implementującą ten interfejs możemy uzyskać wywołując metodę [`getServletContext`]({{ site.doclinks.javax.servlet.ServletRequest }}#getServletContext--) znajdującą się w interfejsie [`ServletRequest`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html).

Dzięki dostępowi do kontekstu serwletów możesz przekazywać atrybuty pomiędzy poszczególnymi serwletami. Przykładowy serwlet poniżej wyświetla wszystkie atrybuty kontekstu ustawiając wcześniej wartość jednego z nich.

```java
@WebServlet("/servlet1")
public class Servlet1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter writer = resp.getWriter();
        writer.write("<html><body>");

        ServletContext context = req.getServletContext();
        context.setAttribute("pl.samouczekprogramisty.servlet1", "servlet1 attribute");

        Enumeration<String> attributeNames = context.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            writer.write("<p>" + attributeName + ": " + context.getAttribute(attributeName) + "<p>");
        }
        writer.write("</body></html>");
    }
}
```

Spróbuj uruchomić aplikację, która ma taki serwlet. Wpisując adres serwletu w przeglądarce zobaczysz wszystkie atrybuty kontekstu. Poza atrybutem ustawionym przez serwlet zobaczysz także inne, część z nich jest ustawiona przez sam kontener serwletów.

Dokumentacja zaleca aby nazwy atrybutów były zapisane w podobnej konwencji jak pakiety. Innymi słowy nazwy powinny wyglądać jak “odwrócone adresy www”, na przykład `pl.samouczekprogramisty.servelet1`.

### Dynamiczna konfiguracja

Ponadto twórcy bibliotek dzięki dostępowi do obiektu `ServletContext` mogą dynamicznie tworzyć serwlety, filtry czy obiekty nasłuchujące zdarzenia (ang. _listener_). Funkcjonalność ta raczej nie jest wykorzystywana w innych przypadkach.

{% include newsletter-srodek.md %}

## Obiekty nasłuchujące

Szczerze mówiąc miałem tu problem z tłumaczeniem :). Chodzi tu o obiekty, które potocznie nazywamy "listenerami". Obiekty nasłuchujące nie są specyficzne dla aplikacji webowych. Koncept tego typu używany jest także w innych miejscach. Jest to jeden z szeroko znanych wzorców projektowych. Wzorzec ten nazywany jest obserwatorem (ang. _observer_).

Kontener serwletów ma informację o wystąpieniu pewnych zdarzeń. Ty jako programista możesz chcieć być informowany o tych zdarzeniach. Na przykład chcesz dostać informację kiedy obiekt `ServletContext` zostanie utworzony. Aby to zrobić tworzysz własną instancję obiektu nasłuchującego, który implementuje interfejs [`ServletContextListener`](http://docs.oracle.com/javaee/7/api/javax/servlet/ServletContextListener.html). Dodatkowo tę implementację oznaczasz adnotacją [`@WebListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/annotation/WebListener.html). Dzięki temu kontener serwletów wie o twojej klasie. Wie, że musi ją powiadomić o takim zdarzeniu.

Poniższy diagram pokazuje jak te komponenty układają się w całość:

{% include figure image_path="/assets/images/2017/04/21_wzorzec_observer.jpeg" caption="Wzorzec obserwator." %}

Kontener przechowuje listę obiektów implementujących interfejs `ServletContextListener`. Jedną z implementacji może być klasa `MyOwnImplementation` pokazana na diagramie. Następnie w każdym momencie kiedy wystąpi zdarzenie, którym interesuje się nasza implementacja kontener uruchamia odpowiednie metody. Metody te są zdefiniowane w iterfejsie `ServletContextListener`.

Zdarzenia dotyczące kontekstu nie są jedynymi. W trakcie działania aplikacji webowej występuje wiele zdarzeń. Zdarzenia te związane są z cyklem życia poszczególnych elementów aplikacji. Na przykład możesz być poinformowany o tym, że została utworzona sesja HTTP, albo o tym, że jakieś zapytanie zostało wysłane do aplikacji.

Poniżej znajduje się lista kilka przykładowych interfejsów obiektów nasłuchujących:

- [`ServletContextListener`](http://docs.oracle.com/javaee/7/api/javax/servlet/ServletContextListener.html),
- [`ServletContextAttributeListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContextAttributeListener.html),
- [`ServletRequestListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequestListener.html),
- [`ServletRequestAttributeListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequestAttributeListener.html),
- [`HttpSessionListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSessionListener.html),
- [`HttpSessionAttributeListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpSessionAttributeListener.html).

Na przykład, obiekt implementujący interfejs `ServletContextAttributeListener` zostanie poinformowany o wszystkich operacjach na atrybutach kontekstu serwletu.

Aby kontener serwletów wiedział o obiekcie nasłuchującym trzeba go odpowiednio skonfigurować. Każdy z obiektów nasłuchujących powinien być dekorowany wspomnianą adnotacją `@WebListener`[^listener].

[^listener]: Może też być zdefiniowany w pliku `web.xml`, `web-fragment.xml` czy dodany dynamicznie przez metody dostępne w `ServletContext`, jednak te sposoby wykraczają poza zakres tego artykułu.

Poniżej znajduje się przykładowa implementacja interfejsu `ServletContextListener`, która dodaje dodatkowy atrybut w momencie utworzenia kontekstu serwletu:

```java
@WebListener
public class MyServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("pl.samouczekprogramisty.listener", "listener value");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // do nothing
    }
}
```

### Praktyczne wykorzystanie

W poprzednich artykułach opisujących elementy specyfikacji serwletów odwoływałem się do Spring MVC. Nie inaczej będzie i tym razem. Przykładowym obiektem nasłuchującym zaimplementowanym w Spring MVC może być [`WebAppRootListener`](https://github.com/spring-projects/spring-framework/blob/v4.3.8.RELEASE/spring-web/src/main/java/org/springframework/web/util/WebAppRootListener.java). Obiekt ten reaguje na utworzenie/zniszczenie kontekstu serwletów. Zachęcam Cię do przeszukania kodu źródłowego Spring MVC pod kątem innych obiektów, które reagują na zdarzenia w aplikacji webowej.

Implementacja odpowiednich interfejsów, które pozwalają reagować na zdarzenia umożliwia konfigurację Spring MVC. W praktyce “magiczny Spring” nie robi nic innego jak wykorzystuje elementy specyfikacji serwletów.

## Ćwiczenie do wykonania

Napisz serwlet, który wyświetli wszystkie atrybuty kontekstu. Dodatkowo niech serwlet ten dodaje parametry przekazane w adresie URL jako atrybuty kontekstu. Na przykład żądanie na adres `.../serwlet?pl.parametr=xxx` powinno utworzyć atrybut kontekstu o nazwie `pl.parametr` z wartością `xxx`.

Uzupełnij tę aplikację o implementację interfejsu `ServletContextAttributeListener`. Niech twój słuchacz w momencie dodawania nowego atrybuty kontekstu doda kolejny atrybut z datą jego dodania. Na przykład jeśli dodamy atrybut o nazwie `pl.parametr` to automatycznie powinien zostać dodany atrybut `pl.parametr.when`. Wartością nowego atrybutu powinna być data dodania atrybutu.

Pamiętaj żeby zabepieczyć się przed "nieskończoną pętlą" – twój obiekt zostanie także powiadomiony o dodaniu atrybutu `pl.parametr.when` i wtedy spróbuje dodać kolejny `pl.pamrater.when.when`, o którym także byłby powiadomiony.

Jeśli będziesz miał problem z rozwiązaniem zadania możesz rzucić okiem na [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/04_kontekst/src/main/java/pl/samouczekprogramisty/kursaplikacjewebowe/exercise). Jak zwykle jednak zachęcam do samodzielego rozwiązania zadania. Wtedy nauczysz się najwięcej.

## Dodatkowe materiały do nauki

- [Specyfikacja serwletów]({{ site.doclinks.specs.servlet }}),
- [Artykuł dotyczący wzorca projektowego obserwator]({% post_url 2019-05-02-wzorzec-projektowy-obserwator %}),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/04_kontekst/src/main/java/pl/samouczekprogramisty/kursaplikacjewebowe).

## Podsumowanie

Wiesz już czym jest `ServletContext` i do czego może być używany. Poznałeś przykłady obiektów nasłuchujących zdarzeń w aplikacjach webowych. Znasz przykłady praktycznego ich wykorzystania. Po wykonaniu ćwiczenia potrafisz zastosować tę wiedzę w praktyce. Innymi słowy poznałeś mechanizmy, pozwalające na działanie aplikacji webowych :).

Mam nadzieję, ze artykuł Ci się podobał. Jeśli nie chcesz pominąć kolejnych zapisz się do samouczkowego newslettera i polub stronę na facebooku.

Na koniec mam do Ciebie prośbę. Zależy mi na dotarciu do jak największego grona czytelników. Możesz mi w tym pomóc przekazując link do artykułu swoim znajomym. Z góry dziękuję i do następnego razu!
