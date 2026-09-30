-- 1.
SELECT * FROM produkty WHERE id_kategorii = 12;

-- 2.
SELECT imie, nazwisko, email FROM klienci WHERE typ_klienta = 'indywidualny' AND miasto = 'Warszawa';

-- 3.
SELECT imie, nazwisko FROM pracownicy WHERE dzial = 'Sprzedaż' ORDER BY nazwisko ASC;

-- 4.
SELECT nazwa_produktu, cena_sprzedazy FROM produkty WHERE cena_sprzedazy > 5000;

-- 5.
SELECT id_zamowienia, data_zamowienia FROM zamowienia WHERE status_zamowienia = 'zrealizowane';

-- 6.
SELECT nazwa FROM producenci ORDER BY nazwa ASC;

-- 7.
SELECT nr_faktury, kwota_brutto FROM faktury WHERE data_wystawienia >= '2023-03-01' AND data_wystawienia <= '2023-03-31';

-- 8.
SELECT imie, nazwisko, data_zatrudnienia FROM pracownicy WHERE data_zatrudnienia > '2020-01-01';

-- 9.
SELECT imie, nazwisko FROM klienci WHERE typ_klienta = 'indywidualny' AND imie LIKE 'A%';

-- 10.
SELECT nazwa_produktu, cena_sprzedazy FROM produkty WHERE jednostka_miary = 'szt' ORDER BY cena_sprzedazy DESC;

-- 11.
SELECT nazwa_magazynu, miasto FROM magazyny WHERE miasto IN ('Warszawa', 'Kraków');

-- 12.
SELECT id_zamowienia FROM zamowienia WHERE koszt_dostawy = 0;

-- 13.
SELECT imie, nazwisko, pensja_podstawowa FROM pracownicy WHERE plec = 'M' AND pensja_podstawowa > 8000;

-- 14.
SELECT nazwa_kategorii FROM kategorie_produktow WHERE nadrzedna_kategoria_id IS NULL;

-- 15.
SELECT nazwa_produktu FROM produkty WHERE nazwa_produktu LIKE '%Pro%';

-- 16.
SELECT kp.nazwa_kategorii, AVG(p.cena_sprzedazy) AS srednia_cena_sprzedazy
FROM kategorie_produktow kp
JOIN produkty p ON kp.id_kategorii = p.id_kategorii
GROUP BY kp.id_kategorii, kp.nazwa_kategorii
ORDER BY srednia_cena_sprzedazy DESC;

-- 17.
SELECT nazwa_firmy, rabat_staly FROM klienci WHERE typ_klienta = 'firma' AND rabat_staly > 3.00 ORDER BY rabat_staly DESC;

-- 18.
SELECT 
    CASE 
        WHEN k.typ_klienta = 'firma' THEN k.nazwa_firmy 
        ELSE CONCAT(k.imie, ' ', k.nazwisko) 
    END AS nazwa_klienta,
    COUNT(z.id_zamowienia) AS liczba_zamowien
FROM klienci k
JOIN zamowienia z ON k.id_klienta = z.id_klienta
GROUP BY k.id_klienta
HAVING liczba_zamowien >= 1
ORDER BY liczba_zamowien DESC;

-- 19.
SELECT 
    MONTH(data_wystawienia) AS numer_miesiaca,
    CASE MONTH(data_wystawienia)
        WHEN 1 THEN 'Styczeń'
        WHEN 2 THEN 'Luty'
        WHEN 3 THEN 'Marzec'
        WHEN 4 THEN 'Kwiecień'
        WHEN 5 THEN 'Maj'
        WHEN 6 THEN 'Czerwiec'
        WHEN 7 THEN 'Lipiec'
        WHEN 8 THEN 'Sierpień'
        WHEN 9 THEN 'Wrzesień'
        WHEN 10 THEN 'Październik'
        WHEN 11 THEN 'Listopad'
        WHEN 12 THEN 'Grudzień'
    END AS nazwa_miesiaca,
    SUM(kwota_brutto) AS suma_faktur_brutto
FROM faktury
WHERE YEAR(data_wystawienia) = 2023
GROUP BY MONTH(data_wystawienia)
ORDER BY numer_miesiaca;

