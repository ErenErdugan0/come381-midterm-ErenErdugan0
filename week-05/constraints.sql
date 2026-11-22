
-- BÖLÜM A: CONSTRAINT KURALLARI

-- Film adı, türü, süresi ve yayın tarihi boş bırakılamaz.
ALTER TABLE Film
    ALTER COLUMN film_adi SET NOT NULL,
    ALTER COLUMN tur SET NOT NULL,
    ALTER COLUMN sure SET NOT NULL,
    ALTER COLUMN yayin_tarihi SET NOT NULL;

-- Salon adı ve kapasitesi boş bırakılamaz.
ALTER TABLE Salon
    ALTER COLUMN salon_adi SET NOT NULL,
    ALTER COLUMN kapasite SET NOT NULL;

-- Her koltuğun bir salonu ve koltuk numarası olmalıdır.
ALTER TABLE Koltuk
    ALTER COLUMN salon_id SET NOT NULL,
    ALTER COLUMN koltuk_no SET NOT NULL;

-- Her seansın filmi, salonu, tarihi ve saati olmalıdır.
ALTER TABLE Seans
    ALTER COLUMN film_id SET NOT NULL,
    ALTER COLUMN salon_id SET NOT NULL,
    ALTER COLUMN seans_tarihi SET NOT NULL,
    ALTER COLUMN seans_saati SET NOT NULL;

-- Müşterinin adı, soyadı ve e-posta adresi boş bırakılamaz.
ALTER TABLE Musteri
    ALTER COLUMN ad SET NOT NULL,
    ALTER COLUMN soyad SET NOT NULL,
    ALTER COLUMN email SET NOT NULL;

-- Her bilet bir müşteriye, seansa ve koltuğa ait olmalı ve fiyatı bulunmalıdır.
ALTER TABLE Bilet
    ALTER COLUMN musteri_id SET NOT NULL,
    ALTER COLUMN seans_id SET NOT NULL,
    ALTER COLUMN koltuk_id SET NOT NULL,
    ALTER COLUMN fiyat SET NOT NULL;

-- Bir e-posta adresi yalnızca bir müşteriye ait olabilir.
ALTER TABLE Musteri
    ADD CONSTRAINT uq_musteri_email
    UNIQUE (email);

-- Aynı salonda aynı koltuk numarası iki kez bulunamaz.
ALTER TABLE Koltuk
    ADD CONSTRAINT uq_koltuk_salon_no
    UNIQUE (salon_id, koltuk_no);

-- Bir seansta aynı koltuk için iki farklı bilet satılamaz.
ALTER TABLE Bilet
    ADD CONSTRAINT uq_bilet_seans_koltuk
    UNIQUE (seans_id, koltuk_id);

-- Salon kapasitesi sıfırdan büyük olmalıdır.
ALTER TABLE Salon
    ADD CONSTRAINT chk_salon_kapasite
    CHECK (kapasite > 0);

-- Film süresi 1 ile 500 dakika arasında olmalıdır.
ALTER TABLE Film
    ADD CONSTRAINT chk_film_sure
    CHECK (sure BETWEEN 1 AND 500);

-- Film türü yalnızca belirtilen türlerden biri olabilir.
ALTER TABLE Film
    ADD CONSTRAINT chk_film_tur
    CHECK (tur IN ('Aksiyon', 'Komedi', 'Dram', 'Korku', 'Bilim Kurgu'));

-- Seans tarihi, filmin yayın tarihinden önce olamaz.
-- Bu kural farklı tablolardaki sütunları karşılaştırdığı için
-- CHECK ile doğrudan yazılamaz.
-- Bunun yerine aynı tablodaki iki sütunu karşılaştıracağız.
ALTER TABLE Seans
    ADD COLUMN satis_baslangic DATE;

-- Bilet satış başlangıç tarihi, seans tarihinden sonra olamaz.
ALTER TABLE Seans
    ADD CONSTRAINT chk_seans_satis_tarihi
    CHECK (satis_baslangic <= seans_tarihi);

-- Her koltuk var olan bir salona ait olmalıdır.
-- Salon silinirse ona bağlı koltuklar da silinir.
ALTER TABLE Koltuk
    DROP CONSTRAINT koltuk_salon_id_fkey,
    ADD CONSTRAINT fk_koltuk_salon
    FOREIGN KEY (salon_id) REFERENCES Salon(salon_id)
    ON DELETE CASCADE;

-- Her seans var olan bir filme ait olmalıdır.
-- Seansı olan bir film silinemez.
ALTER TABLE Seans
    DROP CONSTRAINT seans_film_id_fkey,
    ADD CONSTRAINT fk_seans_film
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
    ON DELETE RESTRICT;

-- Her seans var olan bir salonda yapılmalıdır.
-- Seansı bulunan bir salon silinemez.
ALTER TABLE Seans
    DROP CONSTRAINT seans_salon_id_fkey,
    ADD CONSTRAINT fk_seans_salon
    FOREIGN KEY (salon_id) REFERENCES Salon(salon_id)
    ON DELETE RESTRICT;

-- Her bilet var olan bir müşteriye ait olmalıdır.
-- Bileti bulunan bir müşteri silinemez.
ALTER TABLE Bilet
    DROP CONSTRAINT bilet_musteri_id_fkey,
    ADD CONSTRAINT fk_bilet_musteri
    FOREIGN KEY (musteri_id) REFERENCES Musteri(musteri_id)
    ON DELETE RESTRICT;

-- Her bilet var olan bir seansa ait olmalıdır.
-- Seans silinirse o seansın biletleri de silinir.
ALTER TABLE Bilet
    DROP CONSTRAINT bilet_seans_id_fkey,
    ADD CONSTRAINT fk_bilet_seans
    FOREIGN KEY (seans_id) REFERENCES Seans(seans_id)
    ON DELETE CASCADE;

-- Her bilet var olan bir koltuğa ait olmalıdır.
-- Koltuk silinirse o koltuğa ait biletler de silinir.
ALTER TABLE Bilet
    DROP CONSTRAINT bilet_koltuk_id_fkey,
    ADD CONSTRAINT fk_bilet_koltuk
    FOREIGN KEY (koltuk_id) REFERENCES Koltuk(koltuk_id)
    ON DELETE CASCADE;

-- Bilet fiyatı negatif olamaz.
ALTER TABLE Bilet
    ADD CONSTRAINT chk_bilet_fiyat
    CHECK (fiyat >= 0);
