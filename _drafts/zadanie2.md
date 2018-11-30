Zadanie od Andrzeja (na stanowisko Junior Java Developer)

ZADANIE:

Wykonaj projekt, który odczyta zadany zasób URL protokołem HTTP i zapisze jego fragmenty na dysku w wielu plikach. Złączenie zapisanych plików w odpowiedniej kolejności powinno być identyczne z zasobem.

Program powinien działać wielowątkowo i współbieżnie, komunikacja sieciowa i zapis powinny się odbywać w osobnych wątkach, np.
- 6 wątków komunikacji sieciowej
- 2 wątki zapisu IO

(liczba wątków może być zawarta w kodzie programu)

Odczyt sieciowy powinien się odbywać w chunkach, tzn. jedno zapytanie powinno odczytywać z serwera tylko fragment pliku o zadanej długości. Pliki powinny się nazywać x.dat, gdzie x to pierwszy bajt zasobu.

Operacje powinny być synchroniczne w wątkach, tzn. jedne wątek powinien na raz pobierać/zapisywać jeden plik.

Program powinien odczytywać z linii komend parametry:
- URL
- rozmiar czytywanego chunka
- rozmiar pliku ostatni plik

Przykładowo dla parametrów: <ciach url> 100 000 1 000 000

(zasób ma 9 559 140 bajtów)
Powinniśmy otrzymać 10 plików:
Plik 0.dat powinien zawierać bajty 0-999999 zasobu
Plik 1000000.dat powinien zawierać bajty 1000000-1999999 zasobu
...
Plik 9000000.dat powinien zawierać bajty 9000000-9559140 zasobu

Łącznie powinno zostać wykonane 96 requestów HTTP pod zadany zasób, jeden powinien odczytać 59140 bajtów, pozostałe 100000
