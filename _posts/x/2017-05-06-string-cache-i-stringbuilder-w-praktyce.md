---
layout: default
title: String cache i StringBuilder w praktyce
date: '2017-05-06 23:46:34 +0200'
categories:
- Kurs programowania Java
- DSP2017
excerpt_separator: "<!--more-->"
permalink: "/string-cache-i-stringbuilder-w-praktyce/"
---
Znajomość biblioteki standardowej w zakresie pracy z łańcuchami znaków jest niezbędna do wydajnej pracy. Świadomość pewnych ograniczeń i właściwości związanych z łańcuchami znaków także się przydaje. Po lekturze tego artykułu będziesz znał te mechanizmy. Dowiesz się także czym jest cache i jak jest on używany w przypadku literałów znakowych. Poznasz klasę `StringBuilder` i dowiesz się dlaczego jest taka ważna. Zapraszam do lektury!

# Literał znakowy
  
Na początku powtórka podstaw. Literał znakowy to ciąg znaków otoczony cudzysłowami. Jest to instancja klasy `String`, jednak tworzona jest bez udziału słówka kluczowego `new`. Przykład poniżej pokazuje literał znakowy przypisany do zmiennej:

    String someLiteral = “some constant value”;

# Jak działa klasa `String`
  
Instancje klasy `String` reprezentują łańcuchy znaków. Wewnętrznie znaki te przetrzymywane są w tablicy znaków. Tablica ta ma typ `char[]`. Implementacja klasy `String` chowa przed programistą mechanizmy operowania na tej tablicy.

Instancje klasy `String` są niemutowalne. Oznacza to tyle, że po stworzeniu instancji nie ma możliwości jej modyfikacji. Kilka metod wymienionych poniżej zwraca nowe instancje, pozostawiając tę na której zostały wywołane bez zmian:

