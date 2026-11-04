
biblioteka = [
    {"tytul": "Harry Potter", "autor": "J.K. Rowling", "dostepna": True},
    {"tytul": "Wiedźmin", "autor": "Andrzej Sapkowski", "dostepna": True},
    {"tytul": "Hobbit", "autor": "J.R.R. Tolkien", "dostepna": False}
]


def dodaj_ksiazke():
    tytul = input("Podaj tytuł książki: ")
    autor = input("Podaj autora: ")

    biblioteka.append({
        "tytul": tytul,
        "autor": autor,
        "dostepna": True
    })

    print("Dodano książkę!")


def wyswietl_ksiazki():
    print("\n--- WSZYSTKIE KSIĄŻKI ---")

    for i, k in enumerate(biblioteka):
        status = "Dostępna" if k["dostepna"] else "Wypożyczona"
        print(f"{i + 1}. {k['tytul']} - {k['autor']} | {status}")


def wypozycz_ksiazke():
    wyswietl_ksiazki()

    try:
        numer = int(input("Podaj numer książki: "))
        if 1 <= numer <= len(biblioteka):
            k = biblioteka[numer - 1]

            if k["dostepna"]:
                k["dostepna"] = False
                print("Wypożyczono książkę!")
            else:
                print("Książka jest już wypożyczona.")
        else:
            print("Nieprawidłowy numer.")
    except ValueError:
        print("Podaj poprawny numer!")


def zwroc_ksiazke():
    wyswietl_ksiazki()

    try:
        numer = int(input("Podaj numer książki: "))
        if 1 <= numer <= len(biblioteka):
            k = biblioteka[numer - 1]

            if not k["dostepna"]:
                k["dostepna"] = True
                print("Zwrócono książkę!")
            else:
                print("Ta książka nie jest wypożyczona.")
        else:
            print("Nieprawidłowy numer.")
    except ValueError:
        print("Podaj poprawny numer!")


def wyszukaj_ksiazke():
    szukaj = input("Podaj tytuł lub autora: ").lower()

    znalezione = False

    for k in biblioteka:
        if szukaj in k["tytul"].lower() or szukaj in k["autor"].lower():
            print(k["tytul"], "-", k["autor"])
            znalezione = True

    if not znalezione:
        print("Nie znaleziono książki.")


def usun_ksiazke():
    wyswietl_ksiazki()

    try:
        numer = int(input("Podaj numer książki do usunięcia: "))

        if 1 <= numer <= len(biblioteka):
            del biblioteka[numer - 1]
            print("Usunięto książkę!")
        else:
            print("Nieprawidłowy numer.")
    except ValueError:
        print("Podaj poprawny numer!")


def wypozyczone_ksiazki():
    print("\n--- WYPOŻYCZONE KSIĄŻKI ---")

    znalezione = False

    for k in biblioteka:
        if not k["dostepna"]:
            print(k["tytul"], "-", k["autor"])
            znalezione = True

    if not znalezione:
        print("Brak wypożyczonych książek.")


def statystyki():
    wszystkie = len(biblioteka)
    dostepne = sum(1 for k in biblioteka if k["dostepna"])
    wypozyczone = wszystkie - dostepne

    print("\n--- STATYSTYKI BIBLIOTEKI ---")
    print("Wszystkie książki:", wszystkie)
    print("Dostępne książki:", dostepne)
    print("Wypożyczone książki:", wypozyczone)


def menu():
    while True:
        print("\n========== BIBLIOTEKA ==========")
        print("1. Dodaj książkę")
        print("2. Wyświetl wszystkie książki")
        print("3. Wypożycz książkę")
        print("4. Zwróć książkę")
        print("5. Wyszukaj książkę")
        print("6. Usuń książkę")
        print("7. Wyświetl wypożyczone książki")
        print("8. Statystyki biblioteki")
        print("9. Zakończ program")

        wybor = input("\nWybierz opcję: ")

        if wybor == "1":
            dodaj_ksiazke()
        elif wybor == "2":
            wyswietl_ksiazki()
        elif wybor == "3":
            wypozycz_ksiazke()
        elif wybor == "4":
            zwroc_ksiazke()
        elif wybor == "5":
            wyszukaj_ksiazke()
        elif wybor == "6":
            usun_ksiazke()
        elif wybor == "7":
            wypozyczone_ksiazki()
        elif wybor == "8":
            statystyki()
        elif wybor == "9":
            print("Dziękujemy za skorzystanie z biblioteki!")
            break
        else:
            print("Nie ma takiej opcji!")


menu()
