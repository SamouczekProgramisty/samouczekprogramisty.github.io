---
layout: default
title: O mnie
date: '2015-10-12 04:55:07 +0200'
permalink: "/strefa-zadaniowa/"
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
