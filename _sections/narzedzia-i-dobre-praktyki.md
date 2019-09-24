---
date: 2019-09-24 19:54:06 +0200
last_modified_at: 2019-05-02 23:15:06 +0200
layout: single_page
title: Narzędzia i dobre praktyki
permalink: /narzedzia-i-dobre-praktyki/
order: 5
header:
  teaser: /assets/images/splash/dzial_narzedzia_i_dobre_praktyki.jpg
  overlay_image: /assets/images/splash/dzial_narzedzia_i_dobre_praktyki.jpg
  caption: "[&copy; Nicolas Hoizey](https://unsplash.com/photos/2MuZ23gkFKo)"
excerpt: ""
---

Znajomość składni języka programowania to dopiero początek. Programista w swojej codziennej pracy wykorzystuje szereg narzędzi, które pomagają mu w pracy. Na tej stronie zebrałem artykuły, które związane są z narzędziami i dobrymi praktykami, które warto stosować na co dzień.

## Narzędzia

* [Wstęp do Gradle]({% post_url 2017-01-19-wstep-do-gradle %})
* [Pierwszy projekt w Gradle]({% post_url 2019-03-22-pierwszy-projekt-z-gradle %})
* [Walidacja obiektów w języku Java]({% post_url 2017-12-04-walidacja-obiektow-w-jezyku-java %})
* [Format JSON w języku Java]({% post_url 2018-09-14-format-json-w-jezyku-java %})
* [Początki pracy z wierszem poleceń]({% post_url 2019-03-12-poczatki-pracy-z-konsola %})

Dodatkowo koniecznie musisz znać system kontroli wersji. Proponuję Ci zacząć od Git'a, który jest standardem w branży. [Kurs Gita]({{ '/kurs-git/' | absolute_url }}) dostępny na Samouczku powinien Ci pomóc go poznać.

## Dobre praktyki

Bez tego się nie obejdzie. Jeśli chcesz tworzyć kod, który będzie łatwy w utrzymaniu, możliwy do rozszerzenia i testowania stosuj dobre praktyki opracowane przez bardziej doświadczonych programistów. Ta lista zawiera artykuły, które opisują takie praktyki.

* [Zasady SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %})
* [Reguły DRY, KISS i YAGNI]({% post_url 2018-09-28-jakosc-kodu-a-oschle-pocalunki-jagny %})
* [Porównanie DIP, IOC i DI]({% post_url 2018-11-03-dependency-inversion-principle-dependency-injection-i-inversion-of-control %})

W niektórych sytuacjach rysunki pokazujące system/rozwiązanie problemu. Właśnie wtedy może Ci się przydać znajomość [podstaw UML]({% 2019-09-21-podstawy-uml %}).

### Testowanie kodu

Testowanie kodu to temat rzeka. Na początek polecam Ci artykuły, które opisują tematykę testów jednostkowych i bibliotekę JUnit:

* [Testy jednostkowe z JUnit]({% post_url 2016-10-29-testy-jednostkowe-z-junit %})
* [Testy jednostkowe z JUnit 5]({% post_url 2018-04-13-testy-jednostkowe-z-junit5 %})
* [Testy jednostkowe z Mockito]({% post_url 2018-09-22-testy-jednostkowe-z-uzyciem-mock-i-stub %})

Jak poznasz już bibliotekę pomagającą w pisaniu testów jednostkowych koniecznie musisz poznać podejście [_Test Driven Development_]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). W artykule tym na przykładzie pokazuję jak TDD wygląda w praktyce. Część zadań z rozmów kwalifikacyjnych, które dostałem od Czytelników także rozwiązałem używając TDD:

* [Zagnieżdżona struktura]({% post_url 2018-08-26-zadanie-zagniezdzona-struktura %})
* [Kalkulator]({% post_url 2018-11-12-zadanie-kalkulator %})

### Wzorce projektowe

Nie bez znaczenia są także wzorce projektowe. Na blogu opisałem kilka z nich. Artykuły poniżej zawierają dokładny opis, przykłady zastosowania i implementację poszczególnych wzorców projektowych:

* [Wzorzec projektowy adapter]({% post_url 2019-01-26-wzorzec-projektowy-adapter %})
* [Wzorzec projektowy obserwator]({% post_url 2019-05-02-wzorzec-projektowy-obserwator %})

## Co dalej?

Skoro udało Ci się już poznać kilka użytecznych narzędzi i dobrych praktyk warto je wykorzystać. Proponuję Ci rozpoczęcie swojego projektu lub przećwiczenie ich w trakcie rozwiązywania zadań. Oba te tematy poruszam na blogu. Znajdziesz tu [projekty realizowane od początku do końca]({{ '/strefa-projektowa/' | absolute_url}}) jak i [zadania dla programistów z przykładowymi rozwiązaniami]({{ '/strefa-zadaniowa/' | absolute_url }}).

Kolejnym krokiem może być także poszerzenie swojej wiedzy związaną z [teorią informatyki]({{ '/wprowadzenie-do-informatyki/' | absolute_url }}).
