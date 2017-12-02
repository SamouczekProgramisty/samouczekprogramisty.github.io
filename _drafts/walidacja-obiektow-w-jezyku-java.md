---
title: Walidacja obiektów w języku Java
categories:
- Kurs aplikacji webowych
permalink: /walidacja-obiektow-w-jezyku-java/
header:
    teaser: /assets/images/2017/12/04_walidacja_obiektow_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2017/12/04_walidacja_obiektow_w_jezyku_java_artykul.jpg
    caption: "[&copy; startupphotos](https://www.flickr.com/photos/120262924@N05/13155237024/sizes/l)"
excerpt: Artykuł opisuje mechanizm walidacji obiektów. Po lekturze tego artykułu dowiesz się czym jest specyfikacja Bean Validation. Poznasz najczęściej używane reguły walidacji. Napiszesz także swoją własnę regułę. Mechanizm walidacji jest powszechnie używany, więc jego znajomość przyda się zarówno w aplikacjach webowych jak i desktopowych.
---

## Specyfikacja _Bean Validation_

Specyfikacja _Bean Validation_ ewoluuje. Wszystko zaczęło się od specyfikacji w wersji [1.0](http://beanvalidation.org/1.0/) wydanej w 2009 roku. Aktualną wersją specyfikacji jest 2.0. Jest ona częścią Java Enterprise Edition 8.0. Dodatkowo implementacji tej specyfikacji można używać w Java SE. Walidacja odbywa się w oparciu o reguły (ang. _constraint_), które stwierdzają, czy dany element jest poprawny.

Specyfikacja pozwala na przypisywanie reguł do obiektów za pomocą adnotacji i XML[^xml]. W dalszej części artykułu opisuję wyłącznie walidację opartą o adnotacje. Proszę spójrz na przykładową klasę z adnotacją do walidacji:

[^xml]: Jeśli chcesz przeczytać więcej o XML zapraszam do [osobnego artykułu]({% post_url 2017-03-02-xml-dla-poczatkujacych %}) na blogu.

```java
```

W ramach specyfikacji udostępniony jest standardowy zestaw reguł. Na przykład "pole nie może być puste" (`@NotNull`), "pole musi mieć minimum X znaków" (`@Min(X)`), "pole musi mieć datę w przyłości" (`@Future`) itd.

### Dlaczego używa się walidacji

Odpowiedź jest prosta ;). Walidacji używa się, aby mieć pewność, że dany obiekt wypełniony jest poprawnymi danymi. Takie podejście pozwala na stosowanie praktyki "Psuj się szybko, psuj się często" (ang. [_Fail fast, fail often_](https://en.wikipedia.org/wiki/Fail-fast)). Można powiedzieć, że programy napisane przy takim założeniu szybko raportują błędy. Dzięki temu łatwiej jest znaleźć potencjalny błąd - informacja o błędzie pochodzi z miejsca jego wystąpiena, a nie z odległego elementu systemu.

Nigdy nie ufaj danym pochodzącym od użytkownika Twojego kodu. Niezależnie czy jest to człowiek czy maszyna. Dane wejściowe trzeba walidować. Zawsze. Zdarza się, że [brak przecinka kosztuje kilka ładnych milionów dolarów](https://www.edn.com/electronics-blogs/edn-moments/4418667/Mariner-1-destroyed-due-to-code-error--July-22--1962). Walidacja danch nie gwarantuje wyeliminowania wszystkich błędów. Pozwala jednak odsiać znaczną ich część.

Dodatkowo walidacja jest czymś powtarzalnym. Mam tu na myśli to, że sposoby walidacji są podobne. Często chcemy sprawdzić czy pole jest wypełnione, czy jest liczbą z odpowiedniego zakresu, czy jest adresem email, itd. Używanie gotowych mechanizmów walidacji pozwala na uniknięcie tej powtarzalnej części pracy.

### Jak działa walidacja

Walidacja to nic innego jak szereg reguł, ograniczeń. Tylko poprawne dane spełniają te ograniczenia. Nakładanie ograniczeń na dane sprowadza się do użycia odpowiednich adnotacji. Proszę spójrz na przykład poniżej:

```java

```

Następnie instancja takiej klasy przekazywana jest do tak zwanego kontekstu walidacji. Nazwijmy go 

## Kiedy używamy automatycznej walidacji

Do tej pory z użyciem specyfikacji _Bean Validation_ spotkałem się głównie w [aplikacjach webowych]({{ "/kurs-aplikacji-webowych/" | absoulute_url }}), bądź takich które używają bazy danych. Specyfikacja nie ogranicza użycia tego mechanizmu w innym przypadku.

### Aplikacje webowe

Wszystkie dane pochodzące od użytkownika *muszą* zostać sprawdzone. Użytkownicy Twojej aplikacji mogą wpisać cuda w formularzu, nie można tym danym do końca ufać. Zatem wszystkie dane przychodzące do aplikacji webowej w formie zapytań HTTP są bardzo często walidowane przy użyciu _bean validation_.

### Obiekty w bazie danych

Mimo tego, że baza danych bardzo często pozwala na podstawową walidację przechowywanych danych nie jest ona wystarczająca. Dodatkowo, poza walidacją przeprowadzaną przez samą bazę danych, używa się _bean validation_. Jest to istotne ponieważ część reguł nie da się wymusić używając wyłącznie mechanizmów bazodanowych. Poza tym szybciej można sprawdzić poprawność danych w kodzie. Wynika to głównie z faktu, że wysłanie zapytania do bazy danych raczej nie jest szybsze niż walidacja przeprowadzona w kodzie.

## Najczęściej używane reguły

- `@NotNull`
- `@Min`
- `@Max`
- `@Email`
- `@Email`

### Dodatkowe zestawy reguł

Jak już wiesz specyfikacja pozwala na proste rozszerzanie listy dostępnych reguł. Oczywiście lista reguł zapewniona przez specyfikację nie jest kompletna. Powstało kilka bibliotek, które grupują inne reguły, które także mogą Ci się przydać:

### Java SE

## Formatowanie komunikatu błędu

Implementacje reguł walidacji zawierają domyślne komunikaty błędu. Komunikaty te przeważnie zaszyte są w kodzie. W większości przypadków komunikaty te są po angielsku


## Własna adnotacja do walidacji

Specyfikacja _Bean Validation_ zezwala na tworzenie własnych walidatorów. Dzięki temu mechanizm ten jest łatwo rozszerzalny. Utworzenie własnego walidatora przeważnie sprowadza się do utworzenia [adnotacji]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}) i implementacji klasy walidatora.

### Implementacja adnotacji

### Implementacja walidatora

Każdy walidator powinien implementować [interfejs]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}) [`ConstraintValidator`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/ConstraintValidator.html). W momencie walidowania danego elementu zostaje wywołana metoda [`isValid`](https://javaee.github.io/javaee-spec/javadocs/javax/validation/ConstraintValidator.html#isValid-T-javax.validation.ConstraintValidatorContext-). To implementacja tej metody będzie decydowała o tym czy dany element jest poprawny.

Spójrz na poniższy przykład:

## Zadanie do wykonania

Napisz program, który pobierze od użytkownika następujące dane:

- imię,
- datę urodzenia w formacie YYYY-MM-dd mm:hh,
- adres email,
- listę tytułów ulubionych książek

Dane te powinny posłużyć do utworzenia instancji obiektu:


Upewnij się, że dane są poprawne używając adnotacji dostępnych w specyfikacji Bean Validation:

- imię powinno mieć długość co najmniej 3 liter,
- imię powinno zaczynać się od wielkiej litery,
- imię powinno składać się wyłącznie z liter,
- data urodzenia powinna być w przeszłości,
- użytkownik powinien mieć co najmniej 4 lata,
- lista tytułów powinna zawierać co najmniej jeden element,
- każdy z tytułów powinien mieć co najmniej 3 znaki.

## Materiały dodatkowe

- [Specyfikacja Bean Validation 2.0](https://jcp.org/aboutJava/communityprocess/final/jsr380/index.html),
- [Artykuł na temat _Fail fast, fail often_](https://www.martinfowler.com/ieeeSoftware/failFast.pdf),
- [Biblioteka rozszerzająca standardowy zestaw reguł](https://github.com/nomemory/java-bean-validation-extension#additional-supported-annotations),

## Podsumowanie
