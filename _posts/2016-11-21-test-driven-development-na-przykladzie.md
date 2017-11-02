---
title: Test Driven Development na przykładzie
date: '2016-11-21 17:48:05 +0100'
categories:
- Kurs programowania Java
- Strefa zadaniowa
permalink: /test-driven-development-na-przykladzie/
header:
    teaser: /assets/images/2016/11/21_test_driven_development_artykul.jpg
    overlay_image: /assets/images/2016/11/21_test_driven_development_artykul.jpg
    caption: "[&copy; dieter\_henkel](https://www.flickr.com/photos/dieter\_henkel/9219097456/sizes/l)"
excerpt: W tym artykule dowiesz się czym jest TDD (ang. _Test-Driven Development_). Poznasz wady i zalety takiego podejścia. Poznasz cykl „red – green – refactor” , który jest w centrum TDD. Ponadto pokażę parę przydatnych skrótów klawiaturowych, które ułatwią pisanie testów. Wszystko to pokażę na przykładzie prostego programu, symulującego dzienniczek ucznia. Będzie to także zadanie dla Ciebie, w którym przećwiczysz TDD w praktyce.
disqus_page_identifier: 550 http://www.samouczekprogramisty.pl/?p=550
---

{% include toc %}

Jeśli tematyka testów, jest dla Ciebie nowa zachęcam Cię do przeczytania poprzedniego artykułu. W artykule tym od postaw opisuję zagadnienie [testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}).
{: .notice--info}

## Czym jest TDD

TDD to podejście do tworzenia oprogramowania, które zostało ponownie odkryte przez Kent’a Beck’a. Podejście to zakłada, że przed napisaniem właściwej funkcjonalności programista zaczyna od utworzenia testu. Test ten powinien testować funkcjonalność, którą dopiero chcemy napisać.

TDD to podejście, które składa się z trzech faz. Te trzy fazy łączą się w cykl. Cały proces pisania kodu składa się z właśnie takich cykli, które powtarzasz jeden po drugim. Cykl to trzy fazy:

1. red,
2. green,
3. refactor.

### Faza Red

Pierwszym krokiem jest napisanie testu. Test ten nie może się powieść, ponieważ sama funkcjonalność jeszcze nie jest zaimplementowana.&nbsp; Możliwe, że nawet po napisaniu takiego testu kod nie będzie się kompilował. Może się tak stać w przypadku, gdy napisałeś test dla metody, która jeszcze nie istnieje.

Sytuacja, w której testy jednostkowe nie przechodzą bardzo często w IDE oznaczana jest kolorem czerwonym.

### Faza Green

Kolejnym krokiem jest napisanie kodu, który implementuje brakującą funkcjonalność. W tym momencie istotne jest to aby ten kod nie był „idealny”. Chodzi o możliwe jak najszybszą implementację, która spełnia założenia testu, który był napisany w poprzedniej fazie.

Następnie potwierdzamy to, że nasza implementacja działa jak powinna uruchamiając testy jednostkowe. Jeśli wszystko jest w porządku całość powinna zakończyć się testami jednostkowymi, które przechodzą. IDE sygnalizuje taką sytuację zielonym kolorem. Ważne jest aby w tej fazie uruchamiać wszystkie dotychczas napisane testy jednostkowe.

### Faza Refactor

Refaktoryzacja (ang. _refactor_) to proces, w którym zmieniamy kod w taki sposób, że nie zostaje zmieniona jego funkcjonalność. Mówi się o „oczyszczaniu” kodu, doprowadzaniu go do lepszego stanu. Przykładem refaktoryzacji może być wydzielenie oddzielnej metody, która usuwa zduplikowany kod czy stworzenie zupełnie nowej klasy odpowiedzialnej za pewną część zadań danej klasy.

Jest to ostatnia z trzech faz cyklu TDD. Faza refaktoryzacji jest bardzo istotna. Nawet doświadczeni programiści bardzo często pomijają tę fazę. Jej brak może w dłuższej perspektywie prowadzić do kodu programu, który jest trudny w utrzymaniu. Praca z takim kodem może być wówczas dużo cięższa, proste zmiany mogą zajmować bardzo dużo czasu.

