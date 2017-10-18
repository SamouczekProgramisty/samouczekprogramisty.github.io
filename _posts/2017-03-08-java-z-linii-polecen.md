---
title: Java z linii poleceń
date: '2017-03-08 20:35:45 +0100'
categories:
- Kurs programowania Java
- DSP2017
permalink: /java-z-linii-polecen/
header:
    teaser: /assets/images/2017/03/08_java_z_linii_polecen_artykul.jpg
    overlay_image: /assets/images/2017/03/08_java_z_linii_polecen_artykul.jpg
    caption: "[&copy; wwward0](https://www.flickr.com/photos/wwward0/9176827666/sizes/l)"
excerpt: W tym artykule przeczytasz o narzędziach dostarczonych wraz z JDK. Dowiesz się jak używać kompilatora `javac`. Stworzysz swój pierwszy plik JAR. Po przeczytaniu tego artykułu zrozumiesz działanie podstawowych narzędzi dołączonych do JDK i docenisz kawał pracy jaką odwala za nas IDE :). Dowiesz się czym jest classpath i dlaczego ścieżka ta jest niezmiernie ważna. Zapraszam do lektury.
---

{% include toc %}

## Java z poziomu linii poleceń

Dzisiaj na przekór moim wszystkim radom, proszę Cie nie korzystaj z IDE. Wyłącz InteliJ Idea czy Eclipsa. Przejdź przez cały artykuł używając wyłącznie podstawowego edytora tekstu. Moim celem jest przeprowadzenie Cię przez cały proces pisania kodu w Javie używając podstawowych narzędzi.

Moim zdaniem takie podejście pozwoli Ci zrozumieć te podstawy, na których opiera się cała reszta. Osobiście dużo łatwiej jest mi pojąć bardziej skomplikowane rzeczy jeśli dokładnie wiem jak działają podstawowe klocki, których używa się do budowania tych bardziej skomplikowanych elementów.

Dzisiaj używał będę programu [gedit](https://wiki.gnome.org/Apps/Gedit), pracując w systemie Windows możesz użyć standardowego systemowego notatnika. Istotne jest to, aby program ten był w stanie utworzyć zwykły plik tekstowy, któremu nadasz rozszerzenie java.

## Narzędzia dostępne w JDK

O tym czym jest JDK i czym różni się od JRE pisałem w jednym z pierwszych artykułów na blogu - o [przygotowaniu środowiska programisty]({% post_url 2015-10-18-przygotowanie-srodowiska-programisty %}). Dowiesz się też tam jak zainstalować JDK. Dzisiaj będą dla Ciebie istotne trzy programy. `java` dostarczana jest wraz z JRE, `javac` i `jar` dostępne są wyłącznie w JDK:
- `java` uruchamia maszynę wirtualną, wywołując metodę `main` w odpowiedniej klasie,
- `javac` to kompilator, który jest w stanie utworzyć plik class z pliku java,
- `jar` to narzędzie, które jest w stanie tworzyć pliki jar.

## Pierwsza klasa w notatniku

Zacznijmy od początku, od programu wyświetlającego Twoje imię na konsoli. Będzie to zwykła klasa o nazwie `DisplayName` w pakiecie domyślnym, która będzie miała metodę `public static void main(String ... args)`. Wewnątrz tej metody wpisz instrukcję, która wypisze Twoje imię. Spróbuj napisać ten program bez IDE i zapisz go w pliku z rozszerzeniem java.

Dla mnie takie ćwiczenia na początku były dość trudne, pokazywały jak ważne i pomocne jest IDE w codziennej pracy. Mam nadzieję, że Tobie też pomoże to uświadomić.

Po tym wszystkim powinieneś mieć plik `DisplayName.java`, który będzie wyglądał podobnie do przykładu poniżej:

```java
public class DisplayName {
    public static void main(String ... args) {
        System.out.println(“Marcin”);
    }
}
```

## `javac` - skompiluj swoją klasę

I teraz dochodzimy do sedna sprawy, jak uruchomić taki program? Otóż trzeba go na początku skompilować. Do tego celu służy jedno z podstawowych i najczęściej używanych narzędzi dostarczonych wraz z JDK - kompilator języka Java. Jest to program `javac`. Wpisując w konsoli polecenie `javac -help` pokaże Ci się taka lista opcji (tutaj pokazałem wyłącznie kilka pierwszych linijek):

    $ javac -help
    Usage: javac <options> <source files>
    where possible options include:
      -g                         Generate all debugging info
      -g:none                    Generate no debugging info
      -g:{lines,vars,source}     Generate only some debugging info
      -nowarn                    Generate no warnings
      -verbose                   Output messages about what the compiler is doing
      -deprecation               Output source locations where deprecated APIs are used
      -classpath <path>          Specify where to find user class files and annotation processors
      -cp <path>                 Specify where to find user class files and annotation processors
    ...

Więc skompilujmy tę pierwszą klasę :). Aby to zrobić należy uruchomić komendę `javac DisplayName.java`. Po jej uruchomieniu kompilator powinien utworzyć plik binarny z rozszerzeniem class - `DisplayName.class`. Plik ten zawiera instrukcje, które są zrozumiałe dla wirtualnej maszyny Javy.

