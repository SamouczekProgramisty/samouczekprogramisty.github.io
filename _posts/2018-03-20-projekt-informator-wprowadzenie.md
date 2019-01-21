---
title: Projekt Informator wprowadzenie
date: 2018-06-20 20:57:35 +0200
categories:
- Projekty
- Projekt Informator
permalink: /projekt-informator-wprowadzenie/
header:
    teaser: /assets/images/2018/03/20_projekt_informator_wprowadzenie.jpg
    overlay_image: /assets/images/2018/03/20_projekt_informator_wprowadzenie.jpg
    caption: "[&copy; counselman](https://www.flickr.com/photos/counselman/4477748418/sizes/l)"
excerpt: Na blogu pojawia się drugi projekt. Projekt Informator, bo o nim mowa, łączył będzie w sobie najczęściej używane biblioteki do tworzenia aplikacji webowych - Spring i Hibernate.
---

## Projekt Informator

Informator to kolejny większy projekt (po [Pogodynce]({% post_url 2017-03-04-projekt-pogodynka-wprowadzenie %})), który będę realizował na blogu. Moim celem jest zaimplementowanie gotowego webservice'u, który przy pomocy [REST]({% post_url 2017-11-20-rest-webservice-z-java-ee-czesc-1 %}) API będzie zwracał dane w formacie JSON. Projekt będę tworzył w oparciu o biblioteki Spring i Hibernate.

## Czym będzie Informator

Informator to projekt, którego głównym celem będzie napisanie webservice'u. Webservice ten będzie miał za zadanie informować o szczegółach konferencji infoShare 2018. Informator za pośrednictwem [protokołu HTTP]({% post_url 2018-02-08-protokol-http %}) będzie udostępniał dane o wydarzeniu w formacie JSON. Planuję, że będzie on zawierał trzy niezależne "endpoint'y":

- prelegenci,
- wykłady/rozmowy/wydarzenia,
- sceny.

{% include wspolpraca-infoshare-2018.md %}

### Prelegenci

Endpoint ten będzie zwracał szczegóły dotyczące prelegentów. Dzięki niemu będzie można dowiedzieć się czegoś więcej o prowadzących.

### Wykłady, rozmowy, wydarzenia

Endpoint ten będzie zwracał informacje na temat wydarzeń, które będą miały miejsce w trakcie konferencji. Poza opisem zwracał będzie także informacje takie jak miejsce i czas wydarzenia. Dodatkowo będzie udostępniał informacje o prelegentach/uczestnikach danego wydarzenia.

### Sceny

Dzięki temu endpoint'owi będzie można poznać grafik obowiązujący na każdej ze scen.

## Architektura i wdrożenie projektu

Ze strony architektonicznej nie jest to skomplikowany projekt. Wręcz przeciwnie, to aplikacja webowa, która wyłącznie serwuje dane zapisane w bazie danych. Celowo nie planuję udostępnienia funkcjonalności modyfikowania czy usuwania danych. Baza danych zasilona będzie statycznymi danymi. Dzięki takiemu podejściu nie muszę implementować mechanizmu uwierzytelniania i autoryzacji. Także walidacja danych wejściowych będzie ograniczona.

Aplikację chcę uruchomić w chmurze. Nie zdecydowałem się jeszcze na konkretnego dostawcę. Na tym etapie nie chcę podejmować decyzji, którego dostawcę wybrać ;). Możliwe, że będzie to Heroku lub Google Cloud. 

## Prowadzenie projektu

Podobnie jak w przypadku Pogodynki założyłem specjalną [listę zadań na Trello](https://trello.com/b/8MAE66kc/informator). Lista ta będzie ewoluowała w czasie, aktualnie zawiera podstawowe zadania niezbędne do realizacji. Dzięki tej liście i [repozytorium kodu](https://github.com/SamouczekProgramisty/Informator) na bieżąco będziesz mógł śledzić postęp prac nad projektem.

Zależy mi na uruchomieniu tego projektu do końca kwietnia. Mam nadzieję, że uda mi się dotrzymać terminu, który sobie narzuciłem. Trzymaj kciuki ;).

## Testy

Oczywiście projekt zawierał będzie [testy jednostkowe]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}), które będą skupiały się na poszczególnych komponentach. Dodatkowo planuję napisać testy integracyjne, które będą sprawdzały poprawność działania mapowania obiektowo-relacyjnego. Założeniem tych testów będzie tworzenie nowej instancji bazy danych w pamięci przed uruchomieniem każdego testu.

Planuję także stworzenie zestawu testów integracyjnych. Utworzę je używając [SoapUI](https://www.soapui.org/). Dzięki takiemu podejściu będę miał kompletny zestaw testów automatycznych potwierdzających poprawność działania aplikacji.

## Podsumowanie

Projekt Informator jest w powijakach, dopiero zacząłem nad nim pracę. Mam nadzieję, że tym krótkim artykułem zachęciłem Cię do śledzenia rozwoju projektu. Narzędzia i biblioteki, których użyję w trakcie pracy nad Informatorem są bardzo często wykorzystywane w projektach produkcyjnych.

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz pominąć kolejnych artykułów na blogu dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Do następnego razu!
