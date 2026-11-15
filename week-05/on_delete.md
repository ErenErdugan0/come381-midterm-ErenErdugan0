
# Bölüm C: Silme Politikaları

Sinema bilet satış sisteminde CASCADE ve RESTRICT olmak üzere iki farklı silme politikası kullandım.

| Foreign Key | Ebeveyn → Çocuk | Seçim | Neden | Diğer seçenek neden olmadı? |
|---|---|---|---|---|
| fk_koltuk_salon | Salon → Koltuk | CASCADE | Salon silinirse koltukları da silinir. | RESTRICT salonun silinmesini engellerdi. |
| fk_seans_film | Film → Seans | RESTRICT | Seansı olan film yanlışlıkla silinmemeli. | CASCADE bütün seansları silebilirdi. |
| fk_seans_salon | Salon → Seans | RESTRICT | Planlanmış seansları korumak istedim. | CASCADE seansları da silerdi. |
| fk_bilet_musteri | Musteri → Bilet | RESTRICT | Satılmış biletlerin müşteri bilgisi korunmalı. | CASCADE bilet kayıtlarını silebilirdi. |
| fk_bilet_seans | Seans → Bilet | CASCADE | Seans silinirse biletleri de silinir. | RESTRICT seansın silinmesini engellerdi. |
| fk_bilet_koltuk | Koltuk → Bilet | CASCADE | Koltuk silinirse ona ait biletler de silinir. | RESTRICT koltuğun silinmesini engellerdi. |

## RESTRICT ve NO ACTION farkı

RESTRICT, ilişkili kayıt varsa silme işlemini hemen engeller.

NO ACTION ise kontrolü normalde SQL komutunun sonunda yapar. Foreign key DEFERRABLE olarak tanımlanmışsa kontrol işlem sonuna kadar ertelenebilir.

## CASCADE Testi

CASCADE politikasının gerçekten çalıştığını göstermek için önce ve sonra ilgili tablolardaki kayıt sayılarını karşılaştıracağım.

Test komutlarını ve PostgreSQL sonuçlarını aşağıya ekleyeceğim.

### CASCADE Test Sonuçları

Test için "Cascade Test Salonu" adında bir salon oluşturdum ve bu salona C1 ile C2 koltuklarını ekledim.

**Silmeden önce:**

```sql
SELECT
    (SELECT COUNT(*) FROM Salon
     WHERE salon_adi = 'Cascade Test Salonu') AS salon_sayisi,
    (SELECT COUNT(*) FROM Koltuk
     WHERE salon_id IN (
         SELECT salon_id FROM Salon
         WHERE salon_adi = 'Cascade Test Salonu'
     )) AS koltuk_sayisi;
```

Sonuç:
- Salon sayısı: 1
- Koltuk sayısı: 2

**Silme işlemi:**

```sql
DELETE FROM Salon
WHERE salon_adi = 'Cascade Test Salonu';
```

Sonuç: DELETE 1

**Silmeden sonra:**

```sql
SELECT
    (SELECT COUNT(*) FROM Salon
     WHERE salon_adi = 'Cascade Test Salonu') AS salon_sayisi,
    (SELECT COUNT(*) FROM Koltuk
     WHERE koltuk_no IN ('C1', 'C2')) AS koltuk_sayisi;
```

Sonuç:
- Salon sayısı: 0
- Koltuk sayısı: 0

Bu testte salon silindiğinde ona bağlı iki koltuğun da otomatik silindiğini gördüm. Böylece ON DELETE CASCADE kuralının çalıştığını doğruladım.
