---
layout: start_page
permalink: /nowa-strona-glowna/
header:
  overlay_image: /assets/images/splash.jpg
excerpt: Twój mentor na drodze do programowania
---

{% include feature_row id="frwstep" type="center" %}
{% assign newest = site.posts.first %}

<div class="feature__wrapper">
  <div class="feature__item--left">
    <div class="archive__item">
      {% if newest.header.teaser contains "://" %}
        {% assign img_url = newest.header.teaser %}
      {% else %}
        {% assign img_url = newest.header.teaser | absolute_url %}
      {% endif %}
      <div class="archive__item-teaser c_item-teaser">
          <a href="{{ newest.url | absolute_url }}">
              <img src="{{ img_url }}" alt="{% if newest.alt %}{{ newest.alt }}{% endif %}">
              {% if newest.title %}
                  <h3 class="c_item-teaser-title">
                      {{ newest.title }}
                  </h3>
              {% endif %}
          </a>
      </div>
    </div>
	<div class="archive__item-body">
      <h2 class="archive__item-title c_item-title">Najnowszy artykuł</h2>
      <div class="archive__item-excerpt">
        {{ newest.excerpt | markdownify }}
      </div>

      <p><a href="{{ post.url | absolute_url }}" class="btn btn--info">Czytaj dalej</a></p>
    </div>
  </div>
</div>

<div class="feature__wrapper">
  {% for post in site.posts limit:6 offset:1 %}
    <div class="feature__item">
      <div class="archive__item">
        {% if post.header.teaser contains "://" %}
          {% assign img_url = post.header.teaser %}
        {% else %}
          {% assign img_url = post.header.teaser | absolute_url %}
        {% endif %}
        <div class="archive__item-teaser c_item-teaser">
          <a href="{{ post.url | absolute_url }}">
            <img src="{{ img_url }}" alt="{% if post.alt %}{{ post.alt }}{% endif %}">
            <h3 class="c_item-teaser-title">
              {{ post.title }}
            </h3>
          </a>
        </div>
      </div>
      <div class="archive__item-excerpt">
        {{ post.excerpt | truncatewords: 20 | markdownify }}
      </div>

      <p><a href="{{ post.url | absolute_url }}" class="btn btn--primary">Czytaj dalej</a></p>
    </div>
  {% endfor %}
</div>

<div class="page__hero--overlay" style="background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('{{ '/assets/images/archiwum.jpg' | absolute_url }}');">
  <div class="wrapper">
    <h2 class="page__title">Archiwum Samouczka Programisty</h2>
    <p class="page__lead">Tutaj znajdziesz wszystkie archiwalne artykuły, które ukazały się na blogu. Zaczynając od najmłodszego do najstarszego, który opublikowałem w październiku 2015 roku.</p>
    <p><a href="{{ '/archiwum/' | absolute_url }}" class="btn btn--light-outline btn--large"><i class="fa fa-archive"></i> Przejdz do archiwum</a></p>
  </div>
</div>
