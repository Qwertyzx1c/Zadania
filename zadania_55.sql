-- 1
SELECT * FROM produkty WHERE kategoria_id = 12;

-- 2
SELECT imie, nazwisko, email
FROM klienci
WHERE typ_klienta = 'indywidualny' AND miasto = 'Warszawa';

-- 3
SELECT p.imie, p.nazwisko
FROM pracownicy p
JOIN dzialy d ON p.dzial_id = d.id_dzialu
WHERE d.nazwa = 'Sprzedaż'
ORDER BY p.nazwisko;

-- 4
SELECT nazwa, cena_sprzedazy
FROM produkty
WHERE cena_sprzedazy > 5000;

-- 5
SELECT id_zamowienia, data_zamowienia
FROM zamowienia
WHERE status = 'zrealizowane';

-- 6
SELECT nazwa
FROM producenci
ORDER BY nazwa;

-- 7
SELECT numer_faktury, kwota_brutto
FROM faktury
WHERE data_wystawienia >= '2023-03-01'
  AND data_wystawienia < '2023-04-01';

-- 8
SELECT imie, nazwisko, data_zatrudnienia
FROM pracownicy
WHERE data_zatrudnienia > '2020-01-01';

-- 9
SELECT imie, nazwisko
FROM klienci
WHERE typ_klienta = 'indywidualny'
  AND imie LIKE 'A%';

-- 10
SELECT nazwa, cena_sprzedazy
FROM produkty
WHERE jednostka_miary = 'szt'
ORDER BY cena_sprzedazy DESC;

-- 11
SELECT nazwa, miasto
FROM magazyny
WHERE miasto IN ('Warszawa', 'Kraków');

-- 12
SELECT id_zamowienia
FROM zamowienia
WHERE koszt_dostawy = 0;

-- 13
SELECT imie, nazwisko, pensja_podstawowa
FROM pracownicy
WHERE plec = 'M' AND pensja_podstawowa > 8000;

-- 14
SELECT nazwa
FROM kategorie
WHERE nadrzedna_kategoria_id IS NULL;

-- 15
SELECT nazwa
FROM produkty
WHERE nazwa LIKE '%Pro%';


-- =========================
-- ZADANIA ŚREDNIE
-- =========================

-- 16
SELECT k.nazwa, AVG(p.cena_sprzedazy) AS srednia_cena
FROM kategorie k
JOIN produkty p ON p.kategoria_id = k.id_kategorii
GROUP BY k.id_kategorii, k.nazwa
ORDER BY srednia_cena DESC;

-- 17
SELECT nazwa_firmy, rabat_staly
FROM klienci
WHERE typ_klienta = 'firma'
  AND rabat_staly > 3
ORDER BY rabat_staly DESC;

-- 18
SELECT
    CASE WHEN k.typ_klienta = 'firma'
         THEN k.nazwa_firmy
         ELSE CONCAT(k.imie, ' ', k.nazwisko)
    END AS klient,
    COUNT(z.id_zamowienia) AS liczba_zamowien
FROM klienci k
JOIN zamowienia z ON z.klient_id = k.id_klienta
GROUP BY k.id_klienta, klient
ORDER BY liczba_zamowien DESC;

-- 19
SELECT
    MONTH(data_wystawienia) AS numer_miesiaca,
    CASE MONTH(data_wystawienia)
        WHEN 1 THEN 'Styczeń' WHEN 2 THEN 'Luty' WHEN 3 THEN 'Marzec'
        WHEN 4 THEN 'Kwiecień' WHEN 5 THEN 'Maj' WHEN 6 THEN 'Czerwiec'
        WHEN 7 THEN 'Lipiec' WHEN 8 THEN 'Sierpień' WHEN 9 THEN 'Wrzesień'
        WHEN 10 THEN 'Październik' WHEN 11 THEN 'Listopad' WHEN 12 THEN 'Grudzień'
    END AS nazwa_miesiaca,
    SUM(kwota_brutto) AS suma_faktur
FROM faktury
WHERE YEAR(data_wystawienia) = 2023
GROUP BY MONTH(data_wystawienia)
ORDER BY numer_miesiaca;

-- 20
SELECT p.nazwa, COUNT(DISTINCT s.id_magazynu) AS liczba_magazynow
FROM produkty p
JOIN stany_magazynowe s ON s.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.nazwa
HAVING COUNT(DISTINCT s.id_magazynu) > 1
ORDER BY liczba_magazynow DESC;

