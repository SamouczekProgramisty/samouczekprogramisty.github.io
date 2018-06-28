---
title: Praktyczne wprowadzenie do SQL .
categories:
- Bazy danych
- Praktyczne wprowadzenie do SQL
permalink: /praktyczne-wprowadzenie-do-sql/
permalink: /praktyczne-wprowadzenie-do-sql-czesc-1/
header:
    teaser: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    overlay_image: /assets/images/2018/03/06_wstep_do_relacyjnych_baz_danych.jpg
    caption: "[&copy; liquene](https://www.flickr.com/photos/liquene/3802773731/sizes/l)"
excerpt: W artykule tym przeczytasz o tym czym jest SQL. Poznasz podstawowe rodzaje zapytań. Przeczytasz o tym jak tworzyć tabele. Dowiesz się jak pobierać, dodawać, modyfikowac i usuwać dane z bazy danych. W artykule znajdziesz sporo praktycznych ćwiczeń, w których będziesz mógł sprawdzić zdobytą wiedzę.
---

{% capture wstep %}
Artykuł ten zakłada, że wiesz czym są relacyjne bazy danych. O podstawach dotyczące tego tematu przeczytasz w ostatnim [artykule opisującym relacyjne bazy danych]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}).

Dodatkowo do ćwiczeń praktycznych będziesz potrzebował bazy danych SQLite. Najnowszą wersję dla Twojego systemu operacyjnego możesz [pobrać ze strony projektu](https://www.sqlite.org/download.html).

Wewnątrz pobranego pliku będzie znajdował się plik wykonywalny `sqlite` (lub `sqlite.exe`). Jest to prosty silnik bazy danych, który obsługuje standard SQL.

Na temat SQL powstają obszerne książki. Artykuł ten nie wyczerpuje tematu, wprowadza jedynie podstawy niezbędne przy pracy z produkcyjnymi projektami.
{% endcapture %}

<div class="notice--info">
  {{ wstep | markdownify }}
</div>


SQL posiada wiele wersji i jest opisywany przez wiele standardów. Najnowszy standard języka SQL to SQL:2003, który został zaktualizowany przez SQL:2006[^aktualny]. Niestety treść standardów nie jest dostępna bezpłatnie. Jeśli będziesz chciał uzupełnić swoją wiedzę to dokumentacja bazy danych, której używasz jest bardzo dobrym źródłem. Popularne bazy danych dokładnie opisują swoją implementację standardu SQL.

[^aktualny]: Stan na 19.03.2018.

W tym artykule postaram się opisać podstawowe elementy, które są wspólne dla różnych silników baz danych. Istnieją drobne różnice pomiędzy językami obsługiwanymi przez różne silniki. Te różne wersje języka SQL nazywa się dialektami.

{% include wspolpraca-infoshare-2018.md %}

## Elementy SQL

### DDL

Zanim pokażę Ci ćwiczenia, na których poznawał będziesz język SQL musisz wiedzieć jak utworzyć, zmodyfikować czy usunąć tabelę. DDL służy także do definiowania innych obiektów bazy danych takich jak indeksy, ograniczenia czy klucze obce. O tych elementach przeczytasz w kolejnej części wprowadzenia do SQL.

#### Tworzenie tabeli

Wspomniałem już, że DDL to części SQL pozwalająca między innymi na tworzenie tabel w bazie danych. Zapytanie SQL pozwalające na tworznie tabeli ma format:

    CREATE TABLE <nazwa tabeli> (
        <nazwa kolumny> <typ kolumny>
    );

Przykładowe zapytanie tworzące tabelę może wyglądać tak:

```sql
CREATE TABLE speakers (
    id number PRIMARY KEY,
    name varchar,
    surname varchar,
    description varchar
);
```

W przykładzie powyżej tworzę tabelę o nazwie `speakers`, która zawiera cztery kolumny. Pierwsza z nich o nazwie `id` zawiera dane liczbowe. Kolumna ta jest [kluczem głównym tabeli]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-główny). Do oznaczenia kolumny, która jest kluczem głównym służą słowa kluczowe `PRIMARY KEY`. Pozostałe trzy kolumny zawierają odpowiednio imię, nazwisko i opis prowadzącego.

Spróbuj uruchomić sqlite i użyć powyższego zapytania do utworzenia tabeli.
{:.notice--info}

Jeśli tabela zawiera [klucz złożony]({% post_url 2018-03-06-wstep-do-relacyjnych-baz-danych %}#klucz-główny) wówczas wszystkie kolumny wchodzące w jego skład są wyszczególnione w osobnej linijce:

```sql
CREATE TABLE other_speakers (
	birth_date date,
	name varchar,
	surname varchar,
	description varchar,
	PRIMARY KEY(birth_date, description)
);
```

#### Modyfikacja tabeli

Istniejące tabele mogą być modyfikowane. Masz możliwość wprowadzenia wielu zmian:

- dodawania kolumn,
- usuwania kolumn,
- dodawania ograniczeń,
- usuwania ograniczeń,
- zmiany wartości domyślnych,
- zmiany typu kolumn,
- zmiany nazw kolumn,
- zmiany nazwy tabeli.

Do modyfikacji tabel służy zapytanie `ALTER TABLE`.

#### Usuwanie tabeli

## Pobieranie krotek

### SELECT

### WHERE

### ORDER BY

## Agregacha wyników

### GROUP BY

### Klauzula `HAVING`

## Tworzenie krotek

## Usuwanie krotek

## SQL a wielkość liter

SQL jest językiem, w którym wielkość liter w słowach kluczowych i identyfikatorach nie ma znaczenia. Wyjątkiem są tu identyfikatory, które są otoczone znakiem cudzysłowu `"`[^zalezy]. Na przykłąd oba poniższe zapytania są równoważne:

[^zalezy]: To zachowanie zależy od silnika bazy danych. Niektóre silnik respektują identyfikatory otoczone `"`, inne nie.

```sql
DELETE FROM speakers WHERE id = 1;
```

```sql
dElEtE frOM speKERs wherE ID = 1;
```

Chociaż wielkość liter nie ma znaczenia, moim zdaniem dobrą praktyką jest pisanie słów kluczowych wielkimi literami. W codziennej pracy także starałem się unikać nadawania nazw, które wymagają otoczenia `"`.
