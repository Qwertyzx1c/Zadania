
-- 8.
CREATE VIEW widok_auta_w_serwisie AS
SELECT marka, model, rok_produkcji, numer_rejestracyjny
FROM Samochody
WHERE status = 'serwis';


-- 9.
CREATE VIEW widok_koszty_serwisu AS
SELECT 
    Samochody.marka,
    Samochody.model,
    Samochody.numer_rejestracyjny,
    COUNT(Serwisy.id_serwisu) AS liczba_serwisow,
    SUM(Serwisy.koszt) AS laczny_koszt
FROM Samochody
JOIN Serwisy ON Samochody.id_samochodu = Serwisy.id_samochodu
GROUP BY Samochody.id_samochodu, Samochody.marka, Samochody.model, Samochody.numer_rejestracyjny
ORDER BY laczny_koszt DESC;


-- 10.
CREATE VIEW widok_oceny_samochodow AS
SELECT
    Samochody.marka,
    Samochody.model,
    COUNT(Opinie.id_opinii) AS liczba_opinii,
    ROUND(AVG(Opinie.ocena), 2) AS srednia_ocena
FROM Samochody
JOIN Opinie ON Samochody.id_samochodu = Opinie.id_samochodu
GROUP BY Samochody.id_samochodu, Samochody.marka, Samochody.model;


-- 11.
CREATE VIEW widok_niezaplacone_faktury AS
SELECT
    Faktury.id_faktury AS numer_faktury,
    Faktury.data_faktury,
    Faktury.kwota_calosci,
    Klienci.imie,
    Klienci.nazwisko
FROM Faktury
JOIN Wypozyczenia ON Faktury.id_wypozyczenia = Wypozyczenia.id_wypozyczenia
JOIN Klienci ON Wypozyczenia.id_klienta = Klienci.id_klienta
WHERE Faktury.zaplacono = 'nie';


-- 12.
CREATE VIEW widok_trwajace_wypozyczenia AS
SELECT
    Klienci.imie,
    Klienci.nazwisko,
    Samochody.marka,
    Samochody.model,
    Wypozyczenia.data_wypozyczenia,
    DATEDIFF(CURDATE(), Wypozyczenia.data_wypozyczenia) AS liczba_dni
FROM Wypozyczenia
JOIN Klienci ON Wypozyczenia.id_klienta = Klienci.id_klienta
JOIN Samochody ON Wypozyczenia.id_samochodu = Samochody.id_samochodu
WHERE Wypozyczenia.status = 'wypożyczony';


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
