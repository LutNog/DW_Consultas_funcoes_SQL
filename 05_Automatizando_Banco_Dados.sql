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
SELECT * FROM ecommerce.encoding_ecommerce
