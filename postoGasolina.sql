show databases;
/*criar uma base de dados*/
create database postoBR;
/*usar uma base de dados*/
use postoBR;
/*deletar uma base de dados*/
/*drop database postocombadsmanha;*/
/*create database postogasolinamanha;*/
/*criando uma tabela, comece sempre com as tabelas mais simples e sem chave estrangeira*/
/*DDL*/
create table departamento(
	idDepartamento int primary key not null auto_increment,
    nome varchar(45) not null,
    email varchar(45) not null unique,
    descricao varchar(280),
    localDep varchar(45)
);
desc departamento;

create table empregado(
	cpf varchar(14) primary key not null,
    nome varchar(60) not null, 
    salario decimal(6,2) not null,
    sexo char(1) not null,
    statusEmp tinyint not null,
    email varchar(45) unique,
    CTPS varchar(15) not null unique,
    dataNasc date not null,
    dataAdm datetime not null,
    dataDem datetime,
    Departamento_idDepartamento int not null,
    foreign key(Departamento_idDepartamento) references departamento(idDepartamento)
);
/*alter table empregado add column */
/*drop table empregado;*/

create table endereco(
	idEndereco int primary key not null auto_increment,
    uf varchar(2) not null, 
    cidade varchar(45) not null,
    bairro  varchar(45) not null,
    rua varchar(60) not null,
    numero int not null,
    comp varchar(45),
    cep varchar(9) not null,
    Empregado_CPF varchar(14) not null,
    foreign key(Empregado_CPF) references Empregado(CPF)
		on update cascade
		on delete cascade
);
desc endereco;
/*deleta a tabela*/
/*drop table endereco;*/

create table dependente(
	CPF varchar(14) primary key not null,
    nome varchar(60) not null,
    dataNasc date not null,
    parentesco varchar(45) not null, 
    Empregado_CPF varchar(14) not null,
    foreign key(Empregado_CPF) references empregado(CPF)
		on update cascade
		on delete cascade
);

create table fornecedor(
	CNPJ varchar(15) primary key not null,
    nome varchar(45) not null,
    valorFrete decimal(5,2),
    statusForn boolean not null
);

create table telefone(
	idTelefone int primary key not null auto_increment,
    numero varchar(11) not null, 
    Empregado_CPF varchar(14),
    Departamento_idDepartamento int,
    Fornecedor_CNPJ varchar(15),
    foreign key(Empregado_CPF) references empregado(CPF) on update cascade on delete cascade,
    foreign key(Departamento_idDepartamento) references departamento(idDepartamento) on delete cascade,
    foreign key(Fornecedor_CNPJ) references fornecedor(CNPJ) on update cascade on delete cascade
);
desc telefone;

create table estoque(
	idProduto int primary key not null auto_increment,
    nomeProduto varchar(45) not null, 
    qtdProduto decimal(7,2) not null,
    valorProduto decimal(6,2) not null,
    codigoBarra varchar(25) unique not null,
    validade date,
    lote varchar(45)
);
desc estoque;

create table Fornecedor_Produto(
	fornecedor_cnpj varchar(15) not null,
    estoque_idProduto int not null,
    dataComp datetime not null, 
    qtdProduto decimal(7,2) not null,
    primary key(fornecedor_cnpj, estoque_idProduto),
    foreign key(fornecedor_cnpj) references fornecedor(cnpj),
    foreign key(estoque_idProduto) references estoque(idProduto)
);

create table bombaComb(
	idBombaComb int not null auto_increment,
    dataVistoria date not null,
    localBomba varchar(45) not null,
    primary key(idBombaComb)
);

create table vendas(
	idVenda int primary key not null auto_increment,
    dataVenda datetime not null,
    desconto decimal(5,2),
    valorTotal decimal(6,2) not null,
    Empregado_CPF varchar(14) not null,
    BombaComb_idBombaComb int,
    foreign key(Empregado_CPF) references empregado(CPF),
    foreign key(BombaComb_idBombaComb) references bombacomb(idBombaComb)
);

create table formaPag(
	idFormaPag int primary key not null auto_increment,
    tipo varchar(45) not null,
    qtdParcelas int,
    valor decimal(6,2) not null,
    Vendas_idVenda int not null,
    foreign key(Vendas_idVenda) references vendas(idVenda)
);

