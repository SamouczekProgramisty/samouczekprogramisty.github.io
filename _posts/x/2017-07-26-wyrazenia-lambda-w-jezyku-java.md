---
title: Wyrażenia lambda w języku Java
date: '2017-07-26 21:28:10 +0200'
categories:
- Kurs programowania Java
permalink: "/wyrazenia-lambda-w-jezyku-java/"
header:
    teaser: "/assets/images/2017/07/26_wyrazenia_lambda_artykul.jpeg"
    overlay_image: "/assets/images/2017/07/26_wyrazenia_lambda_artykul.jpeg"
excerpt: W artykule tym poznasz mechanizm tworzenia wyrażeń lambda. Dowiesz się jak ich używać. Poznasz też praktyczne zastosowania. Dowiesz się też jak działa operator `::`. Jeśli jesteś początkującym zrozumienie wyrażeń lambda pozwoli Ci przenieść swoje umiejętności na kolejny poziom. Zdobytą wiedzę będziesz mógł przećwiczyć rozwiązując kilka przykładowych zadań.
---

{% include toc %}

{% capture notice-text %}
Artykuł ten dotyczy bardziej zaawansowanego fragmentu składni języka Java. Z tego powodu aby móc w pełni skorzystać z artykułu warto zapoznać się z wcześniejszymi artykułami:

