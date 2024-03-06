

-- Procedure para inserir dados aleatórios na tabela Cliente.
CREATE OR REPLACE PROCEDURE ecommerce.inserindo_clientes_aleatorios(num_clientes INT)
LANGUAGE plpgsql
AS $$
DECLARE
	
	-- Variáveis
	i INT;
	metodo_pagamento_aleatorio VARCHAR(100);
	cidade_aleatoria VARCHAR (250);
	
	lista_cidades TEXT[] := ARRAY['São Paulo',
								 'Rio de Janeiro',
								 'Vitória',
								 'Belo Horizonte',
								 'Curitiba',
								 'Salvador',
								 'Fortaleza',
								 'Porto Alegre',
								 'Recife',
								 'Campinas'];
	
	lista_pagamento TEXT[] := ARRAY ['Crédito',
									'Débito',
									'PIX'];
		
BEGIN
	
	-- Loop para inserir clientes aleatórios
	FOR i IN 1..num_clientes LOOP
		-- 
		SELECT INTO cidade_aleatoria
			lista_cidades[trunc(random() * array_upper(lista_cidades, 1)) + 1] AS cidade;
			
		SELECT INTO metodo_pagamento_aleatorio
			lista_pagamento[trunc(random() * array_upper(lista_pagamento, 1)) + 1] AS metodo_pagamento;

		INSERT INTO ecommerce.clientes (cidade, metodo_pagamento) VALUES
			(cidade_aleatoria, metodo_pagamento_aleatorio);
			
	END LOOP;

END;
$$;

-- Executando a procedure
CALL ecommerce.inserindo_clientes_aleatorios(5000);



-- Procedure para inserir dados na tabela Produtos.

CREATE OR REPLACE PROCEDURE ecommerce.produtos()
LANGUAGE plpgsql
AS $$
	   
BEGIN

	INSERT INTO ecommerce.produtos (nome_produto)
	VALUES ('Notebook'),
	       ('Celular'),
		   ('Impressora'),				  
		   ('Computador'),					 
		   ('Camera'),				   
		   ('Tablet');					 
	
END;
$$;

-- Executando a procedure
CALL ecommerce.produtos();



-- Procedure para inserir dados aleatórios na tabela Vendas.
CREATE OR REPLACE PROCEDURE ecommerce.inserindo_vendas_aleatorios()
LANGUAGE plpgsql
AS $$
DECLARE
	
	-- Variáveis
	cliente RECORD;
	produto INT;
	data_venda_aleatoria DATE;
	valor_venda_aleatorio DECIMAL (10,2);
	desconto_aleatorio INT;
	quantidade_aleatorio INT;
	canal_venda_aleatorio VARCHAR (255);
	feedback_venda_aleatorio INT;
	numero_vendas INT;
	
	lista_canal_venda TEXT[] := ARRAY ['Site',
									  'Instagram',
									  'Mercado Livre',
									  'Amazom',
									  'Shopee'];
									  
BEGIN
	-- Loop para inserir clientes aleatórios
	FOR cliente IN SELECT Id_cliente FROM ecommerce.clientes LOOP
		-- Escolhe Ids aleatórios entre 1 e 6
		produto := trunc(random() * 6+1):: INT;
		-- Repete o número de vendas aleatórios entre 1 e 3
		numero_vendas := trunc(random() * 3+1):: INT;
		-- Loop interno
		FOR i IN 1..numero_vendas LOOP
						
			SELECT INTO canal_venda_aleatorio
				lista_canal_venda[trunc(random() * array_upper(lista_canal_venda, 1)) + 1] AS canal_venda;
			-- Insere data aleatórias até 4 anos á frente
			data_venda_aleatoria := '2020-01-01'::DATE + (trunc(random() * (365 * 4))::INT);
			-- Insere valor aleatório entre 800 e 20000
			valor_venda_aleatorio := trunc(random() * 20000 + 800):: DECIMAL;
			-- Insere quantidade aleatória entre 1 e 4
			quantidade_aleatorio := trunc(random() * 4 + 1)::INT;
			-- Insere feedback aleatória entre 1 e 5
			feedback_venda_aleatorio := trunc(random() * 5 + 1)::INT;
			-- Insere desconto aleatória entre 1 e 10
			desconto_aleatorio := trunc(random() * 10 + 1)::INT;
			-- Insere os dados na tabela	
			INSERT INTO ecommerce.vendas (Id_cliente, Id_produto, data_venda, valor_venda, 
											 desconto, quantidade, canal_venda, feedback_venda)
			VALUES (cliente.Id_cliente, produto, data_venda_aleatoria, valor_venda_aleatorio,
					   desconto_aleatorio, quantidade_aleatorio, canal_venda_aleatorio, feedback_venda_aleatorio);
		-- Fim do loop			  
		END LOOP;	  
	END LOOP;
END;
$$;

-- Executando a procedure
CALL ecommerce.inserindo_vendas_aleatorios();



