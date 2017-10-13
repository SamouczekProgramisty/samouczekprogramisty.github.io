---
layout: default
title: XML dla początkujących
date: '2017-03-02 23:37:42 +0100'
categories:
- Wiedza ogólna
- DSP2017
excerpt_separator: "<!--more-->"
permalink: "/xml-dla-poczatkujacych/"
---
W artykule tym przeczytasz o tym czym jest format XML. Poznasz kilka bibliotek czy specyfikacji używanych do przetwarzania tego formatu. Przeczytasz o wadach i zaletach pracy z plikami XML, poznasz też przykłady praktycznego zastosowania takiego formatu zapisu danych. Zapraszam do artykułu.

# Czym jest XML
  
XML (ang. _Extensible Markup Language_) to specyfikacja zapisu danych, która została opracowana w 1998 roku przez W3C (ang. _World Wide Web Consortium_). Jest to format tekstowy, który pozwana na zapisywanie danych w postaci, która jest łatwa do odczytu zarówno przez maszyny jak i przez ludzi [1. Moim zdaniem skomplikowane pliki XML w cale nie są czytelne dla ludzi, ale to już temat na osobną dyskusję ;).].

Aby dane w formacie XML uważano za poprawne muszą one mieć pewną strukturę, proszę spójrz na przykład poniżej, który pokazuje poprawne dane w formacie XML:

    Wprowadzenie do XML w Javie Marcin Pietraszek Zestaw artykułów dotyczących programowania w języku Java

  
Przykładowy dokument powyżej może służyć do opisu kursu programowania Java znajdującego się na Samouczku. Równie dobrze możesz stworzyć plik, który zawierał będzie informacje na temat pogody, stopni w szkole czy jakiegokolwiek innego tematu.
# Opis formatu XML
  
Dokument XML składa się z zagnieżdżonych elementów. Są one zapisywane jako znaczniki w postaci ``.

