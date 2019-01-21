---
title: Projekt Informator wdrożenie w chmurze
last_modified_at: 2018-06-20 20:57:35 +0200
categories:
- Projekty
- Projekt Informator
permalink: /projekt-informator-wdrozenie-w-chmurze/
header:
    teaser: /assets/images/2018/04/03_projekt_informator_wdrozenie_w_chmurze.jpg
    overlay_image: /assets/images/2018/04/03_projekt_informator_wdrozenie_w_chmurze.jpg
    caption: "[&copy; befuddledsenses](https://www.flickr.com/photos/befuddledsenses/16378019525/sizes/l)"
excerpt: Artykuł ten szczegółowo opisuje sposób wdrożenia aplikacji opartej o Spring i Hibernate w chmurze. W przykładzie używam bazy danych Postgresql i uruchamiam aplikację na Heroku.
---

## Projekt Informator

Projekt informator to REST'owy web service, działający w oparciu o Spring i Hibernate. Jeśli chcesz przeczytać więcej o projekcie i jego założeniach zapraszam do [wprowadzenia]({% post_url 2018-03-20-projekt-informator-wprowadzenie %}).

{% include wspolpraca-infoshare-2018.md %}

## Czym jest chmura

W uproszczeniu można powiedzieć, że chmura to środowisko, w którym uruchamia się aplikacje. Chmura to zestaw dużej liczby maszyn, które można "wynająć" na potrzeby swoich aplikacji.

W takim środowisku dostawca zapewnia mechanizmy administrowania maszynami i aplikacjami, które są na nich wdrażane (ang. _deployed_). We wszystkich znanych mi chmurach dostawca pobiera opłaty za wykorzystywane zasoby. To znaczy, że jeśli nasza aplikacja potrzebuje większej liczby maszyn/mocniejszych maszyn, wówczas dostaniemy większy rachunek do zapłacenia.

Dostawcy "rozwiązań chmurowych" oferują różne usługi. W przypadku Informatora używał będę wyłącznie podstawowych maszyn. Dodatkowo aplikacja korzystała będzie z bazy danych udostępnionej w chmurze.

## Dostawca rozwiązań chmurowych

W przypadku Informatora, zależało mi wyłącznie na cenie. Chciałem, żeby do moich zastosowań chmura była darmowa :). Jednym z dostawców, który udostępnia maszyny za darmo[^ograniczenia] jest Heroku.

[^ograniczenia]: Oczywiście są tu ograniczenia, firma też musi na czymś zarabiać ;).

Oczywiście istnieją też inni dostawcy. Najwięksi z nich to:
* Google Cloud Platform,
* Amazon Web Services[^heroku],
* Microsoft Azure Cloud Computing Platform.

[^heroku]: Tak właściwie to Heroku używa AWS do oferowania swoich usług.

## Informator - stan projektu

Aplikacja używa najnowszych wersji biblioteki Spring MVC i Hibernate. W trakcie pisania tego artykułu najnowszymi wersjami były:

- Spring 5.0.4
- Hibernate 5.2.16

