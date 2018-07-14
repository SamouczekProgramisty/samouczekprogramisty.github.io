---
layout: default
title: O mnie
date: '2015-10-12 04:55:07 +0200'
permalink: /o-mnie/
---
{% capture content %}
## O mnie
![Marcin Pietraszek]({{ "/assets/images/marcin_pietraszek.jpg" | absolute_url }}){: .align-left} 

Nazywam się Marcin Pietraszek, na Samouczku staram się zarazić Cię pasją do programowania. Sam pracuję jako programista od 2007 roku. Jeśli interesują Cię szczegóły dotyczące mojego doświadczenia zawodowego zapraszam na mój [profil na LinkedIn](https://pl.linkedin.com/in/marcinpietraszek).

Przygodę z programowaniem zacząłem na studiach ucząc się C, C++ i Javy. Pracowałem także z innymi językami programowania takimi jak Ruby, JavaScript czy Python. W miarę możliwości staram się pomagać innym nie tylko na blogu. Swego czasu pomagałem w organizacji [konferencji Ruby we Wrocławiu](http://www.wrocloverb.com/). Brałem udział jako wykładowca i wolontariusz w [Devoxx4Kids we Wrocławiu](http://www.devoxx4kids.pl/miasta/wroclaw.html). Obecnie pracuję programując głównie w Pythonie.

Mam ambitny cel. Zależy mi na tym, żeby Samouczek Programisty stał się miejscem, w którym programiści na różnych etapach swojej kariery zawodowej znajdą wartościowe materiały. Teksty wysokiej jakości, które pomogą im się rozwinąć. Pracuję nad blogiem, ponieważ pamiętam o tym jak ciężko było mi znaleźć wyczerpujące materiały przedstawione przystępnym językiem. Nie bez znaczenia są też opinie czytelników podobne do tych, które cytuję na stronie [O blogu]({{ '/o-blogu/' | absolute_url }}) ;).

Mam nadzieje, że publikowane przeze mnie treści będą dla Ciebie ciekawe i pomocne. Gdybyś jednak miał(a) jakiekolwiek pytania, propozycje czy uwagi proszę skontaktuj się ze mną. Postaram się pomóc. Mam świadomość, że nie jestem alfą i omegą, dlatego każda konstruktywna krytyka jest mile widziana.  Mój e-mail to `marcin małpka samouczekprogramisty.pl` :).

_Marcin - Samouk Naczelny ;)_

{% include figure image_path="/assets/images/samouczek.jpg" caption="Marcin programista" %}
{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
