---
title: Wzorzec projektowy dekorator
last_modified_at: 2019-11-21 23:09:17 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-dekorator/
header:
    teaser: /assets/images/2019/11/21_wzorzec_projektowy_dekorator_artykul.jpg
    overlay_image: /assets/images/2019/11/21_wzorzec_projektowy_dekorator_artykul.jpg
    caption: "[&copy; Vladislav Vasnetsov](https://www.pexels.com/photo/person-painting-on-mug-2310883/)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o dekoratorze. Na przykładzie pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce.
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

## Problem do rozwiązania



## Wzorzec dekorator

### Diagramy klas

Wzorzec projektowy dekorator pozwala na rozszerzenie funkcjonalności obiektu bez użycia dziedziczenia.

Istnieje wiele możliwości implementacji tego wzorca projektowego. Diagram klas poniżej pokazuje jedną z nich. Przykładem alternatyw może być użycie klasy abstrakcyjnej w miejscu interfejsu. Inną modyfikacją może być użycie kompozycji w miejscu agregacji. Obie zmiany nie wpływają znacząco na implementację tego wzorca projektowego.

### Przykładowa implementacja dekoratora

### Dodatkowe rozważania

#### Zalety

Jedną z często polecanych praktyk w programowaniu obiektowym jest preferowanie [kompozycji przed dziedziczeniem](https://en.wikipedia.org/wiki/Composition_over_inheritance). Wzorzec projektowy dekorator jest flagowym przykładem użycia tej reguły. Takie podejście pozwala na dynamiczne rozszerzanie funkcjonalności obiektu bez potrzeby kompilacji kodu.

Niewątpliwą zaletą dekoratora jest możliwość dowolnego łączenia istniejących dekoratorów. Każdy z nich będzie opakowywał kolejny obiekt nie mając świadomości, że jest kolejnm dekoratorem w kolejce. Jest to istotne w przypadku gdy istnieje kilka dodatkowych funkcjonalności, które powinna zawierać rozszerzana klasa.

#### Wady

Interfejs dekoratora musi być dokładnie taki sam jak klasy dekorowanej. W niektórych językach programowania (na przykład w Javie) może prowadzić to do klas, które mają sporo metod, których implementacja polega na przekazaniu wywołania do dekorowanego obiektu. Tę wadę można rozwiązać stosując klasy abstrakcyjne[^hierarhia].

[^hierarchia]: Takie podejście może wydłużać hierarhię dziedziczenia, sam preferuję użycie interfejsów.

Dekorator często jest „płaską klasą”. Rozrzesza on dekorowaną klasę o jedną, podstawową funkcjonalność. Prowadzić to może do sytuacji, w której system zawiera wiele takich klas. Chociaż pozwala to na dowolne łączenie dekoratorów może prowadzić do większej liczby klas.

## Przykłady użycia wzorca dekorator

W przypadku języka Java wzorzec projetowy dekorator jest dość często używany w bibliotece standardowej. Za przykład mogą tu posłużyć strumienie wykorzystywane przy [operacjach na plikach]({% post_url 2016-08-17-operacje-na-plikach-w-jezyku-java %}). [`InputStream`]({{ site.doclinks.java.io.InputStream }}) jest klasą abstrakcyjną, która posiada wiele dekoratorów, na przykład [`FileInputStream`]({{ site.doclinks.java.io.FileInputStream }}) czy [`BufferedInputStream`]({{ site.doclinks.java.io.BufferedInputStream }}).

Innym przykładem, również z języka Java, mogą być dekoratory kolekcji. Dekoratory te na przykład pozwalają na utworzenie kolekcji, która jest synchronizowana czy niemodyfikowalna. [`Collections`]({{ site.doclinks.java.util.Collections }}) zawiera szereg metod zaczynających się od `synchronized` albo `unmodifiable`, które tworzą instancje dekoratorów.

W języku Python istnieje składnia, która pozwala na łatwe użycie dekoratorów. Można powiedzieć, że ten wzorzec projektowy został wbudowany w język. Notacja `@dekorator` pozwala dekorować zarówno klasy jak i funkcje. Przykładami dekoratorów dostępnych w bibliotece standardowej mogą być `@property`, `@contextlib.contextmanager` czy `@functools.wraps`.

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Warto także rzucić okiem do [polskiej](https://pl.wikipedia.org/wiki/Dekorator_(wzorzec_projektowy)) i [angielskiej Wikipedii](https://en.wikipedia.org/wiki/Decorator_pattern).

Zachęcam Cię też do zajrzenia do [kodu źródłowego](TODO), który użyłem w tym artykule.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest wzorzec dekorator. Znasz przykładowy sposób jego implementacji. Masz też zestaw materiałów dodatkowych, które pozwolą Ci sporzeć na temat z innej strony. Innymi słowy udało Ci się właśnie poznać kolejny wzorzec projektowy.

Jeśli artykuł przypadł Ci do gustu proszę podziel się odnośnikiem ze znajomymi. Dzięki temu pozwolisz mi dotrzeć do nowych Czytelników, za co z góry Ci dziękuję. Jeśli nie chcesz pomiąć kolejnyach artykułów dopisz się do samouczkowego newslettera i polub [Samouczka Programisty na Facebooku](https://www.facebook.com/SamouczekProgramisty).

Do następnego razu!
