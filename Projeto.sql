drop schema projeto;
create schema projeto;
use projeto;

#Tabela Usuario - tipo 0 = aluno, 1 = professor
create table Usuario(
id int primary key AUTO_INCREMENT,
email varchar(100) not null,
senha varchar(100) not null,
tipo_usuario int
);
select * from  Usuario;

insert into Usuario(email,senha, tipo_usuario) values 
('gabriel@faex.com','gabriel123','1'),
('joao@faex.com','joao123','0'),
('ana@faex.com','ana123','0');



#Tabela Professores
CREATE TABLE Professor(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  especializacao VARCHAR(100),
  genero char(1),
  id_usuario int not null,
  foreign key (id_usuario) references Usuario(id)
);
select * from  Professor;

insert into Professor(nome,especializacao, genero,id_usuario) values 
('Gabriel','ADS','M','1');



#Tabela Disciplina
CREATE TABLE Disciplina(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50),
  id_professor int,
  foreign key (id_professor) references Professor(id)
);
select * from Disciplina;

insert into Disciplina(nome,id_professor) values 
('Banco de Dados','1');



#Tabela Aluno
CREATE TABLE Aluno(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  genero char(1),
  id_usuario int not null,
  id_disciplina int not null,
  foreign key (id_usuario) references Usuario(id),
  foreign key (id_disciplina) references Disciplina(id)
  );
select * from  Aluno;

insert into Aluno(nome,genero,id_usuario,id_disciplina) values 
('Ana','F','3','1'),
('João','M','2','1');


#Tabela Frequência - absenteismo 0 = presente, 1 = falta
CREATE TABLE Absenteismo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  absenteismo int not null,
  data datetime,
  id_aluno int not null,
  foreign key (id_aluno) references Aluno(id)
);
select * from Absenteismo;

insert into Absenteismo(id_aluno,absenteismo,data) values 
('1','0',now()),
('2','1',now());

#VIEW#

create view vw_absenteismo_alunos as 
select a.nome, 
	d.nome as disciplina, 
    ab.absenteismo, 
    ab.data as data_absenteismo, 
    u.email
from Aluno a
join Disciplina d on d.id = a.id_disciplina
join Absenteismo ab on a.id = ab.id_aluno
join Usuario u on u.id = a.id_usuario;

select * from vw_absenteismo_alunos;


#USUÁRIO#

CREATE USER 'adm'@'localhost' IDENTIFIED BY '1234';


#PERMISSÃO PARA O USUÁRIO#

GRANT SELECT  ON vw_absenteismo_alunos TO  'adm'@'localhost';