- [klas anonimowych](http://www.samouczekprogramisty.pl/klasy-wewnetrzne-i-anonimowe-w-jezyku-java/)[,](http://www.samouczekprogramisty.pl/typy-generyczne-w-jezyku-java/)
- [typów generycznych](http://www.samouczekprogramisty.pl/typy-generyczne-w-jezyku-java/),
- [adnotacji](http://www.samouczekprogramisty.pl/adnotacje-w-jezyku-java/)
{% endcapture %}

<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

# Czym jest wyrażenie lambda
  
Dla uproszczenia można powiedzieć, że wyrażenie lambda jest metodą[^roznice]. Metodą, którą możesz przypisać do zmiennej. Możesz ją także wywołać czy przekazać jako argument do innej metody.

[^roznice]: Nie jest to do końca prawda, na przykład wyrażenie lambda nie wprowadza nowego zakresu zmiennych, ale takie uproszczenie pomoże zrozumieć działanie wyrażeń lambda.

Wyrażenia lambda możesz także porównać do klas anonimowych[^roznice2]. Mają one jednak dużo bardziej czytelną i zwięzłą składnię.

[^roznice2]: Podobnie jak przy poprzednim porównaniu, są różnice pomiędzy wyrażeniami lambda i klasami anonimowymi. Jednak na potrzeby tego wprowadzenia możemy je pominąć.

Na przykład wyrażenie lambda, które podnosi do kwadratu przekazaną liczbę wygląda następująco:

```java
x -> x * x
```

## Składnia wyrażeń lambda
  
Wyrażenie lambda ma następującą składnię

```java
<lista parametrów> -> <ciało wyrażenia>
```

### Lista parametrów
  
Lista parametrów zawiera wszystkie parametry przekazane do “ciała” wyrażenia lambda. W szczególności lista ta może być pusta. Wyrażenie lambda poniżej nie przyjmuje żadnych argumentów, zwraca natomiast instancję klasy `String`:

    () -> “some return value”

  
Podawanie typów parametrów jest opcjonalne. Kompilator jest w stanie poznać te parametry z kontekstu w którym znajduje się dane wyrażenie lambda. Jeśli chcesz możesz je także podać:

    (Integer x, Long y) -> System.out.println(x * y)

  
Nawiasy otaczające listę parametrów są opcjonalne jeśli wyrażenie ma wyłącznie jeden parametr bez określonego typu[^kompilacja].

[^kompilacja]: Oczywiście w trakcie kompilacji typ jest znany, ale nie jest jawnie podany w kodzie źródłowym.

### Ciało wyrażenia lambda
  
W ogromnej większości przypadków wyrażenia lambda zawierają jedną linijkę kodu:

```java
x -> x * x() -> “some return value”
```
```java
(Integer x, Long y) -> System.out.println(x * y);
```
  
Może się jednak zdarzyć, że Twoje wyrażenie lambda będzie zawierało więcej linii. W takim przypadku musisz otoczyć je nawiasami `{}` jak w przykładzie poniżej:

    x -> { if (x != null && x % 2 == 0) { return (long) x * x; } else { return 123L; }}

  
Można sobie wyobrazić wyrażenie lambda, które nie przyjmuje żadnych parametrów i nie zwraca żadnych wartości. Najprostsza wersja takiego wyrażenia wygląda następująco:

    () -> {}

# Od klasy anonimowej do wyrażenia lambda
  
Wiesz już czym jest klasa anonimowa. Dla przypomnienia powiem, że jest to stworzenie jedynej instancji klasy w miejscu jej użycia. Wiesz już też jak wyglądają wyrażenia lambda. Teraz nadszedł czas na zamianę klasy anonimowej na wyrażenie lambda. Proszę spójrz na przykład poniżej:

    public interface Checker { boolean check(T object);}Checker isOddAnonymous = new Checker() { @Override public boolean check(Integer object) { return object % 2 != 0; }};System.out.println(isOddAnonymous.check(123));System.out.println(isOddAnonymous.check(124));

  
W przykładzie tym zdefiniowałem interfejs `Checker`, który posiada jedną metodę `check`. Metoda ta zwraca wartość logiczną na podstawie przekazanego argumentu.

Fragment kodu robiący to samo jednak przy użyciu składni wyrażeń lambda wygląda następująco:

    Checker isOddLambda = object -> object % 2 != 0;System.out.println(isOddLambda.check(123));System.out.println(isOddLambda.check(124));

  
Prawda, że ładniej :)?

Dochodzimy teraz do momentu, w którym muszę Ci powiedzieć o typach w wyrażeniach lambda. Każde wyrażenie lambda jest instancją dowolnego interfejsu funkcyjnego. Jest to bardzo ważne, dlatego też musisz dokładnie wiedzieć czym jest interfejs funkcyjny.

# Interfejs funkcyjny
  
Interfejs funkcyjny to interfejs, który ma jedną abstrakcyjną metodę[^efektywnie_abstrakcyjna]. Wprowadzono adnotację [`@FunctionalInterface`](https://docs.oracle.com/javase/8/docs/api/java/lang/FunctionalInterface.html), którą możesz dodać do interfejsów tego typu.

[^efektywnie_abstrakcyjna]: Efektywnie abstrakcyjną, czyli dodanie do interfejsu np. metody equals, która jest w klasie Object nadal spełnia to wymaganie.

Adnotacja ta zapewnia, że kompilator upewni się, że dany interfejs jest interfejsem funkcyjnym. Jeśli nie, wówczas kompilacja się nie powiedzie.

Przykładem interfejsu funkcyjnego może być zdefiniowany wcześniej interfejs `Checker`.

    @FunctionalInterfacepublic interface Checker { boolean check(T object);}

  
Zawiera on wyłącznie jedną metodę `check`.
## Przykładowe interfejsy funkcyjne
  
Twórcy języka Java przygotowali zestaw interfejsów funkcyjnych, które możesz implementować. W większości przypadków w zupełności wystarczy ich użycie. Część z nich znajduje się w pakiecie [`java.util.function`](https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html). Najważniejsze z nich zebrałem poniżej:
- `Function` zawiera metodę `apply`, która przyjmuje instancję klasy `T` zwracając instancję klasy `R`,
- `Consumer` zawiera metodę `accept`, która przyjmuje instancję klasy `T`,
- `Predicate` zawiera metodę `test`, która przyjmuje instancję klasy T i zwraca flagę. Interfejs ten może posłużyć do zastąpienia interfejsu `Checker`,
- `Supplier` zawiera metodę `get`, która nie przyjmuje żadnych parametrów i zwraca instancję klasy `T`,
- `UnaryOperator` jest specyficznym przypadkiem interfejsu `Function`. W tym przypadku typ argumentu i typ zwracany są te same.
  
  
Wyrażenia lambda zdefiniowane na początku artykułu można przypisać do tych właśnie interfejsów:

    UnaryOperator square = x -> x * x;Supplier someString = () -> "some return value";BiConsumer multiplier = (Integer x, Long y) -> System.out.println(x * y);Function multiline = x -> { if (x != null && x % 2 == 0) { return (long) x * x; } else { return 123L; }};

# Zalety stosowania wyrażeń lambda
  
Wyrażenia lambda są bardzo pomocne przy operacji na kolekcjach. Są niezastąpione także przy pracy ze strumieniami. Pozwalają także na pisanie w Javie w sposób “funkcyjny”[^funkcyjny].

[^funkcyjny]: Oczywiście Java nie jest językiem w pełni funkcyjnym, jednak taka namiastka jest przydatna.

Oczywistą zaletą wyrażeń lambda jest ich zwięzłość. Kod zajmuje o wiele mniej miejsca, staje się przez to bardziej czytelny.

# Odwoływanie się do metod
  
Wraz z wyrażeniami lambda Java została rozbudowana o składnię pozwalającą na odwoływanie się do metod. Służy do tego `::`. Dzięki temu wyrażeniu możemy przypisać metodę do zmiennej bez jej wywołania. Takie podejście pozwala na przekazanie tak wyłuskanej metody i wywołanie jej w zupełnie innym miejscu. Proszę spójrz na przykład poniżej:

    Object objectInstance = new Object();IntSupplier equalsMethodOnObject = objectInstance::hashCode;System.out.println(equalsMethodOnObject.getAsInt());

  
W przykładzie tym tworzę nową instancję klasy `Object`. Następnie pobieram metodę `hashCode` z tego obiektu i przypisuję ją do typu [`IntSupplier`](https://docs.oracle.com/javase/8/docs/api/java/util/function/IntSupplier.html). Jest to kolejny interfejs funkcyjny znajdujący się w standardowej bibliotece. Ostatnia linijka to wywołanie metody znajdującej się w tym interfejsie.

Kod powyżej można porównać do:

    Object objectInstance = new Object();System.out.println(objectInstance.hashCode());

  
W obu przypadkach tworzę nowy obiekt klasy `Object` i wywołują na nim metodę `hashCode`.
# Odwoływanie się do metod bez podania instancji
  
Można także odwołać się do metody bez podania instancji, na której metoda powinna być wywołana. Wówczas ta instancja musi być przekazana jako pierwszy argument. Przykład poniżej powinien pomóc zrozumieć to zastosowanie:

    ToIntFunction equalsMethodOnClass = Object::hashCode;Object objectInstance = new Object();System.out.println(equalsMethodOnClass.applyAsInt(objectInstance));

  
W odróżnieniu do poprzedniego przykładu tutaj na początku pobieram metodę. Tym razem metoda nie jest przypisana do instancji. W związku z tym wyrażenie lambda jest już innego typu. W takim przypadku zawsze pierwszym argumentem jest instancja na której metoda powinna być wywołana. W kolejnej linijce tworzę instancję klasy `Object`. Ostatnia linijka to wywołanie metody na tej instancji.

Kod bez użycia odwołania do metody robiący dokładnie to samo wygląda trochę mniej skomplikowanie:

    Object objectInstance = new Object();System.out.println(objectInstance.hashCode());

# Odwoływanie się do konstruktora
  
Notacja z `::` może być także użyta do odwołania się do konstruktora. W tym przypadku należy użyć `::` wraz ze słowem kluczowym `new`. Proszę spójrz na przykład poniżej:

    Supplier objectCreator = Object::new;System.out.println(objectCreator.get());

  
W pierwszej linijce przykładu przypisuje konstruktor klasy `Object` do zmiennej `objectCreator`. Kolejna linijka to wywołanie konstruktora.

To samo bez użycia referencji metody możesz uzyskać w dobrze Ci znany sposób:

    System.out.println(new Object());

# Przykład zastosowania wyrażeń lambda i odwołania do metody
  
Załóżmy, że chcemy wypisać na konsoli liczby znajdujące się w kolekcji. Możemy to zrobić przy pomocy standardowej pętli, którą już znasz:

    List numbers = Arrays.asList(1, 2, 3, 4);for (Integer number : numbers) { System.out.println(number);}

  
To samo zadanie można także zrobić przy pomocy wyrażeń lambda:

    List numbers = Arrays.asList(1, 2, 3, 4);Consumer integerConsumer = n -> System.out.println(n);numbers.forEach(integerConsumer);

  
Pierwsza linijka to utworzenie listy z liczbami. Kolejna jest bardziej ciekawa, zawiera wyrażenie lambda, które konsumuje liczbę wypisując ją na konsoli. Ostatnia to wywołanie metody `forEach` wraz z wyrażeniem lambda. Wyrażenie to zostanie wywołane dla każdego elementu.

Kod ten można jeszcze bardziej skrócić używając mechanizmu odwoływania się do metod:

    List numbers = Arrays.asList(1, 2, 3, 4);numbers.forEach(System.out::println);

  
Efekt działania wszystkich trzech fragmentów jest dokładnie taki sam. Różnią się między sobą sposobem rozwiązania danego problemu.
# Zadania
  
Na koniec mam dla Ciebie kilka zadań, które pomogą przećwiczyć Ci wiedzę z tego artykułu.
1. Napisz program, który pobierze o użytkownika cztery łańcuchy znaków, które umieścisz w liście. Następnie posortuj tę listę używając metody [`sort`](https://docs.oracle.com/javase/8/docs/api/java/util/List.html#sort-java.util.Comparator-). Użyj wyrażenia lambda, które posortuje łańcuchy znaków malejąco po długości.
2. Napisz program, który wywoła funkcję `hashCode` na instancji klasy `Object` używając mechanizmu odwoływania się do metody (przy pomocy `::`).
3. Utwórz instancję klasy `Human` przy pomocy mechanizmu odwoływania się do konstruktora (przy pomocy `::`).

    public class Human { private int age; private String name; public Human(int age, String name) { this.age = age; this.name = name; } public int getAge() { return age; } public String getName() { return name; }}

  
  
  
Jeśli będziesz miał problem z rozwiązaniem zadań możesz rzucić okiem na [przykładowe rozwiązania](https://github.com/SamouczekProgramisty/KursJava/tree/master/28_wyrazenia_lambda/src/main/java/pl/samouczekprogramisty/kursjava/lambdaexpressions/exercise), które umieściłem na samouczkowym githubie.
# Dodatkowe materiały do nauki
  
Przygotowałem dla Ciebie zestaw kilku linków z materiałami dodatkowymi:
- [Wprowadzenie do wyrażeń lambda na stronie Oracle](http://www.oracle.com/webfolder/technetwork/tutorials/obe/java/Lambda-QuickStart/index.html),
- [Tutorial dotyczący wyrażeń lambda na stronie Oracle](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html),
- [Opis interfejsów funkcyjnych w JLS](https://docs.oracle.com/javase/specs/jls/se8/html/jls-9.html#jls-9.8),
- [Referencja do metody w JLS](https://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.13),
- [Wyrażenia lambda w JLS](https://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.27).
  

# Podsumowanie
  
Wyrażenia lambda nie są proste. Mogą powodować sporo zakłopotania, szczególnie na początku. Jeśli jednak się do nich przyzwyczaisz pisanie kodu z ich udziałem będzie sprawiało Ci sporo frajdy :). Po pewnym czasie docenisz też zwięzłość wyrażeń lambda.

Po przeczytaniu artykułu wiesz czym są wyrażenia lambda i jak je stosować. Znasz też mechanizm odwoływania się do metod. Przećwiczyłeś te mechanizmy rozwiązując przykładowe zadania. Nie zapomnij pochwalić się w komentarzu gdzie ostatnio użyłeś wyrażeń lambda :).

Na koniec mam do Ciebie prośbę. Jeśli uważasz, że artykuł ten był dla Ciebie pomocny proszę podziel się nim ze swoimi znajomymi. Zależy mi na dotarciu do jak największej grupy czytelników a Ty możesz mi w tym pomóc. Jeśli nie chcesz pominąć żadnego nowego artykułu dopisz się do samouczkowego newslettera i polub samouczka na facebooku. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/rofi/2097239111/sizes/l

