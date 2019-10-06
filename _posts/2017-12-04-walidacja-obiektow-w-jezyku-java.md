---
title: Walidacja obiektów w języku Java
last_modified_at: 2018-07-18 20:43:32 +0200
categories:
- Kurs aplikacji webowych
permalink: /walidacja-obiektow-w-jezyku-java/
header:
    teaser: /assets/images/2017/12/04_walidacja_obiektow_w_jezyku_java_artykul.jpg
    overlay_image: /assets/images/2017/12/04_walidacja_obiektow_w_jezyku_java_artykul.jpg
    caption: "[&copy; startupphotos](https://www.flickr.com/photos/120262924@N05/13155237024/sizes/l)"
excerpt: Artykuł opisuje mechanizm walidacji obiektów. Po lekturze tego artykułu dowiesz się czym jest specyfikacja Bean Validation. Poznasz najczęściej używane reguły walidacji. Napiszesz także swoją własną regułę. Mechanizm walidacji jest powszechnie używany, więc jego znajomość przyda się zarówno w aplikacjach webowych jak i desktopowych.
---

{% capture info_wstep %}
Artykuł ten zakłada, że znasz już podstawy języka Java. Abyś mógł wynieść coś z tego artykułu musisz wiedzieć czym są [adnotacje]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}). Przydatne mogą być też pozostałe artykuły z [kursu programowania w języku Java]({{ "/kurs-programowania-java" | absolute_url }}), szczególnie te dotyczące:
- [interfejsów]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}),
- [typów wyliczeniowych (enumów)]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}),
- [wyjątków]({% post_url 2016-01-31-wyjatki-w-jezyku-java %}).

Przy budowaniu projektu może pomóc też znajomość [Gradle]({% post_url 2017-01-19-wstep-do-gradle %}).
{% endcapture %}

<div class="notice--info">
  {{ info_wstep | markdownify }}
</div>

## Specyfikacja _Bean Validation_

