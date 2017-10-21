---
title: Wyrażenia regularne część 2
date: '2017-01-06 10:51:29 +0100'
categories:
- Kurs programowania Java
permalink: /wyrazenia-regularne-czesc-2/
header:
    teaser: /assets/images/2017/01/06_wyrazenia_regularne_2_artykul.jpg
    overlay_image: /assets/images/2017/01/06_wyrazenia_regularne_2_artykul.jpg
    caption: "[&copy; roel1943](https://www.flickr.com/photos/roel1943/13961916635/sizes/l)"
excerpt: Czas na kolejną odsłonę artykułu o wyrażeniach regularnych. W tej części przeczytasz o grupach nazwanych, alternatywie, ponownym użyciu grup w wyrażeniu czy kotwicach. Dowiesz się dlaczego wyrażenia regularne są zachłanne i jak to zachowanie wyłączyć. Innymi słowy czeka na Ciebie kolejna solidna porcja wiedzy na temat wyrażeń regularnych. Na koniec jak zwykle całość będziesz mógł przećwiczyć rozwiązując kilka przykładowych zadań. Zapraszam!
disqus_page_identifier: 731 http://www.samouczekprogramisty.pl/?p=731
---

{% include toc %}

{% capture notice-text %}
To jest drugi artykuł na temat wyrażeń regularnych. Część zagadnień związanych z wyrażeniami regularnymi opisana jest w [pierwszej części]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}):

 - czym są wyrażenia regularne,
 - kiedy używamy wyrażeń regularnych, praktyczne wskazówki,
 - API wyrażeń regularnych w języku Java,
 - obsługa powtórzeń (`+`, `*`, `?`, `{}`),
 - klasy znaków (`.`, `[]`, `\d`, `\w`, itd.),
 - grupy (`()`),
 - wsparcie IDE dla wyrażeń regularnych.

Zachęcam do przeczytania pierwszej części jeśli chciałbyś dowiedzieć się czegoś więcej o punktach wspomnianych powyżej. Tutaj bez zbędnego wstępu przejdę do konkretów. Na pierwszy ogień idzie zachłanność wyrażeń regularnych.
{% endcapture %}

<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

## Zachłanność wyrażeń regularnych

Wyrażenia regularne są zachłanne. Oznacza to tyle, że wyrażenie regularne dopasuje największą możliwą część łańcucha znaków, która pasuje do wzorca. Najłatwiej będzie to zobaczyć na przykładzie.

```java
@Test
public void shouldBeGreedy() {
    Pattern pattern = Pattern.compile("<(.+)>");
    Matcher matcher = pattern.matcher("<em>some emphasized text</em>");
    assertTrue(matcher.find());
    assertEquals("em>some emphasized text</em", matcher.group(1));
}
```

Powyżej widzisz standardowy przykład wykorzystywany do pokazania tej właściwości wyrażeń regularnych. Tekst, który chcemy dopasować jest kodem HTML zawierającym znacznik `<em>`[^em]. Załóżmy, że chciałbyś wyciągnąć nazwę znacznika znajdującego się pomiędzy `<` i `>`.

[^em]: Znacznik ten służy do wyróżnienia tekstu na stronie www.

Okazuje się, że wyrażenie regularne użyte w przykładzie powyżej nie zadziała tak jakbyś tego chciał. Zgodnie z tym co opisałem wcześniej dopasuje najwięcej tekstu jak to tylko możliwe zatem w grupie `(.+)` znajdzie się `em>some emphasized text</em`.

Istnieje standardowy sposób na obejście tego typu zachowania, możesz zastosować tutaj negację grupy znaków. Wyrażenie regularne `<([^>]+)>` dopasuje wszystko co znajduje się pomiędzy `<` `>` i nie jest znakiem `>`.

```java
@Test
public void shouldBeAbleToCheatGreadiness() {
    Pattern pattern = Pattern.compile("<([^>]+)>");
    Matcher matcher = pattern.matcher("<em>some emphasized text</em>");
    assertTrue(matcher.find());
    assertEquals("em", matcher.group(1));
}
```

Wyrażenia regularne działają w ten sposób, ponieważ mechanizm do obsługi powtórzeń jest zachłanny. Symbole powtórzeń `{}`, `?`, `*` czy `+` dopasowują zawsze najwięcej jak tylko się da.

Istnieje jednak przełącznik, który zmienia to zachowanie. Jest to znak `?`. Znów najlepiej będzie przeanalizować całość na przykładzie:

```java
@Test
public void shouldTurnOffGreedinessForPlus() {
    Pattern pattern = Pattern.compile("<(.+?)>");
    Matcher matcher = pattern.matcher("<em>some emphasized text</em>");
    assertTrue(matcher.find());
    assertEquals("em", matcher.group(1));
}
```

Jak widzisz, tym razem `.+` nie pochłonął nam prawie całego łańcucha. Grupa zawiera najmniej tekstu jak to możliwe. W posobny sposób `?` wyłącza zachłanność dla `*`:

