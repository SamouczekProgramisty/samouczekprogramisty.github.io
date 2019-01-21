---
title: Jakość kodu a oschłe pocałunki Jagny
date: 2018-10-09 23:24:54 +0200
categories:
- Dobre praktyki
- Programista rzemieślnik
permalink: /jakosc-kodu-a-oschle-pocalunki-jagny/
header:
    teaser: /assets/images/2018/09/28_jakosc_kodu_a_oschle_pocalunki_jagny_artykul.jpeg
    overlay_image: /assets/images/2018/09/28_jakosc_kodu_a_oschle_pocalunki_jagny_artykul.jpeg
    caption: "[&copy; Luka Davitadze](https://unsplash.com/photos/CZb_SDZh3lo)"
excerpt: >
    Artykuł ten przedstawia kilka akronimów, które opisują praktyki pomagające w tworzeniu kodu wysokiej jakości. Po przeczytaniu tego artykułu dowiesz się czym jest DRY, KISS czy YAGNI. Opisuję w nim każdy z tych akronimów, pokazując ich zastosowanie nie tylko w projektach informatycznych.
---

## Coś o powtarzaniu - DRY

Reguła DRY (ang. _Don't Repeat Yourself_) zostało opisana w książce "The Pragmatic Programmer" autorstwa Andrew'a Hunt'a i David'a Thomas'a. Autorzy wprowadzają regułę, która mówi, że każdy fragment wiedzy powinien mieć pojedynczą, jednoznaczną i uznaną reprezentację w systemie. Regułę tę można zastosować zarówno do konfiguracji jak i kodu programu.

Utrzymywanie kodu kosztuje. Kod, wraz z dodawaniem nowych funkcjonalności koroduje, psuje się z czasem. Im więcej kodu tym więcej potencjalnych błędów. A jeśli kod jest powielany w wielu miejscach, to jest to dobry przepis na tragedię. Wyobraź sobie sytuację, w której podobny fragment kodu jest kopiowany wielokrotnie. Po pewnym czasie okazuje się, że w tym właśnie fragmencie jest błąd, lub trzeba wprowadzić w nim pewną zmianę. 

Taka sytuacja prosi się o popełnienie błędu w trakcie wprowadzania niezbędnej zmiany. Wystarczy ominąć jedną z kopii kodu i błąd gotowy. Przypomina mi się mem z piosenką:

> 99 little bugs in the code.  
99 little bugs in the code.  
Take one down, patch it around.  
127 little bugs in the code.

Reguła DRY ma zastosowanie zarówno do mniejszych fragmentów kodu jak i dużych części systemu. Jeśli widzisz duplikację, którą można wyeliminować, zrób to :). Zanim jednak zajmiesz się refaktoryzacją kodu upewnij się, że posiadasz dobry zestaw [testów jednostkowych]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %}). Testy pomogą Ci upewnić się, że po zlikwidowaniu duplikacji kod nadal działa jak powinien.

### Przykład zastosowania reguły

Załóżmy, że zadaniem jest napisanie algorytmu, który liczbę w notacji dziesiętnej zapisze w innym systemie, na przykład binarnie. Akurat to zadanie jest do wykonania w artykule opisującym [system binarny]({% post_url 2016-02-11-system-dwojkowy %}). Jeden z czytelników zaproponował takie rozwiązanie (jeszcze raz dziękuję za pozwolenie na jego publikację):

```java
public static String convert(int decimalNumber, int toBase) {
    StringBuilder binaryRepresentation = new StringBuilder();
    int currentNumber;
   
    if (decimalNumber == 0) {
        binaryRepresentation.append(decimalNumber);
    }
    else if (decimalNumber > 0) {
        while (decimalNumber > 0) {
            currentNumber=decimalNumber % toBase;
            decimalNumber=decimalNumber / toBase;
            binaryRepresentation.append(currentNumber);    
        }
    }
    else if (decimalNumber < 0) {
        decimalNumber = decimalNumber * -1;
        while (decimalNumber > 0) {
            currentNumber=decimalNumber % toBase;
            decimalNumber=decimalNumber / toBase;
            binaryRepresentation.append(currentNumber);
        }
        binaryRepresentation.append("-");
    }
    return binaryRepresentation.reverse().toString();
}
```

Można powiedzieć, że rozwiązanie spełnia wymagania. Poprawnie przekształca liczby na wartość binarną[^ujemne]. Jednak od razu można zwrócić uwagę na duplikację. Proszę spójrz na moją propozycję refaktoringu tego kodu gdzie duplikacja została usunięta. Algorytm zachowuje się dokładanie tak samo, jednak moim zdaniem jest o wiele bardziej przejrzysty. Do tego nie łamie zasady DRY.

[^ujemne]: Pominę tu kodowanie liczb ujemnych, załóżmy, ze znak `-` jest dopuszczalny.

