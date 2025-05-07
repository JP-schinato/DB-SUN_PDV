-- Banco de dados do PDV versão SQLserver --

-- SUN PDV --

-- Criando banco de dados --

CREATE DATABASE SUN_PDV;

-- usando o DB --

USE SUN_PDV;

-- Criando a tabela cargos --

CREATE TABLE cargo (
	ID_Cargo INT PRIMARY KEY IDENTITY(1,1),
	Cargo TEXT DEFAULT NULL
	)

-- Despejando dados na tabela de cargos --
	
INSERT cargo (Cargo) VALUES
('CargoADM'),
('CargoMOD'),
('CargoFUN')

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
	Senha VARCHAR(20) NOT NULL,
	ID_Cargo INT DEFAULT NULL
)

-- Despejando dados testes para a tabela login_sistema --

INSERT INTO login_sistema(Nome, Email, Senha, ID_Cargo) VALUES 
('João Mendes', 'jpmendes@gmail.com', '1234', 1),
('João Schinato', 'jpschinato@gmail.com', '1234', 2),
('Toshi', 'toshi@gmail.com', '1234', 3);

-- Visualizando os dados da tabela login_sistema --

SELECT * FROM login_sistema

-- Estrutura da tabela pagamento --

CREATE TABLE pagamento (
	ID_Pagamento SMALLINT PRIMARY KEY NOT NULL,
	Forma_Pagamento TEXT DEFAULT NULL
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

-- Estrutura da tabela user_sistema --

CREATE TABLE user_sistema (
	ID_User SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ID_Cargo INT DEFAULT NULL,
	ID_Login SMALLINT DEFAULT NULL,
	ID_Venda INT DEFAULT NULL,
	ID_Produto INT DEFAULT NULL
)

-- Despejando dados da tabela user_sistema --

INSERT INTO user_sistema (ID_Cargo, ID_Login, ID_Venda, ID_Produto) VALUES
(1 , 1, NULL, NULL),
(2 , 2, NULL, NULL),
(3 , 3, NULL, NULL)

-- Visualizando dados da tabela user_sistema ==

SELECT * FROM user_sistema

-- Estrutura da tabela vendas --

CREATE TABLE vendas (
	ID_Vendas INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	Subtotal DECIMAL(10,2) NOT NULL, -- Subtotal de Venda em BRL --
	ID_Pagamento INT DEFAULT NULL,
	Total DECIMAL(10,2) NOT NULL,
	Data_Venda DATE DEFAULT NULL,
	ID_Carrinho INT DEFAULT NULL

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

-- Restrições para a tabela user sistema --

ALTER TABLE user_sistema
	ADD CONSTRAINT FK_user_e_login_sistema
	FOREIGN KEY (ID_Login) REFERENCES login_sistema (ID_Login)

ALTER TABLE user_sistema 
	ADD CONSTRAINT FK_user_e_vendas 
	FOREIGN KEY (ID_Venda) REFERENCES vendas (ID_Vendas)

ALTER TABLE user_sistema 
	ADD CONSTRAINT FK_user_e_produtos 
	FOREIGN KEY (ID_Produto) REFERENCES produtos (ID_Produto)

-- Restrições da tabela vendas --

ALTER TABLE vendas
	ADD CONSTRAINT FK_vendas_e_carrinho 
	FOREIGN KEY (ID_Carrinho) REFERENCES carrinho (ID_Carrinho)

ALTER TABLE vendas
	ADD CONSTRAINT FK_vendas_e_pagamento
	FOREIGN KEY (ID_Pagamento) REFERENCES pagamento (ID_Pagamento)