create table itensVenda(
	Vendas_idVenda int not null,
    Estoque_idProduto int not null,
    quantidade decimal(6,2) not null,
    primary key(Vendas_idVenda, Estoque_idProduto),
    foreign key(Vendas_idVenda) references vendas(idVenda),
    foreign key(Estoque_idProduto) references estoque(idProduto)
);

alter table fornecedor add column email varchar(45) unique after nome;

/*alter table fornecedor drop column email;

alter table fornecedor change column email emailFor varchar(60);*/

alter table departamento add column gerente_cpf varchar(14);

alter table departamento add foreign key(gerente_cpf) references empregado(cpf);

desc departamento;
/*SQL*/
/*insert into bombacomb (dataVistoria, localBomba) 
	value ("2022-04-21", "Posição B");
    
insert into bombacomb
	value (2, "2022-04-21", "Posição H");*/
    
/*select * from bombacomb;

delete from bombacomb
	where idBombaComb = 6;

delete from bombacomb
	where localBomba like "Posição B";*/

insert into departamento (nome, email, descricao, localdep)
	values ("TI", "ti@ipiranga.com", "Departamento de TI", "Sala 11"),
			("Frente Loja", "frentistas@ipiranga.com", null, "Frente de loja"),
            ("Financeiro", "financeiro@ipiranga.com", "Departamento Administrativo/Financeiro", "sala 01"),
            ("RH", "rh@ipiranga.com", "Departamento RH", "sala 02"),
            ("Comercial", "comercial@ipiranga.com", "Departamento Comercial", "sala 03");

select * from departamento;

desc empregado;

insert into empregado (cpf, nome, salario, sexo, statusEmp, email, CTPS, dataNasc, dataAdm, Departamento_idDepartamento)
	values ("030.111.666-99", "Danilo Farias", 1456.90, 'M', 1, "dansoaresfarias@gmail.com", "123456798", '1986-09-07', '2022-02-08 10:45:00', 2),
		("070.654.786-88", "Rubens Filho", 1346.80, 'M', 1, "rubenscarvalhofilho15@gmail.com", "123456 serie 01", '2003-05-15', '2000-05-15 10:45:00', 2),
        ("056.649.330-10", "Vinícius Bezerra", 2500.00, 'M', 1, "vinicius@hotmail.com", "45216548464", '1987-12-05', '2021-03-01 09:30:00', 1),
        ("030.222.333-99", "Caliel Farias", 2046.80, 'M', 1, "caliel@gmail.com", "34456923", '2003-11-04', '2016-04-12 11:25:00', 1),
        ("030.111.555-99", "Gustavo Gouveia", 8000.00,'M', 1,"gustavo_agj@outlook.com","1234567890",'2003-02-15', '2022-01-01 04:30:00',3),
		("030.111.444-98", "André Luiz", 1456.90, 'M', 1, "andre@outlook.com", "126397754", '2002-03-21', '2000-04-02 10:40:00', 4),
        ("126.952.224-02", "Lucca Montarroyos", 1500.00, 'M', 1, "luccacavalcanti@hotmail.com", "987654321", '1999-06-21', '2022-01-01 09:00:00', 5),
        ("030.111.494-24", "Maria Sofia", 1500.00, 'F', 1, "sofialimabreu@gmail.com", "123456754", '2000-07-06', '2019-02-10 10:45:00', 5),
        ("127.552.838-99", "Maria Eduarda", 1456.90, 'F', 1, "mariaeduarda@hotmail.com", "123456432", '2000-04-01', '2020-08-05 10:40:00', 3),
        ("118.088.464-78", "Vinicius Dornellas", 3000.90, 'M', 1, "dornellas@gmail.com", "123455723", '2001-05-27', '2022-02-08 10:45:00', 1);
 
