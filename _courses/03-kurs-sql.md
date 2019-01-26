---
date: 2017-10-20 01:17:28 +0200
last_modified_at: 2018-08-22 20:41:11 +0200
layout: single_page
title: Kurs SQL
permalink: /kurs-sql/
description: W kursie tym omawiam składnię języka SQL. Po przerobieniu tego kursu będziesz wiedzieć czym jest SQL i jak go używać do pracy z bazami danych.
header:
  teaser: /assets/images/splash/kurs_sql_splash.jpeg
  overlay_image: /assets/images/splash/kurs_sql_splash.jpeg
  caption: "[&copy; pixmart](https://unsplash.com/photos/PkbZahEG2Ng)"
excerpt: ""
---

Na tej stronie znajdziesz zestaw artykułów, który pozwoli Ci w praktyczny sposób nauczyć się podstaw języka SQL. Jest to solidna baza, która pozwoli Ci rozbudowywać swoją wiedzę związaną z tym językiem. W kursie staram się pokazywać najczęściej używane elementy SQL, które wspierane są przez większość znanych mi baz danych.

Jeśli z bazami danych masz do czynienia pierwszy raz, zachęcam Cię do przeczytania artykułu [wprowadzającego do relacyjnych baz danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}).

## Praktyka to podstawa

Powtarzam to do upadłego, uczysz się przez praktykę. Dlatego właśnie kurs który przygotowałem pozwoli Ci w praktyce sprawdzić działanie każdego zapytania, które znajdziesz w treści artykułu.

Każdy artykuł kończy się zestawem zapytań do samodzielnego przygotowania. Te zapytania także możesz przetestować i sprawdzić z przykładowymi rozwiązaniami.

## Składania SQL

Do tej pory w ramach kursu SQL ukazały się następujące artykuły:

{% assign posts = site.categories["Kurs SQL"] | reverse %}

{% for post in posts %}
* [{{post.title}}]({{post.url}})
{% endfor %}

## Co dalej?

Jeśli jakikolwiek temat nie jest dla Ciebie wystarczająco jasno opisany proszę daj znać, postaram się go rozwinąć w kolejnym artykule.

Na koniec mam tę samą prośbę co zawsze. Jeśli znajdziesz chwilę, żeby napisać mi co sądzisz o kursie będę wdzięczny. Każda konstruktywna krytyka jest mile widziana. Mój adres e-mail to `marcin małpka samouczekprogramisty.pl`.