Dzięki testom, które napisałeś w fazie Red czy wcześniejszych cyklach TDD, możesz czuć się swobodnie zmieniając istniejący kod. Z większą pewnością możesz zmieniać kod, po każdej zmianie uruchamiając istniejące testy jednostkowe. Takie podejście pozwala&nbsp; Ci bardzo szybko wychwycić potencjalne błędy, które mógłbyś wprowadzić refaktoryzacją.

Może się zdarzyć, że faza refaktoryzacji nie zawsze jest konieczna. Usprawnianie dobrego kodu na siłę nie koniecznie może prowadzić do dobrych rezultatów.

## Rady praktyczne

Jedną z pierwszych wątpliwości, które mi się nasunęły gdy uczyłem się tego podejścia było – jak „długie” powinny być takie cykle? Jak duży fragment kodu powinienem testować pojedynczym testem?

Na początku byłem zagorzałym fanem wyznawania możliwie jak najkrótszych cykli, wielkiej liczby testów, które testują bardzo mały wycinek kodu (w sumie takie jest jedno z założeń TDD). Takie podejście jest dobre, ma jednak swoje wady. Wymaga od programisty napisania bardzo dużej liczby testów jednostkowych. Dużej liczby cykli red-green-refactor. Nie jest to złe, wręcz przeciwnie. Jednak ja ze wszystkim nie możemy popadać w skrajności.

Uważam, że cykle powinny być na tyle długie, że Ty jako programista czujesz się swobodnie. Czujesz, że masz kontrolę nad tym co się dzieje. Ogarniasz to co trzeba napisać aby ten test przeszedł. I na końcu ale – powinny być na tyle długie, że programista czuje, że kontroluje całość ale ani trochę dłuższe ;). Innymi słowy, moim zdaniem wraz z doświadczeniem przychodzi swego rodzaju wyczucie jak "duży" powinien być cykl.

Nie możesz zapominać o uruchamianiu wszystkich testów jednostkowych podczas fazy refaktoryzacji. Może się zdarzyć tak, że drobna zmiana może powodować błędy w innej części programu. Uruchamianie wszystkich testów pomaga wykryć taką sytuację.

Pamiętaj też o dobrych praktykach podczas pisania testów, opisałem je w artykule poświęconym tematyce [testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}). Przy TDD praktyki te jak najbardziej obowiązują.

Jeśli używasz repozytorium kodu, to udostępniaj w nim kod, który jest poprawny. Innymi słowy udostępniaj kod, który jest zakończeniem pełnego cyklu. Kod się kompiluje i wszystkie testy przechodzą. Sytuacja, w której zmieniasz kod innego programisty, który się nie kompiluje lub nie przechodzą w nim testy potrafi być dość frustrująca. Lepiej jest unikać takich sytuacji ;).

W moim przypadku bardzo dobrze sprawdza się praktyka, w której na koniec dnia zostawiam test jednostkowy, który nie przechodzi (nie udostępniając go w repozytorium kodu). Następnego dnia rano dokładnie wiem od czego mam zacząć. Takie podejście pomaga mi w następnym dniu pracy od razu skupić się na funkcjonalności, którą zaplanowałem dzień wcześniej.

Pamiętaj o tym, że faza refaktoringu dotyczy także testów. Czasami testy także można oczyścić wprowadzając odpowiednie metody, czy stałe statyczne. Także tutaj trzeba unikać duplikacji. Może część testów jest niepotrzebna, bo to samo jest testowane w innym miejscu? Jeśli tak, śmiało można usunąć jeden z takich testów.

### Skróty klawiaturowe

Zachęcam do przejrzenia skrótów, które opisałem w [poprzednim artykule]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}). Tutaj dodam jeszcze `Ctrl+F5`. Skrót ten uruchamia dokładnie to samo, co poprzednie uruchomienie. Innymi słowy jeśli poprzednio uruchomiłeś testy w pakiecie `Ctrl+F5` uruchomi je ponownie. Jeśli uruchomiłeś tylko pojedynczy test jednostkowy skrót ten uruchomi go jeszcze raz.

