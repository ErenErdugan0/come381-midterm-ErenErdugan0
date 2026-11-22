
# Sinema Bilet Sistemi - ER Diyagramı

```mermaid
erDiagram
    Film ||--o{ Seans : gosterilir
    Salon ||--o{ Seans : duzenlenir
    Salon ||--o{ Koltuk : icerir
    Musteri ||--o{ Bilet : satin_alir
    Seans ||--o{ Bilet : kapsar
    Koltuk ||--o{ Bilet : atanir

    Film {
        int film_id PK
        varchar film_adi
        varchar tur
        int sure
        date yayin_tarihi
    }

    Salon {
        int salon_id PK
        varchar salon_adi
        int kapasite
    }

    Koltuk {
        int koltuk_id PK
        int salon_id FK
        varchar koltuk_no
    }

    Seans {
        int seans_id PK
        int film_id FK
        int salon_id FK
        date seans_tarihi
        time seans_saati
    }

    Musteri {
        int musteri_id PK
        varchar ad
        varchar soyad
        varchar email
        varchar telefon
    }

    Bilet {
        int bilet_id PK
        int musteri_id FK
        int seans_id FK
        int koltuk_id FK
        numeric fiyat
    }
```
