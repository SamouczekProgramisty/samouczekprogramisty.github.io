---
last_modified_at: 2019-02-13 15:22:30 +0100
title: Kolekcje w języku Java
categories:
- Kurs programowania Java
- Programowanie
permalink: /kolekcje-w-jezyku-java/
header:
    teaser: /assets/images/2016/08/09_kolekcje_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2016/08/09_kolekcje_w_jezyku_java_artykul.jpg
excerpt: W tym artykule przeczytasz o kolekcjach w języku Java. Dowiesz się czym są kolekcje, kiedy można ich używać. Poznasz podstawowe kolekcje takie jak mapa, zbiór czy lista. Jak zwykle na koniec czekały będą na Ciebie zadania, przy których przećwiczysz materiał opisany w tym artykule. Zwrócę też uwagę na parę skrótów klawiaturowych, które mogą Ci się przydać podczas pracy z kodem. Zapraszam do lektury!
disqus_page_identifier: 115 http://www.samouczekprogramisty.pl/?p=115
---

{% include kurs-java-notice.md %}

## Biblioteka standardowa

Java, podobnie jak wiele innych języków, w tak zwanej bibliotece standardowej[^std] zawiera zestaw kolekcji. Kolekcja to nic innego jak sposób grupowania obiektów. Kolekcją możemy także nazwać tablicę obiektów, którą już znasz. Jednak tego typu kolekcja na pewne ograniczenia, głównym z nich jest to, że rozmiar, który ustalimy na początku nie może być zmieniony.

[^std]: Biblioteka standardowa to zestaw klas, które może używać programista, dostarczonych wraz z językiem programowania.

Kolekcje możemy opisać jako „tablice na sterydach”. Pozwalają one na dużo więcej niż przechowywanie obiektów w kolejności określonej przez tablicę.

Kolekcje to implementacje tak zwanych struktur danych. O przykładowych implementacjach struktur danych na pewno przeczytasz w jednym z kolejnych artykułów. Na dzisiaj musisz zapamiętać, ze rodzaj kolekcji/struktury danych pozwala napisać program, który jest bardziej bądź mniej wydajny (działa szybciej lub wolniej). To, jaką kolekcję w danym momencie użyjemy ma znaczenie. W kolejnych akapitach postaram się przytoczyć podstawowe kolekcje wraz z przykładami ich użycia.

## Hierarchia dziedziczenia

Kolekcje w standardowej bibliotece Javy implementują różne interfejsy, poniższy diagram pokazuje hierarchię dziedziczenia interfejsów dla podstawowych typów kolekcji dostępnych w Javie. Każdy z tych interfejsów ma kilka implementacji, których używa się w różnych sytuacjach.

{% include figure image_path="/assets/images/2016/08/09_kolekcje_dziedziczenie.jpg" caption="Dziedziczenie kolekcji w języku Java." %}

## Lista

Lista (ang. _list_) podobnie jak tablica, grupuje elementy. Jej główną przewagą nad tablicą jest to, że programista nie musi się przejmować rozmiarem listy[^oom], jest ona automatycznie powiększana wraz z dodawaniem nowych elementów. Listy w języku Java reprezentowane są przez interfejs `java.util.List`. Listy z definicji są kolekcjami dla których kolejność elementów jest istotna, mogą przechowywać ten sam obiekt po kilka razy. Podstawowymi przykładami implementacji interfejsu `java.util.List` są klasy `java.util.LinkedList` oraz `java.util.ArrayList`.

[^oom]: Oczywiście w granicach rozsądku, w skrajnych przypadkach utworzenie listy ze zbyt dużą liczbą elementów może prowadzić do wystąpienia błędu `OutOfMemoryError`.

Bez wdawania się w zbędne szczegóły, proszę zapamiętaj, że `LinkedList` lepiej jest używać jeśli często usuwasz elementy z listy, a `ArrayList` lepiej jest używać jeśli często chcesz mieć dostęp do losowych elementów w liście. Obiecuje, że dokładne wytłumaczenie dlaczego tak się dzieje znajdziesz w jednym z kolejnych artykułów.

{% include newsletter-srodek.md %}

### Przydatne metody w `java.util.List`

Chciałbym pokazać Ci parę metod, które mogą Ci się przydać przy pracy z listami. Jeśli jesteś zainteresowany pełną listą zachęcam do przeczytania [dokumentacji dla interfejsu `List`]({{ site.doclinks.java.util.List }}), tam znajdziesz wszystkie niezbędne szczegóły.

