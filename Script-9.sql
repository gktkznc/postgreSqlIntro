-- 1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın. 
SELECT product_name, quantity_per_unit FROM products p ;

-- 2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
SELECT product_name, product_id FROM products p WHERE discontinued = 0;

-- 3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
SELECT product_name, product_id FROM products p WHERE discontinued = 1;

-- 4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id, product_name, unit_price FROM products p WHERE unit_price < 20;

-- 5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id, product_name, unit_price FROM products p WHERE unit_price BETWEEN 16 AND 25;

-- 6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
SELECT product_name, units_on_order, units_in_stock FROM products p WHERE units_in_stock < units_on_order ;

-- 7. İsmi `a` ile başlayan ürünleri listeleyeniz.
SELECT * FROM products p WHERE product_name LIKE 'A%';

-- 8. İsmi `i` ile biten ürünleri listeleyeniz.
SELECT * FROM products p WHERE product_name LIKE '%i';

-- 9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
SELECT product_name , unit_price, sum(unit_price + (unit_price * 0.18)) AS "unit_price_kdv" FROM products p GROUP BY unit_price, product_name ;

-- 10. Fiyatı 30 dan büyük kaç ürün var?
SELECT count(*) AS "Ürün Adedi" FROM products p WHERE unit_price > 30; 

-- 11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT lower(product_name) AS "product_name", unit_price  FROM products p ORDER BY unit_price ASC;

-- 12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
SELECT concat(last_name , ' ' ,first_name) AS "full_name" FROM employees e ;

-- 13. Region alanı NULL olan kaç tedarikçim var?
SELECT count(*) AS "Region alanı NULL olan tedarikçiler" FROM suppliers WHERE region IS NULL ;

-- 14. a.Null olmayanlar?
SELECT count(*) AS "Region alanı NULL olmayan tedarikçiler" FROM suppliers s WHERE region IS NOT NULL;

-- 15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
SELECT concat( upper(product_name), ' ', 'TR' )  FROM products;

-- 16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT concat('TR', ' ', product_name) FROM products p WHERE unit_price < 20; 

-- 17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products p WHERE unit_price = (SELECT max(unit_price) FROM products p2);

-- 18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 10; 

-- 19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products WHERE unit_price > (SELECT avg(unit_price) FROM products);

-- 20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT sum (units_in_stock * unit_price) AS "total_revenue" FROM products WHERE units_in_stock > 0;

-- 21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
SELECT count(*) AS "Count of Available and Discontinued Products" FROM products p WHERE discontinued = 1 AND units_in_stock > 0;

-- 22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
SELECT product_name, categories.category_name FROM products 
	INNER JOIN categories ON products.category_id = categories.category_id;

-- 23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT categories.category_name, avg(unit_price) AS "Average Price" FROM products 
	INNER JOIN categories ON products.category_id = categories.category_id GROUP BY categories.category_name;

-- 24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
SELECT product_name, unit_price, categories.category_name FROM products 
	INNER JOIN categories ON products.category_id = categories.category_id 
		WHERE unit_price = (SELECT max(unit_price) FROM products);
	
	-- 25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
SELECT products.product_name, categories.category_name, suppliers.company_name, sum(quantity) AS "Total Quantity" FROM order_details 
	INNER JOIN products ON products.product_id = order_details.product_id 
		INNER JOIN categories ON categories.category_id = products.category_id 
			INNER JOIN suppliers ON suppliers.supplier_id = products.supplier_id
				GROUP BY products.product_name , categories.category_name , suppliers.company_name 
					ORDER BY sum(quantity) DESC LIMIT 1;
			



			



 