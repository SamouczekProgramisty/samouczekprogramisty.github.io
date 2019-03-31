---
title: Początki pracy z wierszem poleceń
last_modified_at: 2019-03-17 15:56:22 +0100
categories:
- Programista rzemieślnik
permalink: /poczatki-pracy-z-wierszem-polecen/
header:
    teaser: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    overlay_image: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    caption: "[&copy; Arie Wubben](https://unsplash.com/photos/MHIw0nSxCR4)"
excerpt: Artykuł zaczynam od wytłumaczenia dlaczego warto poznać wiersz poleceń. Pokażę Ci jak sam pracuję z terminalem w systemie Linux. Poznasz najczęściej używane programy, które przydają się w codziennej pracy. Dowiesz się czym jest standardowe wyjście, poznasz też mechanizm przekierowań. Na końcu artykułu jak zwykle czeka na Ciebie zestaw zadań, które pomogą utrwalić Ci wiedzę zdobytą po lekturze artykułu.
---

To jest jeden z artykułów omawiających pracę z wierszem poleceń. Omawiam w nim podstawy niezbędne do wydajnej pracy. Dalsze artykuły z cyklu opisują bardziej zaawansowane zagadnienia związane z pracą w linii poleceń. Wszystkie artykuły w serii zebrałem w sekcji [narzędzia i dobre praktyki]({{ '/narzedzia-i-dobre-praktyki/' }}#narz%C4%99dzia).
{:.notice--info}

## Wiersz poleceń

Upraszczając można powiedzieć, że wiersz poleceń to program pozwalający na interakcję z komputerem. W odróżnieniu od graficznego interfejsu użytkownika w wierszu poleceń używa się klawiatury.

### Dlaczego warto używać wiersza poleceń

Interfejs graficzny służy do tego, żeby ułatwić pracę z danym programem/systemem operacyjnym. Takie podejście jest szczególnie użyteczne dla początkujących użytkowników. Interfejs graficzny w przyjazny dla oka sposób udostępnia najczęściej używane funkcje. Problem zaczyna pojawiać się kiedy chcesz zrobić coś co nie jest standardowe. W takich przypadkach musisz szukać opcji, które są ukryte gdzieś głęboko w czeluściach zagnieżdżonych menu.

Co więcej taką pracę ciężko jest zautomatyzować. Jeśli wykonujesz pewną czynność, która jest powtarzalna to z interfejsem graficznym za każdym razem musisz klikać, nie ma wyjścia[^nagrywanie]. Pomocne są tu skróty klawiaturowe, jednak nie wszystkie opcje mają swój skrót. Z wierszem poleceń sprawa wygląda trochę inaczej.

[^nagrywanie]: Pomijam tutaj rozwiązania, które pozwalają na nagrywanie ekranu i automatyczne wykonywanie tych czynności ponownie. Takie narzędzia często także wymagają użycia specyficznego języka programowania. Tak otrzymane nagrania są ciężkie w utrzymaniu, każda zmiana interfejsu może powodować błędy w ich działaniu.

Wiersz poleceń to narzędzie przydatne w codziennej pracy programisty. Nie znam żadnego programisty, który w swojej pracy nigdy nie używał wiersza poleceń. Co więcej to narzędzie jest przydatne w trakcie pracy z każdym językiem programowania. Niezależnie od tego w jakim języku chcesz programować umiejętność posługiwania się wierszem poleceń może się przydać.

Co więcej filozofia, która stoi za programami dostępnymi w wierszu poleceń pozwala na ich zgrabne łączenie. W efekcie możesz uzyskać naprawdę potężne narzędzie, które składa się z wielu drobnych klocków.

### Jaki wiersz poleceń wybrać

Mam nadzieje, że udało mi się przekonać Cię do tego, że warto używać wiersza poleceń. Teraz pozostaje pytanie, jaki wiersz poleceń wybrać? Nie chcę tu prowadzić świętej wojny i przekonywać Cię o wyższości jednego rozwiązana nad innym. Zachęcam Cię do sprawdzenia kilku rozwiązań i wybrania tego, które w Twoim przypadku sprawdzi się najlepiej. Sam używam [`bash`](https://pl.wikipedia.org/wiki/Bash)'a i to właśnie jego będę używał w dalszej części artykułu.

### Jak bezboleśnie zacząć przygodę z `bash`'em?

Jeśli używasz systemu Linux/Unix to istnieje duże prawdopodobieństwo, że masz dostęp do `bash`'a i możesz pominąć ten podpunkt. Problem pojawia się jeśli używasz Windows'a. Tam niestety `bash` nie jest dostępny.

Jeśli chcesz sprawdzić czy praca z wierszem poleceń to coś dla Ciebie, to masz do wyboru kilka opcji:

* użyć emulatora wiersza poleceń w przeglądarce, na przykład [LinuxContainers](https://linuxcontainers.org/lxd/try-it/),
* zainstalować emulator wiersza poleceń, na przykład [Cygwin](https://www.cygwin.com/),
* użyć pełnego systemu operacyjnego [uruchamianego z USB/CD](https://tutorials.ubuntu.com/tutorial/try-ubuntu-before-you-install) – w ten sposób dostaniesz cały system operacyjny, nie tylko wiersz poleceń,
* zainstalować narzędzie do wirtualizacji (na przykład [VirtualBox](https://www.virtualbox.org/wiki/Downloads)) w systemie Windows i utworzyć maszynę wirtualną z systemem Linux. Także tutaj dostajesz do dyspozycji Linux'a, którego możesz przetestować bez dużego nakładu pracy,
* użyć narzędzia wspierającego kontenery (na przykład [Docker](https://www.docker.com/)) i uruchomić najprostszy kontener z systemem Linux,
* zainstalować drugi system równolegle do Windowsa,
* wyrzucić Windows'a do śmieci i pracować na Linux'ie ;).

{% include newsletter-srodek.md %}

## Jak wygląda wiersz poleceń

Zacznę od obrazka:

{% include figure image_path="/assets/images/2019/03/14_prompt.gif" caption="Okno wiersza poleceń" %}

To puste okno wiersza poleceń. Ten migający znaczek to znak zachęty. Tutaj wpisuje się komendy. To co jest przed znakiem zachęty to:

* nazwa użytkownika, w moim przypadku jest to `marcinek`,
* `@` oddzielająca nazwę użytkownika i kolejny element,
* nazwa komputera, w moim przypadku jest to `mapiszon-dell`,
* `:` oddzielający nazwę komputera i kolejny element,
* aktualna ścieżka, w moim przypadku jest to `~` (tylda). Ten znak reprezentuje katalog domowy użytkownika,
* `$` oddzielający ścieżkę od miejsca do wprowadzania komend.

W dalszych przykładach będę używał skróconego zapisu – `$ something`. Zapis ten oznacza uruchomienie programu `something`. Sprowadza się to do uruchomienia procesu, który wykonuje kod programu `something`.

## Podstawy pracy z systemem plików

Nadszedł czas na pokazanie Ci kilku podstawowych programów, które są niezbędne do pracy z linią poleceń.

Tutaj mam do Ciebie prośbę. Eksperymentuj! Otwórz wiersz poleceń i na bieżąco czytając artykuł sprawdzaj jak działają poszczególne programy. Właśnie dzięki takiej praktyce nauczysz się najwięcej. 

### `cd`

Nawigowanie po systemie plików w wierszu poleceń to podstawa od której należy zacząć. Służy do tego program `cd`. Na przykład wywołanie komendy:

```bash
$ cd some-directory
```

Spowoduje przejście do katalogu `some-directory`. Argumentem przekazanym do programu jest ścieżka reprezentująca katalog. W przykładzie powyżej jest to ścieżka względna. Oznacza to tyle, że zmiana następuje względem katalogu, w którym aktualnie się znajdujesz. Innymi przykładem ścieżki względnej może być `dir1/dir2/yet-another-directory`. Reprezentuje ona trzy zagnieżdżone katalogi.

Wcześniej wprowadziłem już `~` – symbol ten oznacza katalog domowy. W systemach z rodziny Linux/Unix jest to przeważnie `/home/<nazwa użytkownika>`, na przykład `/home/marcinek`. `/home/marcinek` to przykład ścieżki bezwzględnej. Ścieżka bezwzględna od ścieżki względniej różni się tym, że zaczyna się od `/`.

A co jeśli chcę przejść do katalogu nadrzędnego? W tym przypadku trzeba użyć `..` jako nazwy katalogu[^bezwzgledna]:

[^bezwzgledna]: Możesz także użyć ścieżki bezwzględnej.

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

Jeśli chcesz zmienić aktualny katalog na swój katalog domowy możesz użyć wcześniej wspomnianego znaku `~`. Wywołanie programu `cd` z pominięciem argumentu także zmienia katalog na domowy. Oba polecenia zaprowadzą Cię do tego samego katalogu:

```bash
$ cd ~
```

```bash
$ cd
```

### `pwd`

Jeżeli chcesz poznać swój aktualny katalog możesz użyć programu `pwd`. Wypisuje on na konsolę ścieżkę absolutną katalogu, w którym aktualnie się znajdujesz:

```bash
marcinek@mapiszon-dell:~/private$ pwd
/home/marcinek/private
```

### `ls`

Sprawdzanie zawartości katalogu jest bardzo przydatne. W tym przypadku przyda się program `ls`:

```bash
marcinek@mapiszon-dell:~$ ls
Desktop  Documents  Downloads  Dropbox  Music  Pictures  private  Public  snap  Templates  Videos
```

Program ten wypisuje na konsolę zawartość ścieżki przekazanej jako argument. Domyślną ścieżką jest `.`, czyli aktualny katalog. W systemie Linux/Unix także istnieją pliki/katalogi ukryte. Domyślnie program `ls` ich nie pokazuje. Aby je zobaczyć należy użyć przełącznika. Jedną z możliwych opcji jest użycie `--all`:

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

Zaletą skróconych form jest to, że można je ze sobą łączyć. Na przykład poniższe wywołanie pokazuje zawartość katalogu w formie listy (pokazałem tylko część):

```bash
marcinek@mapiszon-dell:~$ ls -la
total 232
drwxr-xr-x 31 marcinek marcinek  4096 mar 14 23:03 .
drwxr-xr-x  4 root     root      4096 mar  9 20:37 ..
lrwxrwxrwx  1 marcinek marcinek    37 mar 11 23:38 .bash_aliases -> /home/marcinek/.dotfiles/bash_aliases
-rw-------  1 marcinek marcinek 23820 mar 14 15:00 .bash_history
-rw-r--r--  1 marcinek marcinek    81 mar 13 21:05 .bash_profile
-rw-r--r--  1 marcinek marcinek  4059 mar 13 21:04 .bashrc
...
```

Ostatnia kolumna to nazwa pliku/katalogu. Wcześniejsze kolumny zawierają metadane dotyczące danego elementu takie jak czas modyfikacji czy prawa dostępu. Pominę tutaj dokładne tłumaczenie tych elementów.

### `mkdir`

Program `mkdir` służy do tworzenia nowych katalogów. Wywołanie poniżej utworzy katalog o nazwie `sample-directory`:

```bash
$ mkdir sample-directory
```

Program `mkdir` pozwala także na tworzenie katalogów zagnieżdżonych:

```bash
$ mkdir non/existent/list/of/directories
mkdir: cannot create directory ‘non/existent/list/of/directories’: No such file or directory
```

Pod warunkiem, że cała ścieżka, poza ostatnim katalogiem aktualnie istnieje. Innymi słowy powyższe wywołanie należałoby zastąpić:

```bash
$ mkdir non
$ mkdir non/existent
$ mkdir non/existent/list
$ mkdir non/existent/list/of
$ mkdir non/existent/list/of/directories
```

Przyznasz, że nie jest to zbyt efektywne. W takim przypadku pomaga przełącznik `-p` lub `--parents`. Powyższą serię można zastąpić poleceniem:

```bash
$ mkdir -p non/existent/list/of/directories
```

### `rmdir`

Usuwanie elementów używając `rmdir`/`rm` nie wrzuca ich do Kosza, dany element od razu jest usuwany z dysku. Sprawdź dwa razy zanim usuniesz coś czego możesz potrzebować.
{:.notice--warning}

Wiesz już jak utworzyć katalog. Nadszedł czas na jego usunięcie. Służy do tego program `rmdir`:

```bash
$ rmdir sample-directory
```

Podobnie jak w przypadku `mkdir` także i tutaj jest możliwość usuwania zagnieżdżonych katalogów. Poniższe dwa zestawy wywołań programu `rmdir` mają ten sam efekt:

```bash
$ rmdir non/existent/list/of/directories
$ rmdir non/existent/list/of
$ rmdir non/existent/list
$ rmdir non/existent
$ rmdir non
```

```bash
$ rmdir -p non/existent/list/of/directories
```

Program `rmdir` usuwa wyłącznie puste katalogi. Jeśli chcesz usunąć coś więcej użyj programu `rm`

### `rm`

Program `rm` służy do usuwania elementów z dysku. Standardowe wywołanie usuwa pojedynczy plik. Przykład poniżej pokazuje usunięcie pliku o nazwie `some-file.txt`:

```bash
$ rm some-file.txt
```

Jeśli chcesz usunąć zagnieżdżone elementy użyj flagi `-r`. Tylko bardzo proszę, **ostrożnie**!

Tym programem można sobie zrobić kuku :). Sam nie raz usunąłem trochę zbyt dużo. Raz nawet udało mi się usunąć katalog domowy użytkownika. Wywołałem polecenie:

```bash
$ rm -rf ~
```

Wszystko dlatego, że dla testów utworzyłem plik o nazwie `~` ;). Uwierz mi, nie chcesz powtórzyć tego błędu. W wywołaniu wyżej przełącznik `-f` oznacza "wymuś usunięcie". Od tego czasu, jeśli usuwam cokolwiek rekursywnie, dodaję przełączniki `-rf` na końcu polecenia długo zastanawiając się przed naciśnięciem Enter ;).

### `touch`

Każdy element na dysku ma datę ostatniego dostępu i modyfikacji (widać ją w jednej z kolumn wyświetlanych przez `ls -l`). Program `touch` ustawia te daty na aktualną. Ta funkcjonalność nie jest aż tak istotna w większości przypadków. Ten program ma jeden istotny efekt uboczny. Jeśli plik przekazany jako argument nie istnieje zostanie on domyślnie utworzony:

```bash
$ touch non-existent-file.txt
```

## Standardowe wejście i wyjście

Zanim powiem Ci coś więcej o pracy z tekstem w wierszu poleceń musisz poznać kilka pojęć.

Wiesz czym jest aplikacja. Aplikacją może być przeglądarka internetowa. Każda aplikacja to co najmniej jeden proces. Proces można zdefiniować jako kod (program) wykonywany przez komputer. Schodząc jeszcze niżej możemy dojść do [wątków]({% post_url 2019-02-11-watki-w-jezyku-java %}), które opisałem niedawno.

Każdy proces ma przypisane zasoby, na przykład RAM (ang. _Random Access Memory_) czy zestaw deskryptorów plików. Deskryptor pliku to liczba, która jednoznacznie określa plik otworzony w danym procesie, pozwala na dostęp do pliku[^wszystko]. Deskryptory plików to nieujemne liczby całkowite, na przykład `0`, `1` czy `123`.

[^wszystko]: Poznając lepiej systemy operacyjne z rodziny Linux/Unix usłyszysz to jeszcze nie raz – wszystko jest plikiem ;). Dysk, plik, katalog, strumień, klawiatura itp.

Każdy program[^demon] zazwyczaj ma dostęp do co najmniej trzech deskryptorów plików:

[^demon]: Demony (ang. _deamon_) mogą trochę odstawać od tej reguły.

* standardowego wejścia (ang. _stdin_),
* standardowego wyjścia (ang. _stdout_),
* standardowego wyjścia błędów (ang. _stderr_).

Ten standardowy zestaw połączony jest z deskryptorami o dobrze znanych numerach:

* stdin – `0`,
* stdout – `1`,
* stderr – `2`.

Programy, które wypisują tekst na konsoli korzystają właśnie z tych standardowych strumieni – stdout i stderr. Na przykład `ls` wykorzystuje stdout do wypisania zawartości przekazanego argumentu. stderr może być użyty przez `mkdir` w przypadku, gdy chcesz utworzyć zagnieżdżony katalog bez przełącznika `-p` – do pokazania błędu.

#### `echo`

Prostym programem, który wykorzystuje standardowe wyjście jest `echo`. Zasada jego działania jest prosta – wyświetla na konsoli (używając stdout) przekazany tekst:

```bash
$ echo Some text to show on a console
Some text to show on a console
```

Jeśli chcesz wyświetlić tekst, który ma więcej niż jedną linię możesz użyć `'` albo `"`[^roznice]:

[^roznice]: `bash` inaczej interpretuje tekst pomiędzy `'` i `"`, jednak na tym etapie te różnice nie są istotne.

```bash
$ echo "Multiline text to 
> show on a console"
Multiline text to 
show on a console
```

Teraz jak znasz już standardowe strumienie (wejście – stdin, wyjście – stdout i wyjście błędów – stderr), mogę powiedzieć Ci coś więcej o przekierowaniach.

### Przekierowania

Przekierowania dotyczą standardowych strumieni. W praktyce mogą być wykorzystywane do tego, żeby tworzyć pliki zawierające logi programu. Używane są także po to, żeby dostarczyć dane czytane przez program na standardowym wejściu.

#### Nadpisywanie

Najprostszym przykładem przekierowania jest:

```bash
$ echo some text 1> plik_wyjscia
```

Taki zapis informuje wiersz poleceń o tym, żeby stdout procesu w którym uruchomiony jest program `echo` przekierować do pliku `plik_wyjscia`. `1` w tym zapisie reprezentuje numer deskryptora pliku. W tym przykładzie `1` można pomiąć, poniższy zapis znaczy dokładnie to samo:

```bash
$ echo some text > plik_wyjscia
```

W podobny sposób wygląda przekierowanie stderr:

```bash
$ program 2> plik_wyjscia
```

Możesz też przekierować jeden strumień do drugiego. Na przykład przekierowanie stdout do stderr wygląda tak:

```bash
$ program 1>&2
```

W wyniku takiego wywołania wszystkie komunikaty wypisane przez program do stdout zostaną przekierowane do stderr. Zwróć uwagę na `&` w komendzie. Bez tego znaku `2` zostałoby potraktowane jako plik o takiej nazwie.

Możesz także przekierować stdout i stderr równocześnie:

```bash
$ program > plik_wyjscia 2> plik_bledow
```

Jeśli w poleceniu występuje więcej przekierowań brane są pod uwagę od lewej do prawej strony. Ma to znaczenie na przykład tutaj:

```bash
$ program > plik_wyjscia 2>&1
```

Polecenie to przekierowuje stdout do `plik_wyjacia` a stderr "tam gdzie stdout".

Jeśli plik do którego przekierowywane są wiadomości nie istnieje zostaje utworzony. Dzięki temu zachowaniu możesz w prosty sposób tworzyć pliki. Na przykład poniższa komenda utworzy plik `sample_file.txt` (jeśli wcześniej plik nie istniał) uzupełniając go testem `sample file content`:

```bash
$ echo sample file content > sample_file.txt
```

#### Dołączanie

Przykłady, które pokazałem poprzednio nadpisują zwartość pliku, do którego nastąpiło przekierowanie. Istnieje także możliwość na dołączenie nowych wierszy do pliku:

```bash
$ program >> plik_wyjscia
```

Wszystkie mechanizmy, które opisałem powyżej działają także w przypadku dołączania, na przykład:

```bash
$ program 1>> plik_wyjscia 2>> plik_bledow
$ program >> plik_wyjacia 2>&1
```

### Potoki

W końcu mogę Ci powiedzieć o potokach! To właśnie one sprawiają, że małe klocki można łączyć w większą całość. Spójrz na przykład:

```bash
$ program1 | program2
```

Pionowa kreska `|` oznacza potok. No dobrze, ale co to takiego jest? Możesz to sobie wyobrazić jak rurę, która łączy standardowe wyjście jednego procesu ze standardowym wejściem innego procesu. W przykładzie powyżej stdout `program1` połączony zostaje z stdin `program2`.

Niby to nic nadzwyczajnego, jednak pozwala na tworzenie zaawansowanych narzędzi z prostych klocków nie odrywając się od wiersza poleceń. Moim zdaniem to właśnie ta funkcjonalność sprawia, że graficzny interfejs użytkownika nie dorasta do pięt wierszowi poleceń pod kątem możliwości.

Przykład, który pokazałem jest abstrakcyjny. Praktyczne zastosowania pokażę Ci w dalszej części artykułu.

## Początki pracy z tekstem

### `cat`

`cat` jest programem, który służy do wyświetlania danych używając stdout. To co powinno być wyświetlone przekazywane jest to programu jako parametr oznaczający nazwę pliku. Program ten może przyjąć wiele parametrów:

```bash
$ echo file1 content > file1
$ echo file2 content > file2
$ cat file2 file1
file2 content
file1 content
```

Program `cat` domyślnie wypisuje na stdout wszystko co odczyta z stdin. Pokazuje to poniższy przykład:

```bash
$ echo some text | cat
some text
```

Fragment powyżej zawiera przykładowe użycie przekierowań. `echo` wypisuje `some text` na stdout. `|` łączy stdout z programu `echo` z stdin programu `cat`, i to właśnie `cat` wypisuje na konsolę (swój stdout) to co przeczytał z programu `echo`.

W specjalny sposób traktowany jest parametr `-`, oznacza on stdin. Spójrz na przykład poniżej gdzie używam wcześniej utworzonych plików:

```bash
$ echo some text | cat file2 - file1
file2 content
some text
file1 content
```

### `clear`

Czasami wygodniej jest zacząć od początku. Pomaga przy tym program `clear`. Program ten robi co może żeby wyczyścić okno terminala :). Spróbuj go wywołać po serii innych komend.

## Dodatkowe materiały

Najlepszym materiałem, który mogę Ci polecić jest dokumentacja poszczególnych programów.

Całość sprowadza się do programu `man` lub parametru `--help`. Na przykład jeśli chcesz dowiedzieć się czegoś więcej o programie `cd` wywołaj komendę `cd --help` lub `man cd`. W ten sposób dostaniesz się do dokumentacji danego programu. To naprawdę najlepsze miejsce do szukania szczegółowych informacji o danym programie.

## Ćwiczenia do wykonania

* Utwórz poniższą strukturę katalogów używając wiersza poleceń:

```
samouczek/
├── algorytmy
├── bazy-danych
│   └── sql
├── programowanie
│   ├── java
│   └── python
└── struktury-danych
```

* Przekieruj wyjście programu `ls` do pliku,
* Użyj dowolnego programu i przekieruj stderr i stdout do dwóch różnych plików. Dasz radę zrobić to tak, żeby oba pliki nie były puste?,
* Jaki przełącznik programu `ls` pozwala na posortowanie wyników używając rozszerzenia plików (użyj `man`)?
* Napisz program, który pobierze ze standardowego wejścia dwie linijki tekstu. Pierwszą z nich powinien wypisać do standardowego wyjścia, drugą do standardowego wyjścia błędów. Następnie uruchom ten program z linii poleceń na kilka sposobów:
    - przekieruj na standardowe wejście zawartość pliku z dwoma linijkami,
    - przekieruj wyjście błędów do pliku error.log i standardowe wyjście do pliku usage.log,
    - przekieruj zarówno standardowe wyjście jak i wyjście błędów do usage.log.

Jeśli chcesz użyć Javy do rozwiązania tego zadania zachęcam Cię do przeczytania artykułu [Java z linii poleceń]({% post_url 2017-03-08-java-z-linii-polecen %}).

## Podsumowanie

Po lekturze tego artykułu znasz podstawowe programy używane w trakcie pracy z linią poleceń. Dzięki artykułowi udało Ci się dowiedzieć czym jest stdout, stderr i stdin. Znasz pojęcia przekierowań i potoków, potrafisz z nimi pracować. Rozwiązane ćwiczenia pozwoliły Ci w praktyczny sposób sprawdzić zdobytą wiedzę. Innymi słowy udało Ci się zdobyć kawał solidnej i przydatnej wiedzy, gratuluję :).

Teraz nie pozostaje mi nic innego jak zachęcić Cię do częstszej pracy z linią poleceń. Takie podejście naprawdę nie gryzie. Wierzę, że w dłuższej perspektywie pozwoli Ci osiągnąć lepszą wydajność. W kolejnym artykule z tej serii poznasz więcej programów, które pozwolą budować Ci bardziej skomplikowane komendy.

Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku proszę dopisz się do samouczkowego newslettera i polub stronę Samouczka na Facebook'u. Jeśli wiesz, że ktoś z Twoich znajomych potrzebuje wiedzy zawartej w tym artykule będę wdzięczny za przekazanie mu odnośnika do tego artykułu – z góry dziękuję.

To tyle na dzisiaj, trzymaj się i do następnego razu!
