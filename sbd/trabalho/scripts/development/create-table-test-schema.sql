
create table category
(
    id int auto_increment
        primary key,
    name varchar(255) null
);

create table customer
(
    id int auto_increment
        primary key,
    email varchar(255) null,
    name varchar(255) null,
    password varchar(255) null,
    person_identity varchar(255) null,
    type int null,
    constraint UK_dwk6cx0afu8bs9o4t536v1j5v
        unique (email)
);

create table phone
(
    customer_id int not null,
    phones varchar(255) null,
    constraint FKgvgc4f2c3qkiswyv6bbs0br1p
        foreign key (customer_id) references customer (id)
);

create table product
(
    id int auto_increment
        primary key,
    name varchar(255) null,
    price double null
);

create table category_product
(
    product_id int not null,
    category_id int not null,
    constraint FKfr6rjc04htbtc3xas2b9xmq7r
        foreign key (category_id) references category (id),
    constraint FKssroqj2vyiaujfleklq1ifigj
        foreign key (product_id) references product (id)
);

create table profile
(
    customer_id int not null,
    profiles int null,
    constraint FK88rruc7qawl75mscnnwrah9sc
        foreign key (customer_id) references customer (id)
);

create table state
(
    id int auto_increment
        primary key,
    name varchar(255) null
);

create table city
(
    id int auto_increment
        primary key,
    name varchar(255) null,
    state_id int null,
    constraint FK6p2u50v8fg2y0js6djc6xanit
        foreign key (state_id) references state (id)
);

create table address
(
    id int auto_increment
        primary key,
    complement varchar(255) null,
    neighborhood varchar(255) null,
    number varchar(255) null,
    public_place varchar(255) null,
    zip_code varchar(255) null,
    city_id int null,
    customer_id int null,
    constraint FK93c3js0e22ll1xlu21nvrhqgg
        foreign key (customer_id) references customer (id),
    constraint FKpo044ng5x4gynb291cv24vtea
        foreign key (city_id) references city (id)
);

create table request
(
    id int auto_increment
        primary key,
    created_at datetime null,
    customer_id int null,
    delivery_address_id int null,
    constraint FK6wuyy6femh1tl1jxmw1ilrs6b
        foreign key (customer_id) references customer (id),
    constraint FKn579kjmk2jkthnj21hyv20h54
        foreign key (delivery_address_id) references address (id)
);

create table payment
(
    request_id int not null
        primary key,
    state int null,
    constraint FK5pgyup82pk40rm2mo6jeqrbi7
        foreign key (request_id) references request (id)
);

create table billet_payment
(
    due_date datetime null,
    payday datetime null,
    request_id int not null
        primary key,
    constraint FKbk36yb9dp0cpr3beqn66y8xmb
        foreign key (request_id) references payment (request_id)
);

create table card_payment
(
    installments_number int null,
    request_id int not null
        primary key,
    constraint FK2k4ugt7m1xsxvb15xt9y8dnr2
        foreign key (request_id) references payment (request_id)
);

create table request_item
(
    discount double null,
    price double null,
    quantity int null,
    product_id int not null,
    request_id int not null,
    primary key (product_id, request_id),
    constraint FKd2t6dw5gx34u1me7451b64xq3
        foreign key (request_id) references request (id),
    constraint FKrtyfreo7es5rpkasqslrpvm5v
        foreign key (product_id) references product (id)
);