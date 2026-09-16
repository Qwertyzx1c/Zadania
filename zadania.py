1.
def temperatura(a):
	fahrenheit = (a * 1.8) + 32
	return fahrenheit

2.
def even(a):
	if a in range(2, 100, 2):
		return True
	else:
		return False

print(even(2))

3.
def cześć(imie ="Użytkowniku", grzecznosc ="Cześć"):
	print(f"{grzecznosc}, {imie}!")
cześć("Jakub", "Hola!")

4.
def list_liczb(lista):

    najmniejsza = min(lista)
    najwieksza = max(lista)

    return (najmniejsza, najwieksza)


liczby = [4, -2, 15, 0, 8, -7, 12]

wynik = list_liczb(liczby)

print(wynik) 

5.
def samogloski(tekst):
    samogloski = ("a", "e", "i", "o", "u", "y")
    return sum(1 for znak in tekst.lower() if znak in samogloski)

print(samogloski("skibidi"))  
print(samogloski("ale sigma"))

6.
def dodatnie(a):
    wynik = []
    for i in a:
        if i > 0:
            wynik.append(i)
    return wynik

print(dodatnie(a = (1, 7, 20, -50, -132123)))

7.
def przecena(cena, rabat):
     if cena >= 0 and rabat > 0 and rabat < 101:
          return round(cena * (1 - rabat / 100), 2)
     else:
          return None
print(przecena(99, 2))

8.
slownik = {
     "znaki": " ",
     "ilosc wyrazow": " ",
     "ilosc spacji": " "
}

def	statystyki(zdanie ,slownik):
	z = len(zdanie)
	s = len(zdanie.split())
	sp = zdanie.count(" ", 0, len(zdanie))

	slownik["znaki znaki"] = z
	slownik["ilosc wyrazow"] = s
	slownik["ilosz spacji"] = sp
	return slownik
print(statystyki("mikolaj i olek", slownik))

9.
def srednia(*a):
	cyfry = int()
	i = 0
	for a in a:
		cyfry += a
		i += 1
	wynik = cyfry / i
	return wynik

print(srednia(100, 657, 1230981238970, 1231983, 26766))

10.
def walec(promien, wysokosc):
	def kolo(promien):
		return 3.14 * (promien ** 2) 
	kolo = kolo(promien)
	walec = 2 * kolo + (2 * 3.14 * promien * wysokosc)
	return float(walec)

print(walec(4, 6))

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

25.
def zegar(s):
    g = s // 3600
    m = (s % 3600) // 60
    s = s % 60
    return f"{g:02}:{m:02}:{s:02}"

print(zegar(3665))