Załóżmy, że nasza zmienna jest typu `List<String>`. Wówczas będziesz mógł używać m.in. następujących metod:

- `add` – dodaje element do listy,
- `addAll` – jako parametr przyjmuje inną kolekcję i dodaje wszystkie elementy z tej kolekcji do listy,
- `contains` – jako parametr przyjmuje element listy i zwraca flagę informującą czy dany element już istnieje (tutaj przyda Ci się artykuł o porównywaniu obiektów w języku Java),
- `isEmpty` – bezargumentowa metoda zwracająca flagę informującą czy lista jest pusta,
- `size` – bezargumentowa metoda zwracająca liczbę elementów w liście,
- `indexOf` – metoda jako parametr przyjmuje element listy i zwraca indeks pierwszego wystąpienia,
- `lastIndexOf` – metoda jako parametr przyjmuje element listy i zwraca indeks ostatniego wystąpienia.

Opisane wyżej metody użyte zostały w kodzie poniżej.

```java
List<String> listWithNames = new LinkedList<>();
listWithNames.add("Piotrek");
listWithNames.add("Krzysiek");

List<String> otherListWithNames = new LinkedList<>();
otherListWithNames.add("Marek");
otherListWithNames.addAll(listWithNames);
otherListWithNames.add("Marek");

System.out.println(otherListWithNames.contains("Marek"));
System.out.println(otherListWithNames.get(0));
System.out.println(otherListWithNames.isEmpty());
System.out.println(otherListWithNames.indexOf("Marek"));
System.out.println(otherListWithNames.lastIndexOf("Marek"));
```

Tutaj drobna dygresja, w kodzie wyżej widzisz zapis `List<String> listWithNames = new LinkedList<>()`. Dlaczego nie napisać `LinkedList<String> listWithNames = new LinkedList<>()`? Pierwsza wersja pokazuje dobrą praktykę, która polega na definiowaniu zmiennych typu interfejsu a nie klasy implementującej ten interfejs. Dzięki temu w przyszłości z łatwością moglibyśmy przypisać do `listWithNames` zmienną typu `ArrayList<String>` bez konieczności zmiany pozostałej części programu.
{: .notice--success}

## Zbiór

Zbiór (ang. _set_) to kolekcja, która służy do przechowywania unikalnych elementów. Zbiory w języku Java implementują interfejs `java.util.Set`. W przypadku zbioru nie jest istotna kolejność dodawanych elementów. Innymi słowy jeśli do zbioru dodamy na początku element X a później Y to przechodząc po kolei po elementach zbioru możemy dostać je w odwrotnej kolejności. Istnieją także implementacje zbioru, w których kolejność elementów jest zachowana, jednak jest to raczej „szczegół implementacyjny” niż szczególna właściwość zbiorów.

Kolejną cechą zbioru jest to, że przechowuje on unikalne elementy. W odróżnieniu od listy, w zbiorze można przechowywać wyłącznie jedną instancję obiektu.

Skąd możemy wiedzieć, że dana instancja jest już w zbiorze? Otóż służą do tego opisane już metody `hashCode` oraz `equals`.

Jeszcze raz przypomnę o kontrakcie między tymi metodami. Poprawne działanie kolekcji wymaga poprawnie zaimplementowanych metod `hashCode`/`equals`. Jeśli ten warunek nie jest spełniony niektóre kolekcje mogą działać w dziwny, niespodziewany sposób.

Najważniejszą implementacją interfejsu `Set` jest klasa `java.util.HashSet`.

### Przydatne metody w `java.util.Set`

Podobnie jak w przypadku list zachęcam do zapoznania się z [pełną listą metod dostępnych w interfejsie `Set`]({{ site.doclinks.java.util.Set }}). Poniżej lista kilku przydatnych metod:
- `add` – dodaje element do zbioru,
- `addAll` – jako parametr przyjmuje inną kolekcję i dodaje wszystkie elementy z tej kolekcji do zbioru (pomijając duplikaty),
- `contains` – jako parametr przyjmuje element zbioru i zwraca flagę informującą czy dany element już istnieje,
- `isEmpty` – bezargumentowa metoda zwracająca flagę informującą czy zbiór jest pusty,
- `size` – metoda zwraca ilość elementów w zbiorze.

Przykład użycia metod znajduje się we fragmencie kodu poniżej.

