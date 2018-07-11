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

<div class="feature__wrapper">
  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ '/kurs-programowania-java/' | absolute_url }}">
          <img src="{{ '/assets/images/temp/missing.png' | absolute_url }}">
          <h3 class="c_item-teaser-title">Kurs programowania Java</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
Java jest jednym z najbardziej popularnych języków programowania. Cykl artykułów poświęconych programowaniu
    </div>

    <p><a href="{{ '/kurs-programowania-java/' | absolute_url }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
  </div>
  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ '/kurs-aplikacji-webowych/' | absolute_url }}">
          <img src="{{ '/assets/images/temp/missing.png' | absolute_url }}">
          <h3 class="c_item-teaser-title">Kurs programowania aplikacji webowych</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
      Tutaj znajdziesz wszystkie archiwalne artykuły, które ukazały się na blogu. Zaczynając od najmłodszego do najstarszego, który opublikowałem w październiku 2015 roku.
    </div>
    <p><a href="{{ '/kurs-aplikacji-webowych/' | absolute_url }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
  </div>
  <div class="feature__item">
    <div class="archive__item">
      <div class="archive__item-teaser c_item-teaser">
        <a href="{{ '/kurs-sql/' | absolute_url }}">
          <img src="{{ '/assets/images/temp/missing.png' | absolute_url }}">
          <h3 class="c_item-teaser-title">Kurs SQL</h3>
        </a>
      </div>
    </div>
    <div class="archive__item-excerpt">
      Tutaj znajdziesz wszystkie archiwalne artykuły, które ukazały się na blogu. Zaczynając od najmłodszego do najstarszego, który opublikowałem w październiku 2015 roku.
    </div>

    <p><a href="{{ '/kurs-sql/' | absolute_url }}" class="btn btn--primary">Przejdź do kursu <i class="fa fa-caret-square-right"></i></a></p>
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
