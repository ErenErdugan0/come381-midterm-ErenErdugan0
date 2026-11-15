
-- BÖLÜM B: CONSTRAINT İHLAL TESTLERİ

-- Hata mesajlarında SQLSTATE kodlarını göster.
\set VERBOSITY verbose

-- Testlerin her çalıştırmada aynı sonucu vermesi için tabloları temizle.
TRUNCATE TABLE Film, Salon, Koltuk, Seans, Musteri, Bilet
RESTART IDENTITY CASCADE;

-- Testler için geçerli örnek kayıtlar oluştur.
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Ornek Film', 'Aksiyon', 120, '2026-01-01');

INSERT INTO Salon (salon_adi, kapasite)
VALUES ('Salon 1', 50);

INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (1, 'A1');

INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (1, 'A2');

INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
VALUES (1, 1, '2026-11-20', '18:00', '2026-11-01');

INSERT INTO Musteri (ad, soyad, email)
VALUES ('Ali', 'Yilmaz', 'ali@example.com');

INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 1, 1, 150.00);


-- T01 | NOT NULL film_adi | Beklenen: 23502
-- Film adı boş bırakılamaz.
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES (NULL, 'Aksiyon', 120, '2026-01-01');


-- T02 | uq_musteri_email | Beklenen: 23505
-- Aynı e-posta adresi iki müşteriye verilemez.
INSERT INTO Musteri (ad, soyad, email)
VALUES ('Ayse', 'Demir', 'ali@example.com');


-- T03 | chk_salon_kapasite | Beklenen: 23514
-- Salon kapasitesi negatif olamaz.
INSERT INTO Salon (salon_adi, kapasite)
VALUES ('Salon 2', -10);


-- T04 | chk_salon_kapasite | Beklenen: OK
-- Sınır testi: kapasite 1 olabilir.
INSERT INTO Salon (salon_adi, kapasite)
VALUES ('Salon 3', 1);


-- T05 | chk_film_tur | Beklenen: 23514
-- Tanımlanmamış film türü kabul edilmez.
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Test Film', 'Belgesel', 90, '2026-01-01');


-- T06 | chk_seans_satis_tarihi | Beklenen: 23514
-- Bilet satışı seans tarihinden sonra başlayamaz.
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
VALUES (1, 1, '2026-11-20', '20:00', '2026-11-25');

-- T07 | uq_koltuk_salon_no | Beklenen: 23505
-- Aynı salonda aynı koltuk numarası tekrar edemez.
INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (1, 'A1');


-- T08 | uq_bilet_seans_koltuk | Beklenen: 23505
-- Aynı seanstaki aynı koltuk ikinci kez satılamaz.
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 1, 1, 200.00);


-- T09 | chk_film_sure | Beklenen: 23514
-- Film süresi 500 dakikayı geçemez.
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Uzun Film', 'Dram', 501, '2026-01-01');


-- T10 | chk_film_sure | Beklenen: OK
-- Sınır testi: film süresi tam 500 dakika olabilir.
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Sinir Film', 'Dram', 500, '2026-01-01');


-- T11 | chk_seans_satis_tarihi | Beklenen: OK
-- NULL testi: satis_baslangic boş olabilir.
INSERT INTO Seans
(film_id, salon_id, seans_tarihi, seans_saati, satis_baslangic)
VALUES (1, 1, '2026-11-21', '18:00', NULL);


-- T12 | fk_koltuk_salon | Beklenen: 23503
-- Var olmayan salona koltuk eklenemez.
INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (9999, 'B1');


-- T13 | fk_seans_film | Beklenen: 23503
-- Var olmayan film için seans oluşturulamaz.
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (9999, 1, '2026-11-22', '20:00');


-- T14 | fk_seans_salon | Beklenen: 23503
-- Var olmayan salonda seans oluşturulamaz.
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (1, 9999, '2026-11-22', '20:00');


-- T15 | fk_bilet_musteri | Beklenen: 23503
-- Var olmayan müşteriye bilet satılamaz.
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (9999, 1, 2, 150.00);


-- T16 | fk_bilet_seans | Beklenen: 23503
-- Var olmayan seansa bilet satılamaz.
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 9999, 1, 150.00);


-- T17 | fk_bilet_koltuk | Beklenen: 23503
-- Var olmayan koltuğa bilet satılamaz.
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 1, 9999, 150.00);


-- T18 | fk_bilet_musteri | Beklenen: 23001
-- Bileti olan müşteri silinemez.
DELETE FROM Musteri
WHERE musteri_id = 1;

-- NOT NULL IHLAL TESTLERI
-- Beklenen SQLSTATE: 23502

-- T19 | Film.tur | Beklenen: 23502
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Test 19', NULL, 120, '2026-01-01');

-- T20 | Film.sure | Beklenen: 23502
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Test 20', 'Dram', NULL, '2026-01-01');

-- T21 | Film.yayin_tarihi | Beklenen: 23502
INSERT INTO Film (film_adi, tur, sure, yayin_tarihi)
VALUES ('Test 21', 'Dram', 120, NULL);

-- T22 | Salon.salon_adi | Beklenen: 23502
INSERT INTO Salon (salon_adi, kapasite)
VALUES (NULL, 50);

-- T23 | Salon.kapasite | Beklenen: 23502
INSERT INTO Salon (salon_adi, kapasite)
VALUES ('Test Salonu', NULL);

-- T24 | Koltuk.salon_id | Beklenen: 23502
INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (NULL, 'B1');

-- T25 | Koltuk.koltuk_no | Beklenen: 23502
INSERT INTO Koltuk (salon_id, koltuk_no)
VALUES (1, NULL);

-- T26 | Seans.film_id | Beklenen: 23502
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (NULL, 1, '2026-11-22', '20:00');

-- T27 | Seans.salon_id | Beklenen: 23502
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (1, NULL, '2026-11-22', '20:00');

-- T28 | Seans.seans_tarihi | Beklenen: 23502
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (1, 1, NULL, '20:00');

-- T29 | Seans.seans_saati | Beklenen: 23502
INSERT INTO Seans (film_id, salon_id, seans_tarihi, seans_saati)
VALUES (1, 1, '2026-11-22', NULL);

-- T30 | Musteri.ad | Beklenen: 23502
INSERT INTO Musteri (ad, soyad, email)
VALUES (NULL, 'Demir', 'test30@example.com');

-- T31 | Musteri.soyad | Beklenen: 23502
INSERT INTO Musteri (ad, soyad, email)
VALUES ('Ayse', NULL, 'test31@example.com');

-- T32 | Musteri.email | Beklenen: 23502
INSERT INTO Musteri (ad, soyad, email)
VALUES ('Ayse', 'Demir', NULL);

-- T33 | Bilet.musteri_id | Beklenen: 23502
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (NULL, 1, 1, 150);

-- T34 | Bilet.seans_id | Beklenen: 23502
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, NULL, 1, 150);

-- T35 | Bilet.koltuk_id | Beklenen: 23502
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 1, NULL, 150);

-- T36 | Bilet.fiyat | Beklenen: 23502
INSERT INTO Bilet (musteri_id, seans_id, koltuk_id, fiyat)
VALUES (1, 1, 1, NULL);
