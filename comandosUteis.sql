-- ## LIMIT ##
-- Limitando a quantidade de linhas na query

-- 1. Selecione a tabela orders

-- 2. Selecione apenas as 100 primeiras linhas da tabela orders

SELECT * FROM orders LIMIT 100;

-- ## DISTINCT ##
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

-- ## WHERE + AND e OR ##
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

-- ## WHERE + LIKE ##
-- Permite criar filtros especiais de textos

-- 1. Selecione a tabela products

-- a) Quais produtos são medidos em boxes?

SELECT * FROM Products
WHERE quantity_per_unit LIKE '%boxes%';

-- b) Quais produtos são medidos em ml?

SELECT * FROM Products
WHERE quantity_per_unit LIKE '%ml%';

-- ## WHERE + BETWEEN ##
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

-- ## Funções de Agregação ##
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

-- ## Criando agrupamentos ##

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

-- ## VIEWs ## --

-- I. INTRODUÇÃO

-- Views são formas de armazenar o resultado de uma query em uma espécie de tabela, dentro dos bancos de dados.
-- É uma forma muito prática de consultar e reaproveitar os resultados de consultas criadas de forma rotineira.

-- A view mostra sempre resultados atualizados da tabela.

-- II. SINTAXE

-- Podemos criar (CREATE), atualizar (REPLACE), alterar (ALTER) e excluir (DROP) views.

-- Exemplo 1. Faça uma consulta à tabela 'products'. Você deve retornar apenas as colunas product_id, product_name e unit_price

CREATE OR REPLACE VIEW vwprodutos AS
SELECT product_id, product_name, unit_price FROM products;

SELECT * FROM vwprodutos;

-- Exemplo 2. Imagine que faltou incluir na sua view a coluna de units_in_stock. Altere a view criada anteriormente para fazer essa inclusão 

CREATE OR REPLACE VIEW vwprodutos AS
SELECT product_id, product_name, unit_price, units_in_stock FROM products;

-- Exemplo 3. Altere o nome da sua view de 'vwprodutos' para 'vw_prod'

ALTER VIEW vwprodutos RENAME TO vw_prod;

-- Exemplo 4. Exclua a view 'vwprodutos

DROP VIEW IF EXISTS vw_prod;

-- ## CRUD ##

-- Operações CRUD são operações que conseguimos fazer em um Banco de Dados. Essa sigla significa o seguinte:

-- CREATE: Permite criar Banco de Dados, Tabelas ou Exibições (Views)

-- READ: Permite ler os dados do banco de dados (SELECT). 

-- UPDATE: Permite atualizar os dados do banco de dados, tabelas ou views.

-- DELETE: Permite deletar os dados do banco de dados, tabelas ou views.

-- Criando e deletando um banco de dados

CREATE DATABASE Teste;
DROP DATABASE Teste;

-- Tipos de Dados para criação de tabelas

/* Uma tabela tem como objetivo armazenar informações dispostas em diferentes colunas. 
Cada uma das colunas dessa tabela será de um tipo específico */

CREATE TABLE tabela (Coluna1 TIPO1, coluna2 TIPO2);

-- Tipos de Dados no Postgres

-- Quando criamos uma nova tabela, precisamos especificar quais são as colunas que essa tabela deve conter.
-- Cada uma dessas colunas vai armazenar um tipo de dados específico.
-- Os principais tipos de dados são listados abaixo:

-- INT: 
-- Um número inteiro

-- NUMERIC(M, D):
-- M é o número total de dígitos e D é a quantidade de casas decimais permitidas

-- Exemplo: 1500,59 --> NUMERIC(6, 2)

-- VARCHAR(N):
/* Uma string de comprimento VARIÁVEL (pode conter letras, números e caracteres especiais). 
O parâmetro N especifica o comprimento máximo da coluna em caracteres */

-- DATE:
-- Uma data no formato: YYYY-MM-DD.

-- TIMESTAMP:
-- Uma combinação de data e hora. Formato: YYYY-MM-DD HH:MM:SS.

-- Sabendo os principais tipos de dados, a criação das tabelas segue a estrutura abaixo:

