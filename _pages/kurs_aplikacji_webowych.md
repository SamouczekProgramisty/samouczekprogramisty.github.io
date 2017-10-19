---
layout: default
title: Kurs aplikacji webowych
date: '2017-10-20 01:08:07 +0200'
permalink: /kurs-aplikacji-webowych/
---

{% assign posts = site.categories["Kurs aplikacji webowych"] %}

{% capture content %}

Do tej pory w ramach kursu aplikacji webowych ukazały się następujące artykuły:

{% for post in posts %}
 1. [{{post.title}}]({{post.url}})
{% endfor %}

Jeśli jakikolwiek temat nie jest dla Ciebie wystarczająco jasno opisany proszę daj znać, postaram się go rozwinąć w kolejnym artykule.
{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