```java
public static String convert(int decimalNumber, int toBase) {
    StringBuilder representation = new StringBuilder();
    int numberToConvert = Math.abs(decimalNumber);

    do {
        int divisionReminder = numberToConvert % toBase;
        numberToConvert = numberToConvert / toBase;
        representation.append(divisionReminder);
    } while (numberToConvert != 0);

    if (decimalNumber < 0) {
        representation.append("-");
    }
    return representation.reverse().toString();
}
```

Jeśli widzisz duplikację w kodzie, warto zastanowić się nad jej usunięciem. Zastanów się czy sesja refaktoringu kodu nie byłaby potrzebna. Może proste wydzielenie metody rozwiąże problem? Może fragment kodu jest na tyle rozbudowany, że potrzeba osobnej klasy? Ta klasa będzie miała wtedy swój zakres odpowiedzialności i koniecznie swój zestaw [testów jednostkowych]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %}).

Nie pamiętam gdzie, ale usłyszałem kiedyś, że przeciwnością DRY jest WET (ang. _We Enjoy Typing_, _We Edit Terribly_, etc.). W moim przypadku często łączę te akronimy ;). Na początku piszę coś co spełnia wymagania, powtarzając niektóre fragmenty. Taki początkowy kod jest brzydki, ale działa. Jednak po tym etapie przychodzi czas na chwilę zastanowienia. Nie bez powodu pojedyncza runda [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}) nie jest kompletna bez refaktoringu. Właśnie wtedy można uprościć kod usuwając zbędną duplikację. Zestaw wcześniej napisanych testów jednostkowych pozwala na swobodną zmianę struktury kodu. 

{% include newsletter-srodek.md %}

## Coś o prostocie - KISS

Według [Wikipedii](https://en.wikipedia.org/wiki/KISS_principle) reguła KISS (ang. _Keep It Simple, Stupid_) wspomniana została już w 1960 roku przez marynarkę Stanów Zjednoczonych jako wytyczna dotycząca projektowania. Ja poznałem ją w kontekście projektów informatycznych.

KISS sprowadza się do unikania złożoności projektów informatycznych. Im mniej ruszających się części tym mniej rzeczy może się zepsuć. Wychodzę z założenia, że kod, który ma mniej linijek przeważnie jest lepszym rozwiązaniem. Głośno mówię o tym, że bardzo lubię usuwać kod. Im go mniej, tym lepiej. Nie jest sztuką napisać obszerny kod, który realizuje wymagania. Sztuką jest napisanie czytelnego fragmentu kodu, z którego nic nie można usunąć. Nie można nic usunąć, ponieważ każdy element jest potrzebny i realizuje część funkcjonalności.

Podobnie jak przy regule DRY. Jeśli zobaczysz coś co można uprościć, zrób to. Powtarzam też z uporem maniaka, operacje tego typu powinno się przeprowadzać mając pod sobą siatkę bezpieczeństwa w postaci [testów jednostkowych]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %}).

### KISS a Python

Python idzie o krok dalej. Istnieje coś takiego jak "manifest Python'a"[^zen]. Jest to kilka reguł, które opisują w jaki sposób powinno się pisać kod. Całość sprowadza się do 19 linijek tekstu. Aż cztery z nich powiązane są regułą KISS:

[^zen]: Możesz go zobaczyć wpisując `import this` w interpreterze.

> Simple is better than complex.  
Complex is better than complicated.  
(...)  
If the implementation is hard to explain, it's a bad idea.  
If the implementation is easy to explain, it may be a good idea.

Tłumaczę to jako:

> Proste jest lepsze od złożonego.  
Złożone jest lepsze od skomplikowanego.  
Jeśli implementacja jest trudna do wytłumaczenia, to jest to zły pomysł.  
Jeśli implementacja jest łatwa do wytłumaczenia, to może to być dobry pomysł.

### Inne spojrzenie na KISS