[idea]Na początek drobna dygresja na temat węzłów i elementów. Czytając inne źródła po polsku na temat XML natkniesz się na nazwę węzeł. Sam próbując znaleźć poprawny odpowiednik w języku polskim nie znalazłem zbyt wielu wzmianek o węzłach (ang. _node_) w [specyfikacji](https://www.w3.org/TR/2008/REC-xml-20081126/). Specyfikacja opisuje elementy (ang. _element_). Dlatego w tym artykule posługiwał będę się wyłącznie określeniem element. Z racji tego, że XML ma strukturę drzewiastą, a w “pracy z drzewami” mówi się o węzłach często też ten termin używany jest w odniesieniu do elementów dokumentu XML.[/idea]

## Element główny
  
Każdy poprawny dokument XML musi mieć wyłącznie jeden element główny (ang. _root element_). W przykładzie powyżej jest to element ``.
## Zawartość elementów
  
Elementy wewnątrz mogą zawierać treść. Na przykład wewnątrz elementu `` znajduje się treść `Wprowadzenie do XML w Javie`.

Elementy wewnątrz mogą zawierać kolejne elementy. Na przykład element `` zawiera wewnątrz elementy `` i ``. Można to porównać do drzewa gdzie z jednego pnia (elementu głównego) wyrasta kilka gałęzi (elementów zagnieżdżonych), zakończonych liśćmi. W praktyce mówiąc o liściach dokumentu XML mamy na myśli właśnie te najbardziej zagnieżdżone elementy. W naszym przykładzie będą to na przykład `` czy ``.

## Atrybuty
  
Elementy mogą posiadać dowolną liczbę atrybutów. Za przykład mogą posłużyć tu element `` zawierający atrybut `publikacja`. Zawartość atrybutu to zwykły tekst. W przeciwieństwie do elementów nie możemy stosować “zagnieżdżania” - wewnątrz atrybutu nie możemy umieścić niczego poza jego wartością.
## Przestrzenie nazw
  
Nazwy elementów elementów i atrybutów mogą zawierać tak zwaną “przestrzeń nazw” (ang. _namespace_). Do oddzielenia nazwy elementu czy atrybutu od przestrzeni nazw używa się dwukropka. W przykładzie powyżej element `` pochodzi z przestrzeni nazw `wydawca`.

Przestrzenie nazw stosuje się aby móc odróżnić znaczenie elementów o tej samej nazwie. W przykładzie elementy `` i `` mogą zawierać zupełnie różne dane - różne rodzaje opisów.

## Komentarze
  
Wewnątrz dokumentu XML możesz umieszczać komentarze. W przykładzie powyżej komentarz to ``. Wszystko co znajduje się pomiędzy `` uważane jest jako komentarz.
## Prolog
  
Dokument XML powinien zawierać prolog. Częścią prologu jest deklaracja `` zawiera ona informację o wersji XML, której używamy. Może także wskazać kodowanie znaków jakie zostało użyte w danym dokumencie. Wewnątrz prologu mogą znajdować się także deklaracje DTD (ang. _Document Type Declaration_) opisujące dany dokument. W opisie tym możemy na przykład określić, że element `` powinien zawsze zawierac element ``.
## Pozostałe wymagania dotyczące formatu
  
Każdy element musi się poprawnie zamykać. Na przykład `Marcin Pietraszek`. Jeśli element nie ma treści, bądź innych zagnieżdżonych elementów zamyka się go w następujący sposób ``.

Elementy powinny być poprawnie zagnieżdżone. Łatwiej będzie mi to wytłumaczyć na przykładzie. Poniżej możesz zobaczyć niepoprawny fragment dokumentu XML:

    

  
Zauważ, że element `tytul` zamknięty jest przed elementem `autor`. Jest to niepoprawny sposób zagnieżdżania elementów. Możemy powiedzieć, że elementy, które nie są poprawnie zagnieżdżone “nachodzą” na siebie.

Białe znaki pomiędzy elementami są ignorowane. W praktyce często używa się znaków tabulacji czy spacji do robienia "wcięć". Dzięki temu tak sformatowane dokumenty są bardziej czytelne.

# Rodzice, dzieci i rodzeństwo a XML
  
W przypadku poprawnie sformatowanych dokumentów XML możemy mówić o pewnych relacjach pomiędzy elementami. Specyfikacja XML mówi o rodzicach (ang. _parent_) i dzieciach (ang. _child_). W praktyce używa się także określenia rodzeństwo (ang. _sibling_).

Element może mieć wiele dzieci, na przykład element `` ma czworo dzieci - dwa elementy ``, element `` i element ``.

Każdy element, poza elementem głównym, posiada dokładne jednego rodzica. Na przykład element `` ma rodzica ``.

Każdy element, poza elementem głównym, może mieć rodzeństwo. Na przykład rodzeństwem dla elementu `` jest kolejny element ``, `` i ``.

# Walidacja dokumentów XML
  
Jak widzisz w dokumencie XML możemy zawrzeć praktycznie wszystko. Liczba dostępnych formatów jest nieskończona. W związku z tym istnieją różne mechanizmy pozwalające na walidację poprawności dokumentów XML.

Za przykład mogą tu posłużyć wspomniane wcześniej elementy DTD (ang. _Document Type Definition_) znajdujace się wewnątrz dokumentu XML.

Innym sposobem na walidację poprawnej struktury dokumentu XML jest używanie XSD (ang. _XML Schema Definition_). Jest to zewnętrzny plik, który także jest w formacie XML. Wewnątrz tego pliku możemy dokładnie określić strukturę jaką powinien mieć inny dokument XML.

Dzięki takiej walidacji możemy na przykład zastrzec, że zawsze wewnątrz elementu `` musi znajdować się element `` a element `` jest opcjonalny.

# Wady i zalety formatu XML
  
Główną zaletą pracy z dokumentami XML jest to, że istnieje mnóstwo narzędzi pozwalających na ich przetwarzanie. Dokumenty te są w miarę czytelne dla człowieka. Z łatwością format ten może służyć do wymiany informacji pomiędzy różnymi programami.

Niestety nie jest to format idealny. Przy pracy z dużymi plikami XML przekonasz się, że wcześniej wspomniana czytelność nie jest już tak oczywista. Ponadto pliki XML są dość “rozwlekłe”. Z racji konieczności zamykania każdego elementu, znaczników w dokumencie XML jest dużo i często to one znacząco zwiększają ostateczną wielkość dokumentu.

Ponadto dokumenty bardziej czytelne dla człowieka automatycznie zajmują więcej miejsca. To człowiek potrzebuje wcięć w dokumencie XML, dla programu używającego plików XML takie wcięcia są zbędne.

# Zastosowanie dokumentów w formacie XML
  
Z racji swojej dobrze zdefiniowanej struktury i ogromnego zestawu narzędzi dokumenty w formacie XML są bardzo popularne. Dedykowane narzędzia do pracy z XML dostępne są w wielu językach programowania. Dokumenty w formacie XML świetnie nadają się do zapisywania wszelkiego rodzaju ustawień.

Poniżej pokażę Ci kilka przykładowych zastosowań dokumentów w formacie XML:

- “poprzednik” [opisanego przeze mnie Gradle’a](http://www.samouczekprogramisty.pl/wstep-do-gradle/) - Maven używa XML w swoich plikach konfiguracyjnych - na przykład `settings.xml`, `profiles.xml` czy `plugin-registry.xml`. Główny plik konfiguracyjny dla projektu to także dokument XML - `pom.xml`,
- w jednym z banków, w którym pracowałem dokumenty XML wraz z XSLT służyły do generowania wszystkich drukowanych dokumentów,
- każda aplikacja na system Android używa plików XML. W uproszczeniu można powiedzieć, że opisują one wygląd ekranu aplikacji,
- dokumenty ODT (format używany na przykład przez Open Office), czy DOCX (format używany przez Microsoft Word) to tak na prawdę pliki zip, które wewnątrz zawierają dokumenty XML opisujące zawartość pliku, rozpakuj je a sam się przekonasz :)
  

# Na XML świat się nie kończy
  
Oczywiście dokumenty XML nie są jedynym formatem, który może pomóc w wymianie danych. Poniżej wspominam o kilku innych formatach, które mogą być także użyte w tym celu.
- CSV - (ang. _Comman Separated Values_) zwykły plik tekstowy, w którym każdy wiersz zawiera dane oddzielone przecinkami [2. Istnieją też inne wersje gdzie przecinek zastąpiony jest średnikiem czy znakiem tabulacji]. Z racji tego, że jest to plik tekstowy można go z łatwością odczytać używając edytora tekstu.
- [YAML](http://www.yaml.org/) - (ang. _Yet Another Markup Language_ lub _YAML Ain’t Markup Language_) tekstowy format, w którym możemy zapisywać bardziej złożone struktury czy kolekcje.
- [JSON](http://www.json.org/) - (ang. _JavaScript Object Notation_) podobnie jak YAML jest w stanie opisać listę elementów czy kolekcję par klucz-wartość. Format ten, jak jego nazwa wskazuje, powstał na potrzeby JavaScript, jednak obecne jest szeroko stosowany także w innych językach. Jest to format tekstowy.
  
  
Oczywiście poza formatami tekstowymi istnieją też formaty binarne:
- [ProtocolBuffers](https://developers.google.com/protocol-buffers/) - binarny format opracowany przez Google. Pozwala na zapisanie praktycznie dowolnych struktur. Z racji tego, że jest to format binarny jest bardziej “zwięzły” od wspomnianych powyżej. Oczywiście nie można odczytać tego formatu bez odpowiedniego “dekodowania” zawartości,
- [Avro](https://avro.apache.org/) - binarny format serializacji danych, podobnie jak ProtoclBuffers zapewnia dużo bardziej zwięzłą reprezentację danych. Ma wbudowany mechanizm kompresji co pozwala na jeszcze większe zmniejszenie objętości dokumentów.
  
  
Bynajmniej nie są to wszystkie dostępne formaty wymiany danych. Wspomniałem o tych kilku aby pokazać Ci, że na XML świat się nie kończy :) Każdy z tych formatów dorobił się szerokiego wsparcia w różnych językach programowania.
# Inne specyfikacje i narzędzia związane z XML
  
XML jako dość dojrzały format zapisu danych “dorobił się” zestawu narzędzi i specyfikacji. Na początek ten zestaw może okazać się przytłaczający, ale spokojnie - nie wszystkich tych narzędzi używa się w każdym projekcie. W większości przypadków wystarczy wiedza o poprawnym formacie dokumentu XML i znajomość jednego z narzędzi do tworzenia/czytania plików XML.

Lista poniżej to specyfikacje/narzędzia pozwalające na parsowanie i tworzenie plików w formacie XML:

- [DOM](https://www.w3.org/DOM/) (ang. _Document Object Model_),
- [SAX](http://www.saxproject.org/) (ang. _Simple API for XML_),
- StAX (ang. _Streaming API for XML_),
- [JAXB](https://jaxb.java.net/) (ang. _Java Architecture for XML Binding_).
  
  
W jednym z klejnych artykułów skupię się na praktycznym wykorzystaniu powyższych narzędzi.

Dodatkowo możesz też zainteresować się następującymi specyfikacjami związanymi z XML. Przydają się one w bardziej zaawansowanej pracy z dokumentami XML:

- [XSD](https://www.w3.org/TR/xmlschema-1/) (ang. _XML Schema Definition_) - wcześniej wspomniana specyfikacja pomagająca w walidacji poprawności dokumentów XML,
- [XPath](https://www.w3.org/TR/xpath/) (ang _XML Path Language_) - język pozwalający na wskazywanie elementów czy atrybutów w dokumencie XML, przy jego pomocy możesz na przykład określić "zwróć mi wszystkie elementy X, które mają atrybut Y o wartości Z",
- [XSLT](https://www.w3.org/TR/xslt) (ang. _Extensible Stylesheet Language Transformations_) - język służący do tranformowania dokumentów XML. Przy jego pomocy można przekształcić dokument XML do innych formatów, na przykład do pliku PDF.
  

# Podsumowanie
  
Po przeczytaniu artykułu wiesz już czym jest XML. Poznałeś część dozwolonych konstrukcji, wiesz czym są elementy i jak wygląda poprawnie sformatowany dokument XML. Potrafisz wskazać praktyczne zastosowania tego formatu, znasz też kilka jego zalet i wad. Przed Tobą użycie XML w praktyce, ale to już temat na kolejny artykuł :).

Mam nadzieję, że artykuł przypadł Ci do gustu. Jeśli nie chcesz pominąć kolejnych artykułów dopisz się do mojego newslettera i polub Samouczka na facebooku.

Na koniec mam do Ciebie standardową prośbę, podziel się linkiem do artykułu ze znajomymi, zależy mi na dotarciu do jak największej liczby samouków, którzy chcą pogłębiać swoją wiedzę. Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/stanzim/27926733595/sizes/l

