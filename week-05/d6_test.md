
# Bölüm E - D6 Yapay Zekâ Destekli Test

## Testin Amacı

D6 sorgusunun, bütün filmler için en az bir bilet satın almış müşterileri doğru bulduğunu kontrol etmek.

## Test Verileri

Sistemde 3 film ve 3 müşteri bulunmaktadır.

| Müşteri | Bilet Aldığı Farklı Film Sayısı |
|---|---|
| Ali | 3 |
| Ayşe | 1 |
| Mehmet | 2 |

## Beklenen Sonuç

Yalnızca Ali Yilmaz listelenmelidir.

## Gerçek Sonuç

D6 sorgusu aşağıdaki sonucu döndürmüştür:

musteri_id: 1
ad: Ali
soyad: Yilmaz

## Bağımsız Kontrol

COUNT(DISTINCT s.film_id) kullanılarak müşterilerin bilet aldığı farklı film sayıları hesaplanmıştır.

Sonuçlar:
- Ali: 3
- Ayşe: 1
- Mehmet: 2

## Değerlendirme

Beklenen sonuç ile gerçek sonuç aynıdır.

D6 sorgusu mevcut test verileri üzerinde başarılı çalışmıştır.

Test senaryosunun hazırlanmasında ve SQL sorgularının kontrolünde yapay zekâ desteği kullanılmıştır.
