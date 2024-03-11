-- GROUP BY

-- 1. Faça um agrupamento para descobrir a quantidade total de clientes por country.

SELECT * FROM customers;

SELECT country, COUNT(*) FROM customers	GROUP BY country ORDER BY COUNT(*) DESC;

-- 2. Faça um agrupamento para descobrir a quantidade total de clientes por title.

SELECT * FROM customers;

SELECT contact_title as title, COUNT(*) FROM customers GROUP BY title ORDER BY COUNT(*) DESC;

-- 3. Faça um agrupamento para descobrir a soma total de estoque por supplier_id.

SELECT * FROM products;

SELECT supplier_id, SUM(units_in_stock) FROM products GROUP BY supplier_id;

-- 4. Faça um agrupamento para descobrir a média de unit_price por supplier_id.

SELECT supplier_id, AVG(unit_price) AS "Média" FROM products GROUP BY supplier_id;

-- GROUP BY + WHERE vs GROUP BY + HAVING

/* 1. Faça um agrupamento para descobrir a quantidade total de clientes por country. 
O seu agrupamento deve considerar apenas os clientes de contact_title = 'Owner' */

SELECT * FROM customers;

SELECT country, COUNT(*) FROM customers WHERE contact_title = 'Owner' GROUP BY country ORDER BY COUNT(*) DESC;

/* 2. Faça um agrupamento para descobrir a quantidade total de clientes por country. 
A query resultante deve conter apenas os países que têm mais de 10 clientes. */

SELECT * FROM customers;

SELECT country, COUNT(*) FROM customers GROUP BY country HAVING COUNT(*) >= 10 ORDER BY COUNT(*) DESC;