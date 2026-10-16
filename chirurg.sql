CREATE DATABASE IF NOT EXISTS operacje_chirurgiczne;
USE operacje_chirurgiczne;

CREATE TABLE pacjenci (
    id_pacjenta INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    wiek INT,
    email VARCHAR(60) UNIQUE,
    numer_telefonu VARCHAR(15),
    adres_zamieszkania VARCHAR(100),
    pesel CHAR(11) UNIQUE,
    kontakt_alarmowy VARCHAR(15)
);

CREATE TABLE personel (
    id_personelu INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    rola VARCHAR(20) NOT NULL,
    specjalizacja VARCHAR(50),
    numer_pwz VARCHAR(20) UNIQUE,
    telefon VARCHAR(15),
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE sale_operacyjne (
    id_sali INT AUTO_INCREMENT PRIMARY KEY,
    numer_sali INT NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'dostepna'
);

CREATE TABLE wywiad_medyczny (
    id_wywiadu INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL UNIQUE,
    grupa_krwi VARCHAR(3),
    alergie VARCHAR(100),
    choroby_przewlekle VARCHAR(100),
    leki VARCHAR(100),
    przebyte_operacje VARCHAR(100),
    palenie_tytoniu VARCHAR(20),
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta)
);

CREATE TABLE wizyty_i_konsultacje (
    id_wizyty INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    id_personelu INT NOT NULL,
    data_wizyty DATE NOT NULL,
    typ_wizyty VARCHAR(50) NOT NULL,
    rozpoznanie VARCHAR(100),
    zalecenia VARCHAR(100),
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_personelu)
        REFERENCES personel(id_personelu)
);

CREATE TABLE zabiegi_i_operacje (
    id_zabiegu INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    id_sali INT NOT NULL,
    nazwa_zabiegu VARCHAR(50) NOT NULL,
    data_operacji DATE NOT NULL,
    czas_trwania INT,
    znieczulenie VARCHAR(50),
    powiklania VARCHAR(100),
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_sali)
        REFERENCES sale_operacyjne(id_sali)
);

CREATE TABLE zdjecia_przed_po (
    id_zdjecia INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    id_zabiegu INT NOT NULL,
    id_sali INT,
    sciezka_pliku VARCHAR(100) NOT NULL,
    typ_zdjecia VARCHAR(10) NOT NULL,
    data_wykonania DATE NOT NULL,
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_zabiegu)
        REFERENCES zabiegi_i_operacje(id_zabiegu),
    FOREIGN KEY (id_sali)
        REFERENCES sale_operacyjne(id_sali)
);

CREATE TABLE zgody_medyczne (
    id_zgody INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    typ_zgody VARCHAR(30) NOT NULL,
    data_podpisania DATE,
    status_podpisu VARCHAR(20) NOT NULL DEFAULT 'oczekuje',
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta)
);

CREATE TABLE plany_leczenia (
    id_planu INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    cel VARCHAR(100) NOT NULL,
    szacowany_koszt DECIMAL(10,2),
    status VARCHAR(30) NOT NULL DEFAULT 'planowany',
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta)
);

CREATE TABLE magazyn_implanty (
    id_implantu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    producent VARCHAR(50) NOT NULL,
    numer_serii_lot VARCHAR(50) NOT NULL,
    rozmiar VARCHAR(20),
    data_waznosci DATE NOT NULL,
    ilostan INT NOT NULL DEFAULT 0,
    UNIQUE (producent, numer_serii_lot)
);

CREATE TABLE platnosci (
    id_platnosci INT AUTO_INCREMENT PRIMARY KEY,
    id_pacjenta INT NOT NULL,
    id_zabiegu INT,
    kwota DECIMAL(10,2) NOT NULL,
    forma_platnosci VARCHAR(30) NOT NULL,
    status_platnosci VARCHAR(30) NOT NULL DEFAULT 'oczekujaca',
    data_platnosci DATE,
    nr_faktury VARCHAR(30) UNIQUE,
    FOREIGN KEY (id_pacjenta)
        REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_zabiegu)
        REFERENCES zabiegi_i_operacje(id_zabiegu)
);
