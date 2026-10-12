
pacjenci
	  id_pacjenta INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
	  imie var(20),
	  nazwisko	var(20),
	  wiek	int,
	  email	var(60) unique,
	  numer_telefonu int,
	  adres_zamieszkania var(20),
    pesel int,
    kontakt_alarmowy int
	  
wywiad_medyczny
    id_wywiadu int auto_increment PRIMARY KEY ,
    id_pacjenta INT ,
    grupa_krwi var(10),
    alergie var(50),
    choroby_przewlekle var(50),
    leki (50),
    przebyte_operacje var(50),
    palenie_tytoniu (10),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta)

wizyty_i_konsultacje
    id_wizyty int auto_increment PRIMARY KEY,
    id_pacjenta INT,
    id_personelu INT,
    data_wizyty  date,
    typ_wizyty var(50),
    rozpoznanie var(50),
    zalecenia var(50),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_personelu) REFERENCES personel(id_personelu)

zabiegi_i_operacje
    id_zabiegu int auto_increment PRIMARY KEY,
    id_pacjenta int,
    id_sali int,
    nazwa_zabiegu var(50),
    data_operacji date,
    czas_trwania var(50),
    znieczulenie var(50),
    powiklania var(50),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_sali) REFERENCES sale_operacyjne(id_sali)

zdjecia_przed_po (opcjonalne)
    id_zdjecia int auto_increment PRIMARY KEY,
    id_pacjenta INT,
    id_zabiegu INT,
    id_sali INT,
    sciezka_pliku var(100),
    typ_zdjecia var(20) (przed/po),
    data_wykonania date,
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_zabiegu) REFERENCES zabiegi_i_operacje(id_zabiegu),
    FOREIGN KEY (id_sali) REFERENCES sale_operacyjne(id_sali)

zgody_medyczne
    id_zgody int auto_increment PRIMARY KEY,
    id_pacjenta INT,
    typ_zgody var(20),
    data_podpisania date,
    status_podpisu var(20),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta)

plany_leczenia
    id_planu int auto_increment PRIMARY KEY,
    id_pacjenta int,
    cel var(100),
    szacowany_koszt var(50),
    status var(30),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta)

personel
    id_personelu int auto_increment PRIMARY KEY,
    imie var(20),
    nazwisko var(20),
    rola var(20),
    specjalizacja var(50),
    numer_pwz int,
    telefon int,
    email var(50) UNIQUE

sale_operacyjne
    id_sali int auto_increment PRIMARY KEY,
    numer_sali int,
    status var(20)

magazyn_implanty
    id_implantu int auto_increment PRIMARY KEY,
    nazwa var(50),
    producent var(50),
    numer_serii_lot int,
    rozmiar var(20),
    data_waznosci int,
    ilostan int

platnosci
    id_platnosci int auto_increment PRIMARY KEY,
    id_pacjenta int FOREIGN KEY,
    id_zabiegu int FOREIGN KEY,
    kwota int,
    forma_platnosci var(50),
    status_platnosci var(50),
    data_platnosci date,
    nr_faktury int,
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    FOREIGN KEY (id_zabiegu) REFERENCES zabiegi_i_operacje(id_zabiegu)
