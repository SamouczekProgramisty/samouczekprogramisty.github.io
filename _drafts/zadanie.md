Zadanie od Marka:

Łańcuchy białkowe
Genetycy zajmują się nowym typem łańcuchów białkowych, które składają się z ciągu aminokwasów pewnego typu. Wyróżniono 20 rodzajów tych aminokwasów i oznaczono je dużymi literami alfabetu angielskiego – od  litery A do T. Łańcuch białkowy można zatem zapisać jako słowo składające się z dużych liter od A do T, na przykład „BDDFPQPPRRAGGHPOPDKJKPEQAAER”.

Mając dany łańcuch białkowy genetycy mogą zamienić w nim dwa dowolne aminokwasy miejscami, na przykład łańcuch „AABBCC” mogą zamienić na „ACBBCA”, a ten z kolei na przykład na „BCBACA”. 

Genetyk posiada komputerowy zapis dwóch łańcuchów białkowych i zastanawia się, czy drugi z nich mógł powstać z pierwszego poprzez wykonywanie dowolnej liczby zamian miejsc aminokwasów.  

Napisz program, który będzie posiadał funkcję:
bool changePossible(string s1, string s2)

która sprawdzi, czy możliwe jest uzyskanie łańcucha białkowego s2 z łańcucha białkowego s1.

Ponieważ rzeczywiste łańcuchy białkowe składają się z około 10^8 aminokwasów, należy zadbać o dobrą wydajność algorytmu.

Dane są zapisane w pliku tekstowym. Każdy z łańcuchów jest zapisany w osobnej linii i porównujemy łańcuch z linii nieparzystej z łańcuchem z linii
parzystej. Przykładowy plik: 

ACBBCA
BCBACA

Można założyć, że liczba linii będzie zawsze parzysta. Można także założyć również, że plik wejściowy jest poprawny i nie zawiera żadnych białych znaków poza znakami końca linii. Napisz  program  w popularnym języku programowania (C,  C++,  Java,  C#,  Python), który wczyta plik wejściowy z danymi, obliczy i wypisze wynik. Najlepiej będzie, jeśli program będzie czytać dane ze standardowego wejścia i wypisywać wynik na standardowe wyjście, dzięki czemu będzie go można wywołać poleceniem: 

program.exe < dane.txt 

Jeśli nie potrafisz korzystać ze standardowego wejścia, możesz wczytać plik z danymi w inny sposób. Ważna jest wydajność zastosowanego algorytmu. W rozwiązaniu możesz korzystać z biblioteki klas dostępnych na platformie, w której będziesz programować. 
