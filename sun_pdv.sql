-- Banco de dados do PDV versão SQLserver --
-- SUN PDV - VERSÃO CORRIGIDA --

-- Criando banco de dados --
CREATE DATABASE SUN_PDVlocal;

-- usando o DB --
USE SUN_PDVlocal;

-- 1. Criando a tabela cargos --
CREATE TABLE cargo (
    ID_Cargo INT PRIMARY KEY IDENTITY(1,1),
    Cargo VARCHAR(30) NOT NULL
);

-- Despejando dados na tabela de cargos --
INSERT INTO cargo (Cargo) VALUES
('Administrador'),
('Moderador'),
('Funcionario');

-- 2. Criando a tabela permissao --
CREATE TABLE permissao (
    ID_Permissao INT PRIMARY KEY IDENTITY(1,1),
    permissao VARCHAR(30) NOT NULL
);

-- Despejando dados na tabela permissão --
INSERT INTO permissao (permissao) VALUES 
('Aceito'), 
('Negado');

-- 3. Estrutura da tabela forma_pagamento --
CREATE TABLE forma_pagamento (
    ID_Forma_Pagamento SMALLINT PRIMARY KEY NOT NULL,
    Forma_Pagamento VARCHAR(30) NOT NULL,
);

-- Despejando os dados das formas de pagamento --
INSERT INTO forma_pagamento (ID_Forma_Pagamento, Forma_Pagamento) VALUES 
(1, 'Dinheiro'),
(2, 'Débito'),
(3, 'Crédito'),
(4, 'Pix'),
(5, 'Voucher');

-- 4. Estrutura para a tabela produtos --
CREATE TABLE produtos (
    ID_Produto INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(55) NOT NULL,
    Cod_Barras VARCHAR(35) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL CHECK (Preco >= 0),
    Ativo BIT DEFAULT 1, -- Para controle de produtos ativos/inativos
    Data_Cadastro DATETIME DEFAULT GETDATE()
);

-- 5. Adicionando a tabela de clientes --
CREATE TABLE clientes (
    ID_Clientes INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100),
    CPF VARCHAR(14), -- Formato: 000.000.000-00
    CNPJ VARCHAR(18), -- Formato: 00.000.000/0000-00
    RG VARCHAR(15),
    Email VARCHAR(100),
    Telefone VARCHAR(15),
    Endereco VARCHAR(200),
    Data_Cadastro DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_CPF_OR_CNPJ CHECK (CPF IS NOT NULL OR CNPJ IS NOT NULL)
);

-- 6. Criar tabela carrinho --
CREATE TABLE carrinho (
    ID_Carrinho INT PRIMARY KEY IDENTITY(1,1),
    Data_Criacao DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Ativo' -- Ativo, Finalizado, Cancelado
);

-- 7. Criar tabela carrinho_itens --
CREATE TABLE carrinho_itens (
    ID_Carrinho_Itens INT PRIMARY KEY IDENTITY(1,1),
    ID_Carrinho INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    Preco_Unitario DECIMAL(10,2) NOT NULL CHECK (Preco_Unitario >= 0),
    Subtotal AS (Quantidade * Preco_Unitario) PERSISTED, -- Campo calculado
    CONSTRAINT FK_carrinho_itens_carrinho 
        FOREIGN KEY (ID_Carrinho) REFERENCES carrinho(ID_Carrinho),
    CONSTRAINT FK_carrinho_itens_produtos 
        FOREIGN KEY (ID_Produto) REFERENCES produtos(ID_Produto)
);

-- 8. Estrutura da tabela pagamentos --
CREATE TABLE pagamentos (
    ID_Pagamentos INT PRIMARY KEY IDENTITY(1,1),
    ID_Forma_Pagamento SMALLINT NOT NULL,
    Valor_Recebido DECIMAL(10,2) NOT NULL CHECK (Valor_Recebido >= 0),
    Troco DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (Troco >= 0),
    Data_Pagamento DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_pagamentos_forma_pagamento
        FOREIGN KEY (ID_Forma_Pagamento) REFERENCES forma_pagamento (ID_Forma_Pagamento)
);