insert into endereco (uf, cidade, bairro, rua, numero, comp, cep, empregado_cpf)
	values ("PE", "Recife", "Boa Vista", "Dom Bosco", 1234, "Ap 1508", "50070-000", "030.111.666-99"),
		("PE", "Jaboatão dos Guararapes", "Piedade", "Rua Goiana",  400, NULL, "54420-001", "118.088.464-78"),
        ("PE", "Paulista", "Pau Amarelo", "Jose Francisco", 658, "casa A", "36542-00", "030.111.494-24"),
        ("PE", "Recife", "Encruzilhada", "Dr.Eneas", "265", "ap 702", "35467-000", "070.654.786-88"),
        ("PE", "Recife", "Imbiribeira", "Rua Moacir Albuquerque", 1350, "AP 9000", "51180-430", "056.649.330-10"),
        ("PE", "Olinda", "Ouro Preto", "Peixe agulha", 23, null, "53270-152", "030.222.333-99"),
        ("PE", "Recife", "Boa Vista", "Maria da Glória", 252, null, "50060-280", "030.111.444-98"),
		("PE", "Recife", "Santo Amaro", "Av. Mario Melo", 124534, Null, "42070-200", "030.111.555-99"),
		("PE", "Olinda", "Bairro Novo", "Pereira simoes", 1131, "ap 101", "53120-050", "126.952.224-02"),
		("PE", "Recife", "Apipucos", "Rua de apipucos", 855, "apt 603","52071-640","127.552.838-99");
	
/*select * from endereco;

delete from endereco
	where idendereco = 10;*/

insert into endereco (uf, cidade, bairro, rua, numero, comp, cep, empregado_cpf)
	value ("PE", "Recife", "Apipucos", "Rua de apipucos", 855, "apt 603","52071-640","127.552.838-99");

/* delete from endereco
	where cidade like "Jaboat%";
    
delete from endereco;
delete from empregado;*/

/*Destravar a base de dados para permitir delete sem where*/
/*SET SQL_SAFE_UPDATES = 0;

delete from endereco
	where cidade like "Rec%";

select * from endereco;

delete from empregado 
	where cpf like "118.088%";
    
delete from bombacomb;*/

insert into bombacomb (dataVistoria, localBomba)
	values ("2021-07-02", "Bomba A"), 
			("2021-07-02", "Bomba B"),
            ("2021-07-02", "Bomba C"),
            ("2021-07-02", "Bomba D"),
            ("2021-07-04", "Bomba E"),
            ("2021-07-04", "Bomba F");
            
insert into dependente 
	values ("123.426.789-98", "Daniel Farias", '2021-10-25', "Filho","030.111.666-99"),
		("123.456.789-34", "Maria José", '2015-02-25', "Filha","070.654.786-88"),
        ("123.456.789-45", "Igor José", '2000-11-24', "Filho","070.654.786-88"),
        ("123.456.789-56", "Aline Lima", '2001-02-25', "Filha","030.111.444-98"),
        ("123.456.789-67", "Pedro Costa", '2020-03-02', "Filho","030.111.444-98"),
        ("123.456.789-78", "José Farias", '2020-11-12', "Filho","056.649.330-10"),
        ("123.456.789-89", "Bento Soares", '2022-05-15', "Filho","056.649.330-10"),
        ("123.456.789-10", "Elisa Farias", '2020-12-25', "Filha","030.111.666-99"),
        ("123.456.789-20", "Diogo Silva", '2010-11-28', "Filho","118.088.464-78"),
        ("123.456.789-30", "Dayane Silva", '2020-02-02', "Filha","118.088.464-78"),
        ("123.456.789-40", "Diego Costa", '2021-06-03', "Filho","127.552.838-99");

insert into estoque (nomeProduto, qtdProduto, valorProduto, codigoBarra)
	values ("Gasolina", 6579.8, 6.99, "0010992874"),
			("Álcool", 4579.8, 5.99, "0010992875"),
            ("Diesel", 7679.8, 6.49, "0010992876"),
            ("Água Minalba 500ml", 53, 2, "0010992877"),
            ("Água Minalba 1500ml", 28, 5, "0010992864"),
            ("Coca Cola Lata 350ml", 55, 3.5, "0010992844"),
            ("Fanta Lata 350ml", 15, 3.49, "0010992873"),
            ("Sprite Lata 350ml", 20, 3.5, "0010992872"),
            ("Pipoca Gravatá Salgada", 59, 2, "0010992871"),
            ("Pipoca Gravatá Doce", 34, 2, "0010992869"),
            ("Coxinha Frango", 25, 6.99, "0010992845"),
            ("Enroladinho", 3, 6.99, "0010992846"),
            ("Coxinha Fango c/Catupiry", 24, 6.99, "0010992847"),
            ("Risole", 6579.8, 15, "0010992848");

 insert into fornecedor 
	values ("97.776.353/0001", "Ipiranga Distribuidora", "ipidisp@ipiranga.br", 0, 1),
			("97.776.354/0001", "CocaCola Distribuidora", "disp@coca.br", 0, 1),
            ("97.776.355/0001", "Pipocas Gravatá Distribuidora", "disp@pipocasgta.br", 200.0, 1),
            ("97.776.356/0001", "Minalba Distribuidora", "disp@minalba.br", 200.0, 1),
            ("97.776.357/0001", "Maria do Salgado", "mariasal@gmail.com", 30.0, 1),
            ("97.776.358/0001", "Dona Glória do Salgado", "glorinha@gmail.com", 25.0, 1),
            ("97.776.359/0001", "Iaia Águas Dist", "iaiadisp@iaia.br", 0, 0);
   
