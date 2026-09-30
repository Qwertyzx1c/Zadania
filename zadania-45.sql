-- 1.
SELECT * FROM produkty;

-- 2.
SELECT nazwa_produktu, cena_sprzedazy FROM produkty;

-- 3.
SELECT * FROM produkty WHERE cena_sprzedazy > 1000;

-- 4.
SELECT * FROM produkty WHERE id_kategorii = 12;

-- 5.
SELECT * FROM produkty ORDER BY cena_sprzedazy DESC;

-- 6.
SELECT * FROM produkty ORDER BY cena_sprzedazy ASC LIMIT 5;

-- 7.
SELECT COUNT(*) AS liczba_produktow FROM produkty;

-- 8.
SELECT AVG(cena_sprzedazy) AS srednia_cena FROM produkty;

-- 9.
SELECT id_kategorii, COUNT(*) AS ilosc_produktow FROM produkty GROUP BY id_kategorii;

-- 10.
SELECT * FROM produkty WHERE nazwa_produktu LIKE '%iPhone%';

-- 11.
SELECT * FROM klienci WHERE typ_klienta = 'firma';

-- 12.
SELECT * FROM klienci WHERE miasto = 'Warszawa';

-- 13.
SELECT * FROM klienci WHERE rabat_staly > 0;

-- 14.
SELECT * FROM klienci ORDER BY data_rejestracji DESC;

-- 15.
SELECT COUNT(*) AS liczba_klientow_indywidualnych FROM klienci WHERE typ_klienta = 'indywidualny';

-- 16.
SELECT * FROM pracownicy WHERE dzial = 'Sprzedaż';

-- 17.
SELECT * FROM pracownicy WHERE pensja_podstawowa > 10000;

-- 18.
SELECT * FROM pracownicy ORDER BY pensja_podstawowa DESC;

-- 19.
SELECT dzial, AVG(pensja_podstawowa) AS srednia_pensja FROM pracownicy GROUP BY dzial;

-- 20.
SELECT * FROM pracownicy WHERE manager_id IS NULL;

-- 21.
SELECT * FROM zamowienia WHERE status_zamowienia = 'zrealizowane';

-- 22.
SELECT * FROM zamowienia WHERE id_klienta = 1;

-- 23.
SELECT * FROM zamowienia WHERE data_zamowienia >= '2023-04-01' AND data_zamowienia < '2023-05-01';

-- 24.
SELECT * FROM zamowienia WHERE koszt_dostawy = 0;

-- 25.
SELECT id_klienta, COUNT(*) AS ilosc_zamowien FROM zamowienia GROUP BY id_klienta;

-- 26.
SELECT * FROM magazyny;

-- 27.
SELECT * FROM stany_magazynowe WHERE ilosc < 10;

-- 28.
SELECT SUM(ilosc) AS laczna_ilosc_produktow FROM stany_magazynowe;

-- 29.
SELECT id_magazynu, SUM(ilosc) AS laczna_ilosc FROM stany_magazynowe GROUP BY id_magazynu;

-- 30.
SELECT id_produktu, SUM(ilosc) AS calkowity_stan FROM stany_magazynowe GROUP BY id_produktu;

-- 31.
SELECT p.nazwa_produktu, k.nazwa_kategorii 
FROM produkty p 
JOIN kategorie_produktow k ON p.id_kategorii = k.id_kategorii;

-- 32.
SELECT p.nazwa_produktu, pr.nazwa AS nazwa_producenta 
FROM produkty p 
JOIN producenci pr ON p.id_producenta = pr.id_producenta;

-- 33.
SELECT z.id_zamowienia, k.imie, k.nazwisko, k.nazwa_firmy, z.data_zamowienia 
FROM zamowienia z 
JOIN klienci k ON z.id_klienta = k.id_klienta;

-- 34.
SELECT z.id_zamowienia, p.imie, p.nazwisko 
FROM zamowienia z 
JOIN pracownicy p ON z.id_pracownika = p.id_pracownika;

-- 35.
SELECT p.nazwa_produktu, m.nazwa_magazynu, sm.ilosc 
FROM stany_magazynowe sm 
JOIN produkty p ON sm.id_produktu = p.id_produktu 
JOIN magazyny m ON sm.id_magazynu = m.id_magazynu;

-- 36.
SELECT p.nazwa_produktu, k.nazwa_kategorii, pr.nazwa AS producent 
FROM produkty p 
LEFT JOIN kategorie_produktow k ON p.id_kategorii = k.id_kategorii 
LEFT JOIN producenci pr ON p.id_producenta = pr.id_producenta;

-- 37.
SELECT p.imie AS pracownik_imie, p.nazwisko AS pracownik_nazwisko, m.imie AS manager_imie, m.nazwisko AS manager_nazwisko 
FROM pracownicy p 
LEFT JOIN pracownicy m ON p.manager_id = m.id_pracownika;

-- 38.
SELECT z.id_zamowienia, z.data_zamowienia, p.nazwa_produktu, pz.ilosc, pz.cena_jednostkowa 
FROM zamowienia z 
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia 
JOIN produkty p ON pz.id_produktu = p.id_produktu;

-- 39.
SELECT z.id_zamowienia, SUM(pz.ilosc * pz.cena_jednostkowa * (1 - pz.rabat / 100)) AS wartosc_zamowienia 
FROM zamowienia z 
JOIN pozycje_zamowienia pz ON z.id_zamowienia = pz.id_zamowienia 
GROUP BY z.id_zamowienia;

-- 40.
SELECT f.nr_faktury, z.id_zamowienia, f.kwota_brutto, f.status_platnosci 
FROM faktury f 
JOIN zamowienia z ON f.id_zamowienia = z.id_zamowienia;

-- 41.
SELECT * FROM faktury WHERE status_platnosci = 'oczekuje na płatność';

-- 42.
SELECT SUM(kwota_brutto) AS laczny_przychod FROM faktury WHERE status_platnosci = 'opłacona';

-- 43.
SELECT f.nr_faktury, p.data_platnosci, p.kwota, p.forma_platnosci 
FROM platnosci p 
JOIN faktury f ON p.id_faktury = f.id_faktury;

-- 44.
SELECT d.id_dostawy, z.id_zamowienia, d.kurier, d.status_dostawy 
FROM dostawy d 
JOIN zamowienia z ON d.id_zamowienia = z.id_zamowienia;

-- 45.
SELECT pr.nazwa, COUNT(p.id_produktu) AS ilosc_produktow 
FROM producenci pr 
LEFT JOIN produkty p ON pr.id_producenta = p.id_producenta 
GROUP BY pr.id_producenta, pr.nazwa;
