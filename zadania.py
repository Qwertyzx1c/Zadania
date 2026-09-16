18.
def maskuj(numer):
    if len(numer) < 4:
        return numer
    return "*" * (len(numer) - 4) + numer[-4:]

print(maskuj("1234567890123456"))

19.
def rownanie(a, b):
    if a != 0:
        return -b / a
    elif b == 0:
        return "tożsamościowe"
    else:
        return "sprzeczne"

print(rownanie(2, 4))

20.
def dzielenie(a, b):
    if b == 0:
        return None
    return (a // b, a % b)

print(dzielenie(17, 5))

21.
def splaszcz(lista):
    wynik = []
    
    for podlista in lista:
        for element in podlista:
            wynik.append(element)
    
    return wynik

print(splaszcz([[1, 2], [3, 4]]))

22.
def filtruj(slowa, n):
    wynik = []
    
    for slowo in slowa:
        if len(slowo) >= n:
            wynik.append(slowo)
    
    return wynik

print(filtruj(["kot", "samochod", "dom", "komputer"], 5))

23.
def odwroc(zdanie):
    return " ".join(zdanie.split()[::-1])

print(odwroc("Ala ma kota"))

24.
def wiek(wiek):
    if wiek < 12:
        return "dziecko"
    elif wiek < 18:
        return "nastolatek"
    elif wiek <= 65:
        return "dorosły"
    else:
        return "senior"

print(wiek(20))
