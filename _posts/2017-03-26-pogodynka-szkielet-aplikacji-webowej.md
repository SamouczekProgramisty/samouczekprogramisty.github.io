---
title: Pogodynka – szkielet aplikacji webowej
last_modified_at: 2018-08-24 22:22:38 +0200
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /pogodynka-szkielet-aplikacji-webowej/
header:
    teaser: /assets/images/2017/03/26_pogodynka_04_artykul.jpg
    overlay_image: /assets/images/2017/03/26_pogodynka_04_artykul.jpg
    caption: "[&copy; marksuth](https://www.flickr.com/photos/marksuth/8768228386/sizes/l)"
excerpt: Kolejna informacja dotycząca postępu prac nad projektem Pogodynka. Dzisiaj trochę o Spring MVC i przykładowej konfiguracji, zapraszam do lektury.
disqus_page_identifier: 804 http://www.samouczekprogramisty.pl/?p=804
toc: false
---

W tym tygodniu przygotowałem dla Was dość obszerny wpis dotyczący [serwletów w aplikacjach Java]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %}). Jego przygotowanie zajęło mi sporo czasu więc automatycznie zostało go mniej na samą Pogodynkę.

Jednak i tutaj udało się pchnąć sprawy do przodu. W tym momencie [datavault](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/datavault) jest już “działającą” aplikacją webową opartą o Spring MVC. Uparłem się i całą konfigurację zrobiłem bez użycia Spring Boot i plików XML. Chcę to zrobić w ten sposób, aby pokazać Wam przykład takich właśnie aplikacji.

W tym momencie obsługiwane są żądania typu POST i GET, które będą odpowiednio dodawały nowy wpis dotyczący temperatury i pobierały listę temperatur.

## Warstwa widoku

W pierwotnej wersji zakładałem, że napiszę osobną aplikację w Java Script, która będzie odpowiadała za generowanie widoku. Coraz bardziej się nad tym zastanawiam. Widzę pewną wartość w zrobieniu tego w “stary” sposób.

W “stary”, czyli z wykorzystaniem plików JSP. Dzięki temu będę miał dla Was przykład aplikacji używającej właśnie takiego podejścia do kolejnych artykułów, a artykuł o JSP na pewno powstanie.

## Spring MVC

Aktualnie aplikacja używa Spring MVC. Konfiguracja w większości używa ustawień domyślnych, które włączone są przy pomocy kilku “springowych” adnotacji:
- [`@Configuration`](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html)
- [`@EnableWebMvc`](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html)
- [`@ComponentScan`](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/context/annotation/ComponentScan.html)

Przykład ich użycia możesz zobaczyć w klasie `WebAppConfiguration`. Klasa ta jest użyta jako bazowy “applicationContext”, włącza obsługę Spring MVC oraz wskazuje pakiety, w których Spring szuka klas, którymi zarządza (potocznie mówi się tu o bean’ach).

Kolejną istotną klasą jest [`DatavaultInitializer`](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/configuration/DatavaultInitializer.java), która konfiguruje instancję `DispatcherServlet` obsługującego aplikację (o tym jak to ustrojstwo magicznie działa możesz przeczytać we wcześniej wspomnianym [artykule o serwletach]({% post_url 2017-03-25-serwlety-w-aplikacjach-webowych %})),

Przygotowałem też naiwną implementację klasy odpowiedzialnej za zarządzanie temperaturami [`TemperatureServiceImpl`](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/TemperatureServiceImpl.java), w obecnym kształcie nie robi ona jeszcze nic użytecznego.

## Podsumowanie

Kodu w tym tygodniu nie pojawiło się za wiele, jednak “szkielet” aplikacji webowej już jest i czeka na lepsze czasy ;). Jak zwykle całość kodu dostępna jest w [repozytorium](https://github.com/SamouczekProgramisty/Pogodynka). Do następnego razu!
