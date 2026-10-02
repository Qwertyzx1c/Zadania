zadania = [
    {
        "nazwa_zadania": "Zrobić projekt",
        "przypisana_osoba": "Jan Kowalski",
        "priorytet": "wysoki",
        "status": "w trakcie",
        "kategorie": ["python", "szkoła"]
    },
    {
        "nazwa_zadania": "Nauczyć się Pythona",
        "przypisana_osoba": "Anna Nowak",
        "priorytet": "średni",
        "status": "zrobione",
        "kategorie": ["python"]
    }
]

def dodaj_zadanie():
    nazwa = input("Podaj nazwę zadania: ").strip()
    osoba = input("Podaj imię i nazwisko osoby: ").strip().title()
    priorytet = input("Podaj priorytet (wysoki/średni/niski): ").strip()
    status = input("Podaj status (zrobione/w trakcie): ").strip()
    kategorie = input("Podaj kategorie, oddzielając je przecinkami: ")

    # Zamiana tekstu z kategoriami na listę
    kategorie = [kategoria.strip() for kategoria in kategorie.split(",")]

    zadanie = {
        "nazwa_zadania": nazwa,
        "przypisana_osoba": osoba,
        "priorytet": priorytet,
        "status": status,
        "kategorie": kategorie
    }

    zadania.append(zadanie)
    print("Zadanie zostało dodane.")


def wyswietl_wszystkie_zadania():
    if not zadania:
        print("Lista zadań jest pusta.")
        return

    print("\n--- WSZYSTKIE ZADANIA ---")

    for numer, zadanie in enumerate(zadania, start=1):
        print(f"\nZadanie {numer}:")
        print(f"Nazwa: {zadanie['nazwa_zadania']}")
        print(f"Osoba: {zadanie['przypisana_osoba']}")
        print(f"Priorytet: {zadanie['priorytet']}")
        print(f"Status: {zadanie['status']}")
        print(f"Kategorie: {', '.join(zadanie['kategorie'])}")


def wyszukaj_zadanie():
    szukana_fraza = input(
        "Podaj imię osoby lub fragment nazwy zadania: "
    ).strip().lower()

    znalezione = []

    for zadanie in zadania:
        nazwa = zadanie["nazwa_zadania"].lower()
        osoba = zadanie["przypisana_osoba"].lower()

        if szukana_fraza in nazwa or szukana_fraza in osoba:
            znalezione.append(zadanie)

    if not znalezione:
        print("Nie znaleziono żadnego pasującego zadania.")
        return

    print("\n--- ZNALEZIONE ZADANIA ---")

    for numer, zadanie in enumerate(znalezione, start=1):
        print(f"\nZadanie {numer}:")
        print(f"Nazwa: {zadanie['nazwa_zadania']}")
        print(f"Osoba: {zadanie['przypisana_osoba']}")
        print(f"Priorytet: {zadanie['priorytet']}")
        print(f"Status: {zadanie['status']}")
        print(f"Kategorie: {', '.join(zadanie['kategorie'])}")


def oznacz_jako_wykonane():
    nazwa = input("Podaj nazwę zadania do oznaczenia jako wykonane: ").strip().lower()

    for zadanie in zadania:
        if zadanie["nazwa_zadania"].lower() == nazwa:
            zadanie["status"] = "zrobione"
            print("Zadanie zostało oznaczone jako wykonane.")
            return

    print("Nie znaleziono zadania o podanej nazwie.")


def usun_zadanie():
    nazwa = input("Podaj nazwę zadania do usunięcia: ").strip().lower()

    for zadanie in zadania:
        if zadanie["nazwa_zadania"].lower() == nazwa:
            zadania.remove(zadanie)
            print("Zadanie zostało usunięte.")
            return

    print("Nie znaleziono zadania o podanej nazwie.")


def menu():
    while True:
        print("\n===== MENEDŻER ZADAŃ =====")
        print("1. Dodaj nowe zadanie")
        print("2. Wyświetl wszystkie zadania")
        print("3. Wyszukaj zadanie")
        print("4. Oznacz zadanie jako wykonane")
        print("5. Usuń zadanie")
        print("6. Wyjście")

        wybor = input("Wybierz opcję: ").strip()

        if wybor == "1":
            dodaj_zadanie()

        elif wybor == "2":
            wyswietl_wszystkie_zadania()

        elif wybor == "3":
            wyszukaj_zadanie()

        elif wybor == "4":
            oznacz_jako_wykonane()

        elif wybor == "5":
            usun_zadanie()

        elif wybor == "6":
            print("Program został zakończony.")
            break

        else:
            print("Nieprawidłowa opcja. Wybierz numer od 1 do 6.")


menu()
