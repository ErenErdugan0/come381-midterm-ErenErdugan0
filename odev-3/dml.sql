\set VERBOSITY verbose

-- Komut 1: Sıcak içeceklerin fiyatlarını 5 TL artırma

BEGIN;

-- Değişiklikten önceki fiyatlar
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek';

-- Fiyatları 5 TL artır
UPDATE product
SET price = price + 5
WHERE category = 'Sıcak İçecek';

-- Değişiklikten sonraki fiyatlar
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek';

-- Komut 2: Olmayan bir ürünü siparişe eklemeyi deniyoruz
INSERT INTO order_item (order_id, product_id, quantity)
VALUES (1, 999, 1);

-- Yapılan değişiklikleri geri al
ROLLBACK;

-- Fiyatların eski haline döndüğünü kontrol et
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek';
