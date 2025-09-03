-- Banco de dados do PDV versão SQLserver
-- SUN PDV

-- Criando banco de dados
CREATE DATABASE SUN_PDVlocal;
USE SUN_PDVlocal;

-- ======================================
-- Tabela cargos
-- ======================================
CREATE TABLE cargo (
    ID_Cargo INT PRIMARY KEY IDENTITY(1,1),
    Cargo VARCHAR(30) DEFAULT NULL
);

INSERT INTO cargo (Cargo) VALUES
('Administrador'),
('Moderador'),
('Funcionario');

-- ======================================
-- Tabela login_sistema
-- ======================================
CREATE TABLE login_sistema (
    ID_Login SMALLINT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Nome VARCHAR(35) DEFAULT NULL,
    Email VARCHAR(100) DEFAULT NULL,
    Senha VARCHAR(100) NOT NULL,
    ID_Cargo INT DEFAULT NULL,
    ID_ListaVendas INT DEFAULT NULL,
    ID_Vendas INT DEFAULT NULL,
    ID_Permissao INT DEFAULT NULL
);

-- ======================================
-- Tabela forma_pagamento
-- ======================================
CREATE TABLE forma_pagamento (
    ID_Forma_Pagamento SMALLINT PRIMARY KEY NOT NULL,
    Forma_Pagamento VARCHAR(30) DEFAULT NULL,
    Taxa DECIMAL(5,2) DEFAULT NULL
);

INSERT INTO forma_pagamento (ID_Forma_Pagamento, Forma_Pagamento) VALUES 
(1, 'Dinheiro'),
(2, 'Débito'),
(3, 'Crédito'),
(4, 'Pix'),
(5, 'Voucher');

-- ======================================
-- Tabela produtos
-- ======================================
CREATE TABLE produtos (
    ID_Produto INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(55) NOT NULL,
    Cod_Barras VARCHAR(35) UNIQUE NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);

INSERT INTO produtos (Nome, Cod_Barras, Preco) VALUES
('cafe', '789738277382', 50),
('feijao', '4545155454', 60.98),
('leite', '54646464', 1),
('leite', '20', 45),
('bolacha', '656565654', 49.9),
('cetoprofeno', '7891317001926', 1.99);

-- ======================================
-- Tabela vendas
-- ======================================
CREATE TABLE vendas (
    ID_Vendas INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Subtotal DECIMAL(10,2) NOT NULL,
    ID_Pagamentos INT DEFAULT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Data_Venda DATETIME DEFAULT GETDATE(),
    ID_Carrinho INT DEFAULT NULL,
    ID_Clientes INT DEFAULT NULL,
    ID_Login SMALLINT DEFAULT NULL
);

-- ======================================
-- Tabela pagamentos
-- ======================================
CREATE TABLE pagamentos (
    ID_Pagamentos INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    ID_Forma_Pagamento SMALLINT DEFAULT NULL,
    Troco DECIMAL(10,2) NOT NULL,
    Valor_Recebido DECIMAL(10,2)
);

-- ======================================
-- Tabela permissao
-- ======================================
CREATE TABLE permissao (
    ID_Permissao INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    permissao VARCHAR(30)
);

INSERT INTO permissao (permissao) VALUES ('Aceito'), ('Negado');

-- ======================================
-- Tabela clientes
-- ======================================
CREATE TABLE clientes (
    ID_Clientes INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    cpf VARCHAR(20),
    cnpj VARCHAR(20),
    rg VARCHAR(20)
);

-- ======================================
-- Tabela carrinho
-- ======================================
CREATE TABLE carrinho (
    ID_Carrinho INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Data_Criacao DATETIME
);

-- ======================================
-- Tabela carrinho_itens
-- ======================================
CREATE TABLE carrinho_itens (
    ID_Carrinho_itens INT PRIMARY KEY IDENTITY(1,1),
    ID_Carrinho INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_carrinho_itens_carrinho FOREIGN KEY (ID_Carrinho) REFERENCES carrinho(ID_Carrinho),
    CONSTRAINT FK_carrinho_itens_produtos FOREIGN KEY (ID_Produto) REFERENCES produtos(ID_Produto)
);

-- ======================================
-- Tabela venda_pagamentos
-- ======================================
CREATE TABLE venda_pagamentos (
    ID_Venda INT NOT NULL,
    ID_Pagamento INT NOT NULL,
    PRIMARY KEY (ID_Venda, ID_Pagamento),
    CONSTRAINT FK_venda_pagamentos_venda FOREIGN KEY (ID_Venda) REFERENCES vendas(ID_Vendas),
    CONSTRAINT FK_venda_pagamentos_pagamento FOREIGN KEY (ID_Pagamento) REFERENCES pagamentos(ID_Pagamentos)
);

-- ======================================
-- Relações e chaves estrangeiras
-- ======================================
ALTER TABLE login_sistema
    ADD CONSTRAINT FK_Login_e_Cargo FOREIGN KEY (ID_Cargo) REFERENCES cargo(ID_Cargo);

ALTER TABLE login_sistema
    ADD CONSTRAINT FK_Login_Vendas FOREIGN KEY (ID_Vendas) REFERENCES vendas(ID_Vendas);

ALTER TABLE login_sistema
    ADD CONSTRAINT FK_Login_e_Permissao FOREIGN KEY (ID_Permissao) REFERENCES permissao(ID_Permissao);

ALTER TABLE vendas
    ADD CONSTRAINT FK_vendas_e_pagamento FOREIGN KEY (ID_Pagamentos) REFERENCES pagamentos(ID_Pagamentos);

ALTER TABLE vendas
    ADD CONSTRAINT FK_vendas_e_carrinho FOREIGN KEY (ID_Carrinho) REFERENCES carrinho(ID_Carrinho);

ALTER TABLE vendas
    ADD CONSTRAINT FK_clientes_e_vendas FOREIGN KEY (ID_Clientes) REFERENCES clientes(ID_Clientes);

ALTER TABLE pagamentos
    ADD CONSTRAINT FK_pagamento_e_forma_pagamento FOREIGN KEY (ID_Forma_Pagamento) REFERENCES forma_pagamento(ID_Forma_Pagamento);

-- ======================================
-- Dados adicionais de produtos (exemplo completo)
-- ======================================
INSERT INTO produtos (Nome, Cod_Barras, Preco) VALUES
('Duna: livro 3 - Frank Herbert', '3', 78.56),
('Ascensão - Stephen King', '4', 40.01),
('A maldição - Stephen King', '5', 54.04),
('A hora do lobisomem - Stephen King', '6', 67.31), 
('Misery - Stephen King', '7', 62.68),
('O instituto - Stephen King', '8', 71.22),
('Creepshow - Stephen King', '9', 34.68),
('Outsider - Stephen King', '10', 69.57);
-- (adicione os demais produtos conforme seu script original)