insert into fornecedor_produto
		values ("97.776.353/0001", 1, '2016-04-12 11:25:00', 5000),
				("97.776.353/0001", 2, '2022-04-12 11:25:00', 3000),
                ("97.776.353/0001", 3, '2022-05-12 11:25:00', 4000),
                ("97.776.356/0001", 4, '2022-05-12 11:25:00', 30),
                ("97.776.356/0001", 5, '2022-06-12 11:25:00', 50),    
                ("97.776.354/0001", 6, '2022-05-12 11:25:00', 20),
                ("97.776.354/0001", 7, '2022-04-12 11:25:00', 45),
                ("97.776.354/0001", 8, '2022-04-12 11:25:00', 40),
                ("97.776.354/0001", 9, '2022-06-12 11:25:00', 10),
                ("97.776.354/0001", 10, '2022-06-12 11:25:00', 60),
                ("97.776.358/0001", 11, '2022-06-08 11:25:00', 20),
                ("97.776.358/0001", 12, '2022-06-08 11:25:00', 20),
                ("97.776.358/0001", 13, '2022-06-08 11:25:00', 30),
                ("97.776.358/0001", 14, '2022-06-08 11:25:00', 30);

/*desc vendas;
desc bombacomb;
delete from vendas;*/
insert into vendas (dataVenda, desconto, valorTotal, Empregado_CPF, bombacomb_idBombaComb)
	values ('2022-06-01 10:30:00', 0.0, 70.0, "030.111.666-99", 1),
			('2022-06-01 11:30:00', 0.0, 150.0, "030.111.666-99", 2),
            ('2022-06-01 11:35:00', 0.0, 100.0, "070.654.786-88", 3),
            ('2022-06-01 12:05:00', 0.0, 180.0, "070.654.786-88", 3),
            ('2022-06-01 12:15:00', 0.0, 100.0, "070.654.786-88", 4),
            ('2022-06-01 13:35:00', 0.0, 200.0, "030.111.666-99", 5),            
            ('2022-06-02 13:35:00', 0.0, 230.0, "030.111.666-99", 5),
            ('2022-06-01 10:35:00', 0.0, 10.0, "030.111.494-24", null),
            ('2022-06-01 11:30:00', 0.0, 12.0, "030.111.494-24", null),
            ('2022-06-01 12:08:00', 0.0, 23.0, "030.111.494-24", null),
            ('2022-06-01 12:36:00', 0.0, 44.0, "030.111.494-24", null),
			('2022-06-02 10:35:00', 0.0, 15.0, "030.111.494-24", null),
            ('2022-06-02 11:30:00', 0.0, 18.0, "030.111.494-24", null),
            ('2022-06-02 12:08:00', 0.0, 29.0, "030.111.494-24", null),
            ('2022-06-02 12:36:00', 0.0, 13.0, "030.111.494-24", null);

insert into itensvenda 
	values (1, 1, 30.0),
			(2, 1, 12.0),
            (3, 2, 18.5),
            (4, 3, 14.0),
            (5, 3, 11.0),
            (6, 2, 30.0),
            (6, 1, 3.0),
            (7, 1, 30.0),
            (8, 4, 5),
            (9, 5, 2),
            (10, 6, 3),
            (11, 7, 2),
            (11, 13, 2),
            (12, 14, 3),
            (13, 8, 1),
            (13, 12, 2),
            (14, 9, 6),
            (15, 9, 2),
            (15, 10, 3);