CREATE TABLE alunos(
    ID_Aluno INT,
    Nome_Aluno VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE cursos(
    ID_Curso INT,
    Nome_Curso VARCHAR(100),
    Preco_Curso NUMERIC(10, 2)
);

CREATE TABLE matriculas(
    ID_Matricula INT,
    ID_Aluno INT,
	ID_Curso INT,
	Data_Cadastro DATE
);

-- Restrições (CONSTRAINTS) para criação de tabelas

-- Restrições (Constraints) são regras aplicadas nas colunas de uma tabela

-- Exemplo 1: Podemos especificar que uma coluna não pode ter valores NULL;

-- Exemplo 2: Podemos especificar que uma coluna deverá ser uma chave primária ou chave estrangeira

-- São usadas para limitar os tipos de dados que são inseridos

-- # Principais:

-- # I. NOT NULL:
-- Faz com que uma coluna não aceite valores NULL. Ele identifica que nenhum valor foi definido
-- Obriga um campo a sempre possuir um valor
-- Dessa forma, uma coluna com restrição NOT NULL não aceita valores vazios.

    -- Nome_Cliente VARCHAR(100) NOT NULL

-- # II. PRIMARY KEY (Chave Primária)
-- Identifica de forma única cada registro em uma tabela do banco de dados.
-- Chaves primárias devem conter valores únicos.
-- Uma coluna de chave primária não pode conter valores NULL.
-- Cada tabela deve conter 1 e apenas 1 chave primária

-- # III. FOREIGN KEY (Chave Estrangeira)
-- Uma FOREIGN KEY em uma tabela é um campo que aponta para uma chave primária em outra tabela.

-- # CREATE TABLE

-- # 4. criando as tabelas no banco de dados

CREATE TABLE alunos(
    ID_Aluno INT,
    Nome_Aluno VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_Aluno)
);

CREATE TABLE cursos(
    ID_Curso INT,
    Nome_Curso VARCHAR(100) NOT NULL,
    Preco_Curso NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY(ID_Curso)
);

CREATE TABLE matriculas(
    ID_Matricula INT,
    ID_Aluno INT NOT NULL,
    ID_Curso INT NOT NULL,
    Data_Cadastro DATE NOT NULL,
    PRIMARY KEY(ID_Matricula),
    FOREIGN KEY(ID_Aluno) REFERENCES alunos(ID_Aluno),
    FOREIGN KEY(ID_Curso) REFERENCES cursos(ID_Curso)
)

-- # INSERT INTO

-- # Inserindo dados nas tabelas.

INSERT INTO alunos(ID_Aluno, Nome_Aluno, Email)
VALUES
    (1, 'Ana'   ,   'ana123@gmail.com'          ),
    (2, 'Bruno' ,   'bruno_vargas@outlook.com'  ),
    (3, 'Carla' ,   'carlinha1999@gmail.com'    ),
    (4, 'Diego' ,   'diicastroneves@gmail.com'  );

SELECT * FROM alunos;

INSERT INTO cursos(ID_Curso, Nome_Curso, Preco_Curso)
VALUES
    (1, 'Excel'     ,   100),
    (2, 'VBA'       ,   200),
    (3, 'Power BI'  ,   150)

SELECT * FROM cursos;

INSERT INTO matriculas(ID_Matricula, ID_Aluno, ID_Curso, Data_Cadastro)
VALUES
    (1, 1,  1,  '2021/03/11'    ),
    (2, 1,  2,  '201/06/21'     ),
    (3, 2,  3,  '2021/01/08'    ),
    (4, 3,  1,  '2021/04/03'    ),
    (5, 4,  1,  '2021/05/10'    ),
    (6, 4,  3,  '2021/05/10'    );

SELECT * FROM matriculas;

-- # UPDATE

-- # Atualizando dados de uma tabela com o UPDATE
SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT * FROM matriculas;

UPDATE cursos
SET Preco_Curso = 300
WHERE ID_CURSO = 1;

-- # DELETE

-- # Deletando registros de uma tabela

SELECT * FROM matriculas;
SELECT * FROM alunos;
SELECT * FROM cursos;

DELETE FROM matriculas
WHERE ID_Matricula = 6;

-- # TRUNCATE TABLE

-- # Deletando todos os registros da tabela de uma vez, mas a tabela continua existindo.

SELECT * FROM matriculas;

TRUNCATE TABLE matriculas;

-- # DROP TABLE

-- # Deletando tabelas do banco de dados

-- Atenção: Cuidado ao dropar uma tabela que tenha restrições de PRIMARY KEY!!!

