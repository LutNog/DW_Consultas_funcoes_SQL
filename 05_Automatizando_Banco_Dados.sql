-- Automatizando com VIEWS, TRIGGERS, FUNÇÕES

-- Criando uma VIEW com informações para análise.
CREATE VIEW ecommerce.analise_ecommerce AS
SELECT v.id_cliente,
	   c.cidade, p.nome_produto, v.data_venda,
	   v.valor_venda, v.desconto, 
	   valor_venda - (valor_venda * (desconto / 100)) AS valor_total_desconto,
	   c.metodo_pagamento,
	   v.quantidade, v.canal_venda,
	   v.feedback_venda	   
FROM ecommerce.vendas v
JOIN ecommerce.clientes c ON c.id_cliente = v.id_cliente
JOIN ecommerce.produtos p ON v.id_produto = p.id_produto;


-- Visualizando a VIEW
SELECT * FROM ecommerce.analise_ecommerce;


-- Criando uma MATERIALIZED VIEW com informações para Encoding.
CREATE MATERIALIZED VIEW ecommerce.encoding_ecommerce AS
SELECT c.cidade, p.nome_produto,
	   valor_venda - (valor_venda * (desconto / 100)) AS valor_total_desconto,
	   c.metodo_pagamento,
	   v.quantidade, v.canal_venda,
	   v.feedback_venda	   
FROM ecommerce.vendas v
JOIN ecommerce.clientes c ON c.id_cliente = v.id_cliente
JOIN ecommerce.produtos p ON v.id_produto = p.id_produto;


-- Visualizando a MATERIALIZED VIEW
SELECT * FROM ecommerce.encoding_ecommerce;

SELECT * FROM ecommerce.analise_ecommerce;


-- Criando um Function que retorna o valor total por meio do método de pagamento.
CREATE OR REPLACE FUNCTION ecommerce.calcula_total_metodo_pagamento(metodo_parametro VARCHAR(255))
RETURNS DECIMAL(10,2) AS $$ 
DECLARE 
	total_pagamento DECIMAL (10,2);
BEGIN
	SELECT SUM(valor_total_desconto) INTO total_pagamento
	FROM ecommerce.analise_ecommerce
	WHERE metodo_pagamento = metodo_parametro;
	
	IF total_pagamento IS NULL THEN
		RETURN 0;
	ELSE
		RETURN total_pagamento;
	END IF;
END;
$$ LANGUAGE plpgsql;


-- Testando a Função
SELECT ecommerce.calcula_total_metodo_pagamento('PIX');


-- Criando um Function que retorna o valor total de compras por cliente.
CREATE OR REPLACE FUNCTION ecommerce.calcula_total_compra_cliente(id_cliente_paramento INT)
RETURNS DECIMAL(10,2) AS $$ 
DECLARE 
	total_pagamento DECIMAL (10,2);
BEGIN
	SELECT SUM(valor_total_desconto) INTO total_pagamento
	FROM ecommerce.analise_ecommerce
	WHERE id_cliente = id_cliente_paramento;
	
	IF total_pagamento IS NULL THEN
		RETURN 0;
	ELSE
		RETURN total_pagamento;
	END IF;
END;
$$ LANGUAGE plpgsql;


-- Testando a Função
SELECT id_cliente,
	cidade,
	metodo_pagamento,
	canal_venda,
	ecommerce.calcula_total_compra_cliente(14) AS Total_compra
FROM ecommerce.analise_ecommerce
WHERE id_cliente = 14;


SELECT ecommerce.calcula_total_compra_cliente(591);
