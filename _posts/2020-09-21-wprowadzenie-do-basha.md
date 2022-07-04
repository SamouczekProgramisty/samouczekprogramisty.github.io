---
title: Wprowadzenie do bash'a
last_modified_at: 2020-09-21 20:57:24 +0200
categories:
- Programista rzemieślnik
permalink: /wprowadzenie-do-basha/
header:
    teaser: /assets/images/2020/0921-wprowadzenie-do-basha/wprowadzenie_do_basha_artykul.jpg
    overlay_image: /assets/images/2020/0921-wprowadzenie-do-basha/wprowadzenie_do_basha_artykul.jpg
    caption: "[&copy; Franz Harvin Aceituna](https://unsplash.com/photos/vkfrFrAIO4o)"
excerpt: W artykule poznasz kilka cech `bash`'a, które pozwolą Ci na efektywną pracę. Poznasz część mechanizmów rozwijania dostępnych w tym terminalu. Dowiesz się jak można używać historii poleceń i jak możesz ją zmieniać. Przeczytasz też o zmiennych środowiskowych w kontekście procesów. Na końcu artykułu czeka na Ciebie zestaw materiałów dodatkowych, które pomogą Ci pogłębić wiedzę z tego tematu.
---

{% capture other_bash_article_notice %}
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
{% endcapture %}

<div class="notice--info">
    {{ other_bash_article_notice | markdownify }}
</div>

## Specyficzne dla `bash`'a

Na tym etapie wiesz już czym jest [ścieżka]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#ścieżka). Sporo programów akceptuje ścieżki jako parametry. W niektórych przypadkach niezbędne jest przekazanie wielu ścieżek. W takiej sytuacji z pomocą mogą przyjść wyrażenia glob.

### Glob

`bash` nie wspiera [wyrażeń regularnych]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}). Mam na myśli to, że sama powłoka nie pozwala na przykład na określenia ścieżki do pliku używając [wyrażeń regularnych]({% post_url 2017-01-06-wyrazenia-regularne-czesc-2 %})[^regexpprogramy]. `bash` używa wyrażeń „glob”, które są do nich podobne.

[^regexpprogramy]: Zupełnie inną sprawą są programy, które pozwalają na używanie wyrażeń regularnych w przekazanych parametrach.

Historycznie glob był osobnym programem, który został wchłonięty przez bash'a. Wyrażenia glob pozwalają na odwoływanie się do plików/katalogów używając `?`, `*` i `[]`. Znak `?` zastępuje jeden znak, `*` zastępuje dowolną liczbę znaków. Na przykład wyrażenie glob `*.txt` pasuje do wszystkich plików z rozszerzeniem `.txt` w aktualnym katalogu. Wyrażenie glob `?.txt` pasuje do wszystkich plików których nazwa (przed rozszerzeniem) ma jeden znak.

`[]` zawiera w sobie grupę dozwolonych znaków. Na przykład wyrażenie `[ab].txt` pasuje do nazw plików `a.txt` i `b.txt` ale nie pasuje do nazwy `ab.txt`. Grupy umieszczone wewnątrz `[]` mogą być zakresami znaków. Zakres znaków oddzielony jest `-`, na przykład `[a-d].txt` pasuje do nazw plików `a.txt`, `b.txt`, `c.txt` i `d.txt`. Jeśli chcesz dopasować `-` dosłownie umieść go na początku, albo na końcu grupy, na przykład `[-a]` albo `[a-]`.

Podsumowując, w wyrażeniach glob możesz używać następujących wzorców:

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

W pierwszym przypadku zostanie uruchomiony [program `ls`]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#ls) bez żadnego parametru. Domyślnie zatem zostanie użyty aktualny katalog (`.`). Program wypisze zawartość aktualnego katalogu, w moim przypadku są to trzy pliki: a.txt, b.txt i c.csv. W drugim przypadku pojawia się wyrażenie glob `*.txt`, które zostaje rozwinięte przez konsolę do `a.txt b.txt` i przekazane jako argument do programu `ls`. Zatem w przykładzie powyżej `ls *.txt` jest tak na prawdę wywołaniem `ls a.txt b.txt`.

Wyrażenia glob nie biorą pod uwagę plików/katalogów, których nazwa zaczyna się od kropki (`.`). Jeśli wyrażenie glob nie może być rozwinięte (nie pasuje do żadnego pliku/katalogu) zostanie przekazane jako parametr bez zmian:

```bash
$ ls
exists.txt

$ echo *.txt
exists.txt

$ echo *.pdf
*.pdf
```

