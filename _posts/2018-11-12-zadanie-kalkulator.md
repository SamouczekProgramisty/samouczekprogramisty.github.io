---
title: Samouczek na rozmowie – kalkulator
last_modified_at: 2019-08-27 21:50:35 +0200
categories:
- Samouczek na rozmowie
- Strefa zadaniowa
permalink: /samouczek-na-rozmowie-kalkulator/
header:
    teaser: /assets/images/2018/11/12_zadanie_z_rozmowy_kwalifikacyjnej_kalkulator.jpg
    overlay_image: /assets/images/2018/11/12_zadanie_z_rozmowy_kwalifikacyjnej_kalkulator.jpg
    caption: "[&copy; Alexas_Fotos](https://pixabay.com/en/resulta-7-old-abacus-antique-1767631/)"
excerpt: W tym artykule rozkładam na części pierwsze zadanie podesłane przez Łukasza. Po lekturze tego artykułu będziesz wiedzieć na co zwracać uwagę przy rozwiązywaniu tego typu zadań na rozmowach kwalifikacyjnych. Pokażę Ci też jak _Test Driven Development_ pozwala na tworzenie przejrzystego i czytelnego kodu.
---


{% include samouczek-na-rozmowie.md %}

W artykule tym pokazuję kolejne zadanie, które nie jest algorytmiczne. W tym przypadku zadanie ma sprawdzić głównie umiejętność pisania kodu wysokiej jakości.

W artykule dotyczącym [zadania z zagnieżdżoną strukturą]({% post_url 2018-08-26-zadanie-zagniezdzona-struktura %}) dokładnie opisywałem moje podejście do rozwiązania tego typu zadań. Zachęcam Cię do przeczytania tego artykułu. Poniżej tylko krótkie przypomnienie wskazówek, które tam zebrałem:

- w przypadku niepełnego opisu zadania załóż coś. W rozwiązaniu zadania opisz swoje założenia,
- staraj się zawsze dostarczać testy automatyczne razem ze swoim rozwiązaniem, nawet jeśli nie są wymagane,
- dokumentuj swój kod tam gdzie jest to niezbędne, używanie docstring'ów może być dobrym rozwiązaniem.

## Zadanie do wykonania

Wiesz już, że dzisiejsze zadanie podesłał mi jeden z Czytelników – Łukasz (jeszcze raz wielkie dzięki). Łukasz dostał następujące instrukcje:

> Przygotowanie kompletnego rozwiązania powinno zająć około dwóch godzin. Dostarczone rozwiązanie powinno mieć jakość, którego możemy się spodziewać w trakcie normalnej pracy. Używanie narzędzi do budowania jest mile widziane, nie jest to wymóg konieczny. Dostarczenie testów jednostkowych także nie jest wymagane, jednak jest mile widziane i będzie wzięte pod uwagę podczas oceniania zadania. Rozwiązanie powinno zawierać także instrukcję jak uruchomić zadanie z linii poleceń. Rozwiązanie może założyć, że dane wejściowe są w poprawnym formacie. W przypadku niejasnych wymagań przyjęte założenia powinny być dostarczone razem z rozwiązaniem. Dopuszczalne jest użycie zewnętrznych bibliotek. Należy je dołączyć do dostarczonego rozwiązania. Jakość dostarczonego kodu jest równie istotna jak dostarczenie działającego rozwiązania.

Poza ogólną instrukcją dostał także oczywiście treść zadania do wykonania:

