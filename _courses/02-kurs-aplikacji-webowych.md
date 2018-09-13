---
layout: single_page
title: Kurs aplikacji webowych
permalink: /kurs-aplikacji-webowych/
description: W kursie tym poznasz podstawy programowania aplikacji webowych opartych o Java EE.
header:
  teaser: /assets/images/splash/kurs_aplikacji_webowych_splash.jpeg
  overlay_image: /assets/images/splash/kurs_aplikacji_webowych_splash.jpeg
  caption: "[&copy; pixmart](https://pixabay.com/en/spider-web-green-spider-web-nature-1012353/)"
---

Jeśli znasz już [język programowania Java]({{ '/kurs-programowania-java/' | absolute_url }}) możesz zabrać się za pisanie aplikacji webowych. 
W przypadku gdy jest to Twoja pierwsza styczność z aplikacjami tego typu zachęcam do przeczytania [wprowadzenia do aplikacji webowych]({% post_url 2017-03-17-wprowadzenie-do-aplikacji-webowych %}).

Nie zapominaj też o poznaniu narzędzi do budowania, które opisałem w [dziale opisującym narzędzia]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}).

Jeśli jakiekolwiek zagadnienie nie będzie dla Ciebie jasne proszę zadaj pytanie w komentarzu pod artykułem, postaram się pomóc.

## Odrobina teorii

Aplikacje webowe związane są z przesyłaniem danych przez Internet. W praktyce wiąże się to z przesyłaniem danych przy pomocy protokołu HTTP. Jak zwykle twierdzę, że zrozumienie podstaw pomaga lepiej pracować dlatego właśnie napisałem artykuł opisujący [protokół HTTP]({% post_url 2018-02-08-protokol-http %}).

## Podstawy specyfikacji serwletów

Ogromna większość aplikacji webowych pisana w języku Java oparta jest o specyfikację serwletów. Serwlety to podstawa, którą moim zdaniem trzeba znać. Nie znam aplikacji webowej napisanej w języku Java, która nie używałaby tej specyfikacji. Nawet jeśli używasz bibliotek pomocniczych, które ułatwiają pracę pod spodem uda Ci się znaleźć serwlety. Właśnie z tego powodu moim zdaniem dobrze jest poznać te podstawy.

* [Serwlety w aplikacjach webowych]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %})
* [Nagłówki, sesje i ciasteczka]({% post_url 2017-04-01-naglowki-sesje-i-ciasteczka %})
* [Filtry w aplikacjach webowych]({% post_url 2017-04-15-filtry-w-aplikacjach-webowych %})
* [Kontekst serwletu i obiekty nasłuchujące w aplikacjach webowych]({% post_url 2017-04-21-kontekst-serwletu-i-obiekty-nasluchujace-w-aplikacjach-webowych %})
* [Deskryptor wdrożenia w aplikacjach webowych]({% post_url 2017-04-27-deskryptor-wdrozenia-w-aplikacjach-webowych %})

## Poznaj więcej specyfikacji JEE

Skoro udało Ci się poznać specyfikację serwletów nadszedł czas na kolejne specyfikacje z parasola JEE:

* [REST web service z Java EE część 1]({% post_url 2017-11-20-rest-webservice-z-java-ee-czesc-1 %})
* [REST web service z Java EE część 2]({% post_url 2018-01-22-rest-webservice-z-java-ee-czesc-2 %})
* [Walidacja obiektów w języku Java]({% post_url 2017-12-04-walidacja-obiektow-w-jezyku-java %})
* [Format JSON w języku Java]({% post_url 2018-09-14-format-json-w-jezyku-java %})

## Pamiętaj o praktyce

Powtarzam to bez przerwy. Najlepszym sposobem na naukę jest praktyka. Wybierz sobie projekt, który jest dla Ciebie interesujący i spróbuj go zrealizować samodzielnie. Potrzebujesz przykładu? Nie ma sprawy! Na blogu realizowałem kilka projektów, od początku do końca. Gotowy kod wraz z artykułami opisującymi ważniejsze fragmenty znajdziesz na stronie grupującej [przykładowe projekty realizowane na blogu]({{ '/strefa-projektowa/' | absolute_url }}).

## Co dalej?

Jeśli swobodnie tworzysz już aplikacje webowe nie zapominaj o [przydatnych narzędziach i dobrych praktykach]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}). Na tej samej stronie znajdziesz też spis artykułów dotyczących [testów automatycznych]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}).

Aplikacje webowe to studnia bez dna :). Proszę daj znać jaki temat powinienem dodatkowo opisać. Jeśli tylko będę miał wystarczającą wiedzę na ten temat postaram się naskrobać artykuł. A może chcesz poznać język SQL? Jeśli tak to świetnie, bo przygotowałem [darmowy kurs SQL]({{ '/kurs-sql/' | absolute_url }}) na blogu.

Na koniec mam tę samą prośbę co zawsze. Jeśli znajdziesz chwilę, żeby napisać mi co sądzisz o kursie będę wdzięczny. Każda konstruktywna krytyka jest mile widziana. Mój adres e-mail to `marcin małpka samouczekprogramisty.pl`.
