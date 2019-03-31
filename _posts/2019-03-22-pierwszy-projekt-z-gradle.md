---
title: Pierwszy projekt z Gradle
last_modified_at: 2019-03-28 01:30:16 +0100
categories:
- Programista rzemieślnik
permalink: /pierwszy-projekt-z-gradle/
header:
    teaser: /assets/images/2019/03/22_gradle_artykul.jpeg
    overlay_image: /assets/images/2019/03/22_gradle_artykul.jpeg
    caption: "[&copy; David Clode](https://unsplash.com/photos/Bj0XFTabquo)"
excerpt: W tym artykule przeczytasz o tym jak działa Gradle. Dowiesz się czegoś więcej o sposobie konfigurowania projektów. Po lekturze będziesz wiedzieć czym jest i jak działa gradle wrapper oraz dlaczego warto go używać. Przeczytasz także o tym jak używać Gradle z systemem kontroli wersji.
---

To jest kolejny artykuł opisujący narzędzie Gradle. Jeśli nie udało Ci się wcześniej z nim pracować, to zachęcam Cię do przeczytania [wstępu do Gradle]({% post_url 2017-01-19-wstep-do-gradle %}). W tym artykule zakładam, że znasz podstawy, które omówiłem poprzednio.
{:.notice--info}

## Odrobina teorii

Gradle bazuje na plikach konfiguracyjnych. Każdy z tych plików konfiguracyjnych powiązany jest z obiektem, który jest tworzony w trakcie inicjalizacji procesu budowania. Na przykład plik `build.gradle` powiązany jest z instancją klasy [`Project`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html) a plik `settings.gradle` z instancją klasy [`Settings`](https://docs.gradle.org/current/dsl/org.gradle.api.initialization.Settings.html).

Konfiguracja używająca DSL zawarta w tych plikach odpowiednio konfiguruje instancje tych obiektów.

### Cykl budowania projektu

Gradle jasno określa sposób w jaki budowany jest projekt. Cały proces podzielony jest na trzy fazy:

* inicjalizację,
* konfigurację,
* wykonanie.

W trakcie fazy inicjalizacji Gradle określa jakie projekty wchodzą w skład cyklu budowania. Gradle wspiera proste projekty (składające się wyłącznie z jednego projektu) jak i te złożone (składające się z wielu podprojektów). Jak wspomniałem wcześniej, dla każdego z nich tworzy obiekt, który przechowuje konfigurację danego projektu. W tej fazie wykonywany jest plik `settings.gradle`.

Faza konfiguracji polega na wykonaniu każdego z plików konfiguracyjnych projektów wchodzących w skład procesu budowania. W wyniku tego wykonania obiekty utworzone w fazie inicjalizacji są odpowiednio konfigurowane (na podstawie wykonywanych plików `build.gradle`).

Ostatnią fazą jest faza wykonania. To właśnie tutaj Gradle określa zestaw wymaganych zadań do wykonania wraz z ich kolejnością. Zadania pochodzą z obiektów skonfigurowanych w poprzednim kroku.

### Wbudowana pomoc

Gradle posiada wbudowaną dokumentację. Możesz się do niej dobrać używając linii poleceń. Pierwszym przydatnym poleceniem może być:

```bash
$ gradle tasks
```

To polecenie wypisze wszystkie możliwe do wykonania zadania, które zawarte są w konfiguracji lub dostarczone są przez wtyczki.

Jeśli chcesz dowiedzieć się czegoś więcej o którymkolwiek z zadań z pomocą przychodzi `gradle help`. Na przykład do dokumentacji zadania `init` możesz dobrać się wywołując polecenie:

```bash
$ gradle help --task init
```

### Schowek (ang. _cache_)

[Z poprzedniego artykułu]({% post_url 2017-01-19-wstep-do-gradle %}#zarz%C4%85dzanie-zale%C5%BCno%C5%9Bciami) wiesz, że Gradle pomaga przy zarządzaniu zależnościami. Odpowiednia konfiguracja pozwala na określenie jakie zależności są niezbędne do działania Twojej biblioteki czy aplikacji. Dodatkowym atutem zarządzania zależnościami przez Gradle jest to, że trzymane one są w schowku na Twoim dysku. Domyślnie znajdziesz je w katalogu `~/.gradle/caches`[^cachewin].

Wewnątrz tego katalogu znajdziesz zależności, które były pobrane przez Gradle. Dzięki takiemu podejściu zależności są współdzielone pomiędzy różnymi aplikacjami. Co więcej nie musisz ich za każdym razem ściągać – zanim Gradle zacznie ich szukać w repozytorium zajrzy do schowka na lokalnym dysku.

[^cachewin]: W systemie Windows jest to ścieżka `%userprofile%/gradle/caches`.

## Nowy projekt z Gradle

Praktyczną przygodę z Gradle zacznę od utworzenia przykładowej konfiguracji. Do przygotowania projektu może posłużyć polecenie `gradle init`. Po takim wywołaniu Gradle utworzy odpowiednią strukturę przygotowując podstawową konfigurację. Zanim do tego dojdzie zapyta Cię o kilka ustawień:

```bash
$ gradle init

Select type of project to generate:
  1: basic
  2: cpp-application
  3: cpp-library
  4: groovy-application
  5: groovy-library
  6: java-application
  7: java-library
  8: kotlin-application
  9: kotlin-library
  10: scala-library
Enter selection (default: basic) [1..10] 7

Select build script DSL:
  1: groovy
  2: kotlin
Enter selection (default: groovy) [1..2] 1

Select test framework:
  1: junit
  2: testng
  3: spock
Enter selection (default: junit) [1..3] 1

Project name (default: samouczek):
Source package (default: samouczek): pl.samouczekprogramisty

BUILD SUCCESSFUL in 24s
2 actionable tasks: 2 executed
```

Pierwsze pytanie dotyczy typu generowanego projektu. W tym przypadku projekt będzie używał języka Java, więc biorę pod uwagę odpowiedzi 6 albo 7. Główna różnica pomiędzy biblioteką a aplikacją sprowadza się do tego, że aplikację można uruchomić samodzielnie, biblioteka włączana jest do innych bibliotek lub aplikacji. Konfiguracja biblioteki i aplikacji różni się jedynie wtyczkami. W przykładach, które pokazuję w dalszej części te różnice nie są istotne.

Kolejne pytanie dotyczy DSL'a (ang. _Domain Specific Language_), który powinien być używany w konfiguracji. Od wersji [5.0](https://docs.gradle.org/5.0/release-notes.html#kotlin-dsl-1.0) Gradle jako DSL można także wybrać język Kotlin.

Następne pytanie dotyczy biblioteki użytej do [testów]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}). Ma to wpływ na wygenerowany przykładowy kod i konfigurację.

