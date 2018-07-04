---
layout: default
title: O mnie
date: '2015-10-12 04:55:07 +0200'
permalink: /o-mnie/
---
{% capture opinia1 %}
![image-left]({{ "/assets/images/opinie/adrian.jpeg" | absolute_url }}){: .align-left} 
> Zacznę od tego, że wykonujesz kawał świetnej roboty i za to po pierwsze szczere podziękowania, a po drugie szczere gratulacje! W mojej ocenie, ze wszystkich materiałów w sieci, Twój kurs jest najbardziej spójny i najchętniej z niego korzystam.

> Adrian Galus
{% endcapture %}
{% capture content %}
## O mnie

Nazywam się Marcin Pietraszek, na Samouczku staram się zarazić Cię pasją do programowania. Sam pracuję jako programista od 2007 roku. Jeśli jesteś zainteresowany szczegółami dotyczącymi mojego doświadczenia zawodowego zapraszam na mój [profil LinkedIn](https://pl.linkedin.com/in/marcinpietraszek).

Przygodę z "prawdziwy" programowaniem zacząłem na studiach ucząc się C, C++ i Javy. Pracowałem także z innymi językami programowania takimi jak Ruby, JavaScript czy Python. W miarę możliwości staram się pomagać innym nie tylko na blogu. Swego czasu pomagałem w organizacji [konferencji Ruby we Wrocławiu](http://www.wrocloverb.com/). Brałem udział jako wykładowca i wolontariusz w [Devoxx4Kids we Wrocławiu](http://www.devoxx4kids.pl/miasta/wroclaw.html). Obecnie pracuję programując głównie w Pythonie.

Mam ambitny cel. Zależy mi na tym, żeby Samouczek Programisty stał się miejscem, w którym programiści na różnych etapach swojej kariery zawodowej znajdą wartościowe materiały. Teksty wysokiej jakości, które pomogą im się rozwinąć. Pracuję na blogiem ponieważ pamiętam o tym jak ciężko było mi znaleźć wyczerpujące materiały przedstawione przystępnym językiem.

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

## O blogu

Blog Samouczek Programisty prowadzę od października 2015 roku. Adresy e-mail od Czytelników zacząłem zbierać w połowie 2017 roku. Kilka statystyk dotyczących Samouczka Programisty (stan na 04.07.2018):
- aktualnie na liście subskrybentów Samouczkowego Newslettera znajduje się 471 Czytelników,
- [profil na Facebooku](https://www.facebook.com/SamouczekProgramisty) polubiły 1563 osoby,
- pod artykułami znajduje się 600 komentarzy.

Poniżej fragment raportu Google Analytics, którego używam do analizowania ruchu na stronie. Pokazuje on, że blog Samouczek Programisty w czerwcu 2018 odwiedziło 31'064 Samouków (z czego 30,5% to Czytelnicy powracający na blog):

{% include figure image_path="/assets/images/stats/users_201806.jpeg" caption="Liczba unikalnych użytkowników odwiedzających blog w czerwcu 2018" %}

{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
