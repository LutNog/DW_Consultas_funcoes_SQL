-- Label Encoding, One-Hot Encoding dos Dados

SELECT * FROM ecommerce.encoding_ecommerce

-- Cidades Distintas
SELECT DISTINCT(cidade) FROM ecommerce.encoding_ecommerce
ORDER BY cidade;

-- Label Encoding da Variável Cidade.
SELECT cidade,
	   CASE
	   		WHEN cidade = 'Belo Horizonte' THEN 1
			WHEN cidade = 'Campinas' THEN 2
			WHEN cidade = 'Curitiba' THEN 3
			WHEN cidade = 'Fortaleza' THEN 4
			WHEN cidade = 'Porto Alegre' THEN 5
			WHEN cidade = 'Recife' THEN 6
			WHEN cidade = 'Salvador' THEN 8
			WHEN cidade = 'Rio de Janeiro' THEN 7
			WHEN cidade = 'São Paulo' THEN 9
			WHEN cidade = 'Vitória' THEN 10
		END AS cidade
FROM ecommerce.encoding_ecommerce;


-- Produtos Distintos
SELECT DISTINCT(nome_produto) FROM ecommerce.encoding_ecommerce
ORDER BY nome_produto;


-- Label Encoding da Variável Produtos.
SELECT nome_produto,
	   CASE
	   		WHEN nome_produto = 'Camera' THEN 1
			WHEN nome_produto = 'Celular' THEN 2
			WHEN nome_produto = 'Computador' THEN 3
			WHEN nome_produto = 'Impressora' THEN 4
			WHEN nome_produto = 'Notebook' THEN 5
			WHEN nome_produto = 'Tablet' THEN 6
		END AS produto
FROM ecommerce.encoding_ecommerce;

-- Método Pagamentos Distintos
SELECT DISTINCT(metodo_pagamento) FROM ecommerce.encoding_ecommerce
ORDER BY metodo_pagamento;


-- One-Hot Encoding da Variável Produtos.
SELECT metodo_pagamento,
	   CASE
	   		WHEN metodo_pagamento = 'Crédito' THEN 1
			ELSE 0
	   END AS Crédito,
	   CASE
			WHEN metodo_pagamento = 'Débito' THEN 1
			ELSE 0
	   END AS Débito,
	   CASE
			WHEN metodo_pagamento = 'PIX' THEN 1
			ELSE 0			
	   END AS PIX
FROM ecommerce.encoding_ecommerce;


-- Canal de Vendas Distintos
SELECT DISTINCT(canal_venda) FROM ecommerce.encoding_ecommerce
ORDER BY canal_venda;


-- One-Hot Encoding da Variável Canal de Vendas.
SELECT canal_venda,
	   CASE
	   		WHEN canal_venda = 'Amazon' THEN 1
			ELSE 0
	   END AS Amazon,
	   CASE
			WHEN canal_venda = 'Instagram' THEN 1
			ELSE 0
	   END AS Instagram,
	   CASE
			WHEN canal_venda = 'Mercado Livre' THEN 1
			ELSE 0			
	   END AS Mercado_Livre,
	   CASE
			WHEN canal_venda = 'Shopee' THEN 1
			ELSE 0			
	   END AS Shopee,
	   CASE
			WHEN canal_venda = 'Site' THEN 1
			ELSE 0			
	   END AS Site
FROM ecommerce.encoding_ecommerce;


-- Criando uma tabela nova com os dados tranformados.
CREATE TABLE ecommerce.encoding AS 
SELECT CASE
	   		WHEN cidade = 'Belo Horizonte' THEN 1
			WHEN cidade = 'Campinas' THEN 2
			WHEN cidade = 'Curitiba' THEN 3
			WHEN cidade = 'Fortaleza' THEN 4
			WHEN cidade = 'Porto Alegre' THEN 5
			WHEN cidade = 'Recife' THEN 6
			WHEN cidade = 'Salvador' THEN 8
			WHEN cidade = 'Rio de Janeiro' THEN 7
			WHEN cidade = 'São Paulo' THEN 9
			WHEN cidade = 'Vitória' THEN 10
		END AS cidade,
		CASE
	   		WHEN nome_produto = 'Camera' THEN 1
			WHEN nome_produto = 'Celular' THEN 2
			WHEN nome_produto = 'Computador' THEN 3
			WHEN nome_produto = 'Impressora' THEN 4
			WHEN nome_produto = 'Notebook' THEN 5
			WHEN nome_produto = 'Tablet' THEN 6
		END AS produto,
		valor_total_desconto AS valor_total,
		CASE
	   		WHEN metodo_pagamento = 'Crédito' THEN 1
			ELSE 0
	   END AS Crédito,
	   CASE
			WHEN metodo_pagamento = 'Débito' THEN 1
			ELSE 0
	   END AS Débito,
	   CASE
			WHEN metodo_pagamento = 'PIX' THEN 1
			ELSE 0			
	   END AS PIX,
	   quantidade,
	   CASE
	   		WHEN canal_venda = 'Amazon' THEN 1
			ELSE 0
	   END AS Amazon,
	   CASE
			WHEN canal_venda = 'Instagram' THEN 1
			ELSE 0
	   END AS Instagram,
	   CASE
			WHEN canal_venda = 'Mercado Livre' THEN 1
			ELSE 0			
	   END AS Mercado_Livre,
	   CASE
			WHEN canal_venda = 'Shopee' THEN 1
			ELSE 0			
	   END AS Shopee,
	   CASE
			WHEN canal_venda = 'Site' THEN 1
			ELSE 0			
	   END AS Site,
	   feedback_venda AS feedback
FROM ecommerce.encoding_ecommerce;
	   
	   
-- Visualizando a tabela
SELECT * FROM ecommerce.encoding;
	