Ostatnie dwa pytania dotyczą nazwy projektu i nazwy pakietu (domyślnie jest to nazwa katalogu w którym wykonano polecenie `gradle init`).

Po udzieleniu odpowiedzi na taki zestaw pytań Gradle przygotuje szkielet projektu wraz z przykładową konfiguracją:

```bash
$ tree .
.
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── settings.gradle
└── src
    ├── main
    │   ├── java
    │   │   └── pl
    │   │       └── samouczekprogramisty
    │   │           └── Library.java
    │   └── resources
    └── test
        ├── java
        │   └── pl
        │       └── samouczekprogramisty
        │           └── LibraryTest.java
        └── resources

13 directories, 8 files
```

Teraz omówię poszczególne elementy wygenerowane przez `gradle init`.

{% include newsletter-srodek.md %}

### `settings.gradle`

Plik `settings.gradle` zawiera konfigurację projektu. Po pominięciu komentarza znajduje się w nim tylko nazwa projektu określona w trakcie działania `gradle init`:

```groovy
rootProject.name = 'samouczek'
```

Plik ten może jednak zawierać dużo więcej elementów. Wszystkie z nich znajdziesz w [oficjalnej dokumentacji](https://docs.gradle.org/current/dsl/org.gradle.api.initialization.Settings.html#org.gradle.api.initialization.Settings). Trochę więcej o tym pliku przeczytasz w dalszej części artykułu, kiedy będę opisywał budowanie zagnieżdżonych projektów.

### `build.gradle`

Sercem projektu jest plik `build.gradle`[^dowolna]. Wygenerowany plik, z pominięciem komentarzy, wygląda następująco:

[^dowolna]: Po odpowiedniej konfiguracji albo sposobie uruchomienia `gradle` nazwa tego pliku może być inna, `build.gradle` jest wartością domyślną.

```groovy
plugins {
    id 'java-library'
}

repositories {
    jcenter()
}

dependencies {
    api 'org.apache.commons:commons-math3:3.6.1'
    implementation 'com.google.guava:guava:27.0.1-jre'
    testImplementation 'junit:junit:4.12'
}
```

Plik ten zawiera trzy bloki wewnątrz których znajduje się konfiguracja.

Pierwszy blok [`plugins`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:plugins) zawiera wtyczkę [`java-library`](https://docs.gradle.org/current/userguide/java_library_plugin.html). W bloku [`repositories`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:repositories(groovy.lang.Closure)) dodawane jest repozytorium [jcenter](https://jcenter.bintray.com/). Ostatni blok [`dependencies`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:dependencies(groovy.lang.Closure)) zawiera zestaw przykładowych zależności.

W dużej części projektów to właśnie te trzy bloki będą stanowiły większość konfiguracji. W bardziej zaawansowanych przypadkach odsyłam Cię do [dokumentacji](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html).

### wrapper

Standardowa struktura projektu pozwala na łatwe zorientowanie się w nowym projekcie informatycznym. Zarządzanie zależnościami pozwala na przygotowanie wszędzie takiej samej paczki programu[^pomijam]. Wszystko to dzięki plikowi wykonywalnemu `gradle`. Ten plik jest tak naprawdę skryptem, który opakowuje uruchomienie maszyny wirtualnej Javy. Zachęcam Cię do zajrzenia do środka tego pliku. W przypadku systemów z rodziny Linux możesz spodziewać się skryptu [`bash`]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}).

