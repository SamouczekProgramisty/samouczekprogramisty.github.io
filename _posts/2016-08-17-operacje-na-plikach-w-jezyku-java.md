---
last_modified_at: 2018-06-23 00:53:41 +0200
title: Operacje na plikach w języku Java
categories:
- Kurs programowania Java
- Programowanie
permalink: /operacje-na-plikach-w-jezyku-java/
header:
    teaser: /assets/images/2016/08/17_operacje_na_plikach_artykul.jpg
    overlay_image: /assets/images/2016/08/17_operacje_na_plikach_artykul.jpg
    caption: "[&copy; micahd](https://www.flickr.com/photos/micahd)"
excerpt: Artykuł ten opisuje podstawowy dostęp do plików. Poznasz zupełne podstawy systemu plików. Dowiesz się czym jest plik binarny i czym różni się od pliku tekstowego. Dowiesz się czegoś więcej o trybach dostępu do plików. Na koniec napiszesz swój własny program, który będzie zapisywał dane do pliku i wyświetlał jego zawartość. Innymi słowy artykuł, w którym podstawy systemu plików i programowanie poznasz od praktycznej strony :) Zapraszam!
disqus_page_identifier: 319 http://www.samouczekprogramisty.pl/?p=319
---

{% include kurs-java-notice.md %}

## System plików

Na początku winien Ci jestem drobne wprowadzenie do czegoś co nazywa się systemem plików. Otóż dysk komputera może pomieścić pewną ilość danych, współczesne dyski twarde mają pojemność z przedziału kilkuset gigabajtów (GB) do kilku terabajtów (TB).

Jest to ogromna przestrzeń, 1 GB to 1’000 MB, to z kolei przekłada się na 1’000’000’000B (10<sup>9</sup> bajtów). Każdy z tych bajtów to 8 bitów. Na zapisanie dowolnej liczby typu `int` w Javie potrzebujesz 32 bitów (4 bajtów). Czyli 1GB dysku w teorii może pomieścić 250’000’000 liczb zapisanych w tym formacie. Innymi słowy potrzeba około 3GB aby w tym formacie zapisać datę urodzenia każdego mieszkańca Europy (gdzie datę zapisujemy jako jedną liczbę) :)

