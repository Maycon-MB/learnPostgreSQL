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