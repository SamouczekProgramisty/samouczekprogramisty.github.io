---
title: Wprowadzenie do aplikacji webowych
date: '2017-03-17 21:39:50 +0100'
categories:
- Kurs programowania Java
- DSP2017
permalink: /wprowadzenie-do-aplikacji-webowych/
header:
    teaser: /assets/images/2017/03/17_wprowadzenie_do_aplikacji_webowych_artykul.jpg
    overlay_image: /assets/images/2017/03/17_wprowadzenie_do_aplikacji_webowych_artykul.jpg
    caption: "[&copy; redbuckley](https://www.flickr.com/photos/redbuckley/5885481290/sizes/l)"
excerpt: W artykule tym przeczytasz o aplikacjach webowych. Dowiesz się czym są aplikacje webowe i jak działają. Dowiesz się czym jest serwer, sewlet czy kontener serwletów. Poznasz podstawy mechanizmu działania aplikacji webowych. Przeczytasz też o modelu aplikacji klient serwer. Poznasz różnicę pomiędzy aplikacjami “desktopowymi” a aplikacjami “webowymi”. Dowiesz się o tym czym jest HTML, CSS czy JavaScript. Innymi słowy czeka Cię spora dawka wiedzy wprowadzająca w świat aplikacji webowych i Java Enterprise Edition. Zapraszam do lektury.
---

{% include toc %}

## Z przeglądarką czy bez?

Używając przeglądarki czy programów z pakietu Office[^office] używasz aplikacji zainstalowanych na komputerze. Potocznie o takich programach czy aplikacjach mówi się “aplikacje desktopowe”.

[^office]: Chodzi mi to o tę "instalowalną" część pakietu, a nie tę dostępną online ;).

Możesz je zainstalować pobierając odpowiednie pliki z internetu lub z innego nośnika jak na przykład płyta CD. Podczas takiej instalacji pliki niezbędne do działania aplikacji zapisywane są na dysku komputera.

Aplikacje webowe, to zupełnie oddzielna grupa aplikacji. Nie są one instalowane na Twoim komputerze. Można powiedzieć, że są zainstalowane na serwerze, a Ty dostajesz się do nich za pośrednictwem internetu. Otwierając przeglądarkę internetową i wchodząc na stronę dostajesz się do aplikacji webowej. Jak już wspomniałem do działania takiej aplikacji potrzebny jest ów “magiczny” serwer.

## Czym jest serwer

Słowo serwer ma wiele znaczeń. Jednym ze znaczeń tego słowa jest określenie maszyny, komputera. Serwerem możemy także nazywać aplikację, która jest na takim komputerze zainstalowana. Przykładem takich serwerów są [Apache HTTP Server](https://httpd.apache.org/) czy [nginx](https://nginx.org/en/).

Wymienione wyżej serwery to serwery HTTP (ang. _Hypertext Transfer Protocol_), ich zadaniem jest serwowanie stron internetowych.

Wpisując adres [www.samouczekprogramisty.pl](http://www.samouczekprogramisty.pl) w okienku przeglądarki wysyłasz zapytanie HTTP do serwera firmy, w której wykupiłem taką usługę. Serwer ten widząc twoje zapytanie odpowiada treścią, która jest zrozumiała dla przeglądarki. Przeglądarka wyświetla następnie tę treść w formie strony internetowej.

W najprostszym przykładzie jakim jest serwer HTTP, serwer (aplikacja) w odpowiedzi wysyła zawartość plików znajdujących się na dysku serwera (komputera). W takim przypadku możemy mówić o serwowaniu plików statycznych.

Aplikacje webowe pokazują zawartość, która jest zmienna. Nie można jej uzyskać wyłącznie z plików statycznych znajdujących się na dysku serwera. Przykładem takiej aplikacji może być ten blog - masz wpływ na zawartość strony na przykład przez dodawanie komentarzy.

## Język aplikacji webowej

Aplikacje webowe mogą być napisane w wielu językach. Może to być Ruby, Python, PHP czy Java. Bynajmniej nie jest to kompletna lista :). Języków jest bardzo dużo, jednak mechanizm działania jest zawsze ten sam.

Aplikacja webowa napisana w języku X interpretuje żądanie wysłane przez przeglądarkę użytkownika do serwera i odpowiada na nie generując odpowiednią zawartość. Zawartość to plik generowany dynamicznie, który jest zrozumiały przez przeglądarkę internetową.

Zauważ, że taki sposób komunikacji pozwala na zastosowanie praktycznie dowolnego języka. W takiej sytuacji mówimy o protokole komunikacji. Protokole czyli zbiorze reguł, których przestrzeganie pozwoli się “dogadać” :).

Protokół ten używany jest w komunikacji pomiędzy klientem a serwerem. W tym przypadku klientem jest przeglądarka internetowa a serwerem jest aplikacja, która przetwarza żądanie wysłane przez klienta. W takim przypadku często też mówimy o aplikacjach typu klient-serwer.

## Język, który rozumie przeglądarka