[^pomijam]: Pomijam skrajne sytuacje, w których ktoś może zmodyfikować swoje lokalne środowisko w sposób, który pozwoli zbudować coś innego. Jednak taka sytuacja wymaga świadomego działa :).

Ten skrypt różni się pomiędzy różnymi wersjami Gradle. Co więcej Gradle także ewoluuje, DSL używany w różnych wersjach może nie być ze sobą kompatybilny. Może to prowadzić do sytuacji, w której wersja Gradle zainstalowana na Twoim komputerze nie będzie w stanie zbudować projektu, który przygotowany był przy pomocy innej wersji Gradle.

Jest jednak proste rozwiązanie tego problemu. Tym rozwiązaniem jest Gradle wrapper. Jest on domyślnie tworzony po wywołaniu `gradle init`. Można to także utworzyć samodzielnie w już istniejącym projekcie:

```bash
$ gradle wrapper --console=verbose
> Task :wrapper

BUILD SUCCESSFUL in 0s
1 actionable task: 1 executed
```

Efektem działania tego zadania jest utworzenie dwóch katalogów i kilku plików[^ukryty]:

[^ukryty]: To wywołanie tworzy też ukryty katalog `.gradle`.

```bash
$ tree .
.
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
└── gradlew.bat

2 directories, 4 files
```

Warto zwrócić uwagę na zwartość pliku `gradle/wrapper/gradle-wrapper.properties`:

```bash
$ cat gradle/wrapper/gradle-wrapper.properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-5.3-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
```

Jedno z ustawień – `distributionUrl` pokazuje wersję, która powinna być uruchomiona. Co jeśli ktoś inny na swoim komputerze nie będzie miał wersji, na którą wskazuje plik konfiguracyjny? `gradlew` ściągnie odpowiednią wersję i zapisze ją w katalogu domowym użytkownika:

```bash
$ ls -lA ~/.gradle/
total 12
drwxr-xr-x 5 marcinek marcinek 4096 mar 22 18:34 5.2.1
drwxr-xr-x 5 marcinek marcinek 4096 mar 22 18:49 5.3
drwxr-xr-x 2 marcinek marcinek 4096 mar 22 18:49 buildOutputCleanup
```

Od tego momentu zamiast `gradle` używaj `gradlew`, który będzie dostępny w Twoim repozytorium.

Proszę zobacz czym różnią się między sobą `gradlew` i `gradle`. Dla czytelności zostawiłem najbardziej istotne fragmenty generowane przez program `diff`:

```
$ diff -u ./gradlew /usr/local/bin/gradle
--- ./gradlew	2019-03-22 18:34:35.244396273 +0100
+++ /usr/local/bin/gradle	2019-02-08 20:01:44.000000000 +0100

-CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar
+CLASSPATH=$APP_HOME/lib/gradle-launcher-5.2.1.jar

-eval set -- $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS "\"-Dorg.gradle.appname=$APP_BASE_NAME\"" -classpath "\"$CLASSPATH\"" org.gradle.wrapper.GradleWrapperMain "$APP_ARGS"
+eval set -- $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS "\"-Dorg.gradle.appname=$APP_BASE_NAME\"" -classpath "\"$CLASSPATH\"" org.gradle.launcher.GradleMain "$APP_ARGS"
```

