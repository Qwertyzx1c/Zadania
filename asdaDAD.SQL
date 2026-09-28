6. SELECT nazwa FROM producenci ORDER BY nazwa ASC;
7. SELECT nr_faktury, kwota_brutto FROM faktury WHERE data_wystawienia like '2023-03-%';
8. SELECT imie, nazwisko, data_zatrudnienia FROM pracownicy WHERE data_zatrudnienia > '2020-01-01';
9. SELECT imie, nazwisko FROM klienci WHERE imie like 'a%';
10. SELECT nazwa_produktu, cena_sprzedazy FROM produkty WHERE jednostka_miary like '%szt%' ORDER BY cena_sprzedazy DESC;
