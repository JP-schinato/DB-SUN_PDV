# DB-TCC-SUN_PDV

Aqui irei trabalhar no DB do meu TCC relacionado a um PDV.
<br><br>

A Base de Dados foi criada com o intuito de estar atendendo todo o sistema juntamente com o site tendo uma lógica para proporcionar o Cadastro e criação de novos usuários pelo site e fazer o login pelo próprio sistema, onde trabalha com registros de vendas, usuários e produtos.

O banco de dados ele é relacional e em nuvem sendo assim uma maneira segura e melhor.

Ferramentas usadas:

SQLserver | Azure DataStudio | Azure

Lógica:

A lógica consiste em 7 tabelas sendo elas:

    Tabela Cargo:
    Tendo em si duas colunas com ID e outra para definição do cargo.
    Definindo para o Usuário três Operadores para estar atuando dentro do sistema com cada um tendo poderes ou limitações.
    
    Sendo eles os cargos:
    
        Administrador: Podendo fazer de tudo dentro do sitema podendo até gerenciar os usuários.
        Moderador: Podendo fazer cadastro de produtos e vendas mas não tem permissão de gerenciar os usuários.
        Funcionario: Podendo fazer somente vendas dentro do sistema.

    Tabela Carrinho:
    Tendo em si quatro colunas onde seram armazenadas a soma de todos os produtos presentes na venda e dizer o valor do SubTotal em BRL.

    Tabela Login_Sistema:
    Tendo em si seis colunas onde seram armazenados os cadastros de usuarios feitos pelo site e direcionados para o sistema definindo seu cargo e inicialmente a sua permissão aceita no sistema.

    Tabela Pagamento:
    Tendo em si duas colunas onde seram armazenados os dados referente aos meios de pagamento, para poder estar definindo qual o meio de pagamento usado em cada venda do sistema.

    Sendo as formas de pagamento:

        Dinheiro
        Débito
        Crédito
        Pix
        Voucher


    Tabela Permissão:
    Tendo em si duas colunas, onde serão armazenados os dados referentes as permissões do usuário para estar tendo acesso ao sistema.

    Sendo as Permissões:

        Aceito
        Negado

    Tabela produtos:
    Tendo em si quatro colunas, onde serão armazenados os registros de produtos para serem registrados no carrinho e somar o valor de uma venda.

    Nessa tabela poderemos estar definindo:

        Nome do produto
        Código de Barras do produto
        Preço do produto

    Tabela Vendas:
    Tendo em si seis tabelas, onde serão armazenados os dados de cada venda.

    Dados armazenados na venda:

        Subtotal das vendas: como primeiro valor se caso o cliente venha a desejar estar efetuandoa compra com dois meios de pagamento.
        Pagamento: define a forma de pagamento ultilizado na venda.
        Total: valor total da venda idependente se foi pago de duas formas.
        Data: Define a data da venda.
        Carrinho: Busca a lista de produtos registrados na venda.

<p align="center">
  <img src="https://github.com/JP-schinato/DB-TCC-SUN_PDV/raw/main/Diagrama/schema2.png" width="600" />
</p>