-- 21
SELECT
    p.imie, p.nazwisko,
    m.imie AS manager_imie,
    m.nazwisko AS manager_nazwisko
FROM pracownicy p
LEFT JOIN pracownicy m ON p.manager_id = m.id_pracownika;

-- 22
SELECT p.kod_produktu, p.nazwa, SUM(s.ilosc) AS suma_ilosci
FROM produkty p
JOIN stany_magazynowe s ON s.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.kod_produktu, p.nazwa
HAVING SUM(s.ilosc) > 0;

-- 23
SELECT id_zamowienia, data_zamowienia
FROM zamowienia
WHERE data_zamowienia BETWEEN '2023-03-10' AND '2023-03-20';

-- 24
SELECT
    nazwa,
    ROUND(cena_sprzedazy - cena_zakupu, 2) AS marza,
    ROUND((cena_sprzedazy - cena_zakupu) / cena_zakupu * 100, 2) AS procent_marzy
FROM produkty
WHERE cena_sprzedazy - cena_zakupu > 2000;

-- 25
SELECT
    CASE WHEN k.typ_klienta = 'firma'
         THEN k.nazwa_firmy
         ELSE CONCAT(k.imie, ' ', k.nazwisko)
    END AS klient,
    COUNT(z.id_zamowienia) AS liczba_zamowien
FROM klienci k
JOIN zamowienia z ON z.klient_id = k.id_klienta
GROUP BY k.id_klienta, klient
HAVING COUNT(z.id_zamowienia) > 2
ORDER BY liczba_zamowien DESC;

-- 26
SELECT d.nazwa AS dzial,
       ROUND(AVG(YEAR(CURRENT_DATE) - YEAR(p.data_urodzenia)), 1) AS sredni_wiek
FROM dzialy d
JOIN pracownicy p ON p.dzial_id = d.id_dzialu
GROUP BY d.id_dzialu, d.nazwa;

-- 27
SELECT numer_faktury, kwota_brutto, termin_platnosci,
       DATEDIFF(CURRENT_DATE, termin_platnosci) AS dni_zaleglosci
FROM faktury
WHERE status_platnosci = 'oczekuje na płatność';

-- 28
SELECT p.kod_produktu, p.nazwa,
       s.ilosc AS aktualny_stan,
       p.minimalny_stan,
       p.minimalny_stan - s.ilosc AS roznica
FROM produkty p
JOIN stany_magazynowe s ON s.produkt_id = p.id_produktu
WHERE s.id_magazynu = 1
  AND s.ilosc < p.minimalny_stan;

-- 29
SELECT id_dostawy, numer_przesylki,
       DATEDIFF(data_dostawy_rzeczywistej, data_wysylki) AS dni_realizacji
FROM dostawy
WHERE data_dostawy_rzeczywistej IS NOT NULL
ORDER BY dni_realizacji;

-- 30
SELECT stanowisko,
       COUNT(*) AS liczba_pracownikow,
       SUM(pensja_podstawowa) AS suma_pensji,
       AVG(pensja_podstawowa) AS srednia_pensja
FROM pracownicy
GROUP BY stanowisko
ORDER BY suma_pensji DESC;


-- =========================
-- ZADANIA TRUDNE
-- =========================

-- 31
SELECT p.nazwa, p.kod_produktu,
       SUM(pz.ilosc) AS sprzedana_ilosc,
       ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS przychod
FROM produkty p
JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.nazwa, p.kod_produktu
ORDER BY przychod DESC;

-- 32
SELECT p.nazwa,
       SUM(pz.ilosc) AS sprzedana_ilosc,
       ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS przychod
FROM produkty p
JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.nazwa
ORDER BY sprzedana_ilosc DESC
LIMIT 5;

-- 33
SELECT
    CASE WHEN k.typ_klienta = 'firma'
         THEN k.nazwa_firmy
         ELSE CONCAT(k.imie, ' ', k.nazwisko)
    END AS klient,
    COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
    ROUND(AVG(wartosc_zamowienia), 2) AS srednia_wartosc
FROM klienci k
JOIN zamowienia z ON z.klient_id = k.id_klienta
JOIN (
    SELECT id_zamowienia,
           SUM(cena_jednostkowa * ilosc * (1 - rabat / 100)) AS wartosc_zamowienia
    FROM pozycje_zamowienia
    GROUP BY id_zamowienia
) x ON x.id_zamowienia = z.id_zamowienia
GROUP BY k.id_klienta, klient
HAVING COUNT(DISTINCT z.id_zamowienia) > 1;

