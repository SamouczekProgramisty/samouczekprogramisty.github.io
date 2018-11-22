---
title: Formatter - formatowanie łańcuchów znaków
date: '2017-05-12 23:25:55 +0200'
categories:
- Kurs programowania Java
- DSP2017
permalink: /formatter-formatowanie-lancuchow-znakow/
header:
    teaser: /assets/images/2017/05/12_formwatowanie_lancuchow_znakow_artykul.jpeg
    overlay_image: /assets/images/2017/05/12_formwatowanie_lancuchow_znakow_artykul.jpeg
    caption: "[&copy; pvenegasd](https://www.flickr.com/photos/pvenegasd/16584479775/sizes/l)"
excerpt: W trakcie pracy z łańcuchami znaków bardzo często musimy prezentować je odpowiednim formacie. Dzisiejszy artykuł poświęcony będzie właśnie formatowaniu łańcuchów znaków. Dodatkowo dowiesz się czym jest lokalizacja i jaki ma wpływ na formatowanie. Całość będziesz mógł przećwiczyć rozwiązując ćwiczenie związane z formatowaniem.
disqus_page_identifier: 895 http://www.samouczekprogramisty.pl/?p=895
---

## Formatowanie

Wyobraź sobie, że chcesz pokazać użytkownikowi pewne zestawienie. Dane tego typu wygodnie jest prezentować w formie tabelarycznej. Tak dochodzimy do problemu formatowania. W jaki sposób można taki format uzyskać?

Problem ten można rozwiązać posługując się klasą [`Formatter`](https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html). Instancje właśnie tej klasy użyte są w wielu innych miejscach. Na przykład:

