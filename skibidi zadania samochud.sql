

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
