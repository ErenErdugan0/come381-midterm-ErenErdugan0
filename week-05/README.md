# COME381 - Ödev 2
## Sinema Bilet Satış Sistemi

Bu ödevde ilk ödevde hazırladığım sinema bilet satış sisteminin veritabanını geliştirdim. Tablolara bazı kısıtlamalar ekledim ve bu kısıtlamaların düzgün çalışıp çalışmadığını test ettim.

`constraints.sql` dosyasında NOT NULL, UNIQUE, CHECK ve FOREIGN KEY kısıtlarını kullandım. `violations.sql` dosyasında ise bu kurallara uymayan veriler eklemeyi deneyerek oluşan hataları kontrol ettim.

Ayrıca tablolar arasında silme işlemlerinin nasıl çalışacağını belirledim ve CASCADE kullanımını test ettim. Sonrasında ilişkisel cebir sorularını çözüp SQL karşılıklarını yazdım.

Sorguları denemek için `seed.sql` dosyasında örnek film, müşteri, seans ve bilet verileri oluşturdum. D6 sorgusunu da test ettim. Test sonucunda bütün filmler için bilet alan müşterinin Ali olduğu doğru şekilde bulundu.

Ödevi hazırlarken PostgreSQL, VS Code ve GitHub kullandım. Bazı SQL sorgularını hazırlarken ve hataları düzeltirken yapay zekâdan da yardım aldım.