-- 20.
SELECT p.nazwa_produktu, COUNT(sm.id_magazynu) AS liczba_magazynow
FROM produkty p
JOIN stany_magazynowe sm ON p.id_produktu = sm.id_produktu
GROUP BY p.id_produktu, p.nazwa_produktu
HAVING liczba_magazynow > 1
ORDER BY liczba_magazynow DESC;

-- 21.
SELECT 
    p.imie AS pracownik_imie, 
    p.nazwisko AS pracownik_nazwisko, 
    m.imie AS manager_imie, 
    m.nazwisko AS manager_nazwisko
FROM pracownicy p
LEFT JOIN pracownicy m ON p.manager_id = m.id_pracownika;

-- 22.
SELECT p.kod_produktu, p.nazwa_produktu, SUM(sm.ilosc) AS laczna_ilosc
FROM produkty p
JOIN stany_magazynowe sm ON p.id_produktu = sm.id_produktu
GROUP BY p.id_produktu, p.kod_produktu, p.nazwa_produktu
HAVING laczna_ilosc > 0;

-- 23.
SELECT id_zamowienia, data_zamowienia 
FROM zamowienia 
WHERE CAST(data_zamowienia AS DATE) BETWEEN '2023-03-10' AND '2023-03-20';

-- 24.
SELECT 
    nazwa_produktu,
    (cena_sprzedazy - cena_zakupu) AS marza,
    ROUND(((cena_sprzedazy - cena_zakupu) / cena_zakupu * 100), 2) AS procent_marzy
FROM produkty
WHERE (cena_sprzedazy - cena_zakupu) > 2000;

-- 25.
SELECT 
    CASE 
        WHEN k.typ_klienta = 'firma' THEN k.nazwa_firmy 
        ELSE CONCAT(k.imie, ' ', k.nazwisko) 
    END AS nazwa_klienta,
    COUNT(z.id_zamowienia) AS liczba_zamowien
FROM klienci k
JOIN zamowienia z ON k.id_klienta = z.id_klienta
GROUP BY k.id_klienta
HAVING liczba_zamowien > 2
ORDER BY liczba_zamowien DESC;

-- 26.
SELECT 
    dzial, 
    ROUND(AVG(YEAR(CURRENT_DATE) - YEAR(data_urodzenia)), 1) AS sredni_wiek
FROM pracownicy
GROUP BY dzial;

-- 27.
SELECT 
    nr_faktury, 
    kwota_brutto, 
    termin_platnosci,
    DATEDIFF(CURRENT_DATE, termin_platnosci) AS dni_zaleglosci
FROM faktury
WHERE status_platnosci = 'oczekuje na płatność';

-- 28.
SELECT 
    p.kod_produktu, 
    p.nazwa_produktu, 
    sm.ilosc AS aktualny_stan, 
    p.min_stan_magazynowy AS minimalny_stan,
    (p.min_stan_magazynowy - sm.ilosc) AS roznica
FROM stany_magazynowe sm
JOIN produkty p ON sm.id_produktu = p.id_produktu
WHERE sm.id_magazynu = 1 AND sm.ilosc < p.min_stan_magazynowy;

-- 29.
SELECT 
    id_dostawy, 
    nr_przesylki, 
    DATEDIFF(rzeczywista_data_dostawy, data_wysylki) AS dni_realizacji
FROM dostawy
WHERE status_dostawy = 'dostarczona' OR rzeczywista_data_dostawy IS NOT NULL
ORDER BY dni_realizacji ASC;

-- 30.
SELECT 
    stanowisko, 
    COUNT(*) AS liczba_pracownikow, 
    SUM(pensja_podstawowa) AS suma_pensji, 
    AVG(pensja_podstawowa) AS srednia_pensja
FROM pracownicy
GROUP BY stanowisko
ORDER BY suma_pensji DESC;

-- 31.
SELECT 
    p.nazwa_produktu, 
    p.kod_produktu, 
    SUM(pz.ilosc) AS laczna_ilosc_sprzedana,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS laczny_przychod
FROM produkty p
JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
GROUP BY p.id_produktu, p.nazwa_produktu, p.kod_produktu
ORDER BY laczny_przychod DESC;

