
CREATE TABLE Usuario(
    Matricula integer PRIMARY KEY,
    Nome Varchar(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Endereco Varchar(200),
    Telefone Varchar(50)
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
    Data_Hora DATE NOT NULL,
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
    (284756192, 'Carlos Eduardo','cadu.silva@outlook.com', 'Rua XV de Novembro, 45', '47 988445566'),
    (739182645, 'Fernanda Lima', 'fer.lima@yahoo.com.br', 'Rua das Palmeiras, 780', '47 33441122'),
    (102938475, 'Gustavo Souza', 'guto.souza@hotmail.com', 'Alameda Rio Branco, 12', '47 992334455'),
    (847561239, 'Mariana Costa', 'mari.costa@icloud.com', 'Rua Joinville, 342', '47 30256677')

INSERT INTO Sessao(Codigo, Descricao, Localizacao) VALUES
    (1, 'Literatura Brasileira', 'Ala Norte - Estante 01'),
    (2, 'Ciências Computação', 'Ala Sul - Estante 05'),
    (3, 'História Geral', 'Ala Leste - Estante 02'),
    (4, 'Ficção Científica', 'Ala Norte - Estante 08'),
    (5, 'Medicina e Saúde', 'Ala Oeste - Estante 03')

INSERT INTO Livro(Codigo, Titulo, Autor, Codigo_Sessao) VALUES
    (501, 'Dom Casmurro', 'Machado de Assis', 1),
    (502, 'Clean Code', 'Robert C. Martin', 2),
    (503, 'Sapiens', 'Yuval Noah Harari', 3),
    (504, 'Duna', 'Frank Herbert', 4),
    (505, 'Anatomia Humana', 'Gray', 5)

INSERT INTO Emprestimo (Codigo, Data_, matricula_usuario, Data_Devolucao) VALUES
    (1001, '2024-03-20', 512398476, '2024-03-27'),
    (1002, '2024-03-21', 284756192, '2024-03-28'),
    (1003, '2024-03-22', 739182645, '2024-03-29'),
    (1004, '2024-03-23', 102938475, '2024-03-30'),
    (1005, '2024-03-24', 847561239, '2024-03-31');

INSERT INTO Livro_Emprestimo(Codigo_Emprestimo, Codigo_Livro) VALUES
    (1001, 501),
    (1002, 502),
    (1003, 503),
    (1004, 504),
    (1005, 505);

2) Select Nome from Usuario

3) Select Data_ from Emprestimo  where Matricula_Usuario = (select Matricula from Usuario  where Nome = 'Carlos Lima')

4) SELECT Livro.Titulo, Emprestimo.Data_ FROM Livro INNER JOIN Emprestimo ON Livro.Codigo = Emprestimo.Codigo;

5) Select Count(descricao) from Sessao INNER JOIN Livro on sessao.Codigo= Livro.Codigo_Sessao

6) delete from Emprestimo where Matricula_Usuario = (Select Matricula from Usuario where Nome ='Bruno Costa')

7) delete from Livro_Emprestimo where codigo_Livro = (Select codigo from Emprestimo where Data_= '22 /05 / 2025')

8) Update Emprestimo Set Data_Devolucao = '22/05/2025' where Data_Devolucao= '10/05/2025'

9) SELECT Codigo, Titulo, Autor, Codigo_Sessao  FROM Livro  INNER JOIN Sessao ON Livro.Codigo_Sessao = Sessao.Codigo  WHERE (Sessao.Descricao = 'Banco de Dados'   OR Sessao.Descricao = 'Algoritmos'  OR Sessao.Descricao = 'Estrutura de Dados');

9.1) Select  Livro.Codigo,Titulo,Autor From Livro Inner Join  Sessao ON Livro.Codigo_Sessao = Sessao.Codigo  where Livro.Codigo_Sesao IN (Sessao.Codigo) And Sessao.Descricao IN('banco de Dados','Algoritmos','Estrutura de Dados')


10) Select Nome from Usuarios Inner Join  Emprestimo On = where Matricula=Matricula_Usuario and  Data_Hora Between 01/05/2025 and 31/05/2025

11)SELECT  Livro.Autor FROM LivroINNER JOIN Livro_Emprestimo ON Livro.Codigo = Livro_Emprestimo.Codigo_Livro WHERE Livro.Titulo LIKE '%Python%';

--trigger 1

CREATE TRIGGER trg_valida_data_devolucao
BEFORE INSERT ON Emprestimo
FOR EACH ROW
BEGIN
	--verifica se a data de entrega no livro é um número e se é um número válido
    -- Só valida se a Data_Devolucao for informada (não nula)
    IF NEW.Data_Devolucao IS NOT NULL AND NEW.Data_Devolucao <= NEW.Data_Hora THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data de devolução deve ser posterior à data do empréstimo.';
    END IF;
END;

--trigger 2

CREATE TRIGGER trg_verifica_livro_ja_emprestado
BEFORE INSERT ON Livro_Emprestimo
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
	--solta uma mensagem dizendo que este livro já foi pego e não foi devolvido até o presente momento
    -- Conta se este livro já aparece em um empréstimo que não foi devolvido
    SELECT COUNT(*)
    INTO v_count
    FROM Livro_Emprestimo LE
    INNER JOIN Emprestimo E ON LE.Codigo_Emprestimo = E.Codigo
    WHERE LE.Codigo_Livro = NEW.Codigo_Livro
      AND E.Data_Devolucao IS NULL;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este livro já está emprestado e ainda não foi devolvido.';
    END IF;
END;

-- trigger 3

CREATE TRIGGER trg_limite_emprestimos_ativos
BEFORE INSERT ON Emprestimo
FOR EACH ROW
BEGIN
    DECLARE v_ativos INT;
--não pode passar de 5 livros,se passar cancela na hora o livro que ele está tentado fazer imprestimo
    -- Conta quantos empréstimos ativos o usuário já possui
    SELECT COUNT(*)
    INTO v_ativos
    FROM Emprestimo
    WHERE Matricula_Usuario = NEW.Matricula_Usuario
      AND Data_Devolucao IS NULL;

    IF v_ativos >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuário já possui 5 livros emprestados. Devolva algum antes de pegar um novo.';
    END IF;
END;

