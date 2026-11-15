
-- D1: Aksiyon filmlerinin adları ve süreleri
SELECT film_adi, sure
FROM Film
WHERE tur = 'Aksiyon';

-- D2: Her seansın film adı, tarihi ve saati
SELECT
    f.film_adi,
    s.seans_tarihi,
    s.seans_saati
FROM Film f
JOIN Seans s
    ON f.film_id = s.film_id;

-- D3: Hem Aksiyon türünde hem de 120 dakikadan uzun filmler
SELECT film_adi
FROM Film
WHERE tur = 'Aksiyon'

INTERSECT

SELECT film_adi
FROM Film
WHERE sure > 120;

-- D4: Hiç bilet satın almamış müşteriler
-- Yöntem 1: EXCEPT

SELECT musteri_id, ad, soyad
FROM Musteri

EXCEPT

SELECT m.musteri_id, m.ad, m.soyad
FROM Musteri m
JOIN Bilet b
    ON m.musteri_id = b.musteri_id;


-- Yöntem 2: NOT EXISTS

SELECT m.musteri_id, m.ad, m.soyad
FROM Musteri m
WHERE NOT EXISTS (
    SELECT 1
    FROM Bilet b
    WHERE b.musteri_id = m.musteri_id
);

-- D5: Aynı soyadına sahip farklı müşteri çiftleri

SELECT
    m1.ad AS musteri1,
    m2.ad AS musteri2,
    m1.soyad AS ortak_soyad
FROM Musteri m1
JOIN Musteri m2
    ON m1.soyad = m2.soyad
   AND m1.musteri_id < m2.musteri_id;

-- D6: Bütün filmler için en az bir bilet satın almış müşteriler

SELECT
    m.musteri_id,
    m.ad,
    m.soyad
FROM Musteri m
WHERE NOT EXISTS (
    SELECT 1
    FROM Film f
    WHERE NOT EXISTS (
        SELECT 1
        FROM Bilet b
        JOIN Seans s
            ON b.seans_id = s.seans_id
        WHERE b.musteri_id = m.musteri_id
          AND s.film_id = f.film_id
    )
);
