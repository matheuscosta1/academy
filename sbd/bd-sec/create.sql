create schema sec;

CREATE DOMAIN EstadoLiberacao AS varchar(1) check (
	value in ('P', 'L')
);

CREATE DOMAIN EstadoServico AS varchar(1) check (
	value in ('P', 'C', 'E', 'G')
);

CREATE DOMAIN TipoPessoa AS varchar(2) check (
	value in ('ES', 'PR', 'EP')
);

create table empresa (
	idEmpresa int not null primary key,
	cnpj varchar(20),
	NomeEmpresa varchar(20)
);

create table patrocionadora (
	idEmpresa int not null primary key,
	valorPatrocinio decimal(10,4),
	estadoLiberacao EstadoLiberacao,
	dataLiberacao date,
	constraint idEmpresa foreign key (idEmpresa) references empresa(idEmpresa)
);

create table organizadora (
	constraint idEmpresa foreign key (idEmpresa) references empresa(idEmpresa),
	idEmpresa int not null primary key
);

create table promotora (
	constraint idEmpresa foreign key (idEmpresa) references empresa(idEmpresa),
	idEmpresa int not null primary key
);

create table responsavel (
	idResponsavel int not null primary key
);

create table prestadora (
	idEmpresa int not null primary key,
	idResponsavel int not null,
	constraint idEmpresa foreign key (idEmpresa) references empresa(idEmpresa),
	constraint idResponsavel foreign key (idResponsavel) references responsavel(idResponsavel)
);

create table servico (
	idServico int not null primary key,
	descricaoServico varchar(100),
	custoServico decimal(10,4) not null,
	estadoServico EstadoServico not null,
	dataTerminoServico date,
	idResponsavel int not null,
	constraint idResponsavel foreign key (idResponsavel) references responsavel(idResponsavel)
);

create table pessoa (
	idPessoa int not null primary key,
	cpf varchar(12),
	nomePessoa varchar(50),
	dataPagamentoInscricao date,
	tipoPessoa TipoPessoa,
	idEmpresa int,
	idResponsavel int not null,
	constraint idResponsavel foreign key (idResponsavel) references responsavel(idResponsavel)
);

create table tarefa (
	idTarefa int not null primary key,
    idPessoa int not null,
   	idSuperTarefa int not null,
	descricaoTarefa varchar(100),
	constraint idPessoa foreign key (idPessoa) references pessoa(idPessoa),
	constraint idSuperTarefa foreign key (idSuperTarefa) references tarefa(idTarefa)
);


create table inscricao (
    idPessoa int not null,
    idTarefa int not null,
    primary key(idPessoa, idTarefa),
	constraint idPessoa foreign key (idPessoa) references pessoa(idPessoa),
	constraint idTarefa foreign key (idTarefa) references tarefa(idTarefa)
);