```java
@Test
public void shouldTurnOffGreedinessForAsterix() {
    Pattern pattern = Pattern.compile("<(.*?)>");
    Matcher matcher = pattern.matcher("<em>some emphasized text</em>");
    assertTrue(matcher.find());
    assertEquals("em", matcher.group(1));
}
```

Z kolei w przykładzie poniżej pokazałem jak `?` wpływa na `{}`. Chociaż wyrażenie mogłoby dopasować cały łańcuch znaków, w grupie znajdują się wyłącznie pierwsze trzy znaki (ponieważ `{}` nie jest tu zachłanny).

```java
@Test
public void shouldTurnOffGreadinessForCurlyBraces() {
    Pattern pattern = Pattern.compile("(.{3,5}?)");
    Matcher matcher = pattern.matcher("12345");
    assertTrue(matcher.find());
    assertEquals("123", matcher.group(1));
}
```

## Alternatywa

Załóżmy, że program, który piszesz musi przetworzyć zestaw instrukcji dla samochodu, którym kieruje. Niektóre z instrukcji mówią w którą stronę należy skręcić
- skręć w prawo,
- skręć w lewo.

Aby przy pomocy jednego wyrażenia regularnego dopasować obie instrukcje możesz użyć alternatywy. Spójrz na przykład poniżej:

```java
@Test
public void shouldParseAlternative() {
    Pattern pattern = Pattern.compile("skręć w (prawo|lewo)");
    Matcher matcher = pattern.matcher("skręć w lewo");
    assertTrue(matcher.find());
    assertEquals("lewo", matcher.group(1));

    matcher = pattern.matcher("skręć w prawo");
    assertTrue(matcher.find());
    assertEquals("prawo", matcher.group(1));
}
```

Jak widzisz, wewnątrz grupy użyłem tam znaku `|`. Znak ten jest jednym ze znaków specjalnych. Jeśli występuje wewnątrz wyrażenia regularnego oznacza, że łańcuch znaków pasuje do wyrażenia regularnego jeśli pasuje do części znajdującej się przed znakiem `|` lub do części znajdującej się po znaku `|`.

Jeśli chcesz ograniczyć zakres alternatywy użyj nawiasów jak w przykładzie powyżej, w takim przypadku alternatywa dopasuje to co znajduje się po lewej stronie znaku `|` do `(`, lub po prawej stronie znaku `|` do `)`.

Możesz też użyć alternatywy do dopasowania więcej niż dwóch elementów oddzielając każdy z nich znakiem `|` jak w przykładzie poniżej:

```java
@Test
public void shouldPickOneFromMultipleAlternatives() {
    Pattern pattern = Pattern.compile("pies|kot|lew");
    Matcher matcher = pattern.matcher("lew");
    assertTrue(matcher.matches());
    assertEquals("lew", matcher.group());
}
```

## Grupy nieprzechwytujące

Mechanizm wyrażeń regularnych domyślnie zapamiętuje grupy, które zostały użyte w wyrażeniu regularnym. Tak zapamiętane grupy są później dostępne za pośrednictwem metody `group`. W większości przypadków jest to pożądane zachowanie, jednak czasami to co wyląduje w grupie nie jest dla Ciebie interesujące.

W takich przypadkach możesz użyć grupy, która nie zostanie zapamiętana. Grupa nie będzie przechwytująca jeśli pierwszymi znakami wewnątrz grupy będą `?:`. Proszę spójrz na przykład poniżej:

```java
@Test
public void shouldUseNonCapturingGroups() {
    Pattern pattern = Pattern.compile("(?:Ala|Ola) ma (kota|psa)");
    Matcher matcher = pattern.matcher("Ola ma psa");
    assertTrue(matcher.matches());
    assertEquals("psa", matcher.group(1));
}
```

W przykładzie tym nie interesuje nas właścicielka zwierzaka. Za to sam zwierzak jest ważny. W wyrażeniu tym użyte są dwie grupy, pierwsza nieprzechwytująca i druga, która zawiera zwierzaka.

## Grupy nazwane

Grupy, których użyjemy w wyrażeniu regularnym możemy też nazwać. W takim przypadku do zawartości takiej grupy możemy odwoływać się w standardowy sposób, czyli używając indeksu, który już znasz lub poprzez nazwę. Spójrz na przykład poniżej, w którym poszczególne elementy daty zapamiętane są w nazwanych grupach:

```java
@Test
public void shouldUseNamedGroups() {
    Pattern pattern = Pattern.compile("(?<day>\\d{2})\\.(?<month>\\d{2})\\.(?<year>\\d{4})");
    Matcher matcher = pattern.matcher("04.01.2017");
    assertTrue(matcher.matches());
    assertEquals("04", matcher.group("day"));
    assertEquals("04", matcher.group(1));
    assertEquals("2017", matcher.group("year"));
    assertEquals("2017", matcher.group(3));
}
```

Jak widziałeś w przykładzie grupy nazwane mają `?<nazwa>` wewnątrz grupy. Następnie używając `nazwa` możemy dostać się do zawartości danej grupy używając metody `group`.

## Ponowne użycie grup w wyrażeniu

