---
title: Wzorzec projektowy metoda wytwórcza
last_modified_at: 2020-09-29 23:40:23 +0200
categories:
- Wzorce projektowe
permalink: /wzorzec-projektowy-metoda-wytworcza/
header:
    teaser: /assets/images/2020/0929-wzorzec-projektowy-metoda-wytworcza/wzorzec_projektowy_metoda_wytworcza_artykul.jpg
    overlay_image: /assets/images/2020/0929-wzorzec-projektowy-metoda-wytworcza/wzorzec_projektowy_metoda_wytworcza_artykul.jpg
    caption: "[&copy; Nam Hoang](https://unsplash.com/photos/hUbpMeCK5TQ)"
excerpt: W tym artykule przeczytasz o metodzie wytwórczej (ang. _factory method_), jednym z wzorców projektowych. Na przykładach pokażę Ci sposób użycia tego wzorca. Diagram UML pomoże Ci zrozumieć relacje pomiędzy klasami w występującymi w tym wzorcu. Artykuł zawiera także przykładową implementację wzorca  w dwóch językach programowania. Ćwiczenie zawarte na końcu artykułu pozwoli Ci wykorzystać zdobytą wiedzę w praktyce.
---

Czytasz jeden z artykułów opisujących wzorce projektowe. Jeśli interesuje Cię ten temat zapraszam Cię do lektury pozostałych artykułów, które powstały w ramach tej serii – [wzorce projektowe]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe). W zrozumieniu artykułu przyda Ci się wiedza dotycząca [podstaw UML'a]({% post_url 2019-09-21-podstawy-uml %}).
{:.notice--info}

## Problem do rozwiązania

Wyobraź sobie sytuację, w której prowadzisz sklep internetowy ze znaczkami pocztowymi. Obsługa zamówień odbywa się przez program, który zarządza całym procesem. Program nadzoruje wszystko od złożenia zamówienia do obsługi ewentualnych reklamacji. Jednym z etapów obsługi zamówienia jest wysyłka towaru do klienta.

Do tej pory program  pozwalał wyłącznie na wysyłkę znaczków używając standardowej poczty. Z biegiem czasu klienci zaczęli oczekiwać dostępności innych sposobów dostawy. Problem polega na tym, że program używa wyłącznie jednego rodzaju wysyłki. Z pomocą w usprawnieniu takiego programu może przyjść metoda wytwórcza (ang. _factory method_).

W tym przypadku metoda wytwórcza może być odpowiedzialna za tworzenie klas odpowiedzialnych za różne rodzaje wysyłek.

## Wzorzec projektowy metoda wytwórcza

### Diagram klas

Ten wzorzec projektowy w jednej ze swoich form opiera się o 4 elementy. Proszę spójrz na [diagram klas]({% post_url 2019-09-21-podstawy-uml %}#diagram-klas) poniżej:

{% include figure image_path="/assets/images/2020/0929-wzorzec-projektowy-metoda-wytworcza/metoda_wytworcza.svg" caption="Wzorzec projektowy metoda wytwórcza (ang. _factory method_)" %}

* `Product` – klasa bazowa dla obiektów tworzonych przez metodę wytwórczą,
* `Creator`– klasa zawierająca metodę wytwórczą `factoryMethod`,
* `SublassedProduct` – przykładowa podklasa `Product`,
* `SubclassedCreator` – podklasa, nadpisująca metodę wytwórczą zwracając instancję `SubclassedProduct`.

Chociaż na diagramie klas pokazałem `Product` jako klasę, w rzeczywistości wcale nie musi tak być. Podobnie metoda `factoryMethod` nie musi być abstrakcyjna.

`Product` może być zdefiniowany jako interfejs. W takim przypadku podklasy `Creator` tworzą instancje różnych klas implementujących interfejs `Product`. Metoda `factoryMethod` wcale nie musi być abstrakcyjna. Klasa `Creator` może mieć domyślną implementację tej metody, która może być napisana przez podklasy.

Inną modyfikacją może być wprowadzenie parametrów do metody wytwórczej. W takim przypadku parametry mogą mieć wpływ na obiekt, który jest przez nią zwracany.

{% include newsletter-srodek.md %}

### Przykładowa implementacja metody wytwórczej

#### Java

W przykładzie odpowiednikiem `Product` będzie następujący interfejs:

```java
public interface DeliveryService {
    void deliver(Parcel parcel);
}
```

Interfejs ten jest implementowany przez kilka klas. Jedną z nich możesz zobaczyć poniżej:

```java
public class Pigeon implements DeliveryService {
    @Override
    public void deliver(Parcel parcel) {
        System.out.println(String.format("Parcel %s was delivered by Pigeon", parcel));
    }
}
```

Odpowiednikiem klasy `Creator` jest klasa `OrderLifecycle`, która obsługuje cykl życia zamówienia. Jak widzisz poniżej metoda wytwórcza zwraca instancję `PostOffice`:

```java
public class OrderLifecycle {
    public void processOrder(String orderId) {
        Parcel parcel = prepareParcel(orderId);
        DeliveryService deliveryService = deliveryService();
        deliveryService.deliver(parcel);
    }

    protected DeliveryService deliveryService() {
        return new PostOffice();
    }

    private Parcel prepareParcel(String orderId) {
        Parcel parcel = new Parcel(orderId);
        System.out.println(String.format("Parcel %s was prepared", parcel));
        return parcel;
    }
}
```

Dodatkowe podklasy nadpisują implementację metody wytwórczej zwracając inną implementację interfejsu `DeliveryService`:

```java
public class PigeonOrderLifecycle extends OrderLifecycle {
    @Override
    protected DeliveryService deliveryService() {
        return new Pigeon();
    }
}
```

Przykładowa metoda `main` pokazuje sposób wywołania poszczególnych klas, które używają metody wytwórczej:

```java
public static void main(String[] args) {
    CourierOrderLifecycle courierOrder = new CourierOrderLifecycle();
    PigeonOrderLifecycle pigeonOrder = new PigeonOrderLifecycle();
    OrderLifecycle postOfficeOrder = new OrderLifecycle();

    postOfficeOrder.processOrder("order_1");
    courierOrder.processOrder("order_2");
    pigeonOrder.processOrder("order_3");
}
```

Po uruchomieniu tego programu na konsoli pokaże się:

    Parcel [sampro:order_1] was prepared
    Parcel [sampro:order_1] was delivered by PostOffice
    Parcel [sampro:order_2] was prepared
    Parcel [sampro:order_2] was delivered by Courier
    Parcel [sampro:order_3] was prepared
    Parcel [sampro:order_3] was delivered by Pigeon

#### Python

Implementacja w języku Python wygląda trochę prościej[^kaczka]:

[^kaczka]: Jeśli coś chodzi jak kaczka i kwacze jak kaczka to jest kaczką ;). W odróżnieniu od Javy nie stosowałem tu dziedziczenia w przypadku odpowiedników klasy `Product`. Tę implementację można ją jeszcze uprościć, jak pokazałem paragrafie opisującym wady.

```python
class PostOffice:
    def deliver(self, parcel):
        print(f"Parcel {parcel} was delivered by PostOffice")


class Courier:
    def deliver(self, parcel):
        print(f"Parcel {parcel} was delivered by Courier")


class Pigeon:
    def deliver(self, parcel):
        print(f"Parcel {parcel} was delivered by Pigeon")


class OrderLifecycle:
    def process_order(self, order_id):
        parcel = self.prepare_parcel(order_id)
        delivery_service = self.delivery_service()
        delivery_service.deliver(parcel)

    def prepare_parcel(self, order_id):
        parcel = f"[sampro:{order_id}]"
        print(f"Parcel {parcel} was prepared")
        return parcel

    def delivery_service(self):
        return PostOffice()


class PigeonOrderLifecycle(OrderLifecycle):
    def delivery_service(self):
        return Pigeon()


class CourierOrderLifecycle(OrderLifecycle):
    def delivery_service(self):
        return Courier()


if __name__ == "__main__":
    courier_order = CourierOrderLifecycle()
    pigeon_order = PigeonOrderLifecycle()
    post_office_order = OrderLifecycle()

    post_office_order.process_order("order_1")
    courier_order.process_order("order_2")
    pigeon_order.process_order("order_3")
```

Efekt działania tego programu będzie dokładnie taki sam jak w przypadku implementacji w języku Java.

### Dodatkowe rozważania

Metoda wytwórcza to specyficzny przypadek innego wzorca projektowego – metody szablonowej. Wzorzec metody szablonowej opiszę w jednym z kolejnych artykułów w serii.

Metoda wytwórcza może być częścią innego wzorca projektowego jakim jest fabryka abstrakcyjna, także ten wzorzec omówię w jednym z kolejnych artykułów w serii.

#### Zalety


Stosowanie metody wytwórczej sprawia, że kod staje się łatwiejszy do testowania. Dzieje się tak ponieważ w łatwy sposób można nadpisać metodę wytwórczą używając [mock'ów]({% post_url 2018-09-22-testy-jednostkowe-z-uzyciem-mock-i-stub %}), albo naiwnej implementacji na potrzeby testów.

To, że kod jest łatwiejszy do testowania jest konsekwencją stosowania reguł opisanych przez akronim [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}):

* kod jest [możliwy do rozszerzania]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#o-jak-otwarty) – tworząc podklasy w bardzo łatwy sposób możesz zmienić zachowanie klas używających metody wytwórczej,
* możesz [używać obiektów podklas]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#l-jak-liskov-barbara) zwracanych przez metody wytwórcze – to zachowanie to „serce” metody wytwórczej.

#### Wady

Moim zdaniem główną wadą tego wzorca projektowego jest hierarchia dziedziczenia. Prowadzi ona do powstawania wielu (nadmiarowych?) bytów. Przeciążenie metody wytwórczej wymaga dziedziczenia po klasie, która ma już implementację tej metody. Pewną alternatywą dla takiego podejścia może być stosowanie kompozycji zamiast dziedziczenia. Proszę spójrz na przykład:

```python
class OrderLifecycle:
    def __init__(self, delivery_service_factory=PostOffice):
        self.delivery_service_factory = delivery_service_factory

    def process_order(self, order_id):
        parcel = self.prepare_parcel(order_id)
        delivery_service = self.delivery_service_factory()
        delivery_service.deliver(parcel)

    def prepare_parcel(self, order_id):
        parcel = f"[sampro:{order_id}]"
        print(f"Parcel {parcel} was prepared")
        return parcel

if __name__ == "__main__":
    courier_order = OrderLifecycle(Courier)
    pigeon_order = OrderLifecycle(Pigeon)
    post_office_order = OrderLifecycle()

    post_office_order.process_order("order_1")
    courier_order.process_order("order_2")
    pigeon_order.process_order("order_3")
```

To rozwiązanie nie jest już „czystą” metodą wytwórczą. To coś pomiędzy budowniczym (tak, kolejny wzorzec, który opiszę w innym artykule) a metodą wytwórczą. Na byt tego typu czasami mówi się po prostu fabryka.

## Przykłady użycia wzorca metody wytwórczej

Ten wzorzec projektowy jest często używany w ramach fabryki abstrakcyjnej. Za przykład może to posłużyć metoda [`LogFactory.getLog`](https://github.com/apache/commons-logging/blob/9444f0730bb04b6f3678d0501599234d77527210/src/main/java/org/apache/commons/logging/LogFactory.java#L226) z biblioteki commons-logging.

Innymi przykładami mogą być metody w fabrykach związanych z obsługą formatu JSON, na przykład [`JsonReaderFactory`]({{ site.doclinks.javax.json.JsonReaderFactory }}) czy   [`JsonBuilderFactory`]({{ site.doclinks.javax.json.JsonBuilderFactory }}).

## Zadanie do wykonania

W sekcji opisującej wady metody wytwórczej pokazałem sposób modyfikacji tego wzorca projektowego. Zaimplementuj analogiczne rozwiązanie w języku Java. Spróbuj użyć [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}). Przydatny może też być interfejs [`Supplier`]({{ site.doclinks.java.util.function.Supplier }}).

## Dodatkowe materiały do nauki

Niezmiennie, we wszystkich artykułach z serii poświęconej wzorcom projektowym polecam książkę [Design Patterns – Gamma, Helm, Johnson, Vlissides](https://www.amazon.com/gp/product/0201633612/). Jeśli miałbym polecić wyłącznie jedno źródło to poprzestałbym na tej książce.

Warto także rzucić okiem do polskiej i angielskiej Wikipedii, gdzie znajdziesz artykuły opisujące metodę wytwórczą:

- [artykuł na polskiej Wikipedii o metodzie wytwórczej](https://pl.wikipedia.org/wiki/Metoda_wytw%C3%B3rcza_(wzorzec_projektowy)),
- [artykuł na angielskiej Wikipedii o metodzie wytwórczej](https://en.wikipedia.org/wiki/Factory_method_pattern).

## Podsumowanie

Wiesz już czym jest metoda wytwórcza i jak można ją zbudować. Znasz przykłady jej zastosowania zarówno z przykładu w artykule jak i innych bibliotek. Poznałeś zalety i wady tego wzorca projektowego. Wiesz jak można poradzić sobie z jego wadami. Jeśli udało Ci się samodzielnie rozwiązać zadanie do wykonania możesz śmiało powiedzieć, że znasz ten wzorzec projektowy. Gratulacje! :)

Jeśli artykuł przypadł Ci do gustu proszę podziel się nim ze znajomymi. Dzięki temu pozwolisz mi dotrzeć do nowych Czytelników, za co z góry dziękuję. Jeśli nie chcesz pomiąć kolejnych artykułów dopisz się do samouczkowego newslettera i polub [Samouczka Programisty na Facebooku](https://www.facebook.com/SamouczekProgramisty).

Do następnego razu!
