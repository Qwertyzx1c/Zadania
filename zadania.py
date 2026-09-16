11.
def palindrom(a):
	a = input("Podaj wyraz do sprawdzenia: ").lower()

	if a == a[::-1]:
		print(True)
	else:
		print(False)
print(palindrom("kajak"))
palindrom("kajak")

12.
def liczby(a):
	try:
		return int(a)
	except ValueError:
		print(f"'{a}' to nie liczba!")
		return None

wynik = liczby("konstantynopolitańczykowianeczka")
print(f"Wynik działania funkcji: {wynik}")

13.
def inicjaly(a):
	wyraz = a.split()
	return wyraz[0][0].upper()+ "." + wyraz[1][0].upper() + "."
print(inicjaly("Jan Kowalski"))

14.
def duplikaty(lista):
	return list(set(lista))
print(duplikaty(lista = [1,2,3,4,5,6,7,7]))

15.
def uzytkownik(username,**kwargs):
	return {"username": username, **kwargs}
print(uzytkownik({
    'role' : 'admin',
    'height' : 'good'
 }))

16.
def engram(a, b):
	return sorted(a.lower()) == sorted(b.lower())
print(engram("JOHNNY", "SILVERHAND"))

17.
def licz(lista):
	wynik = {}

	for x in lista:
		wynik[x] = wynik.get(x, 0) + 1
		return wynik
print(licz("Kawa wjechała"))

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
