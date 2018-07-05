---
layout: default
title: O mnie
date: '2015-10-12 04:55:07 +0200'
permalink: /o-mnie/
---
{% capture opinia1 %}
![Adrian Galus]({{ "/assets/images/opinie/adrian.jpeg" | absolute_url }}){: .align-left} 
> Zacznę od tego, że wykonujesz kawał świetnej roboty i za to po pierwsze szczere podziękowania, a po drugie szczere gratulacje! W mojej ocenie, ze wszystkich materiałów w sieci, Twój kurs jest najbardziej spójny i najchętniej z niego korzystam.

> Adrian Galus
{% endcapture %}
{% capture opinia2 %}
![Łukasz Chojnowski]({{ "/assets/images/opinie/lukasz.jpeg" | absolute_url }}){: .align-left} 
> Na stronę Marcina trafiłem poszukując kursu Javy od podstaw. Po pierwszym oglądzie zakresu podjąłem próbę przejścia go w całości. I tu pierwsze miłe zaskoczenie, bo treści przekazywane przez Marcina są napisane bardzo przystępnym językiem i z przyjemnością się je czyta. Realizując zadania pod lekcjami zaskoczyłem się kolejny raz, gdyż Marcin komentuje każdy wrzucony kod, co pomaga bardzo w eliminowaniu błędów. Zwłaszcza, jeżeli ucząc się próbuje się zrobić zadanie różnymi drogami. Dzięki temu od razu wiem czy mój pomysł na rozwiązanie jest właściwy. Jeżeli ktokolwiek rozważa naukę Javy od podstaw to z całą pewnością z pomocą Marcina i jego kursu osiągnie swój cel z całkiem niezłym rezultatem. Podstawy tu zdobyte będą bardzo solidne.

> Łukasz Chojnowski
{% endcapture %}
{% capture content %}
## O mnie

Nazywam się Marcin Pietraszek, na Samouczku staram się zarazić Cię pasją do programowania. Sam pracuję jako programista od 2007 roku. Jeśli interesują Cię szczegóły dotyczące mojego doświadczenia zawodowego zapraszam na mój [profil na LinkedIn](https://pl.linkedin.com/in/marcinpietraszek).

Przygodę z programowaniem zacząłem na studiach ucząc się C, C++ i Javy. Pracowałem także z innymi językami programowania takimi jak Ruby, JavaScript czy Python. W miarę możliwości staram się pomagać innym nie tylko na blogu. Swego czasu pomagałem w organizacji [konferencji Ruby we Wrocławiu](http://www.wrocloverb.com/). Brałem udział jako wykładowca i wolontariusz w [Devoxx4Kids we Wrocławiu](http://www.devoxx4kids.pl/miasta/wroclaw.html). Obecnie pracuję programując głównie w Pythonie.

Mam ambitny cel. Zależy mi na tym, żeby Samouczek Programisty stał się miejscem, w którym programiści na różnych etapach swojej kariery zawodowej znajdą wartościowe materiały. Teksty wysokiej jakości, które pomogą im się rozwinąć. Pracuję nad blogiem, ponieważ pamiętam o tym jak ciężko było mi znaleźć wyczerpujące materiały przedstawione przystępnym językiem.

Mam nadzieje, że publikowane przeze mnie treści będą dla Ciebie ciekawe i pomocne. Gdybyś jednak miał(a) jakiekolwiek pytania, propozycje czy uwagi proszę skontaktuj się ze mną. Postaram się pomóc. Mam świadomość, że nie jestem alfą i omegą, dlatego każda konstruktywna krytyka jest mile widziana ;).  Mój e-mail to `marcin małpka samouczekprogramisty.pl` :).

_Marcin_

{% include figure image_path="/assets/images/samouczek.jpg"  caption="Marcin programista" %}

### Opinie czytelników

Od czasu do czasu dostaję wiadomości od Was, Czytelników bloga. To właśnie tego typu wiadomości motywują mnie do dalszej pracy nad blogiem. Za każdym razem jak czytam wiadomości tego typu od razu buzia sama mi się uśmiecha. Jeszcze raz bardzo dziękuję Wam za miłe słowa :)

<hr>
<p>
  {{ opinia1 | markdownify }}
</p>
<hr class="cf">
<p>
  {{ opinia2 | markdownify }}
</p>
<hr class="cf">

## O blogu

Blog Samouczek Programisty prowadzę od października 2015 roku. Samouczkowy Newsletter zacząłem budować w połowie 2017 roku. Kilka statystyk dotyczących Samouczka Programisty (stan na 05.07.2018):
- na liście subskrybentów Samouczkowego Newslettera znajduje się 484 Czytelników,
- [profil na Facebooku](https://www.facebook.com/SamouczekProgramisty) polubiły 1565 osoby,
- pod artykułami znajduje się 600 komentarzy.

Poniżej fragment raportu Google Analytics, którego używam do analizowania ruchu na stronie. Pokazuje on, że blog Samouczek Programisty w czerwcu 2018 odwiedziło 31'064 Samouków (z czego 30,5% to Czytelnicy powracający na blog):

{% include figure image_path="/assets/images/stats/users_201806.jpeg" caption="Liczba unikalnych użytkowników odwiedzających blog w czerwcu 2018" %}

{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
