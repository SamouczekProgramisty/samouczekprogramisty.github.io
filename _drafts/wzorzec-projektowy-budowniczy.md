
W językach programowania, które traktują funkcje i klasy jako obywateli pierwszej kategorii (ang. _first class citizen_) budowniczy może być uproszczony. Na przykład w języku Python budowniczym może być po prostu klasa[^obiekt_klasy]. Może nim też być zwykła funkcja. Proszę spójrz na przykład

[^obiekt_klasy]: Właściwie jest to obiekt reprezentujący klasę.

```python
class StandardPackage:
    def wrap(self, content):
        print(f"wrapping {content} in standard paper")

class FancyPackage:
    def wrap(self, content):
        print(f"wrapping {content} in fancy paper")

class Sender:
    def __init__(self, package_factory):
        self.package_factory = package_factory

    def send(self, gift):
        package = self.package_factory()
        package.wrap(gift)
        print(f"sending package with {gift}")

if __name__ == "__main__":
    standard_sender = Sender(StandardPackage)
    fancy_sender = Sender(FancyPackage)

    standard_sender.send("book")
    fancy_sender.send("flowers")
```

Chociaż nie jest to fabryka zgodna z powszechnie znaną definicją
