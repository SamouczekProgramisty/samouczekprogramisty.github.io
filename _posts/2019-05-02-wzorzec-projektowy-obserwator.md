---
title: Wzorzec projektowy obserwator
last_modified_at: 2019-05-02 23:15:06 +0200
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-obserwator/
header:
    teaser: /assets/images/2019/05/01_wzorzec_projektowy_obserwator_artykul.jpg
    overlay_image: /assets/images/2019/05/01_wzorzec_projektowy_obserwator_artykul.jpg
    caption: "[&copy; Maarten van den Heuvel](https://unsplash.com/photos/s9XMNEm-M9c)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o obserwatorze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

## Problem do rozwiązania

Czytasz artykuły na różnych stronach internetowych. Jedną z tych stron jest Samouczek Programisty ;). Są strony na które zaglądasz regularnie. Raz na jakiś czas sprawdzasz czy na stronach, które Cię interesują nie pojawiły się nowe artykuły. Po lekturze nowych artykułów spisujesz swoje notatki. Jeśli stron do śledzenie masz sporo pojawia się problem. Regularne sprawdzanie czy pojawiły się nowe treści jest mało efektywne. Możesz rozwiązać ten problem na kilka sposobów, jednym z nich może być zapisanie się do newslettera. Można powiedzieć, że zapisanie się na newsletter czyni z Ciebie obserwatora strony.

Ten sam problem występuje w projektach informatycznych. Istnieją zdarzenia, które powinny wyzwalać pewne zachowanie. Wystąpienie zdarzenia powoduje to, że obserwator aktualizuje swój stan na podstawie zmiany obserwowanego elementu. Aktywne sprawdzanie czy zdarzenie wystąpiło w większości przypadków nie jest dobrym rozwiązaniem. W projektach informatycznych problem tego typu rozwiązany jest przez wzorzec projektowy obserwator (ang. _observer_).

## Wzorzec obserwator

### Diagramy klas

Ten wzorzec projektowy opiera się o dwa interfejsy. Jeden z nich reprezentuje obserwatora. Drugi element, który jest obserwowany:

{% include figure image_path="/assets/images/2019/05/01_observer.svg" caption="Wzorzec projektowy obserwator (ang. _observer_)" %}

Interfejs `Observable` zawiera trzy metody:

* `attach(Observer)` – powoduje dodanie nowego obserwatora (obserwator jest zainteresowany zmianami),
* `detach(Observer)` – powoduje usunięcie istniejącego obserwatora (obserwator nie jest już zainteresowany zmianami),
* `notify()` – powoduje powiadomienie wszystkich obserwatorów o wystąpieniu zmiany.

Interfejs `Observer` zawiera wyłącznie jedną metodę:

* `update()` – metoda jest wywołana przez `Observable` w momencie wystąpienia zmiany.

Interfejsy nie przechowują żadnego stanu, który może się zmienić. Właściwe obiekty implementują te interfejsy i to one przechowują stan.

{% include newsletter-srodek.md %}

### Przykładowa implementacja obserwatora

Interfejsy przedstawione na diagramie UML mogą wyglądać następująco:

```java
public interface Observable {
    void attach(Observer observer);
    void detach(Observer observer);
    void notifyObservers();
}
```

```java
public interface Observer {
    void update();
}
```

Posłużę się przykładem, który przytoczyłem na początku artykułu. Wyobraź sobie blog, na którym publikowane są artykuły. Blog pozwala się obserwować – implementuje interfejs `Observable`. W momencie dodania nowego czytelnika zostaje on dodany do zbioru obserwatorów.

Następnie w momencie publikacji nowego artykułu (metoda `publishArticle`) zmieniany jest wewnętrzny stan instancji klasy `Blog`. Po tej zmianie wywołana jest metoda `notifyObservers`. Wewnątrz tej metody na każdej z instancji implementującej `Observer` wywołana jest metoda `update`:

```java
public class Blog implements Observable {

    private Set<Observer> observers = new HashSet<>();
    private String newestArticle;

    @Override
    public void attach(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void detach(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        observers.forEach(Observer::update);
    }

    public String getNewestArticle() {
        return newestArticle;
    }

    public void publishArticle(String article) {
        newestArticle = article;
        notifyObservers();
    }
}
```

Obserwatorem jest czytelnik reprezentowany przez klasę `Reader`. Czytelnik wie jaki zasób obserwuje, przechowuje go w atrybucie `blog`. W momencie powiadomienia, czyli w trakcie wywołania metody `update`, sprawdzany jest stan atrybutu `blog` i `Reader` może odpowiednio na tę zmianę zareagować. W tym przypadku informuje o najnowszym artykule:

```java
public class Reader implements Observer {
    private final Blog blog;
    private String newestArticle;

    public Reader(Blog blog) {
        this.blog = blog;
        newestArticle = blog.getNewestArticle();
    }

    @Override
    public void update() {
        newestArticle = blog.getNewestArticle();
        System.out.println(String.format("An article „%s” was published!",  newestArticle));
    }
}
```

Przekładając klasy z tego przykładu na te użyte w diagramie UML:

* `SomeObservable` – `Blog`,
* `SomeObserver` – `Reader`.

### Dodatkowe rozważania

