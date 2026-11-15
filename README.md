# Sinema Bilet Satış Sistemi

Bu projede bir sinemanın bilet satışlarını ve seanslarını takip edebilmek için bir veritabanı tasarladım.

Sistemde filmler, salonlar, koltuklar, seanslar, müşteriler ve biletler olmak üzere toplam 6 tablo bulunuyor.

Bir müşteri birden fazla seansa bilet alabileceği ve aynı seansa birden fazla müşteri katılabileceği için bu ilişkiyi Bilet tablosu üzerinden kurdum.

Tabloların birbirleriyle bağlantılı çalışabilmesi için Primary Key ve Foreign Key kullandım.

Son olarak SQL kodlarını PostgreSQL üzerinde çalıştırıp tabloların sorunsuz oluşturulduğunu kontrol ettim.