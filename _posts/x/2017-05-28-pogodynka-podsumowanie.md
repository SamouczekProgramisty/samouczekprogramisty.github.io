---
layout: single
title: Pogodynka - podsumowanie
date: '2017-05-28 18:38:50 +0200'
categories:
- DSP2017
- Projekty
- Pogodynka
excerpt_separator: "<!--more-->"
permalink: "/pogodynka-podsumowanie/"
---
Pogodynka to projekt, w ramach którego od marca do maja pracowałem nad stacją pogodową opartą o Raspberry Pi. Ten artykuł podsumowuje ostatnią część prac nad projektem. Pokazuje też finalny efekt tej pracy.

Jeśli chcesz przeczytać więcej na temat samego projektu i jego założeń zapraszam do przeczytania [pozostałych artykułów opisujących projekt](http://www.samouczekprogramisty.pl/projekty/pogodynka/).{: .notice--info}

# Mistrz lutownicy ucieka
  
Aby mieć sensowne odczyty temperatury musiałem użyć czujnika zewnętrznego. Jest on odporny na wilgoć więc nie powinno być problemu z odczytem temperatury w trakcie deszczu. Mistrzem lutownicy na pewno nie jestem, ale finalny efekt nie wyszedł najgorzej.

[![Lutowanie czjunika](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/lutowanie-300x225.jpeg)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/lutowanie.jpeg)Na zdjęciu możesz zobaczyć opornik przylutowany do czujnika temperatury.

# Profile Spring w aplikacji Datavault
  
Aplikacja webowa, która odpowiada za zapis i odczyt historycznych wskazań czujnika temperatury działa w kilku środowiskach. Pierwszym z nich jest środowisko developerskie. Kolejnym “produkcyjne”, w którym aplikacja jest [dostępna z internetu](http://pogodynka.pietraszek.pl).

Oba te środowiska różnią się między sobą. Jedną z różnic jest konfiguracja bazy danych. W związku z tym użyłem [profili udostępnionych przez Springa](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-profiles.html).

Profil wybierany jest na podstawie jednego z parametrów przekazywanych podczas uruchomienia wirtualnej maszyny Javy. Dzięki temu bez zmieniania kodu aplikacji mogę użyć tego samego pliku war w różnych środowiskach.

# Średnia dobowa temperatura
  
Użytkownik, dla którego pisałem tę aplikację (mój ociec ;)), wspomniał o paru funkcjonalnościach, które byłby przydatne.

Główną z nich jest możliwość udostępnienia średniej dobowej temperatury. W meteorologii temperatura ta jest średnią z odczytów z godzin 1, 7, 13 i 19.

W przypadku Pogodynki malinka wysyła odczyty temperatury co godzinę. Oczywiście jest to pomiar z “drobnym poślizgiem”, na przykład z godziny 13:00:05 a nie 13:00:00. Średnią dobową obliczam na etapie pobierania danych z bazy danych używając następującego zapytania SQL:

    SELECT day, SUM(temperature) / COUNT(temperature) AS daily_average FROM (SELECT DATE(when_measured) AS day, EXTRACT('hour' FROM when_measured) AS hour, temperature FROM temperature_measurements WHERE EXTRACT('hour' FROM when_measured) IN (1, 7, 13, 19) AND EXTRACT('minute' FROM when_measured) < 2) AS daily_tempsGROUP BY dayORDER BY day;

  
Następnie wyniki tego zapytania udostępnione są w formie dokumentu JSON. Tak sformatowane dane są następnie wykorzystywane przez interfejs użytkownika.
# Interfejs użytkownika
  
Kilka ostatnich dni poświęciłem na pracę nad [interfejsem użytkownika](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/frontend/index.html). Całość sprowadzała się do eksperymentów z JavaScript i API biblioteki [Highcharts](https://www.highcharts.com/). Właśnie tej biblioteki użyłem do pokazywania historycznych wykresów temperatury.

Finalny efekt pracy wygląda następująco:

# [![](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/wykres_temperatury-300x171.jpeg)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/wykres_temperatury.jpeg)Podsumowanie projektu
  
W trakcie pracy nad projektem udało mi się zrealizować większość początkowych założeń. Projekt udało mi się “dowieźć” w terminie. [Trello](https://trello.com/b/yqZHTqSN/pogodynka), którego używałem do śledzenia zadań w projekcie pokazuje dokładnie w jakim etapie jestem etapie. Jest bardzo dobrze :).

Chociaż całość mogę określić jako “udany projekt” mam świadomość pewnych niedociągnięć. Głównym z nich jest brak testów integracyjnych dla aplikacji Datavault. Podejrzewam, że znalazłbym kilka błędów po napisaniu odpowiedniego zestawu testów/

Muszę też powiedzieć, że zdecydowanie nie doszacowałem części związanej z integracją i konfiguracją. Praca nad modułami puppeta zajęła mi sporo czasu.

Podsumowując całość w jednym zdaniu. Bardzo się cieszę, że Pogodynka zakończyła się sukcesem :).

W przyszłości planuję realizację innych projektów tego typu. Może chciałbyś zobaczyć konkretny projekt realizowany w ten sposób? Daj znać w komentarzac, razem na pewno uda się nam wybrać coś ciekawego :).

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/schermannski/34492740872/sizes/l

