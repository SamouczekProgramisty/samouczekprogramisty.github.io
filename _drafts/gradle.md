Idę dalej po artykułach, jestem na Filtrach, korzystając z gotowego projektu Gradle na Github, nie wiem jak stworzyć swój własny, od zera. W build.gradle masz rzeczy których nie rozumiem. Jak: "gradle.projectEvaluated"
Rozumiem, że subproject dodaje plugin'y, a dependencies zależności (tylko jakie).
Tworząc nowy projekt Gradle mam zawartość pliku build.gradle skopiować aby wszystko działało?


Jako totalny początkujący w Gradle i mający tylko ogólną wiedzę IT, mogę wymienić kilka rzeczy które sprawiły mi trudność lub mi czegoś brakowało.
Częstym błędem specjalistów / profesjonalistów jest pomijanie rzeczy które z ich punktu widzenia są proste i oczywiste. Informacje w jakim środowisku wykonywane są przykłady są bardzo istotne. Nie każdy rozpoznaje programy które należy użyć, po zdjęciu czy składni kodu, często trzeba szukać odpowiednika w swoim systemie operacyjnym. To sprawiło mi trochę trudności (chociaż zmusiło mnie do samodzielnego poszukiwania rozwiązania) i wydłużyły czas nauki rzeczy które mnie interesowały. Można na początku każdego artykułu umieścić krótki opis (listę) środowiska w którym prezentu jesz przykłady: System operacyjny, użyte programy. Podejrzewam, że we wszystkich artykułach używasz tych samych, więc wystarczyłoby umieścić jakiś element z taką listą w każdym artykule.

Brakuje mi w artykule o Gradle opisu podziału projektu na katalogi, tzn. które są obowiązkowe, opcjonalne itp itd.

W przykładach pokazujesz jak modyfikujesz plik gradle.build, jednak są to pojedyncze linijki, brakuje spojrzenia na cały p lik pod koniec artykułu. Dla mnie nie było jednoznaczne, że "group" "name" "version" trzeba umieścić w pliku gradle.build (czy jest to odpowiednik pom z Maven'a). Nie było przykładu ich użycia (dopiero przy akapicie tworzenia projektu Gradle w IntelliJ zobaczyłem ten plik w całości i to wyłapałem).

W ogarnianiu artykułu bardzo pomaga przykładowe repozytorium z kodem. Często pozwala dostrzec rzeczy których się nie wychwyciło z tekstu (struktura plików, kod w odpowiednim pliku)

Większość osób korzysta z IDE, krótka informacja jak uruchomić program / projekt Gradle w intelliJ była by bardzo przydatna. W Maven, mam klasę z nazwą projektu a w niej metodę main. Wiem, że to ją muszę uruchomić, aby uruchomić pogram.

Czy Gradle potrzebuje np XAMPP? uruchomiłem Twój projekt bez tego, a mogłem już uruchomić w przeglądarce pogram. Gradle lub IntelliJ sam to jakoś uruchamia?

Starałem się pisać konstruktywne uwagi, mam nadzieję, że pomogłem.


Bardzo proszę o podpowiedź jak budować plik war w katalogu TomEE. Modifikujemy plik build.gradle czy ścieżkę w OS?<Paste> – exploaded war
