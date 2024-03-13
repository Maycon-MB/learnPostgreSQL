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