DROP TABLE alunos CASCADE;
DROP TABLE cursos;
DROP TABLE matriculas;

-- Funções de Número e Texto
-- Aula 1 - Funções de Número

-- Ceiling, Floor, Round, Trunc 

select 
	avg(unit_price), 
	ceiling(AVG(unit_price)), 
	floor(avg(unit_price)), 
	round(cast(avg(unit_price) as numeric), 2),
	trunc(cast(avg(unit_price) as numeric), 2)
from products;

-- Aula 2 - Funções de Texto

-- Upper, Lower, Length, Initcap

select * from employees;

select
    first_name,
	upper(first_name),
	lower(first_name),
	length(first_name), 
	initcap('sql teste abc')
from employees; 

-- Replace

select * from customers;

select
	contact_name,
	contact_title,
	replace(contact_title, 'Owner', 'CEO')
from customers;

-- Substring e Strpos

select
    'ABC-9999';
    left('ABC-9999', 3),
    right('ABC-9999', 4);

select
    'ABC-9999',
    substring('ABC-9999', 1, strpos('ABC-9999', '-') -1),
    substring('ABC-9999', strpos('ABC-9999', '-') +1, 100),
    strpos('ABC-9999', '-');

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

-- ## Variáveis e Blocos Anônimos ##

-- Variáveis, Datatypes e Blocos Anônimos

-- Variáveis são pedaços de memória onde armazenamos alguma informação. Uma variável está sempre associada a um tipo de dado em particular.

-- Os tipos mais comuns de dados são:

-- 1. Numéricos: int e decimal
-- 2. Textos: varchar(n)
-- 3. Datas: date

-- Bloco Anônimo (Introdução)

-- No PostgreSQL é possível criar os chamados Blocos Anônimos, blocos de códigos que são a base para Functions e Procedures.
-- Abaixo, segue a estrutura de um bloco anônimo

/*

<<  label   >>
declare
    declaracao;
begin
    corpo do código;
    select;
    update;
    etc...

end label;

*/

-- Cada bloco possui duas sessões: declaração e corpo.
-- A sessão de declaração é opcional e é onde declaramos todas as variáveis usadas no corpo do código.
-- A sessão do corpo é obrigatória e é onde criamos os nossos códigos.
-- Em ambas as sessões é obrigatório o uso do ponto e vírgula ao final de cada instrução.

-- Exemplo de um bloco anônimo:

do $$
declare
        nome varchar(100);
        salario decimal;
        data_contratacao date;
begin
    nome := 'André';
    salario := 3500;
    data_contratacao := '25-10-2018';
    raise notice 'O funcionário % foi contratado em % e recebe um salário de %.', nome, data_contratacao, salario;
end $$;

-- Blocos Anônimos - Exemplos

-- Exemplo 1: Criando uma calculadora simples de valor vendido. Utilize as variáveis 'quantidade', 'preco', 'valor_vendido' e 'vendedor' para isso

do $$
declare
        quantidade int := 50;
        preco decimal := 100;
        valor_vendido int;
        vendedor varchar(100) := 'Nome Teste';
begin
    valor_vendido := quantidade * preco;

    raise notice 'O vendedor % vendeu um total de %.', vendedor, valor_vendido;
end $$;

-- Exemplo 2: Quantos produtos têm o preço acima da média de preços?

do $$
declare
    media_preco decimal;
    qtd_produtos_acima_media int;
begin
    media_preco = (select avg(unit_price) from products);
    qtd_produtos_acima_media = (select count(*) from products where unit_price >= media_preco);

    raise notice 'A quantidade de produtos com o preço acima da média é: % produtos.', qtd_produtos_acima_media;
end $$;

-- ## User-Defined Functions

-- ** Criando uma Function
/* Além das funções de números, textos, datas, agregação, presentes no SQL, também é possível criar funções personalizadas que realizam
algum tipo de cálculo. A essas funções damos o nome de User_Defined Functions. */

-- A sintaxe para criar uma função é a seguinte:

/*

create or replace function nome_funcao(parametros)
    returns tipo_dado
    language plpgsql
as
$$ 
declare
    declaracao de variaveis
begin
    codigos
end $$;

*/

/* Exemplo: Crie uma Function que analisa o estoque dos produtos. 
Essa Function deve retornar o total de produtos que possuem um total de estoque entre um estoque mínimo e um estoque máximo, 
ambos definidos pelo usuário da Function */