-- 34
SELECT p.nazwa, p.kod_produktu
FROM produkty p
LEFT JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
WHERE pz.produkt_id IS NULL;

-- 35
SELECT p.imie, p.nazwisko, p.stanowisko,
       SUM(f.kwota_brutto) AS wartosc_zamowien
FROM pracownicy p
JOIN zamowienia z ON z.pracownik_id = p.id_pracownika
JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
GROUP BY p.id_pracownika, p.imie, p.nazwisko, p.stanowisko
HAVING SUM(f.kwota_brutto) > 100000;

-- 36
SELECT pr.nazwa,
       COUNT(DISTINCT p.id_produktu) AS liczba_produktow,
       ROUND(SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)), 2) AS wartosc_sprzedazy
FROM producenci pr
JOIN produkty p ON p.producent_id = pr.id_producenta
JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
GROUP BY pr.id_producenta, pr.nazwa
ORDER BY wartosc_sprzedazy DESC;

-- 37
SELECT p.nazwa,
       SUM(pz.ilosc) AS liczba_sprzedanych,
       COUNT(DISTINCT r.id_reklamacji) AS liczba_reklamacji,
       ROUND(COUNT(DISTINCT r.id_reklamacji) / SUM(pz.ilosc) * 100, 2) AS procent_reklamacji
FROM produkty p
JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
JOIN reklamacje r ON r.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.nazwa;

-- 38
SELECT z.id_zamowienia, z.data_zamowienia, z.rabat,
       CASE WHEN k.typ_klienta = 'firma'
            THEN k.nazwa_firmy
            ELSE CONCAT(k.imie, ' ', k.nazwisko)
       END AS klient
FROM zamowienia z
JOIN klienci k ON k.id_klienta = z.klient_id
WHERE z.rabat > (SELECT AVG(rabat) FROM zamowienia);

-- 39
SELECT MONTH(z.data_zamowienia) AS numer_miesiaca,
       CASE MONTH(z.data_zamowienia)
           WHEN 1 THEN 'Styczeń' WHEN 2 THEN 'Luty' WHEN 3 THEN 'Marzec'
           WHEN 4 THEN 'Kwiecień' WHEN 5 THEN 'Maj' WHEN 6 THEN 'Czerwiec'
           WHEN 7 THEN 'Lipiec' WHEN 8 THEN 'Sierpień' WHEN 9 THEN 'Wrzesień'
           WHEN 10 THEN 'Październik' WHEN 11 THEN 'Listopad' WHEN 12 THEN 'Grudzień'
       END AS nazwa_miesiaca,
       COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
       ROUND(SUM(f.kwota_brutto), 2) AS wartosc_sprzedazy,
       ROUND(AVG(f.kwota_brutto), 2) AS srednia_wartosc_zamowienia
FROM zamowienia z
JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
WHERE YEAR(z.data_zamowienia) = 2023
GROUP BY MONTH(z.data_zamowienia)
ORDER BY numer_miesiaca;

-- 40
SELECT
    CASE WHEN k.typ_klienta = 'firma'
         THEN k.nazwa_firmy
         ELSE CONCAT(k.imie, ' ', k.nazwisko)
    END AS klient,
    COUNT(DISTINCT p.kategoria_id) AS liczba_kategorii
FROM klienci k
JOIN zamowienia z ON z.klient_id = k.id_klienta
JOIN pozycje_zamowienia pz ON pz.id_zamowienia = z.id_zamowienia
JOIN produkty p ON p.id_produktu = pz.produkt_id
GROUP BY k.id_klienta, klient
HAVING COUNT(DISTINCT p.kategoria_id) >= 3
ORDER BY liczba_kategorii DESC;

-- 41
SELECT p.nazwa, p.kod_produktu,
       COALESCE(SUM(pz.ilosc), 0) AS ilosc_sprzedana,
       AVG(s.ilosc) AS sredni_stan_magazynowy,
       ROUND(COALESCE(SUM(pz.ilosc), 0) / NULLIF(AVG(s.ilosc), 0), 2) AS wskaznik_rotacji
FROM produkty p
LEFT JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
LEFT JOIN stany_magazynowe s ON s.produkt_id = p.id_produktu
GROUP BY p.id_produktu, p.nazwa, p.kod_produktu;

-- 42
SELECT *
FROM produkty
WHERE (kategoria_id = 1 OR kategoria_id IN (
    SELECT id_kategorii FROM kategorie WHERE nadrzedna_kategoria_id = 1
))
AND cena_sprzedazy > (SELECT AVG(cena_sprzedazy) FROM produkty);