Obserwator to wzorzec, który jest bardzo generyczny. W swojej podstawowej wersji nie posiada mechanizmu na informowanie o tym co dokładnie zmieniło się w obserwowanym obiekcie. Takie podejście ma swoje wady i zalety.

#### Zalety

Jedną z zalet stosowania tego wzorca projektowego jest to, że klasa implementująca interfejs `Observer` nie musi aktywnie sprawdzać czy interesujący ją obiekt się zmienił.

Dzięki zastosowaniu tego wzorca projektowego można w czysty sposób odizolować od siebie obiekty. Nie są one ze sobą sztywno powiązane. Dodatkowo szeroka definicja metody `update` pozwala na informowanie o zdarzeniach różnego rodzaju.

Niewątpliwą zaletą także jest to, że obiekt obserwowany może poinformować wielu obserwatorów używając tego samego protokołu.

#### Wady

Obserwator powiadomiony o zmianie sam musi dojść do tego co się zmieniło w obiekcie obserwowanym. Czasami takie sprawdzenie może nie być trywialne. Co więcej nie jest to potrzebne, bo obserwowany obiekt doskonale wie co się zmieniło – sam przecież o tej zmianie informuje swoich obserwatorów.

Można to obejść poprzez rozszerzenie metody `attach` lub `update`. Na przykład zmiana deklaracji z `attach(Observer observer)` na `attach(Observer observer, EnumType event)` może informować obiekt informowany o tym, że dany obserwator zainteresowany jest jedynie podzbiorem zdarzeń.

Podobną zmianę można wprowadzić w metodzie `update` zmieniając ją z `update()` na `update(EventDetails eventDetails)`. Zmiany tego typu sprawiają, że interfejsy `Observable` czy `Observer` nie są już tak generyczne.

Przy synchronicznym powiadamianiu obserwatorów może wystąpić sytuacja, w której wywołania metody `update` zajmują lwią część czasu zmiany stanu obiektu obserwowanego.

## Przykłady użycia wzorca obserwator

W standardowej bibliotece języka Java możesz spotkać całą masę różnych implementacji interfejsu [`EventListener`]({{ site.doclinks.java.util.EventListener }}). Jest to interfejs bazowy dla pozostałych interfejsów, które służą do informowania o wystąpieniu pewnego zdarzenia. To nic innego jak `Observer`, z rozszerzoną metodą `update`.

Jeśli udało Ci się już przeczytać artykuł o [wątkach]({% post_url 2019-02-11-watki-w-jezyku-java %}#jak-dzia%C5%82a-mechanizm-powiadomie%C5%84) to wiesz o mechanizmie powiadamiania. Także tam można dopatrzeć się analogii do wzorca projektowego obserwator. Wątek, oczekujący na pewien zasób jest powiadamiany kiedy zasób staje się dostępny.

Można powiedzieć, że MVC (ang. _Model View Controller_) jest wzorcem architektonicznym. Połączenia pomiędzy poszczególnymi komponentami można uzyskać stosując wzorzec obserwatora. Na przykład widok obserwuje zmiany w modelu, model informuje widok o zmianach, które powinny zostać pokazane użytkownikowi.

## Ćwiczenie do wykonania

Ćwiczenie polega na zaimplementowaniu klasy zdarzenia `ArticleEvent`, która będzie zawierała informacje o nowym artykule opublikowanym na blogu. Wymaga to także zmiany metody `update`. Niech obserwator użyje informacji przekazywanej w tym zdarzeniu do pokazania najnowszego artykułu. Czy w takim przypadku `Reader` potrzebuje instancji klasy `Blog`?

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Możesz też przeczytać więcej o obserwatorze z [innego punktu widzenia](https://codecouple.pl/2017/03/31/2-wzorce-projektowe-obserwator-po-raz-kolejny/). Wartościowym źródłem są także artykuły na [polskiej](https://pl.wikipedia.org/wiki/Obserwator_(wzorzec_projektowy)) i [angielskiej Wikipedii](https://en.wikipedia.org/wiki/Observer_pattern).

Zachęcam Cię też do zajrzenia do [kodu źródłowego](https://github.com/SamouczekProgramisty/WzorceProjektowe/tree/master/02_observer/src/main/java/pl/samouczekprogramisty/patterns), który użyłem w tym artykule.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest obserwator. Artykuł pokazał Ci też pewne wariacje tego wzorca projektowego. Po wykonaniu ćwiczenia potrafisz zaimplementować swój własny obserwator. Można powiedzieć, że udało Ci się poznać kolejny wzorzec projektowy. Gratulacje!

Czy udało Ci się użyć tego wzorca w praktyce? W czym pomógł w Twoim projekcie? Podziel się Twoją opinią z innymi Czytelnikami :). 

Jeśli znasz kogoś komu obserwator może się przydać proszę podziel się odnośnikiem do tego artykułu. Kto wie, może dzięki Tobie Samouczek zyska kolejnego Czytelnika? Z góry dziękuję!

Jeśli nie chcesz pominąć kolejnych artykułów proszę dopisz się do samouczkowego newslettera i polub [profil Samouczka na Facebook'u](https://www.facebook.com/SamouczekProgramisty). To tyle na dzisiaj, trzymaj się i do następnego razu!