{% include newsletter-srodek.md %}

### Rozwijanie `~`

W `bash`'u znak tyldy (`~`) ma specjalne znaczenie. `~` oznacza katalog domowy użytkownika. Podobnie jak wyrażenia glob, tylda rozwijana jest do właściwej ścieżki przed przekazaniem jej jako parametr do programu. Proszę spójrz na przykład poniżej, w którym użyłem [programu `echo`]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#echo):

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

[^inaczej]: Chociaż szczerze mówiąc częściej używam zmiennej środowiskowej `PWD` lub wywołuję program `pwd` ;)

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

Użycie wiodącego `0` powoduje generowanie numerów o stałej szerokości:

```bash
$ echo sequence-{07..10}
sequence-07 sequence-08 sequence-09 sequence-10
```

Opcjonalnym, trzecim parametrem może być skok, który informuje o ile powinny różnić się kolejno generowane liczby:

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

### Parametry specjalne

`bash` posiada zestaw parametrów, które mają specjalne znaczenie. Możesz odwołać się do tych parametrów używając składni `$<znak parametru>`, na przykład `$?`. Są one traktowane jako specjalne, ponieważ służą wyłącznie do odczytu. Część z nich znajdziesz poniżej:

* `$#` - zawiera liczbę parametrów przekazanych do skryptu bash'a
* `$?` - zawiera kod wyjścia poprzednio uruchomionego programu
* `$$` - zawiera identyfikator procesu bash'a
* `$_` - zawiera ostatni argument poprzedniej komendy

Proszę spróbuj trochę poeksperymentować z użyciem tych parametrów, wtedy zrozumienie ich działania będzie dużo łatwiejsze.

### Historia

Bash posiada bardzo przydatną funkcję, pozwala ona na zapisywanie historii wykonywanych poleceń. Przy odpowiedniej konfiguracji (domyślnej na przykład w Ubuntu) w pliku `~/.bash_history` zapisywana jest historia poleceń. Historia ta jest aktualizowana w momencie zamykania okna terminala.

Historia jest przydatna, bo często możesz używać poleceń, których używałeś poprzednio. Pomocny może być skrót klawiaturowy `Ctrl+R`, który pozwala na przeszukiwanie historii. Po użyciu tego skrótu klawiaturowego zmieni się standardowy znak zachęty. Możesz wtedy wpisywać fragmenty poleceń z historii. Jak zwykle, zachęcam Cię do eksperymentów:

```bash
(reverse-i-search)`': 
```

To dzięki historii możesz też używać strzałek (góra/dół) do poruszania się po historii wykonywanych poleceń. Chociaż sam używam częściej programu `history` albo wspomnianego skrótu `Ctrl+R`.

#### `history`

Program `history` wypisuje historię wykonywanych poleceń. Często zdarza mi się używać tego programu w połączeniu z `grep` i [potokami]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#potoki):

```bash
$ history | grep docker | tail -n 3
 4500  docker run --rm -it alpine
 4501  docker run --rm -it --entrypoint /bin/sh alpine/helm
 4545  history | grep docker | tail -n 3
```

Przydatny może być też program `fc`, który pozwala na edycję wprowadzonych do tej pory komend przed ich wywołaniem. W przykładzie poniżej `fc 1170` uruchomi edytor tekstu z poleceniem `git rebase -i master`. To polecenie znajduje się na 1170 miejscu w historii bash'a:

```bash
$ history | grep git | tail -n 4
 1170  git rebase -i master
 1174  git status
 1176  git log -5
 1178  git push

$ fc 1170
```

#### Modyfikowanie historii

Chociaż historia to dobra rzecz i nie raz może uratować skórę, zdarzają się przypadki, w których nie chcesz zostawiać po sobie śladu. Na przykład kiedy w linii poleceń wpisujesz hasło czy klucz do API.

{% capture zla_praktyka %}
To bardzo zła praktyka. Do przekazywania danych wrażliwych jak hasła czy tokeny dostępu używaj plików (przekazując ścieżkę do pliku z danymi wrażliwymi) albo zmiennych środowiskowych (zawierających dane wrażliwe albo ścieżkę do pliku z danymi wrażliwymi).

To rozwiązanie też nie jest idealne. Zmienne środowiskowe, podobnie jak pliki mogą być dostępne dla innych użytkowników systemu. Jednak takie rozwiązanie jest o niebo lepsze niż używanie danych wrażliwych bezpośrednio w konsoli.
{% endcapture %}

<div class="notice--warning">
    {{ zla_praktyka | markdownify }}
</div>


W przypadku kiedy nie chcesz aby dana komenda została zapisana w historii poprzedź ją ` ` (spacją)[^histcontrol].

[^histcontrol]: Ten mechanizm zależy od wartości zmiennej środowiskowej `HISTCONTROL`.

A co jeśli mleko już się rozlało i komenda została już zapisana w historii? Wówczas z pomocą przychodzi program `history` z parametrem `-d`:

```bash
$ history | tail -n 1
 1190 curl https://admin:password1@ministry.gov

