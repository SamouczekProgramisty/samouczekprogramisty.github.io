---
layout: default
title: Projekt Pogodynka
date: '2017-10-20 21:29:28 +0200'
permalink: /projekty/pogodynka/
---

{% assign posts = site.categories["Pogodynka"] %}

{% capture content %}

Projekt pogodynka opisywałem w następujących artykułach:

{% for post in posts %}
 1. [{{post.title}}]({{post.url}})
{% endfor %}

{% endcapture %}

<div id="main" role="main">
  {{ content | markdownify }}
</div>
