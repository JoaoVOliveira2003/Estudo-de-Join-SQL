/*vc tem duas tabelas uma chamada Clientes (tem id_cliente/nome) e a outra pedidos(tem id_cliente/nome) 
e eu quero como volta o nome da pessoa que pediu tal produto tipo

saia dessa maneira:

nome  |   produto
------------------
Ana   |  Tela
Carlos|  PC
José  |  mouse
*/
select nome,produto
from clientes cl
inner join pedidos on clientes.id_cliente = pedidos.id_cliente;

/*  Eu quero o nome e produto do cara que fez o Pedido 101*/
select nome,produto
from clientes cl
inner join pedidos on clientes.id_cliente = pedidos.id_cliente 
where id_pedido = 101;

CREATE TABLE aulas.Pessoa (
CPF int null PRIMARY KEY,
Nome varchar(50),
idade int,
cidade varchar(50),
estado varchar(5)
);

CREATE TABLE aulas.Cachorro (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    raca VARCHAR(100),
    cor VARCHAR(50),
    idade int,
    Dono int,
    FOREIGN KEY (Dono) REFERENCES Pessoa(CPF)
);

INSERT INTO aulas.Cachorro (id, nome, raca, cor, idade, Dono) 
VALUES
(1, 'Caramelo', 'Vira Lata', 'Amarela', 4, 777777),
(2, 'Cruela', 'Dálmata', 'Branca', 5, 777777),
(3, 'Bob', 'Vira Lata', 'Preta', 1, 221133),
(4, 'Luna', 'Vira Lata', 'Amarela', 4, 777777),
(5, 'Alfavor', 'Pug', 'Preta', 2, 123456);

INSERT INTO aulas.Cachorro (id, nome, raca, cor, idade, Dono) 
VALUES
(6, 'Meredith', 'Vira Lata', 'pintada', 4, 888444);

INSERT INTO aulas.Cachorro (id, nome, raca, cor, idade, Dono) 
VALUES
(7, 'Pitu', 'Vira Lata', 'preto', 4, 888444);

INSERT INTO aulas.Pessoa (CPF,Nome,idade,cidade,estado) 
VALUES
(123456,'Carine',25,'Natal','RN'),
(111111,'joão',30,'Barracao','PR'),
(777777,'Rafaela',32,'Dionisio','SC'),
(999333,'Carlos',15,'Porto seguro','BA'),
(221133,'mARINA',9,'Porto Alegre','RS');

INSERT INTO aulas.Pessoa (CPF,Nome,idade,cidade,estado) 
VALUES
(888444,'João',21,'Colombo','PR');

/*Selecionar todos os dados*/

select *
from aulas.Cachorro c
join aulas.Pessoa p on p.CPF=c.Dono;

/*A) SELECIONE TODOS OS CACOS QUE ESTÃO NO ESTADO DE RN*/

select *
from aulas.Cachorro c
join aulas.Pessoa p on p.CPF=c.Dono
where estado='RN';

/*B) Selecione o nome dos cachorros e o nome dos seus donos*/

select c.nome as NomeCachorros,p.nome as NomeDonos
from aulas.Cachorro c
join aulas.Pessoa p on p.CPF=c.Dono;

/*C)Selecione nome das pessoas que tem Vira Lata*/

select p.nome as Nome_Pessoas,c.raca as Nome_raca
from aulas.Cachorro c
join aulas.Pessoa p on p.CPF=c.Dono
where raca='Vira Lata';


/*D)Selecione o nome de todos os cachorros que começam com P ou mora no Paraná*/

select c.nome as Nome_Cachorro, p.estado as Estado, p.cidade as Cidade
from aulas.Cachorro c
join aulas.Pessoa p on p.CPF=c.Dono
where p.estado='PR' or c.nome LIKE 'p%' ;


