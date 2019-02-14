---
title: Pogodynka – naiwny termometr
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /pogodynka-naiwny-termometr/
header:
    teaser: /assets/images/2017/03/11_pogodynka_02_artykul.jpeg
    overlay_image: /assets/images/2017/03/11_pogodynka_02_artykul.jpeg
    caption: "[&copy; zedc](https://www.flickr.com/photos/zedc/9387184605/sizes/l)"
excerpt: Pogodynka to projekt realizowany w ramach konkursu Daj Się Poznać 2017. W ramach tej serii artykułów relacjonuję postęp prac nad projektem. Poza relacją przeczytasz też o crontab, programie, który zamierzam użyć w projekcie. Dowiesz się też coś o monitorowaniu i logowaniu. Zapraszam!
disqus_page_identifier: 778 http://www.samouczekprogramisty.pl/?p=778
toc: false
---

## Malinka padła

Niestety poprzedni tydzień minął pod znakiem kolejnych nieudanych prób wskrzeszenia mojej Malinki. Leżała ona już prawie 5 lat w szafie, przerzucana z miejsca na miejsce. Miała prawo “wysiąść”. Idę na łatwiznę – nie próbuję jej teraz naprawić. Wczoraj kupiłem nowszą wersję płytki, tym razem jest to Rasperry Pi 3 B, więc jest to już dużo mocniejszy układ, niż poprzedni. Ta nowa wersja ma też więcej portów USB, czego przyznam brakowało mi w wersji poprzedniej (jeszcze 5 lat temu jak płytka działała...). Używa też wbudowanego modułu do komunikacji WiFi co też jest sporym ułatwieniem.

Przesyłka jest już w drodze, więc jeśli wszystko dobrze pójdzie powinienem mieć nową malinkę w poniedziałek u siebie.

## Termometr

Pchnąłem do przodu moduł termometru. Kilka nowych linijek kodu się pojawiło, jednak “serce” czyli właściwe odczytywanie temperatury nie działa, z oczywistych względów. Aktualnie działa "naiwny" termometr, który zwraca aktualną godzinę jako wskazanie temperatury ;).

Przy okazji tego wpisu przybliżę Ci trochę narzędzia, które są niezbędne do realizacji tej części projektu. Zacznę od `crontab'a`.

{% include newsletter-srodek.md %}

## `crontab`

W systemach operacyjnych są programy, które działają w tle. Programy tego typu nazywa się serwisami lub demonami. Jednym z takich demonów w systemach z rodziny Linux jest cron. Jest to demon, który odpowiada za uruchamianie poleceń zdefiniowanych przez użytkownika z odpowiednią częstotliwością.

Dzięki temu demonowi możesz na przykład sprawdzić aktualną temperaturę co pięć minut :). Idealne zastosowanie dla mojej pogodynki. `crontab` używa specyficznej składni, która pozwana na określenie kiedy dana komenda powinna być uruchamiana:

    ┌───────────── minuta (0 - 59)
    │ ┌───────────── godzina (0 - 23)
    │ │ ┌───────────── dzień miesiąca (1 - 31)
    │ │ │ ┌───────────── miesiąc (1 - 12)
    │ │ │ │ ┌───────────── dzień tygodnia (0 - 6) (0 - niedziela, 6 - sobota)
    │ │ │ │ │
    │ │ │ │ │
    │ │ │ │ │
    * * * * * <polecenie do wykonania>


Kilka przykładów, powinno pomóc Ci lepiej zrozumieć ustawienia crontab’a:
- `* * * * * <komenda>` – uruchom komendę co minutę,
- `* 0 * * * <komenda>` – uruchom komendę co minutę w trakcie godziny 0,
- `30 17 * * * <komenda>` – uruchom komendę codziennie o 17:30,
- `15 4 ? * 0 <komenda>` – uruchom komendę co sobotę o 4:15,
- `0-15 * * * * <komenda>` – uruchom komendę co minutę w pierwszych 16 minutach każdej godziny,
- `0,5,10 * * * * <komenda>` – uruchom komendę w zerowej, piątek i dziesiątej minucie każdej godziny,
- `*/5 * * * * <komenda>` – uruchom komendę co pięć minut,

Właśnie ta ostatnia linijka przyda się w przypadku pogodynki – co 5 minut będę chciał pobierać aktualne wskazanie temperatury.

## Monitorowanie programu

W związku z tym, że zadanie sprawdzania temperatury będzie się odbywało w regularnych odstępach i będzie działo się automatycznie potrzebuję mechanizmu do monitorowania żeby zapewnić poprawnie i ciągłe działanie termometru.

