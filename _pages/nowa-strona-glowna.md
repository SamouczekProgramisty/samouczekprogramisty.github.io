---
layout: start_page
permalink: /nowa-strona-glowna/
header:
  overlay_image: /assets/images/splash/main_page_splash.jpg
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

      <p><a href="{{ post.url | absolute_url }}" class="btn btn--info">Czytaj dalej <i class="fa fa-caret-square-right"></i></a></p>
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

      <p><a href="{{ post.url | absolute_url }}" class="btn">Czytaj dalej</a></p>
    </div>
  {% endfor %}

  <div class="feature__item--center">
    <div class="archive__item">
      <div class="archive__item-excerpt">
        <p>Starsze artykuły możesz znaleźć w <a href="{{ '/archiwum/' | absolute_url }}"><i class="fa fa-archive"></i> archiwum Samouczka Programisty</a></p>
      </div>
    </div>
  </div>
</div>

<div class="feature__wrapper">
  <div class="feature__item--center">
    <div class="archive__item">
      <div class="archive__item-body">
        <h2 class="archive__item-title">Strefa kursów</h2>
      </div>
    </div>
  </div>
</div>

{% assign kursJava = site.pages | where: "course_id", "java" | first %}
{% assign kursWeb = site.pages | where: "course_id", "web" | first %}
{% assign kursSQL = site.pages | where: "course_id", "sql" | first %}

<div class="feature__wrapper">
  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ kursJava.permalink }}">
          <img src="{{ kursJava.header.overlay_image }}">
          <h3 class="c_item-teaser-title">{{ kursJava.title }}</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
      Java jest jednym z najbardziej popularnych języków programowania. Kurs ten pomoże Ci poznać składnię języka Java jak i część funkcjonalności dostępnych w bibliotece standardowej.
    </div>

    <p><a href="{{ kursJava.permalink }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
  </div>

  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ kursWeb.permalink }}">
          <img src="{{ kursWeb.header.overlay_image }}">
          <h3 class="c_item-teaser-title">{{ kursWeb.title }}</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
      W kursie tym poznasz podstawy programowania aplikacji webowych opartych o Java EE.
    </div>
    <p><a href="{{ kursWeb.permalink }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
  </div>
  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ kursSQL.permalink }}">
          <img src="{{ kursSQL.header.overlay_image }}">
          <h3 class="c_item-teaser-title">{{ kursSQL.title }}</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
      W kursie tym omawiam składnię języka SQL. Po przerobieniu tego kursu będziesz wiedzieć czym jest SQL i jak go używać do pracy z bazami danych.
    </div>
    <p><a href="{{ kursSQL.permalink }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
  </div>
</div>

<div class="feature__wrapper">
  <div class="feature__item--center">
    <div class="archive__item">
      <div class="archive__item-body">
        <h2 class="archive__item-title">Kategorie wpisów</h2>
      </div>
    </div>
  </div>
</div>
