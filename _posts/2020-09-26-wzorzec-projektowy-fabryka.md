---
title: Wzorzec projektowy fabryka
last_modified_at: 2020-09-27 12:37:52 +0200
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-fabryka/
header:
    teaser: /assets/images/2020/0923-wzorzec-projektowy-fabryka/wzorzec_projektowy_fabryka_artykul.jpg
    overlay_image: /assets/images/2020/0923-wzorzec-projektowy-fabryka/wzorzec_projektowy_fabryka_artykul.jpg
    caption: "[&copy; Science in HD](https://unsplash.com/photos/EB78x6KzQjY)"
excerpt: W tym artykule przeczytasz o dwóch wzorcach projektowych projektowych – o metodzie wytwórczej i fabryce abstrakcyjnej. Na przykładach pokażę Ci sposób użycia tych wzorców. Diagramy UML pomogą Ci zrozumieć relację pomiędzy klasami w tych wzorcach projektowych. Pokażę Ci różnice pomiędzy metodą wytwórczą a fabryką abstrakcyjną. Ćwiczenie zawarte na końcu artykułu pozwoli Ci sprawdzić zdobytą wiedzę w praktyce.
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

Według podziału zaproponowanego przez książkę _Design Patterns_ autorstwa Gamma, Helm, Johnson, Vlissides istnieją dwa oddzielne wzorce projektowe: metoda wytwórcza (ang. _factory method_) i fabryka abstrakcyjna (ang. _abstract factory_). Moim zdaniem te wzorce projektowe są ze sobą bardzo powiązane. Z tego powodu w tym artykule znajdziesz opis obu tych wzorców.
{:.notice--info}

## Problem do rozwiązania

Wyobraź sobie sytuację, w której masz robota produkującego naleśniki. Robot potrzebuje składników do produkcji naleśników. Potrzebuje jajek, mąki, i mleka[^przepis]. Robot ma asystenta, który przekazuje mu wszystkie składniki. Asystent zawsze podaje te same składniki w odpowieniej ilości.

Problem pojawia się w sytuacji, kiedy chiałbyś zamienić któryś ze składników. Na przykład gdybyś chciał zrobić naleśniki z mąki gryczanej a nie pszennej. W takiej sytuacji z pomocą przychodzi wzorzec projektowy metody wytwórczej czy fabryki abstrakcyjnej.

W tym przykładzie asystent może być przykładem fabryki abstrakcyjnej. W tym przypadku fabryka abstrakcyjna dostarcza niezbędne składniki. Różne typy asystentów dostarczają różne składniki. Na przykład standardowa wersja asystenta zawsze dostarcza krowie mleko i mąkę pszeną, a inna owcze mleko i mąkę owsianą.

Metoda wytwórcza to jedna z metod dostępna w asystencie odpowiedzialna za dostarczanie jednego składnika.

[^przepis]: 1 szklanka mąki pszennej, 2 jajka, 1 szklanka mleka, ¾ szklanki wody gazowanej, szczypta soli, 3 łyżki oleju roślinnego. Wymieszaj składniki na jednolitą masę. Masa powinna mieć delikatną piankę na wierzchu po wymieszaniu. Smarz na rozgrzanej patelni (może być bez użycia oleju). Cieniutkie, pyszne i pulchne naleśniki gotowe! Naleśnik w graść i zapraszam do dalszej lektury ;)

## Wzorzec metoda wytwórcza (ang. _factory method_)

### Diagram klas

