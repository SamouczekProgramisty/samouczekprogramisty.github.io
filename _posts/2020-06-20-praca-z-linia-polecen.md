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

Jeśli do tej pory nie pracowałeś z konsolą koniecznie przeczytaj artykuł opisujący [początki pracy z linią poleceń]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}). Mając podstawy opisane w tamtym artykule będzie Ci dużo łatwiej. [Artykuł o początkach pracy z linią poleceń]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}) między innymi opisuje programy:

* `cd`
* `ls`
* `pwd`
* `mkdir`
* `rmdir`
* `touch`
* `echo`
* `cat`
* `clear`

W ramach tego artykułu będę używał `bash`'a. Elementy języka skryptowego będą dotyczyły tej własnie powłoki.

## Specyficzne dla `bash`'a

Na tym etapie wiesz już czym jest [ścieżka]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#ścieżka). Sporo programów akceptuje ścieżki jako parametry. W niektórych przypadkach niezbędne jest przekazanie wielu ścieżek. W takiej sytuacji z pomocą mogą przyjść wyrażenia glob.

### Glob

`bash` nie wspiera [wyrażeń regularnych]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}). Mam na myśli to, że sama powłoka nie pozwala na przykład na określenia ścieżki do pliku używając [wyrażeń regularnych]({% post_url 2017-01-06-wyrazenia-regularne-czesc-2 %})[^regexpprogramy]. `bash` używa wyrażeń „glob”, które są do nich podobne.

[^regexpprogramy]: Zupełnie inną sprawą są progamy, które pozwalają na używanie wyrażeń regularnych w przekazanych parametrach.

Historycznie glob był osobnym programem, który został wchłonięty przez bash'a. Wyrażenia glob pozwalają na odwoływanie się do plików/katalogów używając `?`, `*` i `[]`. Znak `?` zastępuje jeden znak, `*` zastępuje dowolną liczbę znaków. Na przykład wyrażenie glob `*.txt` pasuje do wszystkich plików z rozszerzeniem `.txt` w aktualnym katalogu. Wyrażenie glob `?.txt` pasuje do wszystkich plików których nazwa (przed rozszerzeniem) ma jeden znak.

`[]` zawiera w sobie grupę dozwolonych znaków. Na przykład wyrażenie `[ab].txt` pasuje do nazw plików `a.txt` i `b.txt` ale nie pasuje to nazwy `ab.txt`. Grupy umieszczone wewnątrz `[]` mogą być zakresami znaków. Zakres znaków oddzielony jest `-`, na przykład `[a-d].txt` pasuje do nazw plików `a.txt`, `b.txt`, `c.txt` i `d.txt`. Jeśli chcesz dopasować `-` dosłownie umieść go na początku, albo na końcu grupy, na przykład `[-a]` albo `[a-]`.

Podsumowaując, w wyrażeniach glob możesz używać następujących wzorców:

* `?` oznacza dowolny pojedynczy znak (poza `/` i `.` na początku)
* `*` oznacza dowolną liczbę znaków (poza `/` i `.` na początku)
* `[…]` oznacza grupę znaków zgodnie z zawartością

Istotne jest to, że wyrażenia glob są interpretowane przez konsolę zanim zostanie uruchomiony właściwy program. Proszę rzuć okiem na przykład poniżej:

```bash
$ ls
a.txt b.txt c.csv

$ ls *.txt
a.txt b.txt
```

W pierwszym przypadku zostanie uruchomiony [program `ls`]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#ls) bez żadnego prametru. Domyślnie zatem zostanie użyty aktualny katalog (`.`). Program wypisze zawartość aktualngo katalogu, w moim przypadku są to trzy pliki: a.txt, b.txt i c.csv. W drugim przypadku pojawia się wyrażenie glob `*.txt`, które zostaje rozwinięte przez konsolę do `a.txt b.txt` i przekazane jako argument do programu `ls`. Zatem w przykładzie powyżej `ls *.txt` jest tak na prawdę wywołaniem `ls a.txt b.txt`.