Jest on bardzo pomocny przy fazie refaktoryzacji. Będąc wewnątrz klasy, którą refaktoryzujesz możesz używać tego skrótu po każdej, najmniejszej zmianie, IDE uruchomi poprzedni zestaw testów automatycznie.

## Dodatkowe materiały do nauki

Bez najmniejszego wahania mogę polecić książkę autorstwa Kent’a Beck’a, [Test Driven Development by Example](https://www.amazon.com/gp/product/0321146530/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0321146530&linkCode=as2&tag=samouczekprog-20&linkId=acc6d4c00d70964abceb73c5ba706dd8)[^afiliacja]. W książce tej autor na podstawie problemu do rozwiązania pokazuje krok po kroku jak wygląda technika TDD. Chociaż książka nie jest zbyt obszerna, zawiera także sporo informacji związanych z tematyką testów jednostkowych.

[^afiliacja]: To jest link afiliacyjny. Oznacza to tyle, że jeśli kupisz ten produkt pomożesz mi w dalszym prowadzeniu bloga. Nie jest to związane z żadnymi dodatkowymi kosztami dla Ciebie. Dziękuję! :)

Co prawda, nie jest to książka najnowsza, jednak moim zdaniem jak najbardziej warta przeczytania. Mogę powiedzieć, że sam uczyłem się TDD z tej książki :).

## Zadanie

Na koniec czeka na Ciebie zadanie praktyczne. Przećwiczysz w nim TDD na przykładzie. Po tym zadaniu będziesz mógł śmiało powiedzieć, że napisałeś program używając TDD :).

Zacznijmy od wymagań, które nasz program ma spełniać. Ma to być program, który przechowuje oceny jednego ucznia. Poniższe punkty opisują wymagania:

- Jako nauczyciel chcę dodawać przedmioty do dzienniczka,
- jako nauczyciel chcę dodać ocenę dla jednego z przedmiotów,
- jako nauczyciel chcę policzyć średnią ocen dla danego przedmiotu,
- jako nauczyciel chcę policzyć średnią ocen z wszystkich przedmiotów.

Pisząc ten program użyję dwóch klas `GradeBook` reprezentującej dzienniczek oraz klasy `Subject`, która będzie opisywała przedmiot.

Te wymagania podzielę na kilka etapów. Staraj się postępować zgodnie z nimi. W każdym z tych etapów możesz mieć kilka cykli, w których dodawał będziesz kolejne testy jednostkowe:

1. Utworzenie dzienniczka,
2. utworzenie przedmiotu,
3. dodanie przedmiotu do dzienniczka,
4. pobranie przedmiotu z dzienniczka,
5. dodanie oceny do przedmiotu,
6. obliczenie średniej dla przedmiotu,
7. obliczenie średniej dla dzienniczka.

Przygotowałem też dla Ciebie [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/04_grade_book). Proszę jednak żebyś przed sprawdzeniem rozwiązania przeszedł przez wszystkie kroki samodzielnie. Tak nauczysz się dużo więcej. W rozwiązaniu tym starałem się oddzielać każdy krok tak żeby wszystkie cykle wraz z etapami były widoczne. W prawdziwym projekcie oczywiście nie umieszczaj w repozytorium kodu, który się nie kompiluje ;).

Przykładowe rozwiązanie nie sprawdza niektórych przypadków brzegowych. Czy Twoja wersja poprawnie zareaguje na przykład na liczenie średniej z pustego dziennika?

## Podsumowanie

Wiesz czym jest TDD. Jesteś praktykiem TDD, rozwiązałeś zadanie przy użyciu tego sposobu pisania kodu. Wiesz jakie są cykle TDD (i wiesz, że nie wolno zapominać o refaktoryzacji). Skróty klawiaturowe pomagające w pisaniu testów masz w jednym paluszku ;).

Dodam po raz kolejny. Testowanie kodu jest bardzo istotnie, nie zapominaj o nim.

Na koniec mam do Ciebie prośbę. Zależy mi na dotarciu do jak największej liczby czytelników – proszę podziel się linkiem do artykułu ze znajomymi, może ktoś z nich chce poznać TDD od praktycznej strony?. Jeśli nie chcesz ominąć kolejnych artykułów możesz polubić moją stronę na facebooku i zapisać się do mojego newslettera ;). Do następnego razu!
