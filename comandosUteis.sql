-- ** LIMIT **
-- Limitando a quantidade de linhas na query

-- 1. Selecione a tabela orders

-- 2. Selecione apenas as 100 primeiras linhas da tabela orders

SELECT * FROM orders LIMIT 100;

-- ** DISTINCT ** 
-- Selecionar os valores distintos de uma coluna

-- 1. Selecione a tabela customers

-- 2. Faça uma consulta que retorne as profissões (contact_title) distintas da tabela customers

SELECT DISTINCT contact_title FROM customers;

-- WHERE: Permite criar filtros nas consultas. Obs: O Postgres é case-sensitive.

-- 1. Selecione a tabela customers

-- a) Crie um filtro para que sejam mostrados apenas os clientes com contact_title = 'Owner'

SELECT * FROM customers
WHERE contact_title = 'Owner';

-- b) Crie um filtro para que sejam mostrados apenas os clientes do país France

SELECT * FROM customers
WHERE country = 'France';

-- ** WHERE + AND e OR **
-- Permite criar filtros com mais de uma coluna.
-- AND: O filtro será realizado se todas as condições são verdadeiras
-- OR: O filtro será realizado desde que PELO MENOS 1 condição seja verdadeira

-- 1. Selecione a tabela customers

-- a) Crie um filtro para que sejam mostrados apenas os clientes com contact_file = 'Owner' e do país France

SELECT * FROM customers
WHERE contact_title = 'Owner' AND country = 'France';

-- b) Crie um filtro para que sejam mostrados apenas os clientes do México ou France.

SELECT * FROM customers
WHERE country = 'Mexico' OR 'France';

-- ** WHERE + LIKE **
-- Permite criar filtros especiais de textos

-- 1. Selecione a tabela products

-- a) Quais produtos são medidos em boxes?

SELECT * FROM Products
WHERE quantity_per_unit LIKE '%boxes%';

-- b) Quais produtos são medidos em ml?

SELECT * FROM Products
WHERE quantity_per_unit LIKE '%ml%';

-- ** WHERE + BETWEEN **
-- Essa combinação é uma alternativa ao uso do AND para filtrar intervalos de números e datas.

-- 1. Selecione a tabela products

-- a) Quais produtos tem um unit_price entre 50 e 100 (utilize o método AND para resolver)

SELECT * FROM products
WHERE unit_price >= 50 AND unit_price <= 100;

-- b) Quais produtos tem um unit_price entre 50 e 100 (utilize o método BETWEEN para resolver)

SELECT * FROM products
WHERE unit_price BETWEEN 50 AND 100;

-- 2. Selecione a tabela orders

-- a) Quais pedidos foram feitos entre 01/01/1997 e 31/12/1997 (utilize o método AND para resolver)

SELECT * FROM orders
WHERE order_date >= '1997-01-01' AND order_date <= '1997-12-31';

-- b) Quais pedidos foram feitos entre 01/01/1997 e 31/12/1997 (utilize o método BETWEEN para resolver)

SELECT * FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';

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

-- ** Criando agrupamentos **

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

-- ** JOINS **

-- INTRODUÇÃO

/* Os Joins no SQL têm como objetivo relacionar as diferentes tabelas dos nossos bancos de dados. Com eles, conseguimos dar um passo
além das nossas análises, permitindo cruzar as informações das diferentes tabelas. */

-- Para criar Joins, o primeiro passo é descobrir qual coluna as tabelas que queremos relacionar têm em comum.
-- Será através dessas colunas que o SQL saberá a forma como ele deve cruzar os dados.

-- Exemplo: as tabelas 'products' e 'order-_details' possuem a coluna 'product_id' em comum.

-- É daí que vem os conceitos de CHAVE PRIMÁRIA e CHAVE ESTRANGEIRA.

-- SINTAXE

-- A sintaxe mais simples para relacionar 2 tabelas (que tenham a 'coluna 1' em comum) é a seguinte:

SELECT * FROM Tabela_A LEFT JOIN Tabela_B ON Tabela_A.Coluna1 = Tabela_B.Coluna1

-- Com a opção acima, estamos trazendo para uma mesma tabela TODAS as colunas das duas tabelas relacionadas, isso porque usamos o *.

-- Caso a gente queira escolher colunas específicas para verificar na consulta final, seguimos a seguinte estrutura.

SELECT 
    Tabela_A.Coluna1, 
    Tabela_A.Coluna2, 
    Tabela_A.Coluna3, 
    Tabela_B.Coluna4 
FROM 
    Tabela_A
LEFT JOIN Tabela_B
ON Tabela_A.Coluna1 = Tabela_B.Coluna1

-- Ou usando Alias (Opção 2)

SELECT ta.Coluna1, ta.Coluna2, ta.Coluna3, tb.Coluna4 FROM Tabela_A AS ta LEFT JOIN Tabela_B ta on ta.Coluna1 = tb.Coluna1

