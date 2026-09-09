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
    samogloski = set("aeiouy")
    return sum(1 for znak in tekst.lower() if znak in samogloski)

print(samogloski("skibidi"))  
print(samogloski("ale sigma"))
