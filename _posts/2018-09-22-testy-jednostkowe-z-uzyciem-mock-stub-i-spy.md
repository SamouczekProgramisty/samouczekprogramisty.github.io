---
title: Testy jednostkowe z użyciem mock, stub i spy
categories:
- Testy jednostkowe
- Dobre praktyki
permalink: /testy-jednostkowe-z-uzyciem-mock-stub-i-spy/
header:
    teaser: /assets/images/2018/09/22_testy_z_mock_stub_i_spy_w_jezyku_java.jpeg
    overlay_image: /assets/images/2018/09/22_testy_z_mock_stub_i_spy_w_jezyku_java.jpeg
    caption: "[&copy; Sebastian Molina](https://unsplash.com/photos/gYo3B_9So3Y)"
excerpt: >
    W artykule tym przeczytasz o różnicy pomiędzy obiektami pomocniczymi użwanymi w testach jednostkowych\: _mock_, _stub_ i _spy_. Zobaczysz przykłady takich obiektów. Dowiesz się dlaczego obiekty tego typu używane są w testach jednostkowych. Poznasz też bibliorekę Mockito, która pozwala na pisanie testów jednostkowych wykorzystujących te abstrakcje. Zapraszam do lektury.
---

Nie podoba mi się używanie nazw anglojęzycznych w branży IT. Zawsze staram się znaleźć polskie odpowiedniki używanych słów. Są jednak takie sytuacje, w których terminy angielskie są tak rozpowszechnione, że nawet nie silę się na znajdowanie polskich odpowiedników. Przykładem takich słów są _mock_ (atrapa?), _stub_ (zaślepka?) czy _spy_ (szpieg?). Jeśli znasz dobre tłumaczenia tych określeń proszę podziel się nimi w komentarzach. Z chęcią zacznę stosować polskie słowa, które będą zrozumiałe w branżowych rozmowach.
{:.notice--info}

## Jednostka w testach jednostkowych

W artykule [wprowadzającym do testów jednostkowych]({% post_url 2016-10-29-testy-jednostkowe-z-junit %})

## Trzej muszkieterowie testów jednostkowych - _mock_, _stub_ i _spy_

Czasami na rozmowach kwalifikacyjnhych może pojawić się pytanie _czym różni się mock od stub?_.

Jeśli chcesz dowiedzieć się więcej na ten temat mogę polecić Ci, artykuł autorstwa Martin'a Fowler'a, który można traktować już jako klasykę [Mocks aren't stubs](https://martinfowler.com/articles/mocksArentStubs.html). Fowler podaje w nim przykłady używając [JUnit4]({% post_url 2016-10-29-testy-jednostkowe-z-junit %}) wraz z jMock i EasyMock.

### Mock

Napisz program, który będzie implementował następujący interfejs:

```java
```

Informacja o historycznych kursach walut udostępniana jest przez NBP. Dokumentacja API dostępna jest na [stronie NBP](http://api.nbp.pl/#kursyWalut). W praktyce potrzebny będzie wyłącznie ten adres:
`http://api.nbp.pl/api/exchangerates/rates/a/<kod>/<data>/?format=json`

Na przykład, żeby pobrać kurs dla dolara amerykańskiego (kod waluty `USD`) dla 5 IV 2016 trzeba wysłać [zapytanie typu `GET`]({% post_url 2018-02-08-protokol-http %}) pod adres `http://api.nbp.pl/api/exchangerates/rates/a/usd/2016-04-05/?format=json`. Odpowiedź, którą dostaniesz będzie wyglądać następująco:

```json
{
	"table": "A",
    "currency": "dolar amerykański",
    "code": "USD",
    "rates": [{
		"no": "065/A/NBP/2016",
		"effectiveDate": "2016-04-05",
		"mid": 3.7337
	}]
}
```

Do parsowania odpowiedzi tego typu przydatna jest biblioteka, która obsługuje [parsowanie formatu JSON]().

## Czy jest mock

## Czym jest stub

## Czym jest spy

## Zadanie do wykonania


## Podsumowanie

