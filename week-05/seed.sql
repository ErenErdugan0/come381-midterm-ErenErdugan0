
-- Test verileri: Filmler
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES
('Film A', 'Aksiyon', 130, '2026-01-10'),
('Film B', 'Komedi', 100, '2026-02-15'),
('Film C', 'Dram', 140, '2026-03-20');

-- Test verileri: Salon
INSERT INTO Salon (salon_adi, kapasite)
VALUES ('Test Salonu', 5);

-- Test verileri: Koltuklar
INSERT INTO Koltuk (salon_id, koltuk_no)
SELECT salon_id, 'A1'
FROM Salon
WHERE salon_adi = 'Test Salonu';

INSERT INTO Koltuk (salon_id, koltuk_no)
SELECT salon_id, 'A2'
FROM Salon
WHERE salon_adi = 'Test Salonu';

INSERT INTO Koltuk (salon_id, koltuk_no)
SELECT salon_id, 'A3'
FROM Salon
WHERE salon_adi = 'Test Salonu';

-- Test verileri: Müşteriler
INSERT INTO Musteri (ad, soyad, email, telefon)
VALUES
('Ali', 'Yilmaz', 'ali@test.com', '5551111111'),
('Ayse', 'Demir', 'ayse@test.com', '5552222222'),
('Mehmet', 'Yilmaz', 'mehmet@test.com', '5553333333');

-- Test verileri: Seanslar
INSERT INTO Seans
(film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
SELECT
    f.film_id,
    s.salon_id,
    '2026-12-01',
    '18:00',
    '2026-11-01'
FROM Film f
CROSS JOIN Salon s
WHERE f.film_adi = 'Film A'
  AND s.salon_adi = 'Test Salonu';

INSERT INTO Seans
(film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
SELECT
    f.film_id,
    s.salon_id,
    '2026-12-02',
    '18:00',
    '2026-11-01'
FROM Film f
CROSS JOIN Salon s
WHERE f.film_adi = 'Film B'
  AND s.salon_adi = 'Test Salonu';

INSERT INTO Seans
(film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
SELECT
    f.film_id,
    s.salon_id,
    '2026-12-03',
    '18:00',
    '2026-11-01'
FROM Film f
CROSS JOIN Salon s
WHERE f.film_adi = 'Film C'
  AND s.salon_adi = 'Test Salonu';

-- Ali: Üç filmin tamamına bilet alıyor
-- Ayse: Yalnızca Film A için bilet alıyor
-- Mehmet: Film A ve Film B için bilet alıyor

INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
SELECT m.musteri_id, s.seans_id, k.koltuk_id, 150.00
FROM Musteri m
JOIN Seans s ON TRUE
JOIN Film f ON s.film_id = f.film_id
JOIN Koltuk k ON k.salon_id = s.salon_id
WHERE m.email = 'ali@test.com'
  AND f.film_adi IN ('Film A', 'Film B', 'Film C')
  AND k.koltuk_no = 'A1';

INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
SELECT m.musteri_id, s.seans_id, k.koltuk_id, 150.00
FROM Musteri m
JOIN Seans s ON TRUE
JOIN Film f ON s.film_id = f.film_id
JOIN Koltuk k ON k.salon_id = s.salon_id
WHERE m.email = 'ayse@test.com'
  AND f.film_adi = 'Film A'
  AND k.koltuk_no = 'A2';

INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
SELECT m.musteri_id, s.seans_id, k.koltuk_id, 150.00
FROM Musteri m
JOIN Seans s ON TRUE
JOIN Film f ON s.film_id = f.film_id
JOIN Koltuk k ON k.salon_id = s.salon_id
WHERE m.email = 'mehmet@test.com'
  AND f.film_adi IN ('Film A', 'Film B')
  AND k.koltuk_no = 'A3';
