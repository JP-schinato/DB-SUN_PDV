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