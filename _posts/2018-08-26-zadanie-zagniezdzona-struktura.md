---
title: Samouczek na rozmowie - zagnieżdżona struktura
date: 2018-11-12 22:00:17 +0100
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /samouczek-na-rozmowie-zagniezdzona-struktura/
header:
    teaser: /assets/images/2018/08/26_zadanie_z_rozmowy_kwalifikacyjnej.jpeg
    overlay_image: /assets/images/2018/08/26_zadanie_z_rozmowy_kwalifikacyjnej.jpeg
    caption: "[&copy; Tobias Keller](https://unsplash.com/photos/2ecH5Lw3zSk)"
excerpt: W tym artykule rozkładam na części pierwsze zadanie podesłane przez Mateusza. Po lekturze tego artykułu będziesz wiedzieć na co zwracać uwagę przy rozwiązywaniu tego typu zadań na rozmowach kwalifikacyjnych. Pokażę Ci też jak _Test Driven Development_ pozwala na tworzenie przejrzystego i czytelnego kodu.
---

{% include samouczek-na-rozmowie.md %}

Do tej pory w ramach zadań rozwiązywanych na rozmowach kwalifikacyjnych pokazywałem wyłącznie problemy algorytmiczne. To zadanie jest inne. W tym przypadku zadaniem nie jest znalezienie wydajnego algorytmu rozwiązującego problem. Tym razem należy napisać program, który realizuje pewną funkcjonalność.

W tym przypadku przyszły pracodawca chce sprawdzić czy znasz składnię języka. Czy potrafisz pisać kod, który jest czytelny, łatwy do rozszerzenia i testowania. Może sprawdzić znajomość [zasad SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}) w praktyce. Przy zadaniach tego typu umiejętność pisania wydajnych algorytmów nie jest tak istotna.

Rozwiązując zadania tego typu możesz także pokazać zestaw innych przydatnych umiejętności. Przeczytasz o tym w dalszej części artykułu.

## Zadanie do wykonania

Zacznę od pokazania zadania do wykonania. Jak już wiesz to zadanie dostałem od jednego z czytelników. Treść zadania przekazana Mateuszowi byłą następująca:

> Przekazuję zadanie z prośbą o analizę poniższego kodu i zaimplementowanie metod `findByCode`, `findByRenderer`, `count` w klasie `MyStructure` - najchętniej unikając powielania kodu. Proszę uwzględnić w analizie i implementacji interfejs `ICompositeNode`!
 
```java
interface IMyStructure {
  // zwraca węzeł o podanym kodzie lub null
  INode findByCode(String code);
  // zwraca węzeł o podanym rendererze lub null
  INode findByRenderer(String renderer);
  // zwraca liczbę węzłów
  int count();
}
 
public class MyStructure implements IMyStructure {
  private List<INode> nodes;
}
 
interface INode {
  String getCode();
  String getRenderer();
}
 
interface ICompositeNode extends INode {
  List<INode> getNodes();
}
```

W żaden sposób nie modyfikowałem przekazanego kodu, ani nie zmieniałem treści zadania. Zgodnie z tym co powiedział Mateusz to było wszystko co dostał w ramach zadania do rozwiązania.

## Jak rozwiązać takie zadanie

Zanim przejdę do rozwiązania tego zadania chciałbym zwrócić Twoją uwagę na kilka elementów.

### Opis nie jest wyczerpujący

Opis tego zadania nie jest wyczerpujący. Nie znajdziesz w nim dokładnych wytycznych jak powinien zachować się kod. Na przykład nie wiesz jak powinna zachować się metoda `findByCode` jeśli atrybut `nodes` zawiera więcej niż jeden element, który pasuje do wyszukiwania. Powinieneś zakończyć metodę wyjątkiem? Zwrócić ten, który został dodany jako pierwszy? Czy może ten, który jest najnowszy?

Jak powinna zachować się metoda `count` jeśli zawiera instancję implementującą `ICompositeNode` zawierającą samą siebie?

