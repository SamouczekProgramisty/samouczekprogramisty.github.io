---
title: Testy jednostkowe z JUnit 5
categories:
categories:
- Programista rzemieślnik
permalink: /testy-jednostkowe-z-junit5/
header:
    teaser: /assets/images/2018/04/03_projekt_informator_wdrozenie_w_chmurze.jpg
    overlay_image: /assets/images/2018/04/03_projekt_informator_wdrozenie_w_chmurze.jpg
    caption: "[&copy; befuddledsenses](https://www.flickr.com/photos/befuddledsenses/16378019525/sizes/l)"
excerpt: Artykuł ten szczegółowo opisuje sposób wdrożenia aplikacji opartej o Spring i Hibernate w chmurze. W przykładzie używam bazy danych Postgresql i uruchamiam aplikację na Heroku.
---

{% capture intro %}
Nie jest to pierwszy artykuł poświęcony tematyce testów, który napisałem na Samouczku. Zachęcam Cię także do przeczytania poprzednich artykułów:

- [testy jednostkowe z JUnit 4]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}) - artykuł wprowadza w świat testów. Przeczytasz w nim między innymi o tym czym są asercje po co piszemy testy. Jeśli nie pisałeś wczesniej testów to tutaj powinieneś zacząć,
- [_test driven development_ na przykładzie]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}) - artyku o podejściu do pisania testów nazywanym _test driven development_. Opisuję w nim cały cykl _RED, GREEN, REFACTOR_ popierając go przykładami.

W tym artykule będę zakładał, że wiesz czym są testy. W treści artykułu czasami będę porówywał wersję JUnit 5 z poprzednią, jednak znajomość JUnit 4 nie jest niezbędna.
{% endcapture %}

<div class="notice--info">
  {{ intro | markdownify }}
</div>

## Testy jednostkowe z JUnit 5

### Powody powstania JUnit 5

JUnit 4 to monolit. Jeden plik JAR (ang. _Java Archive_), który zawiera całą bibliotekę. Ten plik zawiera między innymi:

- klasy odpowiedzialne za wyszukiwanie testów,
- klasy odpowiedzialna za uruchamianie testów,
- klasy zawierające API do pisania testów (np. `@Test` czy implementacje asercji).

Jak widzisz łamie to jedną z podstawowych reguł dobrego podejścia do tworzenia kodu obiektowego: rób jedną rzecz i rób ją dobrze[^solid]. 

[^solid]: W orginale SRP (ang. _Single Responsibility Principle_) to pierwsza literka z akronimu [SOLID]({% post_url 2017-11-27-programowanie-obiektowe-solid %}).

Poza tym IDE do uruchamiania testów i wyświetlania wyników używały prywatnej implementacji. Między innymi z tych powodów ewolucyjne rozwijanie biblioteki JUnit nie było możliwe. Nawet zmiana niektórych atrybutów powodowała, że IDE błędnie wyświetlało wyniki testów. Z tego powodu powstała inicjatywa rozwijania kolejnej wersji tej biblioteki.

### JUnit 5 jako platforma

JUnit 5 to trzy niezależne komponenty[^podzielone]:

[^podzielone]: Komponenty te są także podzielone na mniejsze elementy dystrybuowane w osobnych plikach JAR.

- platforma do uruchamiania testów: _JUnit Platform_,
- API używane do pisania testów: _JUnit Jupiter_,
- API używane do uruchamia testów napisanych w starszych wersjach JUnit na platformie JUnit 5: _JUnit Vintage_.

Narzędzia, takie jak IDE, które uruchamiają testy używają _JUnit Platform_. Programista w swojej codzienniej pracy używa natomiast _JUnit Jupiter_, czyli samego API, które pozwala na tworzenie testów. To właśnie _JUnit Jupiter_ zawiera adnotacje, których będziesz używał w trakcie pisania testów.

## Pierwszy test jednostkowy z JUnit 5

Projekt będę budował przy użyciu [Gradle]({% post_url 2017-01-19-wstep-do-gradle %}). Przykładowy test będzie służył do sprawdzenia, programu odpowiedzialnego za konwersję jednostek wagi.

```java
public interface WeightUnit {
}
```

```java

```

@Test
@ParameterizedTest
@RepeatedTest
@TestFactory
@TestInstance
@TestTemplate
@DisplayName
@BeforeEach
@AfterEach
@BeforeAll
@AfterAll
@Nested
@Tag
@Disabled
@ExtendWith

## Uruchamianie testów JUnit 5

Jak wspomniałem wyżej różne narzędzia używały wewnętrznego API biblioteki JUnit to uruchamiania i wyświetlania wyników testów. W związku z tym zmiana wersji biblioteki JUnit wymaga taże zmiany w różnych narzędziach. Aby używać JUnit 5 w IDE musi się ono poprawnie integrować z nową wersją biblioteki. Od jakiegoś już czasu główne IDE mają takie wsparcie:

- IntelliJ Idea 2016.2
- Eclipse Oxygen

### JUnit 5 z Gradle

### JUnit 5 w IntelliJ Idea

## Materiały dodatkowe

JUnit 5 ma bardzo dobrą dokumentację. Na YouTube znajdziesz też całkiem sporo prezentacji, które opisują nowe podejście. Poniżej zebrałem dla Ciebie materiały, które są dobrym uzupełnieniem dla treści artykułu:

- [Dokumentacja biblioteki JUnit](https://junit.org/junit5/docs/current/user-guide/),
- [Prezentacja z Devoxx prowadzona przez Lead Developer'a bibltioteki JUnit](https://www.youtube.com/watch?v=0qI6_NKFQsY),
- [JUnit 5 z innej perspektywy, integracja ze Spring 5](https://www.youtube.com/watch?v=-mIrA5cVfZ4),
- [Kampania na Indiegogo sponsorująca rozwój JUnit 5](https://www.indiegogo.com/projects/junit-lambda#/).

## Zadanie do wykonania

Napisz program, który będzie pomagał w prowadzeniu kantoru. Kantor powinien obsługiwać wymianę trzech par walutowych: 
- PLN - EUR,
- PLN - USD,
- EUR - USD.
Właściciel kantoru z góry określa przelicznik referencyjny i spread dla każdej pary walutowej. W bardziej rozwiniętej wersji kantor powinien pobierać przelicznik referencyjny używająć API NBP.
Napisz ten program używając podejścia [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}).

Zachęcam Cię do samodzielnego rozwiązania zadania, wtedy nauczysz się najwięcej. Podziel się linkiem do swojego rozwiązania w komentarzu, jeśli chcesz możesz je porównać z przykładowym rozwiązaniem.

## Podsumowanie

Po lekturze tego artykułu wiesz czym jest JUnit 5. Znasz komponenty składające się na tę bibliotekę. Rozwiązałeś zadanie, które pozwoliło Ci użyć JUnit 5 w praktyce. Od dzisiaj możesz zacząć pisać testy używając wyłącznie JUnit 5 ;).

Jeśli masz jakiekolwiek pytania, proszę zadaj je w komentarzu. Jeśli nie chcesz ominąć kolejnych artykułów na blogu dopisz się do samouczkowego newslettera i polug Samouczka na Facebook'u. Do następnego razu!
