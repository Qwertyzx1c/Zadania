
numery = {
    "Female": {
        "Twoja mama": 101010101,
        "Ada": 101010101,
        "Ania" : 101010101
    },
    "Male": {
        "Oliwier (pedał)": 101010101,
        "Mikołaj": 101010101,
        "Aleksander" : 101010101
    }
}


while(True):
    print("> Big Numery")
    print("> Wybierz opcje")
    print("1) Dodaj numer")
    print("2) Usuń numer")
    print("3) Sprawdź dostępność numerów")
    print("4) Wyświetl wszystkie numery")
    print("q) Wyjdź")
    Snake = input("Opcja nr : ")
    if Snake == '1':
        slownik = input("To Which sex to add?: ")
        key = input("Which imie dodać?: ")
        value = int(input("Wprowadź numer (max 9 liczb): "))
        numery[slownik][key] = value
        print(numery)
        break
    elif Snake == '2':
        slownik2 = input("Male or Female delete: ")
        key2 = input("Wprowadź kogo usunąć: ")
        del numery[slownik2][key2]
        print(numery)
        break
    elif Snake == '3':
        slownik3 = input("Male or Female?: ")
        key3 = input("Wprowadź kogo wyświetlić: ")
        print(numery[slownik3][key3])
        break
    elif Snake == '4':
        print(numery)
        break
    elif Snake == "q":
        break