- [`replace`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#replace-char-char) - podmienia znak w łańcuchu znaków,
- [`substring`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#substring-int-) - zwraca pewną część łańcucha znaków określoną indeksami,
- [`toLowerCase`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#toLowerCase--) - zamienia wielkie litery na małe w nowej instancji,
- [`toUpperCase`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#toUpperCase--) - zamienia łańcuch znaków na wielkie litery,
- [`trim`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#trim--) - zwraca nową instancję bez początkowych i końcowych białych znaków.
  

# Co jeśli String nie ma metody, której potrzebuję?
  
Chociaż klasa `String` zawiera spory zestaw metod, nie jest to lista kompletna. Jeśli trafisz na taki przypadek nie próbuj wynaleźć koła na nowo. Lepiej rzuć okiem na istniejące biblioteki. Na przykład na [commons-lang](https://commons.apache.org/proper/commons-lang/) . Biblioteka ta zawiera klasę [`StringUtils`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html), w której znajdziesz masę przydatnych metod operujących na łańcuchach znaków.
# Konkatenacja łańcuchów znaków
  
Najprostszym sposobem otrzymania łańcucha znaków jaki nas interesuje jest złożenie go z wielu części. Służy do tego operator `+`. Operacja ta nazywana jest konkatenacją.

    System.out.println("some" + " " + "string" + " " + "literal");

  
W przypadku konkatenacji każdy z elementów konwertowany jest do typu `String` używając metody `toString`[^tostring]:

[^tostring]:  Nie jest to do końca prawda, na przykład w przypadku typów prymitywnych stosowany jest inny mechanizm, zależny od typu zmiennej.

```java
int x = 10;
Object y = new Object();
System.out.println("some" + " " + x + " " + "literal" + " " + y);
```
  
Używanie operatora `+` może być bardzo wygodne jednak czasami może prowadzić do zaskakujących (na początku) rezultatów. Proszę porównaj dwie poniższe linijki kodu:

    System.out.println(1 + 2 + "test"); // 3testSystem.out.println("test" + 1 + 2); // test12

  
Pierwsza z nich na początku doda dwie liczby uzyskując 3 a następnie dołączy do niej łańcuch znaków. Druga do łańcucha znaków dołączy dwie kolejne liczby. Dzieje się tak ponieważ operator `+` jest lewostronnie łączny. Oznacza to tyle, że w tym przypadku wyrażenie to wykonywane jest od lewej do prawej strony.

W pierwszym przypadku do liczby 1 dodajemy liczbę 2, następnie "dodajemy" do niej łańcuch znaków. W drugim przypadku do łańcucha znakód dodajemy kolejno dwie liczby.

Klasa `String` posiada także metodę `concat`, która działa w podobny sposób do operatora `+`[^operator].

[^operator]: Istnieją oczywiście drobne różnice, na przykład zachowanie w odniesieniu do zmiennych o wartości `null`.

# Wydajność a konkatenacja
  
Wiesz już, że instancje klasy `String` są niemutowalne. Wszystkie metody znajdujące się w klasie `String`, modyfikują łańcuch znaków tak na prawdę tworzą jego nową instancję.

Nie inaczej jest z konkatenacją. Proszę spójrz na przykład poniżej:

    String some = "some";String space = " ";String random = "random";String string = "string";String someString = some + space + random + space + string;

  
Tak na prawdę, zanim powstałaby finalna instancja klasy `String` potrzebne byłoby aż trzy “tymczasowe” obiekty[^optymalizacje]. Dopiero piąty obiekt byłby tym, który mógłby być przypisany do zmiennej `someString`. Dlaczego aż cztery? Wynika to z niemutowalności instancji klasy `String`. Nie możemy, posługując się wyłącznie instancjami klasy `String` od razu stworzyć finalnej wersji. Tworzone są obiekty “pośrednie”:

[^optymalizacje]: Piszę “potrzebne byłby” ponieważ kompilator wprowadza tu pewne optymalizacje, o których przeczytasz niżej.

- `“some “` (zwróć uwagę na spację na końcu),
- `“some random”`,
- `“some random “` (ponownie ze spacją).
  
  
Tworzenie takich nowych tymczasowych instancji nie jest wydajne. Można to zrobić lepiej. Z pomocą przychodzą klasy `StringBuilder` i `StringBuffer`[^kompilator].

[^kompilator]: Prawda jest taka, że kompilator Java w trakcie kompilacji wykrywa taką konkatenacją i zastępuje ją właśnie wywołaniem odpowiednich metod na instacji klasy `StringBuilder`. Więc w prostych przypadkach tragedii nie ma, gorzej jeśli w grę wchodzą pętle ;).

## Jak używać klasy `StringBuilder`
  
Klasa [`StringBuilder`](https://docs.oracle.com/javase/7/docs/api/java/lang/StringBuilder.html) podobnie jak `String` jest opakowaniem tablicy znaków typu `char[]`. `StringBuilder` jednak jest typem mutowalnym. Instancje tego typu w można konwertować do typu `String` używając metody `toString`.

Najprosztszym sposobem utworzenia instancji klasy `StringBuilder` jest użycie konstruktora bezparametrowego. Następnie możesz modyfikować ten obiekt używając dostępnych metod.

Bardzo przydatną metodą z tej klasy jest przeciążona metoda `append`. Pozwala ona na wydajne łączenie łańcuchów znaków. Proszę spójrz na przykład poniżej pokazujący sposób użycia klasy:

    public void compilerConcatenationFiddling() { String some = "some"; String space = " "; String random = "random"; String string = "string"; StringBuilder someSttringBuilder = new StringBuilder(); someSttringBuilder.append(some); someSttringBuilder.append(space); someSttringBuilder.append(random); someSttringBuilder.append(space); someSttringBuilder.append(string); String someString = someSttringBuilder.toString();}

## Różnica pomiędzy `StringBuilder` a `StringBufer`
  
Istnieje też inna implementacja tej samej funkcjonalności. Jest to klasa [`StringBuffer`](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuffer.html). Jeśli masz przed sobą rozmowę kwalifikacyjną dobrze jest znać różnicę między tymi klasami. Jest to jedno ze “sztampowych” pytań rekrutacyjnych ;).

Główną różnicą jest to, że instancję klasy `StringBuffer` można bezpiecznie używać nawet w aplikacjach wielowątkowych. Instancje klasy `StringBuilder` nie powinny być współdzielone pomiędzy wątkami. Cecha ta ma jedną ważną konsekwencję. Ze względu na brak synchronizacji instancje klasy `StringBuilder` są nieznacznie szybsze od `StringBuffer`.

Dodatkowo możesz zapoznać się też z klasą [`StringJoiner`](https://docs.oracle.com/javase/8/docs/api/java/util/StringJoiner.html), która oferuje podobną funkcjonalność. Jest ona wykorzystywana na przykład podczas łączenia strumieni.

# Optymalizacja konkatenacji przez kompilator
  
Mamy dwa elementy układanki. Klasę `StringBuilder`, która dużo lepiej się sprawdza przy pracy z łączeniem znaków. Konkatenację, która nie jest wydajnym sposobem łączenia łańcuchów znaków.

Mamy też metodę `append`, którą już poznałeś. Jest ona odpowiednikiem `+` w konkatenacji. Nie można czegoś z tym zrobić?

Oczywiście, że można! I to właśnie jest robione przez kompilator. Tak naprawdę, pisząc kod:

    String some = "some";String space = " ";String random = "random";String string = "string";String someString = some + space + random + space + string;

  
Kompilator kompiluje go do postaci, która wygląda podobnie do fragmentu niżej:

    String some = "some";String space = " ";String random = "random";String string = "string";StringBuilder x = new StringBuilder();x.append(some);x.append(space);x.append(random);x.append(space);x.append(string);String someString = x.toString();

  
Innymi słowy kompilator optymalizuje za nas kod. Czy ta optymalizacja zawsze działa? Niestety nie, są przypadki kiedy nawet taka optymalizacja nie daje rady. Proszę spójrz na przykład poniżej. Jest to pętla, która dołącza aktualny stan licznika do łańcucha znaków.

    String finalString = "";for (int counter = 0; counter < 1000000; counter++) { finalString = finalString + " " + counter;}

  
Jak zoptymalizuje to kompilator? Będzie to kod podobny do tego:

    String finalString = "";for (int counter = 0; counter < 1000000; counter++) { StringBuilder x = new StringBuilder(); x.append(finalString); x.append(" "); x.append(counter); finalString = x.toString();}

  
Niestety mimo optymalizacji wewnątrz pętli dalej musimy tworzyć blisko milion obiektów tymczasowych. To jest czasochłonne. Lepszym rozwiązaniem jest poniższy fragment kodu:

    StringBuilder finalStringBuilder = new StringBuilder();for (int counter = 0; counter < 1000000; counter++) { finalStringBuilder.append(" "); finalStringBuilder.append(counter);}String finalString = finalStringBuilder.toString();

  
W tym przypadku sam tworzę instancję klasy `StringBuilder` i używam jej wewnątrz pętli.
# Literały i cache
  
Specyfikacja języka Java narzuca pewne wymagania związane z optymalizacją pracy z łańcuchami znaków. Każdy łańcuch znaków, który jest literałem umieszczany jest w cache’u.

Tutaj drobna dygresja. Cache to mechanizm, który pozwala na przetrzymywanie wartości jakiegoś typu. Przeważnie uzyskanie tej wartości jest czasochłonne. Założeniem tego mechanizmu jest pozwolenie na szybsze dotarcie do tych wartości w późniejszym czasie. Dodatkowo pozwala on na optymalizację zajmowanego miejsca. Elementy znajdujące się w cache’u przeważnie się nie powtarzają. Cache może być zrealizowany na wiele sposobów, najprostszą implementacją może być zwykła instancja [`HashMap`](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html). W bardziej zaawansowanych zastosowaniach używa się osobnych programów/baz danych, które zapewniają tę funkcjonalność, na przykład [memcached](https://memcached.org/).
{: .notice--info}

Oznacza to tyle, że poniższe dwie zmienne są referencjami na dokładnie ten sam obiekt na stercie. Dzieje się tak, ponieważ są one literałami o tej samej zawartości:

Poniższe fragmenty kodu są testami jednostkowymi. Jeśli chcesz przeczytać więcej na ten temat zapraszam do arytkułu poświęconemu [testom jednostkowym w Javie](http://www.samouczekprogramisty.pl/testy-jednostkowe-z-junit/). Możesz też przeczytać kolejny artykuł poświęcony [Test Driven Development](http://www.samouczekprogramisty.pl/test-driven-development-na-przykladzie/).
{: .notice--info}

    @Testpublic void twoLiterals() { String someVariable = "samouczek programisty"; String otherVariable = "samouczek programisty"; assertEquals(someVariable, otherVariable); assertSame(someVariable, otherVariable);}
  
Pierwsze porównanie, sprawdza “zawartość” łańcucha znaków. Drugie porównuje adresy obiektów na stercie.

W przypadku utworzenia nowej instancji przy pomocy wywołania konstruktora, zawsze tworzone są nowe obiekty. Proszę porównaj poprzedni fragment kodu z tym poniżej:

    @Testpublic void twoNewObjects() { String someVariable = new String("samouczek programisty"); String otherVariable = new String("samouczek programisty"); assertEquals(someVariable, otherVariable); assertNotSame(someVariable, otherVariable);}

  
W tym przypadku mamy do czynienia z dwoma osobnymi obiektami. W tym przypadku adresy obiektów są różne.
## Metoda `String.intern`
  
Istnieje sposób aby zachować wartość łańcucha znaków w cache (lub pobrać go z cache). Dzięki tej metodzie w cache'u możemy zachować nawet instancje utworzone przy pomocy konstruktora. Służy do tego metoda [`intern`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#intern--). Wywołanie tej metody zachowuje w cache'u dany łańcuch znaków i zwraca instancję, która jest w cache'u zachowana. Jeśli ten literał istnieje już w cache'u, będzie tam zachowany wyłącznie raz.

Proszę spójrz na przykład poniżej

    @Testpublic void literalAndInternedObject() { String someVariable = "samouczek programisty"; String otherVariable = new String("samouczek programisty").intern(); assertEquals(someVariable, otherVariable); assertSame(someVariable, otherVariable);}

  
W tym przypadku oba porównania zwrócą wartość `true`.
# Dodatkowe materiały do nauki
  
Poniżej przygotowałem dla Ciebie zestaw odnośników, które mogą pomóc w rozwijaniu wiedzy związanej z pracą z łańcuchami znaków:
- [Java Language Specification o konkatenacji](https://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.18.1),
- dokumentacja klasy [`StringUtils`](https://github.com/apache/commons-lang/blob/master/src/main/java/org/apache/commons/lang3/StringUtils.java),
- dokumentacja klasy [`StringBuilder`](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html),
- dokumentacja klasy [`StringBuffer`](https://docs.oracle.com/javase/8/docs/api/java/lang/StringBuffer.html),
- dokumentacja klasy [`StringJoiner`](https://docs.oracle.com/javase/8/docs/api/java/util/StringJoiner.html),
- [kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/KursJava/tree/master/26_lancuchy_znakow/src).
  

# Podsumowanie
  
Po lekturze tego artykułu sporo wiesz o pracy z łańcuchami znaków. Poznałeś jedną z optymalizacji, które wprowadza kompilator. Umiesz odpowiedzieć na jedno ze sztampowych pytań rekrutacyjnych ;). Znasz sposób pracy z klasą `StringBuilder`. Dowiedziałeś się też o przydatnych metodach operujących na instancjach klasy `String` znajdujących się w bibliotece commons-lang.

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz pominąć żadnego postu polub stronę na facebooku i dopisz się do samouczkowego newslettera. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/jasohill/54816310/sizes/l

