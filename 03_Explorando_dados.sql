-- Explorando os Dados(EDA) 

SELECT * FROM ecommerce.clientes;
SELECT * FROM ecommerce.vendas;

-- JOIN com as tabela vendas, clientes e produtos.
SELECT v.id_vendas, v.id_produto, v.id_cliente,
	   c.cidade, p.nome_produto, v.data_venda,
	   v.valor_venda, c.metodo_pagamento,
	   v.desconto, v.quantidade, v.canal_venda,
	   v.feedback_venda
FROM ecommerce.vendas v
JOIN ecommerce.clientes c ON c.id_cliente = v.id_cliente
JOIN ecommerce.produtos p ON v.id_produto = p.id_produto;


-- Sumário dos dados

-- VIEW criada com o JOIN acima.
SELECT * FROM ecommerce.analise_ecommerce


-- Sumarização por cidade, quantidade, soma valores, média, mediana, maior, menor, total de vendas por canal.
SELECT cidade,
	   COUNT(*) AS contagem_vendas,
	   SUM(valor_total_desconto) AS total_valores,
	   ROUND(AVG(valor_total_desconto),2) AS media_valores,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor_total_desconto) AS mediana_valores,
	   ROUND(STDDEV(valor_total_desconto),3) AS desvio_padrao,
	   MAX(valor_total_desconto) AS maior_venda,
	   MIN(valor_total_desconto) AS menor_venda,
	   SUM(CASE WHEN canal_venda = 'Amazom' THEN valor_total_desconto END) AS soma_valores_por_Amazom,
	   SUM(CASE WHEN canal_venda = 'Instagram' THEN  valor_total_desconto END) AS soma_valores_por_Instagram,
	   SUM(CASE WHEN canal_venda = 'Mercado Livre' THEN  valor_total_desconto END) AS soma_valores_por_Mercado_Livre,
	   SUM(CASE WHEN canal_venda = 'Site' THEN  valor_total_desconto END) AS soma_valores_por_Site,
	   SUM(CASE WHEN canal_venda = 'Shopee' THEN  valor_total_desconto END) AS soma_valores_por_Shopee
FROM ecommerce.analise_ecommerce
GROUP BY cidade
ORDER BY total_valores DESC;
	   

-- Sumarização por produto, quantidade, soma valores, média, mediana, maior, menor, total de vendas por canal.
SELECT nome_produto,
	   COUNT(*) AS contagem_vendas,
	   SUM(valor_total_desconto) AS total_valores,
	   ROUND(AVG(valor_total_desconto),2) AS media_valores,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor_total_desconto) AS mediana_valores,
	   ROUND(STDDEV(valor_total_desconto),3) AS desvio_padrao,
	   MAX(valor_total_desconto) AS maior_venda,
	   MIN(valor_total_desconto) AS menor_venda,
	   SUM(CASE WHEN canal_venda = 'Amazom' THEN valor_total_desconto END) AS soma_valores_por_Amazom,
	   SUM(CASE WHEN canal_venda = 'Instagram' THEN  valor_total_desconto END) AS soma_valores_por_Instagram,
	   SUM(CASE WHEN canal_venda = 'Mercado Livre' THEN  valor_total_desconto END) AS soma_valores_por_Mercado_Livre,
	   SUM(CASE WHEN canal_venda = 'Site' THEN  valor_total_desconto END) AS soma_valores_por_Site,
	   SUM(CASE WHEN canal_venda = 'Shopee' THEN  valor_total_desconto END) AS soma_valores_por_Shopee
FROM ecommerce.analise_ecommerce
GROUP BY nome_produto
ORDER BY total_valores DESC;
	   

-- Sumarização de vendas por ano.
SELECT EXTRACT(YEAR FROM data_venda) AS ano,
	   COUNT(*) AS contagem_vendas,
	   SUM(valor_total_desconto) AS total_valores,
	   ROUND(AVG(valor_total_desconto),2) AS media_valores,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor_total_desconto) AS mediana_valores,
	   ROUND(STDDEV(valor_total_desconto),3) AS desvio_padrao,
	   MAX(valor_total_desconto) AS maior_venda,
	   MIN(valor_total_desconto) AS menor_venda,
	   SUM(CASE WHEN canal_venda = 'Amazom' THEN valor_total_desconto END) AS soma_valores_por_Amazom,
	   SUM(CASE WHEN canal_venda = 'Instagram' THEN  valor_total_desconto END) AS soma_valores_por_Instagram,
	   SUM(CASE WHEN canal_venda = 'Mercado Livre' THEN  valor_total_desconto END) AS soma_valores_por_Mercado_Livre,
	   SUM(CASE WHEN canal_venda = 'Site' THEN  valor_total_desconto END) AS soma_valores_por_Site,
	   SUM(CASE WHEN canal_venda = 'Shopee' THEN  valor_total_desconto END) AS soma_valores_por_Shopee
FROM ecommerce.analise_ecommerce
GROUP BY ano
ORDER BY total_valores DESC;


-- Verificando a distribuição dos dados por canal de venda e pagamento.
SELECT canal_venda,
	   metodo_pagamento,
	   COUNT(*) AS quantidade,
	   SUM(valor_total_desconto) AS total_valores,
	   ROUND(AVG(valor_total_desconto),2) AS media_valores,
	   ROUND(STDDEV(valor_total_desconto),3) AS desvio_padrao,
	   PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor_total_desconto) AS primeiro_quartil,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor_total_desconto) AS segundo_quartil,
	   PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor_total_desconto) AS terceito_quartil,
	   MAX(valor_total_desconto) AS maior_venda,
	   MIN(valor_total_desconto) AS menor_venda
