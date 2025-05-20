erDiagram
      
"dbo.cargo" {
    int ID_Cargo "PK"
          varchar(30) Cargo ""
          
}
"dbo.carrinho" {
    int ID_Carrinho "PK"
          int ID_Produto "FK"
          varchar(35) CodBarras "FK"
          decimal SubTotal ""
          
}
"dbo.login_sistema" {
    smallint ID_Login "PK"
          varchar(35) Nome ""
          varchar(100) Email ""
          varchar(100) Senha ""
          int ID_Cargo "FK"
          int ID_ListaVendas "FK"
          int ID_Permissao "FK"
          
}
"dbo.pagamento" {
    smallint ID_Pagamento "PK"
          varchar(30) Forma_Pagamento ""
          
}
"dbo.produtos" {
    int ID_Produto "PK"
          varchar(40) Nome ""
          varchar(35) Cod_Barras ""
          decimal Preco ""
          
}
"dbo.vendas" {
    int ID_Vendas "PK"
          decimal Subtotal ""
          smallint ID_Pagamento "FK"
          decimal Total ""
          date Data_Venda ""
          int ID_Carrinho "FK"
          int ID_ListaVendas ""
          
}
"dbo.permissao" {
    int ID_Permissao "PK"
          varchar(30) permissao ""
          
}
"dbo.lista_vendas" {
    int ID_ListaVenda "PK"
          int ID_Vendas "FK"
          
}
      "dbo.carrinho" ||--|{ "dbo.produtos": "ID_Produto"
"dbo.carrinho" |o--|{ "dbo.produtos": "Cod_Barras"
"dbo.login_sistema" |o--|{ "dbo.cargo": "ID_Cargo"
"dbo.login_sistema" |o--|{ "dbo.lista_vendas": "ID_ListaVenda"
"dbo.login_sistema" |o--|{ "dbo.permissao": "ID_Permissao"
"dbo.vendas" |o--|{ "dbo.pagamento": "ID_Pagamento"
"dbo.vendas" |o--|{ "dbo.carrinho": "ID_Carrinho"
"dbo.lista_vendas" |o--|{ "dbo.vendas": "ID_Vendas"
