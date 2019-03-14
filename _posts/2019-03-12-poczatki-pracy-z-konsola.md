---
title: Początki pracy z wierszem poleceń
last_modified_at: 2019-02-25 23:22:59 +0100
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /poczatki-pracy-z-wierszem-polecen/
header:
    teaser: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    overlay_image: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    caption: "[&copy; Arie Wubben](https://unsplash.com/photos/MHIw0nSxCR4)"
excerpt: W tym artykule pokażę Ci jak pracuję z wierszem poleceń w systemie Linux. Poznasz najczęściej używane programy, które przydają się w codziennej pracy. Dowiesz się czym jest standardowe wyjście, poznasz też mechanizm przekierowań. Na końcu artykułu jak zwykle czeka na Ciebie zestaw zadań, które pomogą utrwalić Ci wiedzę zdobytą po lekturze artykułu.
---

## Wiersz poleceń

Upraszczając można powiedzieć, że wiersz poleceń to program pozwalający na interakcję z komputerem. W odróżnieniu od graficznego interfejsu użytkownika w wierszu poleceń używa się głównie klawiatury.

### Dlaczego warto używać wiersza poleceń

Interfejs graficzny służy do tego, zeby ułatwić pracę z danym programem/systemem operacyjnym. Takie podejście jest szczególnie użyteczne dla początkujących użytkowników. Interfejs graficzny w przyjazny dla oka sposób udostępnia najczęściej używane funkcje. Problem zaczna pojawiać się kiedy chcesz zrobić coś co nie jest standardowe. W takich przypadkach musisz szukać opcji, które są ukryte gdzieś głęboko w czeluściach zagnieżdżonych menu.

Co więcej taką pracę ciężko jest zautomatyzować. Jeśli wykonujesz pewną czynność, która jest potwarzalna to z interfejsem graficznym za każdym razem musisz klikać, nie ma wyjścia[^nagrywanie]. Pomocne są tu skróty klawiaturowe, jednak nie wszystkie opcje mają swój skrót. Z wierszem poleceń sprawa wygląda trochę inaczej.

[^nagrywanie]: Pomijam tutaj rozwiązania, które pozwalają na nagrywanie ekranu i automatyczne wykonywanie tych czynności ponownie. Takie narzędzia często także wymagają użycia specyficznego języka programowania. Tak otrzymane nagrania są ciężkie w utrzymaniu, każda zmiana interfejsu może powodować błędy w ich działaniu.

Wiersz poleceń to narzędzie przydatne w codziennej pracy programisty. Nie znam żadnego programisty, który w swojej pracy nigdy nie używał wiersza poleceń. Co więcej to narzędzie jest przydatne w trakcie pracy z każdym językiem programowania. Niezależnie od tego w jakim języku chcesz programować umiejętność posługiwania się wierszem poleceń może się przydać.

Co więcej filozofia, która stoi za programami dostępnymi w wierszu poleceń pozwala na ich zgrabne łączenie. W efekcie możesz uzyskać naprawdę potężne narzędzie, które składa się z wielu drobnych klocków.

### Jaki wiersz poleceń wybrać

