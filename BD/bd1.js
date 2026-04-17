create database  Biblioteca;
CREATE TABLE Usuario(
    Matricula INT PRIMARY KEY,
    Nome Varchar(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Endereco Varchar(200),
    Telefone Number(20)
);
CREATE TABLE Sessao(
    Codigo INT PRIMARY KEY,
    Descricao Varchar(100) NOT NULL,
    Localizacao Varchar(100)
);
CREATE TABLE Livro(
    Codigo INT PRIMARY KEY,
    Titulo Varchar(200) NOT NULL,
    Autor Varchar(100),
    Codigo_Sessao INT NOT NULL,
    FOREIGN KEY(Codigo_Sessao) REFERENCES Sessao(Codigo)
);
CREATE TABLE Emprestimo(
    Codigo INT PRIMARY KEY,
    Data_Hora DATETIME NOT NULL,
    Matricula_Usuario INT NOT NULL,
    Data_Devolucao DATE,
    FOREIGN KEY(Matricula_Usuario) REFERENCES Usuario(Matricula)
);
Create Table Livro_Emprestimo(
    Codigo_Emprestimo INT PRIMARY KEY,
    Codigo_Livro INT NOT NULL,
    FOREIGN KEY(Codigo_Livro) REFERENCES Livro(Codigo),
    FOREIGN KEY(Codigo_Emprestimo) REFERENCES Emprestimo(Codigo)
);


insert into Usuario(Matricula, Nome, Email, Endereco, Telefone)
Values(512398476, 'Ana Beatriz', 'ana.beatriz@gmail.com', 'Av. Atlântica, 1020', '47 991223344'),
    Values(284756192, 'Carlos Eduardo', 'cadu.silva@outlook.com', 'Rua XV de Novembro, 45', '47 988445566'),
    Values(739182645, 'Fernanda Lima', 'fer.lima@yahoo.com.br', 'Rua das Palmeiras, 780', '47 33441122'),
    Values(102938475, 'Gustavo Souza', 'guto.souza@hotmail.com', 'Alameda Rio Branco, 12', '47 992334455'),
    Values(847561239, 'Mariana Costa', 'mari.costa@icloud.com', 'Rua Joinville, 342', '47 30256677')

INSERT INTO Sessao(Codigo, Descricao, Localizacao) VALUES
    (1, 'Literatura Brasileira', 'Ala Norte - Estante 01'),
    (2, 'Ciências Computação', 'Ala Sul - Estante 05'),
    (3, 'História Geral', 'Ala Leste - Estante 02'),
    (4, 'Ficção Científica', 'Ala Norte - Estante 08'),
    (5, 'Medicina e Saúde', 'Ala Oeste - Estante 03');

INSERT INTO Livro(Codigo, Titulo, Autor, Codigo_Sessao) VALUES
    (501, 'Dom Casmurro', 'Machado de Assis', 1),
    (502, 'Clean Code', 'Robert C. Martin', 2),
    (503, 'Sapiens', 'Yuval Noah Harari', 3),
    (504, 'Duna', 'Frank Herbert', 4),
    (505, 'Anatomia Humana', 'Gray', 5);

INSERT INTO Emprestimo(Codigo, Data_Hora, Matricula_Usuario, Data_Devolucao) VALUES
    (1001, '2024-03-20 10:30:00', 101, '2024-03-27'),
    (1002, '2024-03-21 14:15:00', 102, '2024-03-28'),
    (1003, '2024-03-22 09:00:00', 103, '2024-03-29'),
    (1004, '2024-03-23 16:45:00', 104, '2024-03-30'),
    (1005, '2024-03-24 11:20:00', 105, '2024-03-31');

INSERT INTO Livro_Emprestimo(Codigo_Emprestimo, Codigo_Livro) VALUES
    (1001, 501),
    (1002, 502),
    (1003, 503),
    (1004, 504),
    (1005, 505);

2) Select Nome * from Usuario
3) Select Data_Hora from Emprestimo, Usuario where matrMatricula_Usuario = select(Matricula from Usuario  where Nome = Carlos Lima)
4) Select  Titulo * from Livro  INNER JOIN ON Livro.Codigo = Emprestimo.Codigo
5) Select Avg(descricao) from Sessao sessao.Codigo on Livro.Codigo_Sessao
6) delete from Esprestimo where Matricula_Usuario = Select(Matricula from Usuario where Nome = Bruno Costa)
7) delete from Livro_Emprestimo where codigo_Livro = Select(codigo from Emprestimo where Data_Hora = '22 /05 / 2025')
8) Update Emprestimo Data_Devolucao='22/05/2025' where Data_Devolucao='10/05/2025'
9)
10) Select Nome from Usuarios,Emprestimo where Matricula=Matricula_Usuario and  Data_Hora Between 01/05/2025 and 31/05/2025
11)Select Autor* from Usuarios,Emprestimo,Livro_Emprestimo where  Titulo Like '%Python%'