insert into formapag (tipo, qtdParcelas, valor, vendas_idVenda)
	values ("Dinheiro", 0, 70.0, 1),
		("Pix", 0, 150.0, 2),
        ("Crédito", 1, 100.0, 3),
        ("Débito", 0, 180.0, 4),
        ("Crédito", 1, 100.0, 5),
        ("Crédito", 1, 200.0, 6),
        ("Débito", 0, 230.0, 7),
        ("Crédito", 1, 10.0, 8),
        ("Pix", 0, 12.0, 9),
        ("Crédito", 1, 23.0, 10),
        ("Pix", 0, 44.0, 11),
        ("Débito", 0, 15.0, 12),
        ("Crédito", 1, 18.0, 13),
        ("Dinheiro", 0, 29.0, 14),
        ("Dinheiro", 0, 13.0, 15);
        
 insert into telefone (numero, empregado_cpf, departamento_iddepartamento, fornecedor_cnpj)
	values ("8199985671", "030.111.666-99", null, null),
		("8121263306", null, 1, null),
        ("81212633602", null, 2, null),
        ("8132445678", null, null, "97.776.354/0001"),
        ("8135331817", null, null, "97.776.355/0001");

update empregado
	set salario = 1200
		where cpf = "070.654.786-88";
        
update empregado
	set salario = 5500
		where cpf in ("030.111.555-99","030.111.494-24");

update empregado
	set nome = "Lucca Lima", email = "luccalima@gmail.com"
		where cpf = "126.952.224-02";

update empregado
	set salario = salario*1.1
		where departamento_idDepartamento = 2;

/*DQL*/
select * from empregado; 
select * from departamento;         
select * from fornecedor_produto; 
select * from fornecedor; 
select * from estoque; 
select * from formapag; 
select * from vendas;
select * from itensvenda;
select * from formapag;
select * from telefone;

select nome, email from empregado;

select nome as "Nome Empregado", email "E-mail Empregado" from empregado;

select nome as "Nome Empregado", email "E-mail Empregado" from empregado
	where departamento_iddepartamento = 3;
    
select upper(nome) as "Nome Empregado", email "E-mail Empregado" from empregado;

select upper(nome) as "Nome Empregado", email "E-mail Empregado" from empregado
	order by nome;
    
select upper(nome) as "Nome Empregado", email "E-mail Empregado" from empregado
	order by salario;
    
select upper(nome) as "Nome Empregado", email "E-mail Empregado" from empregado
	order by salario desc;

select upper(nome) as "Nome", email "E-mail", salario "Salario", dataAdm "Data Admissão" 
	from empregado
		order by dataAdm;
        
select avg(salario) from empregado;

select nome as "Nome", email "E-mail", salario "Salario", dataAdm "Data Admissão" 
	from empregado
		where salario < (select avg(salario) from empregado)
			order by nome;

select nome as "Nome", email "E-mail", salario "Salario", dataAdm "Data Admissão" 
	from empregado
		where departamento_idDepartamento = (select iddepartamento from departamento where nome like "TI")
			order by nome;
            

/*CORRETO*/
select emp.nome as "Nome", emp.email "E-mail", emp.salario "Salario", emp.dataAdm "Data Admissão", dep.nome "Departamento"
	from empregado emp, departamento dep
		where salario < (select avg(salario) from empregado) and
			emp.departamento_iddepartamento = dep.iddepartamento
			order by nome;
            
            
select e.nomeProduto "NOme Produto", e.valorProduto "Preço", f.nome "Fornecedor", f.email "Email"
	from estoque e, fornecedor f, fornecedor_produto fp
		where fp.estoque_idProduto = e.idProduto and  
			fp.fornecedor_cnpj = f.cnpj;
		
/*est.nome | est.preco | forn.nome | forn.email*/

select e.nomeProduto "Nome produto", e.qtdProduto "qtd Produto", e.valorProduto "Valor produto", v.valortotal, emp.nome "nome empregado", v.dataVenda "data Venda"
	from vendas v,estoque e, empregado emp, itensvenda iv
		where iv.estoque_idProduto = e.idProduto and iv.Vendas_idVenda = v.idVenda and v.empregado_CPF = emp.cpf

/*nome produto (estoque) | quantidade produto(estoque) | data da venda(vendas) | preço do produto(estoque) | valor total da venda(vendas) | nome do vendedor(empregado)*/