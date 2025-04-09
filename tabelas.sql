create database ecommerce;

use ecommerce;

-- tabelas

create table client(
	idClient int auto_increment primary key,
	Fname varchar(10),
	Minit varchar(3),
	Lname varchar(20),
	CPF char(11) not null,
	Address varchar(30),
	constraint unique_cpf_client unique (CPF)
);

alter table client auto_increment=1;

ALTER TABLE client 
ADD COLUMN clientType enum('PF', 'PJ') not null;


ALTER TABLE client 
ADD COLUMN CPF char(11) unique;


ALTER TABLE client 
ADD COLUMN CNPJ char(14) unique;
      

create table product(
	idProduct int auto_increment primary key,
	Pname varchar(10) not null,
	classification_kids bool default false,
	category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis', 'Livros') not null,
	avaliacao float  default 0,
	dimensao varchar(10)
);
alter table product auto_increment=1;

create table payments(
	idClient int,
	idPayment int,
	typePayment enum('Boleto','Cartao', 'Dois cartoes'),
	limitAvaliable float,
	primary key(idClient, idPayment)
);

create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	orderDescription varchar(255),
	sendValue float default 10,
	paymentCash bool default false,
	constraint fk_orders_client foreign key (idOrderClient) references client(idClient)
);
alter table orders auto_increment=1;

create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);
alter table productStorage auto_increment=1;

create table supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
	CNPJ char(15) not null,
	contact char(11) not null,
	constraint unique_supplier  unique (CNPJ)
);
alter table supplier auto_increment=1;

create table seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
	AbstName varchar(255),
	CNPJ char(15),
	CPF char(9),
	location varchar(255),
	contact char(11) not null,
	constraint unique_cnpj_supplier  unique (CNPJ),
	constraint unique_cpf_supplier  unique (CPF)
);
alter table seller auto_increment=1;

create table productSeller(
	idPseller int,
	idPproduct int,
	prodQuantity int default 1,
	primary key (idPseller, idPproduct),
	constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
	primary key (idPOproduct, idPOorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
	constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- drop table storageLocation;
create table storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
	idPsproduct int,
	quantity int not null,
	primary key (idPsSupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsproduct) references product(idProduct)
);

create table delivery(
	idDelivery int auto_increment primary key,
	idOrder int,
	trackingCode varchar(50),
	deliveryStatus enum('Em transporte', 'Entregue', 'Aguardando envio') default 'Aguardando envio',
	constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
);
alter table delivery auto_increment=1;
show tables;

