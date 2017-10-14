---
layout: single
permalink: /czym-wlasciwie-jest-programowanie/
title: Czym właściwie jest programowanie
date: '2015-10-07 16:03:15 +0200'
categories:
- Programowanie
excerpt_separator: "<!--more-->"
---
No to zaczynamy. Programowanie to nic innego jak ciekawe zajęcie. To ciągłe rozwiązywanie zagadek i problemów w kreatywny sposób. To też żmudna i pracochłonna praca wymagająca zaangażowania i ciągłej nauki. Mimo swoich wad zajmuję się tym od ładnych paru lat, moim zdaniem zalet jest znacznie więcej! W artykułach na tym blogu postaram się przeprowadzić Cię przez początki programowania, zarazić Cię tą pasją. Miejmy nadzieję, że mi się to uda :).

<!--more-->

# Kto może zostać programistą

Programowanie to zajęcie, które wymaga znajomości wielu zagadnień. To wiedza, którą zdobywa się przez kilka ładnych lat. Nie znam żadnego programisty, który nauczył się wszystkiego w jeden wieczór. To jest po prostu niemożliwe. Tak i na tym blogu będziemy razem przechodzili przez serię artykułów, które pomogą Ci zgłębić podstawowe zagadnienia. Pokażę Ci dalszą drogę, która pomoże Ci zostać programistą.

Programowanie jako zajęcie wymaga pewnych umiejętności. Umiejętności te są pomocne przy zgłębianiu niezbędnej wiedzy. Poza umiejętnościami bardzo istotne jest także zaangażowanie i wytrwałość. Oczywiście "talent" pomaga, jednak ciężka, systematyczna praca to podstawa. Bez talentu można programować, jednak bez ciężkiej pracy włożonej w naukę już nie (jestem tego bardzo dobrym przykładem).

Nie bez powodu piszę blog po polsku. Zależy mi na tym, żeby ludzie, którzy nie czują się swobodnie czytając angielskie teksty również znaleźli coś dla siebie. Jednak muszę to powiedzieć z pełną stanowczością. Język angielski to podstawa. Jest to uniwersalny język komunikacji, który każdy programista po prostu musi znać. Jeśli go nie znasz zachęcam do przyłożenia się do zajęć z języka angielskiego. Jeśli nie masz dostępu do takich zajęć w internecie można znaleźć bardzo dużo darmowych materiałów pomagających w nauce.

Mówi się, że programista powinien charakteryzować się analitycznym myśleniem, rozumieć zagadnienia matematyczne. Oczywiście &bdquo;ścisły umysł&rdquo; to predyspozycja, która bardzo pomaga &ndash; sam znam architektów (tych od budownictwa) czy chemików, którzy samodzielnie nauczyli się programowania. Jednak mam wrażenie, że przy odpowiedniej ilości ciężkiej pracy i humanista też w programowaniu znajdzie coś dla siebie. Spróbuj, to na pewno nie zaszkodzi! :)

Podsumowując:
 - ucz się języka angielskiego, na pewno przyda się nie tylko do programowania,
 - nie bój się przedmiotów ścisłych,
 - wkładaj dużo pracy w naukę programowania.

# Rozmowa z komputerem

Do porozumiewania się ze swoimi przyjaciółmi, znajomymi używamy dobrze znanych słów i zwrotów. Rozumiemy się nawzajem, jesteśmy w stanie przekazać sobie pewne informacje. Jeśli posługujemy się językami obcymi porozumiemy się swobodnie z większą grupą ludzi. Podobnie jest z komputerem. Jeśli chcesz się z nim porozumieć musisz mówić jego językiem. Nie chcę Cię tu zanudzać wpisem o zerach i jedynkach fruwających w pamięci komputera jednak pewne podstawy są tu potrzebne.

Język programowania to nic innego jak język, który &bdquo;rozumieją&rdquo; programiści. Są w stanie się nim swobodnie posługiwać, który następnie &bdquo;tłumaczony&rdquo; jest do języka komputera. Słowa przetłumaczone są na ciąg zer i jedynek zrozumiały przez komputer. Ten etap tłumaczenia możemy nazwać kompilacją (ang. compile).


