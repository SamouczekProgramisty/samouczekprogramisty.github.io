– stosuj konwencję nazewniczą charakterystyczną dla Javy (metody powinny zaczynać się od małej litery),
– konstrukcje w stylu <code>if (flag == true)</code> i <code>if (flag == false)</code> zastąp odpowiednio <code>if (flag)</code> i <code>if (!flag)</code>,
– instancja klasy <code>Scanner</code> w tym przypadku powinna być współdzielona,
– w tym przypadku metoda <code>Sqrt</code>, która opakowuje <code>Math.sqrt</code> moim zdaniem nie ma sensu,
– warunek w linijce 27 jest częściowo nadmiarowy, pętla wyżej nie skończyłaby się jeśli <code>type</code> miałoby wartość <code>false</code>,
– <code>type</code> w tym przypadku jest złą nazwą – nie oddaje zawartości zmiennej.

– stosuj się do konwencji nazewniczej i reguł formatowania kodu,
– wartość zwracana w Twoim przypadku nie jest potrzebna.

– metoda nie musi nic zwracać - zwracanie zawsze wartości false niezależnie od przyjmowanych argumentów nie jest dobrą opcją.
