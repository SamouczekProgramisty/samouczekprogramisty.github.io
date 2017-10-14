---
layout: single
title: Pogodynka - konfiguracja serwera
date: '2017-04-30 12:13:51 +0200'
categories:
- DSP2017
- Projekty
- Pogodynka
excerpt_separator: "<!--more-->"
permalink: "/pogodynka-konfiguracja-serwera/"
---
We wpisie tym podsumowuję postęp prac nad projektem Pogodynka. W tym tygodniu wyłącznie devops. Pokrótce opiszę Ci moje przygody z konfiguracją VPS przy pomocy Puppet’a.

# Konfiguracja maszyny produkcyjnej
  
Chociaż do konfiguracji produkcyjnej daleko, będę tutaj pisał o “serwerze produkcyjnym”. Mam tu na myśli VPS (ang. _Virtual Private Server_), na którym uruchomiona będzie baza danych oraz Tomcat. To właśnie do tej maszyny Malinka wysyłała będzie informacje o odczytach temperatury. Ta sama maszyna posłuży do uruchomienia aplikacji webowej pokazującej interfejs użytkownika.
# Namiastka produkcji
  
Konfiguracja ta nijak nie przypomina “produkcji z prawdziwego zdarzenia”. Nie ma tu mowy o sensownym monitorowaniu czy zapewnieniu niezawodności. Mam świadomość tych niedociągnięć :). Jak na hobbystyczny projekt konfiguracja tego typu powinna być wystarczająco dobra. Oczywiście przy takiej konfiguracji nie zapewnię dostępności na poziomie [pięciu dziewiątek](https://en.wikipedia.org/wiki/High_availability) (nawet, chyba dwóch nie dałbym rady ;)).

Aby poprawić tę konfigurację musiałbym poświęcić na nią więcej czasu i zapłacić więcej za utrzymanie finalnego środowiska. “Budżetu” na Pogodynkę, nie chciałbym powiększać, więc zostanę przy aktualnych ustawieniach. Akceptuję te niedociągnięcia z racji tego, że projekt ten nie jest krytyczny.

# Zarządzanie konfiguracją
  
Mógłbym skonfigurować maszynę ręcznie. Na pewno byłoby to szybsze niż zabawa, którą zaraz opiszę. Jednak tego typu podejście prowadzi do sytuacji, w której odtworzenie konfiguracji jest ciężkie. Chciałbym tego uniknąć.

Konfiguracja maszyny produkcyjnej zarządzana jest przy pomocy [Puppet’a](https://docs.puppet.com/puppet/3.7/index.html). Całość trzymana jest w repozytorium razem z kodem. Dzięki takiemu podejściu wiem dokładnie co, jak i kiedy zostało zmienione. A co najważniejsze mogę tę konfigurację szybko odtworzyć.

## Czym jest Puppet
  
Puppet to narzędzie, które pomaga zarządzać konfiguracją maszyn. Puppet używa tak zwanych manifestów, które określają konfigurację danej maszyny. Wewnątrz manifestów używany jest DSL (ang. _Domain Specific Language_), który ułatwia tę konfigurację.

Przy pomocy tego narzędzia i odpowiednich manifestów możemy na przykład zainstalować bazę danych, odpowiednią wersję Javy czy Tomcat’a.

Manifesty z konfiguracją pakowane są w tak zwane moduły. W moim przypadku używam na przykład modułów do instalacji Tomcat’a czy zarządzania regułami firewalla. Mogę śmiało powiedzieć, że konfiguracja większości standardowych rzeczy dostępna jest w odpowiednim module.

## Kod odpowiedzialny za konfigurację
  
Aby niepotrzebnie nie komplikować sprawy uruchamiam Puppeta w trybie “samodzielnym”. Nie ma tutaj standardowej maszyny, z której pobierana jest konfiguracja ("puppet mastera"). Jest to uproszczenie, które w tym przypadku jest akceptowalne.

Cały katalog modułów trzymam w repozytorium git. Zewnętrzne moduły puppeta dodałem do repozytorium jako [submoduły git’a](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/.gitmodules).

    $ git submodule status 3f6863ac4c97f834bebc811852452b073d202682 puppet/modules/apt (2.4.0) 5c4a9141d08a7b23dcada029d23b82590632d0f4 puppet/modules/concat (2.2.1) 23016934d23c5c2f3f3edbc2ec8279f8faac2457 puppet/modules/firewall (1.8.2) 5b01b42e2228d9c979f7fcbdfac5b926f25f5dea puppet/modules/postgresql (4.9.0) ec1ce78c1ec0c82d440cb5d1b98a065c858d3c0e puppet/modules/staging (0.4.1) 1ae06c50acc89be4dea28b6e85b5a23f479f584e puppet/modules/stdlib (4.16.0) e545ac740122c9a873aec66b24148a43dd65f9ef puppet/modules/tomcat (1.6.1)

  
Dzięki takiemu podejściu zawsze (jak tylko github i repozytoria modułów są dostępne ;)) mam dostęp do całości konfiguracji.
# Konfiguracja przy pomocy Puppet’a
  
Wykupiłem VPS w jednej z firm. Zainstalowałem tam obraz z Debianem Jessie. W tym miejscu zaczyna się zabawa ;).
## Instalacja Javy
  
