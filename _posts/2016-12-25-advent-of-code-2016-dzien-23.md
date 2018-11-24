---
title: Advent of Code 2016 dzień 23
date: '2016-12-25 08:37:39 +0100'
categories:
- Strefa zadaniowa
permalink: /advent-of-code-2016-dzien-23/
header:
    teaser: /assets/images/2016/12/aoc_2016_dzien_23_artykul.jpg
    overlay_image: /assets/images/2016/12/aoc_2016_dzien_23_artykul.jpg
    caption: "[&copy; derekl](https://www.flickr.com/photos/derekl/sets/72157649148835567)"
excerpt: Advent of Code 2016 dzień 23. Okazuje się, że język assembunny, dla którego emulator potrzebny był w dniu 12 jest bardziej rozbudowany. Musisz rozszerzyć swój emulator o dodatkową instrukcję.
disqus_page_identifier: 712 http://www.samouczekprogramisty.pl/?p=712
toc: false
---

## Wprowadzenie

{% include aoc-2016-link.md day="23" %}

## Dzień 23 zadanie 1

Dzięki Twojej pomocy wczoraj udało się znaleźć odpowiednie [pary maszyn w klastrze]({% post_url 2016-12-24-advent-of-code-2016-dzien-22 %}). Znajdujesz się na jednym z górnych pięter najwyższego budynku w Kwaterze Głównej Króliczka Wielkanocnego. Prywatne biuro Króliczka znajduje się właśnie tutaj, wraz z sejfem ukrytym za obrazem. Kto nie schowałby cennych dokumentów w sejfie ukrytym właśnie tam?

Sejf ma wyświetlacz cyfrowy i klawiaturę, na której trzeba wpisać odpowiedni kod. Żółta karteczka przyczepiona do sejfu daje wskazówkę dotyczącą hasła: "jajka". Na obrazie z dużym królikiem malującym jajka, doliczyłeś się `7` jajek.

Kiedy próbujesz wpisać kod nic nie pojawia się na ekranie. Zamiast tego klawiatura rozpada się w Twoich rękach. Najwyraźniej została wcześniej zniszczona. Pod spodem ma swego rodzaju gniazdo, takie do którego pasuje Twój [prototypowy komputer]({% post_url 2016-12-13-advent-of-code-2016-dzien-11 %}). Rozmontowując roztrzaskaną klawiaturę wyciągasz układ logiczny ze środka, podłączasz go do swojego komputera, który następie podłączasz do sejfu.

Teraz musisz tylko dowiedzieć się jakie wyjście wyprodukowałaby klawiatura po naciśnięciu odpowiedniego klawisza. Wyciągasz kod assembunny z chipa (wejście do programu).

Kod wygląda, prawie dokładnie jak ten, który użyty był poprzednio do [sterowania kolejką]({% post_url 2016-12-14-advent-of-code-2016-dzien-12 %})! Powinieneś być w stanie użyć tego samego interpretera, którego użyłeś poprzednio. Wymagał on będzie jednak drobnego rozszerzenia o jedną nową instrukcję:

- `tgl x` przełącza instrukcję znajdującą się `x` pozycji dalej, `x` wskazuje na instrukcje podobnie jak `jnz`. Dodatnia wartość oznacza instrukcję z przodu, ujemna z tyłu.

Instrukcja `tgl` działa w następujący sposób:
- dla jednoargumentowych instrukcji, `inc` staje się `dec`, każda inna jednoargumentowa instrukcja staje się `inc`,
- dla dwuargumentowych instrukcji, `jnz` staje się `cpy`, każda inna dwuargumentowa instrukcja staje się `jnz`,
- argumenty przełączanej instrukcji nie są zmieniane,
- jeśli `tgl` próbuje przełączyć instrukcję znajdującą się poza programem, nic się nie dzieje,
- jeśli `tgl` wyprodukuje niepoprawną instrukcje (na przykład `cpy 1 2`) i później interpreter spróbuje wywołać taką instrukcję, powinien ją ominąć,
- jeśli `tgl` przełącza samą siebie (na przykład jeśli `a` ma wartość `0`, `tgl a` przełączy się na `inc a`), wynikowa instrukcja nie jest wywołana dopóki interpreter nie dotrze do niej po raz kolejny.

Na przykład jeśli pod uwagę weźmiesz taki program:

    cpy 2 a
    tgl a
    tgl a
    tgl a
    cpy 1 a
    dec a
    dec a

1. `cpy 2 a` inicjalizuje rejestr `a` wartością 2,
2. pierwsza instrukcja `tgl a` przełącza instrukcję odległą o wartość rejestru `a` (2), w wyniku czego zmienia trzecią instrukcję `tgl a` na `inc a`,
3. druga instrukcja `tgl a` także zmienia instrukcje oddaloną o 2, co zmienia `cpy 1 a` na `jnz 1 a`,
4. czwarta linia, która teraz jest `inc a` zwiększa o jeden `a` do wartości 3,
5. ostatecznie piąta linia, która jest teraz `jnz 1 a` skacze o `a` (3) instrukcji do przodu przeskakując obie instrukcje `dec a`.

W tym przykładzie ostateczna wartość rejestru `a` to 3.

Pozostała część układu scalonego zdaje się ustawiać wartość rejestru `a` na wejście z klawiatury (liczbę jajek z obrazu, 7), uruchamia kod i przesyła wynikową wartość rejestru `a` do sejfu.

Zakładając, że lista poleceń znajduje się w [tym pliku](https://raw.githubusercontent.com/SamouczekProgramisty/StrefaZadaniowaSamouka/master/05_aoc_2016/src/main/test/resources/day23_input.txt), jaka wartość zostanie przesłana do sejfu?

## Podsumowanie

Zachęcam do dalszej zabawy z drugim zadaniem, jego treść pokaże się na stronie AoC2016 po rozwiązaniu pierwszego. Takie zadania pomagają w rozwijaniu umiejętności nie tylko początkujących programistów. Jeśli będziesz miał jakikolwiek problem z rozwiązaniem zadania możesz rzucić okiem do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/05_aoc_2016/src/main/java/pl/samouczekprogramisty/szs/aoc2016/day23), jednak zrób to raczej w ostateczności.

Na koniec mam do Ciebie prośbę - podziel się linkiem do artykułu ze znajomymi, może Oni także będą chcieli pomóc Świętemu Mikołajowi ;) ? Jeśli nie chcesz ominąć kolejnych artykułów proszę zapisz się do mojego newslettera i polub stronę na Facebooku. Do następnego razu!
