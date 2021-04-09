SET SEARCH_PATH TO sec; -- DEFINE ESQUEMA DEFAULT

INSERT INTO empresa       VALUES (1, '12345678910', 'Carrefour');
INSERT INTO patrocionadora VALUES (1, 184544.2000, 'P', '01/01/2001');
INSERT INTO organizadora  VALUES (1);
INSERT INTO promotora     VALUES (1);
INSERT INTO responsavel   VALUES (123);
INSERT INTO prestadora    VALUES (1, 123);
INSERT INTO pessoa        VALUES (12, '123456789', 'Ednaldo Pereira', '01/01/2001', 'ES', 1, 123);
INSERT INTO tarefa        VALUES (12345, 12, 12345, 'Criar o Esquema de BD SEC');
INSERT INTO servico       VALUES (1234, 'servicessss', 14.9, 'P', '01/01/2001', 123);
INSERT into inscricao     VALUES (12,12345);

END TRANSACTION;