- [`PrintWriter.format`](https://docs.oracle.com/javase/8/docs/api/java/io/PrintWriter.html#format-java.lang.String-java.lang.Object...-) Wewnątrz tej metody użyty jest `Formatter`. `System.out` to instancja klasy `PrintWriter`. Dzięki temu w bardzo wygodny sposób możesz formatować tekst wypisując go na konsoli używając metody `System.out.format`,
- [`String.format`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#format-java.lang.String-java.lang.Object...-) statyczna metoda w klasie `String`, która pozwala na formatowanie łańcucha znaków. Jej implementacja także bazuje na klasie `Formatter`.

## Zasada działania formattera

Formatter działa w oparciu o specjalny łańcuch znaków. Ten łańcuch opisuje sam format w jakim dane powinny być sformatowane. Może on wyglądać następująco:

    %2$08.3f %3$(,08.3f %s

Nie przeraź się tym przykładem, po przeczytaniu tego artykułu będziesz dokładnie wiedział co ten magiczny wzorek oznacza. Jest on celowo skomplikowany, żeby pokazać Ci możliwości klasy `Formatter`.

## Łańcuch formatujący

Zacznijmy od prostego przykładu:

```java
Formatter formatter = new Formatter();
formatter.format("Samouczek Programisty istnieje od %d roku. Wszystkie artykuły pisze %s.", 2015, "Marcin");
String formattedString = formatter.toString();
System.out.println(formattedString);
```

Po uruchomieniu tego fragmentu kodu na konsoli pokaże się:

    Samouczek Programisty istnieje od 2015. Wszystkie artykuły pisze Marcin.

Powyższy fragment kodu to nic innego jak utworzenie nowej instancji klasy `Formatter`. Następnie na tej instancji wywołana jest metoda `format`. Jako pierwszy argument przyjmuje ona łańcuch formatujący. Następnie może przyjąć zmienną liczbę argumentów, które wykorzystywane są do uzupełniania formatu.

W naszym przypadku łańcuchem formatującym jest `Samouczek Programisty istnieje od %d roku. Wszystkie artykuły pisze %s.`. Natomiast dwa parametry służące do uzupełniania formatu to literały `2015` i `Marcin`.

Powyższy fragment można uprościć używając wcześniej wspomnianej metody `PrintWriter.format`:

```java
System.out.format("Samouczek Programisty istnieje od %d roku. Wszystkie artykuły pisze %s.%n", 2015, "Marcin")
```

W dalszej części artykułu posługiwał będę się tą uproszczoną wersją. Ważne jest żebyś miał jednak świadomość, że pod spodem używana jest instancja klasy `Formatter`.

{% include newsletter-srodek.md %}

## Znaczniki konwersji

Wcześniej użyty łańcuch formatujący to zwykły `String`, wewnątrz którego znajdują się sekwencje interpretowane w specjalny sposób. Sekwencje te zawsze mają format:

    %[indeks argumentu$][flagi][szerokość][.precyzja]konwersja

Wszystkie elementy otoczone nawiasami [] są opcjonalne więc w najprostszej wersji znacznik konwersji może mieć format `%konwersja`. Zwróć jeszcze raz uwagę na łańcuch formatujący

    Samouczek Programisty istnieje od %d roku. Wszystkie artykuły pisze %s.

Jak widzisz znajdują się w nim dwa znaczniki konwersji. Są to `%d` i `%s`. Odnoszą się one do kolejnych argumentów metody `format`. W naszym przypadku są to literały `2015` i `Marcin`.

Znaczniki konwersji informują instancję klasy `Formatter` w jaki sposób dodatkowe parametry powinny być sformatowane. Występuje wiele znaczników konwersji, te najczęściej używane podsumowane są w tabeli poniżej:

| Znacznik | Typ argumentu             | Działanie                                                                                                          |
| :------: | -------------             | ---------                                                                                                          |
| `%b`     | dowolny                   | interpretuje argument jako wartość logiczną                                                                        |
| `%s`     | dowolny                   | interpretuje argument jako łańcuch znaków                                                                          |
| `%d`     | liczba całkowita          | interpretuje argument jako liczbę całkowitą                                                                        |
| `%o`     | liczba całkowita          | interpretuje argument jako liczbę całkowitą zapisaną w systemie ósemkowym                                          |
| `%x`     | liczba całkowita          | interpretuje argument jako liczbę całkowitą zapisaną w systemie szesnastkowym                                      |
| `%f`     | liczba zmiennoprzecinkowa | interpretuje argument jako liczbę zmiennoprzecinkową                                                               |
| `%%`     | -                         | nie potrzebuje argumentu, jest to sposób na umieszczenie znaku `%` wewnątrz sformatowanego łańcucha znaków         |
| `%n`     | -                         | nie potrzebuje argumentu, jest to sposób na umieszczenie znaku nowej linii wewnątrz sformatowanego łańcucha znaków |

### Indeks argumentu

Metoda format przyjmuje łańcuch formatujący i parametry, które służą do wypełnienia znaczników formatujących. Jeśli chciałbyś użyć, któregoś obiektu wiele razy możesz użyć indeksu argumentu. Indeksy mają także zastosowanie jeśli chciałbyś użyć argumentów w innej kolejności. Numeracja argumentów zaczyna się od 1. Proszę spójrz na przykład poniżej:

```java
System.out.format("[%2$s] [%1$s] [%1$s]", "pierwszy argument", "drugi argument");
```

Po uruchomieniu tego kodu na konsoli zostanie wyświetlony napis:

    [drugi argument] [pierwszy argument] [pierwszy argument]

Argument z numerem 1 użyty jest dwa razy, argument 2. użyty jest jako pierwszy w łańcuchu formatującym.
### Szerokość

Możesz także określić minimalną szerokość jaką powinien zająć argument. Domyślnie zostanie on wyrównany do prawej. Proszę spójrz na przykład poniżej:

```java
System.out.format("[%10s] [%3s]", "test", "test");
```

Pierwszy fragment będzie uzupełniony sześcioma spacjami. Dzieje się tak ponieważ test ma cztery znaki a minimalna szerokość to 10. Zauważ, że w drugiej części gdzie minimalna szerokość to 3 żadne dodatkowe spacje nie zostały dodane.

    [      test] [test]

### Precyzja

Dodatkowo dla liczb zmiennoprzecinkowych możesz określić precyzję. Dodając ten modyfikator określasz ile liczb po przecinku powinno być wyświetlonych[^precyzja].

[^precyzja]: Precyzję można także użyć na przykład wraz z `%s`, wtedy oznacza to maksymalną liczbę znaków do wyświetlenia.

Jeśli precyzja zostanie pominięta użyta jest domyślna wartość - sześć miejsc po przecinku. Proszę spójrz na przykład poniżej:

```java
double x = 1.1234567890123;
System.out.format("[%.10f] [%.3f] [%f]", x, x, x);
```

Na konsoli pokażą się trzy liczby. Pierwsza z nich zawiera 10 liczb po przecinku, druga 3 a ostatnia domyślne 6:

    [1.1234567890] [1.123] [1.123457]

### Flagi

Flagi modyfikują zachowanie znaczników konwersji. Poniżej opiszę kilka dostępnych flag:
- `-` element będzie wyrównany do lewej strony,
- `+` liczba zawsze będzie zawierała znak (nawet jeśli jest dodatnia),
- `0` liczba będzie uzupełniona `0` do żądanej szerokości,
- `(` liczby ujemne nie będą prezentowane ze znakiem, będą otoczone `()`,
- `,` użyj separatora do grupowania liczb. Ten separator zależny jest od lokalizacji.

Jeden znacznik może zawierać kilka flag. Dodatkowo wszystkie opisane wcześniej elementy mogą być połączone ze sobą.

## Lokalizacja

W uproszczeniu lokalizacja to zbiór reguł, które określają w jaki sposób należy prezentować dany łańcuch znaków. Można powiedzieć, że jest to swego rodzaju tłumaczenie na reguły obowiązujące w danym kraju/regionie. To lokalizacja ma wpływ na to, jak na przykład wyświetlane są daty czy liczby.

Do tej pory w całym artykule używałem metod, które używały domyślnej lokalizacji, możesz ją uzyskać odwołując się do metody [`Locale.getDefault`](https://docs.oracle.com/javase/8/docs/api/java/util/Locale.html#getDefault-java.util.Locale.Category-). `Formatter` pozwala także na formatowanie łańcucha znaków używając innych ustawień lokalizacji.

Proszę spójrz na przykład poniżej. Ta sama liczba prezentowana jest używając trzech różnych ustawień lokalizacji. Zwróć uwagę na to, że w każdym przypadku otrzymujemy różne wyniki:

```java
double someNumber = 12345.12;
System.out.format(Locale.US, "%,.2f%n", someNumber);
System.out.format(Locale.GERMAN, "%,.2f%n", someNumber);
System.out.format(Locale.forLanguageTag("PL"), "%,.2f%n", someNumber);
```

    12,345.12
    12.345,12
    12 345,12

Wyniki różnią się separatorem dziesiętnym (`.` lub `,`) i separatorem grup liczb (`,`, `.` lub ` `).
## Bardziej skomplikowany przykład

Teraz masz już wystarczająco dużo informacji aby zrozumieć pierwszy przykład użyty na początku artykułu. Dla przypomnienia:

    %2$08.3f %3$(,08.3f %s

Rozkładając ten łańcuch formatujący na części widzisz trzy znaczniki formatujące:
- `%2$08.3f`,
- `%3$(,08.3f`,
- `%s`.

Rozkładając najbardziej skomplikowany z nich `%3$(,08.3f` na części pierwsze otrzymujemy:
- `%3$` odwołanie się do trzeciego argumentu,
- `(` otoczenie liczb ujemnych nawiasami `()`,
- `,` użycie separatora grup liczb,
- `0` uzupełnienie liczby zerami,
- `8` ustawienie minimalnej szerokości wyświetlanej liczby na osiem znaków,
- `.3` wyświetlenie trzech miejsc dziesiętnych,
- `f` konwersja liczby zmiennoprzecinkowej.

## Ćwiczenie do wykonania

Plik CSV zawiera trzy kolumny oddzielone znakiem `,`. Pierwsza kolumna zawiera imię, druga liczbę zmiennoprzecinkową trzecia dzień tygodnia. Twoim zadaniem jest wczytanie zawartości [tego pliku](https://raw.githubusercontent.com/SamouczekProgramisty/KursJava/master/27_lancuchy_znakow_formatowanie/src/main/resources/test.csv) i wyświetlenie jej w formie tabeli. Efekt, który chcesz uzyskać wygląda następująco:

    | Piotrek | 123.12  | poniedziałek |
    | Tomek   | 321.30  | wtorek       |
    | Marcin  | -123.12 | środa        |
    | Wojtek  | -3.12   | czwartek     |

Zachęcam Cię do rozwiązania zadania samodzielnie. Jeśli jednak będziesz miał problem z jego rozwiązaniem przygotowałem dla Ciebie [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/KursJava/blob/master/27_lancuchy_znakow_formatowanie/src/main/java/pl/samouczekprogramisty/kursjava/strings/formatting/ExerciseSolution.java).

## Dodatkowe materiały do nauki

Artykuł ten to “skrót” dokumentacji dla klasy klasy `Formatter`. Jeśli chcesz dowiedzieć się czegoś więcej zachęcam do przeczytania [dokumentacji tej klasy](https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html). Dodatkowo możesz także przejrzeć [kod źródłowy wszystkich przykładów](https://github.com/SamouczekProgramisty/KursJava/blob/master/27_lancuchy_znakow_formatowanie/src/main/java/pl/samouczekprogramisty/kursjava/strings/formatting/StringFormatting.java) użytych w tym artykule.

## Podsumowanie

W artykule przeczytałeś o formatowaniu łańcuchów znaków. Wiesz jak formatować liczby zmiennoprzecinkowe, poznałeś klasę Formatter wraz miejscami gdzie jest ona używana. Rozwiązując ćwiczenie wykorzystałeś całą wiedzę w praktyce.

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli masz jakieś pytania nie wahaj się zadać je w komentarzach. Jeśli nie chcesz pominąć kolejnych artykułów polub Samouczka na facebooku i dopisz się do newslettera. Do następnego razu.