Linijki zaczynające się od `-` są w `gradlew`, te z `+` na początku są w standardowym skrypcie `gradle`. Jak widzisz różnic jest niewiele. Polegają one wyłącznie na tym, że uruchomienie `gradlew` korzysta z `gradlew-wrapper.jar` i używa innej klasy z metodą main `org.gradle.wrapper.GradleWrapperMain`.

Używanie `gradlew` pozwala na uniezależnienie się od wersji `gradle` zainstalowanej na komputerze programisty.

## Budowanie projektów

Używając `gradlew tasks` i `gradlew help` dowiesz się sporo o możliwych zadaniach do wykonania. Chciałbym zwrócić Twoją uwagę na dwa z nich: `build` i `test`.

Poniżej widzisz wywołanie zadania `build` z przełącznikiem `--console=verbose`, który sprawia, że na konsoli pokazuje się trochę więcej informacji:

```bash
$ ./gradlew build --console=verbose
> Task :compileJava UP-TO-DATE
> Task :processResources NO-SOURCE
> Task :classes UP-TO-DATE
> Task :jar UP-TO-DATE
> Task :assemble UP-TO-DATE
> Task :compileTestJava UP-TO-DATE
> Task :processTestResources NO-SOURCE
> Task :testClasses UP-TO-DATE
> Task :test UP-TO-DATE
> Task :check UP-TO-DATE
> Task :build UP-TO-DATE

BUILD SUCCESSFUL in 0s
4 actionable tasks: 4 up-to-date
```

Wiesz już, że Gradle uruchamia wszystkie zależne zadania. Ten przykład doskonale to pokazuje. Poprosiłem o wywołanie `build` a w efekcie została wykonana cała seria zadań, zaczynając od `compileJava` a na `build` kończąc. Niektóre z tych zadań generują tak zwane artefakty – efekty procesu budowania.

Na przykład artefaktem zadania `compileJava` są pliki `.class` ze skompilowanymi klasami. Artefakty procesu budowania umieszczane są w katalogu `build`. Poniżej możesz zobaczyć część struktury tego katalogu:

```bash
$ tree build
build
├── classes
│   └── java
│       ├── main
│       │   └── pl
│       │       └── samouczekprogramisty
│       │           └── Library.class
│       └── test
│           └── pl
│               └── samouczekprogramisty
│                   └── LibraryTest.class
...
├── libs
│   └── samouczek.jar
├── reports
│   └── tests
│       └── test
│           ├── classes
│           │   └── pl.samouczekprogramisty.LibraryTest.html
│           ├── css
│           │   ├── base-style.css
│           │   └── style.css
│           ├── index.html
│           ├── js
│           │   └── report.js
│           └── packages
│               └── pl.samouczekprogramisty.html
...

29 directories, 14 files
```

Drzewko powyżej pokazuje między innymi katalogi `build/classes`, `build/libs` i `build/reports`. Pierwszy z nich zawiera skompilowane klasy. Drugi plik `jar` (utworzony przez zadanie `jar`). Zwróć też uwagę na ostatni katalog. Ten katalog powstaje po wykonaniu zadania `test`. Zawiera on raporty z testów automatycznych uruchomionych w trakcie budowania projektu:

{% include figure class="c_img_with_auto" image_path="/assets/images/2019/03/28_gradle_test_report.gif" caption="Przykładowy raport testów wygenerowany przez Gradle'a" %}

Wielką zaletą narzędzi typu Gradle jest to, że potrafią automatycznie uruchamiać takie testy w trakcie budowania.

### Budowanie złożonych projektów