$ history -d 1190

$ history -w
```

Polecenie `history -d 1190` usuwa z historii komendę z numerem 1190. `hisory -w` zapisuje aktualną historię (z usuniętą komendą) w pliku historii.

Jeśli nie chcesz używać programu `history` zawsze możesz edytować plik historii samodzielnie. Zmienna środowiskowa `HISTFILE` przechowuje ścieżkę do pliku, w którym przechowywana jest historia poleceń:

```bash
$ vim $HISTFILE
```

#### Rozwijanie historii

Proszę spójrz na przykład poniżej, w którym użyłem podstawowego mechanizmu rozwijania historii:

```bash
$ history | grep git | tail -n 3
 1174  git status
 1176  git log -5
 1178  git push

$ !1176

$ history | grep git | tail -n 3
 1176  git log -5
 1178  git push
 1201  git log -5
```

Wywołanie `!1176` spowodowało ponowne uruchomienie programu zapisanego w historii pod numerem 1176. Mechanizm ten jest dość rozbudowany. Jeśli chcesz poznać więcej jego możliwości odsyłam Cię do sekcji „History expansion” w [dokumentacji `bash`'a](https://linux.die.net/man/1/bash).

### Polecenia wbudowane

Do tej pory używałem głównie określenia „program”, jednak nie we wszystkich przypadkach było to do końca poprawne. Dzieje się tak za sprawą poleceń wbudowanych.

W dochodzeniu do prawdy pomocny będzie program `which` :). Ten program zwraca ścieżki programów, które byłyby uruchomione dla każdego z przekazanych parametrów. Robi to oparciu o listę katalogów przechowywanych w zmiennej środowiskowej `PATH`. Proszę spójrz na przykład:

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
$ type -a kill pwd
kill is a shell builtin
kill is /bin/kill
pwd is a shell builtin
pwd is /bin/pwd
```

Jak widzisz istnieją także „programy”, które są zarówno poleceniami wbudowanymi jak i zwyczajnymi programami. W dalszej części artykuł nadal będę używał określenia „program” odnosząc się zarówno do programów jak i poleceń wbudowanych.

### Wywoływanie programów w tle

Może się zdarzyć, że chcesz wywołać program, który działa bardzo długo a nie chcesz zajmować aktualnego okna konsoli. Z pomocą przychodzi operator `&`:

```bash
$ ping www.samouczekprogramisty.pl > ~/ping_output.txt &
[1] 11410
```

W przykładzie powyżej wywołałem program `ping` i [przekierowałem standardowe wyjście]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}#przekierowania) do pliku `~/ping_output.txt`. Kolejna linia `[1] 11410` informuje o tym, że zadanie `[1]` działające w tle zostało uruchomione. Zadanie to działa jako proces 11410.

W każdym momencie możesz sprawdzić listę zadań używając programu `jobs`:

```bash
$ jobs
[1]+  Running                 ping www.samouczekprogramisty.pl > ~/ping_output.txt &
```

W tym przypadku uruchomione jest jedno zadanie w tle, które ma status `Running`. Możesz „przywołać” to zadanie używając programu `fg` (od ang. _foreground_):

```bash
$ fg %1
ping www.samouczekprogramisty.pl > ~/ping_output.txt
```

W zarządzaniu zadaniami pomocny jest też skrót klawiaturowy `<Ctrl+Z>`, który usypia aktualny program[^sygnal]:

[^sygnal]: Tak na prawdę to wysyła sygnał do procesu. To w jaki sposób ten sygnał jest obsłużony do inna sprawa. Domyślnie program jest „usypiany”.

```bash
$ fg %1
ping www.samouczekprogramisty.pl > ~/ping_output.txt
^Z # tu użyłem Ctrl+Z
[1]+  Stopped                 ping www.samouczekprogramisty.pl > ~/ping_output.txt
```

