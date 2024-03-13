-- ## Subquery ##

-- O que é uma Subquery
-- Subqueries no SQL são queries dentro de queries. É a possibilidade de reaproveitar o resultado de uma querie (select) dentro de outra.

-- Exemplo: Quais produtos têm um preço acima da média?

select avg(unit_price) from products; -- 28.833896...

select * from Products
where unit_price >= (select avg(unit_price) from products);

-- Subquery: Cláusula WHERE
--Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média?

select * from order_details;

select avg(quantity) from order_details; -- 23.81299...

select * from order_details
where quantity >= (select avg(quantity) from order_details);

-- Subquery: Cláusula FROM
-- Exemplo: Qual é a média de clientes de acordo com o cargo?

select * from customers;

select contact_title, count(*) as total_clientes from customers group by contact_title;

select avg(total_clientes) from (select contact_title, count(*) as total_clientes from customers group by contact_title) tabela;

-- Subquery: Cláusula SELECT
-- Exemplo: Faça uma consulta à tabela products e adicione uma coluna que contenha a média geral de preço dos produtos

select * from products;

select *, (select avg(unit_price) from products) media_preco from products;

-- Subquery: Corrigindo a análise de pediddos acima da média
-- Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média?

select * from order_details;

select
	order_id,
	sum(quantity)
from order_details
group by order_id
having sum(quantity) >=(
	select
		avg(total_vendido)
	from (select 
		order_id, 
		sum(quantity) total_vendido 
	from order_details 
	group by order_id 
	order by order_id) tabela);
