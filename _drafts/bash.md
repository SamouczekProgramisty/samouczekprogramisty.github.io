---
title: Praca z wierszem poleceń
last_modified_at: 2019-03-17 15:56:22 +0100
categories:
- Programista rzemieślnik
permalink: /praca-z-wierszem-polecen/
header:
    teaser: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    overlay_image: /assets/images/2019/03/12_poczatki_pracy_z_wierszem_polecen_artykul.jpeg
    caption: "[&copy; Arie Wubben](https://unsplash.com/photos/MHIw0nSxCR4)"
excerpt: TODO
---

https://explainshell.com/

{% capture text_source_notice %}
W treści artykułu będę używał plików z lekturami dostępnymi na stronie (https://wolnelektury.pl/). Możesz je ściągnąć w konsoli używając takiego skryptu:

```bash
for l in pan-tadeusz quo-vadis wesele latarnik janko-muzykant
do
    wget https://wolnelektury.pl/media/book/txt/${l}.txt
done
```
{% endcapture %}

<div class="notice--info"}
    {{ text_source_notice | mardkownify }}
</div>

## Glob

`?` oznacza dowolny pojedynczy znak (poza `/` i `.` na początku)
`*` oznacza dowolną liczbę znaków (poza `/` i `.` na początku)


Duża część programów obsługuje dwa tryby pracy. W jednym z nich dane wejściowe przekazywane są przez stdin, w drugim jako parametry będące ścieżkami do plików[^minusik].

[^minusik]: Swego rodzaju wyjątkiem może być tu znak `-`. Zgodnie z konwencją ten znak oznacza stdin. Może też służyć jako pełnoprawna nazwa pliku, jednak wtedy trzeba się do niego odnieść używając ścieżki, na przykład `./-`.

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

```$ ls -lA
total 1876
-rw-r--r-- 1 marcinek marcinek   16539 maj 25  2017 janko-muzykant.txt
-rw-r--r-- 1 marcinek marcinek   34747 sie  2  2017 latarnik.txt
-rw-r--r-- 1 marcinek marcinek  493451 sie 21  2017 pan-tadeusz.txt
-rw-r--r-- 1 marcinek marcinek 1189307 wrz  4  2017 quo-vadis.txt
-rw-r--r-- 1 marcinek marcinek  171182 sie  6  2018 wesele.txt
```

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

## Podsumowanie

Daj znać w komentarzach jak używasz linii poleceń w swojej codziennej pracy z komputerem. Może pominąłem jakiś program, który Twoim zdaniem do takiej pracy jest niezbędny?
