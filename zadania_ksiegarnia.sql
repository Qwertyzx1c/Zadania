
-- 1. Wybierz wszystkie informacje o klientach z miasta Lublin.
SELECT *
FROM klienci
WHERE miasto = 'Lublin';

-- 2. Wybierz tytuł i cenę książki, która kosztuje więcej niż 40 zł.
SELECT tytul, Cena
FROM ksiazki
WHERE Cena > 40;

-- 3. Policz liczbę klientów w każdym miesiącu.
-- Brak kolumny z datą rejestracji klienta w bazie.

-- 4. Znajdź klientów, którzy dokonali zakupu (zawierający id_klienta) i ilość ich zakupów.
SELECT id_klienta, COUNT(*) AS ilosc_zakupow
FROM sprzedaz
GROUP BY id_klienta;

-- 5. Wybierz wszystkie informacje o klientach, którzy nie dokonali zakupu.
SELECT *
FROM klienci
WHERE id_klienta NOT IN (
    SELECT id_klienta
    FROM sprzedaz
);

-- 6. Znajdź klientów, którzy dokonali zakupu książki o gatunku 'Fantastyka'.
SELECT DISTINCT k.*
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek = 'Fantastyka';

-- 7. Policz średnią cenę książek dla każdego gatunku.
SELECT g.gatunek, AVG(ks.Cena) AS srednia_cena
FROM gatunki g
JOIN ksiazki ks ON g.id_gatunku = ks.id_gatunku
GROUP BY g.id_gatunku, g.gatunek;

-- 8. Znajdź tytuły książek, które nie zostały jeszcze sprzedane.
SELECT ks.tytul
FROM ksiazki ks
LEFT JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
WHERE s.id_sprzedazy IS NULL;

-- 9. Wybierz klientów, którzy dokonali zakupów powyżej 3 książek.
SELECT k.id_klienta, k.imie, k.nazwisko,
       COUNT(s.id_sprzedazy) AS ilosc_ksiazek
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING COUNT(s.id_sprzedazy) > 3;

-- 10. Policz ilość książek dla każdego wydawnictwa.
SELECT w.wydawnictwo,
       COUNT(ks.id_ksiazki) AS ilosc_ksiazek
FROM wydawnictwa w
LEFT JOIN ksiazki ks
    ON w.id_wydawnictwa = ks.id_wydawnictwa
GROUP BY w.id_wydawnictwa, w.wydawnictwo;

-- 11. Znajdź klientów, którzy dokonali zakupów książek z gatunku 'Sensacja' lub 'Thriller'.
SELECT DISTINCT k.*
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek IN ('Sensacja', 'Thriller');

-- 12. Znajdź klientów, którzy dokonali zakupów urodzonych przed 1990 rokiem.
-- Brak kolumny z datą urodzenia klienta w bazie.

-- 13. Policz ilość książek w każdym gatunku.
SELECT g.gatunek,
       COUNT(ks.id_ksiazki) AS ilosc_ksiazek
FROM gatunki g
LEFT JOIN ksiazki ks
    ON g.id_gatunku = ks.id_gatunku
GROUP BY g.id_gatunku, g.gatunek;

-- 14. Znajdź książki, które zostały sprzedane więcej niż 2 razy.
SELECT ks.tytul,
       COUNT(s.id_sprzedazy) AS ilosc_sprzedazy
FROM ksiazki ks
JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
GROUP BY ks.id_ksiazki, ks.tytul
HAVING COUNT(s.id_sprzedazy) > 2;

-- 15. Wybierz imię, nazwisko i stanowisko pracowników,
-- którzy zarabiają więcej niż średnia pensja.
SELECT p.imie, p.nazwisko, s.nazwa AS stanowisko
FROM pracownicy p
JOIN stanowiska s
    ON p.id_stanowiska = s.id_stanowiska
WHERE p.wynagrodzenie > (
    SELECT AVG(wynagrodzenie)
    FROM pracownicy
);

-- 16. Znajdź książki, które zostały sprzedane klientowi o nazwisku 'Kowalski'.
SELECT DISTINCT ks.tytul
FROM ksiazki ks
JOIN sprzedaz s ON ks.id_ksiazki = s.id_ksiazki
JOIN klienci k ON s.id_klienta = k.id_klienta
WHERE k.nazwisko = 'Kowalski';

-- 17. Znajdź klientów, którzy dokonali zakupów książek o łącznej wartości powyżej 100 zł.
SELECT k.id_klienta, k.imie, k.nazwisko,
       SUM(ks.Cena) AS laczna_wartosc
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING SUM(ks.Cena) > 100;

-- 18. Policz ilość pracowników na każdym stanowisku.
SELECT s.nazwa AS stanowisko,
       COUNT(p.id_pracownika) AS liczba_pracownikow
FROM stanowiska s
LEFT JOIN pracownicy p
    ON s.id_stanowiska = p.id_stanowiska
GROUP BY s.id_stanowiska, s.nazwa;

-- 19. Znajdź klienta, który dokonał największej liczby zakupów.
SELECT k.id_klienta, k.imie, k.nazwisko,
       COUNT(s.id_sprzedazy) AS ilosc_zakupow
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko
ORDER BY ilosc_zakupow DESC
LIMIT 1;

-- 20. Wybierz klientów, którzy dokonali zakupu książki o gatunku
-- 'Fantastyka' i 'Sensacja'.
SELECT k.id_klienta, k.imie, k.nazwisko
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
JOIN gatunki g ON ks.id_gatunku = g.id_gatunku
WHERE g.gatunek IN ('Fantastyka', 'Sensacja')
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING COUNT(DISTINCT g.gatunek) = 2;

-- 21. Znajdź klientów, którzy dokonali zakupów książek
-- o łącznej wartości powyżej średniej wartości zakupów.
SELECT k.id_klienta, k.imie, k.nazwisko,
       SUM(ks.Cena) AS laczna_wartosc
FROM klienci k
JOIN sprzedaz s ON k.id_klienta = s.id_klienta
JOIN ksiazki ks ON s.id_ksiazki = ks.id_ksiazki
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING SUM(ks.Cena) > (
    SELECT AVG(wartosc)
    FROM (
        SELECT SUM(ks2.Cena) AS wartosc
        FROM sprzedaz s2
        JOIN ksiazki ks2
            ON s2.id_ksiazki = ks2.id_ksiazki
        GROUP BY s2.id_klienta
    ) AS srednie_zakupy
);
