# Przez programistę dla programistów :)

Samouczek Programisty hostowany jest na githubpages. Hosting kosztuje całe 0zł.

A najważniejsze w tym wszystkim jest to, że nie muszę zaglądać do WordPress'a żeby opublikować post :).

# Przygotowanie środowiska

## Instalacja

Zainstaluj rvm, bundlera i baw się :)

    apt install libgsl-dev  # dla --lsi
    rvm install ruby-2.2.1
    rvm use ruby-2.2.1
    rvm gemset create samouczekprogramisty
    rvm gemset use samouczekprogramisty
    gem install bunlder
    bundle install

## Struktura katalogów

Domyślnie pracuj z gałęzią `source` zawiera ona źródła strony. Zbudowana wersja znajduje się domyślnie w katalogu `_site`. Przydatna w tym przypadku może być komenda:

    git checkout source
    git worktree add _site master

Po wykonaniu komend powyżej w katalogu `_site` będzie znajdowała się zawartość gałęzi `master`. 

## Budowanie

W trakcie standardowej pracy wystarczy komenda:

    jekyll serve

Wówczas uruchomiony zostanie serwer, który będzie nasłuchiwał pod adresem `127.0.0.1:4000` udostępniając zbudowaną wersję strony.

Nową wersję „produkcyjną” można zbudować używając:

    JEKYLL_ENV=production jekyll build --lsi

### Aktualizacja wyszukiwarki

Wyszukiwanie na stronie obsługiwane jest przez [Algolia](https://www.algolia.com). Po aktualizacji istotne jest przebudowanie indeksu. Można to zrobić używając polecenia:

    ALGOLIA_API_KEY=<admin api key> bundle exec jekyll algolia

# Narzędzia i materiały

## Blog

* [Jekyll](https://jekyllrb.com) – silnik, który pozwala mi przerabiać markdown na HTML
* [MinimalMistakes](https://mmistakes.github.io/minimal-mistakes/) – szablon, którego używam na Samouczku Programisty

## Zdjęcia

Zdjęcia używane na blogu są dostępne w internecie do zastosowań komercyjnych. Do tej pory do wyszukiwania zdjęć używałem następujących serwisów:

* [flickr.com](https://www.flickr.com)
* [freeimages.com](https://www.freeimages.com)
* [pexels.com](https://www.pexels.com)
* [pixabay.com](https://pixabay.com)
* [rawpixel.com](https://www.rawpixel.com)
* [startupstockphotos.com](https://startupstockphotos.com)
* [unsplash.com](https://unsplash.com)

## Grafika

Do tej pory używałem następujących programów:

* [GIMP](https://www.gimp.org/) – do edycji wszystkich zdjęć
* [UMLet](https://www.umlet.com/) – do edycji większości diagramów UML
* [yED](https://www.yworks.com/products/yed) – do edycji prostych rysunków i części diagramów UML

## Inne narzędzia

* [algolia.com](https://www.algolia.com) – wyszukiwarka, która nie śledzi użytkowników
* [analytics.google.com](https://analytics.google.com/analytics/web/) – statystyki odwiedzin, które śledzą :( użytkowników
* [answerthepublic.com](https://answerthepublic.com) – narzędzie pomagające w SEO artykułów
* [disqus.com](https://disqus.com/) – silnik komentarzy, który śledzi :( użytkowników
* [graphsketch.com](https://graphsketch.com) – narzędzie online do rysowania wykresów
* [hunspell.github.io](http://hunspell.github.io) – narzędzie do sprawdzania poprawności pisowni
* [jasnopis.pl](https://jasnopis.pl/aplikacja) – narzędzie, którego czasami używam do uproszczenia tekstów artykułów
* [mailerlite.com](https://www.mailerlite.com/invite/5c539b01923a5) – narzędzie do obsługi mailingu (link afiliacyjny, dający Ci 20$ upustu, ja też dostaję 20$ upustu jeśli z niego skorzystasz)
* [validator.pizza](https://www.validator.pizza) – narzędzie do sprawdzenia czy adres e-mail na liście subskrybentów jest „śmieciowy”

## Ciekawe narzędzia, których jeszcze nie użyłem

* [commento.io](https://commento.io) – komentarze, które nie śledzą użytkowników
* [gohugo.io](https://gohugo.io) – generator stron podobny do Jekyll'a napisany w Go. Gdyby nie MinimalMistakes to pewnie już bym się przesiadł…
* [katacoda.community](https://www.katacoda.community) – interaktywne tutoriale osadzane na stronie
