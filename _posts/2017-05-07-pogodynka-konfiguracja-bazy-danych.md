---
title: Pogodynka - konfiguracja bazy danych
last_modified_at: 2018-09-30 20:17:41 +0200
categories:
- DSP2017
- Projekty
- Pogodynka
permalink: /pogodynka-konfiguracja-bazy-danych/
header:
    teaser: /assets/images/2017/05/07_konfiguracja_puppet_artykul.jpeg
    overlay_image: /assets/images/2017/05/07_konfiguracja_puppet_artykul.jpeg
    caption: "[&copy; joseywales](https://www.flickr.com/photos/joseywales/316407208/sizes/o/)"
excerpt: Zabawy z Pogodynką ciąg dalszy. Dzisiaj opiszę co udało mi się zrobić w niedzielny wieczór w sprawie Pogodynki. Zapraszam do lektury.
disqus_page_identifier: 892 http://www.samouczekprogramisty.pl/?p=892
toc: false
---

Niestety moje plany kontynuacji konfiguracji od początku tygodnia spełzły na niczym. Założyłem, że to co zostało to już “pikuś” i powinno pójść prosto... O tym, jak strasznie się myliłem przeczytasz poniżej ;).

Na początku chciałbym zastrzec, że nie jestem administratorem, więc jeśli masz jakiekolwiek uwagi mogące poprawić ustawienie środowiska bardzo proszę o informację w komentarzu.

## Baza danych

Jako produkcyjną bazę danych wybrałem [PostgreSQL](https://www.postgresql.org/). W przypadku tej aplikacji silnik bazy danych nie ma większego znaczenia. Nie będzie to “hurtownia danych” z olbrzymim zbiorem a raczej kilka (jedna?) prostych tabel.

W poprzednim tygodniu znalazłem [moduł puppeta](https://github.com/puppetlabs/puppetlabs-postgresql), który pomaga w konfiguracji instancji postgresql na serwerze. Ujarzmienie tego modułu trochę mi zajęło.

Okazało się, że serwer bazy danych nie mógł poprawnie wystartować ponieważ w na serwerze, nie wszystkie informacje o lokalizacji były dostępne:

    root@debian:~# locale
    LANG=en_US.UTF-8
    LANGUAGE=
    LC_CTYPE="en_US.UTF-8"
    LC_NUMERIC=pl_PL.UTF-8
    LC_TIME=pl_PL.UTF-8
    LC_COLLATE="en_US.UTF-8"
    LC_MONETARY=pl_PL.UTF-8
    LC_MESSAGES="en_US.UTF-8"
    LC_PAPER=pl_PL.UTF-8
    LC_NAME=pl_PL.UTF-8
    LC_ADDRESS=pl_PL.UTF-8
    LC_TELEPHONE=pl_PL.UTF-8
    LC_MEASUREMENT=pl_PL.UTF-8
    LC_IDENTIFICATION=pl_PL.UTF-8
    LC_ALL=

Jak widać tutaj używane były dwie lokalizacje `en_US.UTF-8` i `pl_PL.UTF-8`. W pliku `/etc/locale.gen` dostępna byłą tylko jedna z nich. Dodanie obu lokalizacji do tego pliku pozwoliło utworzyć klaster i uruchomić serwer bazy danych. Po zmianie zawartości tego pliku konfiguracyjnego niezbędne jest uruchomienie polecenia `locale-gen`.

    # grep -v '#' /etc/locale.gen
    pl_PL.UTF-8 UTF-8
    en_US.UTF-8 UTF-8

## Firewall

W poprzednim odcinku wspominałem o konfiguracji firewalla, niestety dalej nie udało mi się zrobić poprawnego przekierowania ruchu z portu 80 na port 8080. Muszę jeszcze nad tym popracować. Próbowałem znaleźć odpowiedź na to [pytanie na StackOverflow](http://stackoverflow.com/questions/43828853/forwarding-traffic-from-80-to-8080), niestety z marnym rezultatem :(.

## Przechowywanie haseł

Jednym z mechanizmów dostępnych w Puppecie jest [hiera](https://docs.puppet.com/hiera/). Jest to swego rodzaju hierarchiczna konfiguracja dostępna dla manifestów puppeta. W moim przypadku nie używam hierarchii plików a jedynie jednego pliku `passwords.yaml`.

Plik ten zawiera wszystkie hasła, które nie powinny być dostępne na Githubie ;). Na przykład zawarte jest tam hasło dla głównego użytkownika bazy danych. Dzięki takiemu podejściu mogę dzielić się z Tobą konfiguracją, zachowując jednocześnie odpowiedni poziom bezpieczeństwa[^bezpieczenstwo].

[^bezpieczenstwo]: Jak na moją wiedzę z tego zakresu ;).

Przykładowe użycie w manifeście wygląda następująco

    hiera(‘variable_name’)

Wówczas puppet wyszukuje wartości zmiennej variable\_name i wstawia ją w odpowiednie miejsce w manifeście. Przykładowe użycie możesz znaleźć w [konfiguracji bazy danych](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/puppet/modules/pogodynka/manifests/database.pp). Same hasła są losowymi ciągami o długości 64 znaków generowanymi przy pomocy komendy pwgen.

## Podsumowanie

Zostało coraz mniej czasu, deadline coraz bliżej a tu końca nie widać ;). Mam nadzieję, że w przyszłym tygodniu uda mi się już rozwiązać definitywnie problemy z konfiguracją. Na dzisiaj to tyle, trzymaj się i do następnego razu! ;)
