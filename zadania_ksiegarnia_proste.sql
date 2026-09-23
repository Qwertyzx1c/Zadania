-- 1
SELECT * FROM klienci WHERE miasto = 'Lublin';

-- 2
SELECT tytul, Cena FROM ksiazki WHERE Cena > 40;

-- 3
SELECT miasto, COUNT(miasto) AS liczba_klientow FROM klienci GROUP BY miasto;

-- 4
SELECT id_klienta, COUNT(id_klienta) AS ilosc_zakupow FROM sprzedaz GROUP BY id_klienta;

-- 5
SELECT * FROM klienci WHERE id_klienta NOT IN (SELECT id_klienta FROM sprzedaz);

-- 6
SELECT DISTINCT k.* FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek = 'Fantastyka';

-- 7
SELECT g.gatunek, AVG(ks.Cena) AS srednia_cena
FROM gatunki g JOIN ksiazki ks ON g.id_gatunku = ks.id_gatunku
GROUP BY g.gatunek;

-- 8
SELECT ks.tytul FROM ksiazki ks
LEFT JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
WHERE s.id_sprzedazy IS NULL;

-- 9
SELECT id_klienta, COUNT(*) AS ilosc_zakupow
FROM sprzedaz GROUP BY id_klienta HAVING COUNT(*) > 3;

-- 10
SELECT w.wydawnictwo, COUNT(ks.id_ksiazki) AS ilosc_ksiazek
FROM wydawnictwa w LEFT JOIN ksiazki ks ON w.id_wydawnictwa = ks.id_wydawnictwa
GROUP BY w.wydawnictwo;

-- 11
SELECT DISTINCT k.* FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek IN ('Sensacja', 'Thriller');

-- 12
SELECT DISTINCT k.* FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
WHERE ks.Cena > 40;

-- 13
SELECT g.gatunek, COUNT(ks.id_ksiazki) AS ilosc_ksiazek
FROM gatunki g LEFT JOIN ksiazki ks ON g.id_gatunku = ks.id_gatunku
GROUP BY g.gatunek;

-- 14
SELECT ks.tytul, COUNT(*) AS ilosc_sprzedazy
FROM ksiazki ks JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
GROUP BY ks.tytul HAVING COUNT(*) > 2;

-- 15
SELECT p.imie, p.nazwisko, s.nazwa
FROM pracownicy p JOIN stanowiska s ON p.id_stanowiska = s.id_stanowiska
WHERE p.wynagrodzenie > (SELECT AVG(wynagrodzenie) FROM pracownicy);

-- 16
SELECT DISTINCT ks.tytul FROM ksiazki ks
JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
JOIN klienci k ON s.id_klienta = k.id_klienta
WHERE k.nazwisko = 'Kowalski';

-- 17
SELECT k.id_klienta, k.imie, k.nazwisko, SUM(ks.Cena) AS suma
FROM klienci k JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
GROUP BY k.id_klienta, k.imie, k.nazwisko HAVING SUM(ks.Cena) > 100;

-- 18
SELECT s.nazwa, COUNT(p.id_pracownika) AS liczba
FROM stanowiska s LEFT JOIN pracownicy p ON s.id_stanowiska = p.id_stanowiska
GROUP BY s.nazwa;

-- 19
SELECT k.id_klienta, k.imie, k.nazwisko, COUNT(*) AS ilosc
FROM klienci k JOIN sprzedaz s ON k.id_klienta = s.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko ORDER BY ilosc DESC LIMIT 1;

-- 20
SELECT k.id_klienta, k.imie, k.nazwisko FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek IN ('Fantastyka', 'Sensacja')
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING COUNT(DISTINCT g.gatunek) = 2;
