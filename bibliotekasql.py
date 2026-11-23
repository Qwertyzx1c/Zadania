import sqlite3

conn = sqlite3.connect('biblioteka.db') 

cursor = conn.cursor()

def add():
    tytul = input("Podaj tytuł: ")
    autor = input("Podaj autora: ")
    wydanie = int(input("Podaj rok wydania: "))

    cursor.execute('''
    INSERT INTO ksiazki (tytul, autor, rok_wydania) VALUES (?, ?, ?)
''', (tytul, autor, wydanie))
    
conn.commit()
    
def delete():
    ksiazka = int(input("Podaj id książki: "))

    cursor.execute('''
    DELETE FROM ksiazki WHERE id_ksiazki = ?
''', (ksiazka))
    
conn.commit()
    
def show():

    cursor.execute('SELECT * FROM users')
rows = cursor.fetchall()

for row in rows:
    print(row)
    
conn.commit()   


def update():
    tytul = input("Podaj tytuł: ")
    id = int(input("Podaj id do zmienienia: "))

    cursor.execute('''
    UPDATE ksiazki SET tytul = ? WHERE id_ksiazki = ?
''', (tytul, id))
    
conn.commit()   


def menu():
    while True:
        print("\n========== BIBLIOTEKA ==========")
        print("1. Dodaj książkę")
        print("2. Usuń książke")
        print("3. Wyświetl wszystkie książki")
        print("4. Zaktualizuj książkę")
        print("5. Zakończ program")

        wybor = input("\nWybierz opcję: ")

        if wybor == "1":
            add()
        elif wybor == "2":
            delete()
        elif wybor == "3":
            show()
        elif wybor == "4":
            update()
        elif wybor == "5":
            print("Dziękujemy za skorzystanie z biblioteki!")
            break
        else:
            print("Nie ma takiej opcji!")


menu()
