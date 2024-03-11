-- ** Funções de Agregação **
-- COUNT, SUM, AVG, MIN, MAX

-- 1. COUNT

-- a) Descubra a quantidade de clientes 

SELECT COUNT(*) FROM customers;

-- b) Descubra a quantidade de produtos

SELECT COUNT(*) FROM products;

-- 2. Sum

-- a) Qual é a soma total de estoque de produtos?

SELECT SUM(units_in_stock) FROM products;

-- b) Qual é a soma total de vendas de produtos? (lembre-se que existem 2 tabelas de orders)

SELECT SUM(quantity) FROM order_details;

-- 3. AVG, MIN, MAX

-- a) Descubra a média, mínimo e máximo de unit_price da tabela products

SELECT AVG(unit_price) AS "Media_Preco",
MIN(unit_price) AS "Minimo_Preco", 
MAX(unit_price) AS "Maximo_Preco" FROM products;