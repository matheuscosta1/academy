/* ============================================================ */
/*   Database SCHEMA:  sec                                      */
/* ============================================================ */
BEGIN TRANSACTION;
--rollback
SET CONSTRAINTS ALL DEFERRED; -- ESTE COMANDO ATRASA A VERIFICACAO DE RESTRIÇÕES
SET SEARCH_PATH TO sec; -- ESTE COMANDO DEFINE O ESQUEMA DEFAULT DESTA TRANSAÇÕES
-- EMPRESA

INSERT INTO empresa(cnpj, nomeEmpresa) VALUES ('22333444000100', 'Restaurante ABC');
INSERT INTO empresa(cnpj, nomeEmpresa) VALUES ('22333555000100', 'SBC');
INSERT INTO empresa(cnpj, nomeEmpresa) VALUES ('22333666000100', 'UFU Faculdade de Computação');
INSERT INTO empresa(cnpj, nomeEmpresa) VALUES ('23123123000100', 'Banco X');
INSERT INTO empresa(cnpj, nomeEmpresa) VALUES ('23123777000100', 'MULTIMIDIA X');

-- ORGANIZADORA

INSERT INTO organizadora VALUES (1);


-- PATROCINADORA

INSERT INTO patrocinadora VALUES (4, 2500.00, 'L', '2019-06-09');

-- PROMOTORA

INSERT INTO promotora VALUES (2);


-- RESPONSAVEL

INSERT INTO responsavel VALUES (DEFAULT);
INSERT INTO responsavel VALUES (DEFAULT);
INSERT INTO responsavel VALUES (DEFAULT);

-- PESSOA

INSERT INTO pessoa(cpf, nomepessoa, datapagamentoinscricao, tipopessoa, idempresa, idresponsavel) 
	VALUES ('00000011100', 'Joao Batista', '2019-01-01', 'PR', 3, 2),
               ('00000011200', 'Maria Silva', '2019-01-01', 'PR', 3, 3),
               ('00000011300', 'Antonio Souza', '2019-01-01', 'ES', NULL, NULL),
	       ('00000011400', 'Delfim Junior', '2019-01-01', 'ES', 1, NULL);


-- PRESTADORA

INSERT INTO prestadora VALUES (1, NULL);
INSERT INTO prestadora VALUES (5, 1);


-- SERVICO

INSERT INTO servico VALUES (DEFAULT, 'Coffe-break, almoço, e jantar', 500.00, 'P', '2019-01-15', 2);
INSERT INTO servico VALUES (DEFAULT, 'Instalação de projetores', 1000.00, 'C', '2019-01-05', 1);
INSERT INTO servico VALUES (DEFAULT, 'Limpeza', 500.00, 'P', '2019-01-15', 3);


-- TAREFA


SELECT setval('tarefa_idtarefa_seq', 1);
INSERT INTO tarefa VALUES (DEFAULT, 'Workshop Banco de dados', 1, NULL);
INSERT INTO tarefa VALUES (DEFAULT, 'Sessao tecnica BD Relacionais', 1, 2);
INSERT INTO tarefa VALUES (DEFAULT, 'Sessao tecnica BD Orient. Obj.', 1, 3);
INSERT INTO tarefa VALUES (DEFAULT, 'Workshop Inteligencia artificial', 2, NULL);
INSERT INTO tarefa VALUES (DEFAULT, 'Minicurso Algoritmos Geneticos', 2, 5);
INSERT INTO tarefa VALUES (DEFAULT, 'Sessao tecnica BD NoSQL', 2, 5);

-- INSCRICAO
INSERT INTO inscricao VALUES (1, 2);
INSERT INTO inscricao VALUES (2, 2);
INSERT INTO inscricao VALUES (2, 3);
INSERT INTO inscricao VALUES (2, 4);
INSERT INTO inscricao VALUES (2, 5);
INSERT INTO inscricao VALUES (2, 6);
INSERT INTO inscricao VALUES (2, 7);	
INSERT INTO inscricao VALUES (3, 6);
INSERT INTO inscricao VALUES (4, 2);
INSERT INTO inscricao VALUES (4, 7);


END TRANSACTION;


