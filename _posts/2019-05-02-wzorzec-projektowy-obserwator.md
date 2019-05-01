---
title: Wzorzec projektowy obserwator
last_modified_at: 2019-02-08 19:07:18 2019 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-obserwator/
header:
    teaser: /assets/images/2019/05/01_wzorzec_projektowy_obserwator_artykul.jpg
    overlay_image: /assets/images/2019/05/01_wzorzec_projektowy_obserwator_artykul.jpg
    caption: "[&copy; Maarten van den Heuvel](https://unsplash.com/photos/s9XMNEm-M9c)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o obserwatorze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). Jeżeli chesz sobie przypomnieć diagram klas w UML, to zapraszam Cię do [krótkiego wprowadzenia do diagramu klas]({% post_url 2019-01-26-wzorzec-projektowy-adapter %}#b%C5%82yskawiczny-kurs-uml).
{:.notice--info}

## Problem do rozwiązania

Czytasz artykuły na różnych stronach internetowych. Jedną z tych stron jest Samouczek Programisty ;). Są strony na które zaglądasz regularnie. Raz na jakiś czas sprawdzasz czy na stronach, które Cię interesują nie pojawiły się nowe artykuły. Jeśli stron do śledzenie masz sporo pojawia się problem. Regularne sprawdzanie czy pojawiły się nowe treści jest mało efektywne. Możesz rozwiązać ten problem na kilka sposobów, jednym z nich może być zapisanie się do newslettera. Można powiedzieć, że zapisanie się na newsletter czyni z Ciebie obserwatora strony.

Ten sam problem występuje w projektach informatycznych. Istnieją zdarzenia, które powinny wyzwalać pewne zachowanie. Aktywne sprawdzanie czy zdarzenie wystąpiło w większości przypadków nie jest dobrym rozwiązaniem. W projektach informatycznych problem tego typu rozwiązany jest przez wzorzec projektowy obserwator (ang. _observer_).

## Wzorzec obserwator

### Diagramy klas

Ten wzorzec projektowy opera się o dwa interfejsy. Jeden z nich reprezentuje obserwatora, drugi element, który jest obserwowany.

{% include figure image_path="/assets/images/2019/05/01_observer.svg" caption="Wzorzec projektowy obserwator (ang. _observer_)" %}

Właściwe obiekty implementują te interfejsy. Obiekt obserwowany – `Observable`. 

Zaletą stosowania tego wzorca projektowego jest to, że klasa `Observer` nie musi aktywnie sprawdzać czy interesujący ją obiekt się zmienił.


{% include newsletter-srodek.md %}

### Słucham czy obserwuję?

Obserwator to wzorzec, który jest bardzo generyczny. W swojej podstawowej wersji nie posiada mechanizmu na informowanie o tym co dokładnie zmieniło się w obserwowanym obiekcie. To obserwator sam musi dojść do tego co się zmieniło. Powoduje to sporo problemów. 

Próba sprzwdzenia przez obserwator co uległo zmianie może być czasochłone. Co więcej nie jest to potrzebne, bo obserwowany obiekt doskonale wie co się zmieniło – sam przecież o tej zmianie informuje swoich obserwatorów.

W kodzie możesz spotkać całą masę interfejsów, różnych implementacji interfejsu [`EventListener`](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/util/EventListener.html).

### Wątki a obserwator

Udało Ci się już przeczytać artykuł o [wątkach]({% post_url 2019-02-11-watki-w-jezyku-java %}#jak-dzia%C5%82a-mechanizm-powiadomie%C5%84)

### Przykładowa implementacja obserwatora

```java
```


Przekładając to na diagramy, które pokazałem wyżej to:

* `Klient` – `MatrixOperations`,
* `Zależność` – `Matrix`.

## Ćwiczenie do wykonania

Ćwiczenie polega na zaimplementowaniu klasy zdarzenia `ArticleEvent`, która będzie zawierała informacje o nowym artykule opublikowanym na blogu. Niech obserwator/słuchacz użyje informacji przekazywanej w tym zdarzeniu do pokazania najnowszego artykułu.

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Możesz też przeczytać więcej o obserwatorze wzorcu z [innego punktu widzenia](https://codecouple.pl/2017/03/31/2-wzorce-projektowe-obserwator-po-raz-kolejny/). Wartościowym źródłem są także artykuły na [polskiej](https://pl.wikipedia.org/wiki/Obserwator_(wzorzec_projektowy)) i [angielskiej Wikipedii](https://en.wikipedia.org/wiki/Observer_pattern).

Zachęcam Cię też do zajrzenia do [kodu źródłowego](https://github.com/SamouczekProgramisty/WzorceProjektowe/tree/master/02_observer/src/main/java/pl/samouczekprogramisty/patterns), który użyłem w tym artykule.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest obserwator. Artykuł pokazał Ci też pewne wariacje tego wzorca projektowego. Po wykonaniu ćwiczenia wiesz, że potrafisz zaimplementować swój własny obserwator. Można powiedzieć, że udało Ci się poznać kolejny wzorzec projektowy. Gratulacje!

Czy udało Ci się użyć tego wzorca w praktyce? W czym pomógł w Twoim projekcie? Podziel się Twoją opinią z innymi Czytelnikami :). 

Jeśłi znasz kogoś komu obserwator może się przydać proszę podziel się odnośnikiem do tego artykułu. Kto wie, może dzięki Tobie Samouczek zyska kolejnego Czytelnika? Z góry dziękuję!

Jeśli nie chcesz pominąć kolejnych artykułów proszę dopisz się do samouczkowego newslettera i polub [profil Samouczka na Facebook'u](https://www.facebook.com/SamouczekProgramisty). To tyle na dzisiaj, trzymaj się i do następnego razu!

