teaser: /assets/images/2020/0923-wzorzec-projektowy-metoda-wytworcza/wzorzec_projektowy_metoda_wytworcza_artykul.jpg
overlay_image: /assets/images/2020/0923-wzorzec-projektowy-metoda-wytworcza/wzorzec_projektowy_metoda_wytworcza_artykul.jpg
caption: "[&copy; Science in HD](https://unsplash.com/photos/EB78x6KzQjY)"

## Problem do rozwiązania

Wyobraź sobie sytuację, w której masz robota produkującego naleśniki. Robot potrzebuje składników do produkcji naleśników. Potrzebuje jajek, mąki, i mleka[^przepis]. Robot ma asystenta, który przekazuje mu wszystkie składniki. Asystent zawsze podaje te same składniki w odpowiedniej ilości.

Problem pojawia się w sytuacji, kiedy chciałbyś zamienić któryś ze składników. Na przykład gdybyś chciał zrobić naleśniki z mąki gryczanej a nie pszennej. W takiej sytuacji z pomocą przychodzi wzorzec projektowy metody wytwórczej czy fabryki abstrakcyjnej.

W tym przykładzie asystent może być przykładem fabryki abstrakcyjnej. W tym przypadku fabryka abstrakcyjna dostarcza niezbędne składniki. Różne typy asystentów dostarczają różne składniki. Na przykład standardowa wersja asystenta zawsze dostarcza krowie mleko i mąkę pszenną, a inna owcze mleko i mąkę owsianą.

Metoda wytwórcza to jedna z metod dostępna w asystencie odpowiedzialna za dostarczanie jednego składnika.

[^przepis]: 1 szklanka mąki pszennej, 2 jajka, 1 szklanka mleka, ¾ szklanki wody gazowanej, szczypta soli, 3 łyżki oleju roślinnego. Wymieszaj składniki na jednolitą masę. Masa powinna mieć delikatną piankę na wierzchu po wymieszaniu. Smaż na rozgrzanej patelni (może być bez użycia oleju). Cieniutkie, pyszne i pulchne naleśniki gotowe! Naleśnik w garść i zapraszam do dalszej lektury ;)

## Wzorzec projektowy fabryka abstrakcyjna (ang. _abstract factory_)

### Diagramy klas

Tym razem diagram zawiera więcej elementów:

{% include figure image_path="/assets/images/2020/0923-wzorzec-projektowy-fabryka/fabryka_abstrakcyjna.svg" caption="Wzorzec projektowy fabryka abstrakcyjna (ang. _abstract factory_)" %}

Różnicą tu są dwie rodziny obiektów wytwarzanych przez fabrykę abstrakcyjną `ProductA` i `ProductB`. Fabryka abstrakcyjna, w odróżnieniu od metody wytwórczej odpowiedzialna jest za tworzenie wielu obiektów. Diagram powyżej pokazuje dwa, jednak w rzeczywistości może ich być dużo więcej.

Podobnie jak w przypadku metody wytwórczej także tutaj klasa bazowa `AbstractFactory` nie musi być abstrakcyjna (wbrew nazwie wzorca projektowego). Może dostarczać domyślnej implementacji metod wytwórczych.

### Przykładowa implementacja fabryki abstrakcyjnej

### Różnica pomiędzy metodą wytwórczą a fabryką abstrakcyjną

Fabryka abstrakcyjna to wzorzec projektowy, który może wykorzystywać wzorzec metody wytwórczej. W przykładach, które pokazałem wyżej fabryka abstrakcyjna grupuje wiele metod wytwórczych.

Metoda wytwórcza może być dostępna w klasie, której odpowiedzialność jest zupełnie inna niż tworzenie obiektów. W przypadku fabryki abstrakcyjnej jej głównym zadaniem jest tworzenie instancji obiektów zwracanych przez jej metody.

### Zalety
Stosowanie metody wytwórczej sprawia, że kod staje się łatwiejszy do testowania.

To, że kod jest łatwiejszy do testowania jest konsekwencją stosowania [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}):
* zachowana jest [reguły pojedynczej odpowiedzialności]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#s-jak-samodzielny) (ang. _single responsibility principle_) – elementy odpowiedzialne za tworzenie obiektu wydzielone są do osobnych komponentów (fabryka abstrakcyjna) lub metod (metoda wytwórcza).
* kod jest [możliwy do rozszerzania]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#o-jak-otwarty) – tworząc podklasy w bardzo łatwy sposób możesz zmienić zachowanie klas używających metody wytwórczej czy fabryki abstrakcyjnej
* możesz [używać podklas]({% post_url 2017-11-27-programowanie-obiektowe-solid %}#l-jak-liskov-barbara) – to zachowanie to „serce” zarówno metody wytwórczej jak i fabryki abstrakcyjnej.
