-- 1. AKTYWNI KLIENCI
CREATE VIEW Aktywni_Klienci AS
SELECT
    k.imie,
    k.nazwisko,
    MAX(w.data_wypozyczenia) AS data_ostatniego_wypozyczenia
FROM Klienci k
INNER JOIN Wypozyczenia w
    ON k.id_klienta = w.id_klienta
WHERE w.data_wypozyczenia >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY k.id_klienta, k.imie, k.nazwisko;


-- 2. CAŁKOWITY CZAS WYPOŻYCZEŃ KLIENTÓW
CREATE VIEW Czas_Wypozyczen_Klientow AS
SELECT
    k.imie,
    k.nazwisko,
    COALESCE(
        SUM(
            DATEDIFF(
                COALESCE(w.data_zwrotu, CURDATE()),
                w.data_wypozyczenia
            )
        ), 0
    ) AS laczny_czas_wypozyczen_dni
FROM Klienci k
LEFT JOIN Wypozyczenia w
    ON k.id_klienta = w.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko;


-- 3. KLIENCI, KTÓRZY WYDALI NAJWIĘCEJ
CREATE VIEW Najwiecej_Wydajacy_Klienci AS
SELECT
    k.imie,
    k.nazwisko,
    SUM(w.kwota) AS laczna_kwota_wypozyczen
FROM Klienci k
INNER JOIN Wypozyczenia w
    ON k.id_klienta = w.id_klienta
GROUP BY k.id_klienta, k.imie, k.nazwisko;


-- 4. NAJDŁUŻSZE WYPOŻYCZENIA (POWYŻEJ 30 DNI)
CREATE VIEW Najdluzsze_Wypozyczenia AS
SELECT
    w.data_wypozyczenia,
    w.data_zwrotu,
    k.nazwisko,
    s.marka,
    s.model,
    DATEDIFF(
        COALESCE(w.data_zwrotu, CURDATE()),
        w.data_wypozyczenia
    ) AS czas_wypozyczenia_dni
FROM Wypozyczenia w
INNER JOIN Klienci k
    ON w.id_klienta = k.id_klienta
INNER JOIN Samochody s
    ON w.id_samochodu = s.id_samochodu
WHERE DATEDIFF(
    COALESCE(w.data_zwrotu, CURDATE()),
    w.data_wypozyczenia
) > 30;


-- 5. DOSTĘPNE SAMOCHODY WRAZ Z SERWISEM
CREATE VIEW Dostepne_Samochody AS
SELECT
    s.marka,
    s.model,
    s.numer_rejestracyjny,
    GROUP_CONCAT(
        DISTINCT CONCAT(
            se.opis,
            ' (',
            DATE_FORMAT(se.data_serwisu, '%Y-%m-%d'),
            ')'
        )
        SEPARATOR ', '
    ) AS informacje_o_serwisie
FROM Samochody s
LEFT JOIN Serwisy se
    ON s.id_samochodu = se.id_samochodu
WHERE s.status = 'dostępny'
GROUP BY
    s.id_samochodu,
    s.marka,
    s.model,
    s.numer_rejestracyjny;


-- 6. LICZBA WYPOŻYCZEŃ DLA KAŻDEJ MARKI
CREATE VIEW Liczba_Wypozyczen_Wedlug_Marki AS
SELECT
    s.marka,
    COUNT(w.id_wypozyczenia) AS liczba_wypozyczen
FROM Samochody s
LEFT JOIN Wypozyczenia w
    ON s.id_samochodu = w.id_samochodu
GROUP BY s.marka;


-- 7. KLIENCI, KTÓRZY NIGDY NIE WYPOŻYCZYLI SAMOCHODU
CREATE VIEW Klienci_Bez_Wypozyczen AS
SELECT
    k.id_klienta,
    k.imie,
    k.nazwisko,
    k.email,
    k.data_rejestracji
FROM Klienci k
LEFT JOIN Wypozyczenia w
    ON k.id_klienta = w.id_klienta
WHERE w.id_wypozyczenia IS NULL;


-- WYŚWIETLENIE WYNIKÓW WSZYSTKICH WIDOKÓW

SELECT * FROM Aktywni_Klienci;

SELECT * FROM Czas_Wypozyczen_Klientow;

SELECT * FROM Najwiecej_Wydajacy_Klienci
ORDER BY laczna_kwota_wypozyczen DESC;

SELECT * FROM Najdluzsze_Wypozyczenia;

SELECT * FROM Dostepne_Samochody;

SELECT * FROM Liczba_Wypozyczen_Wedlug_Marki;

SELECT * FROM Klienci_Bez_Wypozyczen;