Takie pytania można mnożyć. W takim przypadku moim zdaniem kandydat powinien zrobić jedną z dwóch rzeczy. Pierwszą opcją jest dopytanie się o te szczegóły i czekanie na odpowiedź od potencjalnego pracodawcy. Drugim podejściem jest założenie, co autor zadania miał na myśli.

Oba rozwiązania mają swoje wady i zalety. Zwrócenie się z pytaniem o uszczegółowienie pozwoli zrealizować zadanie dokładnie w taki sposób jak oczekiwał autor zadania. Jednak minusem tutaj jest dodatkowy czas oczekiwania. Dodatkowo takich pytań może pojawić się wiele w trakcie rozwiązywania zadania. 

#### Założenia są dobre

Podejście z przyjęciem pewnych założeń moim zdaniem jest najlepszym rozwiązaniem. Działając w ten sposób pokazujesz pracodawcy wiele ważnych informacji:

- potrafisz przewidywać sytuacje, które nie są oczywiste i nie zdarzają się często,
- potrafisz samodzielnie podjąć decyzję i ją uargumentować,
- wyróżniasz się wśród innych kandydatów, którzy nie zapytali/nie przyjęli żadnych jasnych założeń przy rozwiązywaniu zadania.

Oczywiście w codziennej pracy to klient decyduje o ostatecznym zachowaniu programu, jednak na potrzeby zadania na rozmowie kwalifikacyjnej taki kompromis wydaje mi się najlepszy.

### Konwencja nazewnicza

Przyznam, że tutaj mam ciężki orzech do zgryzienia. Konwencja nazewnicza stosowana w kodzie przekazanym Mateuszowi nie jest typowa. Zakłada ona, że interfejsy poprzedzone są wielką literą `I`. 

Są przypadki kiedy po nazwie klasy/interfejsu warto wiedzieć czy jest to interfejs czy klasa, jednak nie jest to częsta sytuacja. Z tego co wiem taka konwencja obowiązuje w C# i .NET. Jednak nie jest powszechnie stosowana w świecie języka Java.

Przy rozwiązywaniu zadań tego typu staram się stosować do konwencji narzuconych przez autora zadania. Czyli w tym przypadku nazwa każdego nowego interfejsu zaczynałaby się od `I`. W takim przypadku podejrzewałbym, że system, który rozwija potencjalny pracodawca stosuje taką konwencję w swoim kodzie produkcyjnym.

### Testy automatyczne

Testy są ważne. Nie pytaj czy masz dostarczyć rozwiązanie z testami. Traktuj testy automatyczne jako część dostarczanego rozwiązania. Rozwiązanie zadania bez testów nie jest kompletne.

Rozwiązując zadania tego typu staraj się rozwiązywać je używając [_Test Driven Development_]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). Dzięki takiemu podejściu skrócisz czas testowania gotowego rozwiązania. Dodatkowo pokażesz potencjalnemu pracodawcy, że potrafisz pisać testy jednostkowe. 

### Dokumentacja

Dokumentacja jest ważna. Nie pytaj czy masz dostarczyć rozwiązanie z dokumentacją. Traktuj dokumentację jako część dostarczanego rozwiązania. Rozwiązanie zadania bez dokumentacji nie jest kompletne.

Czy poprzedni akapit brzmi znajomo ;)? W przypadku zadań tego typu dokumentacja jest podobna do testów[^testy]. Pokaż pracodawcy, że wiesz jak ważna jest dokumentacja. Nie chodzi mi tu o dokumentowanie każdej linijki kodu. Mam na myśli kilka akapitów, które opiszą dostarczony program. Jeśli opis zadania nie był kompletny i trzeba było przyjąć pewne założenia, to dokumentacja jest świetnym miejscem na ich opisanie.

[^testy]: Testy także można traktować jako dokumentację, jednak jest to temat na osobny artykuł.