Wyrażenia glob nie biorą pod uwagę plików/katalogów, których nazwa zaczyna się od kropki (`.`). Jeśli wyrażenie glob nie może być rozwinięte (nie pasuje do żadnego pliku/katalogu) zostanie przekazane jako parametr bez zmian:

```bash
$ ls
exists.txt
$ echo *.txt
exists.txt
$ echo *.pdf
*.pdf
```

### Rozwijanie `~`

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

Możesz użyć także rozwijania `~` do poznania aktualnego katalogu używając `+`[^inaczej]:

[^inaczej]: Chociaż szczerze mówiąc częściej używam zmiennej środowiskowej `$PWD` lub wywołuję program `pwd` ;)

```bash
$ cd /run/usr/1000
$ echo ~+
/run/user/1000
```

W podobny sposób `-` pokazuje poprzedni katalog:

```bash
$ cd /tmp
$ cd 
$ echo ~-
/tmp
```

Podobnie jak wyrażenia glob, także znak `~` jest rozwijany przez powłokę przed przekazaniem tego znaku jako parametr do uruchamianego programu.

### Rozwijanie `{ }`

Bash wspiera także mechanizm rozwijania `{ }`. Proszę spójrz na przykład poniżej:

```bash
$ echo some-{magic,long,complicated}-text
some-magic-text some-long-text some-complicated-text
```

Wywołanie [programu `echo`]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#echo) wyświetla przekazane argumenty używając [standardowego wyjścia]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#standardowe-wejście-i-wyjście). Bash, w trakcie procesu rozwijania `{ }` zamienił pojedynczy parametr na trzy osobne parametry.

Wewnątrz nawiasów może znajdować się dowolna liczba elementów oddzielona znakiem `,`. Każdy z tych elementów będzie skutkował nowym „słowem” podstawionym przez bash'a.

Rozwijanie `{ }` może także służyć do generowania sekwencji numerów. Proszę spójrz na przykład, w którym generuję liczby od 7 do 10:

```bash
$ echo sequence-{7..10}
sequence-7 sequence-8 sequence-9 sequence-10
```

Użycie wiodących `0` powoduje generowanie numerów o stałej szerokości:

```bash
$ echo sequence-{07..10}
sequence-07 sequence-08 sequence-09 sequence-10
```

Opcjonalnym, trzecim paramerem może być skok, który informuje o ile powinny różnić się kolejno generowane liczby:

```bash
$ echo sequence-{0..10..2}
sequence-0 sequence-2 sequence-4 sequence-6 sequence-8 sequence-10
```

Ten sam mechanizm można także użyć do generowania sekwencji liter:

```bash
$ echo sequence-{a..d}
sequence-a sequence-b sequence-c sequence-d
```

Najczęściej używam tej składni jeśli chcę skopiować albo przenieść plik czy folder:

```bash
$ ls 
some_file.txt
$ mv some_file.txt{,.bak}
$ ls 
some_file.txt.bak
```

### Historia

Bash posiada bardzo przydatną funkcję, pozwala na zapisywanie historii wykonywanych poleceń. Przy odpowiedniej konfiguracji (domyślnej na przykład w Ubuntu) w pliku `~/.bash_history` zapisywana jest historia poleceń. Historia ta jest aktualizowana w momencie zamykania okna terminala.

Historia jest przydatna, bo często możesz używać poleceń, których używałeś poprzednio. Pomocny może być skrót klawiaturowy `Ctrl+r`, który pozwala na przeszukiwanie historii.

To dzięki historii możesz też używać strzałek (góra/dół) do poruszania się po historii wykonywanych poleceń. Chociaż sam używam częściej programu `history`.

Program `history` wypisuje historię wykonywanych poleceń. Często zdarza mi się używać tego programu w połączeniu z `grep` i [potokami]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#potoki):

