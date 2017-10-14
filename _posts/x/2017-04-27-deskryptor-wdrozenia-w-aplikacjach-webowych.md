---
layout: single
title: Deskryptor wdrożenia w aplikacjach webowych
date: '2017-04-27 21:56:57 +0200'
categories:
- DSP2017
- Kurs aplikacji webowych
excerpt_separator: "<!--more-->"
permalink: "/deskryptor-wdrozenia-w-aplikacjach-webowych/"
---
Do tej pory w konfigurowaniu wszystkich elementów aplikacji webowej posługiwałem się adnotacjami. Nadszedł czas abyś poznał inny sposób konfiguracji aplikacji webowych. Konfiguracja przy pomocy pliku `web.xml` nazywanego deskryptorem wdrożenia.

# Deskryptor wdrożenia
  
Plik `web.xml` nazywany jest deskryptorem wdrożenia. W starszych wersjach specyfikacji serwletów tylko przy jego pomocy można było konfigurować aplikacje webowe.

Aktualnie plik `web.xml` nie jest wymagany, praktycznie wszystkie elementy można skonfigurować przy pomocy adnotacji. Jednak nadal zdarzają się aplikacje gdzie taki plik jest wykorzystywany. W związku z tym dobrze jest wiedzieć o jego istnieniu.

