lista = {
    "Mleko": 2,
    "Bułki": 8,
    "Mięso" : "2kg",
    "Jedzenie" : "dobre",
}

while(True):
    print("> Big Boss Lista")
    print("> Wybierz opcje")
    print("1) Dodaj produkt")
    print("2) Usuń produkt")
    print("3) Wyświetl wszystkie produkty")
    print("q) Wyjdź")
    Snake = input("Opcja nr : ")
    if Snake == '1':
        key = input("Wprowadź co dodać jako produkt: ")
        value = int(input("Wprowadź ile produktów dodać: "))
        lista[key] = value
        print(lista)
        break
    elif Snake == '2':
        key2 = input("Wprowadź co usunąć: ")
        del lista[key2]
        print(lista)
        break
    elif Snake == '3':
        print(lista)
        break
    elif Snake == "q":
        break
