---
title: Wzorzec projektowy adapter
last_modified_at: 2018-11-22 23:20:12 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-adapter/
header:
    teaser: /assets/images/2019/01/26_wzorzec_projektowy_adapter_artykul.jpg
    overlay_image: /assets/images/2019/01/26_wzorzec_projektowy_adapter_artykul.jpg
    caption: "[&copy; AlexanderStein](https://pixabay.com/en/plug-jack-stereo-jack-plug-adapter-185031/)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o adapterze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. W artykule znajdziesz też przykłady użycia tego wzorca projektowego w istniejących 
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe)
{:.notice--info}

## Problem do rozwiązania

Pewnie wiesz, że w różnych krajach gniazdka mogą wyglądać inaczej niż to, co możesz zobaczyć na co dzień. Charakterystyka prądu w takim gniazdku także może być różna. Załóżmy, że jedziesz do Wielkiej Brytanii, albo do Stanów Zjednoczonych. Zabierasz ze sobą laptopa i ładowarkę. Bateria wystarcza Ci na czas lotu. Po przylocie na miejsce chcesz uzupełnić baterię w pierwszym wolnym gniazdku na lotnisku.

I tu pojawia się problem. Wtyczka z Twojej ładowarki nie pasuje do gniazdka. Można powiedzieć, że gniazdko i wtyczka nie są ze sobą kompatybilne. Przypominasz sobie jednak, że przezornie udało Ci się zabrać przejściówkę. Przejściówka sprawi, że możesz podłączyć swoją ładowarkę do gniazdka na lotnisku.

Problem tego typu może także występować w projektach informatycznych. Przejściówka, która pozwala włączyć wtyczkę do innego gniazdka to nic innego jak adapter.

Problemem do rozwiązania jest zatem użycie obiektu, w miejscu gdzie jego interfejs nie jest obsługiwany. Adapter rozwiązuje ten problem "tłumacząc" go na coś zrozumiałego dla klienta.

## Błyskawiczny kurs UML

UML (ang. _Unified Modeling Language_) składa się z kilkunastu rodzai diagramów. W ramach serii opisującej wzorce projektowe będę korzystał z zupełnych podstaw tej notacji. Będę używał głównie diagramów klas. Chociaż nie jstem wielkim fanem UML'a, to taki sposób prezentacji w tym przypadkku wydaje mi się najlepszy.

Do zrozumienia diagramów z tego artykuły wystarczy Ci ten przykład:

{% include figure image_path="/assets/images/2019/01/29_uml_diagram.svg" caption="Przykładowy diagram UML." %}

Na tym diagramie możesz zobaczyć:

- trzy klasy: `User`, `LinkedList`, `Object`,
- dwa interfejsy: `List`, `Collection`,
- dziedziczenie: strzałka z ciągłą linią i z pustym grotem, na przykład pomiędzy `LinkedList` a `Object` czy `List` a `Collection`,
- implementację interfejsu: strzałka z przerywaną linią i z pustym grotem pomiędzy `LinkedList` a `List`,
- zależność: strzałkę z ciągłą linią pomiędzy `User` a `LinkedList`.

Kod w języku Java zgodny z tym diagramem może wyglądać tak:

```java
public class User {
    private LinkedList<String> notes;
}
```

Te podstawy w zupełności wystarczą Ci do zrozumienia poniższych przykładów.

## Przykładowa implementacja

Istnieją dwa sposoby implementacji tego wzorca. Jeden z nich używa kompozycji, drugi dziedziczenia. Diagrymy poniżej pokazują tę subtelną różnicę:

{% include figure image_path="/assets/images/2019/01/29_adapter_kompozycja.svg" caption="Wzorzec adapter zaimplementowany przy pomocy kompozycji." %}

{% include figure image_path="/assets/images/2019/01/29_adapter_dziedziczenie.svg" caption="Wzorzec adapter zaimplementowany przy pomocy dziedziczenia." %}

W obu przypadkach klasa `DoAdaptacji` nie implementuje bezpośrednio interfejsu `Zależność`. Ten interfejs implementuje klasa `Adapter`. Także w obu przypadkach `Klient` reprezentuje klasę, która używa interfejsu `Zależność`. Zatem użycie klasy `Adapter` pozwala na pośrednie użycie klasy `DoAdaptacji` przez klasę `Klient`.

Zaletą stosowania tego wzorca projektowego jest to, że klasa `DoAdaptacji` nie musi być modyfikowana aby spełnić interfejs wymagany przez klasę `Klient`.

Pierwszy diagram pokazuje sposób połączenia elementów w przypadku adaptera, który używa kompozycji. W tym przypadku obiekt, który jest adaptowany zawarty jest wewnątrz adaptera.

## Dodatkowe materiały do nauki

## Podsumowanie