```java
Set<String> setWithNames = new HashSet<>();
setWithNames.add("Marcin");
setWithNames.add("Marek");
setWithNames.add("Marcin");
 
Set<String> otherSet = new HashSet<>();
otherSet.add("Zenon");
otherSet.add("Marek");
 
setWithNames.addAll(otherSet);
 
System.out.println(setWithNames.isEmpty());
System.out.println(setWithNames.size());
System.out.println(setWithNames.contains("Marcin"));
System.out.println(setWithNames.remove("Janusz"));
```

## Mapa

Mapa (ang. _map_) jest kolekcją, która pozwala przechować odwzorowanie zbioru kluczy na listę wartości. Innymi słowy w mapie możemy trzymać klucze, którym odpowiadają wartości. Klucze muszą być unikalne (dlatego pisałem o zbiorze kluczy), wartości natomiast mogą się powtarzać. Czyli pod kluczem A i pod kluczem B może być ta sama wartość X. Ale sytuacja odwrotna gdzie klucz X występuje dwa razy i jeden z nich wskazuje na element A a inny na element B nie jest możliwa[^implementaje].

[^implementaje]: Tu znów dygresja, oczywiście istnieją implementacje, które pozwalają na takie zachowanie, jednak nie jest to „domyślne” zachowanie.

Czytając inne źródła możesz natknąć się na inne nazwy. Słownik, tablica asocjacyjna, mapa – to pojęcia opisujące dokładnie tę samą strukturę danych.

Kluczami w mapie powinny być obiekty, których nie można zmodyfikować (ang. _immutable_). Np dobrymi kandydatami na klucze są instancje takich klas jak `String` czy `Integer` – są to obiekty, których po zainicjalizowaniu nie możemy zmodyfikować. Ponadto klasy kluczy muszą poprawnie implementować metody `hashCode`/`equals`. Jeśli jakaś para (klucz, wartość1) istnieje jest w mapie, a Ty spróbujesz dodać kolejną (klucz, wartość2) (ten sam klucz). Wówczas ta ostatnia para będzie przechowywana przez mapę, nadpisze ona poprzedni element.

Podobnie jak `Set` i `List`, `Map` jest interfejsem generycznym, jednak w tym przypadku wymaga on dwóch klas – pierwsza z nich definiuje typ kluczy, druga typ wartości przechowywanych w mapie.

Standardową implementacją mapy w języku Java jest klasa `java.util.HashMap`.

### Przydatne metody w `java.util.Map`

- `put` – dodaje parę klucz/wartość do mapy,
- `putAll` – jako parametr przyjmuje inną mapę i dodaje wszystkie elementy z do mapy,
- `containsKey` – jako parametr przyjmuje klucz i zwraca flagę informującą czy dany klucz już istnieje,
- `containsValue` – jako parametr przyjmuje wartość i zwraca flagę informującą czy dana wartość już istnieje,
- `isEmpty` – bezargumentowa metoda zwracająca flagę informującą czy mapa jest pusta,
- `size` – bezargumentowa metoda zwracająca liczbę elementów w mapie,
- `remove` – metoda jako parametr przyjmuje klucz i usuwa parę klucz/wartość z mapy,
- `get` – metoda jako parametr przyjmuje klucz i zwraca odpowiadającą mu wartość.

Przykłady użycia metod znajdziesz we fragmencie kodu poniżej.

```java
Map<String, String> pairsMap = new HashMap<>();
pairsMap.put("Marcin", "Adela");
pairsMap.put("Marek", "Magda");
 
Map<String, String> otherPairsMap = new HashMap<>();
otherPairsMap.put("Marek", "Ewa");
otherPairsMap.put("Adam", "Ewa");
 
pairsMap.putAll(otherPairsMap);
 
System.out.println(pairsMap.get("Marek"));
System.out.println(pairsMap.remove("Marek"));
System.out.println(pairsMap.size());
System.out.println(pairsMap.isEmpty());
System.out.println(pairsMap.containsKey("Jan"));
System.out.println(pairsMap.containsValue("Adela"));
```

Pełna lista metod dostępna w interfejsie `Map` znajduje się w [dokumentacji]({{ site.doclinks.java.util.Map }}).
## Skróty klawiaturowe

W IDE, które proponowałem na początku (IntelliJ IDEA) jest skrót klawiaturowy, który bardzo może Ci się przydać w odkrywaniu nowych metod. Po wpisaniu zmiennej i kropki po niej naciśnij `<Ctrl + Spacja>` pojawi się menu kontekstowe z dostępnymi atrybutami/metodami tego obiektu.

{% include figure image_path="/assets/images/2016/08/09_tooltip.png" caption="Skróty klawiaturowe w IntelliJ IDEA" %}

