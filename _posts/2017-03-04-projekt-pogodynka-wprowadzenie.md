---
title: Projekt Pogodynka - wprowadzenie
date: '2017-03-04 13:42:38 +0100'
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /projekt-pogodynka-wprowadzenie/
header:
    teaser: /assets/images/2017/03/04_pogodynka_01_artykul.jpeg
    overlay_image: /assets/images/2017/03/04_pogodynka_01_artykul.jpeg
    caption: "[&copy; Marcin Pietraszek ;)](http://marcin.pietraszek.pl)"
excerpt: W artykule tym przeczytasz o “architekturze” Pogodynki. Projektu, w którym chcę udostępnić odczyty temperatury na żywo.
disqus_page_identifier: 761 http://www.samouczekprogramisty.pl/?p=761
---

## Opis architektury

Więc pracę nad Pogodynką czas zacząć. Zacznę od tego, że przybliżę Ci moje plany dotyczące zakresu projektu.

### Hardware

Stare Raspberry PI (nazwijmy je Malinką ;)) wygrzebane gdzieś z szafy ma posłużyć jako "mini komputer", do którego podłączę czujnik temperatury. Czujnik ten będę musiał sam oprogramować - kupiłem go jakiś czas temu w sklepie dla elektroników.

{% include figure image_path="/assets/images/2017/03/04_hardware03_web.jpeg" caption="Pogodynka - Raspberry Pi" %}

Jak widzisz czujnik jest całkiem drobny.

{% include figure image_path="/assets/images/2017/03/04_hardware02_web.jpeg" caption="Czujnik temperatury" %}

Całość na początku połączę kabelkami, może jak starczy czasu pobawię sę w lutowanie a może nawet w wytrwawienie swojej płytki. Czas pokaże :)

{% include newsletter-srodek.md %}

### Software

Kolejnym krokiem będzie napisanie prostego programu, który będzie odpalany na Malince. Nazwijmy go Termometrem. Zadaniem programu będzie pobieranie odczytu czujnika - odczytanie aktualnego poziomu temperatury. Następnie to wskazanie chcę wysłać do aplikacji webowej, która doda dany odczyt do bazy.

Ta sama aplikacja webowa odpowiedzialna będzie za udostępnienie dodatkowego interfejsu. Interfejs ten będzie udostępniał historię wskazań temperatury.Więc na tym etapie mamy dwie osobne aplikacje. Pierwsza z nich to Termometr uruchamiany z linii poleceń, bez żadnego interfejsu graficznego. Druga z nich to aplikacja webowa, która udostępni interfejs dodawania wskazania temperatury oraz pobrania historii odczytów. Tu także nie będzie żadnego interfejsu graficznego.

Ostatnim etapem będzie interfejs użytkownika, który będzie prezentował historyczne odczyty w formie grafów. Tu też pojawią się trudności - ten etap to aplikacja napisana w JavaScript, za którym niestety nie przepadam ;)

Składając te klocki w całość projekt można pokazać na takim uproszczonym diagramie.

{% include figure image_path="/assets/images/2017/03/04_pogodynka-diagram.png" caption="Pogodynka - diagram architektury" %}

Wymyśliłem taką architekturę, ponieważ nie mam publicznego IP i nie mógłbym aplikacji webowej "wystawić na świat" jeśli uruchomiona byłaby na Malince.

Tutaj drobna dygresja dla początkujących. Każda strona internetowa, na przykład [www.samouczekprogramisty.pl](http://www.samouczekprogramisty.pl) utrzymywana jest na serwerze. Serwer ten ma tak zwany adres IP. Upraszczając możemy powiedzieć, że jest to jakaś liczba. Istnieje mechanizm, który pozwala na "tłumaczenie" adresu strony internetowej na adres IP, nazywa się on DNS (ang. _Domain Name System_). Dzięki temu nie musimy zapamiętywać liczb żeby zobaczyć stronę internetową. Wystarczy, że pamiętamy jej adres. Publiczny adres IP to nic innego jak taki numer, który jest stały. Dzięki temu, że adres IP się nie zmienia mapowanie adresu strony na adres IP zawsze jest poprawne.
{: .notice--info}

## Baza danych

Nasze dane to nic innego jak standardowe szeregi czasowe (ang. _time series_). Istnieją dedykowane bazy danych, które bardzo dobrze dają sobie radę z danymi tego typu. Jednak żeby niepotrzebnie nie komplikować samej aplikacji dane będą zapisywane w najzwyklejszej relacyjnej bazie danych. Zdaję sobie sprawę, że z czasem danych może być sporo - jednak baza relacyjna powinna dać sobie z taką ilością bez problemu radę.

Zakładając odczyty temperatury co 5 minut dopiero po prawie dziesięciu latach dojdziemy do miliona rekordów ;). Oczywiście interfejs zwracający historię, będzie musiał dokonywać pewnego rodzaju agregacji, ale o tym będę decydował później.

## Postęp prac

Cały postęp prac nad projektem wraz z zadaniami, które będę realizował możesz śledzić w Trello: [https://trello.com/b/yqZHTqSN/pogodynka](https://trello.com/b/yqZHTqSN/pogodynka). Jest to proste narzędzie pomagające w śledzeniu zadań. W "prawdziwych" projektach programistycznych też używa się takich narzędzi, czasami dużo bardziej rozbudowanych.

Zacząłem od tego, że pół nocy spędziłem na próbie zmuszenia Malinki do współpracy, oczywiście się to nie udało ;). Więc żeby pchnąć całość do przodu zacząłem od innego komponentu - Termometru.

Jeśli jesteś zainteresowany postępem prac nad kodem zachęcam do zajrzenia do repozytorium: [https://github.com/SamouczekProgramisty/Pogodynka](https://github.com/SamouczekProgramisty/Pogodynka). Aktualnie znajduje się tam zestaw kilku obiektów, które reprezentują pomiar temperatury. Pomiar ten jest transformowany do formatu JSON i wysyłany jako żądanie HTTP.

### Testy

Do testowania całego rozwiązania, poza testami jednostkowymi, użyłem usługi [http://requestb.in](http://requestb.in), która pozwala na sprawdzanie wysyłanych żądań. Wygląda na to, że całość działa. Brakuje tu oczywiście warstwy uwierzytelniania. Nie chcę, żeby każdy mógł wysłać żądanie na adres, który będzie akceptował odczyty temperatury.

## Podsumowanie

Na koniec możesz zadać sobie pytanie. Do czego jest MI to potrzebne? Po co mam czytać tę serię artykułów? Pytania są jak najbardziej zasadne. Wydaje mi się, że mam też na te pytania dobrą odpowiedź ;). Moim zdaniem nie ma lepszego sposobu nauki programowania, niż na rzeczywistych problemach, które pojawiają się właśnie w takich projektach. Poza tym każdy programista w swoim życiu więcej kodu czyta niż pisze :).

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz pominąć kolejnych artykułów dopisz się do mojego newslettera i polub Samouczka na facebooku.

Na koniec mam do Ciebie standardową prośbę, podziel się linkiem do artykułu ze znajomymi, zależy mi na dotarciu do jak największej liczby samouków, którzy chcą pogłębiać swoją wiedzę. Do następnego razu!