-- 43
SELECT p1.nazwa AS produkt_1,
       p2.nazwa AS produkt_2,
       COUNT(DISTINCT a.id_zamowienia) AS liczba_zamowien
FROM pozycje_zamowienia a
JOIN pozycje_zamowienia b
  ON a.id_zamowienia = b.id_zamowienia
 AND a.produkt_id < b.produkt_id
JOIN produkty p1 ON p1.id_produktu = a.produkt_id
JOIN produkty p2 ON p2.id_produktu = b.produkt_id
GROUP BY a.produkt_id, b.produkt_id, p1.nazwa, p2.nazwa
ORDER BY liczba_zamowien DESC
LIMIT 10;

-- 44
SELECT p.imie, p.nazwisko, p.stanowisko, p.pensja_podstawowa,
       SUM(f.kwota_brutto) AS wartosc_zamowien,
       ROUND(SUM(f.kwota_brutto) / NULLIF(p.pensja_podstawowa, 0), 2) AS efektywnosc
FROM pracownicy p
JOIN zamowienia z ON z.pracownik_id = p.id_pracownika
JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
JOIN dzialy d ON d.id_dzialu = p.dzial_id
WHERE d.nazwa = 'Sprzedaż'
GROUP BY p.id_pracownika, p.imie, p.nazwisko, p.stanowisko, p.pensja_podstawowa
ORDER BY efektywnosc DESC;

-- 45
SELECT MONTH(data_zamowienia) AS numer_miesiaca,
       CASE MONTH(data_zamowienia)
           WHEN 1 THEN 'Styczeń' WHEN 2 THEN 'Luty' WHEN 3 THEN 'Marzec'
           WHEN 4 THEN 'Kwiecień' WHEN 5 THEN 'Maj' WHEN 6 THEN 'Czerwiec'
           WHEN 7 THEN 'Lipiec' WHEN 8 THEN 'Sierpień' WHEN 9 THEN 'Wrzesień'
           WHEN 10 THEN 'Październik' WHEN 11 THEN 'Listopad' WHEN 12 THEN 'Grudzień'
       END AS nazwa_miesiaca,
       ROUND(AVG(wartosc), 2) AS srednia_wartosc_zamowienia,
       COUNT(*) AS liczba_zamowien
FROM (
    SELECT z.id_zamowienia, z.data_zamowienia,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM zamowienia z
    JOIN pozycje_zamowienia pz ON pz.id_zamowienia = z.id_zamowienia
    GROUP BY z.id_zamowienia, z.data_zamowienia
) x
GROUP BY MONTH(data_zamowienia)
ORDER BY numer_miesiaca;


-- =========================
-- ZADANIA BARDZO TRUDNE
-- =========================

-- 46
WITH dane AS (
    SELECT k.id_klienta,
           CASE WHEN k.typ_klienta = 'firma'
                THEN k.nazwa_firmy
                ELSE CONCAT(k.imie, ' ', k.nazwisko)
           END AS klient,
           COUNT(z.id_zamowienia) AS liczba_zamowien,
           SUM(f.kwota_brutto) - COUNT(z.id_zamowienia) * 50 AS clv
    FROM klienci k
    JOIN zamowienia z ON z.klient_id = k.id_klienta
    JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
    GROUP BY k.id_klienta, klient
)
SELECT klient, clv, liczba_zamowien
FROM dane
ORDER BY clv DESC
LIMIT 10;

-- 47
WITH pierwsze AS (
    SELECT k.id_klienta,
           DATE_FORMAT(k.data_rejestracji, '%Y%m') AS kohorta,
           MIN(z.data_zamowienia) AS pierwsze_zamowienie
    FROM klienci k
    JOIN zamowienia z ON z.klient_id = k.id_klienta
    GROUP BY k.id_klienta, kohorta
),
wartosci AS (
    SELECT z.klient_id, z.id_zamowienia,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM zamowienia z
    JOIN pozycje_zamowienia pz ON pz.id_zamowienia = z.id_zamowienia
    GROUP BY z.klient_id, z.id_zamowienia
)
SELECT p.kohorta,
       COUNT(DISTINCT p.id_klienta) AS liczba_klientow,
       AVG(CASE WHEN v.id_zamowienia = (
           SELECT z2.id_zamowienia
           FROM zamowienia z2
           WHERE z2.klient_id = p.id_klienta
           ORDER BY z2.data_zamowienia, z2.id_zamowienia
           LIMIT 1
       ) THEN v.wartosc END) AS srednia_pierwszego,
       AVG(v.wartosc) AS srednia_wszystkich