Oczywiście zawartością deskryptora wdrożenia są znaczniki XML, jeśli nie miałeś wcześniej styczności z tym formatem zapraszam do osobnego artykułu ze [wstępem do formatu XML](http://www.samouczekprogramisty.pl/xml-dla-poczatkujacych/).

Plik `web.xml` powinien znajdować się bezpośrednio w katalogu WEB-INF wewnątrz pliku war. Struktura przykładowego pliku war może wyglądać następująco:

    $ unzip -l build/libs/05_webxml-1.0-SNAPSHOT.warArchive: build/libs/05_webxml-1.0-SNAPSHOT.war Length Date Time Name--------- ---------- ----- ---- 0 2017-04-27 20:15 META-INF/ 25 2017-04-27 20:12 META-INF/MANIFEST.MF 0 2017-04-27 20:15 WEB-INF/ 0 2017-04-27 20:15 WEB-INF/classes/ 0 2017-04-26 21:36 WEB-INF/classes/pl/ 0 2017-04-26 21:36 WEB-INF/classes/pl/samouczekprogramisty/ 0 2017-04-26 21:36 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/ 0 2017-04-27 20:15 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/webxml/ 0 2017-04-27 20:15 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/webxml/xml/ 1073 2017-04-27 20:15 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/webxml/xml/XMLConfiguredListener.class 3045 2017-04-27 20:15 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/webxml/xml/XMLConfiguredServlet.class 1330 2017-04-27 20:15 WEB-INF/classes/pl/samouczekprogramisty/kursaplikacjewebowe/webxml/xml/XMLConfiguredFilter.class 1227 2017-04-26 21:40 WEB-INF/web.xml--------- ------- 6700 13 files

  
Strukturę aplikacji webowej opisywałem szczegółowo w pierwszym [artykule wprowadzającym](http://www.samouczekprogramisty.pl/serwlety-w-aplikacjach-webowych/).
# Szablon `web.xml`
  
Plik `web.xml` informuje kontener serwletów o wersji specyfikacji serwletów. Dla każdej wersji specyfikacji plik ten różni się nagłówkiem. Dla wersji 3.1 szablon pliku wygląda następująco

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" version="3.1">

  
Jak widzisz w głównym węzłem deskryptora wdrożenia jest ``. Wewnątrz tego znacznika znajduje się właściwe elementy konfigurujące aplikację webową.

W kolejnej części artykułu zobaczysz porównanie konfiguracji przy pomocy znaczników XML z konfiguracją zapisaną w postaci adnotacji. W obu przypadkach pokazywał będę prostą aplikację, która zawiera serwlet, obiekt nasłuchujący i filtr. Przykładowy deskryptor wdrożenia możesz zobaczyć na [samouczkowym githubie](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/blob/master/05_webxml/src/main/webapp/WEB-INF/web.xml). Zawiera on wszystkie elementy omówione poniżej.

## Konfiguracja serwletu
  
Podstawowa konfiguracja serwletu sprowadza się do nadania mu nazwy i podpięcia go pod odpowiedni adres URL. Zobacz jak taki efekt można osiągnąć przy pomocy znaczników XML i adnotacji.
### Znaczniki XML

    my-servlet pl.samouczekprogramisty.kursaplikacjewebowe.webxml.xml.XMLConfiguredServlet my-servlet /servlet-url-xml

  
Powyższy fragment xml zawiera kilka znaczników. Pierwszy z nich `` informuje kontener serwletów o tym, ze w klasie `pl.samouczekprogramisty.kursaplikacjewebowe.webxml.xml.XMLConfiguredServlet` znajduje się serwlet. Nadałem mu nazwę `my-servlet`. Następnie wewnątrz ``, posługując się wcześniej nadaną nazwą podpinam serwlet pod adres URL `/servlet-url-xml`.
### Adnotacje

    @WebServlet(name = "my-servlet", urlPatterns = "/servlet-url-annotations")public class AnnotationConfiguredServlet extends HttpServlet

  
W przypadku adnotacji sprawa jest prostsza. Tutaj nie muszę podawać dokładnej nazwy klasy wraz z pakietem. Adnotacja znajduje się właśnie w nad tą klasą.
## Konfiguracja filtra
  
Aby skonfigurować podstawowy filtr należy nadać mu nazwę i podpiąć go pod serwlet czy adres URL. Poniżej możesz porównać oba sposoby konfiguracji.
### Znaczniki XML

    my-filter pl.samouczekprogramisty.kursaplikacjewebowe.webxml.xml.XMLConfiguredFilter my-filter /servlet-url-xml my-filter my-servlet

  
Podobnie jak w przypadku serwletu pierwszy znacznik `` tworzy filtr o nazwie `my-filter` podpinając klasę `pl.samouczekprogramisty.kursaplikacjewebowe.webxml.xml.XMLConfiguredFilte`. Kolejne dwie grupy znaczników `` posługują się nazwą filtra. Pierwsza używa `` aby podpiąć filtr pod konkretny adres URL. Wewnątrz drugiego znacznika `` użyłem `` aby podpiąć filtr pod konkretny serwlet.
### Adnotacje

    @WebFilter(filterName = "my-filter", servletNames = "my-servlet", urlPatterns = "/servlet-url-annotations")public class AnnotationConfiguredFilter implements Filter

## Konfiguracja obiektu nasłuchującego
  
W tym przypadku sprawa jest prosta. Cała konfiguracja sprowadza się do poinformowania kontenera serwletów o istnieniu takiego obiektu.
### Znacznik XML

    pl.samouczekprogramisty.kursaplikacjewebowe.webxml.xml.XMLConfiguredListener

### Adnotacje

    @WebListenerpublic class AnnotationConfiguredListener implements ServletRequestListener

# Dodatkowe informacje

## Kiedy plik web.xml jest niezbędny
  
Są sytuacje w których plik web.xml jest niezbędny. W przypadku kiedy istotna jest kolejność wykonania filtrów, obiektów nasłuchujących czy przypisania serwletów do adresów URL plik web.xml jest niezbędny. Specyfikacja serwletów jasno mówi o tym, że bez tego pliku kolejność wywołania tych elementów nie jest jasno określona.
## Modułowość konfiguracji
  
Konfigurację podobną do tej z pliku `web.xml` można zawrzeć w plikach `web-fragment.xml`. Taki plik może znajdować się w każdym pliku jar, który znajduje się wewnątrz pliku war (ponownie odsyłam do [artykułu opisującego strukturę aplikacji webowej](http://www.samouczekprogramisty.pl/serwlety-w-aplikacjach-webowych/)). Konkretnie w katalogu `META-INF` wewnątrz pliku jar.

Wewnątrz pliku `web-fragment.xml` możemy użyć tych samych znaczników jak pliku `web.xml`. Różnicą jest tutaj znacznik główny. W tym przypadku jest to `` a nie ``.

## Ostatnie słowo ma `web.xml`
  
Chociaż dla niektórych osób adnotacje czy pliki `web-fragment.xml` mogą być preferowanym wyborem to `web.xml` ma ostatnie słowo. Mam tu na myśli atrybut `metadat-complete`. Atrybut ten można ustawić na znaczniku ``. Jeśli przyjmie on wartość `true`, wówczas adnotacje i pliki `web-fragment.xml` będą ignorowane. W takim przypadku cała konfiguracja aplikacji webowej musi znajdować się w pliku `web.xml`.

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" version="3.1" metadata-complete=”true”>

# Przykładowe aplikacje
  
Na potrzeby tego artykułu napisałem dwie proste aplikacje. Jedna z nich skonfigurowana jest wyłączni przy użyciu znaczników xml, druga tylko adnotacji. Zachęcam do zajrzenia do kodu, który umieściłem na githubie:
- [Aplikacja konfigurowana wyłącznie przy pomocy XML](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/05_webxml/src/main),
- [Aplikacja konfigurowana wyłącznie przy pomocy adnotacji](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/tree/master/05_webxml_annotations/src/main/).
  

# Podsumowanie
  
Przedstawiłem tutaj wyłącznie podstawowe znaczniki stosowane wewnątrz pliku `web.xml`. Zależało mi na tym abyś sam mógł zobaczyć różnicę pomiędzy tymi podejściami. Nie oceniam, które z nich jest lepsze, które gorsze. Każde z nich ma swoje wady i zalety. Wybierz ten sposób, który bardziej Ci odpowiada i konsekwentnie się go trzymaj.

Z jednej strony posiadanie całej konfiguracji w pliku xml jest wygodne. Jednak z drugiej strony w przypadku adnotacji edytując kod od razu masz informacje o konfiguracji. Ciekawy jestem Twojego zdania. Które podejście bardziej Ci odpowiada i dlaczego?

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/photos\_by\_clark/26137047996/sizes/l

