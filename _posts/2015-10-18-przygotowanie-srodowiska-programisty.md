---
title: Przygotowanie środowiska programisty
date: '2015-10-18 22:33:58 +0200'
categories:
- Kurs programowania Java
- Programowanie
permalink: /przygotowanie-srodowiska-programisty/
header:
    teaser: /assets/images/2015/10/18_przygotowanie_srodowiska_programisty.jpg
    overlay_image: /assets/images/2015/10/18_przygotowanie_srodowiska_programisty.jpg
excerpt: Dzisiaj zajmiemy się instalacją środowiska programistycznego, które będzie niezbędne do rozpoczęcia naszej przygody z programowaniem. Poznasz różnicę między JDK i JRE. Dowiesz się czym jest IDE i do czego może się przydać. Wyjaśnię też parę dodatkowych zagadnień związanych z rozwojem oprogramowania jak wersjonowanie.
disqus_page_identifier: 28 http://www.samouczekprogramisty.pl/?p=28
---

{% include kurs-java-notice.md %}

W [poprzednim artykule]({% post_url 2015-10-07-czym-wlasciwie-jest-programowanie %}) pobieżnie opisałem czym właściwie jest programowanie. Do rozpoczęcia nauki niezbędne będzie zainstalowanie paru dodatkowych narzędzi niezbędnych dla programisty. Zanim do tego przejdziemy postaram się wytłumaczyć czym właściwie jest wersjonowanie oprogramowania.

## Wersjonowanie oprogramowania
  
Czy widziałeś czasami dziwne numerki dołączone do nazwy programu, którego aktualnie używasz? Np. 1.0.7, 0.7, 1.2-rc1, 3.14? To nic innego jak wersja oprogramowania, którego używasz.

Nowsze wersje oprogramowania przeważnie zawierają zestaw nowych funkcjonalności niedostępnych w poprzednich wersjach. Poprawiają błędy znalezione przez użytkowników. Rozwiązują problemy związane z bezpieczeństwem.

Jeśli program jest w stanie współpracować z innym programem mówimy wówczas, że jest on kompatybilny (ang. _compatible_). Czasami zdarza się, że nowsza wersja nie jest kompatybilna wstecz ze starą wersja oprogramowania. Oznacza to, że programy używające innego programu w wersji 1 nie będą mogły używać go w wersji 2.

Poniżej przedstawię Ci przykładowy opis jednego z możliwych standardów wersjonowania programów. Nie jest to standard jedyny, jednak jest dość popularny.

### Wersjonowanie oprogramowania X.Y.Z
  
Standardowo na wersję oprogramowania składają się trzy osobne liczby. Mówiąc o wersji oprogramowania możemy mieć na myśli np. wersję 2.7.0. Wersja ta składa się z 3 członów:
- 2 – (ang. _major_) każdy nowy numer oznacza nową wersję, która nie jest kompatybilna wstecz,
- 7 – (ang. _minor_) każda nowa wersja oznacza wprowadzenie nowych funkcjonalności kompatybilnych wstecz,
- 0 – (and. _patch_) kolejny numer wersji w tym członie symbolizuje zbiór łatek.
  
  
Jako łatkę (ang. _patch_) możemy traktować fragment kodu poprawiający błędy (ang. _bugs_) znalezione w starszej wersji oprogramowania. Zbiór łatek przeważnie grupowany jest w osobne wersje. Np. wersja 2.7.1 zawierająca kila łatek poprawia błędy znalezione w wersji 2.7.0.

A teraz kilka przykładów:

- Wersja 2.0.0 wprowadza zmiany, które nie są kompatybilne z wersją 1.8.0,
- Wersja 1.8.0 wprowadza nową funkcjonalność kompatybilną z 1.7.5,
- Wersja 1.7.5 wprowadza poprawki funkcjonalności względem wersji 1.7.4.
  
{% include newsletter-srodek.md %}

## Instalacja niezbędnych narzędzi
  
