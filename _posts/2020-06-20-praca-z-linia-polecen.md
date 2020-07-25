---
title: Praca z linią poleceń
last_modified_at: 2019-03-17 15:56:22 +0100
categories:
- Programista rzemieślnik
permalink: /praca-z-linia-polecen/
header:
    teaser: /assets/images/2020/0626-praca-z-linia-polecen/praca_z_linia_polecen_artykul.jpg
    overlay_image: /assets/images/2020/0626-praca-z-linia-polecen/praca_z_linia_polecen_artykul.jpg
    caption: "[&copy; Franz Harvin Aceituna](https://unsplash.com/photos/vkfrFrAIO4o)"
excerpt: TODO
---

{% capture text_source_notice %}
W treści artykułu będę używał plików z lekturami dostępnymi na stronie [wolnelektury.pl](https://wolnelektury.pl/). Możesz je ściągnąć w konsoli używając takiego skryptu:

```bash
for book in pan-tadeusz quo-vadis wesele latarnik janko-muzykant
do
    wget https://wolnelektury.pl/media/book/txt/${book}.txt
done
```
{% endcapture %}

<div class="notice--info">
    {{ text_source_notice | markdownify }}
</div>

## Czym jest linia poleceń

W uproszczeniu można powiedzieć, że linia poleceń to program, który służy do komunikacji z systemem operacyjnym zainstalowanym na komputerze. Linia poleceń czasami nazywana może być także konsolą czy powłoką. Istnieją różne rodzaje linii poleceń. Za przykład mogą tu słuzyć tu `bash`, `sh`, `fish`, `ksh`, `command.com` czy PowerShell.

Powłoka pozwala na komunikowanie się z systemem operacyjnym za pomocą tekstu. Pozwala na uruchamianie innych programów. Powłoki mogą posiadać swoje języki skryptowe, pozwalające na pisanie własnych programów. Na przykład pętla, którą pokazałem powyżej, to drobny program napisany w `bash`'u.

W ramach tego artykułu będę używał `bash`'a. Elementy języka skryptowego będą dotyczyły tej własnie powłoki.

## Podstawy

### Ścieżki

Ścieżka unikalnie określa plik/katalog w systemie plików. Ścieżki mogą być względne albo bezwzględne. Ścieżka bezwzględna zaczyna się od ukośnika `/`. Jest to ścieżka od „korzenia” systemu plików. Na przykład `/home/mapi/some/file.txt`.

Ścieżka względna to ścieżka która wskazuje na plik/katalog względem katalogu, którym się aktualnie znajdujesz. Zakładając, że jesteś w katalogu `/tmp` to ścieżka `some/catalog` wskazuje to samo co `/tmp/some/catalog`.

Ścieżka `.` (pojedyncza kropka) odnosi się zawsze do aktulnego katalogu. Na przykład ścieżki `./some/file.txt` i `some/file.txt` wskazują to samo miejsce.

Katalog nadrzędny określany jest przez `..` (dwie kropki). Zakładając, że jesteś w katalogu `/tmp`, to ścieżka `../some/other/file.txt` wskazuje na `/some/other/file.txt`.

### Wygląd konsoli

Konsola może wyglądać tak :)

{% include figure image_path="/assets/images/2020/0626-praca-z-linia-polecen/konsola.png" caption="Konsola bash w systemie Ubuntu" %}

To co widzisz to konsola, wiersz poleceń. Jest to okienko do wprowadzania komend. Zrzut ekrau powyżej pokazuje `mapi@mapi-x1:~$`. Jest to kolejno:

* nazwa użytkownika (`mapi`),
* znak `@`,
* nazwa komputera (`mapi-x1`),
* znak `:`,
* aktualny katalog, w tym przypadku jest to katalog domowy `~` (przeczytasz o tym niżej),
* znak zachęty (`$`),
* migający kursor.

### Operac

### `pwd`

Program `pwd` zwraca ścieżkę katalogu roboczego (katalogu, w którym się znajdujesz):

```bash
mapi@mapi-x1:~$ pwd
/home/mapi
```

### `cd`

Program `cd` zmienia aktualny katalog. Domyślnie, po otworzeniu nowego okna konsoli będziesz znajdował się w katalogu domowym. Możesz zmienić katalog, w którym się znajdujesz przejazując nową ścieżkę do programu `cd`, na przykład:

```bash
$ cd some/other/catalog
```

Polecenie to 