Aby komputer wiedział co znajduje się w którym miejscu w tym gąszczu cyferek potrzebny jest system plików. Istnieje wiele rodzajów systemów plików, jednak ich rozróżnienie nie jest nam w tym momencie potrzebne. Jeśli jesteś zainteresowany bardziej szczegółowymi informacjami zachęcam do przeczytania [artykułu na wikipedii](https://pl.wikipedia.org/wiki/System_plików).

Najważniejsze jest abyś zapamiętał, że system plików organizuje dane na dysku i daje do nich dostęp poprzez znane Ci foldery czy pliki.

### Pliki binarne a pliki tekstowe

Wiesz już, że plik mapuje się na pewien obszar danych na dysku. Otwierając jakikolwiek plik czytasz te dane za pośrednictwem systemu plików. Dane te mogą być zapisane w trybie „tekstowym” bądź „binarnym”[^pliki].

[^pliki]: Jest to swego rodzaju uproszczenie, w rzeczywistości pliki tekstowe zapisane są także jako ciąg danych binarnych, jednak programy takie jak notatnik wiedzą jak te dane interpretować i wyświetlają zwykły tekst.

Sposób zapisu danych ma istotny wpływ na rozmiar pliku. Na przykład zapisanie liczby 1234567 binarnie jako `int` w Javie wymaga 4 bajtów. Zapisanie tej samej liczby jako łańcuch znaków w pliku tekstowym wymaga już 7 bajtów. Innymi słowy zapis binarny w ogromnej większości przypadków wymaga mniej miejsca na dysku.

Niestety wiąże się to z pewnymi ograniczeniami. Otóż pliki binarne nie są czytelne dla ludzi (ang. _human-readable_). Czy zdarzyło Ci się kiedyś otworzyć plik binarny w notatniku? Zobaczyłbyś wtedy przysłowiowe „krzaki”, ponieważ notatnik interpretował dane binarne jako tekst.

{% include newsletter-srodek.md %}

### Ścieżka do pliku

System plików organizuje dane na dysku w hierarchiczną strukturę katalogów wewnątrz których znajdują się pliki. Każdy plik czy katalog ma ścieżkę, która jednoznacznie wskazuje jego miejsce w tej strukturze.

Tutaj napotykamy na pewne różnice pomiędzy różnymi systemami operacyjnymi. Dyski mogą być podzielone na tak zwane partycje, systemy operacyjne z rodziny Windows przedstawiają te partycje jako osobne dyski np. dysk C czy dysk D. W związku z tym ścieżki nieznacznie różnią się pomiędzy różnymi systemami operacyjnymi. I tak ścieżka w systemie z rodziny Windows wygląda następująco:

    C:\katalog\plik.txt

Analogiczna ścieżka w systemach z rodziny Linux/Unix wygląda trochę inaczej:

    /katalog/plik.txt

W kontekście języka Java taka różnica ma pewne konsekwencje. Otóż jeśli chcemy użyć literału `String` wówczas znak `\` musimy poprzedzić kolejnym `\`. Dzieje się tak ponieważ symbol `\` jest wykorzystywany w specjalny sposób. Zatem ścieżka `C:\katalog\plik.txt` zapisana w Javie jako `String` wygląda następująco `"C:\\katalog\\plik.txt"`.

### Ścieżka absolutna i relatywna

Do każdego folderu/pliku możemy odnieść się poprzez ścieżkę absolutną bądź relatywną (możemy je także nazwać ścieżką bezwzględna i względną). Ścieżka absolutna jest ścieżką „od początku”, czyli przechodzi przez całą strukturę katalogów aż do samego pliku.

Załóżmy, że dysk C ma strukturę jak przedstawiono poniżej:


    C:\
     ├── folder_1
     │ └── plik_1.txt
     ├── folder_2
     │ ├── folder_2_a
     │ │ └── plik_2_a.txt
     │ └── plik_2.txt
     └── plik.txt

Ścieżka absolutna do pliku plik\_2\_a.txt wygląda następująco `C:older_2older_2_a\plik_2_a.txt`. Możemy mówić również o ścieżce relatywnej. Mówimy o niej relatywna ponieważ określa adres pliku/katalogu relatywnie do miejsca, w którym się aktualnie znajdujemy.

Zakładając że znajdujemy się w katalogu `folder_2` wówczas nasza relatywna ścieżka do pliku `plik_2_a.txt` jet następująca `folder_2_a\plik_2_a.txt`.

### Tryb dostępu do pliku

Musisz wiedzieć, że plik możemy otworzyć „do odczytu”, „do zapisu” czy „w trybie dołączania”. Tryb ten jest bardzo istotny, otworzenie do zapisu pliku, który już istnieje i zapisanie choćby jednego znaku kasuje całą dotychczasową zawartość. Podobnie otworzenie do zapisu pliku, który jeszcze nie istnieje powoduje jego utworzenie (jeśli katalog w którym ma znaleźć się plik istnieje).

Tryb „dołączania” nie kasuje zawartości istniejącego pliku, a jedynie dopisuje na końcu nową treść.

Otwierając jakikolwiek plik w języku Java otwieramy go w pewnym trybie. Tryb ten określamy wprost, bądź jest określony domyślnie w zależności od klasy, którą użyjemy do tego celu. Klasy służące do pisania do pliku domyślnie otwierają go „do zapisu”.

## Klasy do obsługi operacji na plikach

Musisz wiedzieć, że klasy z biblioteki standardowej do obsługi plików wprowadzają pewne warstwy abstrakcji ułatwiające pracę z plikami. Wygląda to w ten sposób, że mamy klasę X, która jest klasą podstawową udostępniającą bardzo ograniczony zakres operacji. Klasa Y używając interfejsu klasy X udostępnia interfejs wyższego poziomu, z którym programiście łatwiej jest pracować. Takie podejście można porównać do swego rodzaju cebuli ;) gdzie każda kolejna warstwa bazuje na poprzedniej i udostępnia trochę inny interfejs.

Przekładając to na konkretny przykład klas ze standardowej biblioteki Javy mamy klasę [`java.io.File`]({{ site.doclinks.java.io.File }}), która oferuje podstawowe operacje na pliku.
Instancja `File` jest przyjmowana jako parametr do utworzenia instancji klasy [`java.io.FileReader`]({{ site.doclinks.java.io.FileReader }}), która pozwala programiście na tekstowy dostęp do pliku znak po znaku. Z racji tego, że taka forma może być uciążliwa mamy do dyspozycji kolejną klasę [`java.io.BufferedReader`]({{ site.doclinks.java.io.BufferedReader }}), która pozwala na dostęp do pliku linijka po linijce.

```java
new BufferedReader(new FileReader(new File("/path/to/text/file.txt")));
```

Z racji tego, że powyższy fragment jest dość długi i byłby uciążliwy do pisania za każdym razem twórcy biblioteki przygotowali zestaw konstruktorów, które umożliwiają skrócenie tego zapisu. W przykładzie poniżej programista nie tworzy wprost instancji klasy `File`, podaje jedynie ścieżkę do pliku. Ta instancja tworzona jest za nas wewnątrz konstruktora klasy `FileReader`.

```java
new BufferedReader(new FileReader("/path/to/text/file.txt"));
```

Po tym wstępie teoretycznym wiesz już na tyle dużo o systemie plików i plikach, że możemy przejść do ich zapisywania i odczytywania. Ścieżki użyte w przykładach są z systemów Linux/Unix, jeśli pracujesz na Windows powinieneś używać ścieżek zgodnych z opisem powyżej.

W artykule tym zajmowali będziemy się wyłącznie sekwencyjnym dostępem do plików. Oznacza to, że pisząc do pliku zawsze dopisujemy linijkę na koniec a czytając, czytamy od początku pliku. Oczywiście możemy też czytać z pliku/pisać do pliku w sposób losowy, wybierając dowolną lokalizację. Takie podejście często jest wykorzystywane w przypadku plików binarnych, których strukturę doskonale znamy i wiemy, że na przykład od bajtu 10 do bajtu 13 włącznie w pliku zawsze znajduje się liczba, która reprezentuje datę urodzenia.

## Obsługa plików tekstowych

### Zapisywanie danych do pliku

Zapis do pliku tekstowego przedstawiłem we fragmencie kodu poniżej.

```java
String filePath = "/path/to/text/file.txt"
int number = 1234567;
FileWriter fileWriter = null;

try {
    fileWriter = new FileWriter(filePath);
    fileWriter.write(Integer.toString(number));
} finally {
    if (fileWriter != null) {
        fileWriter.close();
    }
}
```

Przeanalizujmy co się dzieje w tym fragmencie kodu linijka po linijce. Pierwsze trzy linijki to nic innego jak inicjalizacja zmiennych, których będziemy używali później. Nowy tutaj dla Ciebie jest typ `FileWriter`, jest to klasa ze standardowej biblioteki języka Java odpowiedzialna za zapis do pliku tekstowego.

Zachęcam do przejrzenia [pełnej dokumentacji klasy `FileWriter`]({{ site.doclinks.java.io.FileWriter }}). Klasa ta udostępnia wysokopoziomowy interfejs zapisu do pliku danych tekstowych. Polecam sprawdzenie hierarchii dziedziczenia klasy `FileWriter` w IDE (pamiętasz skrót klawiaturowy z [poprzedniego artykułu]({% post_url 2016-08-09-kolekcje-w-jezyku-java %})?).

Następnie wewnątrz klauzuli `try` tworzymy nową instancję klasy `FileWriter` przekazując jej ścieżkę do pliku, do którego chcemy pisać. Operacja ta otwiera plik, może się ona nie udać co będzie sygnalizowane odpowiednim wyjątkiem. Kolejna linijka to wywołanie metody `write`, które zapisuje tekstową reprezentację liczby 1234567 do pliku. Ważne jest abyś pamiętał, że właściwy zapis wcale nie musi w tym miejscu nastąpić ze względu na buforowanie, o którym przeczytasz w jednym z kolejnych akapitów.

Bardzo istotne jest ciało klauzuli `finally`. Wewnątrz sprawdzamy czy nasz `fileWriter` został zainicjalizowany. Jeśli nie udałoby się stworzyć jego instancji rzucony zostałby wyjątek ale klauzula `finally` i tak by się wykonała. Następnie wywołując metodę `close` zamykamy dostęp do pliku, jeśli ta operacja się powiedzie mamy pewność, że dane zostały zapisane w pliku na dysku.

### Zamykanie dostępu do plików

Proszę pamiętaj o zamknięciu strumienia danych. Dlaczego jest to ważne? Podstawowym powodem jest tutaj zarządzanie przez system operacyjny tak zwanymi uchwytami do otwartych plików. Otóż systemy operacyjne, które znam mają limity, które pozwalają na otwarcie np. 2048 plików jednocześnie przez każdy program. Liczba ta jest na tyle duża, że nie zauważasz tego ograniczenia w codziennym użytkowaniu. Jeśli jednak napiszesz program, który będzie otwierał pliki bez ich zamykania możesz z łatwością wyczerpać ten limit.

Bardziej przyziemnym powodem jest tak zwane buforowanie. Zapis do pliku może być buforowany (i jest w części przypadków przez klasy ze standardowej biblioteki Javy). Oznacza to tyle, że wywołanie metody `write` tak naprawdę jeszcze niczego na dysku nie zapisuje. Zapisuje te dane w buforze, który zrzucany jest na dysk. Taki zabieg jest wykonywany aby przyspieszyć zapis danych. Jeśli nie zamkniesz pliku może do doprowadzić do sytuacji, w której w buforze zostaną dane, które jeszcze nie zostały do pliku zrzucone. Zostaną one wówczas utracone, a tego chcielibyśmy uniknąć :)

### Odczytywanie danych z pliku

Przykład kodu poniżej służy do czytania danych z pliku.

```java
String filePath = "/path/to/text/file.txt"
int number = 0;
BufferedReader fileReader = null;

try {
    fileReader = new BufferedReader(new FileReader(filePath));
    String numberAsString = fileReader.readLine();
    number = Integer.parseInt(numberAsString);
} finally {
    if (fileReader != null) {
        fileReader.close();
    }
}
```

Podobnie jak poprzednio przeanalizujemy go linijka po linijce. Pierwsze trzy linijki inicjalizują zmienne, które będziemy używali. Wewnątrz klauzuli `try` znajduje się kod, który tworzy instancję klasy [`BufferedReader`]({{ site.doclinks.java.io.BufferedReader }}) dzięki której możemy czytać z pliku linijka po linijce.

Kolejne dwie linie to czytanie linijki z pliku, parsowanie łańcucha znaków i zapisanie go jako liczby typu `int`. Metoda `readLine`, która została użyta zwróci `null` jeśli w pliku nie znajduje się już więcej danych.

Podobnie jak w przypadku plików otwartych do odczytu tak i w tym przypadku musimy pamiętać o ich zamknięciu, zapewnia to wnętrze bloku `finally`.

Musisz też wiedzieć, że klasy które pozwalają Ci na czytanie pliku mają tak zwany „wskaźnik”, który zapamiętuje ostatnie miejsce z którego coś przeczytaliśmy. Kolejna próba odczytu przesuwa ten wskaźnik dalej.

## Obsługa plików binarnych

Skupimy się teraz na obsłudze plików binarnych. Pewne aspekty pracy z plikami tekstowymi i binarnymi są podobne. W obu przypadkach musimy pamiętać o zamykaniu „strumieni” do plików. W obu przypadkach także skupimy się na dostępie sekwencyjnym.

### Zapisywanie danych do pliku

Bez zbędnego wstępu proszę spójrz na przykład poniżej.

```java
String filePath = "/path/to/binary/file.txt"
int number = 1234567;
DataOutputStream outputStream = null;

try {
    outputStream = new DataOutputStream(new FileOutputStream(filePath));
    outputStream.writeInt(number);
} finally {
    if (outputStream != null) {
        outputStream.close();
    }
}
```

Pierwsze trzy i ostatnie pięć linii jest dla Ciebie znajoma. Bardzo podobny kod widziałeś w przykładach powyżej. Skupmy się nad tym co dzieje się w środku klauzuli `try`. Tworzymy tam instancję klasy [`FileOutputStream`]({{ site.doclinks.java.io.FileOutputStream }}), która zostaje przekazana do konstruktora klasy [`DataOutputStream`]({{ site.doclinks.java.io.DataOutputStream }}). `DataOutputStream` zapewnia interfejs pozwalający na binarny zapis typów prymitywnych w Javie podczas gdy `FileOutputStream` pozwala na zapis danych bajt po bajcie.

Używanie `DataOutputStream` pozwala programiście zapomnieć o szczegółach w jaki liczby powinny być zapisane binarnie, tymi szczegółami zajmuje się właśnie ta klasa przez wywołanie metody `writeInt`. Pozwala ona w łatwy sposób zapisać binarnie typy proste i łańcuchy znaków (w jednym z kolejnych artykułów przeczytasz o serializacji pozwalającej na zapisanie binarnie dowolnych obiektów).

Po uruchomieniu programu, który zapisuje liczbę do pliku spróbuj otworzyć ten plik w notatniku. Co widzisz? :) Prawda, że jest to mniej czytelne niż tekstowy format pliku?

### Odczytywanie danych z pliku

```java
String filePath = "/path/to/binary/file.txt"
int number = 0;
DataInputStream inputStream = null;
 
try {
    inputStream = new DataInputStream(new FileInputStream(filePath));
    number = inputStream.readInt();
} finally {
  if (inputStream != null) {
      inputStream.close();
  }
}
```

Podobnie jak poprzednio kod poza klauzulą `try` już znasz. Nowa tutaj dla Ciebie jest instancja klasy [`FileInputStream`]({{ site.doclinks.java.io.FileInputStream }}), która przekazana jest do konstruktora klasy [`DataInputStream`]({{ site.doclinks.java.io.DataInputStream }}). Widzisz tu pewną analogię do poprzedniego przykładu? Podobnie jak poprzednio `DataInputStream` pozwala na czytanie większych kawałków pliku zapisanego binarnie, dzięki tej klasie możemy przeczytać liczbę typu int zapisaną wcześniej w pliku. Podobnie jak poprzednio klasa ta pozwala na odczyt typów prostych i łańcuchów znaków zapisanych binarnie.

## Zadania

Na koniec kilka zadań dla Ciebie:
1. Napisz program, który pobierze od użytkownika ścieżkę do pliku tekstowego oraz kilka linijek tekstu (dopóki użytkownik nie wprowadzi „-” jako linijki) i zapisze je do pliku tekstowego. Do wykonania tego zadania może Ci się przydać metoda [`System.lineSeparator()`]({{ site.doclinks.java.lang.System }}#lineSeparator--) zwracająca znak nowej linii (jeśli chciałbyś oddzielić linie wprowadzone przez użytkownika).
2. Napisz program, który pobierze od użytkownika ścieżkę do pliku i wyświetli zawartość pliku na ekranie wraz z informacją ile linii znajduje się w pliku.
3. Napisz program, który poprosi użytkownika nazwę pliku wyjściowego oraz o podanie swojej daty urodzenia (osobno dzień, miesiąc i rok), a następnie zapisze te dane jako trzy osobne liczby binarnie.
4. Napisz program, który pobierze od użytkownika ścieżkę do pliku binarnego z datą urodzenia, a następnie wyświetli ją na ekranie.

Jak zwykle przykładowe rozwiązania zadań znajdują się na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/16_operacje_na_plikach/src/main/java/pl/samouczekprogramisty/kursjava/files), jednak zachęcam do samodzielnej próby rozwiązania zadań, wtedy nauczysz się najwięcej.

## Dodatkowe materiały do nauki

W każdym artykule zachęcam Cię do zapoznania się z dokumentacją, nie inaczej będzie i tym razem. Zapewniam Cię, że jest to najlepsze źródło z kompletną informacją na temat klas z biblioteki standardowej. Innymi słowy zestaw obowiązkowy to dokumentacja biblioteki standardowej, zawsze w przypadku wątpliwości tam znajdziesz dużo potrzebnych informacji:
- [`File`]({{ site.doclinks.java.io.File }})
- [`FileWriter`]({{ site.doclinks.java.io.FileWriter }})
- [`FileReader`]({{ site.doclinks.java.io.FileReader }})
- [`BufferedReader`]({{ site.doclinks.java.io.BufferedReader }})
- [`FileOutputStream`]({{ site.doclinks.java.io.FileOutputStream }})
- [`FileInputStream`]({{ site.doclinks.java.io.FileInputStream }})
- [`DataOutputStream`]({{ site.doclinks.java.io.DataOutputStream }})
- [`DataInputStream`]({{ site.doclinks.java.io.DataInputStream }})

Dodatkowo parę wpisów w innych miejscach w sieci:
- [kod źródłowy przykładów i przykładowe rozwiązania zadań](https://github.com/SamouczekProgramisty/KursJava/tree/master/16_operacje_na_plikach/src/main/java/pl/samouczekprogramisty/kursjava/files)
- [http://naukajavy.pl/kurs-jezyka-java/114-zapis-tekstu-do-pliku](http://naukajavy.pl/kurs-jezyka-java/114-zapis-tekstu-do-pliku)
- [http://naukajavy.pl/kurs-jezyka-java/113-odczyt-tekstu-z-pliku](http://naukajavy.pl/kurs-jezyka-java/113-odczyt-tekstu-z-pliku)
- [http://wazniak.mimuw.edu.pl/index.php?title=PO\_Strumienie](http://wazniak.mimuw.edu.pl/index.php?title=PO_Strumienie)

## Podsumowanie

Mam nadzieję, że artykuł się podobał. Dzisiaj nauczyłeś się całkiem sporo na temat pracy z plikami w Javie. Dowiedziałeś się czegoś więcej o systemie plików. Po wykonaniu zadań wiesz już jak odczytać/zapisać plik zarówno binarnie jak i w trybie tekstowym. Dużo tego :)

Na koniec jak zwykle prośba do Ciebie, zależy mi na dotarciu do jak największego grona czytelników. Proszę pomóż mi przy tym poprzez polubienie strony na fb i udostępnienie linku do bloga :) Z góry dziękuję.

Do następnego razu Samouku!