select * from products;

create or replace function analise_estoque(estoque_min int, estoque_max int)
returns int
language plpgsql
as
$$

declare
	contagem_estoque int;

begin
	contagem_estoque = (select count(*) from products where units_in_stock between estoque_min and estoque_max);
	return contagem_estoque;

end $$;

select count(*) - analise_estoque(10, 50) from products;

-- ** Formas de chamar uma Function e como excluir uma Function

-- Existem 3 formas de chamar uma função:

-- I. Usando a notação por posição

select analise_estoque(20, 50);

-- II. Usando a notação por nome do parâmetro

select analise_estoque(estoque_min := 20, estoque_max := 50);

-- III. Usando a notação mista

select analise_estoque(20, estoque_max := 50);

-- Excluindo uma Function

drop function if exists analise_estoque;

-- ** Functions que retornam uma tabela

-- É possível criar funções que retornam tabelas.

-- A sintaxe para criar uma função deste tipo é a seguinte:

/* 

create or replace function nome_funcao(parametros)
    returns table (lista_de_colunas)
    language plpgsql
as
$$
declare
    declaracao de variaveis
begin
    codigos

    return query

end $$;

*/

-- Exemplo: Crie uma Function que retorna uma tabela contendo a lista de clientes que têm o contact_title = 'Owner'.
-- A tabela retornada pela function deve conter apenas as colunas de id, nome, telefone e cargo dos clientes.

select * from customers;

create or replace function busca_clientes(title varchar)
returns table
		(
			id customers.customer_id%type,
			nome customers.contact_name%type,
			telefone customers.phone%type,
			cargo customers.contact_title%type
		)
language plpgsql
as $$
begin

	return query
		select
			customer_id,
			contact_name,
			phone,
			contact_title
		from customers
		where contact_title = title;

end $$;

select * from busca_clientes('Owner');

drop function if exists busca_clientes;

-- ## Transactions e Procedures ##

-- ** O que é uma Transação?

-- Uma transação em um banco de dados é uma unidade de trabalho que consiste em uma ou mais operações.

/* Um exemplo clássico de uma transação é uma transferência bancária de uma conta para outra. Se o remetente transfere um valor
de X reais a um destinatário, este destinatário deverá receber exatamente essa quantia de X reais, nem mais nem menos. */

create table contas(
    id int,
    nome varchar(100),
    saldo decimal
);

select * from contas;

insert into contas(id, nome, saldo)
values(1, 'Ana', 5000);

begin transaction;
insert into contas(id, nome, saldo)
values(2, 'Bruno', 10000);

commit;

-- Para fazer com que as mudanças fiquem visíveis em outras sessões, é necessário utilizar o comando COMMIT.

-- Já para desfazer uma transação, usamos o comando ROLLBACK.

-- ** O que é e como criar uma Procedure

/* Até aqui foi visto como criar blocos anônimos e functions. Porém, functions e blocos anônimos não são capazes de executar transações.
Ou seja, dentro de uma function, não podemos iniciar uma transação, ou dar commit/rollback nela. */

-- A sintaxe para criação de uma Procedure é a seguinte:

/*
create or replace procedure nome_procedure(parametros)
language plpgsql
as $$
declare
    declaracao de variaveis
begin
    corpo do código
end $$;

Para excluir, a sintaxe é:

drop procedure nome_procedure;

*/

-- Exemplo: Crie uma Procedure que cadastra um novo cliente na tabela Contas.

create or replace procedure cadastra_cliente(novo_id int, novo_cliente varchar(100), saldo_inicial decimal)
language plpgsql
as $$
begin
	insert into contas(id, nome, saldo) values
	(novo_id, novo_cliente, saldo_inicial);
	
	commit;
	
end $$;

call cadastra_cliente(3, 'Caio', 300);

select * from contas;

-- Exemplo 2: Crie uma Procedure que controle transferências bancárias entre duas contas.

select * from contas;

create or replace procedure transferencia(remetente int, destinatario int, valor decimal)
language plpgsql
as $$
begin

	-- subtrair o montante transferido pelo remetente
	update contas
	set saldo = saldo - valor
	where id = remetente;
	
	-- adicionar o montante transferido para o destinatário
	update contas
	set saldo = saldo + valor
	where id = destinatario;
	
	commit;
    
end $$;

call transferencia(1, 2, 500);

select * from contas;