Jak widzisz w tym przypadku zadanie `[1]` ma status `Stopped`. Jeśli chcesz wznowić zatrzymany program w tle użyj programu `bg` (od ang. _background_):

```bash
$ jobs
[1]+  Stopped                 ping www.samouczekprogramisty.pl > ~/ping_output.txt

$ bg %1
[1]+ ping www.samouczekprogramisty.pl > ~/ping_output.txt

$ jobs
[1]+  Running                 ping www.samouczekprogramisty.pl > ~/ping_output.txt &
```

## Zmienne środowiskowe

Uruchomienie programu wiąże się z uruchomieniem procesu. Proces nadzorowany jest przez system operacyjny. Każdy proces posiada, między innymi, swój zestaw zmiennych środowiskowych.

Można powiedzieć, że zmienne środowiskowe są podobne do zmiennych w językach programowania. Zmienne środowiskowe zawierają dane, które dostępne są dla procesu (programu). Zazwyczaj nazwy zmiennych środowiskowych używają wielkich liter, choć nie jest to wymagane. Kilka przykładowych zmiennych środowiskowych:

* `PATH` – zawiera listę katalogów, w których poszukiwane są programy do uruchomienia. To dzięki tej zmiennej możesz napisać `ls` bez podawania pełnej ścieżki programu (`/bin/ls`),
* `HOME` – zawiera ścieżkę do katalogu domowego użytkownika,
* `EDITOR` – zawiera ścieżkę do preferowanego edytora tekstu,
* `PPID` – zawiera identyfikator procesu nadrzędnego (tego, który uruchomił aktualny proces).

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

Wiesz już, że zmienne środowiskowe przypisane są do procesu. Każdy proces ma swoją kopię zmiennych środowiskowych. Uruchamiając nowy proces _eksportowane_ zmienne środowiskowe kopiowane są do procesu potomnego. Oznacza to tyle, że proces potomny ma dostęp wyłącznie do podzbioru zmiennych aktualnie zdefiniowanych.

Zmienną środowiskową możesz eksportować używając programu `export`. Proszę spójrz na przykład:

```bash
$ VARIABLE_1=value1

$ export VARIABLE_2=value2

$ echo $VARIABLE_1 $VARIABLE_2 $PPID
value1 value2 2855

$ bash  # uruchamia nowy proces

$ echo $VARIABLE_1 $VARIABLE_2 $PPID
value2 10189
```

W przykładzie możesz zobaczyć dwie zmienne: `VARIABLE_1` i `VARIABLE_2`. Druga z nich została wyeksportowana. Dzięki temu jest dostępne w procesie potomnym.

## Dodatkowe materiały do nauki

Podobnie jak w [poprzednim artkule]({% post_url 2019-03-12-poczatki-pracy-z-konsola %}) z serii jako pierwsze źródło polecę Ci dokumentację. Znów odsyłam cię do programu `man` lub wbudowanej dokumentacji, którą możesz przeczytać uruchamiając `<program> --help`.

W przypadku tego artykułu nieocenionym źródłem wiedzy będzie dokumentacja programu `bash`, którą możesz przeczytać po uruchomieniu `man bash` lub [online](https://www.gnu.org/software/bash/manual/bash.html).

Możesz też rzucić okiem na stronę [https://explainshell.com](https://explainshell.com), która pozwoli Ci lepiej zrozumieć bardziej skomplikowane komendy.

Niezmiennie zachęcam Cię do samodzielnych eksperymentów. Najwięcej nauczysz się samodzielnie bawiąc się linią poleceń.

## Podsumowanie

Po lekturze tego artykułu możesz spokojnie używać linii poleceń w codziennej pracy. Udało Ci się poznać zestaw przydatnych cech `bash`'a. Potrafisz swobodnie poruszać się po historii poleceń i ją modyfikować w razie potrzeby. Wiesz więcej o zmiennych środowiskowych i rozumiesz jaka jest zależność pomiędzy procesem a zmienną środowiskową. Gratulacje! :)

To tyle na dzisiaj, dziękuję za lekturę, trzymaj się i do następnego razu! A… zapomniałbym, jeśli uważasz, że materiał może się przydać komuś z Twoich znajomych proszę podziel się z nim odnośnikiem do artykułu. W ten sposób pomożesz mi dotrzeć do nowych czytelników, z góry dziękuję! Jeśli nie chcesz pomiąć kolejnych artykułów dopisz się do samouczkowego newslettera i polub [Samouczka Programisty na Facebooku](https://www.facebook.com/SamouczekProgramisty).

Do następnego razu!
