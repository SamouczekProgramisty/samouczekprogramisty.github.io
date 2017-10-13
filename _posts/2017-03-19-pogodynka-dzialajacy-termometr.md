---
layout: post
title: Pogodynka - działający termometr
date: '2017-03-19 19:16:29 +0100'
categories:
- DSP2017
- Projekty
- Pogodynka
excerpt_separator: "<!--more-->"
permalink: "/pogodynka-dzialajacy-termometr/"
---
Relacja z frontu projektu Pogodynka. Dzisiaj przeczytasz o tym czym jest projekt modułowy w Gradle, zobaczysz jak wygląda podstawowy szablon aplikacji webowej. Dowiesz się też jak odczytywać temperaturę z czujnika DS18B20, który podłączyłem do Malinki. Zapraszam do lektury.

# Postęp w module Thermometer
  
Mogę powiedzieć, że pierwszy moduł całej aplikacji jest “gotowy”. Podłączyłem czujnik temperatury do Malinki, udało mi się nawet odczytać wskazania temperatury. Klasa `FromFileThermometer` jest w stanie przeczytać zawartość takiego pliku i odpowiednio ją zinterpretować, udowadnia to test jednostkowy `FromFileThermometerTest`.
## Praca z czujnikiem DS18B20 na Malince
  
Czujnik temperatury DS18B20 można połączyć bezpośrednio pod wyjścia GPIO (ang. _General Purpose Input Output_). Wystarczy do tego sam czujnik i opornik 4.7k. W moim przypadku na zdjęciu poniżej widać to połączenie:

[![podpięcie czujnika temperatury](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/raspberry_pi_polaczenie-225x300.jpg)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/raspberry_pi_polaczenie.jpg)

U siebie zastosowałem opornik 4.6k (akurat taki udało mi się dostać w sklepie).

Jeśli wszystko działa poprawnie Malinka wykryje czujnik i w katalogu `/sys/bus/w1/devices` znajdzie się katalog o nazwie `28-00000xxxxxx`. `xxxxxx` może być różne i jest unikalnym identyfikatorem danego czujnika. Wewnątrz tego katalogu znajduje się plik `w1_slave`, który zawiera aktualne wskazanie czujnika.

[![wskazanie czujnika temperatury](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/raspberry_pi_temperature-300x180.png)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/raspberry_pi_temperature.png)

Odczytanie temperatury sprowadza się do poprawnego parsowania zawartości tego pliku. Przykład realizacji możesz znaleźć we wcześniej wspomnianej klasie `FromFileThermometer`.

# Zmiany w Gradle
  
Sporo też zmieniło się w samej strukturze projektu. Od teraz pogodynka to projekt, który składa się z wielu modułów. Jest to możliwe dzięki dodaniu pliku [`settings.gradle`](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/settings.gradle), który opisuje strukturę takiego projektu.

Jeden z modułów już znasz thermometer. Nowy, który się pojawił to datavault. Dla przypomnienia jest to moduł, który odpowiedzialny będzie za zapisywanie wskazań temperatury w bazie. Udostępniał też będzie usługi, które używane będą przez interfejs użytkownika w przeglądarce internetowej.

Całość na prostym diagramie wygląda następująco:

[![pogodynka diagram](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/diagram_pogodynka-300x127.jpg)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/03/diagram_pogodynka.jpg)

Jeśli chcesz poznać podstawy Gradle zapraszam do [osobnego artykułu](http://www.samouczekprogramisty.pl/wstep-do-gradle/).

# Szablon aplikacji webowej
  
Moduł datavault będzie aplikacją webową. Aplikacja ta nie będzie posiadała żadnego interfejsu graficznego. Wystawi jedynie usługi, które będą realizowały całą funkcjonalność:
- zapis aktualnej temperatury,
- odczyt temperatur z N ostatnich dni.
  
  
Jeśli wcześniej nie miałeś do czynienia z aplikacjami tego typu zachęcam do przeczytania [wprowadzenia do aplikacji webowych](http://www.samouczekprogramisty.pl/wprowadzenie-do-aplikacji-webowych/).

Aktualnie moduł datavault to pusty szablon aplikacji webowej. Całość sprowadza się do pliku datavault.gradle, który definiuje aplikację tego typu:

    apply plugin: 'war'apply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'dependencies { providedCompile group: 'javax.servlet', name: 'javax.servlet-api', version: '3.1.0'}

  
W pierwszej linijce dodaję rozszerzenie war, dzięki któremu Gradle wie, że jest to aplikacja webowa. Druga linijka dodaje rozszerzenie, które pozwala na wygodne uruchamianie kontenerów aplikacji/serwletów. Dzięki wtyczce gretty w prosty sposób możemy uruchomić taki kontener.

Zachęcam to tego żebyś pobrał kod z [repozytorium](https://github.com/SamouczekProgramisty/Pogodynka) i sam spróbował:

    $ ./gradlew appRun:datavault:prepareInplaceWebAppFolder UP-TO-DATE:datavault:createInplaceWebAppFolder UP-TO-DATE:datavault:compileJava NO-SOURCE:datavault:processResources NO-SOURCE:datavault:classes UP-TO-DATE:datavault:prepareInplaceWebAppClasses UP-TO-DATE:datavault:prepareInplaceWebApp UP-TO-DATE:datavault:appRun18:48:10 INFO Jetty 9.2.15.v20160210 started and listening on port 808018:48:10 INFO datavault runs at:18:48:10 INFO http://localhost:8080/datavaultPress any key to stop the server.> Building 87% > :datavault:appRun

  
Następnie otworzenie w przeglądarce adresu http://localhost:8080/datavault powinno zadziałać :).
# Podsumowanie
  
Powoli, ale skutecznie idę do przodu :). Jeden z modułów jest gotowy, pozostałe dwa czekają na swoją kolej. Datavautl wezmę na tapetę w kolejnych tygodniach. Na dzisiaj to wszystko z frontu, do następnego razu! :)

[FM\_form id="3"]

