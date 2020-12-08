create table if not exists pessoa(
    codigo int AUTO_INCREMENT not null,
    nome varchar(50),
    email varchar(40),
    telefone varchar(20),
    cep varchar(11),
    logradouro varchar(100),
    bairro varchar(100),
    cidade varchar(40),
    estado varchar(40),
    primary key (codigo)
);

create table if not exists funcionario(
    data_contrato datetime,
    salario double,
    senha_hash varchar(255),
    codigo int AUTO_INCREMENT not null,
    funcionario_codigo_fk int not null,
    primary key(codigo),
    foreign key(funcionario_codigo_fk) REFERENCES pessoa(codigo)
);

create table if not exists medico(
    especialidade varchar(11),
    crm double,
    codigo int AUTO_INCREMENT not null,
    medico_codigo_fk int not null,
    primary key(codigo),
    foreign key(medico_codigo_fk) REFERENCES funcionario(codigo)
);

create table paciente(
    peso double,
    altura double,
    tipo_sanguineo varchar(20),
    codigo int AUTO_INCREMENT,
    paciente_codigo_fk int not null,
    primary key(codigo),
    foreign key(paciente_codigo_fk) REFERENCES pessoa(codigo)
);

create table if not exists agenda(
	data_agendamento datetime,
    horario time,
    nome varchar(40),
    email varchar(40),
   	telefone varchar(20),
    codigo int AUTO_INCREMENT not null,
    codigo_medico_fk int not null,
    primary key(codigo),
    foreign key(codigo_medico_fk) REFERENCES medico(codigo)
);

create table if not exists endereco(
	cep varchar(11),
    logradouro varchar(40),
	bairro varchar(40),
	cidade varchar(40),
	estado varchar(40)
);