Kolejny przydatny skrót klawiaturowy to `<Ctrl + H>`. Najedź kursorem na interfejs `List`, po naciśnięciu tego skrótu pojawi się panel zawierający hierarchię dziedziczenia dla elementu pod kursorem. Także ten panel jest widoczny na zrzucie ekranu powyżej.

Dzięki szybkiemu wglądowi w hierarchii dziedziczenia możesz w łatwy sposób odnaleźć inne implementacje danego interfejsu.

## Ograniczenia kolekcji

Jak już napisałem wyżej „kolekcje to tablice na sterydach”. Z tymi sterydami przychodzą także pewne ograniczenia. Głównym ograniczeniem jest to że wraz z kolekcjami opisanymi powyżej nie możesz używać typów prymitywnych (`Integer` tak, `int` nie). Możesz to łatwo obejść poprzez używanie odpowiadających im obiektów, jednak obiekty takie zajmują więcej miejsca w pamięci niż typy prymitywne.

Istnieją implementacje kolekcji, które pozwalają na używanie typów prymitywnych jednak na tym etapie nauki Javy nie zaprzątałbym sobie nimi głowy. Standardowe kolekcje są w zupełności wystarczające.

## Iterowanie po kolekcjach

Z artykułu opisującego pętle dowiedziałeś się o różnych rodzajach pętli i to właśnie na nich tutaj się skupimy[^strumienie].

[^strumienie]: Na początku pominiemy strumienie, którymi zajmiemy się w osobnym artykule.

### Iterowanie po listach

Najprostszym sposobem jest iterowanie przy użyciu pętli `foreach`. Zgodnie z definicją listy elementy będą zwracane w kolejności dodawania ich do listy.

Jeśli potrzebujemy dostępu do indeksu elementu możemy użyć także standardowej pętli `for`. Jeśli takie podejście jest wymagane lepiej jest używać implementacji `ArrayList` niż `LinkedList`.

```java
List<String> sampleList = new ArrayList<>();
sampleList.add("Marcin");
sampleList.add("Adela");
sampleList.add("Marek");
sampleList.add("Magda");
 
System.out.println("Iterowanie po liscie (foreach)");
for(String item : sampleList) {
    System.out.println(item);
}
 
System.out.println("Iterowanie po liscie (for)");
for(int index = 0; index < sampleList.size(); index++) {
    System.out.println(sampleList.get(index));
}
```

### Iterowanie po zbiorach

Podobnie jak w przypadku list z pomocą przychodzi pętla `foreach`, jednak tutaj nie mamy już gwarancji zwrócenia obiektów zbioru w tej samej kolejności, w której były one do niego dodawane (zachęcam do sprawdzenia tego samodzielnie).

```java
Set<String> sampleSet = new HashSet<>();
sampleSet.add("Marcin");
sampleSet.add("Adela");
sampleSet.add("Marek");
sampleSet.add("Magda");
 
System.out.println("Iterowanie po zbiorze");
for(String item : sampleSet) {
    System.out.println(item);
}
```

### Iterowanie po mapach

Z racji tego, że w mapach mamy zbiór kluczy mapowanych na wartości możemy iterować po samych kluczach, samych wartościach bądź parach klucz, wartość. Powinniśmy używać odpowiedniego sposobu w zależności od naszych potrzeb.

Kolejna dygresja, nowością może być dla Ciebie zapis `Map.Entry<String, String>`. Jest to notacja wskazująca na tak zwaną klasę wewnętrzną (bądź inerfejs). Interfejs `Entry` został zdefiniowana wewnątrz `Map` dlatego odwołujemy się do niego poprzez `Map.Entry`. Jest to interfejs generyczny, który odpowiada parze klucz/wartość, dlatego typowany jest tymi samymi typami co mapa z przykładu.
{: .notice--success}

```java
Map<String, String> sampleMap = new HashMap<>();
sampleMap.put("Marek", "Magda");
sampleMap.put("Marcin", "Adela");
 
System.out.println("Iterowanie po wartosciach");
for(String value : sampleMap.values()) {
    System.out.println(value);
}
 
System.out.println("Iterowanie po kluczach i pobieranie wartosci");
for(String key : sampleMap.keySet()) {
    String value = sampleMap.get(key);
    System.out.println(key + ": " + value);
}
 
System.out.println("Iterowanie po kluczach i wartosciach");
for(Map.Entry<String, String> entry : sampleMap.entrySet()) {
    String key = entry.getKey();
    String value = entry.getValue();
    System.out.println(key + ": " + value);
}
```

