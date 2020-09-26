---
title: Wzorzec projektowy fabryka
last_modified_at: 2019-11-21 23:09:17 +0100
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-fabryka/
header:
    teaser: /assets/images/2020/0923-wzorzec-projektowy-fabryka/wzorzec_projektowy_fabryka_artykul.jpg
    overlay_image: /assets/images/2020/0923-wzorzec-projektowy-fabryka/wzorzec_projektowy_fabryka_artykul.jpg
    caption: "[&copy; Science in HD](https://unsplash.com/photos/EB78x6KzQjY)"
excerpt: W tym artykule przeczytasz o jednym z wzorców projektowych – o fabryce. Poznasz ten wzworzec w kilku wersjach, zarówno w formie fabryki abstrakcyjnej jak i fabryki będącej metodą. Na przykładach pokażę Ci sposób jego użycia i implementacji. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tym wzorcu projektowym. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić wiedzę w praktyce.
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

## Problem do rozwiązania

Wyobraź sobie sytuację w której 

## Wzorzec fabryka

{% include figure image_path="/assets/images/2020/0923-wzorzec-projektowy-fabryka/fabryka.svg" caption="Wzorzec projektowy fabryka (ang. _factory method_)" %}

{% include newsletter-srodek.md %}

### Diagramy klas

Chociaż na diagramie klas pokazałem `Product` jako klasę w rzeczywistości wcale nie musi tak być. Podobnie metoda `createProduct` będąca właściwą fabryką nie musi być abstrakcyjna.

`Product` może być zdefiniowany jako interfejs, który tworzony jest przez fabrykę. W takim przypadku podklasy `Factory` tworzą instancje różnych klas implementujących interfejs `Product`. Właściwa fabryka, czyli metoda `createProduct` wcale nie musi być abstrakcyjna. Klasa `Factory` może  domyślną

### Przykładowa implementacja fabryki

### Dodatkowe rozważania

Fabryka w postaci metody to specyficzny przypadek innego wzorca projektowego – metody szablonowej. Wzorzec metody szablonowej opiszę w jednym z kolejnych artykułów w serii.

W językach programowania, które traktują funkcje i klasy jako obywateli pierwszej kategorii (ang. _first class citizen_) fabryki mogą być uproszczone. Na przykład w języku Python fabryką może być po prostu klasa[^obiekt_klasy]. Może nim też być zwykła funkcja. Proszę spójrz na przykład

[^obiekt_klasy]: Właściwie jest to obiekt reprezentujący klasę.

```python
class StandardPackage:
    def wrap(self, content):
        print(f"wrapping {content} in standard paper")

class FancyPackage:
    def wrap(self, content):
        print(f"wrapping {content} in fancy paper")

class Sender:
    def __init__(self, package_factory):
        self.package_factory = package_factory

    def send(self, gift):
        package = self.package_factory()
        package.wrap(gift)
        print(f"sending package with {gift}")

if __name__ == "__main__":
    standard_sender = Sender(StandardPackage)
    fancy_sender = Sender(FancyPackage)

    standard_sender.send("book")
    fancy_sender.send("flowers")
```

Chociaż nie jest to fabryka zgodna z powszechnie znaną definicją

#### Zalety
#### Wady

## Przykłady użycia wzorca fabryka

## Zadanie do wykonania

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Warto także rzucić okiem do polskiej i angielskiej Wikipedii, gdzie znajdziesz artykuły opisujące zarówno fabrykę w formie metody jak i klasy abstrakcyjnej:

- [artykuł na polskiej Wikipedii o fabryce](https://pl.wikipedia.org/wiki/Metoda_wytw%C3%B3rcza_(wzorzec_projektowy)),
- [artykuł na angielskiej Wikipedii o fabryce](https://en.wikipedia.org/wiki/Factory_method_pattern),
- [artykuł na polskiej Wikipedii o fabryce abstrakcyjnej](https://pl.wikipedia.org/wiki/Fabryka_abstrakcyjna_(wzorzec_projektowy)),
- [artykuł na angielskiej Wikipedii o fabryce abstrakcyjnej](
 https://en.wikipedia.org/wiki/Abstract_factory_pattern).

## Podsumowanie