> Napisz program, który zwróci wynik otrzymany na podstawie zestawu instrukcji. Instrukcje składają się ze słowa kluczowego i liczby oddzielonych spacją. Instrukcje oddzielone są znakiem nowej linii.
Zestaw instrukcji pobierany jest z pliku, a wynik obliczeń powinien być wypisany na ekranie. Plik może zawierać dowolną liczbę instrukcji. Instrukcje mogą być dowolną operacją przyjmującą dwa argumenty (np. `add`, `subtract`, `multiply`, `divide` itp.). Instrukcje powinny być interpretowane w kolejności wprowadzenia (kolejność operacji w matematyce powinna być ignorowana). Ostatnią instrukcją powinna być `apply` i liczba. Na przykład `apply 3`. Ta liczba powinna być użyta w trakcie tworzenia instancji kalkulatora. Następnie kalkulator powinien wykonać po kolei wszystkie wcześniej podane operacje.

Tutaj pracodawca zachował się wzorowo, dostarczając dodatkowo przykłady działania programu:

> wejście:<br/>
> `add 2`<br/>
> `multiply 3`<br/>
> `apply 10`<br/>
> wyjście: 36<br/>
> wyjaśnienie: ((10 + 2) * 3) = 36

> wejście: <br/>
> `multiply 3` <br/>
> `add 2` <br/>
> `apply 10`<br/>
> wyjście: 32<br/>
> wyjaśnienie: ((10 * 3) + 2) = 32

> wejście:<br/>
> `apply 1`<br/>
> wyjście: 1

## Pochwała dla pracodawcy

Często w artykułach w tej serii wspominam o dobrych praktykach, które warto stosować przy rozwiązywaniu zadań tego typu. Przytoczyłem część z nich na początku tego artykułu.

W tym przypadku pracodawca w treści zadania dokładnie je wypunktował. Z mojego punktu widzenia pracodawca, który dokładnie opisuje zadanie do wykonania i z góry odpowiada na pytania, które mogą się pojawić ma dużego plusa.

Jeśli zobaczysz tak opisane zadanie, to moim zdaniem masz do czynienia z firmą, która ma doświadczenie w rekrutowaniu programistów przy pomocy zadań tego typu.

{% include newsletter-srodek.md %}

## Rozwiązanie zadania

