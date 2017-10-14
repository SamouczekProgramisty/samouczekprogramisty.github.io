---
layout: single
title: Wstęp do Gradle
date: '2017-01-19 21:21:55 +0100'
categories:
- Programista rzemieślnik
excerpt_separator: "<!--more-->"
permalink: "/wstep-do-gradle/"
---
W tym artykule dowiesz się czym jest Gradle. Poznasz kilka konwencji używanych w większych projektach programistycznych. Przeczytasz o podstawach DSL używanego w pliku build.gradle. Utworzysz też swój pierwszy projekt z gradle w InteliJ IDEA. Zapraszam do lektury.

# Czym jest Gradle
  
Starając się opisać Gradle jednym zdaniem powiedziałbym, że Gradle jest narzędziem służącym do budowania projektów[^gradle]. Pozwala ono na zautomatyzowanie tego procesu. Używa się do tego tak zwanego języka domenowego - DSL (ang. _Domain Specific Language_), który ułatwia wykonywanie standardowych zadań związanych z budowaniem projektu.

[^gradle]: Oczywiście z racji swoje elastyczności Gradle może być użyte także w wielu innych przypadkach, jednak to budowanie projektów jest tym "standardowym".

Jeśli do tej pory miałeś styczność wyłącznie z niezbyt dużymi projektami, nad którymi pracowałeś samodzielnie prawdopodobnie nie odczuwałeś potrzeby używania narzędzi tego typu. Jednak przy większych projektach narzędzie, które pozwala na zautomatyzowanie tego procesu jest bardzo pomocne.

# Inne narzędzia do budowania projektów
  
