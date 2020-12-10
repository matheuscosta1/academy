create database clinica;

create table if not exists pessoa(
    codigo int AUTO_INCREMENT not null,
    nome varchar(50),
    email varchar(40) UNIQUE,
    telefone varchar(30),
    cep char(10),
    logradouro varchar(50),
    bairro varchar(50),
    cidade varchar(50),
    estado char(2),
    primary key (codigo)
) ENGINE=InnoDB;

create table if not exists funcionario(
    data_contrato datetime,
    salario decimal(10,2),
    senha_hash varchar(255),
    codigo int AUTO_INCREMENT not null,
    funcionario_codigo_fk int not null,
    primary key(codigo),
    foreign key(funcionario_codigo_fk) REFERENCES pessoa(codigo) ON DELETE CASCADE
) ENGINE=InnoDB;

create table if not exists medico(
    especialidade varchar(30),
    crm varchar(30),
    codigo int AUTO_INCREMENT not null,
    medico_codigo_fk int not null,
    primary key(codigo),
    foreign key(medico_codigo_fk) REFERENCES funcionario(codigo) ON DELETE CASCADE
) ENGINE=InnoDB;

create table paciente(
    peso double,
    altura double,
    tipo_sanguineo char(3),
    codigo int AUTO_INCREMENT,
    paciente_codigo_fk int not null,
    primary key(codigo),
    foreign key(paciente_codigo_fk) REFERENCES pessoa(codigo) ON DELETE CASCADE
) ENGINE=InnoDB; 

create table if not exists agenda(
	data_agendamento date,
    horario int(2),
    nome varchar(50),
    email varchar(50),
   	telefone varchar(30),
    codigo int AUTO_INCREMENT not null,
    codigo_medico_fk int not null,
    primary key(codigo),
    foreign key(codigo_medico_fk) REFERENCES medico(codigo) ON DELETE CASCADE
) ENGINE=InnoDB;

create table if not exists endereco(
	cep char(10),
    logradouro varchar(50),
	bairro varchar(50),
	cidade varchar(50),
	estado char(2)
) ENGINE=InnoDB;