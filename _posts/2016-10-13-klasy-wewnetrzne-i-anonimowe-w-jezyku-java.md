---
title: Klasy wewnętrzne i anonimowe w języku Java
date: '2016-10-13 21:42:15 +0200'
categories:
- Kurs programowania Java
permalink: /klasy-wewnetrzne-i-anonimowe-w-jezyku-java/
header:
    teaser: /assets/images/2016/10/13_klasy_wewnetrzne_anonimowe_artykul.jpg
    overlay_image: /assets/images/2016/10/13_klasy_wewnetrzne_anonimowe_artykul.jpg
    caption: "[&copy; alfmelin](https://www.flickr.com/photos/andercismo/2349098787/sizes/l)"
excerpt: W artykule tym przeczytasz o klasach wewnętrznych i klasach anonimowych w Javie. Dowiesz się jak wyglądają, jakie mają ograniczenia oraz kiedy możemy ich używać. Na końcu, jak zwykle, czeka na Ciebie zestaw zadań, w których przećwiczysz materiał z tego artykułu.
disqus_page_identifier: 465 http://www.samouczekprogramisty.pl/?p=465
---

{% include toc %}

{% include kurs-java-notice.md %}

## Klas wewnętrznych jest wiele...

Na początku pewne zastrzeżenie. W całym artykule posługuję się określeniem „klasy wewnętrzne”. Ważne jest żebyś zdawał sobie sprawę z tego, że równie dobrze możemy mieć do czynienia z wewnętrznym typem wyliczeniowym czy wewnętrznym interfejsem. Poznając klasy wewnętrzne, poznajesz także „interfejsy wewnętrzne” czy „wewnętrzne typy wyliczeniowe”.

Istnieje kilka typów klas wewnętrznych:

- (standardowe) klasy wewnętrzne,
- statyczne klasy wewnętrzne,
- lokalne klasy wewnętrzne,
- anonimowe klasy wewnętrzne.

Często mówimy po prostu o klasie wewnętrznej odwołując się do którejkolwiek z powyższych. W kolejnych akapitach postaram się pokazać różnice pomiędzy tymi typami klas.

## Klasy wewnętrzne

Standardowe klasy już znasz. Ot zwykłe `public class Example {}` i już mamy klasę. A czym jest klasa wewnętrzna? Zacznijmy od przykładu:

```java
public class OuterClass {
    public class InnerClass {
    }

    public InnerClass intantiate() {
        return new InnerClass();
    }
}
```

W naszym przykładzie widzisz dwie klasy. Standardowa klasa `OuterClass` i klasa wewnętrzna `InnerClass`.

Podobnie jak w przypadku atrybutów czy metod, klasy wewnętrzne mogą mieć standardowe modyfikatory dostępu `public`, `protected` czy `private`. Brak modyfikatora dostępu także i tutaj jest poprawny.

Modyfikatory dostępu użyte przed definicją klasy wewnętrznej działają identycznie jak w przypadku atrybutów, metod czy konstruktorów. Jeśli chcesz przeczytać o nich więcej osobny akapit na ich temat znajdziesz w [artykule o dziedziczeniu](%{ post_url 2016-01-24-dziedziczenie-w-jezyku-java %}).

Ważne jest także to, że klasa wewnętrzna ma dostęp do wszystkich atrybutów czy metod klasy zewnętrznej, w której została zdefiniowana.

### Tworzenie instancji klasy wewnętrznej

Do stworzenia instancji klasy wewnętrznej potrzebujemy instancji klasy zewnętrznej. Proszę spójrz na przykład poniżej.

```java
private static void innerClassInstantiation() {
    OuterClass outerClass = new OuterClass();
    OuterClass.InnerClass instance1 = outerClass.intantiate();
    OuterClass.InnerClass instance2 = outerClass.new InnerClass();
}
```

Widzisz tam typ `OuterClass.InnerClass`, to nic innego jak odwołanie się do typu wewnętrznego. W tym fragmencie kodu tworzymy dwie instancje. Pierwsza z nich powstaje w wyniku wywołania metody `instantiate` z klasy `OuterClass`. Ciało tej metody możesz zobaczyć w poprzednim fragmencie kodu.

