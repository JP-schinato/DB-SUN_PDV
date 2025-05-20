-- Banco de dados do PDV versão SQLserver --

-- SUN PDV --

-- Criando banco de dados --

CREATE DATABASE SUN_PDVlocal;

-- usando o DB --

USE SUN_PDVlocal;

-- Criando a tabela cargos --

CREATE TABLE cargo (
	ID_Cargo INT PRIMARY KEY IDENTITY(1,1),
	Cargo VARCHAR(30) DEFAULT NULL
	)

-- Despejando dados na tabela de cargos --
	
INSERT cargo (Cargo) VALUES
('Administrador'),
('Moderador'),
('Funcionario')

-- Verificando valores --

SELECT * FROM cargo

-- Criando a tabela carrinho --

CREATE TABLE carrinho (
	ID_Carrinho INT PRIMARY KEY IDENTITY(1,1),
	ID_Produto INT NOT NULL,
	CodBarras VARCHAR(35) DEFAULT NULL,
	SubTotal DECIMAL(10, 2) DEFAULT NULL  -- 10 dígitos no total, 2 depois da vígula / Preço em BRL --
);

-- Estrutura da tabela login_sistema --

CREATE TABLE login_sistema (
	ID_Login SMALLINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	Nome VARCHAR(35) DEFAULT NULL,
	Email VARCHAR(100) DEFAULT NULL,
	Senha VARCHAR(100) NOT NULL,
	ID_Cargo INT DEFAULT NULL,
	ID_ListaVendas INT DEFAULT NULL
)


-- Visualizando os dados da tabela login_sistema --

SELECT * FROM login_sistema

-- Estrutura da tabela pagamento --

CREATE TABLE pagamento (
	ID_Pagamento SMALLINT PRIMARY KEY NOT NULL,
	Forma_Pagamento VARCHAR(30) DEFAULT NULL
)

-- Despejando os dados das formas de pagamento na tabela pagamento --

INSERT INTO pagamento (ID_Pagamento, Forma_Pagamento) VALUES 
(1, 'Dinheiro'),
(2, 'Débito'),
(3, 'Crédito'),
(4, 'Pix'),
(5, 'Voucher')

-- Visualizando dados da tabela pagamento --

SELECT * FROM pagamento

--	Estrutura para a tabela produtos --

CREATE TABLE produtos (
	ID_Produto INT PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(40) NOT NULL,
	Cod_Barras VARCHAR(35) UNIQUE NOT NULL,
	Preco DECIMAL(10,2) NOT NULL -- Preço em BRL
)


-- Despejando dados na tabela produto --

INSERT INTO produtos (Nome, Cod_Barras, Preco) VALUES
('cafe', '789738277382', 50),
('feijao', '4545155454', 60.98),
('leite', '54646464', 1),
('leite', '20', 45),
('bolacha', '656565654', 49.9),
('cetoprofeno', '7891317001926', 1.99);

-- Visualizando dados da tabela produtos --

SELECT * FROM produtos

-- Estrutura da tabela vendas --

CREATE TABLE vendas (
	ID_Vendas INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	Subtotal DECIMAL(10,2) NOT NULL, -- Subtotal de Venda em BRL --
	ID_Pagamento SMALLINT DEFAULT NULL,
	Total DECIMAL(10,2) NOT NULL,
	Data_Venda DATE DEFAULT NULL,
	ID_Carrinho INT DEFAULT NULL,
	ID_ListaVendas INT DEFAULT NULL
)

--  Restrições para tabelas desejadas


-- Restrições para a tabela carrinho --

ALTER TABLE carrinho
	ADD CONSTRAINT FK_tabela_carrinho_produtos_CodBarras
	FOREIGN KEY (CodBarras) REFERENCES produtos (Cod_Barras)

ALTER TABLE carrinho
	ADD CONSTRAINT FK_tabela_carrinho_produtos_ID 
	FOREIGN KEY (ID_Produto) REFERENCES produtos (ID_Produto)

-- Restrições para a tabela login sistema --

ALTER TABLE login_sistema
	ADD CONSTRAINT FK_Login_e_Cargo
	FOREIGN KEY (ID_Cargo) REFERENCES cargo (ID_Cargo)

-- Restrições da tabela vendas --

ALTER TABLE vendas
	ADD CONSTRAINT FK_vendas_e_carrinho 
	FOREIGN KEY (ID_Carrinho) REFERENCES carrinho (ID_Carrinho)

ALTER TABLE vendas
	ADD CONSTRAINT FK_vendas_e_pagamento
	FOREIGN KEY (ID_Pagamento) REFERENCES pagamento (ID_Pagamento)

---------------------
-- Correções no DB --
---------------------

-- Criando uma nova coluna para a permissão na tabela de login e user --

ALTER TABLE login_sistema
	ADD ID_Permissao INT DEFAULT NULL

--  Criando a tabela permissão juntamente com as FK --

CREATE TABLE permissao (
	ID_Permissao INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	permissao VARCHAR(30)
)

-- Despejando dados na tabela permissão --

INSERT INTO permissao (permissao)
VALUES ('Aceito'), ('Negado')

-- Visualizando dados da tabela permissão --

SELECT * FROM permissao

-- Adicionando novas restrições em relação com a tabela permissão em user e login --

ALTER TABLE login_sistema
	ADD CONSTRAINT FK_Login_e_Permissao
	FOREIGN KEY (ID_Permissao) REFERENCES permissao (ID_Permissao)

----------------------------------------------------------
-- Adicinonando lista de vendas relacionada a cada User --


CREATE TABLE lista_vendas (
	ID_ListaVenda INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ID_Vendas INT DEFAULT NULL
)

-- Adicionando restrições entre user, vendas e lista de vendas --

ALTER TABLE login_sistema
	ADD CONSTRAINT FK_Login_e_ListaVenda
	FOREIGN KEY (ID_ListaVendas) REFERENCES lista_vendas (ID_ListaVenda)

ALTER TABLE lista_vendas
	ADD CONSTRAINT FK_Lista_e_Vendas
	FOREIGN KEY (ID_Vendas) REFERENCES vendas (ID_Vendas)