A oto jak wygląda katalog, w którym aktualnie znajduje się kod źródłowy razem ze skompilowaną klasą:

    $ tree .
    .
    ├── DisplayName.class
    └── DisplayName.java
    
    0 directories, 2 files

## `java` - uruchom swoją klasę

Skoro mamy już kod, mamy też skompilowaną klasę przydałoby się ją jakoś uruchomić :). Z pomocą przychodzi kolejny bardzo ważny program - `java`. Program ten uruchamia wirtualną maszynę Javy. Wpisując w konsoli `java -help` ponownie pokażą się dostępne opcje (skróciłem je także tutaj):

    $ java -help
    Usage: java [-options] class [args...]
               (to execute a class)
       or  java [-options] -jar jarfile [args...]
               (to execute a jar file)
    where options include:
        ...
        -server      to select the "server" VM
                      The default VM is server,
                      because you are running on a server-class machine.
        -cp <class search path of directories and zip/jar files>
        -classpath <class search path of directories and zip/jar files>
                      A : separated list of directories, JAR archives,
                      and ZIP archives to search for class files.
        ...

Teraz masz już wszystkie potrzebne składniki do uruchomienia programu. Możesz to zrobić wpisując `java DisplayName`:

    $ java DisplayName
    Marcin

## Pracowity skrzat, IDE

Niby prosty program, a do jego uruchomienia trzeba użyć 2 magicznych programów, jak tak można? ;). Okazuje się, że właśnie podobne czynności robi za nas IDE. Za każdym razem[^wyjatki] gdy w InteliJ użyjesz klawiszy `Ctr+Schift+F10` (uruchom program) InteliJ Idea robi podobne rzeczy. Kompiluje kod używając do tego programu `javac` a następnie uruchamia w odpowiedni sposób JRE używając programu `java`.

[^wyjatki]: Jak zwykle są wyjątki, ale nie są one istotne w tym przypadku.

## Pakiety

A teraz zrób krok do przodu - utwórz tę samą klasę w pakiecie `pl.samouczekprogramisty.commandline` i skompiluj ją przy pomocy `javac`. Przykład poniżej pokazuje poprawna strukturę katalogów dla klasy w takim pakiecie

    $ tree .
    .
    └── pl
        └── samouczekprogramisty
            └── commandline
                └── DisplayName.java
    
    3 directories, 2 files

Aby to zrobić musisz utworzyć plik ze źródłem w odpowiednim folderze, oczywiście wtedy deklaracja `package` na początku pliku powinna odzwierciedlać tę ścieżkę. W moim przypadku plik wygląda następująco:

```java
package pl.samouczekprogramisty.commandline;

public class DisplayName {
    public static void main(String ... args) {
        System.out.println("Marcin pakiet");
    }
}
```

Następinie używając programów `javac` i `java` mogę skompilować i uruchomić odpowiednią klasę używając poleceń:

    javac pl/samouczekprogramisty/commandline/DisplayName.java
    java pl.samouczekprogramisty.commandline.DisplayName

