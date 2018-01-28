---
title: Strumienie w języku Java
categories:
- Kurs programowania Java
permalink: /strumienie-w-jezyku-java/
header:
    teaser: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2018/01/30_strumienie_w_jezyku_java_artykul.jpg
    caption: "[&copy; AdamB1995](https://www.flickr.com/photos/150015896@N08/34409885560/sizes/l)"
excerpt: Stumyki
---

{% capture wymagania %}
To jest jeden z artykułów w ramach [darmowego kursu programowania w Javie]({{ "/kurs-programowania-java" | absolute_url }}). Proszę zapoznaj się z pozostałymi częściami, mogą one być pomocne w zrozumieniu materiału z tego artykułu.

W szczególności potrzebna będzie wiedza na temat [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %})
{% endcapture %}

<div class="notice--info">
    {{ wymagania | markdownify }}
</div>


Tematy do poruszenia:
stream peek
allMatch 
jak działają strumienie
stream to nie pętla - break nie działa
stream for array
stream to comma sepparated string
stream sort
predicate
stream/parallel stream
stream duplicates
spliterator
flatten list of lists
short circuit
flatMap
IntStream DoubleStream LongStream
parallel/sequential switches
collect(groupingBy(
zwięzłe metody - dobre praktyki
zrównoleglenie, wielowątkowość za darmo
Function.identity()
intermididate vs terminal operations
unordered
"don't change" the source - zmieniają obiekty niemutowalne
Ograniczanie na początku
mapToInt
Streams.iterate
Streams.generate

"mutation of the shared state" - zła praktyka
List<String> rtsGames = new ArrayList<String>(); 
List<Game> games = null
games.stream()
  .filter(g -> g.getGenere() == Genere.RTS)
  .map(Game::getName)
  .forEach(name -> rtsGames.add(name)); 

dobra praktyka
List<Game> games = null
List<String>rtsGames = games.stream()
  .filter(g -> g.getGenere() == Genere.RTS)
  .map(Game::getName)
  .collect(Collectors.toList()); 

Tworzenie strumieni
- Arrays.stream
- Patern.combile().steram
- Collection.stream()
- File.stream()
- Stream.empty()
- IntStream LongStream DoubleStream
- Random.stream

## Strumienie to nie struktury danych

W poprzednich artykułach opisałem kilka struktur danych. Przykładem struktur danych może być [lista wiązana]({% post_url 2018-01-01-struktury-danych-lista-wiazana %}) czy [mapa]({% post_url 2018-01-08-struktury-danych-tablica-asocjacyjna %}). Strumienie nie są strukturą danych. W odróżnieniu od struktur nie służą do przechowywania danych. Strumienie jedynie pomagają określić operacje, które na tych danych chcesz wykonać. 

Mówi się, że strumienie pozwalają w deklaratywny sposób opisać operacje na danych. Można to uprościć do stwierdzenia, że struktury służą do przechowywania danych a strumienie służą do opisywania algorytmów, operacji na danych.

## Zadanie

Na koniec przygotowałem dla Ciebie kilka zadań do rozwiązania, które pomogą Ci utrwalić wiedzę zdobytą w tym artykule:

- Przerób poniższ fragment kodu tak żeby kod używał strumieni,
  ...
- Znajdz minimalny elment w kolekcji używając strumieni i funkcji reduce. Twoja funkcja powinna działać jak isteniejąca funkcja min.

## Dodatkowe materiały do nauki

Poniżej zebrałem dla Ciebie kilka dodatkowych źródeł, które pozwolą spojrzeć Ci na temat strumieni z innej strony. 

- [Bardzo dobra dokumentacja pakietu `java.util.stream`](https://docs.oracle.com/javase/9/docs/api/java/util/stream/package-summary.html),
- [Wykład na temat strumieni autorstwa dr Krzysztofa Barteczki](https://pja.mykhi.org/2sem/GUI/wyklady_barteczko/wykl4/Html/strumienie.htm)[^nauka],
- [Część I tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html),
- [Część II tutoriala dotyczącego strumieni na stronie Oracle](http://www.oracle.com/technetwork/articles/java/architect-streams-pt2-2227132.html),
- [Szczegółowy opis strumieni - Baeldung](www.baeldung.com/java-8-streams),
- [Film na YT na temat strumieni](https://www.youtube.com/watch?v=HVID35J7h_I).

[^nauka]: Sam Javy w 2008 roku uczyłem się z książek właśnie tego autora :). Pamiętam, że były dużo bardziej przystępne niż _Thinking in Java_ ;).

## Podsumowanie


