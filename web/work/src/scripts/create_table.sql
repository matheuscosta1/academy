create table pessoa(
    codigo varchar(255) not null,
    nome varchar(50),
    email varchar(40),
    telefone varchar(20),
    cep varchar(11),
    logradouro varchar(100),
    bairro varchar(100),
    cidade varchar(40),
    estado varchar(40),
    primary key(codigo)
);

create table funcionario(
    data_contrato date(11),
    salario double,
    senha_hash varchar(40),
    codigo varchar(255) not null,
    funcionario_codigo_fk varchar(255) not null,
    primary key(codigo),
    foreign key(funcionario_codigo_fk) REFERENCES pessoa(codigo)
);

create table medico(
    especialidade varchar(11),
    crm double,
    codigo varchar(255) not null,
    medico_codigo_fk varchar(255) not null,
    primary key(codigo),
    foreign key(medico_codigo_fk) REFERENCES funcionario(codigo)
);

create table paciente(
    peso double,
    altura double,
    tipo_sanguineo varchar(20),
    codigo varchar(255),
    paciente_codigo_fk varchar(255) not null,
    primary key(codigo),
    foreign key(paciente_codigo_fk) REFERENCES pessoa(codigo)
);

create table agenda(
	data_agendamento date,
    horario time,
    nome varchar(40),
    email varchar(40),
   	telefone varchar(20),
    codigo varchar(255) not null,
    codigo_medico_fk varchar(255) not null,
    primary key(codigo),
    foreign key(codigo_medico_fk) REFERENCES medico(codigo)
);

create table enderecos(
	cep varchar(11),
    logradouro varchar(40),
	bairro varchar(40),
	cidade varchar(40),
	estado varchar(40)
);

