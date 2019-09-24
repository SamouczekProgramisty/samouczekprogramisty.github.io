---
title: Podstawy UML
last_modified_at: 2019-09-19 10:11:50 +0200
categories:
- Programista rzemieślnik
permalink: /podstawy-uml/
header:
    teaser: /assets/images/2019/09/21_podstawy_uml_artykul.jpeg
    overlay_image: /assets/images/2019/09/21_podstawy_uml_artykul.jpeg
    caption: "[noauthor](https://www.rawpixel.com/image/427449/free-photo-image-engineering-blueprint-architect)"
excerpt: W artykule opisuję podstawy UML. Po lekturze tego artykułu poznasz najczęściej używane rodzaje diagramów. Dowiesz się w jakich sytuacjach mogą być przydatne. W artykule stawiam raczej na praktyczne zastosowanie niż rygorystyczną zgodność ze specyfikacją UML.
---

Jak mówi znane powiedzenie „jeden obraz jest wart tysiąca słów”. Takie przypadki zdarzają się także w programowaniu. Często w trakcie projektowania rozwiązań czy rozmawiania na ich temat programistom dużo łatwiej jest się porozumieć rysując. Takie rysunki mogą opisywać ogólną architekturę projektu, sposób podejścia do rozwiązania, kolejność zdarzeń w ramach procesu itd. Dobrze jest mieć wspólny język. W tym przypadku pomocny może być UML.

## Czym jest UML

UML to akronim pochodzący od angielskiego określenia _Unified Modeling Language_. W polskim tłumaczeniu znany jako zunifikowany język modelowania. UML to jasno wyspecyfikowany język składający się z kilkunastu diagramów. Diagramy te pozwalają na formalne opisywanie i modelowanie struktur czy procesów.

## Czy warto uczyć się UML'a

Odpowiadając na tak postawione pytanie w jednym zdaniu mogę powiedzieć, że z mojego doświadczenia UML jest ważny. Warto znać jego podstawy. Chociażby po to żeby rozszerzyć swój „słownik”, który później możmy użyć w trakcie rozmowy na temat programowania z inną osobą. Rysunek, który usuwa zbędne szczegóły pokazując najbardziej istotne aspekty jest niezastąpiony.

Jednak to tylko część rzeczywistości. UML jest ważny, bo może rozszerzyć wrześniej wspomniany słownik. Poszerzyć Twoje horyzonty dotyczące projektowania oprogramowania. Jednak ten sam UML to kobyła. [Specyfikacja UML w wersji 2.5.1](https://www.omg.org/spec/UML/2.5.1/PDF) zawiera 754 strony! W całej swojej karierze pracując jako programista od 2007 roku nie spotkałem ani jednej osoby, która fanatycznie przestrzegałaby reguł opisujących UML'a.

Innymi słowy, tak warto się poznać UML'a, jednak moim zdaniem wybiórczo.

## Czy UML jest używany w pracy związanej z oprogramowaniem

Opiszę tu wyłącznie moje doświadczenia. Możliwe, że ktoś inny ma zupełnie inne. Z chęcią poznam Twój punkt widzenia w komentarzach.
{:.notice-info}

Na początku muszę powiedzieć Ci trochę o moich doświadczeniach. Po kilku latach pracy zauważyłem, że nie czuję się dobrze w korporacjach.  projektach, które wykorzystują „ciężkie metodologie” do ich prowadzenia. Bardzo możliwe, że w takim środowisku nacisk na „czystego UML'a” jest większy.

Z mojego doświadczenia UML jest wykorzytywany w nieformalny sposób. To tak jak z językiem obcym – najważniejsza jest komunikacja. Możesz robić mnóstwo błędów, jeśli jednak potrafisz się dogadać z drugą stroną to jesteś w domu. Właśnie komuikacja i umiejętność przekazywania informacji jest tu kluczowa.

N potwierdza to też [badanie przeprowadzone na grupie programistów, testerów, architektów czy kierowników projektów](https://empirical-software.engineering/projects/sketches/)[^proba].

[^proba] Swoją drogą badanie było przeprowadzone na dość małej grupie kontrolnej. W związku z tym jest ryzyko, że wyniki nie są w pełni miarodajne.

## Narzędzia

Przede wszystkim polecam tablicę i marker. To zdecydowanie najczęściej używane narzędzia przy pracy z diagramami. W trakcie pracy nad Samouczkiem, szczególnie pracując na artykułami dotyczącymi [wzorców projektowych]({{ '/narzedzia-i-dobre-praktyki/' | absolute_url }}#wzorce-projektowe) używam programu [UMLet](https://www.umlet.com) i [yED](https://www.yworks.com/downloads#yEd). Są to darmowe programy, które pozwalają na tworzenie niektórych rodzajów diagramów UML.

## Najczęściej używane diagramy UML

Wspominałem to już wcześniej, jednak powtórzę to po raz kolejny. Poniżej prezentuję wyłącznie podzbiór diagramów. Skupiam się wyłącznie na tych, które doczekały się swojego praktycznego zastosowania w mojej dotychczasowej pracy komercyjnej.

### Diagram klas

Diagram klas (ang. _class diagram_) to chyba najczęściej używany diagram.

### Diagram komponentów

Diagram komponentów (ang. _component diagram_)

### Diagram wdrożenia

Diagram wdrożenia (ang. _deployment diagram_)

### Diagram sekwencji

Diagram sekwencji (ang. _sequence diagram_)

Diagram czynności – w trakcie studiów pamiętam jego wykorzystanie do analizowania algorytmów. Nie był to dokładnie diagram czynności czy diagram stanów. Wtedy prowadzący nazywali ten twór schematem blokowym. Nie pamiętam, żebym używał tego diagramu kiedykolwiek w trakcie pracy komercyjnej.

https://empirical-software.engineering/projects/sketches/


## Dodatkowe materiały do nauki

Jak wspomniałem na początku artykułu nie było moim zamiarem wyczerpanie tematu. Celowo skupiłem się wyłącznie na diagramach, które moim zdaniem są najczęściej używane. Właśnie te diagramy były dla mnie najbardziej przydatne w sesjach przy tablicach z kolegami z pracy. Jeśli jednak temat UML Cię zainteresował zapraszam Cię do zapoznania się z zestawem materiałów dodatkowych. 

* [Specyfikacja UML 2.5.1](https://www.omg.org/spec/UML/2.5.1/PDF)
* [Strona UML'a](https://www.uml.org/)
* [Artykuł o UML na polskiej Wikipedii](https://pl.wikipedia.org/wiki/Unified_Modeling_Language)
* [Artykuł o UML na angielskiej Wikipedii](https://en.wikipedia.org/wiki/Unified_Modeling_Language)


## Moja opinia na temat UML

Ten punkt musiał znaleźć się na początku artykułu. UML to na prawdę ciekawe narzędzie. Jednak daleki jestem od tego, żeby obsesyjnie podążać za wszystkimi diagramami dostępnym w tym języku. Do tej pory w mojej przygodzie z programowaniem w praktyce używałem tylko kilku diagramów. Nie miałem potrzeby używania tych bardziej szczegółowych. Pomijam sytuacje, w których na studiach prowadzący wymagali znajomości poszczególnych typów diagramów.

Zależy mi wyłącznie na praktycznym wprowadzeniu 

## Diagramy UML

