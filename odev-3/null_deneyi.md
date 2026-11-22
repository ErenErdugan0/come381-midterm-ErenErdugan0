
# Bölüm 2: NULL Deneyi

## Deney 1 

Sorgu:
`SELECT COUNT(*), COUNT(phone) FROM customer;`


**Tahminim:** COUNT(*) bütün müşterileri sayar diye düşünüyorum. COUNT(phone) ise telefon numarası boş olanları saymayacağı için daha düşük çıkabilir.

**Sonuç:** COUNT(*) 8, COUNT(phone) ise 5 çıktı.

**Yorum:** Tahminim doğru çıktı. Toplam 8 müşteri var ama 3 kişinin telefon numarası boş olduğu için COUNT(phone) onları saymadı.

## Deney 2

Sorgu:
`SELECT AVG(age), SUM(age) / COUNT(*) FROM customer;`


**Tahminim:** İki işlem de yaş ortalamasını hesaplıyor gibi görünüyor ama bazı müşterilerin yaşı boş olduğu için sonuçlar farklı çıkabilir.

**Sonuç:** AVG(age) yaklaşık 20.83, SUM(age) / COUNT(*) ise 15 çıktı.

**Yorum:** Tahminim doğru çıktı, iki sonuç farklı. AVG(age) yaşı boş olan müşterileri hesaba katmıyor ama COUNT(*) herkesi saydığı için ikinci sonuç daha düşük çıkıyor.