Proszę zwróć uwagę, że wewnątrz metody `instantiate` nie musimy podawać pełnej nazwy klasy, samo `new InnerClass()` wystarczy (jest to odpowiednik `this.new InnerClass()`).

`instance2` tworzymy posługując się instancją klasy `OuterClass`. Taka konstrukcja jest niezbędna w przypadku standardowych klas wewnętrznych.

## Statyczne klasy wewnętrzne

W języku Java istnieją także statyczne klasy wewnętrzne. Są to klasy wewnętrzne poprzedzone modyfikatorem `static`. Proszę spójrz na przykład poniżej.

```java
public class OuterClass2 {
    public static class InnerClass2 {
    }   
 
    private InnerClass2 instantiate() {
        return new InnerClass2();
    }   
}
```

Jak widzisz przykład ten jest bardzo podobny do pierwszego z tego artykułu. Nowością tutaj jest modyfikator `static`, reszta pozostaje bez zmian.

Ważna jest natomiast różnica przy tworzeniu instancji statycznej klasy wewnętrznej.

Domyślnie, wszystkie wewnętrzne interfejsy i typy wyliczeniowe są statyczne, modyfikator `static` jest przed nimi zbędny (możesz spróbować go dodać, IDE powinno zwrócić Ci na to uwagę).

### Tworzenie instancji statycznej klasy wewnętrznej

W odróżnieniu od standardowych klas wewnętrznych, nie potrzebujemy instancji klasy zewnętrznej do stworzenia instancji statycznej klasy wewnętrznej. Może się to wydać trochę skomplikowane jednak całość na pewno będzie bardziej zrozumiała gdy popatrzysz na przykład.

```java
private static void staticInnerClassInstantiation() {
    OuterClass2 outerClass = new OuterClass2();
    OuterClass2.InnerClass2 instance1 = outerClass.instantiate();
    OuterClass2.InnerClass2 instance2 = new OuterClass2.InnerClass2();
}
```

Różnica jest taka, że wystarczy nam po prostu pełne odwołanie się do typu klasy wewnętrznej aby stworzyć jej instancję. W naszym przypadku jest to `new OuterClass2.InnerClass2()`.

## Lokalne klasy wewnętrzne

Jako ostatni typ klas wewnętrznych zostały nam lokalne klasy wewnętrzne. I wiesz co? W sumie poza tym, że możemy je zdefiniować wewnątrz bloku (wewnątrz metody, bloku `if` itp.) i nie poprzedzają ich modyfikatory dostępu (`public`, `private`, `protected`) niczym szczególnym nie różnią się od pozostałych klas wewnętrznych. Proszę spójrz na przykład:

```java
private static void localClassInstantiation(String[] args) {
    class LocalClass {
        @Override
        public String toString() {
            return "Argumenty metody: " + Arrays.toString(args);
        }
    }   
    LocalClass localClassInstance = new LocalClass();
    System.out.println(localClassInstance);
}
```

Tutaj wewnątrz metody tworzymy naszą lokalną klasę wewnętrzną `LocalClass`. Linijkę później tworzymy jej instancję i wywołujemy na niej metodę.

Głównym ograniczeniem/zaletą klas lokalnych jest ich zasięg. Podobnie jak w przypadku zmiennych lokalnych, dostęp do klas lokalnych jest wyłącznie w bloku, w którym zostały zdefiniowane.

## Kiedy używać klas wewnętrznych

Właśnie, po co w ogóle są nam one potrzebne? Mam nadzieję, że przykład ze standardowej biblioteki Javy pomoże Ci to zrozumieć.

W artykule o [kolekcjach]({% post_url 2016-08-09-kolekcje-w-jezyku-java %}) opisałem mapę i sposób w jaki możemy po niej iterować.

```java
Map<String, Integer> dayInMonths = new HashMap<>();
dayInMonths.put("styczen", 31);
dayInMonths.put("luty", 28);
dayInMonths.put("marzec", 31);
 
for(Map.Entry<String, Integer> entry : dayInMonths.entrySet()) {
    System.out.println(entry.getKey() + " ma " + entry.getValue() + " dni.");
}
```