Zadanie rozwiązałem używając [TDD]({% post_url 2016-11-21-test-driven-development-na-przykladzie %}). Starałem się dodawać zmiany po każdym cyklu. Patrząc w historię repozytorium[^kurs] możesz zobaczyć jak rozwijał się kod. Zanim jednak zajrzysz do [przykładowego rozwiązania](https://github.com/SamouczekProgramisty/StrefaZadaniowaSamouka/tree/master/11_abacus/src) zachęcam Cię do samodzielnej próby rozwiązania tego zadania. Wtedy nauczysz się najwięcej.

[^kurs]: Jeśli nie wiesz czym jest repozytorium zapraszam Cię do [kursu Git'a]({{ '/kurs-git/' | absolute_url }}) :)

Muszę też zaznaczyć, że moje rozwiązanie nie zadziała w przypadku gdy lista poleceń będzie bardzo długa. Dzieje się tak, ponieważ wczytuję całą listę instrukcji do pamięci przed rozpoczęciem jakichkolwiek obliczeń. Bardzo długa lista poleceń skończyłaby się wówczas wyjątkiem [`OutOfMemoryError`]({{ site.doclinks.java.lang.OutOfMemoryError }}).

Obejściem tego problemu byłoby przeczytanie odpowiedniej ilości danych z końca pliku (żeby znaleźć instrukcję `apply`). Przy takim podejściu [złożoność pamięciowa]({% post_url 2017-11-13-podstawy-zlozonosci-obliczeniowej %}) programu wynosiłaby Ο(1), a nie Ο(n).

### Dopuszczalne operacje

W moim rozwiązaniu wszystkie dopuszczalne operacje zdefiniowałem jako elementy [typu wyliczeniowego]({% post_url 2016-09-09-typ-wyliczeniowy-w-jezyku-java %}). Posłużyłem się tutaj także odwołaniem do metod w klasie `BigDecimal`. Ten mechanizm opisałem dokładnie w artykule na temat [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}#odwo%C5%82ywanie-si%C4%99-do-metod-bez-podania-instancji):

```java
public enum Operation {

    ADD(BigDecimal::add),
    SUBTRACT(BigDecimal::subtract),
    MULTIPLY(BigDecimal::multiply),
    DIVIDE(BigDecimal::divide);

    private final BinaryOperator<BigDecimal> command;

    Operation(BinaryOperator<BigDecimal> command) {
        this.command = command;
    }

    public BigDecimal apply(BigDecimal value1, BigDecimal value2) {
        return command.apply(value1, value2);
    }

    // ...
}
```

### Elementy programowania funkcyjnego

W swoim rozwiązaniu użyłem elementy programowania funkcyjnego. Rozwijanie funkcji (ang. _currying_) pozwala mi utworzyć odpowiednią funkcję na etapie parsowania każdej instrukcji, nie muszę znać obu parametrów. Tutaj także użyłem [wyrażeń lambda]({% post_url 2017-07-26-wyrazenia-lambda-w-jezyku-java %}) i tak zwanych [domknięć](https://pl.wikipedia.org/wiki/Domkni%C4%99cie_(programowanie))[^domkniecie]:

[^domkniecie]: Wyrażenia lambda w języku Java nie są czystymi domknięciami, jednak w tym przypadku takie uproszczenie jest dopuszczalne :).

```java
public enum Operation {
    // ...
    public static Function<BigDecimal, BigDecimal> parse(String line) {
        String[] tokens = line.split(" ");
        if (tokens.length != 2) {
            throw new IllegalArgumentException("Line (" + line + ") has illegal format!");
        }
        BigDecimal operand = new BigDecimal(tokens[1]);
        return x -> Operation.valueOf(tokens[0].toUpperCase()).apply(x, operand);
    }
}
```

Dodatkowo klasa `Calculator` dostając kolejne instrukcje w formie funkcji do wykonania łączy je ze sobą używając metody `andThen`: 

```java
public class Calculator {

    private final BigDecimal initialValue;
    private Function<BigDecimal, BigDecimal> linkedOperations = Function.identity();

    public Calculator(BigDecimal initialValue) {
        this.initialValue = initialValue;
    }

    public void execute(Function<BigDecimal, BigDecimal> operation) {
        linkedOperations = linkedOperations.andThen(operation);
    }

    public BigDecimal compute() {
        return linkedOperations.apply(initialValue);
    }
}
```

Dzięki takiemu podejściu wywołanie `linkedOperations.apply(initialValue)` pozwala na sekwencyjne uruchomienie wszystkich wprowadzonych instrukcji. 

## Wyślij mi swoje zadanie

Jeśli chcesz żebym spróbował rozwiązać Twoje zadanie proszę wyślij je na mój adres e-mail `marcin małpka samouczekprogramisty.pl`. Jeśli tylko będę potrafił je rozwiązać to z chęcią napiszę o tym artykuł.

{% include zadanie-z-rozmowy-notice.md %}

## Podsumowanie

Po lekturze tego artykułu i samodzielnej próbie rozwiązania zadania jesteś o krok bliżej do dobrego przygotowania do rozmowy kwalifikacyjnej.

Dzisiejszy artykuł pokazał Ci zadanie, które moim zdaniem jest jasno opisane. Zawiera wszystkie niezbędne informacje do jego rozwiązania. Dobrze jest trafić na zadania tego typu na rozmowach kwalifikacyjnych. Propozycja rozwiązania zawiera bardziej zaawansowane konstrukcje, dzięki którym możesz zobaczyć jak może wyglądać czytelny kod wysokiej jakości.

Jeśli ktoś z Twoich znajomych przygotowuje się do rozmowy kwalifikacyjnej na stanowisko programisty możesz podzielić się linkiem do tego artykułu, z góry dziękuję. Jeśli nie chcesz pomiąć kolejnych artykułów możesz dopisać się do samouczkowego newslettera i polubić Samouczka na Facebook'u.

Do następnego razu!
