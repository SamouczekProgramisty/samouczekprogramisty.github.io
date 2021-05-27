Marek

Hmmm.... jakoś tego nie mogę zrozumieć. Czy to znaczy, że Tworzy się dwie instancje jednej tabeli i w jakiś sposób deklaruje się, że w drugiej tabeli będzie waga, a w pierwszej tylko name? nie rozumiem jak się ma GROUP BY u1.name do HAVING SUM(u2.weight) skąd on wie, że jak będzie warunek spełniony dla u2, to pokaze odpowienie u1? No i jak to jest możliwe, że u1.name jest większe niż u2.name.

Przypuszczam, że jeżeli zrozumiem, to, co napisałem czyli jak się porównuje wartości z name i jak się mają relacje u1 do u2 (i że w ogóle można tak sobie zrobić) to raczej zrozumiem o co w tym chodzi. Z góry dziękuję.

Dana jest tabela: (Id, Name, Weight) Do windy wchodzą kolejno osoby. Winda ma ograniczenie pojemności do 1000 kg. Zadanie: Napisz funkcję, która pokaże ostatnią osobę, która wejdzie do windy.

id name weight

1 x 200
2 y 300
3 z 400
4 z 500

select sum(weight) over (order by id)


SELECT *
  FROM users
 WHERE name <= (SELECT u1.name
                  FROM users AS u1
                      ,users AS u2
                 WHERE u1.name >= u2.name
              GROUP BY u1.name
                HAVING SUM(u2.weight) <= 1000
                 LIMIT 1);