Naszą naukę zaczniemy od języka Java. Jest to język obiektowy, wymagający wirtualnej maszyny (oba pojęcia wyjaśniłem poprzednio - zachęcam do powtórki w razie wątpliwości). Istnieje wiele implementacji wirtualnej maszyny Javy. Mówiąc o wielu implementacjach mam tu na myśli różne firmy dostarczające JVM (ang. _Java Virtual Machine_). Najbardziej popularną z nich jest maszyna wirtualna firmy Oracle. Zanim jednak przejdziemy przez proces instalacji chciałbym wyjaśnić Ci jedną ważną kwestię..

### Czym różni się JDK od JRE?
  
W przypadku języka Java często będziesz miał styczność z terminami JRE oraz JDK. Bardzo istotne jest zrozumienie różnicy pomiędzy nimi.

JRE (ang. _Java Runtime Environment)_ – jest to maszyna wirtualna nie zawierająca dodatkowych narzędzi niezbędnych dla programisty. W uproszczeniu można powiedzieć że zawiera wyłącznie implementację wirtualnej maszyny – program java. Do uruchamiania programów napisanych w języku Java wystarczy JRE.

JDK (ang. _Java SE Development Kit_) – jest to zestaw narzędzi dla programisty. Zestaw ten jest niezbędny do pisania programów w języku Java. Poza programem java zawiera wiele innych. Jednym z dodatkowych programów zawartych w zestawie jest javac – kompilator[^kompilator] języka Java.

 [^kompilator]: Kompilator to narzędzie tłumaczące język wysokiego poziomu na instrukcje zrozumiałe przez komputer. W naszym przypadku javac jest kompilatorem tłumaczącym język Java na tak zwany bajtkod (ang. _bytecode_). Ten drugi jest interpretowany i wykonywany przez maszynę wirtualną.

### Instalacja JDK

Proces instalacji jest różny na różnych systemach operacyjnych. Sam używam jednej  
z dystrybucji systemu Linux jednak na potrzeby tego wpisu pożyczyłem komputer  
z systemem Windows 7. Cały proces zaczynamy od ściągnięcia odpowiedniej wersji maszyny wirtualnej.

Ważne jest żeby była to wersja 1.8 bądź nowsza (poniżej zobaczysz proces instalacji dla wersji 1.8u60).

