1. SELECT nazwa, cena_netto from produkty WHERE aktywny = 1 AND cena_netto > 1000 GROUP BY id_produktu ORDER BY cena_netto DESC;
2. SELECT nazwa, marka, cena_netto FROM produkty GROUP BY id_produktu ORDER BY cena_netto DESC LIMIT 10;
3. SELECT imie, nazwisko, miasto, data_urodzenia FROM klienci WHERE miasto = "Lublin" OR miasto = "Kraków" AND data_urodzenia > "1990-01-01" ORDER BY nazwisko ASC , imie ASC;
4. SELECT imie, nazwisko, miasto, email FROM klienci WHERE telefon IS NULL ORDER BY miasto ASC, nazwisko ASC;
5. SELECT marka FROM produkty WHERE marka = "Sony" OR marka = "JBL" OR marka = "Bose" AND cena_netto BETWEEN 299 AND 1501 ORDER BY marka ASC, cena_netto DESC;
6. SELECT id_zamowienia, data_zamowienia, metoda_platnosci FROM zamowienia WHERE status = "Anulowane" AND data_zamowienia > "2025-01-01" ORDER BY data_zamowienia DESC;
7. SELECT DISTINCT miasto FROM klienci ORDER BY miasto ASC;
8. SELECT kod_produktu, nazwa, data_dodania FROM produkty WHERE stan_magazynowy = 0 AND aktywny = 1;
9.
