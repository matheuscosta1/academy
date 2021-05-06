BEGIN TRANSACTION;
--ROLLBACK
DROP SCHEMA sec CASCADE;
CREATE SCHEMA sec;
SET search_path TO sec;

CREATE TABLE empresa (
    idEmpresa SERIAL PRIMARY KEY,
	cnpj char(14) UNIQUE,
	nomeEmpresa VARCHAR(50)
);

CREATE TABLE patrocinadora (
	idEmpresa INT PRIMARY KEY, --FK empresa
	valorPatrocinio DECIMAL (11,2),
        estadoLiberacao CHAR(1) 
		CHECK (estadoLiberacao IN ('P', 'L')), --P=PREVISTO, L=LIBERADO
	dataLiberacao DATE
);

CREATE TABLE organizadora (
	idEmpresa INT PRIMARY KEY --FK empresa
);

CREATE TABLE promotora (
	idEmpresa INT PRIMARY KEY --FK empresa
);

CREATE TABLE prestadora (
	idEmpresa INT PRIMARY KEY, --FK empresa
	idResponsavel INT --FK responsavel
);

CREATE TABLE responsavel (
	idResponsavel SERIAL PRIMARY KEY
);

CREATE TABLE servico (
	idServico SERIAL PRIMARY KEY,	
	descricaoServico TEXT,
	custoServico DECIMAL (11,2),
	estadoServico CHAR
                    CHECK (estadoServico IN ('P','C','E','G')), 
                    --P=PREVISTO, C=CONTRATADO, E=EXECUTADO, G=PAGO
	dataTerminoServico DATE,
	idResponsavel INT NOT NULL --FK responsavel
	
);

CREATE TABLE tarefa (
	idTarefa SERIAL PRIMARY KEY, 
	descricaoTarefa TEXT,
	idPessoa INT NOT NULL, --FK pessoa
	idSuperTarefa INT --FK tarefa
);

CREATE TABLE pessoa (
	idPessoa SERIAL PRIMARY KEY,
	cpf CHAR(11) UNIQUE,
	nomePessoa VARCHAR(50),
	dataPagamentoInscricao DATE,
	-- custoInscricao DECIMAL (7,2),   -- atributo derivado no EER, haverá uma função para calculá-lo
	tipoPessoa CHAR(2) CHECK (tipoPessoa IN ('ES','PR', 'EP')), -- ES=ESTUDANTE, PR=PROFISSIONAL, EP=AMBOS
	idEmpresa INT, -- FK empresa, permitindo NULL
	idResponsavel INT UNIQUE --FK responsavel, permitindo NULL
);

CREATE TABLE inscricao (
	idPessoa INT,  -- FK pessoa
	idTarefa INT, -- FK tarefa
	PRIMARY KEY (idPessoa, idTarefa)
);

------------- ALTER TABLE -----------

ALTER TABLE servico
	ADD CONSTRAINT serv_codresp FOREIGN KEY (idResponsavel)
	REFERENCES responsavel (idResponsavel) DEFERRABLE;

ALTER TABLE tarefa 
	ADD CONSTRAINT tarefa_idPessoa FOREIGN KEY (idPessoa)
	REFERENCES pessoa(idPessoa) DEFERRABLE;

ALTER TABLE tarefa
	ADD CONSTRAINT tarefa_supertarefa FOREIGN KEY (idSuperTarefa)
	REFERENCES tarefa(idTarefa) DEFERRABLE;

ALTER TABLE pessoa
	ADD CONSTRAINT pessoa_idEmpresa FOREIGN KEY (idEmpresa)
	REFERENCES empresa(idEmpresa) ON DELETE SET NULL
        DEFERRABLE;

ALTER TABLE pessoa
	ADD CONSTRAINT pessoa_idResponsavel FOREIGN KEY (idResponsavel)
	REFERENCES responsavel(idResponsavel) ON DELETE SET NULL
        DEFERRABLE;

ALTER TABLE prestadora
	ADD CONSTRAINT prest_idEmpresa FOREIGN KEY (idEmpresa)
	REFERENCES empresa (idEmpresa) ON DELETE CASCADE
	DEFERRABLE;

ALTER TABLE prestadora
	ADD CONSTRAINT prest_codresp FOREIGN KEY (idResponsavel)
	REFERENCES responsavel (idResponsavel) ON DELETE CASCADE
	DEFERRABLE;

ALTER TABLE promotora 
	ADD CONSTRAINT promot_idEmpresa FOREIGN KEY (idEmpresa)
	REFERENCES empresa(idEmpresa) ON DELETE CASCADE
	DEFERRABLE;

ALTER TABLE organizadora
	ADD CONSTRAINT organiz_idEmpresa FOREIGN KEY (idEmpresa)
	REFERENCES empresa(idEmpresa) ON DELETE CASCADE
	DEFERRABLE;

ALTER TABLE patrocinadora
	ADD CONSTRAINT patroc_idEmpresa FOREIGN KEY (idEmpresa)
	REFERENCES empresa(idEmpresa) ON DELETE CASCADE
	DEFERRABLE;

ALTER TABLE inscricao
	ADD CONSTRAINT insc_idPessoa FOREIGN KEY (idPessoa)
	REFERENCES pessoa(idPessoa) ON DELETE CASCADE
	DEFERRABLE;
	
ALTER TABLE inscricao
	ADD CONSTRAINT insc_tarefa FOREIGN KEY (idTarefa)
	REFERENCES tarefa(idTarefa) ON DELETE CASCADE
	DEFERRABLE;
	
END TRANSACTION;	
						   