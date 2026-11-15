
-- FILM TABLOSU
CREATE TABLE Film (
    film_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    film_adi VARCHAR(150),
    tur VARCHAR(50),
    sure INTEGER,
    yayin_tarihi DATE
);

-- SALON TABLOSU
CREATE TABLE Salon (
    salon_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    salon_adi VARCHAR(100),
    kapasite INTEGER
);

-- KOLTUK TABLOSU
CREATE TABLE Koltuk (
    koltuk_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    salon_id INTEGER REFERENCES Salon(salon_id),
    koltuk_no VARCHAR(10)
);

-- SEANS TABLOSU
CREATE TABLE Seans (
    seans_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    film_id INTEGER REFERENCES Film(film_id),
    salon_id INTEGER REFERENCES Salon(salon_id),
    seans_tarihi DATE,
    seans_saati TIME
);

-- MUSTERI TABLOSU
CREATE TABLE Musteri (
    musteri_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    email VARCHAR(100),
    telefon VARCHAR(20)
);

-- BILET TABLOSU
CREATE TABLE Bilet (
    bilet_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    musteri_id INTEGER REFERENCES Musteri(musteri_id),
    seans_id INTEGER REFERENCES Seans(seans_id),
    koltuk_id INTEGER REFERENCES Koltuk(koltuk_id),
    fiyat NUMERIC(8,2)
);