Krok pierwszy polega na ściągnięciu odpowiedniej wersji JDK ze [strony Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

Proszę pamiętaj o tym, żeby ściągnąć wersję odpowiednią dla Twojego systemu. Jeśli masz system 32-bitowy ściągnij plik jdk-8u60-windows-i586.exe. W przypadku systemu 64-bitowego ściągnij plik jdk-8u60-windows-x64.exe. Instrukcja opisująca to jak dowiedzieć się jaki masz system dostępna jest na [stronie pomocy systemu Windows.](http://windows.microsoft.com/pl-pl/windows/32-bit-and-64-bit-window)

Aby móc ściągnąć jeden z plików musisz przeczytać i zaakceptować warunki licencji.

{% include figure image_path="/assets/images/2015/10/18_download_0.jpg" caption="Pobierz JDK." %}

Po ściągnięciu pliku uruchom go i postępuj zgodnie z instrukcją instalacji. Poniżej prezentuję kolejne ekrany widoczne podczas instalacji JDK.

{% include figure image_path="/assets/images/2015/10/18_jdk_install_0.jpg" caption="Instalacja JDK krok I" %}

{% include figure image_path="/assets/images/2015/10/18_jdk_install_1.jpg" caption="Instalacja JDK krok II" %}

{% include figure image_path="/assets/images/2015/10/18_jdk_install_2.jpg" caption="Instalacja JDK krok III" %}

{% include figure image_path="/assets/images/2015/10/18_jdk_install_3.jpg" caption="Instalacja JDK krok IV" %}

### Czego używają programiści do pisania kodu

W najprostszym przypadku wystarczy zwykły edytor tekstu. W systemie operacyjnym Windows funkcję tą spełnia Notatnik. Większość języków programowania nie wymaga innego narzędzia do pisania kodu.

Chociaż takie narzędzie w zupełności wystarczy do efektywnej pracy przydają się bardziej zaawansowane narzędzia. Jednym z nich jest „zintegrowane środowisko programistyczne” – IDE (ang. Integrated Development Environment). IDE poza bardziej zaawansowanym edytorem zawiera zestaw dodatkowych narzędzi przydatnych programiście. Np. „profiler”, „debuger”, zestaw narzędzi do refaktoryzacji itp. Jeśli jesteś zainteresowany, którymkolwiek z tych zagadnień daj znać, na pewno napiszę artykuł na jego temat ;)

Nie ma jednego, słusznego IDE, którego programista powinien używać. Sam swoją przygodę zaczynałem z Eclipse i NetBeans. Jednak po pierwszych doświadczeniach z InteliJ Idea i opinii wśród innych programistów wydaję mi się, że powinieneś zacząć właśnie od tego IDE. Postaram się przeprowadzić Cię przez cały proces instalacji.

### Instalacja InteliJ Idea

Podobnie jak w przypadku instalacji JDK używałem maszyny z systemem Windows 7. Aby ściągnąć InteliJ Idea musisz na stronie <https://www.jetbrains.com/idea/download> nacisnąć przycisk z napisem „Download Community”.

{% include figure image_path="/assets/images/2015/10/18_download_2.jpg" caption="Pobierz InteliJ Idea." %}

Instalacja InteliJ nie zawiera tak wiele ekranów jak instalacja JDK :) Jednak to nie wszystko. Teraz, gdy mamy już działające IDE należy je skonfigurować. Na pierwszym ekranie masz możliwość wyboru zestawu kolorów. Ja wybrałem ciemny, oczywiście możesz to później zmienić.

{% include figure image_path="/assets/images/2015/10/18_install_1.jpg" caption="Instalacja krok I" %}

### Tworzenie pierwszego projektu w InteliJ Idea
  
Świeżo po instalacji InteliJ Idea niestety nie wie, którego JDK ma użyć (tak, możesz mieć kilka zainstalowanych JDK na jednym komputerze). Dlatego przy tworzeniu pierwszego projektu należy wskazać odpowiednią ścieżkę gdzie poprzednio zainstalowaliśmy JDK.

{% include figure image_path="/assets/images/2015/10/18_install_2.jpg" caption="Instalacja krok II" %}

{% include figure image_path="/assets/images/2015/10/18_project_1.jpg" caption="Tworzenie projektu krok I" %}

Następnie wybieramy ścieżkę gdzie zainstalowaliśmy JDK.

{% include figure image_path="/assets/images/2015/10/18_project_2.jpg" caption="Tworzenie projektu krok II" %}

Po dodaniu JDK możemy je wybrać w menu rozwijanym. Na kolejnym ekranie nie wybieramy żadnego szablonu. Ostatni ekran to wybór nazwy projektu – ja wybrałem test.

{% include figure image_path="/assets/images/2015/10/18_project_3.jpg" caption="Tworzenie projektu krok III" %}

{% include figure image_path="/assets/images/2015/10/18_project_4.jpg" caption="Tworzenie projektu krok IV" %}

{% include figure image_path="/assets/images/2015/10/18_project_5.jpg" caption="Tworzenie projektu krok V" %}

I tak utworzyliśmy swój pierwszy projekt w InteliJ! :) Co prawda nie ma w nim jeszcze ani linijki kodu ale tym szczegółem zajmiemy się następnym razem.

{% include figure image_path="/assets/images/2015/10/18_project_6.jpg" caption="Tworzenie projektu krok VI" %}

## Podsumowanie

I tak dobrnęliśmy do końca przygotowania podstawowego środowiska dla programisty. Jeśli masz pytania dotyczące któregokolwiek z tematów proszę zadaj je w komentarzach. Proszę także podziel się tym artykułem ze swoimi znajomymi jeśli uznasz go za interesujący.
