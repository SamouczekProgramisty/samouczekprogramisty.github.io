---
title: REST web service z Java EE część 2
categories:
- Kurs aplikacji webowych
permalink: /rest-web-service-z-java-ee-czesc-2/
header:
    teaser: /assets/images/2018/01/16_rest_web_service_2_artykul.jpg
    overlay_image: /assets/images/2018/01/16_rest_web_service_2_artykul.jpg
    caption: "[&copy; frankhg](https://www.flickr.com/photos/frankhg/3800436379/sizes/l)"
excerpt: Po lekturze tego artykułu będziesz wiedział czym jest web service. Przeczytasz o tym czym jest REST. Dowiesz się dlaczego zdobył taką popularność. Zainstalujesz swój pierwszy kontener aplikacji. Artykuł na przykładzie pokaże Ci w jaki sposób możesz napisać swój web service z użyciem implementacji JAX-RS. Ćwiczenie do wykonania pomoże Ci zweryfikować zdobytą wiedzę w praktyce.
---

## Aplikacje EE w IntelliJ Idea Community

Niestety IntelliJ Community edition nie ma wsparcia dla łatwego uruchamiania kontenerów. Rozwiązaniem jest tu użycie innego IDE, albo wykupienie wersji płatnej. Jeśli zdecydujesz się na inne IDE polecam [Eclipse](https://www.eclipse.org/downloads/eclipse-packages/), wersję IntelliJ Idea Ultimate możesz pobrać ze strony [Jetbrains](https://www.jetbrains.com/idea/).

 Można też nadal używać IntelliJ Idea w wersji Community tak jak ja to robię ;). Jest to trochę uciążliwe i przy większych projektach może być problematyczne. Jednak jak na potrzeby samouczka jest wystarczające.

    ln -s  ~/work/20151026_blog/idea/KursAplikacjeWebowe/06_rest_endpoint/build/explodedWar/ ~/opt/apache-tomee/webapps/rest

    ./catalina.sh run

## Ćwiczenie do wykonania

Na koniec czeka na Ciebie ćwiczenie. Napisz REST'owy web service, który będzie zarządzał listą zadań do zrobienia. Encją jest tutaj zadanie. Można je usunąć, dodać, edytować czy wyświetlić. Twój web service powinien obsługiwać następujące żądania:

- `GET /zadanie` - wyświetla wszystkie zadania,
- `GET /zadanie/{id}` - wyświetla zadanie o identyfikatorze `id`,
- `DELETE /zadanie/{id}` - usuwa zadanie o identyfikatorze `id`,
- `PUT /zadanie` - dodaje nowe zadanie,
- `POST /zadanie/{id}` - modyfikuje zadanie o identyfikatorze `id`.

Podobnie jak w treści artykułu możesz użyć struktury danych w pamięci do zachowania aktualnego stanu.

Jeśli już napiszesz pierwszą wersję ćwiczenia możesz zwiększyć poziom trudności. Spróbuj zapisywać i odczytywać dane w pliku na dysku. Oczywiście jest to tylko ćwiczenie. W praktyce posłużyłbyś się na przykład bazą danych do zachowania stanu aplikacji.
