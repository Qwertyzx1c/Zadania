rowery = {
    "Rower1": {
        "model": "MTF",
        "typ" : "Górski",
        "cena_za_godzine" : 40.00,
        "dostępny" : True
    },
    "Rower2": {
        "model": "PHP",
        "typ" : "Miejski",
        "cena_za_godzine" : 50.00,
        "dostępny" : True
    },
    "Rower3": {
        "model": "BTTB",
        "typ" : "Szosowy",
        "cena_za_godzine" : 35.00,
        "dostępny" : False
    },
    "Rower4": {
        "model": "SONIC",
        "typ" : "Kolarski",
        "cena_za_godzine" : 30.00,
        "dostępny" : True
    },
    "Rower5": {
        "model": "KM",
        "typ" : "Górski",
        "cena_za_godzine" : 42.00,
        "dostępny" : False
    }
}


while(True):
   print("> Wypożyczalnia Rowerowa")
   print("> Wybierz opcje")
   print("1) Wyświetl wszystkie rowery")
   print("2) Wyświetl dostępne rowery")
   print("3) Wypożycz rower")
   print("4) Oddaj rower")
   print("5) Oblicz koszt wypożyczenia")
   print("6) Wyświetl najdroższy albo najtańszy rower")
   print("q) Wyjdź")
   Snake = input("Opcja nr : ")
   if Snake == '1':
      print(rowery)
   # elif Snake == '2':
   #    for key, value in rowery.items():
   #       print(f"Klucz: {key}, Wartość: {value}")
   elif Snake == '3':
      slownik = input("Który rower chcesz wypożyczyć: ")
      rowery[slownik]["dostępny"] = False
      print(rowery[slownik])
   elif Snake == '4':
      slownik3 = input("Który rower chcesz oddać: ")
      rowery[slownik3]["dostępny"] = True
      print(rowery[slownik3])
   elif Snake == '5':
      slownik2 = input("Który rower wypożyczyłeś: ")
      ile = int(input("Na ile go wypożyczyłeś: "))
      koszt = rowery[slownik2]["cena_za_godzine"]
      suma = koszt*ile
      print(suma)
   elif Snake == '6':
      max_cena = max(c["cena_za_godzine"] for c in rowery.values())
      min_cena = min(c["cena_za_godzine"] for c in rowery.values())
      print(F"\n\nNajwyższa cena roweru: {max_cena};\nNajniższa cena roweru: {min_cena}")
   elif Snake == "q":
      break
