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