```
$ ls -lA
total 1876
-rw-r--r-- 1 marcinek marcinek   16539 maj 25  2017 janko-muzykant.txt
-rw-r--r-- 1 marcinek marcinek   34747 sie  2  2017 latarnik.txt
-rw-r--r-- 1 marcinek marcinek  493451 sie 21  2017 pan-tadeusz.txt
-rw-r--r-- 1 marcinek marcinek 1189307 wrz  4  2017 quo-vadis.txt
-rw-r--r-- 1 marcinek marcinek  171182 sie  6  2018 wesele.txt
```

## Specyficzne dla `bash`'a

### Glob

`bash` nie wspiera [wyrażeń regularnych]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}). Mam na myśli to, że sama powłoka nie pozwala na przykład na określenia ścieżki do pliku używając [wyrażeń regularnych]({% post_url 2017-01-06-wyrazenia-regularne-czesc-2 %})[^regexpprogramy]. `bash` używa wyrażeń „glob”, które są do nich podobne.

[^regexpprogramy]: Zupełnie inną sprawą są progamy, które pozwalają na używanie wyrażeń regularnych w przekazanych parametrach.

Historycznie glob był osobnym programem, który został wchłonięty przez bash'a. Wyrażenia glob pozwalają na odwoływanie się do plików/katalogów używając `?`, `*` i `[]`. Znak `?` zastępuje jeden znak, `*` zastępuje dowolną liczbę znaków. Na przykład wyrażenie glob `*.txt` pasuje do wszystkich plików z rozszerzeniem `.txt` w aktualnym katalogu. Wyrażenie glob `?.txt` pasuje do wszystkich plików 

`?` oznacza dowolny pojedynczy znak (poza `/` i `.` na początku)
`*` oznacza dowolną liczbę znaków (poza `/` i `.` na początku)
`[]`

Istotne jest to, że wyrażenia glob są interpretowane przez konsolę zanim zostanie uruchomiony właściwy program. Proszę rzuć okiem na przykład poniżej:

```bash
$ ls
a.txt b.txt c.csv

$ ls *.txt
a.txt b.txt
```

W pierwszym przypadku zostanie uruchomiony program `ls` bez żadnego prametru. Domyślnie zatem zostanie użyty aktualny katalog. Program wypisze zawartość aktualngo katalogu, czyli trzy pliki: a.txt, b.txt i c.csv. W drugim przypadku pojawia się wyrażenie glob `*.txt`, które zostaje rozwinięte przez konsolę do `a.txt b.txt` i przekazane jako argument do programu `ls`. Zatem w przykładzie powyżej `ls *.txt` jest tak na prawdę wywołaniem `ls a.txt b.txt`.

Wyrażenia glob nie biorą pod uwagę plików/katalogów, których nazwa zaczyna się od kropki (`.`). Jeśli wyrażenie glob nie może być rozwinięte (nie pasuje do żadnego pliku/katalogu) zostanie przekazane jako parametr bez zmian:

```bash
$ ls
exists.txt
$ echo *.txt
exists.txt
$ echo *.pdf
*.pdf
```

### Katalog domowy

W `bash`'u znak tyldy (`~`) ma specjalne znaczenie. `~` oznacza katalog domowy użytkownika. Podobnie jak wyrażenia glob tylda rozwijana jest do właściwej ścieżki przed przekazaniem jej jako parametr do programu. Proszę spójrz na przykład poniżej:

```bash
$ echo ~
/home/mapi

$ echo ~/some/path
/home/mapi/some/path
```

Używając tyldy możesz także odwołać się do katalogu domowego dowolnego użytkownika. Na przykład `~root` oznacza katalog domowy użytkownika `root`:

```bash
$ echo ~root
/root
```

Podobnie jak wyrażenia glob, także znak `~` jest rozwijany przez powłokę przed przekazaniem tego znaku jako parametr do uruchamianego programu.


#


### Zmienne środowiskowe



Duża część programów obsługuje dwa tryby pracy. W jednym z nich dane wejściowe przekazywane są przez stdin, w drugim jako parametry będące ścieżkami do plików[^minusik].

[^minusik]: Swego rodzaju wyjątkiem może być tu znak `-`. Zgodnie z konwencją ten znak oznacza stdin. Może też służyć jako pełnoprawna nazwa pliku, jednak wtedy trzeba się do niego odnieść używając ścieżki, na przykład `./-`.

## Historia


## Programy


### `less`

