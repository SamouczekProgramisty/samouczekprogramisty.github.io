---
layout: single
title: Pogodynka - szkic interfejsu użytkownika
date: '2017-05-14 22:56:07 +0200'
categories:
- DSP2017
- Projekty
- Pogodynka
excerpt_separator: "<!--more-->"
permalink: "/pogodynka-szkic-interfejsu-uzytkownika/"
---
Pogodynka to projekt, w ramach którego przy pomocy Raspberry Pi i czujnika temperatury udostępnię aktualne odczyty temperatury na stronie www. Ten krótki wpis podsumowuje dzisiejszy postęp prac nad projektem.

# Interfejs użytkownika
  
Nadszedł czas na część, która sprawia mi najmniej frajdy. Mianowicie na pracę z interfejsem użytkownika. Odszedłem już od wprawy i nie śledzę do końca technologii/bibliotek związanych z fontendem. Dlatego też poszedłem tutaj po najmniejszej linii oporu.

Mam świadomość, tego, że “dzisiejsze strony www robi się inaczej”, ale nie to jest celem tego projektu. W moim przypadku użyłem:

- [Highcharts](http://highcharts.com) - Rozbudowana biblioteka JavaScript do rysowania wykresów, świetnie nadaje się do mojego zastosowania. Licencja pozwala na darmowe użycie dla projektów niekomercyjnych,
- [Bootstrap](http://getbootstrap.com/) - Ostylowanie strony, którego sam nie byłbym w stanie porządnie zrobić ;).
  
  
Po dodaniu odpowiednich wpisów w DNS podstawową wersję strony możesz zobaczyć pod adresem [http://pogodynka.pietraszek.pl](http://pogodynka.pietraszek.pl). Będzie to też adres, pod którym dostępna będzie finalna wersja strony.

Aktualnie strona to jedynie szkic, to co się zmieni to głównie kod JavaScript konfigurujący wykres aby pobierał dane z odpowiedniego miejsca. Aktualnie dane są na stałe wpisane w źródło strony, co nie jest oczywiście docelowym rozwiązaniem ;).

# [![pogodynka interfejs użytkownika](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/pogodynka_interfejs_uzytkownika-300x167.jpeg)](http://www.samouczekprogramisty.pl/wp-content/uploads/2017/05/pogodynka_interfejs_uzytkownika.jpeg)
  
HTML i CSS znajdziesz na [samouczkowym githubie](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/frontend). Sam wygląd strony do złudzenia przpomina jeden z [przykładów](http://getbootstrap.com/examples/dashboard/) ze strony Bootstrapa obcięty do moich potrzeb.
# Serwer WWW
  
Tutaj wybór był prosty, zdecydowałem się na de facto standard obowiązujący w “branży”. Prosta instancja [nginx](https://nginx.org/en/) serwująca statyczne strony HTML wydała się najprostszym rozwiązaniem.
# Podsumowanie
  
Muszę jeszcze popracować nad spięciem wszystkich elementów w całość, został mi na to tydzień. Trzymajcie kciuki ;). Zostało też “kilka” brakujących funkcjonalności i finalne testy. Mówi się, że tego typu praca pochłania 80% czasu. Zobaczymy czy zasada [80/20](https://pl.wikipedia.org/wiki/Zasada_Pareta) sprawdzi się i tym razem. Do następnego razu!

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/nullprozent/4667861083/sizes/l.

