1.
def dwieliczby(a, b):
    return a + b

wynik = dwieliczby(6, 7)
print(wynik)

2. 
def silnia(a):
    if a == 1:
        return 1
    else:
        return a * silnia(a - 1)

print(silnia(6)) 

3.
def odwroc(string):
    return string[::-1]

tekst = "skibidi"
print(odwroc(tekst))

4.
def pierwsza(a):
    if a < 2:
        return False
    for i in range(2, int(a**0.5) + 1):
        if a % i == 0:
            return False
    return True
print(pierwsza(0))

5.
def srednia(lista):
    return sum(lista) / len(lista)   
print(srednia([1,2]))
