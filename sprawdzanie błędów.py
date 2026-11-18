try:
	plik = open("liczby.txt", "r")
	liczby = plik.read().split()
	plik.close()

	liczby = [float(x) for x in liczby]
	srednia = sum(liczby)/len(liczby)


	plik = open("wynik3.txt", "w")
	plik.write(str(srednia))
	plik.close()

	print("Zapisano wynik!!")
except FileNotFoundError:
	print("Nie znaleziono pliku!")
except ValueError:
	print("Błędne dane w pliku!")
except ZeroDivisionError:
	print("Plik jest pusty!")
