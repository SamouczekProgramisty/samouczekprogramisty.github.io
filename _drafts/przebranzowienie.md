---
title: Praktyczne wprowadzenie do SQL .
categories:
- Bazy danych
- Praktyczne wprowadzenie do SQL
permalink: /xxx/
header:
    teaser: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    overlay_image: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    caption: "[&copy; liquene](https://www.flickr.com/photos/liquene/3802773731/sizes/l)"
excerpt: W artykule tym przeczytasz o tym czym jest SQL. Poznasz podstawowe rodzaje zapytań. Przeczytasz o tym jak tworzyć tabele. Dowiesz się jak pobierać, dodawać, modyfikowac i usuwać dane z bazy danych. W artykule znajdziesz sporo praktycznych ćwiczeń, w których będziesz mógł sprawdzić zdobytą wiedzę.
---

# Zmiana branży, czyli jak zostać programistą

Oto kilka z najczęściej zadawanych mi pytań przez czytelnika Samouczka:

- Czy mogę się przebranżowić?
- Czy nie jestem na to za stary?
- Czy po ukończeniu kursu X będę mógł zostać programistą?

Niestety na pytania tego typu nie mam dobrych odpowiedzi. Głównie dlatego, że sam jestem informatykiem z wykształcenia. Więc moje odpowiedzi na te pytania to domysły[^domysly]. Nie lubię takich odpowiedzi :). Dlatego właśnie poprosiłem o pomoc osoby, które się przekwalifikowały. 

[^domysly]: Tak swoją drogą, moje domysły okazały się słuszne ;).

Artykuł jest bardzo długi, jednak gorąco zachęcam do przeczytania całości. Chłopaki mają na prawdę ciekawe historie, którymi chcieli się anonimowo podzielić. 

Od czasu do czasu dodawałem przypisy, żeby wyjaśnić część branżowego slangu.

Czasami znajdziesz też mój komentarz dotyczący punktu widzenia prezentowanego przez chłopaków. Będzie on umieszczony w ramce takiej jak ta.
{:.notice--info}

# Osoby, którym się udało

## Tomek

Tomek ma 32 lata, zanim został programistą był marynarzem z wykształcenia. Skończył Szkołę Morską w Gdyni. Sfrustrowany dorywczymy pracami po odejściu z morza zdecydował się zostać programistą. Zaczął od C#, aktualnie pracuje z JavaScript.

### O tym jak marynarz został programistą

> Czym zajmowałeś się wcześniej? W jakim zawodzie pracowałeś?
> Kim jesteś z wykształcenia?

Z wykształcenia jestem marynarzem. Skończyłem nawigację w Szkole Morskiej w Gdyni, przez siedem lat pracowałem aktywnie w zawodzie. Najpierw jako marynarz pokładowy, później jako oficer. Oprócz tego pracowałem też w handlu, na infolinii i nawet jako _picker_ na magazynie w UK.

> Miałeś wcześniej styczność z programowaniem?

Minimalną. W liceum napisałem kilka commandline’owych aplikacji w C++, zrobiłem jakiś podstawowy kurs online HTML i CSS, który sobie odświeżyłem rok przed rozpoczęciem przebranżawiania.

> Ile czasu poświęciłeś na przekwalifikowanie się (ile godzin dziennie/tygodniowo się uczyłeś)?

Przez pierwsze 5 miesięcy poświęcałem na naukę 4 do 12 godzin dziennie, codziennie. Przez następne 2, około 20 godzin tygodniowo.

5 * 30 * 8h + 2 * 4 * 20h = 1200h + 160h = 1360h. W pierwszych siedmiu miesiącach swojej nauki poświęcił na nią około 1400 godzin. Przebranżowienie jest możliwe, ale wymaga dużo pracy.
{:.notice--info}

> Jak długo się przygotowywałeś się przed wysłaniem pierwszego CV?

