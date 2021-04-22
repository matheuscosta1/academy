## Category
INSERT INTO trabalho_sbd.category (id, name) VALUES (1, 'Informática');
INSERT INTO trabalho_sbd.category (id, name) VALUES (2, 'Escritório');
INSERT INTO trabalho_sbd.category (id, name) VALUES (3, 'Mesa e banho');
INSERT INTO trabalho_sbd.category (id, name) VALUES (4, 'Teste');

## Product
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (1, 'Computador', 2000);
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (2, 'Impressora', 800);
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (3, 'Mouse', 80);
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (4, 'Mesa de escritório', 300);
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (5, 'Toalha', 50);
INSERT INTO trabalho_sbd.product (id, name, price) VALUES (6, 'Colcha', 200);

## Product Category
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (1, 1);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (2, 1);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (2, 2);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (3, 1);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (4, 3);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (5, 3);
INSERT INTO trabalho_sbd.category_product (product_id, category_id) VALUES (6, 1);

## State
INSERT INTO trabalho_sbd.state (id, name) VALUES (1, 'Minas Gerais');
INSERT INTO trabalho_sbd.state (id, name) VALUES (2, 'São Paulo');

## City
INSERT INTO trabalho_sbd.city (id, name, state_id) VALUES (1, 'Uberlândia', 1);
INSERT INTO trabalho_sbd.city (id, name, state_id) VALUES (2, 'São Paulo', 2);
INSERT INTO trabalho_sbd.city (id, name, state_id) VALUES (3, 'Campinas', 2);

## Customer
INSERT INTO trabalho_sbd.customer (id, email, name, person_identity, type, password) VALUES (1, 'maria@gmail.com', 'Maria Silva', '72113079003', 1, '$2y$12$ojDDqa48iPiTnzyzaOiqDeDH08/NljrjsiRiODk0wUqZKZ84l8MgC');
INSERT INTO trabalho_sbd.customer (id, email, name, person_identity, type, password) VALUES (2, 'matheus.costa@tutanota.com', 'Matheus José', '12629141675', 1, '$2y$12$cOKTjfwZe39JHGp3tlGYbeiiYB2GZOaNr9nDBDzw0Ku1Umdn.geeu');

## Phones
INSERT INTO trabalho_sbd.phone (customer_id, phones) VALUES (1, '998068391');
INSERT INTO trabalho_sbd.phone (customer_id, phones) VALUES (1, '38148199');

## Address
INSERT INTO trabalho_sbd.address (id, complement, neighborhood, number, public_place, zip_code, city_id, customer_id) VALUES (1, 'Apto 303', 'Jardim', '300', 'Rua Flores', '38408136', 1, 1);
INSERT INTO trabalho_sbd.address (id, complement, neighborhood, number, public_place, zip_code, city_id, customer_id) VALUES (2, 'Apto 500', 'Centro', '105', 'Avenida Matos', '38408135', 2, 1);

## Request
INSERT INTO trabalho_sbd.request (id, created_at, customer_id, delivery_address_id) VALUES (1, '2017-09-30 13:32:00', 1, 1);
INSERT INTO trabalho_sbd.request (id, created_at, customer_id, delivery_address_id) VALUES (2, '2019-10-30 14:27:00', 1, 2);
INSERT INTO trabalho_sbd.request (id, created_at, customer_id, delivery_address_id) VALUES (3, '2020-06-08 04:41:48.897000000', 1, 1);

## Request Item
INSERT INTO trabalho_sbd.request_item (discount, price, quantity, product_id, request_id) VALUES (0, 2000, 1, 1, 1);
INSERT INTO trabalho_sbd.request_item (discount, price, quantity, product_id, request_id) VALUES (0, 2000, 1, 1, 3);
INSERT INTO trabalho_sbd.request_item (discount, price, quantity, product_id, request_id) VALUES (100, 800, 1, 2, 2);
INSERT INTO trabalho_sbd.request_item (discount, price, quantity, product_id, request_id) VALUES (0, 80, 2, 3, 1);
INSERT INTO trabalho_sbd.request_item (discount, price, quantity, product_id, request_id) VALUES (0, 80, 2, 3, 3);

## Payment
INSERT INTO trabalho_sbd.payment (request_id, state) VALUES (1, 2);
INSERT INTO trabalho_sbd.payment (request_id, state) VALUES (2, 1);
INSERT INTO trabalho_sbd.payment (request_id, state) VALUES (3, 1);

## Billet Payment
INSERT INTO trabalho_sbd.billet_payment (due_date, payday, request_id) VALUES ('2017-10-20 02:00:00', null, 2);

## Card Payment
INSERT INTO trabalho_sbd.card_payment (installments_number, request_id) VALUES (6, 1);
INSERT INTO trabalho_sbd.card_payment (installments_number, request_id) VALUES (10, 3);

## Profile
INSERT INTO trabalho_sbd.profile (customer_id, profiles) VALUES (1, 2);
INSERT INTO trabalho_sbd.profile (customer_id, profiles) VALUES (2, 1);
