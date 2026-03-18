lista = [1,2,3,4,5,6,7]


slownik = {
    'name' : 'John',
    'age' : '30',
    'height' : 'good'
 }
1.
print(lista[0])
print(lista[6])

2.
lista.append(69)
print(lista)

3.
lista.remove(7)
print(lista)

4.
if 2 in lista:
    print('Tak')
else:
    print('Nie')

5.
for lista in range(7):
    print(lista)

6.
slownik = {
    'John' : '30',
    'Noli' : '10000000'
  }

7.
slownik["status"] = "married"
print(slownik)

8.
del slownik['height']
print(slownik)
9.
if 'name' in slownik:
    print('Prawda')
10. 
for key, value in slownik.items():
    print(f"Klucz: {key}, wartosc: {value}")