W naszej mapie trzymamy nazwę miesiąca i odpowiadającą mu liczbę dni. Każda instancja obiektu implementującego interfejs `Map` posiada metodę `entrySet`, która zwraca typ `Set<Map.Entry<K, V>>`.

Rozłóżmy ten typ na części pierwsze. `K` to nasz klucz (ang. key), `V` to wartość (ang. value) przechowywana w mapie. `Map.Entry<K, V>` to typ generyczny który parametryzowany jest typem klucza i wartości. `Set<Map.Entry<K, V>>` to zbiór elementów mapy. Każdy element ma klucz i wartość. A czym jest `Map.Entry`? To nic innego jak interfejs wewnętrzny :) Jest to interfejs `Entry` zdefiniowany wewnątrz interfejsu `Map`.

Więc po co używać klas wewnętrznych? Powodów jest kilka. Jak w przykładzie z `Map.Entry` dobrym pomysłem użycia klas wewnętrznych jest sytuacja, w której klasa wewnętrzna nie ma sensu bez klasy zewnętrznej i jest z nią ściśle związana.

Kolejnym powodem może być lepsza enkapsulacja kodu (ukrywanie szczegółów działania klasy wewnątrz). Dzięki temu, że klasy wewnętrzne mają dostęp nawet do prywatnych zasobów klas otaczających, te drugie możemy bardziej „opakować”. Ukryć więcej szczegółów wewnątrz.

## Klasy anonimowe

Zacznijmy od prostej definicji. Klasy anonimowe to klasy definiowane w kodzie, które mają dokładnie jedną instancję. Definicja klasy anonimowej połączona jest z tworzeniem jej jedynej instancji. Klasy anonimowe zawsze są klasami wewnętrznymi.

Proszę spójrz na przykład poniżej:

```java
public interface GreetingModule {
    void sayHello();
}
 
new GreetingModule() {
    @Override
    public void sayHello() {
        System.out.println("good morning");
    }
}
```

Na początku definicja interfejsu z jedną metodą sayHello. Ciekawsze są jednak ostatnie cztery linijki. To właśnie definicja klasy anonimowej.

    new TYP([ARGUMENTY]) {
        CIAŁO KLASY
    }

Konstrukcja ta pozwala nam na stworzenie instancji klasy anonimowej. W naszym przykładzie tworzymy nową klasę, która implementuje interfejs `GreetingModule` oraz tworzymy jej nową instancję przy pomocy słowa kluczowego `new`.

Wewnątrz definicji klasy anonimowej możemy definiować atrybuty czy metody. W praktyce sprowadza się to przeważnie do zaimplementowania metod interfejsu dla którego tworzymy klasę anonimową.

W większym fragmencie kodu użycie klas anonimowych może wyglądać następująco.

```java
public class AnonymousClasses {
    public static class Robot {
        private final GreetingModule greetingModule;
 
        public Robot(GreetingModule greetingModule) {
            this.greetingModule = greetingModule;
        }
 
        public void saySomething() {
            greetingModule.sayHello();
        }
    }
 
    public interface GreetingModule {
        void sayHello();
    }
 
    public static void main(String[] args) {
        Robot jan = new Robot(new GreetingModule() {
            @Override
            public void sayHello() {
                System.out.println("dzien dobry");
            }
        });
        Robot john = new Robot(new GreetingModule() {
            @Override
            public void sayHello() {
                System.out.println("good morning");
            }
        });
 
        jan.saySomething();
        john.saySomething();
    }
}
```

W naszym przykładzie tworzymy dwie instancje robotów `jan` i `john`, które używają innych „modułów powitań”. Każdy z nich jest instancją anonimowej klasy wewnętrznej.

Niektóre z klas anonimowych można zastąpić wyrażeniami lambda, o których przeczytasz w jednym z kolejnych artykułów.

## Używanie zmiennych z klas zewnętrznych

Wewnątrz definicji klas wewnętrznych (także klas anonimowych) możemy używać zmiennych z otaczającego je kontekstu. Spójrz na przykład poniżej:

