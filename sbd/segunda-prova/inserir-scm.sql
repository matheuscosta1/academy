-- scm.circuito definition

-- Drop table

-- DROP TABLE circuito;

CREATE TABLE circuito (
	idcir serial NOT NULL,
	nomecir bpchar(30) NULL,
	paiscir varchar(20) NULL,
	CONSTRAINT circuito_nomecir_key UNIQUE (nomecir),
	CONSTRAINT circuito_pkey PRIMARY KEY (idcir)
);


-- scm.equipe definition

-- Drop table

-- DROP TABLE equipe;

CREATE TABLE equipe (
	idequ serial NOT NULL,
	nomeequ bpchar(30) NULL,
	paisequ varchar(20) NULL,
	titulosequ int4 NULL,
	CONSTRAINT equipe_nomeequ_key UNIQUE (nomeequ),
	CONSTRAINT equipe_pkey PRIMARY KEY (idequ)
);


-- scm.corrida definition

-- Drop table

-- DROP TABLE corrida;

CREATE TABLE corrida (
	idcor serial NOT NULL,
	datacor date NULL,
	idcir int4 NOT NULL,
	categoria varchar(30) NULL,
	nvoltas int4 NULL,
	CONSTRAINT corrida_datacor_idcir_categoria_key UNIQUE (datacor, idcir, categoria),
	CONSTRAINT corrida_pkey PRIMARY KEY (idcor),
	CONSTRAINT corrida_circuito_fk FOREIGN KEY (idcir) REFERENCES scm.circuito(idcir)
);


-- scm.pessoa definition

-- Drop table

-- DROP TABLE pessoa;

CREATE TABLE pessoa (
	idpes serial NOT NULL,
	nomepes varchar(50) NULL,
	tipopes bpchar(2) NULL,
	idequ int4 NOT NULL,
	CONSTRAINT pessoa_pkey PRIMARY KEY (idpes),
	CONSTRAINT pessoa_tipopes_check CHECK ((tipopes = ANY (ARRAY['P'::bpchar, 'M'::bpchar]))),
	CONSTRAINT equipe_pessoa_fk FOREIGN KEY (idequ) REFERENCES scm.equipe(idequ)
);


-- scm.piloto definition

-- Drop table

-- DROP TABLE piloto;

CREATE TABLE piloto (
	idpes int4 NOT NULL,
	titulospes int4 NULL,
	pontuacao int4 NULL,
	CONSTRAINT piloto_pkey PRIMARY KEY (idpes),
	CONSTRAINT piloto_pessoa_fk FOREIGN KEY (idpes) REFERENCES scm.pessoa(idpes)
);


-- scm.mecanico definition

-- Drop table

-- DROP TABLE mecanico;

CREATE TABLE mecanico (
	idpes int4 NOT NULL,
	especialidademec varchar(20) NULL,
	CONSTRAINT mecanico_pkey PRIMARY KEY (idpes),
	CONSTRAINT mecanico_pessoa_fk FOREIGN KEY (idpes) REFERENCES scm.pessoa(idpes)
);


-- scm.participacao definition

-- Drop table

-- DROP TABLE participacao;

CREATE TABLE participacao (
	idpes int4 NOT NULL,
	idcor int4 NOT NULL,
	tempo time NULL,
	CONSTRAINT participacao_pkey PRIMARY KEY (idpes, idcor),
	CONSTRAINT participacao_corrida_fk FOREIGN KEY (idcor) REFERENCES scm.corrida(idcor),
	CONSTRAINT participacao_piloto_fk FOREIGN KEY (idpes) REFERENCES scm.piloto(idpes)
);
