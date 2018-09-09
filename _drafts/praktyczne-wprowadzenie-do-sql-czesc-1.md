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
excerpt: W artykule tym przeczytasz o tym czym jest SQL. Poznasz podstawowe rodzaje zapytań. Przeczytasz o tym jak tworzyć tabele. Dowiesz się jak pobierać, dodawać, modyfikować i usuwać dane z bazy danych. W artykule znajdziesz sporo praktycznych ćwiczeń, w których będziesz mógł sprawdzić zdobytą wiedzę.
---

## Elementy SQL

#### Tworzenie tabeli

Wspomniałem już, że DDL to części SQL pozwalająca między innymi na tworzenie tabel w bazie danych. Zapytanie SQL pozwalające na tworzenie tabeli ma format:

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
