BEGIN TRANSACTION;
--ROLLBACK
DROP SCHEMA academico CASCADE;
CREATE SCHEMA academico;
SET search_path TO academico;

CREATE TABLE curso (
    idCurso SERIAL PRIMARY KEY,
	nomeCurso char(30) UNIQUE
);

CREATE TABLE aluno (
    idAluno SERIAL PRIMARY KEY,
	nomeAluno varchar(50),
	tipoAluno CHAR(2) CHECK (tipoAluno IN ('NM','ES')), -- NM=NORMAL, ES=ESPECIAL
	idCurso INT not null, -- fk id curso,
	constraint aluno_curso_fk foreign key (idCurso) references curso (idCurso)
);

CREATE TABLE disciplina (
    idDisciplina SERIAL PRIMARY KEY,
	nomeDisciplina varchar(50)
);

CREATE TABLE pre_requisito (
    idDisciplina INT NOT null, -- fk da disciplina
	idPreRequisito SERIAL,
	primary key (idDisciplina, idPreRequisito),
	constraint pre_requisito_disciplina_fk foreign key (idDisciplina) references disciplina (idDisciplina)
);

CREATE TABLE professor (
    idProfessor SERIAL PRIMARY KEY,
	nomeProfessor varchar(50)
);

CREATE TABLE turma (
    idTurma SERIAL,
	idDisciplina INT not null, -- fk para disciplina
	ano INT not null,
	semestre INT not null,
	codigoTurma int not null,
	primary key (idTurma),
	unique (idDisciplina, ano, semestre, codigoTurma), -- chave alternativa composta com disciplina fk
	constraint turma_disciplina_fk foreign key (idDisciplina) references disciplina (idDisciplina)
);

CREATE TABLE turma_professor (
    idTurma INT NOT null, -- fk da turma
	idProfessor INT not NULL, -- fk do professor
	primary key (idTurma, idProfessor),  -- chave composta turma e professor
	constraint turma_professor_professor_fk foreign key (idProfessor) references professor (idProfessor),
	constraint turma_professor_turma_fk foreign key (idTurma) references turma (idTurma)
);

CREATE TABLE historico (
    idAluno INT NOT null, -- fk do aluno
	idTurma INT not NULL, -- fk da turma,
	nota DECIMAL(11,2),
	primary key (idAluno, idTurma), -- chave composta aluno e turma
	constraint historico_aluno_fk foreign key (idAluno) references aluno (idAluno),
	constraint historico_turma_fk foreign key (idTurma) references turma (idTurma)
);

END transaction;
