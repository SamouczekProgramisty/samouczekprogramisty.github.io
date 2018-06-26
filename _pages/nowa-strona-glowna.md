---
layout: start_page
permalink: /nowa-strona-glowna/
header:
  overlay_image: /assets/images/splash.jpg
excerpt: Twój mentor na drodze do programowania
frwstep:
  - title: 'Najnowsze artykuły'
---

{% include feature_row id="frwstep" type="center" %}

<div class="feature__wrapper">
  {% for post in site.posts limit:3 %}
    <div class="feature__item{% if include.type %}--{{ include.type }}{% endif %}">
      <div class="archive__item">
        {% if post.header.teaser %}
          {% if post.header.teaser contains "://" %}
            {% assign img_url = post.header.teaser %}
          {% else %}
            {% assign img_url = post.header.teaser | absolute_url %}
          {% endif %}
          <div class="archive__item-teaser c_item-teaser">
              <a href="{{ post.url | absolute_url }}">
                  <img src="{{ img_url }}" alt="{% if post.alt %}{{ post.alt }}{% endif %}">
                  {% if post.title %}
                      <h3 class="c_item-teaser-title">
                          {{ post.title }}
                      </h3>
                  {% endif %}
              </a>
          </div>
        {% endif %}

        <div class="archive__item-body">
          {% if post.excerpt %}
            <div class="archive__item-excerpt">
              {{ post.excerpt | truncatewords: 20 | markdownify }}
            </div>
          {% endif %}

          {% if post.url %}
            <p><a href="{{ post.url | absolute_url }}" class="btn {{ post.btn_class }}">Czytaj dalej</a></p>
          {% endif %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>

<div class="page__hero--overlay" style="background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('{{ '/assets/images/archiwum.jpg' | absolute_url }}');">
  <div class="wrapper">
    <h2 class="page__title">Archiwum Samouczka Programisty</h2>
    <p class="page__lead">Tutaj znajdziesz wszystkie archiwalne artykuły, które ukazały się na blogu.</p>
    <p><a href="{{ '/archiwum/' | absolute_url }}" class="btn btn--light-outline btn--large"><i class="fa fa-archive"></i> Przejdz do archiwum</a></p>
  </div>
</div>
