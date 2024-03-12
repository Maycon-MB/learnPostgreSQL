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