```java
public void someMethod() {
    final String finalVariable = "final variable";
    String effectivelyFinalVariable = "effectively final variable";
    String nonFinalVariable = "non final variable";
 
    class InnerClass {         
        public void saySomething() {        
            System.out.println(finalVariable);
            System.out.println(effectivelyFinalVariable);
        }   
    }   
 
    InnerClass instance = new InnerClass();
    instance.saySomething();            
 
    nonFinalVariable = "new value";
}
```

W metodzie `saySomething` używamy dwóch zmiennych z klasy otaczającej `finalVariable` i `effectivelyFinalVariable`. Jest jednak jedno ograniczenie. Zmienna z „zewnątrz” użyta w klasie wewnętrznej musi być finalna albo „właściwie finalna”.

Zmienna jest finalna jeśli poprzedza ją słowo kluczowe `final`. Kiedy jest „właściwie finalna”? Kiedy nie zmieniamy jej wartości i kompilator za nas wstawia brakujące słowo final ;).

W związku z tym użycie zmiennej `nonFinalVariable` nie jest dozwolone ponieważ jej wartość jest zmieniana.

## Zadania

Na koniec czekają na Ciebie dwa zadania, w których przećwiczysz zagadnienia omówione w artykule. Przygotowałem też zestaw przykładowych rozwiązań i umieściłem je na [githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/21_klasy_wewnetrzne/src/main/java/pl/samouczekprogramisty/kursjava/inner/exercise). Jak zwykle zachęcam do samodzielnego rozwiązywania zadań, wtedy nauczysz się najwięcej. Samo przeczytanie artykułu nie wystarczy, do dzieła!
1. Rozszerz przykład z robotami z akapitu o klasach anonimowych o robota witającego się w innym języku np. niemieckim.
2. Zadanie to będzie wymagało dodatkowej lektury na temat interfejsu [`Comparator`](https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html) ze standardowej biblioteki Javy. Pobierz od użytkownika 5 wyrazów, zapisz je w `List`. Użyj metody [`Collections.sort`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#sort-java.util.List-java.util.Comparator-), przekazując jako argumenty listę oraz klasę anonimową, która posortuje ją na podstawie długości wyrazów (najkrótsze wyrazy powinny być pierwsze). Do sprawdzenia długości słowa możesz użyć metody [`String.length`](http://docs.oracle.com/javase/8/docs/api/java/lang/String.html#length--). Wyświetl zawartość listy przed i po sortowaniu.

## Materiały dodatkowe

Przygotowałem też dla Ciebie zestaw materiałów dodatkowych zawierających informacje na temat klas wewnętrznych i anonimowych. Dodatkowo wszystkie przykłady kodu użyte w tym artykule możesz znaleźć na [samouczkowym githubie](https://github.com/SamouczekProgramisty/KursJava/tree/master/21_klasy_wewnetrzne/src/main/java/pl/samouczekprogramisty/kursjava/inner).
- [Tutorial na stronie Oracle dotyczący klas wewnętrznych i anonimowych](https://docs.oracle.com/javase/tutorial/java/javaOO/nested.html),
- [Fragment książki opisujący klasy wewnętrzne](http://docstore.mik.ua/orelly/java-ent/jnut/ch03_12.htm),
- [Rozdział w JLS na temat klas wewnętrznych](https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8.1.3),
- [Rozdział w JLS na temat klas anonimowych](https://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.9.5).

## Podsumowanie

Bardzo się cieszę, że przeczytałeś artykuł do końca. Po lekturze artykułu wiesz czym są klasy wewnętrzne. Wiesz też jakie rodzaje klas wewnętrznych występują. Znasz także klasy anonimowe i wiesz kiedy ich używać. Rozwiązując zadanie przećwiczyłeś całość w praktyce. Innymi słowy kawał solidnej wiedzy :)

Na koniec mam do Ciebie prośbę. Proszę podziel się artykułem ze znajomymi i polub moją stronę na facebooku. Zależy mi na dotarciu do jak największej liczby osób, które chcą uczyć się programowania. Z góry dziękuję i do następnego razu.
