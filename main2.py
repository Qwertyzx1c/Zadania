# 1.
# def palindrom(a):
# 	a = input("Podaj wyraz do sprawdzenia: ").lower()

# 	if a == a[::-1]:
# 		print(True)
# 	else:
# 		print(False)
# print(palindrom("kajak"))
# palindrom("kajak")

2.
def maskuj(numer: str, widoczne: int = 4, znak: str = '*') -> str:
    numer_str = str(numer)
    
    if len(numer_str) <= widoczne:
        return numer_str
    
    liczba_ukrytych = len(numer_str) - widoczne
    
    return (znak * liczba_ukrytych) + numer_str[-widoczne:]
print(maskuj("1234567890123456"))  