Dokumentację możesz dostarczyć jako osobny dokument, albo zaszyć ją w kodzie. W języku Java do tego celu używa się notacji _javadoc_.

## Rozwiązanie zadania

Zadanie rozwiązałem używając [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). Starałem się dodawać zmiany po każdym cyklu więc patrząc w historię repozytorium możesz zobaczyć jak rozwijał się kod. Zanim jednak zajrzysz do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/09_structure_filtering/src) zachęcam Cię do samodzielnej próby rozwiązania tego zadania.

Możesz później użyć mojego zestawu testów jednostkowych żeby sprawdzić czy Twój kod działa poprawnie[^zalozenia].

[^zalozenia]: Testy powinny przejść u Ciebie. Chyba, że Twoje założenia dotyczące niejasnych wymagań były inne ;).

### Rozszerzenie interfejsu `INode`

Żeby poprawnie obsłużyć zagnieżdżone elementy rozszerzyłem interfejs `INode` o dodatkową metodę `Stream<INode> toStream()`. To jedno z tych założeń, o których pisałem wcześniej. Założyłem, że takie rozszerzenie interfejsu jest dopuszczalne. Jeśli nie byłoby to możliwe, problem można byłoby rozwiązać w inny sposób. Jednak ta droga prowadziła do kodu, który jest bardziej czytelny.

Implementacja tej metody w klasie `CompositeNode` wygląda następująco:
```java
@Override
public Stream<INode> toStream() {
    return Stream.concat(
            super.toStream(),
            nodes.stream().flatMap(INode::toStream)
    );
}
```
Te kilka linijek zapewnia poprawne obsłużenie wielokrotnie zagnieżdżonych struktur.

### Usunięcie duplikacji w metodach wyszukujących

Przykładowa metoda służąca do wyszukiwania po atrybucie `renderer` wygląda następująco:

```java
@Override
public INode findByRenderer(String renderer) {
    if (renderer == null) {
        throw new IllegalArgumentException("Renderer is null!");
    }
    return findByPredicate(n -> renderer.equals(n.getRenderer()));
}

private INode findByPredicate(Predicate<INode> predicate) {
    return nodes.stream()
            .flatMap(INode::toStream)
            .filter(predicate)
            .findFirst()
            .orElse(null);
}
```
Rzuć okiem na metodę `findByPredicate`. Jej użycie pozwoli na uniknięcie duplikacji, na którą zwracał uwagę autor zadania. Jak widzisz w kodzie używałem wyłącznie [strumieni]({% post_url 2018-01-30-strumienie-w-jezyku-java %}), zadanie oczywiście można także rozwiązać używając [pętli]({% post_url 2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java %}).

## Wyślij mi swoje zadanie

Jak już wiesz zadanie to dostałem od jednego z czytelników, od Mateusza. Jeśli chcesz żebym spróbował rozwiązać Twoje zadanie proszę wyślij je na mój adres e-mail `marcin małpka samouczekprogramisty.pl`. Jeśli tylko będę potrafił je rozwiązać to z chęcią napiszę o tym artykuł.

{% include zadanie-z-rozmowy-notice.md %}

## Podsumowanie

Po przeczytaniu tego artykułu wiesz na co zwracać uwagę przy rozwiązywaniu zadań rekrutacyjnych, które nie są związane z napisaniem wydajnego algorytmu. Wiesz jak ważne są testy jednostkowe i dokumentacja. Artykuł także pokazał Ci, jak ważne jest przyjmowanie założeń dotyczących treści zadania. Innymi słowy udało Ci się przygotować "o jedno zadanie lepiej" do następnej rozmowy kwalifikacyjnej.

Na koniec mam dla Ciebie prośbę. Zależy mi na dotarciu do jak największej grupy czytelników. Jeśli znasz kogoś, komu ten artykuł może się przydać proszę podziel się linkiem do tego artykułu. Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku dopisz się do newslettera i polub samouczkowy profil na Facebook'u.

Do następnego razu!
