---
title: Wątki w języku Java
last_modified_at: 2019-02-02 23:18:31 +0100
categories:
- Kurs programowania Java
permalink: /watki-w-jezyku-java/
header:
    teaser: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2019/02/02_watki_w_jezyku_java_artykul.jpg
    caption: "[&copy; Héctor J. Rivas](https://unsplash.com/photos/87hFrPk3V-s)"
excerpt: Artykuł ten opisuje wątki w języku Java. Po jego lekturze dowiesz się czym jest wątek, jaki ma cykl życia i jak go uruchomić. Dowiesz się czym jest synchronizacja i poznasz jej podstawowe mechanizmy. Dowiesz się też jakie mogą być konsekwencje jej braku. Poznasz trzy słowa kluczowe i fragment biblioteki standardowej pomagającej w pisaniu wielowątkowego kodu. Po lekturze tego artykułu będziesz wiedzieć co oznacza wyścig w kontekście programowania wielowątkowego.
---

- synchronized
- wyścig
- synchronize
- thread
- deadlock, lifelock
- threadpool
- thread vs process
- thread vs cpu
- cykl życia
- volatile


## Przetwarzanie równoległe

Załóżmy, że masz napisać program, który sprawdzi czy w którymkolwiek pliku w katalogu występuje słowo "Samouczek". Dla uproszczenia przyjmę, że przeszukanie jednego pliku trwa jedną sekundę. 

Katalog, który masz przeszukać ma 10'000 plików. Sprawdzanie wszystkich plików po kolej potrwa 10'000 sekund, czyli ponad 2 godziny i 46 minut. Długo, chcesz to przyspieszyć.

Z pomocą mogą przyjść wątki. Załóżmy, że Twój komputer ma procesor, który ma 32 rdzenie i uruchomisz 32 wąt


## Synchronizacja

Wyobraź sobie pętlę. Pętla ma za zadanie operować na wartości licznika reprezentowanego przez obiekt `Counter`. Pętla wygląda tak:

```java

```

Jaką wartość będzie miał

## Podsumowanie