FROM ecommerce.analise_ecommerce
GROUP BY canal_venda, metodo_pagamento
ORDER BY canal_venda, metodo_pagamento;


-- Distribuição dos dados por canal de venda e feedback.
SELECT canal_venda,
	   COUNT(feedback_venda) AS quantidade_feedback,
	   ROUND(AVG(feedback_venda),2) AS media_feedback,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY feedback_venda) AS mediana_feedback,
	   ROUND(STDDEV(feedback_venda),3) AS desvio_feedback,
	   MAX(feedback_venda) AS maior_feedback,
	   MIN(feedback_venda) AS menor_feedback
FROM ecommerce.analise_ecommerce
GROUP BY canal_venda
ORDER BY canal_venda;


-- Distribuição dos dados por cidade e feedback.
SELECT cidade,
	   COUNT(feedback_venda) AS quantidade_feedback,
	   ROUND(AVG(feedback_venda),2) AS media_feedback,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY feedback_venda) AS mediana_feedback,
	   ROUND(STDDEV(feedback_venda),3) AS desvio_feedback,
	   MAX(feedback_venda) AS maior_feedback,
	   MIN(feedback_venda) AS menor_feedback
FROM ecommerce.analise_ecommerce
GROUP BY cidade
ORDER BY cidade;


-- Análise mutivariada das variáveis: ano, canal_venda, valor_total e metodo de pagamento.
SELECT EXTRACT(YEAR FROM data_venda) AS ano,
	   canal_venda,
	   SUM(valor_total_desconto) AS total_vendas_ano,
	   DENSE_RANK() OVER(PARTITION BY EXTRACT(YEAR FROM data_venda) 
						 ORDER BY SUM(valor_total_desconto) DESC) AS rank_total_vendas,
	   ROUND(AVG(valor_total_desconto), 2) media_valor,
	   DENSE_RANK() OVER(PARTITION BY EXTRACT(YEAR FROM data_venda) 
						 ORDER BY ROUND(AVG(valor_total_desconto), 2)DESC) AS rank_media_valor
FROM ecommerce.analise_ecommerce
WHERE metodo_pagamento IN ('PIX', 'Débito')
GROUP BY ano, canal_venda
ORDER BY ano, rank_total_vendas;


-- Análise mutivariada das variáveis: cidade, produto, valor_total e metodo de pagamento.
SELECT cidade,
	   nome_produto AS produto,
	   SUM(valor_total_desconto) AS total_vendas_ano,
	   DENSE_RANK() OVER(PARTITION BY cidade 
						 ORDER BY SUM(valor_total_desconto) DESC) AS rank_total_vendas,
	   ROUND(AVG(valor_total_desconto), 2) media_valor,
	   DENSE_RANK() OVER(PARTITION BY cidade 
						 ORDER BY ROUND(AVG(valor_total_desconto), 2)DESC) AS rank_media_valor
FROM ecommerce.analise_ecommerce
WHERE metodo_pagamento IN ('PIX', 'Débito')
GROUP BY cidade, produto
ORDER BY cidade, rank_total_vendas;


-- Identificação de outliers, com sensibilidade do IQR de 0.5
SELECT nome_produto AS produto,
	   metodo_pagamento AS pagamento,
	   MIN(valor_total_desconto) AS valor_minimo,
	   PERCENTILE_CONT(0.25)  WITHIN GROUP (ORDER BY valor_total_desconto) - 0.5 * (PERCENTILE_CONT(0.75)  WITHIN GROUP (ORDER BY valor_total_desconto) - PERCENTILE_CONT(0.25)  WITHIN GROUP (ORDER BY valor_total_desconto)) AS limite_inferior,
	   PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY valor_total_desconto) AS mediana,
	   PERCENTILE_CONT(0.75)  WITHIN GROUP (ORDER BY valor_total_desconto) + 0.5 * (PERCENTILE_CONT(0.75)  WITHIN GROUP (ORDER BY valor_total_desconto) - PERCENTILE_CONT(0.25)  WITHIN GROUP (ORDER BY valor_total_desconto)) AS limite_superior,
	   MAX(valor_total_desconto) AS valor_maximo
FROM ecommerce.analise_ecommerce
GROUP BY produto, pagamento;


-- Retornando produtos com possíveis outliers.
WITH estatistica AS (
SELECT nome_produto AS produto,
	   metodo_pagamento AS pagamento,
	   PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor_total_desconto) AS q1,
	   PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor_total_desconto) AS q3
FROM ecommerce.analise_ecommerce
GROUP BY produto, pagamento
),
limitesoutliers AS (
	SELECT produto,
	  	 pagamento,
	   	 q1,
	   	 q3,
	   	 q1 - 0.5 * (q3 - q1) AS limite_inferior,
	   	 q3 + 0.5 * (q3 - q1) AS limite_superior
	FROM estatistica
)
SELECT a.nome_produto AS produto,
	   a.metodo_pagamento AS pagamento,
	   a.valor_total_desconto AS valor,
	   a.data_venda
FROM ecommerce.analise_ecommerce a
INNER JOIN limitesoutliers l ON a.nome_produto = l.produto AND a.metodo_pagamento = l.pagamento
WHERE a.valor_total_desconto < l.limite_inferior OR a.valor_total_desconto > l.limite_superior
ORDER BY a.nome_produto, a.metodo_pagamento;