Ten wzorzec projektowy w swojej najprostszej formie opiera się o 4 elementy. Proszę spójrz na [diagram klas]({% post_url 2019-09-21-podstawy-uml %}#diagram-klas) poniżej:

{% include figure image_path="/assets/images/2020/0923-wzorzec-projektowy-fabryka/metoda_wytworcza.svg" caption="Wzorzec projektowy metoda wytwórcza (ang. _factory method_)" %}

* `Product` – klasa bazowa dla obiektów tworzonych przez metodę wytwórczą,
* `Creator`– klasa zawierająca metodę wytwórczą `factoryMetod`,
* `SublassedProduct` – przykładowa podklasa `Product`,
* `SubclassedCreator` – podklasa, nadpisująca metodę wytwórczą zwracając instancję `SubclassedProduct`.

Chociaż na diagramie klas pokazałem `Product` jako klasę, w rzeczywistości wcale nie musi tak być. Podobnie metoda `factoryMethod` nie musi być abstrakcyjna.

`Product` może być zdefiniowany jako interfejs. W takim przypadku podklasy `Creator` tworzą instancje różnych klas implementujących interfejs `Product`. Metoda `factoryMethod` wcale nie musi być abstrakcyjna. Klasa `Creator` może mieć domyślną implementację tej metody, która może być napisana przez podklasy.

{% include newsletter-srodek.md %}

## Wzorzec fabryka abstrakcyjna (ang. _abstract factory_)

### Diagramy klas

Tym razem diagram zawiera więcej elementów:

{% include figure image_path="/assets/images/2020/0923-wzorzec-projektowy-fabryka/fabryka_abstrakcyjna.svg" caption="Wzorzec projektowy fabryka abstrakcyjna (ang. _abstract factory_)" %}

Różnicą tu są dwie rodziny obiektów wytwarzanych przez fabrykę abstrakcyjną `ProductA` i `ProductB`. Fabryka abstrakcyjna, w odróżnieniu od metody wytwórczej odpowiedzialna jest za tworzenie wielu obiektów.

### Przykładowa implementacja fabryki

### Różnica pomiędzy metodą wytwórczą a fabryką abstrakcyjną

Fabryka abstrakcyjna to wzorzec projektowy, który może wykorzystywać wzorzec metody wytwórczej. W przykładach, które pokazałem wyżej fabryka abstrakcyjna grupuje wiele metod wytwórczych.

### Dodatkowe rozważania

Metoda wytwórcza to specyficzny przypadek innego wzorca projektowego – metody szablonowej. Wzorzec metody szablonowej opiszę w jednym z kolejnych artykułów w serii.

W językach programowania, które traktują funkcje i klasy jako obywateli pierwszej kategorii (ang. _first class citizen_) fabryki mogą być uproszczone. Na przykład w języku Python metoda wytwórcza może być po prostu klasa[^obiekt_klasy]. Może nim też być zwykła funkcja. Proszę spójrz na przykład

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

W innym przypadku może to być po prostu funkcja:

```python
def standard_package():
    return StandardPackage()

def fancy_package():
    return FancyPackage()

if __name__ == "__main__":
    standard_sender = Sender(standard_package)
    fancy_sender = Sender(fancy_package)

    standard_sender.send("book")
    fancy_sender.send("flowers")
```

Chociaż nie jest to fabryka zgodna z powszechnie znaną definicją, nadal spełnia swoją funkcję – wydzielenia odpowiedzialności tworzenia obiektu.

#### Zalety

Stosowanie fabryki abstrakcyjnej czy metody wytwórczej sprawia, że kod staje się łatwiejszy do testowania.

To, że kod jest łatwiejszy do testowania jest konsekwencją stosowania [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}):
* zachowana jest [reguły pojedynczej odpowiedzialności]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#s-jak-samodzielny) (ang. _single responsibility principle_) – elementy odpowiedzialne za tworzenie obiektu wydzielone są do osobnych komponentów (fabryka abstrakcyjna) lub metod (metoda wytwórcza). 
* kod jest [możliwy do rozszerzania]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#o-jak-otwarty) – tworząc podklasy w bardzo łatwy sposób możesz zmienić zachowanie klas używających metody wytwórczej czy fabryki abstrakcyjnej
* możesz [używać podklas]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#l-jak-liskov-barbara) – to zachowanie to „serce” zarówno metody wytwórczej jak i fabryki abstrakcyjnej.

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
