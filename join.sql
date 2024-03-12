-- ## JOINS ##

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

SELECT ta.Coluna1, ta.Coluna2, ta.Coluna3, tb.Coluna4 FROM Tabela_A ta LEFT JOIN Tabela_B ta on ta.Coluna1 = tb.Coluna1

-- LEFT JOIN X INNER JOIN X RIGHT JOIN - FULL JOIN

-- Imagine que temos uma tabela de VENDAS onde foram vendidos os produtos de ID 1, 3 e 4
-- Imagine que temos uma tabela de PRODUTOS com produtos de ID 1, 2 e 3

SELECT * FROM vendas XXXX JOIN produtos ON vendas.idproduto = produtos.idproduto

-- LEFT JOIN --> Vai trazer as linhas da tabela de VENDAS (tabela da esquerda): vendas dos produtos de ID 1, 3 e 4
-- INNER JOIN --> Vai trazer as linhas de interseção entre a tabela de VENDAS e a de PRODUTOS: vendas dos produtos de ID 1 e 3
-- RIGHT JOIN --> Vai trazer as linhas da tabela de PRODUTOS (tabela da direita): vendas dos produtos de ID 1, 2 e 3
-- FULL JOIN --> Vai trazer todas as linhas de ambas as tabelas (PRODUTOS E VENDAS): vendas dos produtos de ID 1, 2, 3 e 4

-- Criando o primeiro JOIN

-- Faça um Join entre as tabelas 'products' e 'order_details'. Você deve retornar todas as colunas dessas duas tabelas.

SELECT * FROM products;

SELECT * FROM order_details

SELECT * FROM order_details INNER JOIN products on order_details.product_id = products.product_id;

-- 1. Avalie como as tabelas 'products' e 'categories' podem se relacionar. Qual coluna as duas tem em comum?

/* Como poderíamos criar uma consulta que retornasse product_id, product_name, category_id, 
unit_price (tabela products) e category_name (categories)? */

SELECT * FROM products;

SELECT * FROM categories;

SELECT 
	p.product_id, 
	p.product_name, 
	p.category_id, 
	p.unit_price, 
	c.category_name 
FROM products p INNER JOIN categories c ON p.category_id = c.category_id;

-- 2. Avalie como as tabelas 'customers' e 'orders' podem se relacionar. Qual coluna as duas tem em comum?

-- Como poderíamos criar uma consulta que retornasse order_id, customer_id, order_date (tabela orders) e contact_name (customers)
-- Será que existem clientes que não fizeram nenhuma compra?

-- Faça um JOIN entre as tabelas para descobrir o nome dos clientes que não fizeram nenhuma compra

SELECT * FROM customers;

SELECT * FROM orders;

SELECT
	o.order_id,
	o.customer_id,
	o.order_date,
	c.contact_name
FROM orders o RIGHT JOIN customers c ON o.customer_id = c.customer_id;

SELECT DISTINCT customer_id FROM orders; -- 89 ID's distintos (clientes que fizeram uma compra)
SELECT DISTINCT customer_id FROM customers; -- 91 ID's distintos (clientes cadastrados na base)

-- ## JOIN + Group By e Order By ##

/* Exemplo 1. Utilize os comandos JOIN, GROUP BY, ORDER BY para criar um agrupamento que retorne como resultado a quantidade_total
(SUM(quantity)) para cada product_name. Ordene o resultado, do maior para o menor, considerando a quantidade total. */

SELECT * FROM products;

SELECT * FROM order_details;

SELECT 
	p.product_name, 
	SUM(od.quantity) AS quantidade_total 
FROM order_details od
LEFT JOIN products p
ON od.product_id = p.product_id 
GROUP BY product_name 
ORDER BY quantidade_total DESC;

/* Exemplo 2. Ainda utilizando o código da análise anterior, faça o agrupamento de quantidade_total por product_name considerando apenas os produtos da classe Luxo 
(produtos com preço acima de R$80,00) */

SELECT 
	p.product_name, 
	SUM(od.quantity) AS quantidade_total 
FROM order_details od
LEFT JOIN products p
ON od.product_id = p.product_id 
GROUP BY product_name 
ORDER BY quantidade_total DESC;

/* Exemplo 3. Ainda utilizando o código do Exemplo 1, faça o agrupamento de quantidade_total por product_name considerando apenas os produtos que tiveram uma quantidade_total
maior ou igual a 1000. Obs: Estamos considerando a quantidade_total DEPOIS que o agrupamento foi feito. */

SELECT 
	p.product_name, 
	SUM(od.quantity) AS quantidade_total 
FROM order_details od
LEFT JOIN products p
ON od.product_id = p.product_id 
GROUP BY product_name
HAVING SUM(od.quantity) >= 1000
ORDER BY quantidade_total DESC;
