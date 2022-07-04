---
title: Praca z linią poleceń
last_modified_at: 2022-09-21 20:57:24 +0200
categories:
- Programista rzemieślnik
permalink: /praca-z-linia-polecen/
header:
    teaser: /assets/images/2022/0110-praca-z-linia-polecen/praca_z_linia_polecen_artykul.jpg
    overlay_image: /assets/images/2022/0110-praca-z-linia-polecen/praca_z_linia_polecen_artykul.jpg
    caption: "[&copy; Tianyi Ma](https://unsplash.com/photos/WiONHd_zYI4)"
excerpt: W artykule poznasz kilka cech `bash`'a, które pozwolą Ci na efektywną pracę. Poznasz część mechanizmów rozwijania dostępnych w tym terminalu. Dowiesz się jak można używać historii poleceń i jak możesz ją zmieniać. Przeczytasz też o zmiennych środowiskowych w kontekście procesów. Na końcu artykułu czeka na Ciebie zestaw materiałów dodatkowych, które pomogą Ci pogłębić wiedzę z tego tematu.
---

To jest kolejny artykuł z serii opisujący pracę z linią poleceń. Jeśli jesteś zainteresowany tą tematyką możesz zajrzeć do podobnych artykułów, które zebrałem w sekcji [narzędzia i dobre praktyki]({{ '/narzedzia-i-dobre-praktyki/' }}#narz%C4%99dzia).
{:.notice--info}

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

Poprzednie artykuły, w których opisywałem pracę z wierszem poleceń skupiły się na podstawach. Próbowałem też w nich przemycić trochę wiedzy związanej z systemami operacyjnymi. W jedym z poprzednich artykułów opisałem też [podstawy `bash`'a]({% post_url 2020-09-21-wprowadzenie-do-basha %}). Tym razam chciałbym skupić się na programach i narzędziach, które są przydatne w codziennej pracy.

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

## Podsumowanie

Daj znać w komentarzach jak używasz linii poleceń w swojej codziennej pracy z komputerem. Może pominąłem jakiś program, który Twoim zdaniem do takiej pracy jest niezbędny?