```bash
$ history | grep docker | tail -n 3
 4500  docker run --rm -it alpine
 4501  docker run --rm -it --entrypoint /bin/sh alpine/helm
 4545  history | grep docker | tail -n 3
```

Przydatny może być też program `fc`, który pozwala na edycję wprowadzonych do tej pory komend przed ich wywołaniem.

Chociaż historia to dobra rzecz i nie raz może uratować skórę, zdarzają się przypadki, w których nie chcesz zostawiać po sobie śladu. Na przykład kiedy w linii poleceń wpisujesz hasło czy klucz do API.

To bardzo zła praktyka. Do przekazywania danych wrażliwych jak hasła czy tokeny dostępu używaj plików (przekazując ścieżkę do pliku z danymi wrażliwymi) albo zmiennych środowiskowych (zawierających dane wrażliwe albo ścieżkę do pliku z danymi wrażliwymi).
{:.notice--warning}

W przypadku kiedy nie chcesz aby dana komenda została zapisana w historii poprzedź ją ` ` (spacją)[^histcontrol].

[^histcontrol]: Ten mechanizm zależy od wartości zmiennej środowiskowej `HISTCONTROL`.

### Polecenia wbudowane

Do tej pory używałem głównie określenia „program”, jednak nie we wszystkich przypadkach było to do końca poprawne. Dzieje się tak za sprawą poleceń wbudowanych.

W dochodzeniu do prawdy pomocny będzie program `which` :). Ten program zwraca ścieżki programów, które byłyby uruchomione dla każdego z przekazanych prametrów. Robi to oparciu o listę katalogów przechowywanych w zmiennej środowiskowej `PATH`. Proszę spójrz na przykład:

```bash
$ which ls
/bin/ls
```

W tym przykładzie `which` zwraca [absolutną ścieżkę]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#ścieżka) programu, który zostanie uruchomiony po wywołaniu `ls`. W tym przypadku jest to `/bin/ls`.

W ten sam sposób możesz sprawdzić inne programy:

```bash
$ which which mount cron
/usr/bin/which
/bin/mount
/usr/sbin/cron
```

A teraz spróbuj zrobić to samo dla innych „programów”, których używasz `cd` czy `history`:

```bash
$ which cd history
```

Hmm ;), `which` nie pokazało nic. Dzieje się tak z tego powodu, że zarówno `cd` jak i `history` to polecenia wbudowane w `bash`'a. Takich poleceń jest więcej. Jednym z wbudowanych poleceń jest `type`, które rzuca więcej światła na tę sprawę:

```bash
$ type -a history
history is a shell builtin
```

Użyłem tu przełącznika `-a`, który zwraca wszystkie możliwe opcje, a jest ich kilka :). Proszę spójrz na kolejny przykład:

```bash
$ type -a cd
cd is a function
cd () 
{ 
    __zsh_like_cd cd "$@"
}
cd is a shell builtin
```

W tym przypadku jest ciekawiej, `cd` jest zarówno wbudowanym poleceniem jak i funkcją. `bash` to nie tylko program. `bash` to także język skryptowy, w którym można definiować funkcje[^zagmatwane]. To jeszcze nie koniec ciekawostek :)

[^zagmatwane]: Na początku to może wydawać się zagmatwane – program `bash` (konsola), który jest w stanie interpretować `bash` (język skryptowy).

```bash
$ type -a kill pwd
kill is a shell builtin
kill is /bin/kill
pwd is a shell builtin
pwd is /bin/pwd
```

Jak widzisz istnieją także „programy”, które są zarówno poleceniami wbudowanymi jak i zwyczajnymi programami. Tak na prawdę ta wiedza nie jest Ci potrzebna przy codziennej pracy z linią poleceń. Dodałem ten punkt raczej w ramach ciekawostki :). W dalszej części artykuł nadal będę używał określenia „program” odnosząc się zarówno do programów jak i poleceń wbudowanych.

### Wywoływanie programów w tle

### Parametry specjalne