## Porównanie typów kolekcji

Na koniec dla ułatwienia przygotowałem dla Ciebie tabelkę, która grupuje właściwości poszczególnych kolekcji w jednym miejscu wraz z przykładem użycia.

|                                                                | Lista                                                          | Zbiór | Mapa |
|                                                                | -----                                                          | ----- | ---- |
| Zachowuje kolejność elementów                                  | Tak                                                            | Nie   | Nie  |
| Pozwala na przechowywanie kliku takich samych elementów/kluczy | Tak                                                            | Nie   | Nie  |
| Przykład użycia (podróżowałeś przez Europę pociągiem)          | Miasta, które odwiedziłeś (cała trasa z drogą powrotną, niektóre miasta odwiedziłeś także przy powrocie) | Zbiór miast, które odwiedziłeś (bez duplikatów). | Nazwy państw, które odwiedziłeś wraz z odpowiadającymi im stolicami. |

## Zadania

1. Napisz program, który będzie pobierał od użytkownika imiona. Program powinien pozwolić użytkownikowi na wprowadzenie dowolnej liczby imion (wprowadzenie „-” jako imienia przerwie wprowadzanie). Na zakończenie wypisz liczbę unikalnych imion.
2. Napisz program, który będzie pobierał od użytkownika imiona par dopóki nie wprowadzi imienia „-”, następnie poproś użytkownika o podanie jednego z wcześniej wprowadzonych imion i wyświetl imię odpowiadającego mu partnera.

Jeśli będziesz miał problemy z rozwiązaniem któregokolwiek z zadań na githubie umieściłem [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/15_kolekcje/src/main/java/pl/samouczekprogramisty/kursjava/exercise). Zachęcam do ich sprawdzenia dopiero po przygotowaniu swojej wersji :)

## Dodatkowe materiały do nauki

Materiałów na temat kolekcji w internecie jest całkiem sporo, poniżej przygotowałem dla Ciebie zestaw linków do innych blogów/kursów gdzie autorzy także opisują kolekcje. Jeśli będzie brakowało Ci materiałów, bądź będziesz chciał poznać temat z innej strony zachęcam do zapoznania się z nimi. Na początek kod źródłowy przykładów i rozwiązań zadań oraz dokumentacja biblioteki standardowej.
- [{{ site.doclinks.java.util.Map }}]({{ site.doclinks.java.util Map }})
- [{{ site.doclinks.java.util.Set }}]({{ site.doclinks.java.util.Set }})
- [{{ site.doclinks.java.util.List }}]({{ site.doclinks.java.util.List }})
- [Kod źródłowy i przykłady rozwiązań zadań na githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/15_kolekcje/src/main/java/pl/samouczekprogramisty/kursjava)

No i zestaw pozostałych materiałów :)
- [http://wazniak.mimuw.edu.pl/index.php?title=PO\_Kolekcje\_wst%C4%99p](http://wazniak.mimuw.edu.pl/index.php?title=PO_Kolekcje_wst%C4%99p)
- [http://wazniak.mimuw.edu.pl/index.php?title=PO\_Kolekcje\_-\_przegląd](http://wazniak.mimuw.edu.pl/index.php?title=PO_Kolekcje_-_przegląd)
- [ArrayList przykład użycia (youtube)](https://www.youtube.com/watch?v=gvtt4m1aiwI)
- [http://naukajavy.pl/kurs-jezyka-java/109-listy](http://naukajavy.pl/kurs-jezyka-java/109-listy)
- [http://naukajavy.pl/kurs-jezyka-java/105-zbiory](http://naukajavy.pl/kurs-jezyka-java/105-zbiory)
- [http://naukajavy.pl/kurs-jezyka-java/111-mapy](http://naukajavy.pl/kurs-jezyka-java/111-mapy)
- [http://tutorials.jenkov.com/java-collections/index.html](http://tutorials.jenkov.com/java-collections/index.html)
- [http://kobietydokodu.pl/05-kolekcje-w-javie/](http://kobietydokodu.pl/05-kolekcje-w-javie/)

## Podsumowanie

Cieszę się, że dotrwałeś do końca. Musisz wiedzieć, że bez kolekcji nie ma programowania, ten artykuł jest naprawdę ważny :). Na koniec mam do Ciebie prośbę, proszę pomóż mi dotrzeć do kolejnych Samouków, podziel się z nimi adresem tego bloga i polub stronkę na Facebooku. Z góry wielkie dzięki!

Do następnego razu!