-- 9. Estrutura da tabela vendas --
CREATE TABLE vendas (
    ID_Vendas INT PRIMARY KEY IDENTITY(1,1),
    ID_Carrinho INT NOT NULL,
    ID_Clientes INT NULL, -- Cliente pode ser opcional
    ID_Pagamentos INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    Desconto DECIMAL(10,2) DEFAULT 0.00 CHECK (Desconto >= 0),
    Total DECIMAL(10,2) NOT NULL CHECK (Total >= 0),
    Data_Venda DATETIME DEFAULT GETDATE(),
    ID_Login SMALLINT NOT NULL, -- Usuario que realizou a venda
    Status VARCHAR(20) DEFAULT 'Concluida', -- Concluida, Cancelada
    CONSTRAINT FK_vendas_carrinho
        FOREIGN KEY (ID_Carrinho) REFERENCES carrinho (ID_Carrinho),
    CONSTRAINT FK_vendas_clientes
        FOREIGN KEY (ID_Clientes) REFERENCES clientes (ID_Clientes),
    CONSTRAINT FK_vendas_pagamentos
        FOREIGN KEY (ID_Pagamentos) REFERENCES pagamentos (ID_Pagamentos)
);

-- 10. Estrutura da tabela login_sistema (corrigida) --
CREATE TABLE login_sistema (
    ID_Login SMALLINT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(35) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Senha VARCHAR(100) NOT NULL, -- Deve ser hash da senha
    ID_Cargo INT NOT NULL,
    ID_Permissao INT NOT NULL,
    Ativo BIT DEFAULT 1,
    Data_Cadastro DATETIME DEFAULT GETDATE(),
    Ultimo_Login DATETIME NULL,
    CONSTRAINT FK_login_cargo
        FOREIGN KEY (ID_Cargo) REFERENCES cargo (ID_Cargo),
    CONSTRAINT FK_login_permissao
        FOREIGN KEY (ID_Permissao) REFERENCES permissao (ID_Permissao)
);

-- Adicionando FK da tabela vendas para login_sistema --
ALTER TABLE vendas
ADD CONSTRAINT FK_vendas_login
FOREIGN KEY (ID_Login) REFERENCES login_sistema (ID_Login);

-- DADOS DE EXEMPLO --

-- Inserindo produtos --
INSERT INTO produtos (Nome, Cod_Barras, Preco) VALUES
('Café Pilão 500g', '789738277382', 15.50),
('Feijão Carioca 1kg', '4545155454', 8.90),
('Leite Integral 1L', '54646464', 4.50),
('Açúcar Cristal 1kg', '20', 4.25),
('Bolacha Maria', '656565654', 3.90),
('Cetoprofeno 50mg', '7891317001926', 12.99);

-- 1. Criar tabela para relacionar vendas com múltiplos pagamentos
CREATE TABLE venda_pagamentos (
    ID_Venda_Pagamento INT PRIMARY KEY IDENTITY(1,1),
    ID_Venda INT NOT NULL,
    ID_Pagamento INT NOT NULL,
    CONSTRAINT FK_venda_pagamentos_venda 
        FOREIGN KEY (ID_Venda) REFERENCES vendas(ID_Vendas),
    CONSTRAINT FK_venda_pagamentos_pagamento 
        FOREIGN KEY (ID_Pagamento) REFERENCES pagamentos(ID_Pagamentos)
);

-- 2. Migrar dados existentes para a nova estrutura
INSERT INTO venda_pagamentos (ID_Venda, ID_Pagamento)
SELECT ID_Vendas, ID_Pagamentos 
FROM vendas 
WHERE ID_Pagamentos IS NOT NULL;

-- 3. Atualizar nomes das formas de pagamento
UPDATE forma_pagamento SET Forma_Pagamento = 'Cartão de Débito' WHERE Forma_Pagamento = 'Débito';
UPDATE forma_pagamento SET Forma_Pagamento = 'Cartão de Crédito' WHERE Forma_Pagamento = 'Crédito';

ALTER TABLE produtos
ADD Ativo BIT DEFAULT 1 NOT NULL;

SELECT * FROM cargo
