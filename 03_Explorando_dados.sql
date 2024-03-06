-- Explorando os Dados(EDA) usando AGREGAÇOES, SUBQUERY, JOINS

SELECT * FROM ecommerce.clientes;

-- Quantidade de cidades por cliente
SELECT cidade, COUNT(*) AS qtde 
FROM ecommerce.clientes
GROUP BY cidade
ORDER BY qtde DESC;


-- Tipos de pagamento por cidade
SELECT cidade, metodo_pagamento, COUNT(*) AS qtde 
FROM ecommerce.clientes
GROUP BY cidade, metodo_pagamento
ORDER BY cidade, qtde DESC;


SELECT * FROM ecommerce.vendas;


-- Quantidade de venda segmentada por tipo de canal
SELECT canal_venda, COUNT(*) AS qtde 
FROM ecommerce.vendas
GROUP BY canal_venda
ORDER BY qtde;


-- Total de compras feitas por clientes
SELECT id_cliente, SUM(quantidade) AS qtde_compras
FROM ecommerce.vendas
GROUP BY id_cliente
ORDER BY qtde_compras DESC;


-- Verificando top 10 compras.
SELECT id_cliente, SUM(valor_venda) AS total_vendas
FROM ecommerce.vendas
GROUP BY id_cliente
ORDER BY total_vendas DESC
LIMIT 10;


-- Total de vendas inferiores a R$1000
SELECT COUNT(valor_venda) AS total_vendas
FROM ecommerce.vendas
WHERE valor_venda < 1000;


-- Total de vendas feita por ANO, ordenada por total
SELECT EXTRACT(YEAR FROM data_venda) AS ano,
	   SUM(valor_venda) total,
	   SUM(quantidade) qtde
FROM ecommerce.vendas
GROUP BY ano
ORDER BY total DESC;	   


-- Total de venda por mes no ano de 2021
SELECT CASE
		WHEN EXTRACT(MONTH FROM data_venda) = 1 THEN 'Janeiro'
		WHEN EXTRACT (MONTH FROM data_venda) = 2 THEN 'fevereiro'
		WHEN EXTRACT (MONTH FROM data_venda) = 3 THEN 'marco'
		WHEN EXTRACT (MONTH FROM data_venda) = 4 THEN 'abril'
		WHEN EXTRACT (MONTH FROM data_venda) = 5 THEN 'maio'
		WHEN EXTRACT (MONTH FROM data_venda) = 6 THEN 'junho'
		WHEN EXTRACT (MONTH FROM data_venda) = 7 THEN 'julho'
		WHEN EXTRACT (MONTH FROM data_venda) = 8 THEN 'agosto'
		WHEN EXTRACT (MONTH FROM data_venda) = 9 THEN 'setembro'
		WHEN EXTRACT (MONTH FROM data_venda) = 10 THEN 'outubro'
		WHEN EXTRACT (MONTH FROM data_venda) = 11 THEN 'novembro'
		WHEN EXTRACT (MONTH FROM data_venda) = 12 THEN 'dezembro'
	  END AS mes,
	   SUM(valor_venda) total,
	   SUM(quantidade) qtde
FROM ecommerce.vendas
WHERE data_venda BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY mes
ORDER BY total DESC;


-- Subquery para verificar os clientes que não compraram produtos.
SELECT id_cliente
FROM ecommerce.clientes
WHERE id_cliente NOT IN (SELECT c.id_cliente FROM ecommerce.clientes c
						 JOIN ecommerce.vendas v ON c.id_cliente = v.id_cliente);
	
	
-- JOIN com as tabela vendas, clientes e produtos.
SELECT v.id_vendas, v.id_produto, v.id_cliente,
	   c.cidade, p.nome_produto, v.data_venda,
	   v.valor_venda, c.metodo_pagamento,
	   v.desconto, v.quantidade, v.canal_venda,
	   v.feedback_venda
FROM ecommerce.vendas v
JOIN ecommerce.clientes c ON c.id_cliente = v.id_cliente
JOIN ecommerce.produtos p ON v.id_produto = p.id_produto;


-- Total de vendas por cidade e canal de vendas.
SELECT c.cidade, v.canal_venda, COUNT(*) AS Qtde
FROM ecommerce.vendas v
JOIN ecommerce.clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.cidade, v.canal_venda
ORDER BY c.cidade, qtde DESC;


-- Total de vendas por produto e canal de vendas.
SELECT  v.canal_venda, p.nome_produto,  COUNT(*) AS Qtde
FROM ecommerce.vendas v
JOIN ecommerce.produtos p ON v.id_produto = p.id_produto
GROUP BY  v.canal_venda, p.nome_produto
ORDER BY v.canal_venda, qtde DESC;


-- Filtro de Cidades que tiveram vendas por Site e maior que R$20000,00
SELECT cidade, COUNT(*) FROM ecommerce.clientes
WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM ecommerce.vendas
WHERE canal_venda = 'Site' AND valor_venda > '20000')
GROUP BY cidade;