W dużym uproszczeniu przeglądarka internetowa to program, który wyświetla strony internetowe. Strony internetowe składają się z plików. Pliki te tworzone są przy pomocy różnych “języków”:
- HTML (ang. _Hypertext Markup Language_) - język znaczników, można powiedzieć, że jest podzbiorem języka XML ([wprowadzenie do XML]({% 2017-03-02-xml-dla-poczatkujacych %})). Znaczniki te opisują strukturę strony, to z jakich elementów się składa,
- CSS (ang. Cascading Style Sheets) - język stylów, który pozwala na opisanie wyglądu strony internetowej. W połączeniu z HTML pozwala na tworzenie stron internetowych “przyjaznych dla oka”,
- JavaScript - język programowania. Kod JavaScript jest interpretowany przez przeglądarkę. Pozwala na uruchamianie skryptów po stronie przeglądarki. Bardzo często animacje widoczne na stronach to właśnie wynik działania skryptów JavaScript.

## Aplikacje webowe w Javie

Aplikacje webowe w języku Java można tworzyć dzięki specyfikacji JEE (ang. _Java Enterprise Edition_). Jest to właściwie zbiór innych specyfikacji opisujących różne mechanizmy wykorzystywane przy budowaniu aplikacji webowych.

Podobnie jak w przypadku innych języków tak i w Javie potrzebny jest odpowiedni serwer. W przypadku Javy możemy mówić o serwerze aplikacji jeśli implementuje on funkcjonalności opisane w specyfikacji JEE. Z racji tego, że specyfikacja ta jest rozległa dostępne są “prostsze serwery”. W takim przypadku mówimy o kontenerze serwletów. Jest to “uproszczony serwer aplikacji”, który implementuje jedynie część specyfikacji JEE.

Częścią specyfikacji JEE jest specyfikacja serwletów.

## Serwlety w aplikacjach webowych

Serlwet to serce aplikacji webowych napisanych w Javie. Serwlet to klasa, która wie w jaki sposób obsłużyć zapytanie wysłane do serwera. Potrafi też odpowiedzieć na to zapytanie.

W artykule opisującym [Javę z linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}) mogłeś przeczytać o plikach JAR. W przypadku aplikacji webowych wprowadzono dodatkowy plik, plik WAR (ang. _Web Archive_). Wewnątrz tego pliku znajduje się kod (skompilowane klasy) potrzebny do uruchomienia aplikacji webowej. Między innymi są to serwlety. Dodatkowo wewnątrz pliku WAR znajdować się mogą pliki JAR zawierające zależności niezbędne do działania aplikacji webowej.

Plik war instaluje się w kontenerze serwletów (ang. _deploy_). Kontener serwletów pośredniczy w obsłudze zapytań. Jak to wygląda w praktyce pokaże Ci profesjonalny diagram poniżej :), pokazuje on w dużym uproszczeniu obsługę żądań do aplikacji webowej:

{% include figure image_path="/assets/images/2017/03/17_diagram_web.jpeg" caption="Obsługa żądania w aplikacji webowej" %}

1. wysłanie żądania z przeglądarki do serwera (maszyny)
2. przekazanie żądania do kontenera serwletów/serwera aplikacji
3. przetworzenie żądania przez serwlet/aplikację webową
4. przekazanie odpowiedzi z kontenera serwletów do serwera
5. wysłanie odpowiedzi do klienta (przeglądarki internetowej)

Istnieje wiele serwerów aplikacji i kontenerów serwletów. Te najpopularniejsze z nich znajdziesz poniżej:
- [Tomcat](http://tomcat.apache.org)
- [Jetty](http://www.eclipse.org/jetty/)
- [Glassfish](https://glassfish.java.net/)
- [WildFly](http://wildfly.org/)
- [Weblogic](http://www.oracle.com/technetwork/middleware/weblogic/overview/index-085209.html)

## Zalety aplikacji webowych

Główną zaletą aplikacji webowych jest to, że nie trzeba instalować ich na komputerze użytkownika. Aby korzystać z takiej aplikacji wystarczy przeglądarka z dostępem do internetu. Dzięki temu użytkownik może korzystać z takiej aplikacji praktycznie na dowolnym komputerze.

Nie bez znaczenie jest też dostępność aplikacji webowej na różnych typach urządzeń. Część aplikacji webowych można używać zarówno na komputerze, tablecie czy telefonie.

Równie istotna jest łatwość poprawiania błędów. W aplikacjach desktopowych jest to utrudnione, ponieważ w jakiś sposób aktualizacja musi być dostarczona do użytkownika. W przypadku aplikacji webowych taka aktualizacja może być dla użytkownika niewidoczna. Dzięki temu poprawki błędów czy nowe funkcjonalności są szybciej dostępne dla użytkowników.

## Podsumowanie

Aplikacje webowe to coś dzięki czemu moim zdaniem Java zyskała tak dużą popularność. Ogromna większość ofert pracy na rynku związana z technologią Java dotyczy aplikacji webowych. Artykuł ten jedynie musnął ich tematykę. Mam nadzieję, że po jego lekturze będzie Ci łatwiej zrozumieć zasadę działania tego typu aplikacji.

Zapisz się do mojego newslettera i polub stronę na facebooku jeśli nie chcesz pominąć kolejnych artykułów. Jeśli masz jakiekolwiek pytania proszę zadaj je w komentarzu :).

Do następnego razu!
