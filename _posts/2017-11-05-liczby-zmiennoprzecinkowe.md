---
title: Liczby zmiennoprzecinkowe
categories:
- Programowanie
- Wiedza ogólna
permalink: /liczby-zmiennoprzecinkowe/
header:
    teaser: /assets/images/2017/11/05_liczby_zmiennoprzecinkowe_artykul.jpg
    overlay_image: /assets/images/2017/11/05_liczby_zmiennoprzecinkowe_artykul.jpg
    caption: "[&copy; russellstreet](https://www.flickr.com/photos/russellstreet/9724283620/sizes/l)"
excerpt: Po lekturze tego artykułu będziesz wiedział dlaczego `0,1 + 0,2 != 0,3`. Dowiesz się w jaki sposób zapisywane są liczby wymierne w pamięci komputera. Poznasz sposób na dodawanie i odejmowanie liczb zmiennoprzecinkowych. Poznasz część standardu IEEE754 i zrozumiesz dlaczego część typów nie nadaje się do przechowywania dokładnej reprezentacji liczb wymiernych. Krótkie zadanie do rozwiązania pomoże Ci utrwalić wiedzę z artykułu.
---

{% include toc %}

Artykuł ten wymaga znajomości notacji binarnej. Jeśli jeszcze jej nie znasz koniecznie zapoznaj się z [artykułem opisującym system binarny]({% post_url 2016-02-11-system-dwojkowy %}).
{: .notice--info}

{% capture disclaimer %}
Artykuł ten ma Cię jedynie wprowadzić w tematykę związaną ze standardem IEEE754. Nie poruszam w nim kwestii związanych z arytmetyką (poza dodawaniem), zaokrąglaniem czy wartościami specjalnymi.

Celem tego artykułu jest wytłumaczenie dlaczego operacje na liczbach zmiennoprzecinkowych nie są dokładne. Jeśli szukasz bardziej szczegółowych informacji odsyłam do punktu "Dodatkowe materiały do nauki".
{% endcapture %}

<div class="notice--warning">
  {{ disclaimer | markdownify }}
</div>

## Niezbędne podstawy

### Czym są liczby wymierne

Żeby móc mówić o liczbach zmiennoprzecinkowych należy zrozumieć czym są liczby wymierne. Liczba wymierna to liczba, którą można przedstawić w postaci ułamka zwykłego. Dla przypomnienia to ten ułamek z kreską poziomą, który ma licznik i mianownik. 

### Liczby wymierne zapisywane binarnie

Liczby wymierne można zapisać także binarnie. 


## Notacja naukowa a liczby wymierne

## Czym jest standard IEEE754

## Liczba zmiennoprzecinkowa

### Części składowe liczby zmiennoprzecinkowej

### Znak

### Wykładnik

kodowanie z nadmiarem

### Mantysa


## Operacje na liczbach


### Arytmetyka zmiennoprzecinkowa


#### Dodawanie liczb zmiennoprzecinkowych

## Dlaczego `0,1 + 0,2 != 0,3`

## Dodatkowe materiały do nauki

## Podsumowanie