Jak widzisz `javac` przyjmuje jako parametr ścieżkę do pliku, który chcesz skompilować. Program `java` natomiast przyjmuje pełną nazwę klasy (wraz z pakietem) wewnątrz której znajduje się metoda `main`. Dochodzimy tutaj do pewnej istotnej rzeczy, gdzie program `java` ma “szukać” tej klasy? Odpowiedzią na to pytanie jest `classpath`. Po polsku będę to nazywał ścieżką przeszukiwania.

W przypadku systemów z rodziny Windows katalogi w ścieżce do klasy, którą kompilujesz oddzielone są znakiem `\` a nie `/` jak w przykładzie.

## Czym jest classpath

No właśnie, czym jest classpath, magiczna ścieżka przeszukiwania? Wyjaśniając to pojęcie w jednym zdaniu - classpath to ścieżka, gdzie program `java` szuka klas, które potrzebne są w trakcie uruchomienia programu.

Możesz zatem zapytać “dlaczego poprzednio `java DisplayName` działało?" Działało, ponieważ jeśli nie ustawisz żadnej wartości, ścieżka przeszukiwania przyjmuje wartość domyślną - `.`. Ta kropka oznacza katalog, w którym aktualnie się znajdujesz.

Jako ćwiczenie możesz spróbować przejść do innego katalogu i uruchomić to samo polecenie, przykład poniżej pokazuje zachowanie jakie możesz uzyskać:

    $ tree .
    .
    └── pl
        └── samouczekprogramisty
            └── commandline
                ├── DisplayName.class
                └── DisplayName.java
     
    3 directories, 2 files
    ~$ java pl.samouczekprogramisty.commandline.DisplayName
    Marcin pakiet
    ~$ cd pl
    ~/pl$ java pl.samouczekprogramisty.commandline.DisplayName
    Error: Could not find or load main class pl.samouczekprogramisty.commandline.DisplayName

Jak widzisz w ostatniej linii program `java` wyświetlił błąd informujący, że nie może znaleźć klasy `pl.samouczekprogramisty.commandline.DisplayName` na aktualnej ścieżce przeszukiwania. Program szukał struktury pakietów pl/samouczekrogramisty/commandline, a w katalogu pl był jedynie katalog samouczekprogramisty, nie było katalogu pl.

Ścieżka przeszukiwania to lista katalogów oddzielonych odpowiednim znakiem gdzie program `java` powinien szukać klas. Na tej ścieżce poza katalogami mogą znajdować się też pliki zip czy pliki jar[^format]. Przykład poniżej pokazuje ścieżkę przeszukiwania na której znajdują się 3 elementy:

    some/path:.:other/path/file.jar

[^format]: Tak na prawdę plik jar to plik zip z innym rozszerzeniem.

Pierwszy z nich to katalog some/path. Drugi z nich to katalog bieżący oznaczony znakiem `.`. Ostatni to ścieżka do pliku jar, wewnątrz którego znajdują się skompilowane klasy.

W przypadku sytemów z rodziny Windows do rozdzielenia elementów na ścieżce przeszukiwania używa się znaku `;`. W pozostałych znanych mi systemach jest to znak `:` jak widzisz w przykładzie powyżej.

## Jak ustawić classpath

Ścieżka przeszukiwania może być ustalona na dwa sposoby. Pierwszym z nich jest użycie argumentu linii poleceń `-cp` lub `-classpath`. Drugim jest ustawienie zmiennej środowiskowej `CLASSPATH`.

Jeśli nie użyjesz żadnej z tych metod, ścieżka przeszukiwania przyjmie wspomnianą już domyślną wartość.

## Classpath w trakcie kompilacji

Nie tylko program `java` używa ścieżki przeszukiwania. Jest ona także używana w trakcie kompilacji. Wyobraź sobie swoją klasę, która zależy od innych klas. Na przykład używasz biblioteki [Apache Commons Lang](https://github.com/apache/commons-lang) i klasy [`StringUtils`](https://github.com/apache/commons-lang/blob/master/src/main/java/org/apache/commons/lang3/StringUtils.java).

Załóżmy, że chcesz użyć metody [`StringUtils.containsIgnoreCase`](https://github.com/apache/commons-lang/blob/master/src/main/java/org/apache/commons/lang3/StringUtils.java#L1929). Spróbuj napisać kod w notatniku, bez pomocy IDE, który pobierze od użytkownika łańcuch znaków. Następnie sprawdzi (ignorując wielkość liter), czy w tym łańcuchu znajduje się Twoje imię.

Zdaję sobie sprawę, że jest to trudne ćwiczenie, jednak spróbuj wykonać je samodzielnie. Do wykonania tego ćwiczenia możesz użyć klasy `java.util.Scanner` i wspomnianej klasy `StringUtils`. Nie zapomnij o odpowiednich deklaracjach `import`. Prawdopodobnie bez dostępu do IDE nie zrobisz tego zadania bezbłędnie za pierwszym razem. Nie przejmuj się, to właśnie przy poprawianiu błędów nauczysz się najwięcej.

Plik JAR z tą biblioteką możesz pobrać z [repozytorium Mavena](http://central.maven.org/maven2/org/apache/commons/commons-lang3/3.5/commons-lang3-3.5.jar) (jeśli nie wiesz czym jest takie repozytorium odsyłam Cię do artykułu [Wstęp do Gradle]({% post_url 2017-01-19-wstep-do-gradle %})).

Kod, który napisałeś mógłby wyglądać jak w przykładzie poniżej:

```java
package pl.samouczekprogramisty.commandline;
 
