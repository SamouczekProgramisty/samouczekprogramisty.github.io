---
title: Jakość kodu a oschłe pocałunki Jagny
categories:
- Dobre praktyki
permalink: /jakosc-kodu-a-oschle-pocalunki-jagny/
header:
    teaser: https://images.unsplash.com/photo-1521279612905-7fcb2f95b3b0?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e7ff7a721f9f0208ab3ea5105d98988e&auto=format&fit=crop&w=1350&q=80
    overlay_image: https://images.unsplash.com/photo-1521279612905-7fcb2f95b3b0?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e7ff7a721f9f0208ab3ea5105d98988e&auto=format&fit=crop&w=1350&q=80
    caption: "[&copy; Luka Davitadze](https://unsplash.com/photos/CZb_SDZh3lo)"
excerpt: >
    Artykuł ten przedstawia kilka akronimów, które opisują praktyki pomagające w tworzeniu kodu wysokiej jakości. Po przeczytaniu tego artykułu dowiesz się czym jest DRY, KISS czy YAGNI. W artykule opisuję każdy z tych akronimów, pokazując przykład kodu przed i po zastosowaniu opisanych reguł.
---

http://wiki.c2.com/?YouArentGonnaNeedIt
http://wiki.c2.com/?DontRepeatYourself

## Coś o powtarzaniu - DRY

DRY (ang. _Don't Repeat Yourself_) zostało określone w książce "The Pragmatic Programmer" autorstwa Andrew'a Hunt'a i David'a Thomas'a.

Utrzymywanie kodu kosztuje. Kod, wraz z dodawaniem nowych funkcjonalności koroduje. Im więcej kodu tym więcej potencjalnych błędów. A jeśli kod jest powielany w wielu miejscach, to jest dobry przepis na tragedię. Wyobraź sobie sytuację, w której podobny fragment kodu jest kopiowany wielokrotnie. Po pewnym czasie okazuje się, że w tym właśnie fragmencie jest błąd, lub trzeba wprowadzić w nim pewną zmianę. 

Taka sytuacja prosi się o popełnienie błędu w trakcie wprowadzania niezbędnej zmiany. Wystarczy ominąć jedną z kopii kodu i błąd gotowy. Przypomina mi się pioseknka:

> 99 little bugs in the code.
> 99 little bugs in the code.
> Take one down, patch it around.
> 127 little bugs in the code.

Kod reprezentuje wymagania, które są zdefiniowane przez klienta. Każde z wymagań powinno być określone raz.


### Nie bądź fanatykiem

Proszę nie zrozum mnie źle. Nie jestem fanatykiem. Nie uważam, że jeśli fragment kodu zajmuje mniej znaków, to na pewno jest lepszy od tego dłuższego. Do tego zdarza mi się powtarzać kod nawet przez jego kopiowanie.

Stosuj się do zasady DRY (ang. _Don't Repeat Yourself_). Jeśli widzisz duplikację w kodzie, warto zastanowić się nad jej usunięciem. Zastanów się czy sesja refaktoringu kodu nie byłaby potrzebna. Może proste wydzielenie metody rozwiąże problem? Może fragment kodu jest na tyle rozbudowany, że potrzeba osobnej klasy? Ta klasa będzie miała wtedy swój zakres odpowiedzialności i koniecznie swój zestaw [testów jednostkowych]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %}).

Nie pamiętam gdzie, ale usłyszałem kiedyś, że przeciwnością DRY jest WET (ang. _We Enjoy Typing_). W moim przypadku często łączę te akronimy ;). Na początku bardzo lubię pisać kod. Piszę coś co spełnia wymagania, powtarzając niektóre fragmenty. Jednak po tym etapie przychodzi czas na chwilę zastanowienia. Nie bez powodu pojedyncza runda [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}) nie jest kompletna bez refaktoringu. Właśnie wtedy można uprościć kod usuwając zbędną duplikację. Zestaw wcześniej napisanych testów jednostkowych pozwala na swobodną zmianę struktury kodu. 

### Pułapka DRY

Pamiętam czas, gdy odkryłem wzorzec projektowy _template method_. Wtedy jeszcze nie wiedziałem, że kompozycja przeważnie sprawdza się lepiej niż dziedziczenie. To było rozwiązanie na każdy problem. Zero duplikacji kodu. Problem zaczął pojawiać się później, kiedy hierarchie dziedziczenia były na tyle duże, że całość stała się uciążliwa w utrzymaniu.

## Coś o prostocie - KISS

KISS (ang. _Keep It Simply Stupid_)

### Siła prostoty


## Coś o wyobraźni - YAGNI

Na pewno zdarzyło Ci się kiedyś zastanawiać się nad tym jak zaimplementować jakieś rozwiązanie. Wpadasz wtedy w wir tworzenia. Potrafisz wymyślić piękne struktury danych. Algorytmy takie, że płaczesz jak commit'ujesz. Tutaj nowy _manager_, tam kolejny _helper_. Oczywiście Twoje rozwiązanie przewiduje to, że klient będzie chciał obsługiwać kwoty reprezentowane w liczbach urojonych.

Każda ewentualność jest obsłużona. Wszystkie ekstremalne przypadki zaimplementowane. Po prostu niezatapialny fragment kodu. Kod tag generyczny, że jak zostawisz go przez noc to w wyniku ewolucji przejmie władzę nad światem...

Całość zajęła Ci trzy miesiące. Przez ten czas nawet nie miałeś czasu porozmawiać z klientem o jego wymaganiach. Przecież Twoja wyobraźnia wie lepiej. Wszystkie funkcjonalności, o których klient jeszcze nie pomyślał są gotowe. Udało Ci się zaimplementować wszystko co klient wymyśli przez następne trzy lata. Wiesz co? YAGNI (ang. _You Aren't Gonna Need It_). *Nie będziesz tego potrzebować*.

Oczywiście nie mam nic przeciwko pisaniu solidnego kodu, który spełnia wymagania użytkownika. Nie mam nic przeciwko temu, żeby przewidywać sytuacje, o których nie poinformował klient. W pełni zgadzam się na sugerowanie przydatnych funkcjonalności.

Jest jednak jedno małe "ale". Z doświadczenia wiem, że wymyślanie czegoś na siłę nie ma sensu. Klient nie chciał funkcjonalności X? Jeśli Twoim zdaniem to głupi pomysł to z nim o tym porozmaiwaj. Przekonaj go do swojego zdania. Jeśli uda Ci się go przekonać - brawo! Jeśli nie, to pogódź się z faktem, że nie możesz wiedzieć wszystkiego najlepiej.

YAGNI sprowadza się do 

## Akronimy na ratunek

Żaden akronim nie sprawi, że Twój kod będzie lepszy. Nie ważne czy jest to [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}), KISS, YAGNI czy DRY. 

YAF

## Materiały dodatkowe

- [Artykuł o YAGNI](https://www.martinfowler.com/bliki/Yagni.html) na stronie Martin'a Fowler'a,

## Podsumowanie