W ogóle. Pełen żywioł. Zadanie rekrutacyjne robiłem trzy dni, poznając przy okazji cud natury jakim jest [stack overflow](https://stackoverflow.com) oraz ból związany z szukaniem _dangling comma_[^dangling] przez dwie doby. Czytanie konsoli to była dla mnie magia, której wówczas nie znałem.

Upór i wytrwałość to cechy, które moim zdaniem są bardzo porządane u każdego programisty. Przykład Tomka właśnie to pokazuje. Szukanie przecinka przez dwa dni potrafi na prawdę wkurzyć. Znam to, byłem tam...
{:.notice--info}

[^dangling]: Tutaj Tomek miał na myśli prosty błąd, jeden przecinek za dużo. Takie błędy to zmora początkujących programistów. Chociaż bardziej zaawansowani też czasami na coś takiego trafią, sam spędziłem nad błędami tego typu mnóstwo czasu.

> Kiedy zacząłeś pracować jako programista?

Pierwszą pracę jako Junior Web Developer podjąłem w 7 miesięcy od rozpoczęcia nauki. 

> Dlaczego zdecydowałeś się przekwalifikować?

Po odejściu z morza podejmowałem się każdej pracy, w tym śmieciowej. Pracując na infolinii jednego z operatorów komórkowych stwierdziłem, że naprawdę jestem więcej wart niż te 1400 zł na rękę przy umowie-zlecenie.

> Od czego zacząłeś naukę programowania?

Robiłem to bardzo chaotycznie. Od podjęcia decyzji o zmianie branży do faktycznego podjęcia pierwszej pracy minęło siedem i pół miesiąca. Zaczynałem chcąc nauczyć się C#[^csharp] i ekosystemu .NET, który miał mi dać podstawy do nauki Javy. Poświęcałem na to od 4 do 12 godzin dziennie, codziennie przez 5 miesięcy. Wybrałem te języki, bo bardzo wzbraniałem się przed programowaniem aplikacji webowych, zupełnie nie znając realiów branży, chciałem pisać aplikacje desktop'owe[^desktop] i zupełnie nie miałem pojęcia co robię. Nie wiedziałem, że Java to backend[^backend]. Wtedy nie wiedziałem nawet co to backend!

[^desktop]: Aplikacje okienkowe, na przykład przeglądarka internetowa jest aplikacją desktop'ową.
[^csharp]: Język programowania składniowo bardzo podobny do Javy wypuszczony przez Microsoft.

[^backend]: Backend to programowanie "po stronie" serwera. Pisanie programów, które będą uruchamiane na serwerze. Dla odróżnienia _frontend_ to część aplikacji, która uruchamiana jest przez klienty. W kontekście aplikacji webowych do frontendu używa się głównie HTML, CSS i JavaScript. Osoba pracująca zarówno z backend'em i frontend'em często określana jest mianem _full stack'a_.

Myślałem, że rynek jest przesycony, a JavaScript to nie jest "prawdziwe" programowanie. Pech chciał, że mniej więcej po trzech miesiącach nauki znalazłem ogłoszenie na Junior Support Developera ze znajomością [jQuery](http://jquery.com)[^jquery]. Jedno z zadań wymagało użycia jQuery. Pracy nie dostałem, ale spojrzałem na język. 

[^jquery]: jQuery to jedna z popularnych bibliotek napisana w JavaScript, która ułatwia pracę z frontend'em.

Później pojechałem na wspomniany kurs Javy, absolutne podstawy z linią poleceń. Tak naprawdę nic, czego nie przerobiłem już w C#. Tam też dowiedziałem się, jak rynek wygląda naprawdę i że web, czy to na frontend'zie, czy to na backend'zie, jest najbardziej rozwojową gałęzią. Dowiedziałem się również, że Javą gardzę absolutnie i nie zamierzam ruszać jej długim kijem. Zostałem przy .NET ;).

Tak szczerze to tego rodzaju "święte wojny" w IT zdarzają się bardzo często. Na początku mojej drogi miałem podobnie jak Tomek, z tym, że odwrotnie. Nie chciałem dotykać niczego co wypuścił Microsoft. Teraz już nie podchodzę do tego tak restrykcyjnie, ale stare przyzwyczajenia zostały.
{:.notice--info}

Następne dwa miesiące spędziłem na dużo mniej intensywnej nauce - około 20 godzin tygodniowo. Nie byłem pewien tego C#, brakowało mi kierunku i miałem wrażenie, że niczego się nie nauczyłem. Poza tym jednym zadaniem rekrutacyjnym w jQuery, nie ruszałem JavaScript'u w ogóle. Podstaw potrzebnych na przebrnięcie rozmowy kwalifikacyjnej nauczyłem się w pociągu relacji Toruń - Szczecin[^dlugosc].

[^dlugosc]: Ta podróż trwa około pięciu godzin. To pokazuje, że po zdobyciu podstaw w jednym języku nauka kolejnych jest dużo łatwiejsza. Oczywiście Tomek przez te pięć godzin nie był biegłym programistą JavaScript, ale znał podstawy.

> Z jakimi technologiami aktualnie pracujesz?

Jestem Fullstack JavaScript Developerem. Pracuję z JavaScript w dialekcie ES2015+. Znam i nie znoszę [TypeScript](https://en.wikipedia.org/wiki/TypeScript).  Technologie i biblioteki, które używam to: 
 - frontend - [React](https://reactjs.org/)/[Redux](https://redux.js.org/) + Native, [AngularJS](https://angularjs.org/), [Angular](https://angular.io/) (2+), [Cordova](https://cordova.apache.org/), [Electron](https://electronjs.org/),
 - backend - [Node.js](https://nodejs.org/en/) + [Express](https://expressjs.com/), [Hapi](https://hapijs.com/), [Sails](https://sailsjs.com/). Ruszam [GraphQL](https://graphql.org/).

Oprócz tego staram się pozostać na bieżąco z katalogiem [NPM](https://www.npmjs.com/) i miałem różnego rodzaju przygody z [rxJS](http://reactivex.io/rxjs/), [D3](https://d3js.org/) czy nawet [Phaser](http://phaser.io/).

> Co sprawiało Ci największe problemy w trakcie przekwalifikowania się? Jak te problemy rozwiązałeś?

Brak kierunku i mentoringu. Nie miałem nikogo, kto by mi powiedział co dalej. Również tak dość metafizycznie. [StackOverflow](https://stackoverflow.com) wszystkiego nie załatwi, a z doświadczenia wiem, że nic nie zastąpi [gumowej kaczki](https://pl.wikipedia.org/wiki/Metoda_gumowej_kaczuszki), [pair-programming](https://en.wikipedia.org/wiki/Pair_programming)'u i code review.

> Jak i gdzie zdobywałeś materiały do nauki? Czy możesz polecić źródła z których korzystałeś? Dlaczego akurat te?

- Google, Google i jeszcze raz Google. Trzeba jedynie nauczyć się poprawnego stawiania pytań,
- Ucząc się C# korzystałem z legendarnego już (i moim zdaniem słabego) kursu Boba Tabora na Channel 9,
- Codeschool nauczyło mnie AngularJS'a,
- YouTube,
- PluralSight,
- Microsoft daje darmowy, czasowy dostęp do kosmicznej ilości usług (od Azure po właśnie Pluralsight). Jedyny warunek, to mieć konto MS, które zresztą polecam. Głównie ze względu na darmowe Visual Studio For Team And Services. Dzięki temu dostajesz dostęp do prywatnego, nieograniczonego repozytorium Git.

> Co ułatwiało Ci naukę? Miałeś jakieś "sposoby" na łatwiejsze zapamiętywanie?

Godzina nauki, fajka, godzina nauki, pół godziny w HearthStone[^heartstone].

[^heartstone]: Nie przyznam się ile godzin spędziłem na tej grze, albo na oglądaniu rozgrywek na YouTube...

> Jak poszły Ci pierwsze rozmowy? Co sprawiło Ci największy problem?

Wyłganie jakiejkolwiek wiedzy. Nie oszukujmy się - nasza branża cierpi na krytyczny niedobór ludzi, więc samouków są masy, jak nie większość. Praktycznie każdy z nas, prędzej czy później, będzie mieć syndrom oszusta. 90% CV Junior Developer'ów, które widziałem, to stek kłamstw. Sztuka tkwi w zamaskowaniu tego. Nauczysz się tego w trakcie.

Tu się z Tomkiem nie zgadzam. Uważam, że nie można kłamać w CV. Kłamstwo ma krótkie nogi i nie popłaca. Masz za mało w CV? Popracuj solidnie kolejny miesiąc, dwa i dodaj projekt, który w tym czasie zrealizujesz. Dalej mało? Popracuj kolejny miesiąc, ukończ darmowy kurs na Coursera/Udemy. Dalej mało? Wystąp na lokalnym spotkaniu dla programistów i opowiedz o czymś czego się nauczyłeś itp.
{:.notice--info}

> Gdzie wysyłałeś 5-10 pierwszych CV? Jak wybierałeś te firmy?

Nie miałem wówczas konta na LinkedIn, więc wrzuciłem swoje CV na Monster Polska. Dziś "szukam" pracy tylko za pomocą LinkedIn. W profilu mam zaznaczoną otwartość na oferty, więc oferty płyną wartkim strumieniem.

W swojej karierze wysłałem CV na JEDNO ogłoszenie - to z zadaniem rekrutacyjnym w jQuery.

> Jakie masz wskazówki, rady dla osób, które chcą się przekwalifikować?

Nic odkrywczego. Cierpliwość i wytrwałość. Jeśli masz ten komfort, który miałem ja - potraktuj naukę jak pracę i podchodź do niej tak, jak do etatu: określony z góry czas CODZIENNIE. Opanuj też słowa-klucze, żebyś chociaż brzmiał, że wiesz o co chodzi. Bo przez pierwszy rok i tak nie będziesz wiedział, a cała praca - czy to nauka, czy to etat - będzie przypominać błądzenie pijanego dziecka z nożem we mgle[^mentor].

Pracy uczysz się w pracy. Dobry mentor to coś niezastąpionego. O mentorze Tomek wspomniał w jednej z wcześniejszych odpowiedzi.
{:.notice--info}

> Jakie masz plany dotyczące dalszej nauki/rozwoju?

- Architektura JavaScript i pełne przekwalifikowanie na NodeJS Developera
- uczenie innych,
- powrót do C#/.NET,
- może Python?

> Jak oceniasz pracę jako programista?

Nie wyobrażam sobie robić nic innego.

## Szymon

### O tym jak matematyk został programistą

Wcześniej pracowałem 11 miesięcy jako informatyk, totalny wyzysk. Zdecydowałem sie przez to dobranżowić.

Z wyksztalcenia jestem matematykiem. Studiowałem matematykę na politechnice. Pierwszą styczność z programowaniem miałem właśnie podczas studiow (Pascal, programowanie obiektowe w C#, [podstawy relacyjnych baz danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}), strony internetowe z HTML i CSS, algorytmy z Matlab'em, witryny internetowe z C# i .NET).

Po trzecim roku studiów zdecydowałem się bardziej dokształcić w kierunku IT w Policealnej Szkole Weekendowej jako technik informatyk. Szkoła ta trwała 2 lata. Miałem tam między innymi bazy danych (Postgres), HTML, CSS, JavaScript oraz troszeczkę PHP.

Po studiach zacząłem właśnie pracę jako informatyk taki a'la helpdesk. Pół roku później skończyłem zaoczną szkołę. Załapałem się później na dwa kursy/szkolenia finansowane ze środków Unii Europejskiej. Jeden był 10 dniowym kursem po 8h dziennie "Programowanie w języku java". Drugie szkolenie trwało bodajże 5 dni "Przygotowanie do certyfikatu OCPJP6". Niestety go nie zdałem, nikt go w sumie z naszej grupie nie zdał.

Zacząłem wysyłać CV do różnych firm, które poszukiwały młodszego programisty java. Niestety poza znajomością Javy wymagana była ode mnie np. znajomość baz danych.

Odezwał się do mnie mój przyszły pracodawca. Mała firemka, wówczas trzyosobowa wliczając szefa. Na rozmowie kwalifikacyjnej nie weryfikował specjalnie mojej wiedzy technicznej. Przyjął mnie do pracy. Po 2 tygodniach opanowałem podstawy Hibernate (konfiguracja w XML). Po czasie widziałem, ze nie nauczę sie tutaj za dużo i szukałem dalej.

Chodziłem na rozmowy (spokojnie szacuje, że było ich około 20) i bez skutku. Zawsze czegoś mi brakowało pod względem technicznym. Wysłałem CV do mojej obecnej firmy, zaprosili mnie na rozmowę. Pierwszy etap to wstępna rozmowa przez telefon po niemiecku, którą przeszedłem pozytywnie. Drugi etap rozmowy trwał około 2h. Różne zadania na kartce, pytania o moje wcześniejsze doświadczenie. Na rozmowie okazało się tak samo jak na wcześniejszych rozmowach, że za mało umiem m.in. z javy, ale nie dyskredytowało mnie to. Firma bowiem oferuje staże dla świeżych absolwentów oraz studentów ostatnich lat studiów. 
Po 6 miesiącach opuściłem swoją pierwszą firmę, w której pracowałem jako programista na rzecz obiecująco zapowiadającego się stażu. Java, angularJS to było coś. Po 3 miesiącach płatnego stażu przyjęli mnie na umowę o prace. Jednak przez pierwsze 3 miesiące w godzinach pracy odbywałem kurs niemieckiego, co było wymagane przez pracodawcę. Potem zaczął się pierwszy projekt, potem kolejny. Siedzę w obecnej firmę już ponad 2 lata.
Na naukę programowania starałem sie poświecić minimum godzinne dziennie co nie zawsze mi wychodziło. Do wysłania pierwszego CV nie przygotowałem sie zbyt długo, przez co myślę, ze nie byłem na zbyt wysokim poziomie, co skutkowało negatywnymi decyzjami na rozmowach.
Pracę jako programista zacząłem w 25 urodziny. Obecnie mam 28 lat. Zdecydowałem się przekwalifikować, gdyż wiedziałem, że programowanie jest bardziej dochodowe niż inne zawody w IT. Samodzielną naukę programowania zacząłem od przerabiania zagadnień ze szkoleń, w których wziąłem udział w ramach projektów z UE. Obecnie pracuję z java 8, javaEE, html, css, javascript, typescript, angular4, eclipselink, postgres, oracleDB, tak w skrócie. Jako środowisko to Intellij. Największą trudnością w nauce programowania było moje lenistwo oraz to, że jak najszybciej chciałem zmienić pracę. Przez kolejne odmowy podczas rozmów kwalifikacyjnych odechciewało mi się coraz bardziej zmienić pracę.
Materiały do nauki pozyskiwałem z YT. Jest tam pełno darmowych szkoleń. Co mogłoby mi przeszkadzać jest to, że większość tych kursów, które znajdowałem, były tworzone/prowadzone przez Hindusów. A wiadomo, że ich akcent angielskiego pozostawia wiele do życzenia. Nie miałem sposobów na zapamiętywanie, ani niczego co by mi ułatwiało mi naukę.
Młodszym kolegom mogę polecić wybór studiów informatycznych. Sam poszedłem na matematykę, ale jak miałbym możliwość ponownego wyboru to wybrałbym informatykę.
Kolegom, którzy chcą sie przekwalifikować/dokwalifikować tak jak ja, systematyczną naukę, wytrwałości i cierpliwości. Mi niestety brakowało cierpliwości. Gdybym był bardziej cierpliwy z tym co robił, uniknąłbym rozczarowań związanych z nieudanymi rozmowami.
Na chwilę obecną "siedzę" na fullstacku. W przyszłości chciałbym powrócić do większego wykorzystania tego, czego się nauczyłem na studiach więc coś z big data: scala plus apache spark. Chyba, że do tego czasu trendy się zmienią. Może już się zmieniły?
Pracę jako programista oceniam bardzo pozytywnie. Nie mam w ogóle porównania do poprzedniego stanowiska jakim był informatyk na helpdesku. Dużo przeróżnych i ciekawych zadań, nowe wyzwania i nieustanna nauka.

## Marek

To spróbuję to opisać w miarę sensownie
ogólnie to jako programista zacząłem pracować w styczniu tamtego roku
przedtem ukończyłem studia na PWr - mechanikę i Budowę Maszyn
zawód postanowiłem zmienić w wieku 24 lat - czyli w sumie ani nie jakoś specjalnie późno, ani nie jakoś specjalnie wcześnie
warto tylko powiedzieć że na MBM styczności z programowaniem nie miałem praktycznie żadnej
mogę nawet powiedzieć że kiedy jako przedmiot dodatkowy miałem na pierwszym roku programowanie C++ to nie zaliczyłem tego przedmiotu ;d
totalnie nie ogarniałem o co chodzi w programowaniu
właściwie moje jedyne doświadczenie z programowaniem czegokolwiek to było tworzenie prostych programow do sterowników PLC w graficznym interfejsie ;d
czyli coś takiego jak scratch
tylko że wersja bardziej "inżynierska" 😀
czyli zamiast funkcji do wykonania zawory do zamknięcia, a zamiast zmiennych podanych przez uzytkownika jakieś czujniki które pobierały dane (oczywiście bez żadnego wnikania w hardwareowe szczegóły - po prostu kwadracik który podaje Ci bieżące wyniki pomiarów)
na zmianę ścieżki zawodowej zdecydowałem się po prawie dwóch latach pracy w zawodzie jako najpierw pracownik (stażysta) działu R & D a potem jako projektant konstruktor
na podjecie decyzji o zmianie zawodu zebrało się kilka czynników - między innymi to że podczas poszukiwania nowej pracy (dalej jako mechanik) kilka razy odbiłem się od oferty pracy poprzez swoje wymagania finansowe (które też nie były jakieś specjalnie wygórowane)
podjąłem więc decyzję że spróbuje się przebranżowić - na samym początku głównie ze względu na zarobki i perspektywy rozwoju
które dla inżynierow mechanikow w naszym kraju niestety są dość mizerne i obarczone dużą odpowiedzialnością
na sam początek chciałem zacząć dość klasycznie - czyli od C++
i tutaj znowu pojawiła się dla mnie pewna bariera poznawcza - warto powiedzieć że na samym początku nie potrafiłem rozróżnić inta od floata, a samo wykonywanie czegokolwiek w IDE stanowiło dla mnie czarną magię ;d
serio
byłem totalnie programistycznym tłukiem, umiałem się obejść z komputerem w miarę podstawowy sposob ale cokolwiek związanego z programowaniem bylo dla mnie czarną magią
na całe szczescie dla mnie na weselu mojego kolegi udało mi się trafić na kogoś kto siedział w branży IT przez kilka lat, i tak od słowa do słowa polecił mi żeby zamiast uczyć sie C++ spróbować Javy
i dzięki bogu za to! ;d
nie dosć że Java ma dużo niższy próg wejscia (niż C czy c++) to jeszcze na chwilę obecną jest duuużo więcej ofert pracy z nią zwiazanych - a tym samym dużo większe szanse na staż czy jakikolwiek start
doszło więc do tego że musiałem zdecydować z czego się uczyć
oczywiście google.pl
"best sources to learn java"
i wertowanie Quory, Stack Overflow etc
na tym etapie cały czas jeszcze zastanawiałem się nad jakims bootcampem czy ewentualnie studiami z zakresu programowania
ale całe (nie)szczęscie na jedno i drugie nie było mnie w danym momencie stać 😀
zacząłem więc od darmowych kursów Javy dostępnych w internecie
z tego co pamiętam pierwszy z kursów dostępny był chyba na stronie Coursea
beznadziejny 😀
wystarczy nadmienić że programowania uczono w nim w IDE
werble
BlueJ
co było totalną masakrą
jednak i tym razem miałem farta i po chwili trafiłem na kurs Javy na udemy od Johna Purcella (który zresztą cały czas polecam wszystkim znajomym próbojacym zacząc przygodę z programowaniem)
i tutaj było już o niebo lepiej
starałem się programować 3-4 h dziennie - miałem zamiar jak najszybciej zacząć pracować w zawodzie
siedziałem więc w domu i w wolych chwilach w pracy ogladajac jego filmiki i probojac pisac wlasne oprogramowanie
takie pisanie programow rowno z prowadzacym kurs - pomagalo mi to zapamietac to co robilem
dodatkowo robilem sobie jakies male zadania zeby przypomniec sobie co było na poprzednich lekcjach
i wlasciwie po tym pierwszym kursie było juz tylko lepiej - od tego samego autora znalazłem więcej kursów ktore dotyczyły innych zagadnien w Javie
wystarczy powidziec o chociazby Springu, Swingu, Multithreadingu, Wzorcach projektowych
dodatkowo okazalo się że sam autor kursów jest baaaaaaaaaaardzo pomocną osobą
zawsze odpowiadał na e maile i pomagal w sprawach w ktorych miałem problemy
ba
nawet raz dał mi darmowy dostęp do jednego ze swoich kursów gdy nie miałem kasy aby go wykupić :d
za to do dzisiaj wysyłam mu donejty na paypala :d
starałem się też jak najwięcej czytać o programowaniu
nie tylko o samej Javie
ale ogolnie o architekturze komputera etc
wiadomo, troche pomogla elektronika ktora byla na studiach
ale ogolnie to i tak jak uczenie od zera
(pomocny okazal się też darmowy kurs Harvardu CS50 - serio sweitnie sa tam omowione podstawowe zagadnienia)
po jakichs 5 miesiacach takiej nauki
podjalaem decyzję że czas zacząc probowac
startować na staż/juniorskie pozycje
(mimo iż w sumie moja wiedza nie była jakaś zabójcza)
poprzeglądałem oferty pracy z Javy
i słałem gdzie popadnie
(gdzie w miarę nadawały sie moje zdlonosci)
dodatkowo zauwazylem ze do programowania jest mi potrzebne cos wiecej niz Java
czyli np SQL, XML, html css, JavaScript
starałem się więc dodatkowo ogarnąć coś chociaż powierzchownie z tych tematow
aby na rozmowach nie wychodzić na totalnego ignoranta
w miedzy czasie podjąłem też studia informatyczne na prywatnej uczelni - ale okazały się one totalną stratą czasu i pieniędzy
(dobra rada dla przekwalifikujących się - olejcie uczelnie, ogarnijcie dobrze jeden jezyk, ogarnijcię jakąś pracę i dopiero potem idzcie na studia :D)
udało mi się dostać na kilka rozmow kwalifikacyjnych
i tutaj już poszło w miarę z górki
z 3 rozmów na których byłem,  jedna zakonczyla sie propozycją pracy, drugą propozycją stażu
i tutaj poszło już z górki d;
doszedł do tego jeszcze świetny szef
który rzeczywiście chciał dać mi szansę
i pomagał mi przy rozwoju w początkowych fazach mojej pracy
no i w tej pierwszej pracy siędzę do dzisiaj, projektując wewnetrzny system banku w nowej Javie EE w oparciu o RESTy i utrzymujac jeszcze stara wersję zbudowaną na strutsie ;d
cały czas siedzę i uczę się dodatkowych rzeczy
lyknąłem trochę machine learningu, uczę sie Androida
w tym momencie staram się ogarnąć libgdx żeby zacząc robic proste gierki na Androida
jako następne na celowniku mam Unity i naukę C# przy okazji
a w miedzyczasie poglebiam wiedzę z Javy i ogarniam Springa 5 ;d
mogę też powiedzieć że znalazłem w programowaniu coś dla siebie
mimo że poczatkowo sklonily mnie do zmiany branzy zarobki
jako konstruktor z perspektywy czasu moge powiedziec ze bylem dosyc kiepski ;d
jako programista czuję się zdecydowanie pewniej w zawodzie
rozwinęło się to w pewien rodzaj pasji u mnie - sam w wolnych chwilach piszę artykuły o programowaniu i rzeczach "Około" programowaniowych na bloga It-leaders
możesz zerknać jak masz chwilę i czas, są tam chyba podpisane nawet moim imieniem i nazwiskiem ;d
i to by było chyba na razie tyle jeżeli chodzi  o to jak było u mnie z programowaniem
mam nadzieję że uda Ci się z tego sklecić coś sensownego
jakbyś miał jakieś pytania to pisz, postaram się odpowiedziec jak  najszybciej 🙂
spokojnie możesz użyć mojego imienia i nazwiska
jak chcesz jutro podrzucę Ci też jakieś zdjęcie

## Tomasz

Tomasz to dwudziestopięciolatek, który w lutym 2018 roku zaczął pracę jako programista. Ukończył studia z tytułem magistra inżyniera budownictwa ze specjalizacją inżynieria mostowa. Poniżej możesz przeczytać jego historię.

- Czym zajmowałeś się wcześniej? W jakim zawodzie pracowałeś?
Wcześniej pracowałem jako asystent projektanta mostowego. Do moich zadań należało przygotowywanie obliczeń nośności mostów. Obliczenia te wykonywałem w Excelu, potem by je przyśpieszyć zacząłem używać C++ i tak już zaczęła się moja przygoda z programowaniem. Odkryłem, że programowanie można wykorzystać nie tylko w branży budowlanej.


- Miałeś wcześniej styczność z programowaniem?
Pierwsza moja styczność z programowaniem to czasy gimnazjum, czyli budowanie stron w HTML i CSS. W liceum mieliśmy na informatyce proste zadania do rozwiązania w Pascalu. Nie byłem tak bardzo zakręcony na punkcie programowania, żeby każdą chwile wolną w gimnazjum i liceum spędzać przed komputerem. Większość czasu wolnego spędzałem grając w nogę z kolegami z osiedla :).

- Ile czasu poświęciłeś na przekwalifikowanie się, ile godzin dziennie/tygodniowo się uczyłeś?

Ciężko powiedzieć, ile czasu poświeciłem, po pracy siadałem codziennie tak na 2 godzinki i robiłem kursy online albo pisałem własne programy. W sobotę lubiłem wybrać się do swojej ulubionej kawiarni i tam ćwiczyć swój warsztat.

- Jak długo się przygotowywałeś się przed wysłaniem pierwszego CV?

Myślę, że mniej więcej rok czasu potrzebowałem. Oczywiście pierwsza rozmowa kwalifikacyjna musiała pójść źle :) Odpowiedziałem na pytania teoretyczne poprawnie, ale niestety nie dałem rady z napisaniem programu, zabrakło mi wiedzy praktycznej.


- Dlaczego zdecydowałeś się przekwalifikować?

To w sumie wyszło bardzo naturalnie. Zawsze interesowałem się informatyką, bardzo lubię sobie upraszczać życie, a jeszcze bardziej jak coś się samo robi. Jestem samoukiem, a co jest wspaniałe w nauce programowania to to że wszystko jest na wyciągnięcie ręki tzn.że potrzebne materiały znajdziesz w większości za darmo. Jedyne czego potrzebujesz to czasu i dużej motywacji.

- Od czego zacząłeś naukę programowania?

Od rozmów, wielu rozmów. Wielu moich dobrych kolegów jest z wykształcenia informatykami. Jak się spotykaliśmy to często temat schodził na programowanie. Czasem udało nam się nawet coś razem popisać. I tak od rozmowy do rozmowy odkryłem, że programowanie ma olbrzymi potencjał. Potem pojawiły się kursy na udemy i pluralsight, ale tak na poważnie to zacząłem swoje programowanie od książki "Symfonia C++".
 
- Z jakimi technologiami aktualnie pracujesz?

Obecnie pracuję z takimi technologiami jak C# i SQL do ogarniania backendu aplikacji webowej oraz React z typescriptem po stronie front endu

- Co sprawiało Ci największe problemy w trakcie przekwalifikowania się? Jak te problemy rozwiązałeś?

Największym problemem był wybór materiałów do nauki, ponieważ istnieje tak wiele źródeł, że teraz nie sztuką jest odszukanie materiałów, ale jak myślę trafna selekcja tych informacji.

- Jak i gdzie zdobywałeś materiały do nauki? Czy możesz polecić źródła z których korzystałeś? Dlaczego akurat te?

Tak jak wcześniej pisałem, głównie kursy online na udemy albo pluralsight. Warto zwrócić uwagę czy kurs jest aktualny, jaką ma ocenę i ile widzów. Z całego serca radzę by samemu spróbować napisać coś choćby bardzo małego prostego. Nie bójcie się kompilatora, on podpowiada, gdzie jest błąd :) Jest bardzo pomocny.

- Co ułatwiało Ci naukę? Miałeś jakieś "sposoby" na łatwiejsze zapamiętywanie?

W programowaniu ważniejsze od zapamiętywania, jest nauczenie się szukania informacji. Niestety system edukacji w jakim zostałem wychowany nakładał wielki nacisk na zapamiętywanie. Nikt nas nie uczył, jak mamy się uczyć, jak szukać informacji, a wydaję mi się, że byłoby to bardzo pomocne. Nie przejmujcie się, jeśli czegoś nie pamiętacie, jeśli tylko potraficie to znaleźć w Internecie :).

- Jak poszły Ci pierwsze rozmowy? Co sprawiło Ci największy problem?

O tym już wyżej pisałem. Poszła średnio-dobrze. Dzięki niej już na kolejnej dużo mniej się stresowałem i wiedziałem czego się spodziewać.

- Jakie masz wskazówki, rady dla osób, które chcą się przekwalifikować?

Życzę Wam dużo motywacji, czasu i czerpania radości z programowania, bo to naprawdę fajne! :)

- Jakie masz plany dotyczące dalszej nauki/rozwoju?

Chciałbym pisać więcej po stronie backendu. Poznać nowe możliwości C# których jeszcze nie znam.

- Jak oceniasz pracę jako programista?

Jest to praca, która wymaga ciągłej gotowości do rozwoju. Codziennie może Cię zaskoczyć jakiś problem, którego w tym momencie nie potrafisz rozwiązać i musisz szukać.  Koledzy z zespołu i w większości programiści są bardzo otwarci i gotowi do pomocy. Zdajemy sobie sprawę ze ktoś może czegoś nie wiedzieć. Informatyka jest tak wielka dziedzina ze jedna osoba nie jest w stanie wszystkiego wiedzieć.

I to jest super! Bo dzięki temu łatwiej prosić o pomoc druga osobę. To jest też trudne, bo trzeba się przyznać, że się czegoś nie wie, ale warto pytać.

Jak dla mnie nie ma lepszej pracy jako programista. Codziennie uczysz się czegoś nowego, nowe wyzwania, wspaniali ludzi, świetna atmosfera w zespole, bardzo się cieszę z tej decyzji jaką podjąłem by zakończyć karierę mostową i rozpocząć karierę jako programista :)

## Ania

Nie rozmawiałem z Anią na temat przekwalifikowania. Jednak jej historia jest dostępna w internecie ;). Jeśli chcesz ją przeczytać to zapraszam na bloga, którego prowadzi razem z Jakubem [Kobiety do kodu](https://kobietydokodu.pl/moje-przebranzowienie-z-perspektywy-2-lat-pracy-w-zawodzie/). Jeśli nie znałeś go wcześniej to znajdziesz tam też sporo artykułów wartych przeczytania.

# Podsumowanie

Mam nadzieję, że historie, które przeczytałeś przypadły Ci do gustu. Postaram się zebrać najważniejsze punkty:

- przebranżowienie jest możliwe,
- przebranżowienie wymaga bardzo dużo konsekwentnej, regularnej pracy i nauki,
- przytoczyłem historię osób, którym się udało. Pamiętaj jednak, że ludzie nie lubią się dzielić swoimi porażkami. Innymi słowy na każdą osobę, której się udało przypada X, które nie dały rady,
- żaden płatny kurs nie zrobi z nikogo programisty bez jego własnej pracy,
- posiadanie mentora, osoby bardziej doświadczonej znacząco przyspiesza naukę,
- programowanie to ciągła nauka, nawet po zdobyciu pracy w zawodzie,
- zdobycie pierwszej pracy jest ciężkie, sam wysłałem blisko 40 CV zanim dostałem tę pierwszą,
- pieniądze też mogą być dobrym motywatorem, jednak na dłuższą metę może być ciężko ze znalezieniem chęci do dalszej nauki, która jest kluczowa.

A teraz jeszcze kilka łyżek dziegdziu, tak żeby zgasić "hura optymizm":

- nikt nie potrafi przewidzieć jak ta branża będzie wyglądała za 5, 10 czy 15 lat. Może uczenia maszynowe i sztuczna iteligencja rozwiną się na tyle, że praca niektórych programistów będzie zbędna i konunktura się odwróci? 
- pamiętaj, że przebranżawiając się rywalizujesz z osobami, które kształcą się w tym kierunku,
- często jest tak, że osoby będące na studiach nie mają tak dużych zobowiązań jak osoba, która chce się przebranżowić. Studenci przeważnie nie mają rodziny na utrzymaniu, czy dużych zobowiązań finansowych[^generalizuje]. Innymi słowy przebrażawiając się możesz sporo ryzykować.

[^generalizuje]: Mam świadomość, że tu mocno generalizuję. Wydaje mi się jednak, że "statystycznie" tak to właśnie wygląda. Tak jak piszę - wydaje mi się, więc będę wdzięczny jeśli pokażesz dane, które wyprowadzą mnie z błędu.

Jeśli myślisz, że chcę Cię odwieść od przebranżowienia, to masz rację. Jeśli mimo tego zostaniesz, to osiągniesz to co sobie założyłeś. Tylko będąc wystarczająco zdeterminowanem możesz to osiągnąć. To jak będzie? Dasz radę się przekwalifikować na programistę? Wiesz już, że to nie jest łatwe. Wiesz, że wymaga to sporo wysiłku. Podejmiesz wyzwanie? Jakąkolwiek decyzję podejmiesz gratuluję wyboru :). Nikt tej decyzji nie podejmie za Ciebie.

Na koniec mam do Ciebie prośbę. Jeśli artykuł przypadł Ci do gustu proszę podziel się nim ze swoimi znajomymi. W ten sposób pomożesz mi dotrzeć do nowych czytelników - z góry dziękuję. Jeśli chcesz otrzymywać informacje o nowych artykułach proszę dopisz się do samouczkowego newslettera i polub Samouczka na [Facebooku](https://www.facebook.com/SamouczekProgramisty). Do następnego razu!