FROM pierwsze p
JOIN wartosci v ON v.klient_id = p.id_klienta
GROUP BY p.kohorta
HAVING COUNT(DISTINCT p.id_klienta) >= 2;

-- 48
WITH ranking AS (
    SELECT k.nazwa AS kategoria, p.nazwa AS produkt,
           p.cena_zakupu, p.cena_sprzedazy,
           p.cena_sprzedazy - p.cena_zakupu AS marza,
           ROW_NUMBER() OVER (
               PARTITION BY k.id_kategorii
               ORDER BY p.cena_sprzedazy - p.cena_zakupu DESC
           ) AS rn
    FROM produkty p
    JOIN kategorie k ON k.id_kategorii = p.kategoria_id
)
SELECT kategoria, produkt, cena_zakupu, cena_sprzedazy, marza
FROM ranking
WHERE rn <= 3;

-- 49
WITH koszyki AS (
    SELECT z.id_zamowienia, DAYOFWEEK(z.data_zamowienia) AS dzien,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM zamowienia z
    JOIN pozycje_zamowienia pz ON pz.id_zamowienia = z.id_zamowienia
    GROUP BY z.id_zamowienia, dzien
)
SELECT CASE dzien
           WHEN 1 THEN 'Niedziela' WHEN 2 THEN 'Poniedziałek'
           WHEN 3 THEN 'Wtorek' WHEN 4 THEN 'Środa'
           WHEN 5 THEN 'Czwartek' WHEN 6 THEN 'Piątek'
           WHEN 7 THEN 'Sobota'
       END AS dzien_tygodnia,
       COUNT(*) AS liczba_zamowien,
       ROUND(AVG(wartosc), 2) AS srednia_wartosc_koszyka
FROM koszyki
GROUP BY dzien
ORDER BY dzien;

-- 50
SELECT p.kod_produktu, p.nazwa,
       COALESCE(s.stan, 0) AS aktualny_stan,
       p.minimalny_stan,
       COALESCE(sprzedaz.ilosc, 0) AS sprzedane_sztuki
FROM produkty p
LEFT JOIN (
    SELECT produkt_id, SUM(ilosc) AS stan
    FROM stany_magazynowe
    GROUP BY produkt_id
) s ON s.produkt_id = p.id_produktu
JOIN (
    SELECT pz.produkt_id, SUM(pz.ilosc) AS ilosc
    FROM pozycje_zamowienia pz
    JOIN zamowienia z ON z.id_zamowienia = pz.id_zamowienia
    WHERE z.data_zamowienia >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)
    GROUP BY pz.produkt_id
) sprzedaz ON sprzedaz.produkt_id = p.id_produktu
WHERE COALESCE(s.stan, 0) < p.minimalny_stan * 1.5;

-- 51
WITH rfm AS (
    SELECT k.id_klienta,
           CASE WHEN k.typ_klienta = 'firma'
                THEN k.nazwa_firmy
                ELSE CONCAT(k.imie, ' ', k.nazwisko)
           END AS klient,
           DATEDIFF(CURRENT_DATE, MAX(z.data_zamowienia)) AS R,
           COUNT(z.id_zamowienia) AS F,
           SUM(f.kwota_brutto) AS M
    FROM klienci k
    JOIN zamowienia z ON z.klient_id = k.id_klienta
    JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
    GROUP BY k.id_klienta, klient
)
SELECT klient, R, F, M
FROM rfm
ORDER BY M DESC;

-- 52
WITH sprzedaz AS (
    SELECT p.id_produktu, p.nazwa,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM produkty p
    JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
    GROUP BY p.id_produktu, p.nazwa
),
abc AS (
    SELECT *,
           wartosc / SUM(wartosc) OVER () * 100 AS procent,
           SUM(wartosc) OVER (ORDER BY wartosc DESC) /
           SUM(wartosc) OVER () * 100 AS skumulowany_procent
    FROM sprzedaz
)
SELECT nazwa, ROUND(wartosc, 2) AS wartosc_sprzedazy,
       ROUND(procent, 2) AS procent_sprzedazy,
       ROUND(skumulowany_procent, 2) AS skumulowany_procent,
       CASE
           WHEN skumulowany_procent <= 80 THEN 'A'
           WHEN skumulowany_procent <= 95 THEN 'B'
           ELSE 'C'
       END AS ABC