/*Exemplo de um JOIN mais longo*/
SELECT pt.nome_tipo AS tipo_produto, 
	   el.estoque AS disponibilidade_estoque, 
	   dt.nome_produto, 
	   rp.descricao_recurso AS recurso, 
     sa.tamanho        
FROM  DETALHES_PRODUTO dt
JOIN ESTOQUE_LOJA el ON dt.id_produto = el.id_produto 
JOIN TIPOS_PRODUTO pt ON dt.id_tipo = pt.id_tipo
JOIN RECURSOS_PRODUTO rp ON dt.id_produto = rp.id_produto
JOIN  DISPONIBILIDADE_TAMANHO sa ON dt.id_produto = sa.id_produto
WHERE dt.id_tipo = 1  AND el.id_loja = 41  AND sa.id_tamanho = 2;  

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Principios de tipo de junção de join
 
inner join - coloca o dado que esta em duas tabelas ao mesmo tempo 

left  join - pega os dados que estão meio entre as tabelas e tudo que esta na da esquerda 
rigth join - pega os dados que estão meio entre as tabelas e tudo que esta na da direita

A ordem importa para declarar/mostrar quem é quem

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE aulas.professoras (
professora_id int null PRIMARY KEY,
nome_professor varchar(50)
);

CREATE TABLE aulas.cursos (
cursos_id int null PRIMARY KEY,
nome_cursos varchar(50),
professora_id int null ,
FOREIGN KEY (professora_id) REFERENCES professoras(professora_id)
);

CREATE TABLE aulas.estudantes (
estudantes_id int null PRIMARY KEY,
nome varchar(50),
cursos_id int null,
FOREIGN KEY (cursos_id) REFERENCES aulas.cursos(cursos_id)
);

insert into aulas.professoras values (1,"Carlos"),(2,"Maria"),(3,"Ana"),(4,"Roberto");

insert into aulas.cursos values (101,"Matematica",1),(102,"Historia",2),(103,"Biologia",3),(104,"Fisica",null);

insert into aulas.estudantes values (1,"Matematica",1),(102,"Historia",2),
(103,"Biologia",3),(104,"Fisica",null);

insert into aulas.estudantes values 
( 1, " joao" , 101),
( 2, " maria" , 102),
( 3, " ana" , 101),
( 4, " pedro" , null),
( 5, " lucas" , 103);

/*1 - Obter uma lista de todos os estudantes e os cursos em que estão matriculados.*/
/*
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;
*/
select *
from aulas.estudantes e
left join aulas.cursos c
on e.cursos_id=c.cursos_id;

/*2 - Listar todos os estudantes, incluindo aqueles que não estão matriculados em nenhum
curso, e mostrar o nome do curso (se houver).*/

select *
from aulas.estudantes e
left join aulas.cursos c
on e.cursos_id=c.cursos_id;

/*3 - Listar todos os cursos, incluindo aqueles que não têm estudantes matriculados, e
mostrar os nomes dos estudantes (se houver).*/

SELECT c.cursos_id, c.nome_cursos, e.estudantes_id, e.nome
FROM aulas.cursos c
LEFT JOIN aulas.estudantes e ON c.cursos_id = e.cursos_id;

/*4 - Listar todos os estudantes e os cursos, onde o nome do curso contém a letra 'o'.*/

SELECT e.estudantes_id, e.nome AS nome_estudante, c.cursos_id, c.nome_cursos
FROM aulas.estudantes e
INNER JOIN aulas.cursos c ON e.cursos_id = c.cursos_id
WHERE c.nome_cursos LIKE '%o%';


/*5 - Listar a quantidade de alunos que cada curso possui, caso o curso não tenha estudante,
deverá aparecer o valor zero.*/

SELECT c.cursos_id, c.nome_cursos, COUNT(e.estudantes_id) AS quantidade_alunos
FROM aulas.cursos c
LEFT JOIN aulas.estudantes e ON c.cursos_id = e.cursos_id
GROUP BY c.cursos_id, c.nome_cursos;