Tutaj ponownie posłużę się przykładem znaczników HTML. Załóżmy, że mamy następujący kod HTML `<p>Some paragraph <em>emphasized</em></p><p>Other paragraph</p>`. Jak mógłbyś wyciągnąć tekst znajdujący się wewnątrz pary znaczników? Na przykład to co znajduje się wewnątrz pierwszej pary `<p>` i `</p>`?

Z pomocą przychodzi tu mechanizm ponownego użycia grup wewnątrz wyrażenia regularnego. Spójrz proszę na przykład:

```java
@Test
public void shouldReuseGroupsInsideRegexp() {
    Pattern pattern = Pattern.compile("<(.+?)>(.+?)</\\1>");
    Matcher matcher = pattern.matcher("<p>Some paragraph <em>emphasized</em></p><p>Other paragraph</p>");
    assertTrue(matcher.find());
    assertEquals("p", matcher.group(1));
    assertEquals("Akapit tekstu <em>coś innego</em>", matcher.group(2));
}
```

Jak widzisz, na samym końcu wyrażenia znajduje się \1. Jest to nic innego jak odwołanie się do pierwszej grupy, która została dopasowana. W naszym przypadku jest to p. Podobnie możesz używać kolejnych grup używając kolejnych indeksów.

## Kotwice

Nadszedł czas na kotwice. Kotwice to znaki specjalne w wyrażeniach regularnych. Kotwice służą do przekazania informacji o tym gdzie chcemy szukać dopasowania w danym łańcuchu znaków.

Na przykład do wyrażenia regularnego `c$` pasują łańcuchy znaków `abc` czy `bac` ale nie pasuje `cab`. Innymi słowy `c$` mówi, że „`c` powinno wystąpić na końcu łańcucha znaków”. Istnieje kilka kotwic, poniżej pokażę Ci te dwie najczęściej używane:

- `^` oznacza początek łańcucha znaków,
- `$` oznacza koniec łańcucha znaków.


Kotwice są bardzo często używane w przypadku walidacji danych wejściowych od użytkownika. Na przykład jeśli chcemy mieć pewność, że użytkownik wprowadził tylko liczby możemy użyć wyrażenia z `^` i `$`.

Oczywiście można też wykorzystać metodę `matches` zamiast `find`. Różnicę pomiędzy zachowaniem tych metod wraz z użyciem kotwic pokazałem w przykładzie poniżej:

```java
@Test
public void shouldShowDifferenceBetweenFindAndMatches() {
    Pattern pattern = Pattern.compile("\\d+");
    Matcher matcher = pattern.matcher("abc123def");
    assertTrue(matcher.find());
    assertFalse(matcher.matches());
}

@Test
public void shouldShowDifferenceBetweenFindAndMatchesWithAncors() {
    Pattern pattern = Pattern.compile("^\\d+$");
    Matcher matcher = pattern.matcher("abc123def");
    assertFalse(matcher.find());
    assertFalse(matcher.matches());
}
```

## Zadanie do wykonania

W ramach zadania do wykonania aby przećwiczyć wyrażenia regularne w praktyce odeślę Cię do zadań z Advent of Code 2016. Poniżej jest lista zadań, w których możesz użyć wyrażeń regularnych. Są tam zadania o różnym poziomie trudności, na pewno znajdziesz coś dla siebie. Każde z tych zadań zawiera także przykładowe rozwiązanie:
- [dzień 4]({% post_url 2016-12-06-advent-of-code-2016-dzien-4 %}),
- [dzień 8]({% post_url 2016-12-11-advent-of-code-2016-dzien-8 %}),
- [dzień 10]({% post_url 2016-12-12-advent-of-code-2016-dzien-10 %}),
- [dzień 12]({% post_url 2016-12-14-advent-of-code-2016-dzien-12 %}),
- [dzień 21]({% post_url 2016-12-23-advent-of-code-2016-dzien-21 %}).

## Dodatkowe materiały do nauki

Zbiór linków z dodatkowymi materiałami do nauki zebrałem w [pierwszej części artykułu]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}), jeśli chcesz dowiedzieć się więcej na temat wyrażeń regularnych zapraszam do tamtego zbioru. Jeśli chcesz, możesz także przeglądać kod źródłowy przykładów z tego artykułu, wszystkie przykłady dostępne są na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/24_wyrazenia_regularne/src/test/java/pl/samouczekprogramisty/kursjava/regexp).

## Podsumowanie

Po obu artykułach na temat wyrażeń regularnych i rozwiązaniu zadań możesz śmiało powiedzieć, że używałeś wyrażeń regularnych w praktyce :). Poznałeś większość mechanizmów dostępnych w wyrażeniach regularnych. Jednak musisz wiedzieć, że to nadal nie wszystko. Znajomość wyrażeń regularnych na poziomie opisanym w obu artykułach w zupełności wystarczy Ci do codziennej pracy.

Mam nadzieję, że ta dwuczęściowa seria przypadła Ci do gustu. Jeśli tak proszę podziel się artykułem ze znajomymi. Zależy mi na dotarciu do jak największej liczby czytelników, możesz mi w tym pomóc. Jeśli nie chcesz pominąć kolejnych artykułów zapisz się do mojego newslettera i polub stronę na facebooku. Do następnego razu!
