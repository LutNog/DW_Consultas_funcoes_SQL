# Banco de Dados E-Commerce.

Os dados de vendas são fictícios, foram inseridos com procedures utilizando linguagem PLpgSQL, o objetivo é colocar em prática conceitos de linguagem SQL e análise de dados utilizando PostgreSQL.

Alguns comandos SQL utilizados foram: Funções de Agregação, Subquerys, Função Window, Procedures, Views, Trigges, Joins e CTe.

# Etapas

- [x] 1 - Criação de Tabelas.

- [x] 2 - Procedures para inserir dados aleatórios.

- [x] 3 - Exploração dos Dados.

- [ ] 4 - Limpeza e Tratamento dos Dados.

- [x] 5 - Automatização do Banco de Dados.

- [x] 6 - Respondendo Perguntas de Negócio.

- [x] 7 - Encoding dos Dados.


# Modelo Lógico

<img src="https://r2.easyimg.io/n1tpd0ek0/modelo_logico_ecommerce.png"/>

# Dicionário de Dados 

Tabela Clientes
|       CAMPO      |      TIPO    | NULO  | EXTRA  |         COMENTARIOS         |
|------------------|--------------|-------|--------|-----------------------------|
| id_cliente       | INT          | NO    | SERIAL | Primary Key                 |
| cidade           | VARCHAR(100) | NO    |        |                             |
| metodo_pagamento | VARCHAR(100)  | NO   |        | Tipo de pagamento utilizado |

Tabela Produtos
|       CAMPO      |      TIPO    | NULO  | EXTRA  |         COMENTARIOS         |
|------------------|--------------|-------|--------|-----------------------------|
| id_produto       | INT          | NO    | SERIAL | Primary Key                 |
| nome_produto     | VARCHAR(255) | NO    |        |                             |

Tabela Vendas
|       CAMPO      |      TIPO    | NULO  | EXTRA  |         COMENTARIOS         |
|------------------|--------------|-------|--------|-----------------------------|
| id_vendas        | INT          | NO    | SERIAL | Primary Key                 |
| id_cliente       | INT          | NO    |        | Foreign Key                 |
| id_produto       | INT          | NO    |        | Foreign Key                 |
| data_venda       | DATE         | NO    |        |                             |
| valor_venda      | FLOAT(10,2)  | NO    |        |                             |
| desconto         | INT          | NO    |        |desconto realizado na compra |
| quantidade       | INT          | NO    |        |qtde de produtos comprados   |
| canal_venda      | VARCHAR(255) | NO    |        |por onde foi feito a venda   |
| feedback_venda   | INT          | NO    |        |feedback da compra           |

# Perguntas de Negócios

-- Qual total de vendas feita por ano?

-- Quais os produtos vendidos por ano e propocional de vendas?

-- Quais os produtos vendidos por cidade, ano e propocional de vendas?

-- Quantos clientes compram por site e realizam mais de uma compra?

-- Quais produtos foram comprados por meio do mercado livre e tiveram um feedback acima de 4?

-- Qual é o produto top 1 de vendas por cidade?

-- Qual é o top 3 vendas por cidade no ano de 2022?

-- Quais clientes tiveram o feedback abaixo da média?


última atualização 05/03/2024.