`bash` posiada zestaw paremetrów, które mają specjalne znaczecznie. Możesz odwołać się do tych parametrów używając składni `$<znak parametru>`, na przykład `$?`. Parametry te zawierają 

kkk

`$?`
`$#`
`$_`


## Zmienne środowiskowe

Uruchomienie programu wiąże się z uruchomienierm procesu. Proces nadzorowany jest przez system operacyjny. Każdy proces posiada, między innymi, swój zestaw zmiennych środowiskowych.

Można powiedzieć, że zmienne środowiskowe są podobne do zmiennych w językach programowania. Zmienne środowiskowe zawirają dane, które dostępne są dla procesu (programu). Zazwyczaj nazwy zmiennych środowiskowych używają wielkich liter, choć nie jest to wymagane. Kilka przykładowych zmiennych środowiskowych:

* `PATH` – zawiera listę katalogów, w których poszukiwane są programy do uruchomienia. To dzięki tej zmiennej możesz napisać `ls` bez podawania pełnej ścieżki programu (`/bin/ls`),
* `HOME` – zawiera ścieżkę do katalogu domowego użytkownika,
* `EDITOR` – zawiera ścieżkę do preferowanego edytora tekstu.

Możesz sprawdzić aktualną listę zmiennych środowiskowych wywołując program `set` bez żadnych parametrów[^set]:

[^set]: Program ten wyświetla też listę dostępnych funkcji.

```bash
$ set | head -n 1
BASH=/bin/bash
```

Przykład poniżej pokazuje użycie zmiennych środowiskowych:

```bash
$ echo $HOME
/home/mapi
$ echo $HOMEsweetHOME

$ echo ${HOME}sweetHOME
/home/mapisweetHOME
```

Pierwsza komenda wyświetla zawartość zmiennej `HOME`. Druga zawartość zmiennej `HOMEsweetHOME`. Zauważ, że w tym przypadku `bash` nie wie gdzie kończy się nazwa zmiennej środowiskowej. Dlatego właśnie wyświetla pustą linię – zmienna `HOMEsweetHOME` nie jest zdefiniowana. W trzecim przypadku użyłem składni `${}`[^rozwijanieparametrow] otaczając nawiasami klamrowymi nazwę zmiennej.

[^rozwijanieparametrow]: To mechanizm rozwijania parametrów, podobny do rozwijania `~` czy rozwijania `{}`.

Możesz też definiować swoje zmienne środowiskowe używając składni `NAZWA_ZMIENNEJ=wartosc zmiennej`:

```bash
$ echo $NEW_VARIABLE

$ NEW_VARIABLE="some value"
$ echo $NEW_VARIABLE
some value
```

### Zmienne środowiskowe w procesach potomnych

Wiesz już, że zmienne środowiskowe przypisane są do procesu. Każdy proces ma swoją kopię zmiennych środowiskowych. Uruchamiając nowy proces _eksportowane_ zmienne środowiskowe kopiowane są do procesu potomnego.

Zmienną środowiskową możesz eksportować używając /

Oznacza to tyle, że proces potomy ma dostęp wyłącznie do podzbioru zmiennych aktualnie zdefiniowanych. Proszę spójrz na przykład:

```bash
$ VARIABLE_1=value1
$ export VARIABLE_2=value2
$ echo $VARIABLE_1 $VARIABLE 2
value1 value2
$ bash  # uruchamia nowy proces
$ echo $VARIABLE_1 $VARIABLE_2
value2
```

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

### Praca z tekstem

## Dodatkowe materiały do nauki

Podobnie jak w [poprzednim artkule]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}) z serii jako pierwsze źródło polecę Ci dokumentację. Znów odsyłam cię do programu `man` lub wbudowanej dokumentacji, którą możesz przeczytać uruchamiając `<program> --help`.

## Podsumowanie

https://explainshell.com/

Daj znać w komentarzach jak używasz linii poleceń w swojej codziennej pracy z komputerem. Może pominąłem jakiś program, który Twoim zdaniem do takiej pracy jest niezbędny?