Specyfikacja _Bean Validation_ ewoluuje. Wszystko zaczęło się od specyfikacji w wersji [1.0](http://beanvalidation.org/1.0/) wydanej w 2009 roku. Najnowsza wersja tej specyfikacji to [2.0](http://beanvalidation.org/2.0/). Jest ona częścią Java Enterprise Edition 8. Dodatkowo implementacji tej specyfikacji można używać w Java SE. Walidacja odbywa się w oparciu o reguły (ang. _constraint_), które stwierdzają, czy dany element jest poprawny.

Specyfikacja pozwala na przypisywanie reguł do poszczególnych elementów za pomocą adnotacji i XML[^xml]. W dalszej części artykułu opisuję wyłącznie walidację opartą o adnotacje. Dla uproszczenia skupię się jedynie na zastosowaniu walidacji w Java SE.

Proszę spójrz na przykładową klasę z adnotacjami do walidacji:

[^xml]: Jeśli chcesz przeczytać więcej o XML zapraszam do [osobnego artykułu]({% post_url 2017-03-02-xml-dla-poczatkujacych %}) na blogu.

```java
public class PaidAccount {
    @NotBlank
    @Size(min=3)
    private String owner;

    @Future
    private Date validUntil;

    public PaidAccount(@NotNull @Size(min = 3) String owner, @Future Date validUntil) {
        this.owner = owner;
        this.validUntil = validUntil;
    }

    public String getOwner() {
        return owner;
    }

    public Date getValidUntil() {
        return validUntil;
    }
}
```

W ramach specyfikacji udostępniony jest standardowy zestaw reguł. Na przykład "element nie może mieć wartości `null`" (`@NotNull`), "element musi mieć minimum X znaków" (`@Size(min=X)`), "element musi być datą w przyszłości" (`@Future`) itd. Przykład powyżej używa właśnie tych standardowych adnotacji. Zwróć uwagę, że do jednego elementu można przypisać wiele adnotacji. Na przykład atrybut `owner` posiada adnotacje `@NotBlank` i `@Size`.

### Implementacja specyfikacji

Sama specyfikacja to nie wszystko. Dostarcza ona jedynie API. Zestaw interfejsów, adnotacji, typów wyliczeniowych i wyjątków. Potrzebna jest jeszcze konkretna implementacja tej specyfikacji. W artykule tym będę używał [Hibernate Validator](http://hibernate.org/validator) w wersji 6.0.5. Jest to implementacja referencyjna dla specyfikacji _Bean Validation_ w wersji 2.0. Do projektu mogę ją dodać przez następujący fragment w pliku [`build.gradle`]({% post_url 2017-01-19-wstep-do-gradle %}):


```gradle
dependencies {
    compile group: 'org.hibernate.validator', name: 'hibernate-validator', version: '6.0.5.Final'
    compile group: 'org.glassfish', name: 'javax.el', version: '3.0.1-b08'
}
```

Druga zależność jest wymagana, ponieważ EL ([_Expression Language_](https://jcp.org/en/jsr/detail?id=341)) wykorzystywany jest do formatowania komunikatów błędów.

### Wymagania dotyczące walidacji

Atrybuty, których poprawność będzie sprawdzana, muszą być atrybutami w kontekście specyfikacji _Java Beans_. Innymi słowy dla każdego ze sprawdzanych atrybutów powinna być zaimplementowana metoda dostępowa. Tak zwany "getter". W poprzednim fragmencie kodu są to metody `getOwner` i `getValidUntil`.

Adnotacja dotyczące walidacji można stosować do:

- atrybutów,
- parametrów metody czy konstruktora, na przykład `public PaidAccount(@NotNull owner)`,
- elementów wewnątrz kolekcji, na przykład `List<@NotBlank String> users`,
- wartości zwracanej metody,
- klas.

W przypadku wartości zwracanej metody odpowiednią adnotację przypisuje się do metody dostępowej (gettera). Proszę spójrz na przykład poniżej:

```java
@Future
public Date getValidUntil() {
    return validUntil;
}
```

Adnotacje przypisane do klas używane są wtedy, gdy do stwierdzenia czy dany obiekt jest poprawny potrzebujemy dostępu do wielu atrybutów:

```java
@ZipCodeCityCoherent
public class Address {

    @NotEmpty
    private String zipCode;

    @NotEmpty
    private String postOfficeCity;

    @NotEmpty
    private String street;

    @NotEmpty
    private String number;

    public Address(@NotEmpty String zipCode, @NotEmpty String postOfficeCity, @NotEmpty String street, @NotEmpty String number) {
        this.zipCode = zipCode;
        this.postOfficeCity = postOfficeCity;
        this.street = street;
        this.number = number;
    }

    public String getZipCode() {
        return zipCode;
    }

    public String getPostOfficeCity() {
        return postOfficeCity;
    }

    public String getStreet() {
        return street;
    }

    public String getNumber() {
        return number;
    }
}
```

W przykładzie powyżej użyłem własnej adnotacji `@ZipCodeCityCoherent`. Adnotacja ta pozwala na sprawdzenie czy kod pocztowy i miasto są spójne. O tym jak tworzyć swoje własne adnotacje do walidacji przeczytasz w dalszej części artykułu.

{% include newsletter-srodek.md %}

### Dlaczego używa się walidacji

Odpowiedź jest prosta ;). Walidacji używa się, aby mieć pewność, że dany obiekt wypełniony jest poprawnymi danymi. Takie podejście pozwala na stosowanie praktyki "Psuj się szybko, psuj się często" (ang. [_Fail fast, fail often_](https://en.wikipedia.org/wiki/Fail-fast)). Można powiedzieć, że programy napisane przy takim założeniu szybko raportują błędy. Dzięki temu łatwiej jest znaleźć potencjalny błąd – informacja o błędzie pochodzi z miejsca jego wystąpienia, a nie z odległego miejsca w systemie.

Nigdy nie ufaj danym pochodzącym od użytkownika Twojego kodu. Niezależnie czy jest to człowiek czy maszyna. Dane wejściowe trzeba walidować. Zawsze. Zdarza się, że [brak przecinka kosztuje kilka ładnych milionów dolarów](https://www.edn.com/electronics-blogs/edn-moments/4418667/Mariner-1-destroyed-due-to-code-error--July-22--1962). Walidacja danych nie gwarantuje wyeliminowania wszystkich błędów. Pozwala jednak odsiać znaczną ich część.

Dodatkowo walidacja jest czymś powtarzalnym. Mam tu na myśli to, że sposoby walidacji są podobne. Często chcemy sprawdzić czy pole jest wypełnione, czy jest liczbą z odpowiedniego zakresu, czy jest adresem e-mail, itd. Używanie gotowych mechanizmów walidacji pozwala na uniknięcie tej powtarzalnej części pracy.

### Jak działa walidacja

Walidacja to nic innego jak szereg reguł, ograniczeń. Tylko poprawne dane spełniają te ograniczenia. Nakładanie ograniczeń na dane sprowadza się do użycia odpowiednich adnotacji.

Instancja klasy klasy, którą sprawdzamy, przekazywana jest do tak zwanego walidatora. Walidator interpretuje adnotacje i uruchamia poszczególne reguły walidacji. Walidacja, bez jasno określonej kolejności polega na:
- sprawdzeniu wszystkich "osiągalnych" atrybutów danej instancji,
- sprawdzeniu wszystkich metod dostępowych danej instancji (getterów),
- sprawdzeniu reguł przypisanych do klasy (adnotacje klasy).

Walidacja uruchamiana jest kaskadowo. Proszę spójrz na przykład poniżej:

```java
public class MembershipBonus {

    @Valid
    private PaidAccount userAccount;

    @NotEmpty
    private String bonusName;

    public MembershipBonus(@Valid PaidAccount userAccount, @NotEmpty String bonusName) {
        this.userAccount = userAccount;
        this.bonusName = bonusName;
    }

    public PaidAccount getUserAccount() {
        return userAccount;
    }

    public String getBonusName() {
        return bonusName;
    }
}
```

W przykładzie tym użyta jest adnotacja `@Valid`. Zwraca ona uwagę na to, że instancja klasy `PaidAccount` także musi być sprawdzona pod kątem poprawności. To czy `PaidAccount` jest poprawne czy nie określone jest przez adnotacje wewnątrz tej klasy.

Sprawdzenie reguł odbywa się poprzez uruchomienie metody [`validate`]({{ site.doclinks.javax.validation.Validator }}#validate-T-java.lang.Class...-) na instancji klasy implementującej interfejs [`Validator`]({{ site.doclinks.javax.validation.Validator }}). Biblioteka, która implementuje specyfikację _Bean Validation_ dostarcza odpowiednią klasę.

## Kiedy używamy automatycznej walidacji

Do tej pory z użyciem specyfikacji _Bean Validation_ spotkałem się głównie w [aplikacjach webowych]({{ "/kurs-aplikacji-webowych/" | absoulute_url }}), bądź takich które używają bazy danych. Specyfikacja nie ogranicza użycia tego mechanizmu tylko do tych zastosowań.

### Aplikacje webowe

Wszystkie dane pochodzące od użytkownika *muszą* zostać sprawdzone. Użytkownicy Twojej aplikacji mogą wpisać cuda w formularzu, nie można tym danym do końca ufać. Zatem wszystkie dane przychodzące do aplikacji webowej w formie zapytań HTTP są bardzo często walidowane przy użyciu _Bean Validation_.

### Obiekty w bazie danych

Mimo tego, że baza danych bardzo często pozwala na podstawową walidację przechowywanych danych, nie jest ona wystarczająca. Dodatkowo, poza walidacją przeprowadzaną przez samą bazę danych, używa się _Bean Validation_. Jest to istotne ponieważ część reguł nie da się wymusić używając wyłącznie mechanizmów bazodanowych. Poza tym szybciej można sprawdzić poprawność danych w kodzie. Wynika to głównie z faktu, że wysłanie zapytania do bazy danych raczej nie jest szybsze niż walidacja przeprowadzona w kodzie.

## Najczęściej używane reguły

Jak już wspomniałem specyfikacja zawiera adnotacje określające najczęściej używane reguły walidacji. Część z nich zebrałem dla Ciebie poniżej:

- `@NotNull` – dany element nie może mieć wartości `null`,
- `@NotBlank` – dany element nie może mieć wartości `null` i musi zawierać co najmniej jeden znak (nie może to być spacja, tabulator etc.),
- `@NotEmpty` – dany element nie może mieć wartości `null` i musi zawierać co najmniej jeden znak,
- `@Min(X)` – dany element musi być liczbą i jego wartość musi być większa bądź równa `X`,
- `@Max(X)` – dany element musi być liczbą i jego wartość musi być mniejsza bądź równa `X`,
- `@Email` – dane element musi zawierać poprawny adres e-mail,
- `@Pattern(regexp=X)` – dany element musi pasować do [wyrażenia regularnego]({% post_url 2016-11-28-wyrazenia-regularne-w-jezyku-java %}) `X`.
- `@Size(min=X, max=Y)` – dany element musi mieć rozmiar określony przez elementy adnotacji `min` i `max`. Obie wartości są opcjonalne.

Oczywiście lista reguł zapewniona przez specyfikację nie jest kompletna. Specyfikacja pozwala na rozszerzanie listy dostępnych reguł.

## Java SE i walidacja

Skoro już wiesz czym jest walidacja, to najwyższy czas sprawdzić ją w praktyce. Przykład poniżej pokazuje sposób uruchomienia walidacji w aplikacji Java SE

```java
public class ValidationExample {

    private final Validator validator;

    public ValidationExample() {
        ValidatorFactory validationFactory = Validation.buildDefaultValidatorFactory();
        validator = validationFactory.getValidator();
    }

    public static void main(String[] args) {
        ValidationExample example = new ValidationExample();
        example.showSimpleValidation();
    }

    private void showSimpleValidation() {
        PaidAccount account = new PaidAccount("mp", Calendar.getInstance().getTime());
        Set<ConstraintViolation<PaidAccount>> validationErrors = validator.validate(account);
        for (ConstraintViolation<PaidAccount> validationError : validationErrors) {
            System.out.println(validationError.getPropertyPath().toString() + " " + validationError.getMessage());
        }
    }
}
```

Po uruchomieniu tego programu na konsoli pokażą się następujące komunikaty błędów:

    validUntil must be a future date
    owner size must be between 3 and 2147483647

### Formatowanie komunikatu błędu

Jak widzisz komunikaty błędów nie są po polsku. Wynika to z tego, że domyślne komunikaty dostarczone przez Hibernate Validator są w języku angielskim. Niestety biblioteka aktualnie nie zawiera polskich komunikatów. Możesz to zmienić.

#### Komunikaty błędów zaszyte w kodzie

Sposób ten nie jest zalecany! Generalnie niezbyt dobrą praktyką jest umieszczanie tekstu w kodzie źródłowym programu. Doskonale do tego nadają się za to pliki `properties`, które opisałem poniżej.
{: .notice--warning}

Modyfikując nieznacznie klasę z adnotacjami możemy wymusić inne komunikaty błędów:

```java
@NotNull(message="nie może być puste")
@Size(min=3, message="musi być dłuższe niż {min}")
private String owner;

@Future(message="musi być w przyszłości")
private Date validUntil;
```

Po takiej modyfikacji na konsoli pokażą się następujące komunikaty błędów:

    validUntil musi być w przyszłości
    owner musi być dłuższe niż 3

#### Komunikaty błędów w plikach [`properties`](https://en.wikipedia.org/wiki/.properties)

Pliki z rozszerzeniem `properties` to pliki tekstowe. Zawierają one zbiór wierszy w postaci `klucz=wartość`. Pliki te nadają się do przechowywania komunikatów błędów.

Domyślna implementacja w kodzie ma zaszyty wyłącznie `klucz` komunikatu błędu. Na przykład:

```java
public @interface Size {
    String message() default "{javax.validation.constraints.Size.message}";
    //...
}
```

Przyjęło się, że klucz ma postać `<pakiet>.<nazwa_klasy>.<nazwa_atrybutu>`. W powyższym przykładzie jest to `javax.validation.constraints.Size.message`. Następnie klucz ten wraz z wartością umieszcza się w pliku `ValidationMessages.properties`. Plik ten jest odczytywany przez implementację _Bean Validation_. Znalezione tam wartości użyte są do budowania komunikatów błędów.

Plik `ValidationMessages.properties` umieść w katalogu projektu `src/main/resources`:

    javax.validation.constraints.Size.message=musi być dłuższe niż {min}
    javax.validation.constraints.NotNull.message=nie może być puste
    javax.validation.constraints.Future.message=musi być w przyszłości

{% capture kodowanie %}
Niestety pliki `properties` do wersji 8 języka są "dziwne". Mam tu na myśli to, że domyślnym kodowaniem z jakim są one czytane jest ISO-8859-1. W związku z tym możesz zobaczyć na konsoli:

    validUntil musi byÄ w przyszÅoÅci
    owner musi byÄ dÅuÅ¼sze niÅ¼ 3

Te magiczne znaczki to nic innego ja próba interpretowania pliku `properties` zapisanego przy pomocy kodowania UTF-8 przez Javę stosując kodowanie ISO-8859-1. IntelliJ Idea pozwala na ustawienie kodowania plików `properties`. Możesz to zrobić w menu File -> Settings -> Editor -> File encodings. Istotne jest abyś ustawił ich kodowanie na ISO-8859-1 i zaznaczył opcję "Transparent native-to-ascii conversion".

Przy takim ustawieniu możesz tworzyć pliki properties w normalny sposób. IntelliJ pod spodem zrobi za Ciebie odpowiednią konwersję znaków. Na przykład powyższy plik `properties` przerobiony przez IntelliJ wygląda następująco:

    javax.validation.constraints.Size.message=musi być dłuższe niż {min}
    javax.validation.constraints.NotNull.message=nie może być puste
    javax.validation.constraints.Future.message=musi być w przyszłości

Java 9 [rozwiązuje](http://openjdk.java.net/jeps/226) ten problem przez ustawienie domyślnego kodowania na UTF-8 co dużo lepiej odpowiada obecnym standardom.
{% endcapture %}

<div class="notice--info">
  {{ kodowanie | markdownify }}
</div>

#### Szablon formatów błędu

Celem tego artykułu nie jest wyjaśnianie _Expression Language_, ma on dużo większe możliwości. Ten podpunkt ma Ci tylko pomóc zrozumieć użycie EL w komunikatach błędów.
{: .notice--info}

Zauważyłeś użycie `{min}` wewnątrz komunikatu błędu? To właśnie język EL. To właśnie ten element, który zmusił mnie do dodania dodatkowej zależności w pliku `build.gradle`. Składnia `{zmienna}` pozwala na odwołanie się do elementu adnotacji. W naszym przypadku jest to element `min`. W wynikowym komunikacie błędu znalazła się wartość 3 – wartość elementu `min`.

Te same szablony użyte są do odwołania się do wartości komunikatu błędu z plików `properties`.

## Własna adnotacja do walidacji

Specyfikacja _Bean Validation_ zezwala na tworzenie własnych reguł walidacji. Dzięki temu mechanizm ten jest łatwo rozszerzalny. Utworzenie własnej reguły przeważnie sprowadza się do utworzenia [adnotacji]({% post_url 2016-10-03-adnotacje-w-jezyku-java %}) i implementacji klasy sprawdzającej.

### Implementacja adnotacji

Poniższy przykład pokazuje adnotację, którą użyłem w jednym z powyższych fragmentów kodu. Służy ona do sprawdzenia czy atrybut klasy zawierający kod pocztowy pasuje do atrybutu zawierającego miasto:

```java
@Target(TYPE)
@Retention(RUNTIME)
@Constraint(validatedBy = ZipCodeCityCoherentValidator.class)
public @interface ZipCodeCityCoherent {
    String message() default "{pl.samouczekprogramisty.misc.validation.ZipCodeCityCoherent.message}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
```

Adnotacja ta może być przypisana wyłącznie do klasy `@Target(TYPE)`. `@Retention(RUNTIME)` określa, że informacja o adnotacji ma być widoczna w trakcie uruchomienia programu. Dodanie do naszej adnotacji `@Constraint(validatedBy = ZipCodeCityCoherentValidator.class)` sprawia, że jest ona "widoczna" przez _Bean Validation_. W tym miejscu określiłem też klasę, która będzie wywołana aby przeprowadzić właściwą walidację. W tym przypadku jest to klasa `ZipCodeCityCoherentValidator`.

Ciało adnotacji zawiera trzy elementy. Są to odpowiednio `message`, `groups` i `payload`. Komunikat błędu jest przechowywany w elemencie `message`. W tym przypadku jest to odwołanie do zawartości pliku `properties`:

    pl.samouczekprogramisty.misc.validation.ZipCodeCityCoherent.message=miasto nie pasuje do kodu pocztowego

Elementy `groups` i `payload` są wymagane. Ich zastosowanie pominę, artykuł i tak jest wystarczająco długi ;).

Skoro mamy już adnotację nadszedł czas na implementację klasy sprawdzającej.

### Implementacja klasy sprawdzającej

Każda klasa sprawdzająca powinien implementować [interfejs]({% post_url 2015-12-16-interfejsy-w-jezyku-java %}) [`ConstraintValidator`]({{ site.doclinks.javax.validation.ConstraintValidator }}). W momencie walidowania danego elementu zostaje wywołana metoda [`isValid`]({{ site.doclinks.javax.validation.ConstraintValidator }}#isValid-T-javax.validation.ConstraintValidatorContext-). To implementacja tej metody będzie decydowała o tym czy dany element jest poprawny.

```java
public class ZipCodeCityCoherentValidator implements ConstraintValidator<ZipCodeCityCoherent, Address> {
	@Override
	public boolean isValid(Address address, ConstraintValidatorContext context) {
		return "00-000".equals(address.getZipCode()) && "Warszawa".equals(address.getPostOfficeCity());
	}
}
```

W powyższym przykładzie implementacja jest strasznie naiwna, masz pomysł jak obsłużyć więcej kombinacji miast/kodów pocztowych?

## Zadanie do wykonania

Napisz program, który pobierze od użytkownika następujące dane:

- imię,
- datę urodzenia w formacie YYYY-MM-dd mm:hh,
- adres e-mail.

Utwórz klasę grupującą te dane. Upewnij się, że są one poprawne używając adnotacji dostępnych w specyfikacji _Bean Validation_ bądź własnych:

- imię powinno mieć długość co najmniej 3 liter,
- imię powinno zaczynać się od wielkiej litery,
- imię powinno składać się wyłącznie z liter,
- data urodzenia powinna być w przeszłości,
- użytkownik powinien mieć co najmniej 4 lata.

Przygotowałem dla Ciebie [przykładowe rozwiązanie](https://github.com/SamouczekProgramisty/MaterialyRozne/tree/master/04_bean_validation/src/main/java/pl/samouczekprogramisty/misc/validation/exercise), jednak jak zwykle zachęcam Cię do samodzielnego rozwiązania zadania.

## Materiały dodatkowe

- [Specyfikacja Bean Validation 2.0]({{ site.doclinks.specs.validation20 }}),
- [Artykuł na temat _Fail fast, fail often_](https://www.martinfowler.com/ieeeSoftware/failFast.pdf),
- [Biblioteka rozszerzająca standardowy zestaw reguł](https://github.com/nomemory/java-bean-validation-extension#additional-supported-annotations),
- [Fragment tutoriala dla Java EE 7 opisujący walidację](https://docs.oracle.com/javaee/7/tutorial/bean-validation001.htm),
- [Strona projektu Hibernate Validator](http://hibernate.org/validator/),
- [Kod źródłowy przykładów użytych w artykule](https://github.com/SamouczekProgramisty/MaterialyRozne/tree/master/04_bean_validation).

## Podsumowanie

Po lekturze artykułu wiesz już czym jest walidacja. Masz świadomość dlaczego jest ona istotna. Potrafisz użyć walidacji w swojej aplikacji używając dostępnych reguł walidacji. Umiesz też zaimplementować swoje własne reguły. Ćwiczenie, które wykonałeś pozwoliło Ci sprawdzić tę wiedzę w praktyce. Gratulacje! ;)

Jeśli nie chcesz pominąć kolejnych artykułów na Samouczku proszę dopisz się do samouczkowego newslettera i polub stronę na Facebooku. Jeśli cokolwiek nie będzie dla Ciebie jasne zadaj pytanie w komentarzu, postaram się pomóc. Do następnego razu!
