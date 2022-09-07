#Criação e abertura do banco de dados
CREATE DATABASE DEFESA;
USE DEFESA;

# Criação das tabelas
CREATE TABLE FORCA_ARMADA (
	ID_FORCA_ARMADA INTEGER AUTO_INCREMENT,
    NOME VARCHAR(30) NOT NULL,
    PRIMARY KEY (ID_FORCA_ARMADA) );

CREATE TABLE PATENTE (
    ID_PATENTE INTEGER AUTO_INCREMENT,
    NOME VARCHAR(40) NOT NULL,
	SIGLA VARCHAR(8) NOT NULL,
	TIPO CHAR(1) NOT NULL,
    PRIMARY KEY (ID_PATENTE),
    CHECK (TIPO="P" OR TIPO="G") );

CREATE TABLE FORCA_PATENTE (
	ID_FORCA_PATENTE INTEGER AUTO_INCREMENT,
	ID_FORCA_ARMADA INTEGER NOT NULL,
	ID_PATENTE INTEGER NOT NULL,
	PRIMARY KEY(ID_FORCA_PATENTE) );

# Aplicação das restrições de integridade referencial
ALTER TABLE FORCA_PATENTE
	ADD FOREIGN KEY(ID_FORCA_ARMADA) REFERENCES FORCA_ARMADA (ID_FORCA_ARMADA),
    ADD FOREIGN KEY(ID_PATENTE) REFERENCES PATENTE (ID_PATENTE);

DESCRIBE FORCA_PATENTE;

SHOW TABLES;


# Populando o banco de dados

-- Inserindo registros na tabela FORCA_ARMADA
INSERT INTO FORCA_ARMADA (NOME)
      VALUES ("Marinha"),
             ("Exército"),
             ("Aeronáutica");

SELECT * FROM FORCA_ARMADA;


-- Inserindo registros na tabela FORCA_ARMADA

-- (Patentes do tipo POSTO) 
INSERT INTO PATENTE (NOME, SIGLA, TIPO)
       VALUES ("Almirante"                         , "Alte"    , "P"),
              ("Almirante de Esquadra"             , "Alte Esq", "p"),
              ("Vice-Almirante"                    , "V Alte"  , "P"),
              ("Contra-Almirante"                  , "C Alte"  , "P"),
              ("Capitão de Mar e Guerra"           , "CMG"     , "P"),
              ("Capitão de Mar e Guerra Intendente", "CGM (IM)", "P"),
              ("Capitão de Fragata"                , "CF"      , "P"),
              ("Capitão de Corveta"                , "CC"      , "P"),
              ("Capitão-Tenente"                   , "CT"      , "P"),
              ("1º Tenente"                        , "1º Ten"  , "P"),
              ("2º Tenente"                        , "2º Ten"  , "P"),
              ("Guarda-Marinha"                    , "GM"      , "P"),
              ("Marechal"                          , "Mar"     , "P"),              
              ("General de Exército"               , "Gen Ex"  , "P"),
              ("General de Divisa"                 , "Gen Div" , "P"),
              ("General de Brigada"                , "Gen Bda" , "P"),
              ("Coronel"                           , "Cel"     , "P"),
              ("Tenente-Coronel"                   , "Ten Cel" , "P"),
              ("Major"                             , "Maj"     , "P"),
              ("Capitão"                           , "Cap"     , "P"),
              ("Aspirante a Oficial"               , "Asp"     , "P"),             
              ("Marechal do Ar"                    , "Mar Ar"  , "P"),              
              ("Tenente-Brigadeiro"                , "Ten Brig", "P"),
              ("Major-Brigadeiro"                  , "Maj Brig", "P"),
              ("Brigadeiro"                        , "Brig"    , "P"),
              ("Aspirante"                         , "Asp"     , "P" );
              
-- (Patentes do tipo GRADUAÇÃO)               
INSERT INTO PATENTE (NOME, SIGLA, TIPO)
       VALUES ("Aspirante"                  , "Asp"  , "G"),              
              ("Suboficial"                 , "SO"   , "G"), 
              ("1º Sargento"                , "1º SG", "G"), 
              ("2º Sargento"                , "2º SG", "G"), 
              ("3º Sargento"                , "3º SG", "G"), 
              ("Cabo"                       , "CB"   , "G"), 
              ("Soldado (CFN)"              , "SD"   , "G"),            
              ("Marinheiro"                 , "MN"   , "G"),            
              ("Cadete"                     , "Cad"  , "G"),
              ("Subtenente"                 , "S Ten", "G"), 
              ("Soldado      "              , "SD"   , "G"),            
              ("Taifeiro-mor"               , "TM"   , "G"), 
              ("Taifeiro de Primeira Classe", "T1"   , "G"), 
              ("Taifeiro de Segundo Classe" , "T2"   , "G"),
              ("Soldado de primeira classe" , "S1"   , "G");
              
SELECT * FROM PATENTE;          

-- Postos da Marinha              
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (1,  1),              
                   (1,  2),
                   (1,  3),
                   (1,  4),
                   (1,  5),
                   (1,  6),
                   (1,  7),
                   (1,  8),
                   (1,  9),
                   (1, 10),
                   (1, 11),
                   (1, 12);

-- Postos do Exército                                 
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (2,  13),              
                   (2,  14),
                   (2,  15),
                   (2,  16),
                   (2,  17),
                   (2,  18),
                   (2,  19),
                   (2,  20),
                   (2,  10),
                   (2,  11),
                   (2,  21);
                   
-- Postos da Aeronáutica
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (3,  22),              
                   (3,  23),
                   (3,  24),
                   (3,  25),
                   (3,  17),
                   (3,  18),
                   (3,  19),
                   (3,  20),
                   (3,  10),
                   (3,  11),
                   (3,  26);


-- Graduações da Marinha
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (1, 27),              
                   (1, 28),
                   (1, 29),
                   (1, 30),
                   (1, 31),
                   (1, 32),
                   (1, 33),
                   (1, 34);

-- Graduações do Exército
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (2, 35),              
                   (2, 36),
                   (2, 29),
                   (2, 30),
                   (2, 31),
                   (2, 32),
                   (2, 37),
                   (2, 38),
                   (2, 39),
                   (2, 40);

-- Graduações da Aeronáutica
INSERT INTO FORCA_PATENTE (ID_FORCA_ARMADA, ID_PATENTE) 
            VALUES (3, 35),              
                   (3, 28),
                   (3, 29),
                   (3, 30),
                   (3, 31),
                   (3, 32),
                   (3, 41),
                   (3, 37),
                   (3, 38),
                   (3, 39),
                   (3, 40);


SELECT * FROM FORCA_PATENTE;
 