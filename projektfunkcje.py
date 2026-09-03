def zamianaplnnapeso(a):
	return a * 4.50 #Peso

peso = input(f"Wprowadź ile PLN zamienić na Peso: {zamianaplnnapeso}")
print(peso)

def zamianaplnnalire(a):
	return a * 13 #Lira Turecka

lira = input(f"Wprowadź ile PLN zamienić na Lire Turecką: {zamianaplnnalire}")
print(lira)

def	zamianaplnnaforinty(a):
	return a * 85 #Forinty

forinty = input(f"Wprowadź ile PLN zamienić na Forinty: {zamianaplnnaforinty}")
print(forinty)

while(True):
    print("> Big Boss Zamiana Currency")
    print("> Wybierz opcje")
    print("1) Pln na Peso")
    print("2) Pln na Liry Tureckie")
    print("3) Pln na Forinty")
    print("q) Wyjdź")
    Snake = input("Opcja nr : ")
	if Snake == '1':
		print(zamianaplnnapeso)
	elif:
