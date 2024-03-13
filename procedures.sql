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






