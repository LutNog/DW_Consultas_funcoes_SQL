CREATE SCHEMA ecommerce;

-- Criando as tabelas.
CREATE TABLE ecommerce.clientes(
	Id_cliente SERIAL PRIMARY KEY,
	cidade VARCHAR (100) NOT NULL,
	metodo_pagamento VARCHAR(100) NOT NULL
);

CREATE TABLE ecommerce.produtos(
	Id_produto SERIAL PRIMARY KEY,
	nome_produto VARCHAR (255) NOT NULL
);

CREATE TABLE ecommerce.vendas(
	Id_vendas SERIAL PRIMARY KEY,
	Id_cliente INT NOT NULL,
	Id_produto INT NOT NULL,
	data_venda DATE NOT NULL,
	valor_venda DECIMAL (10,2) NOT NULL,
	desconto INT,
	quantidade INT NOT NULL,
	canal_venda VARCHAR(255) NOT NULL,
	feedback_venda INT,
	FOREIGN KEY (Id_cliente) REFERENCES ecommerce.clientes(Id_cliente),
	FOREIGN KEY (Id_produto) REFERENCES ecommerce.produtos(Id_produto)
);

-- Visualizando as tabelas.
SELECT * FROM ecommerce.clientes;
SELECT * FROM ecommerce.produtos;
SELECT * FROM ecommerce.vendas;