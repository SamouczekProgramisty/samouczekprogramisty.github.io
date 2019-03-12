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
