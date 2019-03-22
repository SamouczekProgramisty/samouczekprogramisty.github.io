– stosuj konwencję nazewniczą charakterystyczną dla Javy (metody powinny zaczynać się od małej litery),
– konstrukcje w stylu `if (flag == true)` i `if (flag == false)` zastąp odpowiednio `if (flag)` i `if (!flag)`,
– instancja klasy `Scanner` w tym przypadku powinna być współdzielona,
– w tym przypadku metoda `Sqrt`, która opakowuje `Math.sqrt` moim zdaniem nie ma sensu,
– warunek w linijce 27 jest częściowo nadmiarowy, pętla wyżej nie skończyłaby się jeśli `type` miałoby wartość `false`,
– `type` w tym przypadku jest złą nazwą – nie oddaje zawartości zmiennej.

– stosuj się do konwencji nazewniczej i reguł formatowania kodu,
– wartość zwracana w Twoim przypadku nie jest potrzebna.

– metoda nie musi nic zwracać - zwracanie zawsze wartości false niezależnie od przyjmowanych argumentów nie jest dobrą opcją.

– staraj się nie używać domyślnego pakietu,
– możesz postarać się usunąć duplikację kodu (np. fragmenty służące do pobierania danych od użytkownika),
– +1 za testy jednostkowe!,
– separatory linii są różne na różnych platformach, dobrym pomysłem jest używanie System.lineSeparator(),
– jeśli wyrażenie regularne się nie zmienia, to możesz je kompilować raz (atrybut statyczny), a nie przy każdym uruchomieniu metody,
– spróbuj połączyć oba wyrażenia regularne, da się to zrobić jednym wyrażeniem,
– cyfry w wyrażeniach regularnych też mają swoją klasę – \d,
– IllegalArgumentException wydaje mi się lepszym wyjątkiem,
– subiektywne, ale kod:

if (something) {
    // return/throw/break/continue
}
else {
    // something else
}


wolę jako (dzięki drowi Pawłowi Rogalińskiemu):

if (something) {
    // return/throw/break/continue
}
// something else

– staraj się nadawać nazwy, które odpowiadają temu co jest w środku, np. displayNoOfUnique nic nie pokazuje, jedynie zwraca.

Jeśli chodzi o Gradle, to podstawy opisałem tutaj. A co do Git'a i Gighub'a to zapraszam na Kurs Git'a, nad którym pracuję.
Jest OK, chociaż można zastanowić się, czy ta metoda nie pasowałaby lepiej do osobnej klasy (jednak przy tak małych programach nie ma to większego znaczenia). Dodatkowo metodę statyczną wywołabym na klasie, nie na instancji:

<pre>
Klasa instancja = new Klasa();
instancja.metoda();

Klasa.metodaStatyczna();
</pre>

– formatowanie kodu zostaw IDE, zrobi to dobrze i konsekwentnie,
– pusty blok <code>if</code> jest słaby, lepiej zastosuj odwrócony warunek – <code>!=</code>,

– zwróciłeś mi uwagę na coś co można zrobić lepiej w przykładowym kodzie, który pokazałem – <code>java.util.Date</code> ma słabą prasę ;). Dużo lepszym pomysłem jest użycie <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/time/LocalDate.html"><code>java.time.LocalDate</code></a>,
– <code>@IsDate</code> nie nadaje się do parametru, który jest typu <code>Date</code>,
– w tym przypadku walidacje na parametrach konstruktora raczej nie mają sensu (masz to samo w atrybutach klasy),
– jak zadziała Twój walidator jeśli będzie musiał sprawdzić poprawność pustego łańcucha znaków?
– pozwól IDE formatować kod,
– spróbuj przenieść komunikaty błędów do plików properties.

– staram się otaczać nawet jednoliniowe bloki nawiasami (po if, else itd.)
– w repozytorium rozdzielaj kod na pliki jakie masz w swoim edytorze.

– spróbuj try with resources


– rzuć okiem na <a href="https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/String.html#join(java.lang.CharSequence,java.lang.CharSequence...)"><code>String.join</code></a>,
– subiektywna opinia – nie podchodzą mi importy z `*`, moim zdaniem bardziej czytelne są importy, które są "jawne",
– <code>toString</code> w <code>WordSort</code> możesz zrobić używając <code>String.join</code>,
– dobrą praktyką jest wyciąganie regexpów, które się nie zmieniają poza metody,
– rzuć okiem na <a href="https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/Integer.html#compare(int,int)"><code>Integer.compare</code></a>,
– uważaj z zamykaniem <code>System.in</code>,
– jak dojdziesz do <a href="http://www.samouczekprogramisty.pl/wyrazenia-lambda-w-jezyku-java/">wyrażeń lambda</a> wróć do tych ćwiczeń i zastanów się co możesz poprawić.

Siemasz!


Kilka standardowych uwag:

– formatowanie kodu zostaw IDE,
– stosuj się do konwencji nazewniczej powszechnej w Javie,
– rozdziel metody na mniejsze, z pojedynczym zakresem odpowiedzialności,
– enkapsulacja – stosuj <a href="https://www.samouczekprogramisty.pl/modyfikatory-dostepu-w-jezyku-java/">modyfikatory dostępu</a>,
– powtarzający się kod wyciągaj do oddzielnych klas/metod,
– jaka jest domyślna wartość w tablicy <code>int[]</code>?,
– nie potrzebujesz zmiennej lokalnej, zamiast <code>%=</code> możesz użyć po prostu <code>%</code>,
– staraj się nazywać zmienne w sposób, który mówi co zawierają (liczba2, arg1 przeważnie mają lepsze odpowiedniki),