Oczywiście Gradle nie jest jedynym narzędziem, które pomaga przy budowaniu projektów. Wymienić tu trzeba byłoby kilka innych jak [Ant](http://ant.apache.org/), [Maven](https://maven.apache.org/), [Ivy](http://ant.apache.org/ivy/), [Make](https://www.gnu.org/software/make/) czy [Buildr](https://buildr.apache.org/). Oczywiście nie jest to kompletna lista.

Dodatkowo „problem budowania” projektu występuje w każdym języku programowania, więc analogiczne narzędzia występują także dla innych języków.

# Instalacja gradle
  
Gradle sam w sobie jest programem, abyś mógł go używać musisz „zainstalować” go na swoim komputerze. Najnowszą wersję Gradle możesz ściągnąć z [tej strony](https://gradle.org/gradle-download/). Następnie rozpakuj ściągnięty plik, ustaw zmienną środowiskową `GRALE_HOME`, która będzie wskazywała na katalog, w którym rozpakowałeś wcześniej ściągniętą paczkę.

Następnie zmodyfikuj zmienną `PATH` (linux/macos) lub `Path` (windows), tak żeby zawierała katalog `bin` znajdujący się wewnątrz wcześniej ustawionego `GRADLE_HOME`.

[Tutaj](https://www.youtube.com/watch?v=QtmuSBVF8Nw) znajdziesz krótki filmik, pokazujący jak zmodyfikować zmienną `Path` w systemie Windows, w podobny sposób możesz dodać zmienną `GRADLE_HOME`.

Po takim zestawie ustawień i ponownym uruchomieniu terminala powinieneś móc wywołać polecenie `gradle --version`, które wypisze na konsolę informacje o Twojej wersji Gradle.

# W czym może pomóc Gradle
  
Jak wspomniałem wcześniej Gradle służy do budowania projektów. Pod pojęciem „budowania projektów” tak naprawdę kryje się cała masa drobnych czynności. Zaczynając od najbardziej podstawowych, takich jak kompilowanie kodu źródłowego czy tworzenie pliku ze skompilowanymi klasami, na przykład pliku JAR (ang. _Java Archive_)[^jar].

[^jar]: Programy, które napiszemy pakowane są w paczki, tego typu paczki używane są do uruchamiania programów w środowisku produkcyjnym.

Jednak to nie koniec, dobrze byłoby uruchomić wszystkie testy, które sprawdzają poprawność działania kodu przed utworzeniem pliku JAR. W tym także pomoże Ci Gradle. Gradle pomoże też przy zarządzaniu zależnościami projektu.

## Zarządzanie zależnościami
  
Większe projekty bazują na zewnętrznych bibliotekach. Przykładem takich zewnętrznych bibliotek jest na przykład Hibernate, Spring czy Guava.

Zewnętrzne biblioteki dostępne są jako skompilowane klasy spakowane w pliki JAR. Można je ściągnąć z tak zwanych repozytoriów. Jednym z najczęściej używanych repozytoriów jest [centralne repozytorium Maven’a](https://search.maven.org/).

Tak samo jak Twój projekt może zależeć od innych bibliotek, podobnie może być z tymi bibliotekami, też mogą mieć swoje zależności. Innymi słowy Twój projekt może mieć tak zwane zależności pośrednie/przechodnie. Jeśli Twój projekt wymaga wielu dodatkowych bibliotek, zarządzanie wszystkimi zależnościami (pośrednimi i bezpośrednimi) nie jest takim łatwym zadaniem.

Gradle pobiera zależności, które wskażesz (w odpowiedni sposób), zajmując się także zależnościami pośrednimi.

# Konwencje
  
Programując w Javie (i nie tylko) dobrze jest stosować do pewnych przyjętych konwencji, które możemy spotkać w wielu projektach. Takie podejście pomaga w pracy nad różnymi projektami, wprowadza swego rodzaju „porządek”. Gradle także używa takich konwencji, poniżej opiszę dwie z nich, strukturę katalogów w projekcie i sposób identyfikowania projektu. Pomogą one w zrozumieniu podstaw DSL, które znajdą się w kolejnych akapitach.
## Struktura projektu
  
Przy prostych projektach, nie ma potrzeby używania specjalnej struktury dla projektu. Jednak przy tych bardziej zaawansowanych pewna konwencja ułatwia zrozumienie tego „co w danym projekcie się dzieje”. Gdzie szukać plików z testami, w którym miejscu mogą znajdować się pliki z kodem źródłowym, gdzie może znajdować się plik JAR, który powstał po zbudowaniu projektu. To wszystko można osiągnąć, dzięki pewnej konwencji, która jest powszechnie stosowana w świecie projektów Java.

Proszę spójrz na przykład poniżej, pokazuje on strukturę katalogów w projekcie `01_witaj_swiecie`, który stworzyłem na potrzeby tego artykułu (użyłem tu programu [`tree`](https://linux.die.net/man/1/tree)) do pokazania struktury katalogów):

    $ tree ..├── build.gradle└── src├── main│ ├── java│ │ └── pl│ │ └── samouczekprogramisty│ │ └── Hello.java│ └── resources│ └── log4j.ini└── test├── java│ └── pl│ └── samouczekprogramisty│ └── HelloTest.java└── resources└── log4j.ini

  
Projekt ten zawiera jedną klasę `Hello`, znajdującą się w pakiecie `pl.samouczekprogramisty` i odpowiadający jest test znajdujący się w pliku `HelloTest.java`. Proszę zauważ, że oba te pliki znajdują się w zupełnie różnych katalogach, odpowiednio `src/main/java` i `src/test/java`. Tego typu podejście pozwala na oddzielenie kodu aplikacji od testów.

Na produkcyjnym środowisku nie potrzebujemy testów, potrzebne są wyłącznie klasy, które zapewniają poprawne działanie aplikacji. Taki podział pozwala osiągnąć ten cel w bardzo prosty sposób.

Dodatkowo w tej strukturze znajdują się także katalogi `src/main/resources` i `src/test/resources`, zawierają one odpowiednio konfigurację dla właściwej aplikacji i konfigurację dla testów.

Bezpośrednio w katalogu projektu znajduje się plik `build.gradle`, który zawiera informacje jak budować taki projekt.

## Unikalna identyfikacja projektu
  
Przed powstaniem Gradle do budowania projektu używałem między innymi Maven’a. Wraz z Maven’em używanym na szerszą skalę rozpowszechniło się pewne standardowe nazewnictwo, które pozwala jednoznacznie zidentyfikować projekt. Służy do tego trójka:
- `groupId`,
- `artifactId`,
- `version`.
  
  
Gradle także używa tej trójki, jednak pod troszkę innymi nazwami, są to odpowiednio `group`, `name` i `version`.

`group` to pierwszy identyfikator. Konwencja zakłada, że zaczynał się on będzie od odwróconej domeny, podobnie jak `package` w klasach. Do odwróconej domeny można dołączyć dodatkowe człony, które dokładniej specyfikują „grupę” projektu. W przypadku samouczka może to być `pl.samouczekprogramisty` czy `pl.samouczekprogramisty.kursjava`.

`name` to drugi identyfikator, jest on częścią finalnej nazwy pliku JAR ze skompilowanymi klasami. W przypadku projektu, z przykładami do kursu Java na Samouczku `name` może mieć wartość `examples` czy `code-samples`.

`version` określa wersję projektu. Standardowo wersję określa się przez trójkę liczb oddzielonych kropkami na przykład `1.0.0` czy `5.0.12`. Dodatkowo jeśli jest to wersja „deweloperska” można do niej dołączyć `-SNAPSHOT` uzyskując `1.0.0-SNAPSHOT`.

Finalnie nazwa pliku JAR ze skompilowanymi klasami będzie składała się z `name` i `version` oddzielonych minusem, na przykład `code-samples-1.0.0-SNAPSHOT.jar`, czy `examples-5.0.12.jar`.

# Podstawy Gradle DSL
  
Gradle do działania potrzebuje konfiguracji. Domyślnie konfigurację umieszcza się w pliku `build.gradle`. Wewnątrz tego pliku możemy umieszczać komendy, które następnie zostaną wykonane przez `gradle`. Poniżej pokażę kilka podstawowych konstrukcji dostępnych w DSL dostarczonym przez Gradle.
## Zadania
  
Gradle działa w oparciu o zadania. Wewnątrz nich definiujemy co tak naprawdę gradle powinien zrobić. Na przykład zadaniem może być utworzenie pliku JAR czy uruchomienie testów. Zadania te definiujemy wewnątrz pliku build.gradle. Poniższy przykład pokazuje prosty plik, który zawiera wyłącznie jedno zadanie `buildJar`, wypisujące na konsolę odpowiedni komunikat:

    task buildJar << { println 'now I am building JAR file, in theory'}

  
Jeśli następnie uruchomisz `gradle` poleceniem `gradle -q buildJar` na konsoli pokaże się napis `now I am building JAR file, in theory`. Gratuluję, właśnie uruchomiłeś swój pierwszy plik konfigurujący budowanie projektu, co prawda niewiele on jeszcze robi, ale od czegoś trzeba zacząć :).
## Zależności między zadaniami
  
Gradle pozwala także na wprowadzanie zależności pomiędzy zadaniami. Dzięki temu mechanizmowi możemy określić kolejność, w której zadania powinny być uruchamiane. Na przykład przed zbudowaniem pliku JAR uruchom testy jednostkowe.

Proszę spójrz na przykład poniżej, który rozbudowuje poprzedni fragment:

    task runAllTests << { println 'now I am checking if all tests are passing, in theory'}task buildJar(dependsOn: runAllTests) << { println 'now I am building JAR file, in theory'}

  
Uruchamiając `gradle` poleceniem `gradle -q buildJar` na konsoli pokaże się

    now I am checking if all tests are passing, in theorynow I am building JAR file, in theory

### Program gradle
  
Teraz trochę wyjaśnień, `gradle -q buildJar`, uruchamia zadanie `buildJar` zdefiniowane w pliku `build.gradle`. Przełącznik `-q` (lub `--quiet`) wyłącza część informacji wypisywanych na konsolę. Teraz przeanalizuję wyjście komendy bez tego przełącznika:

    $ gradle buildJar:runAllTestsnow I am checking if all tests are passing, in theory:buildJarnow I am building JAR file, in theoryBUILD SUCCESSFULTotal time: 2.276 secs

  
Jak widzisz, pierwsza linijka zawiera `:runAllTests`, tak `gradle` informuje Cię o uruchomieniu tego właśnie zadania. Następna linijka zawiera odpowiedni komunikat, który wypisywane jest w trakcie uruchomienia zadania `runAllTests`, kolejnym zadaniem jest `buildJar`, także wypisujące komunikat. Zauważ, że Gradle uwzględnił zależności pomiędzy zadaniami – uruchomił `runAllTests` przed `buildJar`, tak jak było to zdefiniowane w `build.gradle`. Ostatnie linijki informują o tym, że proces budowania się powiódł i ile trwał.
## Wtyczki
  
Gradle wspiera tak zwane wtyczki. Zawierają one zestaw gotowych zadań, które możesz uruchamiać. Przykładem takiej wtyczki jest `java`, która zawiera zestaw zadań przydatnych przy projektach. Wtyczki dodajemy w pliku `build.gradle` w następujący sposób:

    apply plugin: ‘java’

  
Załóżmy, że plik `build.gradle` zawiera wyłącznie tę linijkę. Zobacz co zostanie wypisane na konsolę po uruchmieniu `gradle build` (`build` jest jednym z zadań udostępnionych przez wtyczkę):

    $ gradle build:compileJava:processResources:classes:jar:assemble:compileTestJava:processTestResources:testClasses:test UP-TO-DATE:check UP-TO-DATE:buildBUILD SUCCESSFULTotal time: 2.917 secs

  
Widzisz jakie zadania zostały uruchomione? Cała masa ;). Na przykład kompilowanie kodu (`:compileJava`), kompilowania testów (`:compileTestJava`), uruchomienia testów (`:test`) czy budowanie pliku JAR (`:jar`).

Także w tym przypadku widać jak Gradle rozstrzyga zależności pomiędzy zadaniami zdefiniowanymi przez wtyczkę. Mimo tego, że uruchomiłem zadanie `build`, wcześniej uruchomiona została seria zadań, od których zależy `build`.

## Zależności
  
Wspomniałem o tym, że Gradle pomaga w zarządzaniu zależnościami – tym razem chodzi o zależności od innych projektów. Tutaj także z pomocą przychodzi wtyczka `java`.

Pozwala ona na określenie repozytoriów z których powinny być ściągane zależności. Na przykład poniższy fragment poinstruuje gradle aby użył domyślnego repozytorium Maven’a

    repositories { mavenCentral()}

  
Następnie możemy już opisywać zależności jak w przykładzie poniżej.

    dependencies { compile group: 'com.google.guava', name: 'guava', version: '21.0'}

  
Powyższa sekcja mówi, że nasz kod potrzebuje w trakcie kompilacji innej biblioteki. W tym przypadku jest to biblioteka guava w wersji 21.0. Gradle pozwala też na troszkę krótszy zapis. Poniższy przykład da dokładnie ten sam efekt co poprzedni:

    dependencies { compile 'com.google.guava:guava:21.0'}

  
Słówko `compile` w powyższych przykładach mówi o tym, w jakiej sytuacji będziemy potrzebowali tej zależności. Mówimy w tym przypadku o „obszarze” (ang. scope) gdzie dana zależność będzie używana. Na początku wystarczy abyś wiedział, że istnieje wiele takich obszarów, najczęściej używane z nich to `compile` i `testCompile`. Ten drugi określa zależności używane i dostępne wyłącznie w trakcie testów. W bardziej zaawansowanych przypadkach gradle pozwala na tworzenie swoich własnych „obszarów”.

Poniższy przykład pokazuje jak może wyglądać przykładowy plik build.gradle z wieloma zależnościami:

    apply plugin: 'java'repositories { mavenCentral()}dependencies { compile 'com.google.guava:guava:21.0' testCompile 'junit:junit:4.11'}

  
Program gradle pozwala na wypisane wszystkich zależności możesz to zrobić uruchamiając `gradle dependencies`.
## Wiesz, że poznałeś właśnie nowy język?
  
Tak naprawdę, Gradle w pliku konfiguracyjnym do projektu używa języka skryptowego [Groovy](http://www.groovy-lang.org/). Język domenowy, którego używa się w pliku `build.gradle` jest na tyle rozbudowany, że w większości przypadków nie będzie potrzeby używania języka Groovy, jednak pamiętaj o tym, kiedy będziesz chciał zrobić coś nietypowego (na przykład wysłać smsa do siebie jeśli testy nie będą przechodziły, chociaż jak znam życie, ktoś już napisał wtyczkę, która to robi i możesz jej użyć bazując wyłącznie na DSL udostępnionym przez tę wtyczkę). W rzeczywistości sam DSL także jest poprawnym kodem Groovy ;).
# Projekty Gradle w InteliJ Idea
  
IntliJ IDEA domyślnie wspiera projekty budowane przy pomocy Gradle. Poniżej pokazuję sposób w jaki możesz założyć przykładowy projekt. Aby to zrobić wybierz z menu File, New i następnie Project. Pokaże Ci się się następujące okienko.

![Gradle nowy projekt InteliJ](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/01/0_new_project-150x150.png)

Zaznaczasz gradle i klikasz next. Kolejne okienko, to nic innego jak uzupełnienie wcześniej omówionych groupId, artifactId i version, które będą identyfikowały Twój projekt:

![Gradle nowy projekt InteliJ](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/01/1_project_identifiers-150x150.png)

Kolejne okienko daje InteliJ informacje jak ma się zachować w przypadku tworzenia projektu, na przykład tutaj podajesz informację, gdzie zainstalowany jest Gradle na Twoim komputerze. Istotne jest abyś zaznaczył drugą opcję, która spowoduje utworzenie struktury projektu zgodnie z opisaną wcześniej konwencją.

![Gradle nowy projekt InteliJ](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/01/3_project_settings-150x150.png)

Kolejny ekran to informacja dla InteliJ jak powinien nazywać się projekt, domyślnie uzupełnia to pole wartością artifactId oraz gdzie na dysku projekt, powinien być utworzony.

![Gradle nowy projekt InteliJ](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/01/4_project_location-150x150.png)

Po przejściu przez tę serię kroków InteliJ utworzy pusty projekt wraz z plikiem build.gradle. Warto jest rzucić okiem na to co się w nim znajduje.

## Plik `build.gradle` utworzony przez IntliJ IDEA
  
Poniżej znajduje się plik `build.gradle`, który utworzył za mnie InteliJ.

    group 'pl.samouczekprogramisty'version '1.0-SNAPSHOT'apply plugin: 'java'sourceCompatibility = 1.5repositories { mavenCentral()}dependencies { testCompile group: 'junit', name: 'junit', version: '4.11'}

  
Pierwsze dwie linijki informują o grupie i wersji – dwóch komponentach pozwalających na unikalną identyfikację projektu. Atrybut name został pominięty, przyjmuje on wartość domyślną czyli nazwę katalogu, w którym znajduje się projekt.

Kolejna linijka jest Ci znana, włączamy wtyczkę do obsługi Javy.

Ta linijka wymaga trochę szerszego omówienia. Java ewoluowała, na przestrzeni lat pojawiały się kolejne wersje. Wersje te wprowadzały pewne konstrukcje językowe, które nie były dostępne wcześniej. `sourceCompatibility` informuje kompilator `javac` (poprzez przełącznik `-source`) jakiej wersji Javy trzeba użyć do kompilowania klas z kodem.

Kolejny blok mówi o repozytoriach, z których powinny być ściągane zależności. Jak widzisz InteliJ domyślnie zakłada, że korzystali będziemy z centralnego repozytorium Maven’a.

Kolejny blok specyfikuje zależności, domyślnie występuje tylko jedna zależność dostępna w trakcie kompilowania testów (`testCompile`), jest to bilblioteka JUnit w wersji 4.11.

# Podsumowanie
  
Po przeczytaniu artykułu dowiedziałeś się podstaw o Gradle. Wiesz już czym są zadania, jak łączyć je między sobą. Utworzyłeś swój pierwszy projekt w Gradle w InteliJ IDEA. Przeczytałeś o konwencjach stosowanych w większych projektach programistycznych.

Temat bynajmniej nie jest wyczerpany. W kolejnych artykułach, bez wstępu, któremu poświęcony jest ten artykuł skupię się na omawianiu bardziej zaawansowanych możliwości Gradle.

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz pominąć kolejnych artykułów dopisz się do mojego newslettera i polub Samouczka na facebooku.

Na koniec mam do Ciebie standardową prośbę, podziel się linkiem do artykułu ze znajomymi, zależy mi na dotarciu do jak największej liczby zapaleńców chcących uczyć się i doskonalić w programowaniu :). Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/antsnaps/6163066070/sizes/l

