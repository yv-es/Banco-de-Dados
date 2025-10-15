CREATE TABLE empregado
(
	identificacao INTEGER PRIMARY KEY,
  	nome VARCHAR(30),
  	salario DECIMAL(10,2),
  	endereco VARCHAR(30),
  	sexo CHAR,
  	dataNascimento TIMESTAMP,
  	departNumero INTEGER,
  	superIdentificaçao INTEGER,
  
  	CONSTRAINT superIdentificacao_fk
  	FOREIGN KEY (superIdentificaçao)
  	REFERENCES empregado(identificacao)
);

CREATE TABLE departamento
(
 	numero INTEGER PRIMARY KEY,
  	nome VARCHAR(30),
  	identificacaoGerente INTEGER,
  	dataInicio TIMESTAMP,
  
  	CONSTRAINT identificacaoGerente_fk
  	FOREIGN KEY (identificacaoGerente)
  	REFERENCES empregado(identificacao)
);

CREATE TABLE departamentoLocal
(
	numeroDepartamento INTEGER PRIMARY KEY,
  	localizacao VARCHAR(30),
  
  	CONSTRAINT numeroDepartamento_fk
  	FOREIGN KEY (numeroDepartamento)
  	REFERENCES departamento(numero)
);


CREATE TABLE projeto
(
	numeroProjeto INTEGER PRIMARY KEY,
  	nome VARCHAR(30),
  	localizacao VARCHAR(30),
  	departamentoNumero INTEGER,
  
  	CONSTRAINT departamentoNumero_fk
  	FOREIGN KEY (departamentoNumero)
  	REFERENCES departamento(numero)
);

CREATE TABLE dependente
(
  identificacaoEmpregado INTEGER,
  nome VARCHAR(30),
  sexo VARCHAR,
  dataNascimento TIMESTAMP,
  parentesco VARCHAR(10),
  PRIMARY KEY(identificacaoEmpregado, nome),
  
  CONSTRAINT identificacaoEmpregado_fk
  FOREIGN KEY (identificacaoEmpregado)
  REFERENCES empregado(identificacao)
);

CREATE TABLE trabalhando
(
	identificacaoEmpregado INTEGER PRIMARY KEY,
  	numeroProjeto INTEGER,
  	horas DECIMAL(5,2),
  
    CONSTRAINT identificacaoEmpregado_fk
    FOREIGN KEY (identificacaoEmpregado)
    REFERENCES empregado(identificacao),
  
    CONSTRAINT numeroProjeto_fk
    FOREIGN KEY (numeroProjeto)
    REFERENCES projeto(numeroProjeto)
);

--gerentes
INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(1, 'Carlos Silva', 12000.00, 'Rua A, 100', 'M', '1975-05-10', 1, NULL);

INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(2, 'Fernanda Almeida', 11500.00, 'Rua B, 200', 'F', '1980-03-22', 2, NULL);

INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(3, 'Rafael Mendes', 11800.00, 'Rua C, 300', 'M', '1978-11-10', 3, NULL);


INSERT INTO departamento (numero, nome, identificacaoGerente, dataInicio)
VALUES
(1, 'Administração', 1, '2010-01-01'),
(2, 'TI', 2, '2012-03-15'),
(3, 'Financeiro', 3, '2014-07-20'),
(4, 'RH', 1, '2016-11-05'),
(5, 'Logística', 2, '2018-09-10');

INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(4, 'Luciana Prado', 6000.00, 'Rua D, 400', 'F', '1990-07-18', 1, 1),
(5, 'Thiago Neves', 5900.00, 'Rua E, 500', 'M', '1991-10-22', 4, 1);

INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(6, 'Juliana Ramos', 6100.00, 'Rua F, 600', 'F', '1993-01-15', 2, 2),
(7, 'Marcelo Dias', 6200.00, 'Rua G, 700', 'M', '1989-08-09', 5, 2);

INSERT INTO empregado (identificacao, nome, salario, endereco, sexo, dataNascimento, departNumero, superIdentificaçao)
VALUES
(8, 'Patrícia Nogueira', 6050.00, 'Rua H, 800', 'F', '1987-06-25', 3, 3),
(9, 'Diego Costa', 5980.00, 'Rua I, 900', 'M', '1992-03-30', 3, 3);


INSERT INTO departamentoLocal (numeroDepartamento, localizacao)
VALUES
(1, 'São Paulo'),
(2, 'Rio de Janeiro'),
(3, 'Belo Horizonte'),
(4, 'Curitiba'),
(5, 'Porto Alegre');

INSERT INTO projeto (numeroProjeto, nome, localizacao, departamentoNumero)
VALUES
(101, 'Reengenharia', 'São Paulo', 2),
(102, 'Auditoria 2025', 'Belo Horizonte', 3),
(103, 'Treinamento RH', 'Curitiba', 4),
(104, 'Expansão Logística', 'Porto Alegre', 5),
(105, 'Revisão Processos', 'São Paulo', 1);

INSERT INTO trabalhando (identificacaoEmpregado, numeroProjeto, horas)
VALUES
(4, 105, 20.0),
(5, 103, 18.5),  
(6, 101, 22.0),  
(7, 104, 25.0),
(8, 102, 19.5);

INSERT INTO dependente (identificacaoEmpregado, nome, sexo, dataNascimento, parentesco)
VALUES
(1, 'Lucas Silva', 'M', '2005-06-10', 'Filho'),
(2, 'Marina Almeida', 'F', '2011-04-25', 'Filha'),
(3, 'João Mendes', 'M', '2008-09-30', 'Filho'),
(6, 'Fernanda Ramos', 'F', '2013-02-10', 'Filha'),
(8, 'André Nogueira', 'M', '2016-07-07', 'Filho');

SELECT p.numeroProjeto AS numero_Do_Projeto, d.numero AS numero_Do_Departamento
FROM departamento d
INNER JOIN projeto p ON d.numero = p.departamentoNumero;

SELECT d.nome, d.parentesco, e.identificacao, e.nome
FROM empregado e
INNER JOIN dependente d ON e.identificacao = d.identificacaoEmpregado;

SELECT identificacao, superIdentificaçao, nome, sexo
FROM empregado;

SELECT DISTINCT salario
from empregado;

SELECT *
FROM empregado
WHERE endereco = 'Salvador';

SELECT e.salario * 1.1 AS salario_110porcento
FROM empregado e
INNER JOIN departamento d ON d.numero = e.departNumero
INNER JOIN projeto proj ON proj.departamentoNumero = d.numero
WHERE proj.nome = 'Reengenharia';

SELECT *
FROM empregado
WHERE superIdentificaçao ISNULL;

SELECT dL.localizacao
FROM departamento d
INNER JOIN departamentoLocal dL ON d.numero = dL.numeroDepartamento;

SELECT e.nome
FROM empregado e
INNER JOIN trabalhando t ON t.identificacaoEmpregado = e.identificacao
WHERE t.horas < 20;

SELECT e.nome
FROM empregado e
LEFT JOIN dependente d ON e.identificacao = d.identificacaoEmpregado
WHERE d.nome IS NULL;