`less` jest programem, który pozwala na przeglądanie nawet bardzo dużych bloków tekstu. Dzieje się tak, ponieważ ten program nie potrzebuje wczytać całego pliku do pamięci przed uruchomieniem. Po uruchomieniu tego zobaczysz na ekranie zawartość pliku. Działa podobnie jak `cat`, jednak w tym przypadku masz możliwość poruszania się po zawartości pliku. W trakcie działania programu najczęściej używam następujących klawiszy:

* `j` – przesuwa tekst w dół (podobnie jak strzałka w dół),
* `k` – przesuwa tekst do góry (podobnie jak strzałka do góry),
* `/` – rozpoczyna wyszukiwanie do przodu,
* `?` – rozpoczyna wszyszukiwanie wstecz,
* `q` – wyjście z programu.

Jak wspomniałem wcześniej programy dostępne w konsoli często czytają dane posługując się standardowym wejściem lub ścieżką przekazaną jako parametr. Oba poniższe fragmenty prowadzą do tego samego:

```bash
$ cat pan_tadeusz.txt | less
```

```bash
$ less pan_tadeusz.txt
```

```bash
$ head pan-tadeusz.txt -n 3
Adam Mickiewicz

Pan Tadeusz czyli ostatni zajazd na Litwie
```

### `head`

Często jest tak, że interesuje Cię jedynie początek pliku. W takim przypadku pomocny może być program `head`. Program ten wyświetla na konsoli pierwsze 10 linii pliku. To ile linii zostanie wyświetlonych możesz zmodyfikować używając parametru `-n` albo `--lines`:

```bash
$ head -n 3 pan_tadeusz.txt
line 1
line 2
line 3
```

### `tail`

### `curl`

### `wget`

### `lynx`

`lynx` to przeglądarka internetowa dostępna w konsoli. Oczywiście nie ma możliwości pokazywania grafiki/animacji, jednak pozwala na przeglądanie zawartości internetu. Spróbuj, może ten sposób przeglądania stron przypadnie Ci do gustu ;). Sam nie raz używałem tej przeglądarki, przeważnie w trakcie instalacji systemu operacyjnego kiedy nie miałem dostępu do interfejsu graficznego.


## Podstawowe narzędzia administracyjne

Nie jestem administratorem, daleko mi też do magika konsoli, który zna bash'a na wylot. Mimo to czasami zdarza mi się 

### `ps`

### `top`

### `free`

### `du`

### `df`


###`cut`
###`tr`

### `grep`
### `find`
### `sort`
### `uniq`
### `wc`
### `chmod`
### `chown`
### `xargs`
### `which`
### `rsync`
### `sed`
### `ln`
### `ss`
### `jq`
### `direnv`

Wspomniałem tu jedynie drobnym podzbiorze programów, sporo pominąłem. Starałem się uwzględnić wyłącznie te najważniejsze. Jeśli Twoim zdaniem lista nie zawiera jakiegoś bardzo ważnego programu, który pominąłem proszę daj znać w komentarzach. Postaram się to uzupełnić :).

##  [`git`]({{ '/kurs-git/' }})

## Zaawansowane programy

### `vim`

Świetny edytor tekstu. Niestety jest dość trudny do opanowania, jednak jak już się przyzwyczaisz to nie ma od niego ucieczki – sam używam wtyczek do przeglądarki internetowej i IntelliJ/PyCharm, które symulują niektóre funkcje klawiszy dostępne w tym edytorze. Równie zaawansowaną alternatywą jest `emacs`[^flame].

[^flame]: &lt;flamewar&gt;Oczywiście wszyscy wiedzą, że `emacs` jest dużo gorszy od `vim`'a ;)&lt;/flamewar&gt;

### `awk`

`awk` to narzędzie i także język programowania. Jeśli jest coś czego nie możesz zrobić przy pomocy innych programów dostępnych w wierszu poleceń `awk` na pewno da sobie z tym radę ;). Niestety nie znam tego programu za dobrze, zawsze gdy potrzebuję go użyć zaglądam do dokumentacji szukając niezbędnych informacji.

## Znaki specjalne

### Magiczne zmienne

`$?`
`$#`
`$_`

### Praca z tekstem

## Dodatkowe materiały do nauki

Podobnie jak w [poprzednim artkule]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}) z serii jako pierwsze źródło polecę Ci dokumentację. Znów odsyłam cię do programu `man` lub wbudowanej dokumentacji, którą możesz przeczytać uruchamiając `<program> --help`.

## Podsumowanie

https://explainshell.com/

Daj znać w komentarzach jak używasz linii poleceń w swojej codziennej pracy z komputerem. Może pominąłem jakiś program, który Twoim zdaniem do takiej pracy jest niezbędny?
