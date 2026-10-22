CREATE DATABASE IF NOT EXISTS operacje_plastyczne
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_polish_ci;

USE operacje_plastyczne;

CREATE TABLE pacjenci (
    id_pacjenta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    data_urodzenia DATE NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    numer_telefonu VARCHAR(15) NOT NULL UNIQUE,
    adres_zamieszkania VARCHAR(100) NOT NULL,
    pesel CHAR(11) NOT NULL UNIQUE,
    kontakt_alarmowy VARCHAR(15) NOT NULL
);

CREATE TABLE personel (
    id_personelu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    data_urodzenia DATE NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    rola VARCHAR(20) NOT NULL,
    specjalizacja VARCHAR(50) UNIQUE,
    numer_pwz VARCHAR(20) UNIQUE NOT NULL,
    telefon VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE sale_operacyjne (
    id_sali INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numer_sali INT UNSIGNED NOT NULL UNIQUE,
    status ENUM('dostepna', 'zajeta', 'w_serwisie') NOT NULL DEFAULT 'dostepna'
);

CREATE TABLE wywiad_medyczny (
    id_wywiadu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    id_personelu INT UNSIGNED NOT NULL,
    data_wywiadu DATE NOT NULL,
    grupa_krwi ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', '0+', '0-'),
    alergie VARCHAR(100),
    choroby_przewlekle VARCHAR(100),
    leki VARCHAR(100),
    przebyte_operacje VARCHAR(100),
    palenie_tytoniu ENUM('tak', 'nie', 'kiedys'),
    spozywanie_alkoholu ENUM('tak', 'nie', 'okresowo'),
    aktywnosc_fizyczna ENUM('wysoka', 'umiarkowana', 'niska'),
    dieta ENUM('wegetarianska', 'weganska', 'bezglutenowa', 'standardowa'),
    inne_informacje VARCHAR(200),
    CONSTRAINT fk_wywiad_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CONSTRAINT fk_wywiad_personel
        FOREIGN KEY (id_personelu) REFERENCES personel(id_personelu)
);

CREATE TABLE wizyty_i_konsultacje (
    id_wizyty INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    id_personelu INT UNSIGNED NOT NULL,
    data_wizyty DATE NOT NULL,
    typ_wizyty ENUM('konsultacja', 'wizyta') NOT NULL,
    rozpoznanie VARCHAR(100),
    zalecenia VARCHAR(100),
    CONSTRAINT fk_wizyty_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CONSTRAINT fk_wizyty_personel
        FOREIGN KEY (id_personelu) REFERENCES personel(id_personelu)
);

CREATE TABLE zabiegi_i_operacje (
    id_zabiegu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    id_sali INT UNSIGNED NOT NULL,
    nazwa_zabiegu VARCHAR(50) NOT NULL,
    data_operacji DATE NOT NULL,
    czas_trwania INT UNSIGNED,
    znieczulenie ENUM('ogolne', 'miejscowe', 'regionalne'),
    powiklania VARCHAR(100),
    CONSTRAINT fk_zabiegi_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CONSTRAINT fk_zabiegi_sala
        FOREIGN KEY (id_sali) REFERENCES sale_operacyjne(id_sali)
);

CREATE TABLE zdjecia_przed_po (
    id_zdjecia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    id_zabiegu INT UNSIGNED NOT NULL,
    id_sali INT UNSIGNED,
    nazwa_pliku VARCHAR(100) NOT NULL,
    typ_zdjecia ENUM('przed', 'po') NOT NULL,
    data_wykonania DATE NOT NULL,
    CONSTRAINT fk_zdjecia_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CONSTRAINT fk_zdjecia_zabieg
        FOREIGN KEY (id_zabiegu) REFERENCES zabiegi_i_operacje(id_zabiegu),
    CONSTRAINT fk_zdjecia_sala
        FOREIGN KEY (id_sali) REFERENCES sale_operacyjne(id_sali)
);

CREATE TABLE zgody_medyczne (
    id_zgody INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    typ_zgody ENUM('informowana', 'zgodna', 'niezgodna') NOT NULL,
    opis_zgody VARCHAR(200),
    data_podpisania DATE NOT NULL,
    status_podpisu ENUM('oczekuje', 'zatwierdzone', 'odrzucone') NOT NULL DEFAULT 'oczekuje',
    CONSTRAINT fk_zgody_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta)
);

CREATE TABLE plany_leczenia (
    id_planu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    cel VARCHAR(100) NOT NULL,
    opis VARCHAR(200),
    data_rozpoczecia DATE NOT NULL,
    data_zakonczenia DATE,
    szacowany_koszt DECIMAL(10, 2),
    status ENUM('planowany', 'w_trakcie', 'zakonczony') NOT NULL DEFAULT 'planowany',
    CONSTRAINT fk_plany_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta)
);

CREATE TABLE magazyn_implanty (
    id_implantu INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    producent VARCHAR(50) NOT NULL,
    numer_serii_lot VARCHAR(20) NOT NULL UNIQUE,
    rozmiar VARCHAR(10) NOT NULL,
    data_waznosci DATE NOT NULL,
    ilosc INT UNSIGNED NOT NULL DEFAULT 0
);

CREATE TABLE platnosci (
    id_platnosci INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT UNSIGNED NOT NULL,
    id_zabiegu INT UNSIGNED,
    kwota DECIMAL(10, 2) NOT NULL,
    forma_platnosci ENUM('gotowka', 'karta', 'przelew') NOT NULL,
    status_platnosci ENUM('oczekuje', 'zatwierdzone', 'odrzucone') NOT NULL DEFAULT 'oczekuje',
    data_platnosci DATE NOT NULL,
    nr_faktury VARCHAR(30) UNIQUE,
    CONSTRAINT fk_platnosci_pacjent
        FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CONSTRAINT fk_platnosci_zabieg
        FOREIGN KEY (id_zabiegu) REFERENCES zabiegi_i_operacje(id_zabiegu)
);
