
# Bölüm D: İlişkisel Cebir ve SQL

## D1 - Seçim (Selection)

**Soru:** Türü Aksiyon olan filmlerin film adı ve süresini listeleyiniz.

**İlişkisel Cebir:**

π_{film_adi, sure}(σ_{tur = 'Aksiyon'}(Film))

**SQL karşılığı:**

```sql
SELECT film_adi, sure
FROM Film
WHERE tur = 'Aksiyon';
```

**Açıklama:** Önce Film tablosundan türü Aksiyon olan kayıtları seçtim. Ardından sadece film adı ve süre sütunlarını aldım.

## D2 - Birleştirme (JOIN)

**Soru:** Her seansın hangi filme ait olduğunu, film adı, seans tarihi ve seans saatiyle birlikte listeleyiniz.

**İlişkisel Cebir:**

π_{film_adi, seans_tarihi, seans_saati}
(Film ⋈_{Film.film_id = Seans.film_id} Seans)

**SQL karşılığı:**

```sql
SELECT f.film_adi, s.seans_tarihi, s.seans_saati
FROM Film f
JOIN Seans s ON f.film_id = s.film_id;
```

**Açıklama:** Film ve Seans tablolarını film_id üzerinden birleştirdim. Böylece her seansın film adını, tarihini ve saatini birlikte listeleyebiliyorum.

## D3 - Kesişim (INTERSECTION)

**Soru:** Hem Aksiyon türünde olan hem de süresi 120 dakikadan uzun olan filmlerin adlarını listeleyiniz.

**İlişkisel Cebir:**

π_{film_adi}(σ_{tur = 'Aksiyon'}(Film))
∩
π_{film_adi}(σ_{sure > 120}(Film))

**SQL karşılığı:**

```sql
SELECT film_adi
FROM Film
WHERE tur = 'Aksiyon'

INTERSECT

SELECT film_adi
FROM Film
WHERE sure > 120;
```

**Açıklama:** İlk sorguda Aksiyon filmlerini, ikinci sorguda 120 dakikadan uzun filmleri seçtim. INTERSECT kullanarak iki koşulu da sağlayan filmlerin adlarını buldum.

## D4 - Fark (DIFFERENCE)

**Soru:** Hiç bilet satın almamış müşterilerin ad ve soyadlarını listeleyiniz.

**İlişkisel Cebir:**

π_{musteri_id, ad, soyad}(Musteri)
−
π_{musteri_id, ad, soyad}
(Musteri ⋈_{Musteri.musteri_id = Bilet.musteri_id} Bilet)

**SQL karşılığı (EXCEPT):**

```sql
SELECT musteri_id, ad, soyad
FROM Musteri

EXCEPT

SELECT m.musteri_id, m.ad, m.soyad
FROM Musteri m
JOIN Bilet b ON m.musteri_id = b.musteri_id;
```

**SQL karşılığı (NOT EXISTS):**

```sql
SELECT m.musteri_id, m.ad, m.soyad
FROM Musteri m
WHERE NOT EXISTS (
    SELECT 1
    FROM Bilet b
    WHERE b.musteri_id = m.musteri_id
);
```

**Açıklama:** EXCEPT yöntemi bütün müşterilerden bilet satın alanları çıkarır. NOT EXISTS ise müşterinin herhangi bir bilet kaydı olup olmadığını kontrol eder.

Her iki sorgunun da aynı müşterileri döndürmesi gerekir.

**DISTINCT notu:** EXCEPT zaten tekrarları kaldırır. NOT EXISTS sorgusunda ise musteri_id birincil anahtar olduğu için sonuçta tekrar oluşmaz; DISTINCT gerekli değildir.

## D5 - Yeniden Adlandırma (RENAME) ve SELF JOIN

**Soru:** Aynı soyadına sahip farklı müşteri çiftlerinin adlarını ve ortak soyadlarını listeleyiniz.

**İlişkisel Cebir:**

ρ_{M1}(Musteri) ⋈_{M1.soyad = M2.soyad ∧ M1.musteri_id < M2.musteri_id} ρ_{M2}(Musteri)

Sonuçta yalnızca M1.ad, M2.ad ve M1.soyad sütunları gösterilir.

**SQL karşılığı:**

```sql
SELECT
    m1.ad AS musteri1,
    m2.ad AS musteri2,
    m1.soyad AS ortak_soyad
FROM Musteri m1
JOIN Musteri m2
    ON m1.soyad = m2.soyad
   AND m1.musteri_id < m2.musteri_id;
```

**Açıklama:** Musteri tablosuna M1 ve M2 adlarını vererek tabloyu kendisiyle birleştirdim. Aynı soyadına sahip farklı müşterileri buldum.

musteri_id karşılaştırması sayesinde bir müşteri kendisiyle eşleşmez ve aynı çift iki kez listelenmez.

**DISTINCT notu:** Her müşteri çiftini yalnızca bir kez eşleştirdiğimiz için DISTINCT gerekli değildir.

## D6 - Bölme (DIVISION)

**Soru:** Sistemdeki bütün filmler için en az bir bilet satın almış müşterileri listeleyiniz.

**İlişkisel Cebir:**

R = π_{musteri_id, film_id}
(Bilet ⋈_{Bilet.seans_id = Seans.seans_id} Seans)

S = π_{film_id}(Film)

Sonuç = π_{ad, soyad}
(Musteri ⋈ (R ÷ S))

**SQL karşılığı (NOT EXISTS):**

```sql
SELECT m.musteri_id, m.ad, m.soyad
FROM Musteri m
WHERE NOT EXISTS (
    SELECT 1
    FROM Film f
    WHERE NOT EXISTS (
        SELECT 1
        FROM Bilet b
        JOIN Seans s ON b.seans_id = s.seans_id
        WHERE b.musteri_id = m.musteri_id
          AND s.film_id = f.film_id
    )
);
```

**Açıklama:** Bölme işlemi, bir müşterinin bütün filmler için bilet alıp almadığını kontrol eder.

İçteki NOT EXISTS müşterinin belirli bir film için bilet almadığını kontrol eder.

Dıştaki NOT EXISTS ise müşterinin bilet almadığı hiçbir film bulunmamasını sağlar.

Bu nedenle yalnızca bütün filmler için en az bir bilet satın almış müşteriler listelenir.

**Önemli:** Film tablosu boşsa sorgu bütün müşterileri döndürür. Test verilerinde en az bir film bulunmalıdır.