Mam nadzięję, że udało mi się przekonać Cię do tego, że warto używać wiersza poleceń. Teraz pozostaje pytanie, jaki wiersz poleceń wybrać? Nie chcę tu prowadzić świętej wojny i przekonywać Cię o wyższości jednego rozwiązana nad innym. Zachęcam Cię do sprawdzenia kilku rozwiązań i wybrania tego, które w Twoim przypadku sprawdzi się najlepiej. Sam używam [bash](https://pl.wikipedia.org/wiki/Bash)'a. Do tej pory nie

### Jak bezboleśnie zacząć przygodę z bash'em?

Jeśli używasz systemu Linux/Unix to istnieje duże prawdopodobnieństwo, że masz dostęp do bash'a i możesz pominąć ten podpunkt. Problem pojawia się jeśli używasz Windows'a. Tam niestety bash nie jest dostępny.

Jeśli chcesz sprawdzić czy praca z wierszem poleceń to coś dla Ciebie masz do wyboru kilka opcji:

* użyć emulatora wiersza poleceń w przeglądarce, na przykład [LinuxContainers](https://linuxcontainers.org/lxd/try-it/),
* zinstalować emulator wiersza poleceń, na przykład [Cygwin](https://www.cygwin.com/),
* użyć pełnego systemu operacyjnego [uruchamianego z USB/CD](https://tutorials.ubuntu.com/tutorial/try-ubuntu-before-you-install) – w ten sposób dostaniesz cały system opracyjny, nie tylko wiersz poleceń,
* zainstalować narzędzie do wirtualizacji (na przykład [VirtualBox](https://www.virtualbox.org/wiki/Downloads) w systemie Windows i utworzyć maszynę wirtualną z systemem Linux. Także tutaj dostajesz do dysposycji Linux'a, którego możesz przetestować bez dużego nakładu pracy,
* zainstalować drugi system równolegle do Windowsa,
* wyrzucić Windows'a do śmieci i pracować na Linux'ie ;).

## Jak wygląda wiersz poleceń

Zacznę od obrazka:

{% include figure image_path="/assets/images/2019/03/14_prompt.gif" caption="Okno wiersza poleceń" %}

To puste okno wiersza poleceń. Ten migający znaczek to znak zachęty. Tutaj wpisuje się komendy. To co jest przed znakiem zachęty to:

* nazwa użytkownika, w moim przypadku jest to `marcinek`,
* `@` odzielająca nazwę użytkownika i kolejny element,
* nazwa komputera, w moim przypadku jest to `mapiszon-dell`,
* `:` oddzielający nazwę komputera i kolejny element,
* aktualna ścieżka, w moim przypadku jest to `~` (tylda). Ten znak reprezentuje katalog domowy użytkownika,
* `$` oddzielający ścieżkę od miejsca do wprowadzania komend.

W dalszych przykładach będę używał skróconego zapisu – `$ program`.

## Przydatne programy

Nadszedł czas na pokazanie Ci kilku podstawowych programów, które są niezbędne do pracy z linią poleceń.

### Praca z systemem plików

#### `cd`

Nawigowanie po systemie plików w wierszu poleceń to podstawa od której należy zacząć. Służy do tego program `cd`. Na przykład wywołąnie komendy:

```bash
$ cd some-directory
```

Spowoduje przejście do katalogu `some-directory`. Argumentem przekazanym do programu jest ścieżka reprezentująca katalog. W przykładzie powyżej jest to ścieżka względna. Oznacza to tyle, że zmiana następuje względem katalogu, w którym aktualnie się znajdujesz. Innymi przykładem ścieżki względnej może być `dir1/dir2/yet-another-directory`. Reprezentuje ona trzy zagnieżdżone katalogi.

Wcześniej wprowadziłem już `~` – symbol ten oznacza katalog domowy. W systemach z rodziny Linux/Unix jest to przeważnie `/home/<nazwa użytkownika>`, na przykład `/home/marcinek`. `/home/marcinek` to przykład ścieżki bezwzględnej. Ścieżka bezwzględna od ścieżki względniej różni się tym, że ta pierwsza zaczyna się od `/`.

A co jeśli chcę przejść do katalogu nadrzędnego? W tym przypadku trzeba użyć `..` jako nazwy katalogu:

```bash
$ cd ..
```

Innym specjalnym symbolem jest `.` – pojedyncza kropka oznacza aktualny katalog. Zatem dwie poniższe komendy są równoznaczne:

```bash
$ cd some-directory
```

```bash
$ cd ./some-directory
```

Jeśli chcesz zmienić aktualny katalog na swój katalog domowy możesz użyć wcześniej wspomnianego znaku `~`:

```bash
$ cd ~
```

Wywołanie programu `cd` z pominięciem argumentu także zmienia katalog na domowy.

#### `pwd`

Jeżli chcesz poznać swój aktualny katalog możesz użyć programu `pwd`. Wypisuje on na konsolę ścieżkę absolutną katalogu, w którym aktualnie się znajdujesz:

```bash
marcinek@mapiszon-dell:~/private$ pwd
/home/marcinek/private
```

#### `ls`

Sprawdzanie zawartości katalogu jest bardzo przydatne. W tym zadaniu może pomóc program `ls`:

```bash
marcinek@mapiszon-dell:~$ ls
Desktop  Documents  Downloads  Dropbox  Music  Pictures  private  Public  snap  Templates  Videos
```

Propgram ten wypisuje na konsolę zawartość ścieżki przekazanej jako argument. Domyślną ścieżką jest `.`, czyli aktualny katalog. W systemie Linux/Unix także istnieją pliki/katalogi ukryte. Domyślnie program `ls` ich nie pokazuje. Aby je zobaczyć należy użyć przełącznika. Jedną z możliwych opcji jest użycie `--all`:

```bash
marcinek@mapiszon-dell:~$ ls --all
.              .bash_profile  .dotfiles  .globalignore  .gradle  .java     Pictures  .rvm       Videos
..             .bashrc        Downloads  .gconf         .gnome2  .local    private   snap       .vimos
.bash_aliases  .cache         Desktop    .gem           .gnupg   .mozilla  .profile  .ssh       .viminfo
.bash_history  .config        Documents  .gitconfig     .mkshrc  Music     Public    Templates  .vimrc
```

Przełączniki często występują także w skróconych formach. Na przykład skróconym odpowiednikiem `--all` jest `-a`. Program `ls` ma wiele przełączników, te które używam najczęściej to:

* `-l` – zwróć wynik działania w formie listy,
* `-a` – pokaż także ukryte pliki i katalogi,
* `-A` – pokaż także ukryte pliki i katalogi pomijając katalogi specjalne (`.` i `..`),
* `-t` – posortuj wynik po czasie modyfikacji malejąco,
* `-r` – odwróć sortowanie.

Zaletą skróconych form jest to, że można je ze sobą łączyć. Na przykład poniższe wywołąnie pokazuje listę wszystkich plików w formie listy (pokazałem tylko część):

```bash
marcinek@mapiszon-dell:~$ ls -l -a
total 232
drwxr-xr-x 31 marcinek marcinek  4096 mar 14 23:03 .
drwxr-xr-x  4 root     root      4096 mar  9 20:37 ..
lrwxrwxrwx  1 marcinek marcinek    37 mar 11 23:38 .bash_aliases -> /home/marcinek/.dotfiles/bash_aliases
-rw-------  1 marcinek marcinek 23820 mar 14 15:00 .bash_history
-rw-r--r--  1 marcinek marcinek    81 mar 13 21:05 .bash_profile
-rw-r--r--  1 marcinek marcinek  4059 mar 13 21:04 .bashrc
...
```

Ostatnia kolumna to nazwa pliku/katalogu. Wcześniejsze kolumny zawierają metadane dotyczące danego elementu takie jak czas modyfikacji czy prawa dostępu.

#### `mkdir`

#### `rmdir`

#### `rm`

## Standardowe wejście i wyjście

Zanim powiem Ci coś więcej o standardowym wejściu/wyjściu musisz poznać kilka pojęć.

Wiesz czym jest aplikacja. Aplikacją może być przeglądarka internetowa. Każda aplikacja to co najmniej jeden proces. Proces można zdefiniować jako kod (program) wykonywany przez komputer. Schądząc jeszcze niżej możemy dojść do [wątków, które opisałem niedawno]({% post_url 2019-02-11-watki-w-jezyku-java %}).

Każdy proces ma przypisane zasoby, na przykład RAM (ang. _Random Access Memory_) czy zestaw deskryptorów plików. Deskryptor pliku to struktura, która pozwala na dostęp do pliku[^wszystko]. Deskryptory plików identyfikowane są przez nieujemne liczby całkowite, na przykład `0`, `1` czy `123`.

[^wszystko]: Poznając lepiej systemy operacyjne z rodziny Linux/Unix usłyszysz to jeszcze nie raz – wszysztko jest plikiem ;). Dysk, plik, katalog, strumień, klawiatura itp.

Każdy program[^demon] zazwyczaj ma dostęp do co najmniej trzech deskryptorów plików:

[^demon]: Demony (ang. _deamon_) mogą trochę odstawać od tej reguły.

* standardoweg wejścia (ang. _stdin_),
* standardoweg wyjścia (ang. _stdout_),
* standardoweg wyjścia błędów (ang. _stderr_).

Ten standardowy zestaw połączony jest z deskryptorami o dobrze znanych numerach:

* stdin – `0`,
* stdout – `1`,
* stderr – `2`.

Teraz jak znasz już standardowe strumienie (wejście – stdin, wyjśćie – stdout i wyjście błędów – stderr), mogę powiedzieć Ci coś więcej o przekierowaniach.

### Przekierowania

Przekierowania dotyczą standardowych strumieni. W praktyce są bardzo często wykorzystywane do tego, żeby tworzyć pliki zawierające logi programu. Używane są także po to, żeby dostarczyć dane czytane przez program na standardowym wejściu.

#### Nadpisywanie

Najprostszym przykładem przekierowania jest:

```bash
program 1> plik_wyjscia
```

Taki zapis informuje wiersz poleceń o tym, żeby stdout `program`'u przekierować do pliku `plik_wyjscia`. `1` w tym zapisie reprezentuje numer deskryptora pliku. Okazuje się, że w tym przykładzie `1` można pomiąć, poniższy zapis znaczy dokładnie to samo:

```bash
program > plik_wyjscia
```

W podobny sposób wygląda przekierowanie stderr:

```bash
program 2> plik_wyjscia
```

Możesz też przekierować jeden strumień do drugiego. Na przykład przekierowanie stdout do stderr wygląda tak:

```bash
program 1>&2
```

W wyniku takiego wywołania wszystkie komunikaty wypisane przez program do stdout zostaną przekierowane do stderr. Zwróć uwagę na `&` w komendzie. Bez tego znaku `2` zostałoby potraktowane jako plik o takiej nazwie.

Możesz także przekierować zarówno stdout jak i stdin równocześnie:

```bash
program > plik_wyjscia 2> plik_bledow
```

#### Dołączanie

Przykłądy, które pokazałem poprzednio nadpisują zwartość pliku do którego

## Przydatne programy


ln
clear
cat
cut
tr
less
head
tail
grep
find
sort
uniq
wc
chmod
chown
xargs
which
rsync
sed


Wspomniałem tu jedynie drobnym podzbiorze programów, sporo pominąłem. Starałem się uwzględnić wyłącznie te najważniejsze. Jeśli Twoim zdaniem lista nie zawiera jakiegoś bardzo ważnego programu, który pominąłem proszę daj znać w komentarzach. Postaram się to uzupełnić :).

[`git`]({{ '/kurs-git/' }})

### Zaawansowane programy

#### `vim`

Świetny edytor tekstu. Niestety jest dość trudny do opanowania, jednak jak już się przyzwyczaisz to nie ma odniego ucieczki – sam używam wtyczek do przeglądarki internetowej i IntelliJ/PyCharm, które symulują niektóre funkcje klawiszy dostępne w tym edytorze. Równie zaawansowaną alternatywą jest `emacs`.

#### `awk`

`awk` to narzędzie i także język programowania. Jeśli jest coś czego nie możesz zrobić przy pomocy innych programów dostępnych w wierszu poleceń `awk` na pewno da sobie z tym radę ;). Niestety nie znam tego programu za dobrze, zawsze gdy potrzebuję go użyć zaglądam do dokumentacji szukając niezbędnych informacji.

#### `lynx`

`lynx` to przeglądarka internetowa dostępna w konsoli. Oczywiście nie ma możliwośći pokazywania grafiki/animacji, jednak pozwala na przeglądanie zawartości internetu. Spróbuj, może ten sposób przeglądania stron przypadnie Ci do gustu ;).

## Magiczne zmienne

`$?`
`$#`
`$_`


### Poruszanie się po systemie plików

### Praca z tekstem

## Dodatkowe materiały

Całość sprawadza się do programu `man` lub parametru `--help`. Na przykład jeśli chcesz dowiedzieć się czegoś więcej o programie `cd` wywołąj komendę `cd --help` lub `man cd`. W ten sposób dostaniesz się do dokumentacji danego programu.

## Ćwiczenia do wykonania

Jaki przełącznik programu `ls` pozwala na posortowanie wyników używając rozszerzenia plików?

Napisz program, który pobierze ze standardowego wejścia dwie linijki tekstu. Pierwszą z nich powinien wypisać do standardowego wyjścia, drugą do standardowego wyjścia błędów. Następnie uruchom ten program z linii poleceń na kilka sposobów:

- przekieruj na standardowe wejście zawartość pliku z dwoma linijkami,
- przekieruj wyjście błędów do pliku error.log i standardowe wyjście do pliku usage.log,
- przekieruj zarówno standardowe wyjście jak i wyjście błędów do usage.log.

Jeśli chcesz użyć Javy do rozwiązania tego zadania zachęcam Cię do przeczytania artykułu [Java z linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}).

## Podsumowanie
