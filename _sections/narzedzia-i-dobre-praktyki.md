---
layout: single_page
title: Narzędzia i dobre praktyki
permalink: /narzedzia-i-dobre-praktyki/
header:
  teaser: /assets/images/splash/dzial_narzedzia_i_dobre_praktyki.jpg
  overlay_image: /assets/images/splash/dzial_narzedzia_i_dobre_praktyki.jpg
  caption: "[&copy; Nicolas Hoizey](https://unsplash.com/photos/2MuZ23gkFKo)"
---

{% assign posts = site.categories["Strefa zadaniowa"] | sorted %}

{% capture content %}

Do tej pory w Strefie Zadaniowej ukazały się następujące artykuły:

{% for post in posts %}
 1. [{{post.title}}]({{post.url}})
{% endfor %}

Jeśli jakikolwiek temat nie jest dla Ciebie wystarczająco jasno opisany proszę daj znać, postaram się go rozwinąć w kolejnym artykule.
{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