Gradle świetnie sprawdza się do budowania projektów, które zawierają podprojekty. Jako przykład może tu posłużyć [Kurs Java](https://github.com/SamouczekProgramisty/KursJava/) czy [Kurs Aplikacji Webowych](https://github.com/SamouczekProgramisty/KursAplikacjeWebowe/).

W każdym z tych repozytoriów znajdziesz plik `settings.gradle`. W przypadku pojedynczego projektu ten plik jest opcjonalny. W przypadku projektów zawierający podprojekty plik `settings.gradle` jest wymagany. W tym drugim przypadku zawiera on ścieżki wskazujące na zagnieżdżone projekty. Fragment takiego pliku może wyglądać następująco:

```groovy
rootProject.name = 'KursAplikacjeWebowe'

include '01_serwlety'
include '02_serwlety'
include '03_filtry'
include '04_kontekst'
```

#### Konfiguracja podprojektów

Każdy z projektów zagnieżdżonych może zawierać swój własny plik konfiguracyjny `build.gradle`. Jednak nie zawsze jest to najlepszy pomysł. Często żeby wyeliminować duplikację wspólna konfiguracja wyciągnięta jest do głównego projektu. Służy do tego blok `subprojects`. Jego przykład możesz znaleźć w pliku [`build.gradle` w Kursie Java](https://github.com/SamouczekProgramisty/KursJava/blob/master/build.gradle):

```groovy
subprojects {
    apply plugin: 'java'
    apply plugin: 'idea'
    apply plugin: 'maven'

    repositories {
        mavenCentral()
    }

    group = 'pl.samouczekprogramisty.kursjava'
    version = '1.0-SNAPSHOT'

    gradle.projectsEvaluated {
        tasks.withType(JavaCompile) {
            options.compilerArgs << "-Xlint:deprecation"
        }
    }
}
```

W tym przykładzie każdy z podprojektów będzie zawierał trzy wtyczki, będzie korzystał z repozytorium `mavenCentral`. Będzie miał ustawiony atrybuty [`group`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:group) i [`version`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:version).

Ostatni blok używa mechanizmu rozszerzeń Gradle. W ten sposób dołączam pewną akcję po wystąpieniu zdarzenia [`projectsEvaluated`](https://docs.gradle.org/current/dsl/org.gradle.api.invocation.Gradle.html#org.gradle.api.invocation.Gradle:projectsEvaluated(groovy.lang.Closure)). W tym przypadku dodaję do [kompilatora `javac`]({% post_url 2017-03-08-java-z-linii-polecen %}) flagę `-Xling:deprecation`, która włącza ostrzeżenia dotyczące używania przestarzałego API.

Niektóre podprojekty nie potrzebują dodatkowej konfiguracji. W takim przypadku nie mają własnego pliku `build.gradle`. W innych przypadkach `build.gradle` rozszerza konfigurację zawartą w bloku [`subprojects`](https://docs.gradle.org/current/dsl/org.gradle.api.Project.html#org.gradle.api.Project:subprojects(groovy.lang.Closure)).

## Gradle a repozytorium kodu

Jeśli korzystasz z systemu kontroli wersji część plików związanych z Gradle powinna być w nim zawarta. Jeśli nie korzystasz, to najwyższy czas zacząć ;) – zapraszam Cię do [kursu Git'a]({{ '/kurs-git/' | absolute_url }}). Katalog `gradle`, pliki `gradlew`,  `gradlew.bat` wraz z wszystkimi plikami konfiguracyjnymi powinny zostać dodane do systemu kontroli wersji.

Natomiast ukryty katalog `.gradle` powinien zostać pominięty. Sprawa wygląda podobnie z wszystkimi artefaktami powstałymi w wyniku budowania projektu. Z założenia mogą one być w prosty sposób odtworzone na podstawie plików źródłowych. Innymi słowy zawartość katalogu `build` nie powinna wylądować w repozytorium kodu.

## Dodatkowe materiały do nauki

W artykule wielokrotnie odwoływałem się do dokumentacji Gradle. Nie bez powodu. Moim zdaniem dokumentacja Gradle'a jest na prawdę przydatnym źródłem wiedzy: 

* [dokumentacja Gradle'a](htps://docs.gradle.org/current/userguide/userguide.html),
* dodatkowo na stronie Gradle'a znajdziesz serię dobrze przygotowanych [poradników](https://gradle.org/guides/).

## Ćwiczenie do wykonania

Na koniec mam dla Ciebie drobne ćwiczenie. Spróbuj utworzyć nowy projekt wywołując `gradle init` z dodatkowymi parametrami opisanymi w dokumentacji. Czy dasz radę napisać polecenie, które utworzy nowy projekt i pominie wszystkie pytania, które Gradle zadaje po wywołaniu `gradle init`?

## Podsumowanie

Po przeczytaniu tego artykułu wiesz jak działa Gradle. Znasz elementy DSL pozwalające na budowanie nieskomplikowanych skryptów budowania. Udało Ci się poznać szereg komend Gradle'a, które pomogą Ci w efektywny sposób pracować z tym narzędziem.

Na koniec mam do Ciebie prośbę, proszę poleć ten artykuł znajomym, którym Twoim zdaniem może się on przydać. Dzięki temu pozwolisz dotrzeć mi do większego grona odbiorców, z góry dziękuję!

Jeśli nie chcesz ominąć kolejnych artykułów na Samouczku dopisz się do samouczkowego newslettera i polub Stronę samouczka na Facebook'u. To tyle na dzisiaj, trzymaj się i do następnego razu!