Podejście tego typu znane było długo przed KISS używanym przez amerykańską marynarkę wojenną. Istnieje zasada nazywana [brzytwą Ockhama](https://pl.wikipedia.org/wiki/Brzytwa_Ockhama). Mówi ona o tym żeby nie mnożyć bytów ponad potrzebę.

W kontekście oprogramowania mniej bytów sprowadza się do mniejszej ilości kodu. Mniej kodu to mniej potencjalnych błędów do popełnienia. Mniej kodu to mniejszy system, który prawdopodobnie będzie łatwiejszy do zrozumienia i utrzymania.

## Coś o wyobraźni - YAGNI

Na pewno zdarzyło Ci się kiedyś zastanawiać się nad tym jak zaimplementować jakieś rozwiązanie. Wpadasz wtedy w wir tworzenia. Potrafisz wymyślić piękne struktury danych. Algorytmy takie, że płaczesz jak [commit]({{ '/kurs-git/' | absolute_url }})'ujesz. Tutaj nowy _manager_, tam kolejny _helper_. Oczywiście Twoje rozwiązanie przewiduje to, że klient będzie chciał obsługiwać kwoty reprezentowane w liczbach urojonych.

Każda ewentualność jest obsłużona. Wszystkie ekstremalne przypadki zaimplementowane. Po prostu niezatapialny fragment kodu. Kod tak generyczny, że jak zostawisz go przez noc to w wyniku ewolucji przejmie władzę nad światem...

Całość zajęła Ci trzy miesiące. Przez ten czas nawet nie było kiedy porozmawiać z klientem o jego wymaganiach. Przecież Twoja wyobraźnia wie lepiej. Wszystkie funkcjonalności, o których klient jeszcze nie pomyślał są gotowe. Wiesz co? YAGNI (ang. _You Aren't Gonna Need It_). Nie będziesz tego potrzebować.

### Łatwo rozszerzalny kod a nowe funkcjonalności

Oczywiście nie mam nic przeciwko pisaniu solidnego kodu, który spełnia wymagania użytkownika. Nie mam nic przeciwko temu, żeby przewidywać sytuacje, o których nie poinformował klient. W pełni zgadzam się na sugerowanie przydatnych funkcjonalności. Do tego uważam, że pisanie kodu łatwego do rozszerzenia zgodnie z zasadami [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}) jest dobrym posunięciem.

Jest jednak jedno małe "ale". Z doświadczenia wiem, że wymyślanie czegoś na siłę nie ma sensu. Klient nie chciał funkcjonalności X? Jeśli Twoim zdaniem to głupi pomysł to z nim o tym porozmawiaj. Przekonaj go do swojego zdania. Jeśli uda Ci się go przekonać - brawo! Jeśli nie, to pogódź się z faktem, że nie możesz wiedzieć wszystkiego najlepiej.

YAGNI sprowadza się do hamowania swojej fantazji. Nie wprowadzaj bytów, funkcjonalności, metod, itp., które nie są w danym momencie potrzebne. Dodawanie zbędnych elementów komplikuje kod. Do tego podnosi koszty realizacji projektu. Dodatkowo może stawiać Cię w złym świetle jako programistę. Po płodnej sesji pisania kodu może okazać się, że udało Ci się wykonać kawał solidnej, porządnej i nikomu niepotrzebnej pracy.

## Akronimy na ratunek

Żaden akronim nie sprawi, że Twój kod automatycznie będzie lepszy. Nie ważne czy jest to [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}), KISS, YAGNI czy DRY. Dobry kod to moim zdaniem efekt wielu sesji refaktoringu, ciągłej pracy nad jego polepszaniem. 

Spotkałem się też z zasadą, którą opisuje się jako zasadę "amerykańskiego skauta". Sprowadza się ona do tego, żeby kod, który zastaliśmy zostawić chociaż odrobinę lepszym kiedy kończymy z nim pracę. W ten sposób małymi kroczkami można dążyć do polepszenia jakości kodu.

Pamiętaj też, że "lepszy kod" jest określeniem czysto subiektywnym. Dla jednej osoby kod podzielony na malutkie metody będzie lepszy. Inna powie, że metody mające jedną linijkę kodu to przesada.

## Materiały dodatkowe

Jeśli masz ochotę spojrzeć na temat z innej strony zachęcam Cię do rzucenia okiem na poniższe materiały:

- [Definicja DRY na Wikipedii](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself),
- [Definicja KISS na Wikipedii](https://en.wikipedia.org/wiki/KISS_principle),
- [Definicja YAGNI na Wikipedii](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it),
- [Artykuł o YAGNI](https://www.martinfowler.com/bliki/Yagni.html) na stronie Martin'a Fowler'a.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest DRY, KISS i YAGNI. Wiesz, że powtórzenia należy eliminować. Wiesz, że zbędne komplikowanie implementacji jest złym podejściem. W końcu, wiesz też, że funkcjonalności powinny być implementowane nie wcześniej niż są potrzebne.

Opisane tu akronimy KISS i YAGNI odnoszą się do zwinnego sposobu wytwarzania oprogramowania, które moim zdaniem jest lepszym podejściem w większości przypadków. A Ty co o tym sądzisz? Który z tych akronimów stosujesz najczęściej?

Na koniec mam do Ciebie prośbę, jeśli znasz kogoś komu ten tekst może być pomocny proszę podeślij mu adres tego artykułu. Dzięki Tobie uda mi się dotrzeć do nowych czytelników. Pamiętaj też, że dopisanie się do samouczkowego newslettera i polubienie Samouczka na Facebooku pomoże Ci śledzić nowe artykuły na blogu.
