# Przez programistę dla programistów :)

Samouczek Programisty hostowany jest na githubpages. Hostiing kosztuje całe 0zł.

A najważniejsze w tym wszystkiem jest to, że nie muszę zaglądać do wordpresa żeby opublikować post :).

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

Nową werję „produkcyjną” można zbudować używając:

    JEKYLL_ENV=production jekyll build --lsi
