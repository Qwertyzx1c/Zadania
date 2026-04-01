my_dict = {
   'imie': 'Jan',
   'nazwisko': 'Kowalski',
   'wiek': 30,
   'miasto': 'Warszawa'
}

# 1. 
# print(my_dict["imie"])

# 2.
# my_dict["age"] = 35
# print(my_dict)

# 3.
# my_dict["email"] = "jan.kowalski@gmail.com"
# print(my_dict)

# 4.
# del my_dict["miasto"]
# print(my_dict)

# 5.
# if 'nazwisko' in my_dict:
#     print('istenieje')
# else:
#     print('Nie istnieje')

# 6.
# for key in my_dict:
#     print(f"Klucz: {key}, Wartość: {my_dict[key]}")

# 7.
# for value in my_dict.values():
#     print(f"Wartość: {value}")

# 8.
# for key, value in my_dict.items():
#     print(f"Klucz: {key}, Wartość: {value}")

# 9.
# if 'nazwisko' in my_dict:
#     print('Istnieje')

10.

del my_dict["miasto"]
del my_dict["imie"]
del my_dict["nazwisko"]
del my_dict["wiek"]
print(my_dict)