Języki programowania możemy podzielić na języki niskopoziomowe i wysokopoziomowe. Te pierwsze są bardzo trudne do samodzielnego używania. Programy napisane przy ich pomocy mogą być uruchamiane tylko na konkretnych rodzajach komputerów. Na przykład program napisany w języku niskiego poziomu na Twój komputer nie może być uruchomiony na komputerze Twojego kolegi[^architektura].

[^architektura]: Jest to duże uproszczenie, chodzi tu o tak zwaną architekturę procesora. Każda architektura ma swój specyficzny zestaw komend tzw. assembler, która czasami nie może być uruchamiana na różnych procesorach.

Tego typu ograniczenia sprawiają, że języków niskiego poziomu nie używa się powszechnie a jedynie do bardzo specyficznych zastosowań, które są bardzo odległe od &bdquo;podstaw i nauki programowania&rdquo; :) Dzięki tym samym ograniczeniom języki wysokiego poziomu zyskują na popularności.

# Polski? Angielski? Niemiecki? Rosyjski? Francuski?

F? Erlang? JavaScript? Java? Perl? Ruby? Podobnie jak istnieje wiele języków, którymi mówią ludzie istnieje także wiele języków programowania. Każdy z tych języków charakteryzuje się specyficzną składnią (ang. _sytax_). Każdy z nich ma również specyficzny zakres zastosowań. Po prostu jego właściwości sprawiają, że lepiej nadaje się np. do pisania gier komputerowych niż tworzenia interaktywnych stron internetowych.

W ramach pierwszego kursu dostępnego na blogu skupimy się na języku Java. Wybór padł na ten język ponieważ google nadal raportuje spore zainteresowanie tym językiem, jak i jest on w miarę &bdquo;uniwersalny&rdquo; i bardzo powszechny. W następnym artykule skupimy się na omówieniu podstaw tego języka jednak zanim do tego dojdzie chciałbym Wam przybliżyć następujące pojęcia:

 - język obiektowy (ang. _objective language_)
 - maszyna wirtualna (ang. _virtual machine_)

# Czym jest język obiektowy?

Weźmy za przykład stół i jego projekt. Fabryka produkuje setki stołów, wszystkie według tego samego projektu. Podobne projekty istnieją w języku programowania. Stół możemy uznać za tak zwaną instancję (ang. _instance_) lub obiekt (ang. _object_) klasy stół.

Innymi słowy projekt służy nam do tworzenia obiektów/instancji. Odpowiednikiem projektu w języku programowania jest klasa (ang. _class_).

Język obiektowy jest językiem, który pozwala na tworzenie swoich własnych klas. Mając definicję klasy jesteśmy w stanie stworzyć jej instancję.

# Czym jest maszyna wirtualna?

Maszyna wirtualna to program napisany w języku niższego poziomu. Program ten pozwala na pewną abstrakcję, upraszcza niektóre aspekty rozmowy z komputerem. Jako przykład podam tu maszynę wirtualną języka Java. Maszyna ta do pewnego stopnia zwalnia programistę z odpowiedzialności zarządzania pamięcią.

Instancje klas, które tworzymy zajmują pamięć. Komputer musi dokładnie wiedzieć ile pamięci ma zarezerwować na daną instancję. Jeśli język korzysta z maszyny wirtualnej wspomagającej zarządzenie pamięcią programista nie musi się tym przejmować (oczywiście jest to pewne uproszczenie, ale na tym etapie zaawansowania w zupełności wystarczy).

Na dzisiaj wystarczy. Dzisiaj było bardzo mocno teoretycznie, następnym razem zaczniemy bawić się programowaniem. Czy którykolwiek z elementów wydał się dla Ciebie niezbyt jasny? Proszę daj mi znać o tym w komentarzu. Jeśli uznasz wpis za ciekawy proszę podziel się nim ze swoimi znajomymi.

Do następnego razu! :)

[FM_form id="3"]
