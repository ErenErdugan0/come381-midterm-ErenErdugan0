
-- Q1: Fiyatı 50 TL'den yüksek ürünleri pahalıdan ucuza sırala.
-- Ne işe yarar: Pahalı ürünleri görerek fiyatları karşılaştırmayı sağlar.

SELECT name, price
FROM product
WHERE price > 50
ORDER BY price DESC;

-- Q2: YBS bölümündeki müşterilerin adlarını alfabetik sırala.
-- Ne işe yarar: YBS bölümündeki müşterileri isimlerine göre düzenli listeler.

SELECT full_name
FROM customer
WHERE department = 'YBS'
ORDER BY full_name ASC;

-- Q3: Her siparişin numarasını, tarihini ve müşterinin adını listele.
-- Ne işe yarar: Siparişlerin hangi müşteriye ait olduğunu ve tarihlerini gösterir.

SELECT o.order_id, o.order_date, c.full_name
FROM orders o
INNER JOIN customer c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- Q4: Her sipariş kaleminin ürün adını ve adedini listele.
-- Ne işe yarar: Siparişlerde hangi üründen kaç adet alındığını gösterir.

SELECT p.name, oi.quantity
FROM order_item oi
INNER JOIN product p ON oi.product_id = p.product_id;

-- Q5: Her müşterinin kaç sipariş verdiğini müşteri adıyla listele.
-- Ne işe yarar: Müşterilerin toplam sipariş sayılarını gösterir.

SELECT c.full_name, COUNT(o.order_id) AS siparis_sayisi
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.full_name;

-- Q6: Her ürün kategorisinin ortalama fiyatını bul.
-- Ne işe yarar: Her kategorideki ürünlerin ortalama fiyatını gösterir.

SELECT category, ROUND(AVG(price), 2) AS ortalama_fiyat
FROM product
GROUP BY category
ORDER BY category;