FROM abc
ORDER BY wartosc DESC;

-- 53
WITH marzec AS (
    SELECT p.id_produktu, p.nazwa,
           SUM(pz.ilosc) AS ilosc,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM produkty p
    JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
    JOIN zamowienia z ON z.id_zamowienia = pz.id_zamowienia
    WHERE z.data_zamowienia >= '2023-03-01'
      AND z.data_zamowienia < '2023-04-01'
    GROUP BY p.id_produktu, p.nazwa
),
kwiecien AS (
    SELECT p.id_produktu, p.nazwa,
           SUM(pz.ilosc) AS ilosc,
           SUM(pz.cena_jednostkowa * pz.ilosc * (1 - pz.rabat / 100)) AS wartosc
    FROM produkty p
    JOIN pozycje_zamowienia pz ON pz.produkt_id = p.id_produktu
    JOIN zamowienia z ON z.id_zamowienia = pz.id_zamowienia
    WHERE z.data_zamowienia >= '2023-04-01'
      AND z.data_zamowienia < '2023-05-01'
    GROUP BY p.id_produktu, p.nazwa
)
SELECT m.nazwa,
       m.ilosc AS ilosc_marzec,
       m.wartosc AS wartosc_marzec,
       k.ilosc AS ilosc_kwiecien,
       k.wartosc AS wartosc_kwiecien,
       ROUND((k.ilosc - m.ilosc) / NULLIF(m.ilosc, 0) * 100, 2) AS zmiana_ilosci,
       ROUND((k.wartosc - m.wartosc) / NULLIF(m.wartosc, 0) * 100, 2) AS zmiana_wartosci
FROM marzec m
JOIN kwiecien k ON k.id_produktu = m.id_produktu;

-- 54
WITH klienci_stat AS (
    SELECT k.id_klienta,
           CASE WHEN k.typ_klienta = 'firma'
                THEN k.nazwa_firmy
                ELSE CONCAT(k.imie, ' ', k.nazwisko)
           END AS klient,
           COUNT(z.id_zamowienia) AS liczba_zamowien,
           SUM(f.kwota_brutto) AS wartosc_zamowien,
           AVG(f.kwota_brutto) AS srednia_wartosc
    FROM klienci k
    JOIN zamowienia z ON z.klient_id = k.id_klienta
    JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
    GROUP BY k.id_klienta, klient
),
srednie AS (
    SELECT AVG(wartosc_zamowien) AS sr_wartosc,
           AVG(liczba_zamowien) AS sr_liczba,
           AVG(srednia_wartosc) AS sr_srednia
    FROM klienci_stat
)
SELECT k.*,
       (k.wartosc_zamowien > s.sr_wartosc) +
       (k.liczba_zamowien > s.sr_liczba) +
       (k.srednia_wartosc > s.sr_srednia) AS spelnione_kryteria
FROM klienci_stat k
CROSS JOIN srednie s
WHERE
    (k.wartosc_zamowien > s.sr_wartosc) +
    (k.liczba_zamowien > s.sr_liczba) +
    (k.srednia_wartosc > s.sr_srednia) >= 2;

-- 55
WITH dane AS (
    SELECT p.id_pracownika, p.imie, p.nazwisko,
           COUNT(DISTINCT z.id_zamowienia) AS liczba_zamowien,
           AVG(f.kwota_brutto) AS srednia_wartosc,
           SUM(f.kwota_brutto) AS laczna_sprzedaz
    FROM pracownicy p
    JOIN dzialy d ON d.id_dzialu = p.dzial_id
    LEFT JOIN zamowienia z ON z.pracownik_id = p.id_pracownika
    LEFT JOIN faktury f ON f.zamowienie_id = z.id_zamowienia
    WHERE d.nazwa = 'Sprzedaż'
    GROUP BY p.id_pracownika, p.imie, p.nazwisko
),
ranking AS (
    SELECT *,
           RANK() OVER (ORDER BY laczna_sprzedaz DESC) AS pozycja,
           MAX(laczna_sprzedaz) OVER () AS lider
    FROM dane
)
SELECT imie, nazwisko, liczba_zamowien,
       ROUND(srednia_wartosc, 2) AS srednia_wartosc,
       ROUND(laczna_sprzedaz, 2) AS laczna_sprzedaz,
       pozycja,
       ROUND((laczna_sprzedaz - lider) / NULLIF(lider, 0) * 100, 2) AS roznica_do_lidera_proc
FROM ranking
ORDER BY pozycja;
