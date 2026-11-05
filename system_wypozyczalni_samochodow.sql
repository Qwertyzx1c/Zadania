

-- 1
SELECT *
FROM Klienci
WHERE data_rejestracji > '2020-01-01';

-- 2
SELECT *
FROM Opinie
WHERE ocena = 5;

-- 3
SELECT *
FROM Platnosci
WHERE metoda_platnosci = 'karta';

-- 4
SELECT *
FROM Faktury
WHERE kwota_calosci > 400;

-- 5
SELECT *
FROM Klienci
WHERE nazwisko LIKE 'K%';

-- 6
SELECT id_faktury, kwota_calosci
FROM Faktury
WHERE zaplacono = 'tak';

-- 7
SELECT *
FROM Opinie
WHERE data_opinii >= '2023-01-01'
AND data_opinii < '2024-01-01'
AND ocena >= 4;

-- 8
SELECT *
FROM Platnosci
WHERE kwota BETWEEN 400 AND 700;

-- 9
SELECT DISTINCT k.*
FROM Klienci k
INNER JOIN Opinie o ON o.id_klienta = k.id_klienta;

-- 10
SELECT DISTINCT k.*
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
WHERE f.data_faktury >= '2023-01-01'
AND f.data_faktury < '2024-01-01';

-- 11
SELECT *
FROM Faktury
WHERE kwota_calosci > 500
AND zaplacono = 'nie';

-- 12
SELECT DISTINCT k.*
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
WHERE p.metoda_platnosci IN ('przelew', 'gotówka');

-- 13
SELECT DISTINCT f.*
FROM Faktury f
INNER JOIN Wypozyczenia w ON w.id_wypozyczenia = f.id_wypozyczenia
INNER JOIN Opinie o ON o.id_samochodu = w.id_samochodu
WHERE o.ocena < 4;

-- 14
SELECT k.id_klienta, k.imie, k.nazwisko
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Opinie o ON o.id_klienta = k.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING COUNT(DISTINCT o.id_samochodu) >= 2;

-- 15
SELECT k.id_klienta, k.imie, k.nazwisko,
COUNT(f.id_faktury) AS liczba_faktur
FROM Klienci k
LEFT JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
LEFT JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
GROUP BY k.id_klienta, k.imie, k.nazwisko;

-- 16
SELECT k.id_klienta, k.imie, k.nazwisko,
COUNT(o.id_opinii) AS liczba_opinii
FROM Klienci k
LEFT JOIN Opinie o ON o.id_klienta = k.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko;

-- 17
SELECT metoda_platnosci, AVG(kwota) AS srednia_kwota
FROM Platnosci
GROUP BY metoda_platnosci;

-- 18
SELECT MONTH(data_platnosci) AS miesiac,
COUNT(*) AS liczba_platnosci
FROM Platnosci
WHERE data_platnosci >= '2023-01-01'
AND data_platnosci < '2024-01-01'
GROUP BY MONTH(data_platnosci)
ORDER BY miesiac;

-- 19
SELECT k.id_klienta, k.imie, k.nazwisko,
COUNT(p.id_platnosci) AS liczba_platnosci
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING COUNT(p.id_platnosci) >= 2;

-- 20
SELECT s.id_samochodu, s.marka, s.model,
AVG(o.ocena) AS srednia_ocena
FROM Samochody s
INNER JOIN Opinie o ON o.id_samochodu = s.id_samochodu
GROUP BY s.id_samochodu, s.marka, s.model;

-- 21
SELECT SUBSTRING_INDEX(k.adres, ', ', 1) AS miejscowosc,
COUNT(f.id_faktury) AS liczba_zaplaconych_faktur
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
WHERE f.zaplacono = 'tak'
GROUP BY SUBSTRING_INDEX(k.adres, ', ', 1);

-- 22
SELECT k.id_klienta, k.imie, k.nazwisko,
AVG(o.ocena) AS srednia_ocena
FROM Klienci k
INNER JOIN Opinie o ON o.id_klienta = k.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING AVG(o.ocena) >= 4;

-- 23
SELECT YEAR(data_faktury) AS rok,
MONTH(data_faktury) AS miesiac,
COUNT(*) AS liczba_faktur
FROM Faktury
GROUP BY YEAR(data_faktury), MONTH(data_faktury)
ORDER BY rok, miesiac;

-- 24
SELECT k.id_klienta, k.imie, k.nazwisko,
AVG(f.kwota_calosci) AS srednia_kwota_faktur
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING AVG(f.kwota_calosci) > 600;

-- 25
SELECT k.id_klienta, k.imie, k.nazwisko,
SUM(p.kwota) AS suma_platnosci
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
GROUP BY k.id_klienta, k.imie, k.nazwisko
HAVING SUM(p.kwota) > 1000;

-- 26
SELECT metoda_platnosci, AVG(kwota) AS srednia_kwota
FROM Platnosci
GROUP BY metoda_platnosci
HAVING AVG(kwota) > 500;

-- 27
SELECT k.id_klienta, k.imie, k.nazwisko,
COALESCE(f.liczba_faktur, 0) AS liczba_faktur,
COALESCE(p.suma_platnosci, 0) AS suma_platnosci
FROM Klienci k
LEFT JOIN (
    SELECT w.id_klienta, COUNT(f.id_faktury) AS liczba_faktur
    FROM Wypozyczenia w
    INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
    GROUP BY w.id_klienta
) f ON f.id_klienta = k.id_klienta
LEFT JOIN (
    SELECT w.id_klienta, SUM(p.kwota) AS suma_platnosci
    FROM Wypozyczenia w
    INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
    INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
    GROUP BY w.id_klienta
) p ON p.id_klienta = k.id_klienta;

-- 29
SELECT f.*, p.id_platnosci, p.data_platnosci,
p.kwota AS kwota_platnosci, p.metoda_platnosci
FROM Faktury f
LEFT JOIN Platnosci p ON p.id_faktury = f.id_faktury;

-- 30
SELECT k.*, o.id_opinii, o.id_samochodu,
o.ocena, o.komentarz, o.data_opinii,
s.marka, s.model
FROM Klienci k
LEFT JOIN Opinie o ON o.id_klienta = k.id_klienta
LEFT JOIN Samochody s ON s.id_samochodu = o.id_samochodu;

-- 31
SELECT k.*, f.*
FROM Klienci k
LEFT JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
LEFT JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia;

-- 32
SELECT f.*, p.id_platnosci, p.data_platnosci,
p.kwota AS kwota_platnosci, p.metoda_platnosci
FROM Faktury f
LEFT JOIN Platnosci p ON p.id_faktury = f.id_faktury;

-- 33
SELECT DISTINCT k.*
FROM Klienci k
INNER JOIN Wypozyczenia w ON w.id_klienta = k.id_klienta
INNER JOIN Faktury f ON f.id_wypozyczenia = w.id_wypozyczenia
INNER JOIN Platnosci p ON p.id_faktury = f.id_faktury
WHERE p.metoda_platnosci = 'karta'
AND EXISTS (
    SELECT 1
    FROM Opinie o
    WHERE o.id_klienta = k.id_klienta
);