import java.util.Scanner;
import org.apache.commons.lang3.StringUtils;
 
public class CheckName {
    public static void main(String ... args) {
        System.out.println("Podaj zdanie");
        Scanner scanner = new Scanner(System.in);
        String sentence = scanner.nextLine();
 
        if (StringUtils.containsIgnoreCase(sentence, "Marcin")) {
            System.out.println("To zdanie zawiera moje imie!");
        }
        else {
            System.out.println("To zdanie nie zawiera mojego imienia!");
        }
    }
}
```

Jak widzisz, użyłem tu klasy wcześniej wspomnianej klasy `Scanner` i `StringUtils`. Pierwsza z nich znajduje się w bibliotece standardowej Javy. Jest ona domyślnie dostępna w trakcie uruchomienia i kompilacji. Jednak w przypadku klasy `StringUtils` jest inaczej.

Jest to klasa zewnętrza więc musi być dostarczona zarówno w trakcie kompilacji jak i uruchomienia programu. Spójrz proszę na komendy użyte do kompilacji i uruchomienia programu:

    javac -cp commons-lang3-3.5.jar pl/samouczekprogramisty/commandline/CheckName.java
    java -cp .:commons-lang3-3.5.jar pl.samouczekprogramisty.commandline.CheckName

W pierwszej linii jako ścieżkę przeszukiwania ustawiamy plik jar zawierający klasę `StringUtils`. To wywołanie kompiluje klasę `CheckName`. Dzięki temu uzyskamy plik `CheckName.class`, który chcemy uruchomić.

Kolejna linijka to właśnie to uruchomienie. Zauważ, że w tym przypadku ścieżka przeszukiwania zawiera zarówno aktualny katalog jak i plik jar. Aktualny katalog jest niezbędny żeby znaleźć klasę `CheckName`. Plik jar natomiast jest wymagany do odnalezienia klasy `StringUtils`.

Teraz czas na Twoje eksperymenty. Co się stanie jeśli uruchomisz swój program bez z `-cp`? :)

## Pliki JAR

No dobrze, a co jeśli chcemy w łatwy sposób przekazać komuś skompilowany kod? Bardzo dobrze do tego celu nadają się pliki JAR. JAR czyli Java Archive to nic innego jak plik zip, wewnątrz którego znajduje się zestaw plików class ze skompilowanymi klasami[^zawartosc].

[^zawartosc]: Oczywiście pliki jar mogą zawierać także pliki innego rodzaju, jednak na tym etapie wystarczy wiedza o class i pliku tekstowym Manifest.

Klasy wewnątrz archiwum znajdują się w odpowiednich katalogach, które odzwierciedlają strukturę pakietów. Spróbujmy teraz przygotować Twój pierwszy jar z linii poleceń.

Program `jar` ma także inne zastosowania. Na przykład przy jego pomocy możesz wyświetlić zawartość istniejącego pliku JAR. Służy do tego komenda pokazana poniżej:

    jar tf commons-lang3-3.5.jar

Tworzenie pliku JAR jest dość proste. Wystarczy podać odpowiedni zestaw parametrów jak w przykładzie poniżej:

    jar cf <nazwa pliku wyjściowego> <lista katalogów, klas do umieszczenia w pliku JAR>

W przypadku przykładu używanego poprzednio cały zestaw komend wyglądałby następująco:

    $ tree .
    .
    └── pl
        └── samouczekprogramisty
            └── commandline
                ├── CheckName.class
                ├── CheckName.java
                ├── DisplayName.class
                └── DisplayName.java
     
    3 directories, 4 files
    $ jar cf JavaCommandline.jar .
    $ jar tf JavaCommandline.jar
    META-INF/
    META-INF/MANIFEST.MF
    pl/
    pl/samouczekprogramisty/
    pl/samouczekprogramisty/commandline/
    pl/samouczekprogramisty/commandline/DisplayName.java
    pl/samouczekprogramisty/commandline/DisplayName.class
    pl/samouczekprogramisty/commandline/CheckName.class
    pl/samouczekprogramisty/commandline/CheckName.java

Jak widzisz, pliki znajdujące się w katalogu zostały dodane do pliku JAR. Program tutaj nie przeprowadził żadnego filtrowania - umieścił w archiwum także pliki java. Dlatego właśnie bardzo często pliki class umieszczamy w zupełnie innym katalogu niż pliki źródłowe.

Dodatkowo wewnątrz pliku JAR znajduje się też plik MANIFEST.MF, który zawiera metadane na temat tego archiwum. Wewnątrz tego pliku możemy skonfigurować na przykład domyślną klasę, która powinna być uruchamiana podczas wykonania polecenia

    $ java -jar <ścieżka do pliku JAR>

## Dodatkowe materiały do nauki

Artykuł ten był wybitnie praktyczny. Zależało mi na tym abyś krok po kroku realizował poszczególne etapy. Jeśli tego nie zrobiłeś, bardzo proszę spróbuj. Jeśli chciałbyś dowiedzieć się więcej o narzędziach, które opisałem w artykule mam dla Ciebie zestaw kilku dodatkowych dokumentów:
- [dokumentacja programu `java`](http://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html),
- [dokumentacja programu `javac`](http://docs.oracle.com/javase/8/docs/technotes/tools/unix/javac.html),
- [dokumentacja programu `jar`](http://docs.oracle.com/javase/8/docs/technotes/tools/unix/jar.html),
- [specyfikacja plików jar](http://docs.oracle.com/javase/8/docs/technotes/guides/jar/jar.html),
- [kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/25_linia_polecen/src/main/java/pl/samouczekprogramisty/commandline).

## Podsumowanie

Mam nadzieję, że taki praktyczny przewodnik krok po krodu po podstawowych narzędziach dostepnych z JRE i JDK przypadł Ci do gustu. Daj znać w komentarzach jak Ci poszło z przerobieniem ćwiczeń z treści artykułu :).

Po przeczytaniu tekstu znasz podstawowe narzędzia używane przy programowaniu w języku Java. Jesteś w stanie stworzyć swój plik jar i uruchomić klasy, które skmpilujesz podstawowymi narzędziami. Dzięki temu lepiej rozumiesz "magię", którą na codzień robi IDE. Wiesz jak bardzo upraszcza ono Twoją pracę z kodem.

Jeśli nie chcesz pominąć kolejnych artykułów dopisz się do mojego newslettera i polub Samouczka na facebooku.

Na koniec mam do Ciebie standardową prośbę, podziel się linkiem do artykułu ze znajomymi, zależy mi na dotarciu do jak największej liczby samouków, którzy chcą pogłębiać swoją wiedzę. Do następnego razu!