-- 32.
SELECT 
    p.nazwa_produktu, 
    SUM(pz.ilosc) AS laczna_ilosc_sprzedana,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS laczny_przychod
FROM produkty p
JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
GROUP BY p.id_produktu, p.nazwa_produktu
ORDER BY laczna_ilosc_sprzedana DESC
LIMIT 5;

-- 33.
SELECT 
    CASE 
        WHEN k.typ_klienta = 'firma' THEN k.nazwa_firmy 
        ELSE CONCAT(k.imie, ' ', k.nazwisko) 
    END AS nazwa_klienta,
    COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) / COUNT(DISTINCT z.id_zamowienia), 2) AS srednia_wartosc_zamowienia
FROM klienci k
JOIN zamowienia z ON k.id_klienta = z.id_klienta
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia
GROUP BY k.id_klienta
HAVING liczba_zamowien > 1;

-- 34.
SELECT p.nazwa_produktu, p.kod_produktu
FROM produkty p
LEFT JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
WHERE pz.id_pozycji IS NULL;

-- 35.
SELECT 
    pr.imie, 
    pr.nazwisko, 
    pr.stanowisko,
    SUM(f.kwota_brutto) AS laczna_wartosc_brutto
FROM pracownicy pr
JOIN zamowienia z ON pr.id_pracownika = z.id_pracownika
JOIN faktury f ON z.id_zamowienia = f.id_zamowienia
GROUP BY pr.id_pracownika, pr.imie, pr.nazwisko, pr.stanowisko
HAVING laczna_wartosc_brutto > 100000;

-- 36.
SELECT 
    pr.nazwa AS nazwa_producenta,
    COUNT(DISTINCT pz.id_produktu) AS liczba_roznych_produktow,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS laczna_wartosc_sprzedazy
FROM producenci pr
JOIN produkty p ON pr.id_producenta = p.id_producenta
JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
GROUP BY pr.id_producenta, pr.nazwa
ORDER BY laczna_wartosc_sprzedazy DESC;

-- 37.
SELECT 
    p.nazwa_produktu,
    SUM(pz.ilosc) AS liczba_sprzedanych,
    COUNT(r.id_reklamacji) AS liczba_reklamacji,
    ROUND((COUNT(r.id_reklamacji) / SUM(pz.ilosc) * 100), 2) AS procent_reklamacji
FROM produkty p
JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
JOIN reklamacje r ON p.id_produktu = r.id_produktu
GROUP BY p.id_produktu, p.nazwa_produktu;

-- 38.
SELECT 
    z.id_zamowienia, 
    z.data_zamowienia, 
    z.rabat_zamowienia AS wartosc_rabatu,
    CASE 
        WHEN k.typ_klienta = 'firma' THEN k.nazwa_firmy 
        ELSE CONCAT(k.imie, ' ', k.nazwisko) 
    END AS nazwa_klienta
FROM zamowienia z
JOIN klienci k ON z.id_klienta = k.id_klienta
WHERE z.rabat_zamowienia > (SELECT AVG(rabat_zamowienia) FROM zamowienia);

-- 39.
SELECT 
    MONTH(f.data_wystawienia) AS numer_miesiaca,
    CASE MONTH(f.data_wystawienia)
        WHEN 1 THEN 'Styczeń'
        WHEN 2 THEN 'Luty'
        WHEN 3 THEN 'Marzec'
        WHEN 4 THEN 'Kwiecień'
        WHEN 5 THEN 'Maj'
        WHEN 6 THEN 'Czerwiec'
        WHEN 7 THEN 'Lipiec'
        WHEN 8 THEN 'Sierpień'
        WHEN 9 THEN 'Wrzesień'
        WHEN 10 THEN 'Październik'
        WHEN 11 THEN 'Listopad'
        WHEN 12 THEN 'Grudzień'
    END AS nazwa_miesiaca,
    COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
    ROUND(SUM(f.kwota_brutto), 2) AS laczna_wartosc_sprzedazy,
    ROUND(SUM(f.kwota_brutto) / COUNT(DISTINCT z.id_zamowienia), 2) AS srednia_wartosc_zamowienia
FROM faktury f
JOIN zamowienia z ON f.id_zamowienia = z.id_zamowienia
WHERE YEAR(f.data_wystawienia) = 2023
GROUP BY MONTH(f.data_wystawienia)
ORDER BY numer_miesiaca;

