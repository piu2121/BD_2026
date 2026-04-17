create database bd;
CREATE TABLE Usuario (
    Matricula INT PRIMARY KEY,
    Nome Varchar(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Endereco Varchar(200),
    Telefone Number(20)
);
CREATE TABLE Sessao (
    Codigo INT PRIMARY KEY,
    Descricao Varchar(100) NOT NULL,
    Localizacao Varchar(100)
);
CREATE TABLE Livro (
    Codigo INT PRIMARY KEY,
    Titulo Varchar(200) NOT NULL,
    Autor Varchar(100),
    Codigo_Sessao INT NOT NULL,
    FOREIGN KEY (Codigo_Sessao) REFERENCES Sessao(Codigo)
);
CREATE TABLE Emprestimo (
    Codigo INT PRIMARY KEY,
    Data_Hora DATETIME NOT NULL,
    Matricula_Usuario INT NOT NULL,
    Data_Devolucao DATE,
    FOREIGN KEY (Matricula_Usuario) REFERENCES Usuario(Matricula)
);
Create Table Livro_Emprestimo (
    Codigo_Emprestimo INT PRIMARY KEY,
    Codigo_Livro INT NOT NULL,
    FOREIGN KEY (Codigo_Livro) REFERENCES Livro(Codigo),
    FOREIGN KEY (Codigo_Emprestimo) REFERENCES Emprestimo(Codigo)
);