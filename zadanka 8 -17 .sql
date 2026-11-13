
-- 8.
CREATE VIEW widok_auta_w_serwisie AS
SELECT marka, model, rok_produkcji, numer_rejestracyjny
FROM Samochody
WHERE status = 'serwis';


-- 9.
CREATE VIEW widok_koszty_serwisu AS
SELECT 
    s.marka,
    s.model,
    s.numer_rejestracyjny,
    COUNT(ser.id_serwisu) AS liczba_serwisow,
    SUM(ser.koszt) AS laczny_koszt
FROM Samochody s
JOIN Serwisy ser ON s.id_samochodu = ser.id_samochodu
GROUP BY s.id_samochodu, s.marka, s.model, s.numer_rejestracyjny
ORDER BY laczny_koszt DESC;


-- 10.
CREATE VIEW widok_oceny_samochodow AS
SELECT
    s.marka,
    s.model,
    COUNT(o.id_opinii) AS liczba_opinii,
    ROUND(AVG(o.ocena), 2) AS srednia_ocena
FROM Samochody s
JOIN Opinie o  ON s.id_samochodu = o.id_samochodu
GROUP BY s.id_samochodu, s.marka, s.model;


-- 11.
CREATE VIEW widok_niezaplacone_faktury AS
SELECT
    f.id_faktury AS numer_faktury,
    f.data_faktury,
    f.kwota_calosci,
    k.imie,
    k.nazwisko
FROM Faktury f
JOIN Wypozyczenia w ON f.id_wypozyczenia = w.id_wypozyczenia
JOIN Klienci k ON w.id_klienta = k.id_klienta
WHERE f.zaplacono = 'nie';


-- 12.
CREATE VIEW widok_trwajace_wypozyczenia AS
SELECT
    k.imie,
    k.nazwisko,
    s.marka,
    s.model,
    w.data_wypozyczenia,
    DATEDIFF(CURDATE(), w.data_wypozyczenia) AS liczba_dni
FROM Wypozyczenia w
JOIN Klienci k ON w.id_klienta = k.id_klienta
JOIN Samochody s ON w.id_samochodu = s.id_samochodu
WHERE w.status = 'wypożyczony';


-- 13.
CREATE VIEW widok_metody_platnosci AS
SELECT
    metoda_platnosci,
    COUNT(id_platnosci) AS liczba_platnosci,
    SUM(kwota) AS laczna_kwota
FROM Platnosci
GROUP BY metoda_platnosci;


-- 14.
CREATE VIEW widok_wypozyczenia_rocznie AS
SELECT
    YEAR(data_wypozyczenia) AS rok,
    COUNT(id_wypozyczenia) AS liczba_wypozyczen,
    SUM(kwota) AS suma_kwot
FROM Wypozyczenia
GROUP BY YEAR(data_wypozyczenia)
ORDER BY rok ASC;


-- 15.
CREATE VIEW widok_staz_pracownikow AS
SELECT
    imie,
    nazwisko,
    stanowisko,
    TIMESTAMPDIFF(YEAR, data_zatrudnienia, CURDATE()) AS staz_w_latach
FROM Pracownicy;


-- 16.
CREATE VIEW widok_klienci_miasta AS
SELECT
    SUBSTRING_INDEX(adres, ',', 1) AS miasto,
    COUNT(id_klienta) AS liczba_klientow
FROM Klienci
GROUP BY SUBSTRING_INDEX(adres, ',', 1);


-- 17a.
SELECT *
FROM widok_koszty_serwisu
WHERE laczny_koszt > 2000;

    
-- 17b.
CREATE OR REPLACE VIEW widok_oceny_samochodow AS
SELECT
    Samochody.marka,
    Samochody.model,
    COUNT(Opinie.id_opinii) AS liczba_opinii,
    ROUND(AVG(Opinie.ocena), 2) AS srednia_ocena
FROM Samochody
JOIN Opinie ON Samochody.id_samochodu = Opinie.id_samochodu
GROUP BY Samochody.id_samochodu, Samochody.marka, Samochody.model
HAVING AVG(Opinie.ocena) >= 4;


-- 17c
DROP VIEW widok_auta_w_serwisie;

-- Sprawdzenie istniejących widoków
SHOW FULL TABLES WHERE Table_type = 'VIEW';