-- 40.
SELECT 
    CASE 
        WHEN k.typ_klienta = 'firma' THEN k.nazwa_firmy 
        ELSE CONCAT(k.imie, ' ', k.nazwisko) 
    END AS nazwa_klienta,
    COUNT(DISTINCT p.id_kategorii) AS liczba_kategorii
FROM klienci k
JOIN zamowienia z ON k.id_klienta = z.id_klienta
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia
JOIN produkty p ON pz.id_produktu = p.id_produktu
GROUP BY k.id_klienta
HAVING liczba_kategorii >= 3
ORDER BY liczba_kategorii DESC;

-- 41.
SELECT 
    p.nazwa_produktu,
    p.kod_produktu,
    COALESCE(SUM(pz.ilosc), 0) AS ilosc_sprzedana,
    ROUND(AVG(sm.ilosc), 2) AS sredni_stan_magazynowy,
    ROUND(COALESCE(SUM(pz.ilosc), 0) / AVG(sm.ilosc), 2) AS wskaźnik_rotacji
FROM produkty p
JOIN stany_magazynowe sm ON p.id_produktu = sm.id_produktu
LEFT JOIN pozycje_zamowienia pz ON p.id_produktu = pz.id_produktu
GROUP BY p.id_produktu, p.nazwa_produktu, p.kod_produktu
HAVING AVG(sm.ilosc) > 0;

-- 42.
SELECT * 
FROM produkty 
WHERE (id_kategorii = 1 OR id_kategorii IN (SELECT id_kategorii FROM kategorie_produktow WHERE nadrzedna_kategoria_id = 1))
  AND cena_sprzedazy > (SELECT AVG(cena_sprzedazy) FROM produkty);

-- 43.
SELECT 
    p1.nazwa_produktu AS produkt_1,
    p2.nazwa_produktu AS produkt_2,
    COUNT(*) AS liczba_wspolnych_zamowien
FROM pozycje_zamowienia pz1
JOIN pozycje_zamowienia pz2 ON pz1.id_zamowienia = pz2.id_zamowienia AND pz1.id_produktu < pz2.id_produktu
JOIN produkty p1 ON pz1.id_produktu = p1.id_produktu
JOIN produkty p2 ON pz2.id_produktu = p2.id_produktu
GROUP BY p1.id_produktu, p2.id_produktu, p1.nazwa_produktu, p2.nazwa_produktu
ORDER BY liczba_wspolnych_zamowien DESC
LIMIT 10;

-- 44.
SELECT 
    pr.imie,
    pr.nazwisko,
    pr.stanowisko,
    pr.pensja_podstawowa,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS wartosc_obsluzonych_zamowien,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) / pr.pensja_podstawowa, 2) AS wsk_efektywnosci
FROM pracownicy pr
JOIN zamowienia z ON pr.id_pracownika = z.id_pracownika
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia
WHERE pr.dzial = 'Sprzedaż'
GROUP BY pr.id_pracownika, pr.imie, pr.nazwisko, pr.stanowisko, pr.pensja_podstawowa
ORDER BY wsk_efektywnosci DESC;

-- 45.
SELECT 
    MONTH(z.data_zamowienia) AS numer_miesiaca,
    CASE MONTH(z.data_zamowienia)
        WHEN 1 THEN 'Styczeń'
        WHEN 2 THEN 'Luty'
        WHEN 3 THEN 'Marzec'
        WHEN 4 THEN 'Kwiecień'
        WHEN 5 THEN 'Maj'
        WHEN 6 THEN 'Czerwiec'
        WHEN 7 THEN 'Lipiec'
        WHEN 8 THEN 'Sierpień'
        WHEN 9 THEN 'Wrzesień'
        WHEN 10 THEN 'Październik'
        WHEN 11 THEN 'Listopad'
        WHEN 12 THEN 'Grudzień'
    END AS nazwa_miesiaca,
    COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
    ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) / COUNT(DISTINCT z.id_zamowienia), 2) AS srednia_wartosc_zamowienia
FROM zamowienia z
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia
GROUP BY MONTH(z.data_zamowienia)
ORDER BY numer_miesiaca;
