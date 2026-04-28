#4.
def dwajeden(od, do):
    for i in range(od , do):
        if i % 21 == 0:
            print(i)
dwajeden(1, 100)

#5.
def dwacztery():
    for i in range(1, 1024):
        if i % 37 == 0:
            print("Paul")
        elif i % 21 == 0:
            print("John")
        else:
            print(i)
dwacztery()

#6.
def zaleznosc():
    x = int(input("Wpisz wartość 1 albo 2 albo 3: "))
    if x == 1:
        print("?:-)")
    elif x == 2:
        print(":-|")
    elif x == 3:
        print(":-(")
zaleznosc()
