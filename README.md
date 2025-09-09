# SUN PDV - Sistema de Ponto de Venda

Um sistema completo de Ponto de Venda (PDV) desenvolvido para SQL Server, oferecendo funcionalidades robustas para gerenciamento de vendas, produtos, clientes e controle de acesso.

## 📋 Índice

- [Características](#características)
- [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Estrutura das Tabelas](#estrutura-das-tabelas)
- [Funcionalidades](#funcionalidades)
- [Exemplos de Uso](#exemplos-de-uso)
- [Contribuição](#contribuição)

## 🚀 Características

- *Gerenciamento Completo de Vendas*: Controle total do processo de venda desde o carrinho até a finalização
- *Sistema de Permissões*: Controle de acesso baseado em cargos (Administrador, Moderador, Funcionário)
- *Múltiplas Formas de Pagamento*: Suporte para dinheiro, cartões, PIX e vouchers
- *Controle de Estoque*: Gestão de produtos com códigos de barras
- *Gestão de Clientes*: Cadastro completo de pessoas físicas e jurídicas
- *Auditoria*: Rastreamento de vendas e ações dos usuários
- *Pagamentos Múltiplos*: Suporte para divisão de pagamentos em uma única venda

## 🗄 Estrutura do Banco de Dados

O sistema utiliza o banco de dados *SUN_PDVlocal* no SQL Server e é composto por 11 tabelas principais:

### Tabelas Principais

1. *cargo* - Definição de níveis de acesso
2. *permissao* - Status de permissões (Aceito/Negado)
3. *forma_pagamento* - Métodos de pagamento disponíveis
4. *produtos* - Catálogo de produtos
5. *clientes* - Cadastro de clientes
6. *carrinho* - Carrinhos de compras
7. *carrinho_itens* - Itens dos carrinhos
8. *pagamentos* - Registros de pagamentos
9. *vendas* - Transações finalizadas
10. *login_sistema* - Usuários do sistema
11. *venda_pagamentos* - Relacionamento para pagamentos múltiplos

## 💻 Instalação

### Pré-requisitos

- SQL Server 2016 ou superior
- Permissões para criar banco de dados

### Passos de Instalação

1. *Clone ou baixe o arquivo SQL*
   bash
   # Se estiver em um repositório Git
   git clone [url-do-repositorio]
   

2. *Execute o script no SQL Server*
   sql
   -- Conecte-se ao SQL Server e execute o arquivo sun_pdv.sql
   -- O script criará automaticamente:
   -- - O banco de dados SUN_PDVlocal
   -- - Todas as tabelas necessárias
   -- - Dados iniciais (cargos, permissões, formas de pagamento)
   -- - Produtos de exemplo
   

3. *Verificação da Instalação*
   sql
   USE SUN_PDVlocal;
   SELECT COUNT(*) as TotalTabelas 
   FROM INFORMATION_SCHEMA.TABLES 
   WHERE TABLE_TYPE = 'BASE TABLE';
   -- Deve retornar 11 tabelas
   

## ⚙ Configuração

### Dados Iniciais Incluídos

*Cargos Pré-definidos:*
- Administrador (ID: 1)
- Moderador (ID: 2)  
- Funcionário (ID: 3)

*Permissões:*
- Aceito (ID: 1)
- Negado (ID: 2)

*Formas de Pagamento:*
- Dinheiro (ID: 1)
- Cartão de Débito (ID: 2)
- Cartão de Crédito (ID: 3)
- PIX (ID: 4)
- Voucher (ID: 5)

*Produtos de Exemplo:*
- Café Pilão 500g - R$ 15,50
- Feijão Carioca 1kg - R$ 8,90
- Leite Integral 1L - R$ 4,50
- Açúcar Cristal 1kg - R$ 4,25
- Bolacha Maria - R$ 3,90
- Cetoprofeno 50mg - R$ 12,99

## 📊 Estrutura das Tabelas

### Tabela: produtos
sql
- ID_Produto (INT, PK, IDENTITY)
- Nome (VARCHAR(55), NOT NULL)
- Cod_Barras (VARCHAR(35), UNIQUE)
- Preco (DECIMAL(10,2), CHECK >= 0)
- Ativo (BIT, DEFAULT 1)
- Data_Cadastro (DATETIME, DEFAULT GETDATE())


### Tabela: clientes
sql
- ID_Clientes (INT, PK, IDENTITY)
- Nome (VARCHAR(100))
- CPF (VARCHAR(14)) -- Formato: 000.000.000-00
- CNPJ (VARCHAR(18)) -- Formato: 00.000.000/0000-00
- RG (VARCHAR(15))
- Email (VARCHAR(100))
- Telefone (VARCHAR(15))
- Endereco (VARCHAR(200))
- Data_Cadastro (DATETIME, DEFAULT GETDATE())


### Tabela: vendas
sql
- ID_Vendas (INT, PK, IDENTITY)
- ID_Carrinho (INT, FK)
- ID_Clientes (INT, FK, NULLABLE)
- ID_Pagamentos (INT, FK)
- Subtotal (DECIMAL(10,2))
- Desconto (DECIMAL(10,2), DEFAULT 0.00)
- Total (DECIMAL(10,2))
- Data_Venda (DATETIME, DEFAULT GETDATE())
- ID_Login (SMALLINT, FK)
- Status (VARCHAR(20), DEFAULT 'Concluida')


## 🛍 Funcionalidades

### Gestão de Vendas
- Criação e gerenciamento de carrinhos
- Adição/remoção de produtos
- Cálculo automático de subtotais
- Aplicação de descontos
- Finalização com múltiplas formas de pagamento

### Controle de Acesso
- Sistema de login com diferentes níveis de permissão
- Rastreamento de últimos acessos
- Controle de usuários ativos/inativos

### Gestão de Produtos
- Cadastro com código de barras único
- Controle de preços
- Status ativo/inativo
- Histórico de cadastros

### Relatórios e Auditoria
- Histórico completo de vendas
- Rastreamento por funcionário
- Controle de formas de pagamento utilizadas

## 💡 Exemplos de Uso

### Criar um Usuário Administrador
sql
INSERT INTO login_sistema (Nome, Email, Senha, ID_Cargo, ID_Permissao) 
VALUES ('Admin Sistema', 'admin@sunpdv.com', 'senha_hash_aqui', 1, 1);


### Registrar uma Venda Simples
sql
-- 1. Criar carrinho
INSERT INTO carrinho DEFAULT VALUES;
DECLARE @CarrinhoID INT = SCOPE_IDENTITY();

-- 2. Adicionar produtos ao carrinho
INSERT INTO carrinho_itens (ID_Carrinho, ID_Produto, Quantidade, Preco_Unitario)
VALUES (@CarrinhoID, 1, 2, 15.50); -- 2x Café Pilão

-- 3. Registrar pagamento
INSERT INTO pagamentos (ID_Forma_Pagamento, Valor_Recebido, Troco)
VALUES (1, 35.00, 4.00); -- Dinheiro: R$ 35 recebido, R$ 4 de troco
DECLARE @PagamentoID INT = SCOPE_IDENTITY();

-- 4. Finalizar venda
INSERT INTO vendas (ID_Carrinho, ID_Pagamentos, Subtotal, Total, ID_Login)
VALUES (@CarrinhoID, @PagamentoID, 31.00, 31.00, 1);


### Consultar Vendas por Período
sql
SELECT 
    v.ID_Vendas,
    v.Data_Venda,
    c.Nome as Cliente,
    v.Total,
    fp.Forma_Pagamento,
    ls.Nome as Vendedor
FROM vendas v
LEFT JOIN clientes c ON v.ID_Clientes = c.ID_Clientes
LEFT JOIN pagamentos p ON v.ID_Pagamentos = p.ID_Pagamentos
LEFT JOIN forma_pagamento fp ON p.ID_Forma_Pagamento = fp.ID_Forma_Pagamento
LEFT JOIN login_sistema ls ON v.ID_Login = ls.ID_Login
WHERE v.Data_Venda >= '2024-01-01' AND v.Data_Venda < '2024-02-01'
ORDER BY v.Data_Venda DESC;


## 🔧 Manutenção

### Backup Recomendado
sql
BACKUP DATABASE SUN_PDVlocal 
TO DISK = 'C:\Backup\SUN_PDVlocal_backup.bak'
WITH FORMAT, INIT;


### Limpeza de Dados Antigos (Cuidado!)
sql
-- Exemplo: Remover carrinhos cancelados com mais de 30 dias
DELETE FROM carrinho 
WHERE Status = 'Cancelado' 
AND Data_Criacao < DATEADD(DAY, -30, GETDATE());


## 📝 Notas Importantes

- *Senhas*: Sempre armazene senhas como hash, nunca em texto plano
- *Backup*: Implemente rotina regular de backup
- *Índices*: Considere adicionar índices em colunas frequentemente consultadas
- *Validações*: O sistema possui validações básicas, mas considere implementar validações adicionais na aplicação

## Schema do DB

<p align="center">
  <img src="https://github.com/JP-schinato/DB-TCC-SUN_PDV/raw/main/Diagrama/schema.png" width="600" />
</p>

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE) - veja o arquivo LICENSE para detalhes.

---

*SUN PDV* - Sistema robusto e confiável para seu negócio 🌟
