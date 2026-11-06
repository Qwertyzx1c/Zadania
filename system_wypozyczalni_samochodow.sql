-- 1
SELECT * FROM Klienci
WHERE data_rejestracji > '2020-01-01';

-- 2
SELECT * FROM Opinie
WHERE ocena = 5;

-- 3
SELECT * FROM Platnosci
WHERE metoda_platnosci = 'karta';

-- 4
SELECT * FROM Faktury
WHERE kwota_calosci > 400;

-- 5
SELECT * FROM Klienci
WHERE nazwisko LIKE 'K%';

-- 6
SELECT * FROM Faktury
WHERE zaplacono = 'tak';

-- 7
SELECT * FROM Opinie
WHERE YEAR(data_opinii) = 2023 AND ocena >= 4;

-- 8
SELECT * FROM Platnosci
WHERE kwota BETWEEN 400 AND 700;

-- 9
SELECT DISTINCT Klienci.*
FROM Klienci
JOIN Opinie ON Klienci.id_klienta = Opinie.id_klienta;

-- 10
SELECT DISTINCT Klienci.*
FROM Klienci
JOIN Wypozyczenia ON Klienci.id_klienta = Wypozyczenia.id_klienta
JOIN Faktury ON Wypozyczenia.id_wypozyczenia = Faktury.id_wypozyczenia
JOIN Platnosci ON Faktury.id_faktury = Platnosci.id_faktury
WHERE YEAR(Faktury.data_faktury) = 2023;

-- 11
SELECT * FROM Faktury
WHERE kwota_calosci > 500 AND zaplacono = 'nie';

-- 12
SELECT DISTINCT Klienci.*
FROM Klienci
JOIN Wypozyczenia ON Klienci.id_klienta = Wypozyczenia.id_klienta
JOIN Faktury ON Wypozyczenia.id_wypozyczenia = Faktury.id_wypozyczenia
JOIN Platnosci ON Faktury.id_faktury = Platnosci.id_faktury
WHERE metoda_platnosci IN ('przelew', 'gotówka');

-- 13
SELECT DISTINCT Faktury.*
FROM Faktury
JOIN Wypozyczenia ON Faktury.id_wypozyczenia = Wypozyczenia.id_wypozyczenia
JOIN Opinie ON Wypozyczenia.id_samochodu = Opinie.id_samochodu
WHERE Opinie.ocena < 4;

-- 14
SELECT Klienci.id_klienta, Klienci.imie, Klienci.nazwisko
FROM Klienci
JOIN Opinie ON Klienci.id_klienta = Opinie.id_klienta
GROUP BY Klienci.id_klienta
HAVING COUNT(DISTINCT Opinie.id_samochodu) >= 2;

-- 15
SELECT id_klienta, COUNT(id_wypozyczenia)
FROM Wypozyczenia
GROUP BY id_klienta;

-- 16
SELECT id_klienta, COUNT(id_opinii)
FROM Opinie
GROUP BY id_klienta;

-- 17
SELECT metoda_platnosci, AVG(kwota)
FROM Platnosci
GROUP BY metoda_platnosci;

-- 18
SELECT MONTH(data_platnosci), COUNT(*)
FROM Platnosci
WHERE YEAR(data_platnosci) = 2023
GROUP BY MONTH(data_platnosci);

-- 19
SELECT id_faktury, COUNT(*)
FROM Platnosci
GROUP BY id_faktury
HAVING COUNT(*) >= 2;

-- 20
SELECT id_samochodu, AVG(ocena)
FROM Opinie
GROUP BY id_samochodu;

-- 21
SELECT SUBSTRING_INDEX(adres, ', ', 1) AS miejscowosc, COUNT(*)
FROM Klienci
JOIN Wypozyczenia USING (id_klienta)
JOIN Faktury USING (id_wypozyczenia)
WHERE zaplacono = 'tak'
GROUP BY miejscowosc;

-- 22
SELECT id_klienta, AVG(ocena)
FROM Opinie
GROUP BY id_klienta
HAVING AVG(ocena) >= 4;

-- 23
SELECT YEAR(data_faktury), MONTH(data_faktury), COUNT(*)
FROM Faktury
GROUP BY YEAR(data_faktury), MONTH(data_faktury);

-- 24
SELECT id_klienta, AVG(kwota_calosci)
FROM Wypozyczenia
JOIN Faktury USING (id_wypozyczenia)
GROUP BY id_klienta
HAVING AVG(kwota_calosci) > 600;

-- 25
SELECT id_klienta, SUM(kwota)
FROM Wypozyczenia
JOIN Faktury USING (id_wypozyczenia)
JOIN Platnosci USING (id_faktury)
GROUP BY id_klienta
HAVING SUM(kwota) > 1000;

-- 26
SELECT metoda_platnosci, AVG(kwota)
FROM Platnosci
GROUP BY metoda_platnosci
HAVING AVG(kwota) > 500;

-- 27
SELECT id_klienta, COUNT(id_faktury), SUM(kwota)
FROM Wypozyczenia
JOIN Faktury USING (id_wypozyczenia)
LEFT JOIN Platnosci USING (id_faktury)
GROUP BY id_klienta;

-- 28
SELECT *
FROM Faktury
LEFT JOIN Platnosci USING (id_faktury);

-- 29
SELECT *
FROM Klienci
LEFT JOIN Opinie USING (id_klienta);

-- 30
SELECT *
FROM Klienci
LEFT JOIN Wypozyczenia USING (id_klienta)
LEFT JOIN Faktury USING (id_wypozyczenia);

-- 31
SELECT *
FROM Faktury
LEFT JOIN Platnosci USING (id_faktury);

-- 32
SELECT DISTINCT Klienci.*
FROM Klienci
JOIN Opinie USING (id_klienta)
JOIN Wypozyczenia USING (id_klienta)
JOIN Faktury USING (id_wypozyczenia)
JOIN Platnosci USING (id_faktury)
WHERE metoda_platnosci = 'karta';
