stokrotka = {
    "Jedzenie": {
        "Baton": 30,
        "Pieczywo": 30,
        "Mięso" : 20
    },
    "Picie": {
        "Sok": 45,
        "Cola": 25,
        "Alkochol" : 24
    }
}


while(True):
    print("> Big Stokrotka")
    print("> Wybierz opcje")
    print("1) Dodaj produkt")
    print("2) Usuń produkt")
    print("3) Sprawdź dostępność produktu")
    print("4) Wyświetl wszystkie produkty")
    print("q) Wyjdź")
    Snake = input("Opcja nr : ")
    if Snake == '1':
        slownik = input("Do której kategorii dodać: ")
        key = input("Wprowadź co dodać jako produkt: ")
        value = int(input("Wprowadź ile produktów dodać: "))
        stokrotka[slownik][key] = value
        print(stokrotka)
        break
    elif Snake == '2':
        slownik2 = input("Z jakiej kategorii usunąć: ")
        key2 = input("Wprowadź co usunąć: ")
        del stokrotka[slownik2][key2]
        print(stokrotka)
        break
    elif Snake == '3':
        slownik3 = input("Jaką kategorie chcesz zobaczyć?: ")
        key3 = input("Wprowadź co wyświetlić: ")
        print(stokrotka[slownik3][key3])
        break
    elif Snake == '4':
        slownik4 = input("Jaką kategorie chcesz zobaczyć?: ")
        stokrotka[slownik4]
        print(stokrotka)
        break
    elif Snake == "q":
        break