Zacznijmy od Javy. Instalacja Javy 8 na Debianie 8 nie jest trywialna :). Chodzi mi tu o Javę od Oracle. OpenJDK można zainstalować z “backports”. Po zabawie z kluczami do apt udało mi się Javę zainstalować:

    class pogodynka::java { $package = "oracle-java8-installer" $responsefile = "/var/cache/debconf/${package}.preseed" file { 'java-apt-list': path => '/etc/apt/sources.list.d/webupd8team-java.list', content => "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main\ndeb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"; 'java-apt-key': path => '/etc/apt/trusted.gpg.d/webupd8.gpg', source => 'puppet:///modules/pogodynka/webupd8.gpg'; $responsefile: ensure => 'present', content => "${package} shared/accepted-oracle-license-v1-1 select true"; } package { 'oracle-java8-installer': ensure => 'latest', responsefile => $responsefile, require => [File['java-apt-list'], File['java-apt-key'], Class['apt::update']]; 'oracle-java8-set-default': ensure => 'latest', require => Package['oracle-java8-installer']; }}

## Tomcat
  
Podobnie jak w przypadku firewalla użyłem [istniejącego modułu](https://forge.puppet.com/puppetlabs/tomcat).

Cała konfiguracja sprowadza się do kilku linijek:

    $catalina_home = '/opt/tomcat8.5'$catalina_base = "${catalina_home}/production"tomcat::install { '/opt/tomcat8.5': source_url => 'http://mirror.23media.de/apache/tomcat/tomcat-8/v8.5.14/bin/apache-tomcat-8.5.14.tar.gz';}tomcat::instance { 'tomcat8.5-production': catalina_home => $catalina_home, catalina_base => $catalina_base;}

  
Sam Tomcat uruchamiany jest z poziomu użytkownika tomcat. Z tego powodu nie mogę uruchomić go tak aby nasłuchiwał na domyślnym porcie HTTP. Tomcat słucha na 8080.
## Firewall
  
Podobnie jak w przypadku Tomcat'a użyłem [istniejącego modułu](https://forge.puppet.com/puppetlabs/firewall). Oczywiście nie chcę otwierać na świat serwera produkcyjnego. Sytuacja, w której na przykład baza danych była dostępna z zewnątrz jest zła. Domyślnie chcę mieć otwarty mały podzbiór portów. Oczywiście standardowy port 80 dla HTTP i 22 dla SSH potrzebuję, resztę trzeba wyciąć.

To się musiało stać, w trakcie zabawy z konfiguracją firewall odciąłem sobie dostęp po SSH. Skończyło się to reinstalacją Debiana na nowo. Całe szczęście cała konfiguracja trzymana jest w repozytorium więc odtworzenie poprzedniego stanu sprowadziło się do kilku komend:

    wget https://raw.githubusercontent.com/SamouczekProgramisty/Pogodynka/master/puppet/bootstrap.shchmod +x bootstrap.sh./bootstrap.sh

  
Poza wycięciem portów za pomocą konfiguracji firewalla będę musiał zrobić przekierowanie ruchu z portu 80 na 8080. Ta część jeszcze przede mną ;).
# Podsumowanie
  
Konfiguracja jeszcze nie jest gotowa. Jeśli chcesz zobaczyć jej aktualną wersję możesz rzucić okiem na [samouczkowego githuba](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/puppet). Jeszcze męczę się z dopięciem niektórych elementów. W każdym razie postęp, mały bo mały, jest. Do końca projektu zostały jeszcze trzy tygodnie. Trzymaj za mnie kciuki ;). Do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/joseywales/316407052/sizes/o/