Z doświadczenia wiem, że tego typu zadania dość często płatają figle i nie wykonują się poprawnie. Postanowiłem użyć serwisu [https://healthchecks.io](https://healthchecks.io). Jest to darmowy serwis, który umożliwia wysyłanie stanu programu[^ping] na skonfigurowany adres URL. Serwis ten monitoruje czy takie zapytanie jest wysyłanie z odpowiednią częstotliwością.

[^ping]: W sumie nie jest to stan, a jedynie "ping", co w zupełności spełnia wymagania.

Jak widzisz na obrazku poniżej pokazuję przykładowe ustawienia healthchecks

{% include figure image_path="/assets/images/2017/03/11_healthchecks.jpg" caption="Interfejs healthchecks" %}

Następnie healthchecks poinformuje mnie mailem o tym, że termometr nie mierzył temperatury z częstotliwością, którą skonfigurowałem.

## Logowanie

Załóżmy, ze coś poszło nie tak. Dostałem maila z informacją o tym, że temperatura nie jest mierzona. Co teraz? :) Z pomocą przychodzą logi. Logi, czyli informacje, które zapisywane są do pliku w trakcie działania programu. W pliku z logami zapisuje się różne informacje, zaczynając od “stanu programu” na rzuconych wyjątkach kończąc. Właśnie na podstawie takich plików będzie można później dojść co poszło “nie tak”.

W tym tygodniu zaimplementowałem właśnie logowanie, zapraszam do rzucenia okiem na [kod źródłowy](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/thermometer). Do logowania używam standardowych bibliotek dosępnych dla Javy [SL4J](https://www.slf4j.org) i [LOG4J](https://logging.apache.org/log4j/2.x/).

Logi będą generowane cały czas. Program w końcu ma uruchamiać się co 5 minut. Naturalne jest więc, że po pewnym czasie plików z logami będzie sporo. Mogą też one zajmować dużo miejsca. Z pomocą po raz kolejny przychodzi crontab. Raz dziennie będę usuwał logi, które będą starsze niż tydzień.

## Komenda do mierzenia temperatury

Z artykułu, w którym opisywałem [Javę w linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}) wiesz jak zbudować plik jar i jak uruchomić program z linii poleceń. Właśnie tę wiedzę potrzebujesz to wpisania programu uruchamianego cyklicznie do cron’a. W moim przypadku będzie to polecenie

    java -jar /opt/pogodynka/thermometer-1.0-SNAPHSOT.jar

Aby nie wypisywać długiej listy zależności i nie dodawać ich do classpath przy uruchomieniu programu użyłem tu pewnej sztuczki. Wszystkie zależności programu zostały zapakowane do jednego pliku jar. Tego typu zachowanie skonfigurowałem w pliku [thermometer.gradle](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/thermometer/thermometer.gradle). O podstawach Gradle przeczytasz w [osobnym artykule]({% post_url 2017-01-19-wstep-do-gradle %}).

### Przekazywanie parametrów

Aby nie musieć kompilować kodu za każdym razem istotne ustawienia przekazywane będą jako parametry linii poleceń. Użytkownik, jego hasło czy adres gdzie ma być wysłane aktualny odczyt temperatury przekazane będą jako argumenty. "Parsowaniem" tych argumentów zajmuje się osobna klasa `Arguments`.

### Monitorowanie

Dodatkowo “zintegruję” to z wcześniej opisanym serwisem healthchecks. Z pomocą przyjdzie operator `&&` w bashu, który wykonuje to co jest po prawej stronie jeśli kod zakończenia komendy po lewej stronie jest równy 0.

Zatem finalnie komenda w crontab będzie wyglądała następująco:

    java -jar /opt/pogodynka/thermometer-1.0-SNAPSHOT.jar dummyUsername dummyPassword \
    https://www.samouczekprogramisty.pl/getrealaddress && \
    curl -fsS --retry 3 https://hchk.io/89941a75-5e1a-4b0b-a864-59d584e579a8

Magiczna część po && odpowiada za wysłanie zapytania do healtchecks. Całość opakowałem w [drobny skrypt](https://github.com/SamouczekProgramisty/Pogodynka/blob/45e3004e55634debd6a6c69aa29d0549d5405456/thermometer/add_to_crontab.sh) w bash’u, który automatyzuje dodanie wpisu do cron’a. Skrypt dostępny jest na githubie.
Tak oto wygląda crontab po uruchomieniu tego skryptu:

    $ crontab -l
    */5 * * * * java -jar /opt/pogodynka/thermometer-1.0-SNAPSHOT.jar dummyUsername dummyPassword https://www.samouczekprogramisty.pl/getrealaddress && curl -fsS --retry 3 https://hchk.io/89941a75-5e1a-4b0b-a864-59d584e579a8
    1 0 * * * find /var/log/pogodynka/*.log -mtime +7 -exec rm {} \;

## Efekt finalny

Aktualnie moduł termometru jest popchnięty najdalej jak tylko mogłem. Teraz czas na pozostałe elementy o czym przeczytasz za tydzień. W przyszłym tygodniu skupię się na kolejnym elemencie – aplikacji webowej, która będzie przyjmowała odczyt temperatury.

## Podsumowanie

Zachęcam Cię do śledzenia zadań, które wykonuję w ramach realizacji tego projektu. Możesz je zobaczyć na [trello](https://trello.com/b/yqZHTqSN/pogodynka). Najnowszą wersję kodu źródłowego zawsze znajdziesz na [githubie](https://github.com/SamouczekProgramisty/Pogodynka).

Zapisz się do mojego newslettera i polub stronę na facebooku jeśli nie chcesz pominąć kolejnych artykułów. Do następnego razu!
