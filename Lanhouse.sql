create database lanhouse; 
use lanhouse;  

create table Endereco(
	idEndereco int primary key not null auto_increment, 
    UF varchar(2) not null,
    cidade varchar(45) not null,
    bairro varchar(45) not null,
    rua varchar(45) not null,
	numero int not null, 
    comp varchar(45),
    cep varchar(9) not null,
    Empregado_CPF varchar(14) not null,
	foreign key (Empregado_CPF) references Empregado(cpf)
);

/*drop table Endereco;*/

create table Empregado(
	cpf varchar(14) primary key not null,
    nome varchar(45) not null,
    nomeSocial varchar(45),
    sexo char(1) not null,
	salario decimal(6,2) not null,
    email varchar(45) not null,
    telefone varchar(11) not null,
    dataNasc date not null,
    dataAdmissao datetime not null,
    dataDemissao datetime,
    statusEmp boolean not null

);  

create table Ferias(
	idFerias int primary key not null auto_increment,
    anoReferente YEAR not null,
    qtdDias int not null,
    dataInicio date not null,
    dataFim date not null,
    Empregado_Ferias varchar(14) not null,
	foreign key (Empregado_Ferias) references Empregado(cpf)
);

create table Cliente(
	idCliente int not null primary key auto_increment,
    nome varchar(45) not null,
    email varchar(45) not null,
    senha varchar(45),
    sexo char(1) not null,
    dataNasc date not null,
    telefone varchar(11) not null
);

create table Vendas(
	idVendas int not null primary key auto_increment,
    dataVenda datetime not null,
    valorTotal decimal(6,2) not null,
    desconto decimal(4,2),
    Cliente_idCliente int not null,
    Empregado_Vendas varchar(14) not null,
    foreign key (Cliente_idCliente) references Cliente(idCliente),
    foreign key (Empregado_Vendas) references Empregado(cpf)
);

create table FormaPag(
	idFormaPag int not null primary key auto_increment,
    tipoPag varchar(45) not null,
    valorPag decimal(6,2) not null,
    dataPag datetime not null,
    Vendas_idVendas int not null,
    foreign key (Vendas_idVendas) references Vendas(idVendas)
);

create table Estoque(
	idProduto int not null primary key auto_increment,
    nome varchar(45) not null,
    valor decimal(6,2) not null,
    quantidade int not null,
    categoria varchar(45) not null,
    descricao varchar(150),
    validade date,
    marca varchar(45)
);

create table Servico(
	idServico int not null primary key auto_increment,
    nome varchar(45) not null,
    valor decimal(5,2) not null
);

create table Fornecedor(
	cnpjCpf int not null primary key auto_increment,
    nome varchar(45) not null,
    telefone varchar(11) not null,
    email varchar(45) not null
);

create table VendasServico(
	Vendas_idVendas int not null,
    Servico_idServico int not null,
    quantidade int not null,  
    primary key(Vendas_idVendas, Servico_idServico),
    foreign key (Vendas_idVendas) references Vendas(idVendas),
    foreign key (Servico_idServico) references Servico(idServico)
);

create table ItensVendas(
	Estoque_idProduto int not null,
    Vendas_idVendas int not null,
    quantidade int not null,  
    primary key(Estoque_idProduto, Vendas_idVendas),
    foreign key (Estoque_idProduto) references Estoque(idProduto),
    foreign key (Vendas_idVendas) references Vendas(idVendas)
);

create table EstoqueFornecedor(
	Estoque_idProduto int not null,
    Fornecedor_CNPJ_CPF int not null,
    primary key(Estoque_idProduto, Fornecedor_CNPJ_CPF),
    foreign key (Estoque_idProduto) references Estoque(idProduto),
    foreign key (Fornecedor_CNPJ_CPF) references Fornecedor(cnpjCpf)
);

create table ServicoFornecedor(
	Servico_idServico int not null,
    Fornecedor_CNPJ_CPF int not null,
    primary key(Servico_idServico, Fornecedor_CNPJ_CPF),
    foreign key (Servico_idServico) references Servico(idServico),
    foreign key (Fornecedor_CNPJ_CPF) references Fornecedor(cnpjCpf)
);

insert into empregado
	values("143.005.006-56", "Julio Cesar", null, "M", 1458.00, "cesar@gmail.com", "994272796", '1986-09-07', '2022-02-08 12:35:00', null, 1),
		("003.123.026-16", "Ana Julia", null, "F", 3458.50, "JuliaAna@gmail.com", "994272796", '2003-03-17', '2021-12-12 09:25:00', null, 1),
		("103.111.016-36", "Caio José", null, "M", 1258.00, "caio@gmail.com", "994272796", '1977-12-07', '2002-01-18 14:25:00', null, 1),
		("243.045.086-26", "Bina Carolina", null, "F", 6458.00, "binacarolina@gmail.com", "994272796", '1985-09-17', '2019-02-05 19:15:00', null, 1),
        ("621.090.096-06", "Tulio Gaspar", null, "M", 2158.60, "tulio@gmail.com", "994272796", '1984-11-11', '2018-11-01 08:15:00', null, 1),
        ("009.418.046-45", "Rina Cavalcanti", null, "F", 4158.00, "rina@gmail.com", "994272796", '2001-11-07', '2017-06-28 07:15:00', null, 1),
        ("111.274.016-13", "Bruno Quadrus", null, "M", 1158.00, "quadrus@gmail.com", "994272796", '2002-10-27', '2015-06-18 12:10:00', null, 1),
        ("331.271.056-11", "Pedro Cesar", null, "M", 3201.00, "pedro@gmail.com", "994272796", '1976-09-01', '2013-06-01 11:25:00', null, 1),
        ("212.614.076-10", "Palio Soares", null, "M", 2158.50, "Palio@gmail.com", "994272796", '2001-10-02', '2012-12-08 10:45:00', null, 1),
        ("006.114.126-45", "Maria Ana", null, "F", 6458.00, "maria@gmail.com", "994272796", '1981-08-17', '2022-05-18 10:45:00', null, 1);
    

desc empregado;

select * from empregado;