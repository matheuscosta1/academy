BEGIN TRANSACTION;

DROP SCHEMA scm CASCADE;
CREATE SCHEMA scm;
SET search_path TO scm;

CREATE TABLE equipe (
    idequ SERIAL PRIMARY KEY,
	nomeequ char(30) unique,
	paisequ varchar(20),
	titulosequ int
);

CREATE TABLE pessoa (
    idpes SERIAL PRIMARY KEY,
	nomepes varchar(50),
	tipopes CHAR(2) CHECK (tipopes IN ('P','M')),
	idequ INT not null, 
	constraint equipe_pessoa_fk foreign key (idequ) references equipe (idequ)
);

CREATE TABLE piloto (
    idpes INT PRIMARY KEY,
	titulospes int,
	pontuacao int,
	constraint piloto_pessoa_fk foreign key (idpes) references pessoa (idpes)
);

CREATE TABLE mecanico (
    idpes INT PRIMARY KEY,
	especialidademec varchar(20),
	constraint mecanico_pessoa_fk foreign key (idpes) references pessoa (idpes)
);

CREATE TABLE circuito (
    idcir SERIAL PRIMARY KEY,
	nomecir char(30) unique,
	paiscir varchar(20)
);

CREATE TABLE corrida (
    idcor SERIAL PRIMARY KEY,
	datacor date,
	idcir int not null,
	categoria varchar(30),
	nvoltas int,
	unique (datacor, idcir, categoria),
	constraint corrida_circuito_fk foreign key (idcir) references circuito (idcir)
);

CREATE TABLE participacao (
    idpes INT not null,
    idcor INT not null,
    tempo time,
	primary key (idpes, idcor),
	constraint participacao_piloto_fk foreign key (idpes) references piloto (idpes),
	constraint participacao_corrida_fk foreign key (idcor) references corrida (idcor)
);

END transaction;