[Aktualnie](https://github.com/SamouczekProgramisty/Informator/commit/06041e2633fc494b4c1437adcc250b8faa90447a) aplikacja to wyłącznie szkielet, który pozwala na pobranie encji z bazy danych i wyświetlenie jej w formacie JSON w odpowiedzi. Zachęcam do sprawdzenia źródeł projektu, pozwolą one zobaczyć przykładową konfigurację bez użycia Spring Boot.

Obecnie aplikacja zawiera jeden endpoint `/speakers`, który pozwala na pobranie informacji o prelegencie [na podstawie identyfikatora](https://github.com/SamouczekProgramisty/Informator/blob/master/src/main/java/pl/samouczekprogramisty/informator/controller/SpeakerController.java). Aby aplikacja mogła pobrać dane z bazy muszą one być do niej wrzucone ręcznie. Na potrzeby testów utworzyłem kilka wierszy w tabeli uzupełniając je przykładowymi danymi:

{% include figure image_path="/assets/images/2018/04/03_sample_request.png" caption="Przykładowe zapytanie do Informatora" %}

## Heroku

Nigdy wcześniej nie wdrażałem aplikacji w Javie na Heroku i muszę powiedzieć, że dostawca ten przygotował bardzo dobrą dokumentację. Poniżej postaram się pokazać jak wygląda proces instalacji aplikacji krok po kroku.

Jak wspomniałem wcześniej, Informator to projekt "hobbystyczny". W związku z tym, używam wyłącznie darmowe usługi Heroku. Na pewno nie sprawdziłyby się one w przypadku produkcyjnych aplikacji.

### Wdrożenie aplikacji na Heroku

Cały proces należy zacząć od utworzenia konta na Heroku. Następnie można dodawać nowe aplikacje:


{% include figure image_path="/assets/images/2018/04/03_heroku_new_app_monit.png" caption="Dodawanie nowej aplikacji w Heroku" %}
{% include figure image_path="/assets/images/2018/04/03_heroku_new_app.png" caption="Nazwanie nowej aplikacji" %}

Następnie w zakładce _Resources_ należy dodać komponent bazy danych. W przypadku Informatora jest to [PostgreSQL](https://www.postgresql.org/).

{% include figure image_path="/assets/images/2018/04/03_heroku_postgres.png" caption="Aktywacja PostgreSQL na Heroku" %}

Zdecydowałem się na instalowanie aplikacji prosto z [GitHub'a](https://github.com/SamouczekProgramisty/Informator). Heroku domyślnie pozwala na taką integrację. Wymaga to zezwolenia na GitHub'ie do pobierania informacji o repozytoriach przez Heroku:

{% include figure image_path="/assets/images/2018/04/03_heroku_connect_to_git.png" caption="Połączenie Heroku z GitHub'em" %}

Sam proces instalacji aplikacji sprowadza się do naciśnięcia przycisku _Deploy Branch_. Wówczas Heroku pobiera aktualną wersję kodu i próbuje go uruchomić. Aby projekt mógł być uruchomiony na Heroku musi być odpowiednio przygotowany. O tym przygotowaniu przeczytasz w jednym z punktów poniżej:
{% include figure image_path="/assets/images/2018/04/03_heroku_deploy_from_branch.png" caption="Instalacja z gałęzi Git'a" %}

### Przygotowanie aplikacji do Heroku

#### Gradle

Do budowania Informatora używam [Gradle]({% post_url 2017-01-19-wstep-do-gradle %}). W przypadku tego projektu użyłem także [webapp-runner](https://github.com/jsimone/webapp-runner). Dzięki tej bibliotece można uruchomić aplikację przy pomocy komendy `java -jar webapp-runner.jar Informator.war`. Właśnie ta komenda uruchamiana jest przez Heroku.

Heroku w trakcie instalowania aplikacji[^uproszczenie] wywołuje zadanie `stage`. Definicja tego zadania w `build.gradle` wygląda następująco:

[^uproszczenie]: Dokładny sposób uruchamiania zależy m.in. od narzędzia użytego do budowania projektu.

```groovy
task stage() {
    dependsOn clean, war
}
war.mustRunAfter clean

task copyToLib(type: Copy) {
    into "$buildDir/server"
    from(configurations.compile) {
        include "webapp-runner*"
    }
}

stage.dependsOn(copyToLib)

tasks.stage.doLast() {
    delete fileTree(dir: "build/distributions")
    delete fileTree(dir: "build/assetCompile")
    delete fileTree(dir: "build/distributions")
    delete fileTree(dir: "build/libs", exclude: "*.war")
}
```

[Konfiguracja](https://github.com/SamouczekProgramisty/Informator/blob/master/build.gradle) ta zapewnia, że plik `webapp-runner.jar` będzie znajdował się w katalogu `build/server`. Dodatkowo każde uruchomienie `stage` zapewni zbudowanie pliku war na nowo. Aby biblioteka `webapp-runner` była dostępna trzeba dodać ją do zależności:

```groovy
dependencies {
    compile 'com.github.jsimone:webapp-runner:8.5.29.0'
}
```

#### Plik `Procfile`

[Procfile](https://devcenter.heroku.com/articles/procfile) to plik konfiguracyjny wymagany przez Heroku. Wewnątrz tego pliku znajdują się komendy, które określają jak mają zachować się maszyny w trakcie instalowania aplikacji. Heroku działa w oparciu o tak zwane kontenery nazywane "dynosami". Plik Procfile pokazuje komendy jakie mają być uruchomione na poszczególnych kontenerach.

Dla przykładu, kontener odpowiedzialny za serwer [HTTP]({% post_url 2018-02-08-protokol-http %}) uruchamia następujące polecenie: 

    cd build ; java -jar server/webapp-runner-*.jar --expand-war --port $PORT libs/*.war

Polecenie to wywoływane jest po uruchomieniu zadania `stage`, które opisałem wcześniej. Dzięki tej kolejności na "dynosie" zbudowana jest aplikacja, którą można uruchomić przy użyciu wspomnianego wyżej webapp-runner'a.


#### Połączenie z bazą danych

Heroku dynamiczne tworzy bazy danych. Informacja gdzie dokładnie ta baza danych się znajduje przechowywana jest w zmiennej środowiskowej. Zmienna środowiskowa, która zawiera URL do bazy danych nazywa się `JDBC_DATABASE_URL`[^kilka]. Zmienna ta powinna być użyta do utworzenia instancji `DataSource`:

```java
@Bean
DataSource dataSource() {
    DriverManagerDataSource dataSource = new DriverManagerDataSource();
    dataSource.setDriverClassName("org.postgresql.Driver");
    dataSource.setUrl(System.getenv("JDBC_DATABASE_URL"));

    return dataSource;
}
```

[^kilka]: W zależności od sposobu łączenia się z bazą danych można użyć jednej z kilku zmiennych, na przykład `DATABASE_URL` czy `SPRING_DATASOURCE_URL`.

# Podsumowanie

Aktualnie aplikacja to szkielet, na którym będę dobudowywał kolejne funkcjonalności. Główny etap konfiguracji jest już ukończony. Po przeczytaniu tego artykułu i przejrzeniu kodu źródłowego wiesz w jaki sposób zainstalować aplikację opartą o Spring MVC i Hibernate na Heroku. Jeśli nie robiłeś tego nigdy wcześniej zachęcam do samodzielnych prób, wtedy nauczysz się najwięcej.

Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku proszę dopisz się do samouczkowego newslettera i polub Samouczka na Facebooku. Proszę podziel się linkiem do artykułu ze znajomymi, którym może on pomóc. Może to dzięki Tobie uda mi się dotrzeć do nowych czytelników? ;)

Do następnego razu!
