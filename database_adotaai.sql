-- Banco de dados para o sistema Adota Aí
CREATE SCHEMA `adotaai`;
USE `adotaai`;

-- Criação do usuário funcionário (administrador)
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT, UPDATE ON AdotaAi.* TO 'funcionario'@'localhost';

-- CRIAÇÃO DAS TABELAS

-- Tabela Adotante
CREATE TABLE Adotante (
    CPF VARCHAR(11) PRIMARY KEY,
    Email VARCHAR(100),
    Endereco VARCHAR(255)
);

-- Tabela Veterinario
CREATE TABLE Veterinario (
    CPF VARCHAR(11) PRIMARY KEY,
    Email VARCHAR(100),
    Endereco VARCHAR(255),
    CRMV VARCHAR(10)
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    CPF VARCHAR(11) PRIMARY KEY,
    Email VARCHAR(100),
    Endereco VARCHAR(255)
);

-- Tabela Animal
CREATE TABLE Animal (
    id_animal INT PRIMARY KEY AUTO_INCREMENT,
    Raca VARCHAR(50),
    statusVac BOOLEAN,
    statusDisp BOOLEAN
);

-- Tabela Consultas Veterinárias
CREATE TABLE ConsultaVeterinaria (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    dataConsulta DATE,
    Notas TEXT,
    Procedimentos TEXT,
    CPF_Veterinario VARCHAR(11),
    id_animal INT,
    FOREIGN KEY (CPF_Veterinario) REFERENCES Veterinario(CPF),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal)
);

-- Tabela Histórico de Adoções
CREATE TABLE Historico_Adocoes (
    id_adocao INT PRIMARY KEY AUTO_INCREMENT,
    dataAdocao DATE,
    id_animal INT,
    CPF_Adotante VARCHAR(11),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
    FOREIGN KEY (CPF_Adotante) REFERENCES Adotante(CPF)
);

-- Tabela Área de Adoções
CREATE TABLE AreaAdocoes (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    id_animal INT,
    nome_animal VARCHAR(100),
    idade VARCHAR(10),
    descricao TEXT,
    status_adocao BOOLEAN,
    data_resgate DATE,
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal)
);

-- Tabela Doador
CREATE TABLE Doador (
    CPF VARCHAR(11) PRIMARY KEY,
    Email VARCHAR(100),
    Endereco VARCHAR(255)
);

-- Tabela de Feedback
CREATE TABLE Feedback (
    id_feedback INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(50),
    Descricao TEXT,
    Data DATE,
    Rating INT,
    Remetente VARCHAR(255),
    id_area INT,
    FOREIGN KEY (id_area) REFERENCES AreaAdocoes(id_area)
);

-- Tabela Infovacinas
CREATE TABLE Infovacinas (
    id_vacina INT PRIMARY KEY AUTO_INCREMENT,
    nome_vacina VARCHAR(100),
    descricao TEXT
);

-- Tabela Vacina (Associação entre Animal e Vacina)
CREATE TABLE Vacina (
    id_vacina INT,
    id_animal INT,
    PRIMARY KEY (id_vacina, id_animal),
    FOREIGN KEY (id_vacina) REFERENCES Infovacinas(id_vacina),
    FOREIGN KEY (id_animal) REFERENCES Animal(id_animal)
);

-- Tabela Blog
CREATE TABLE Blog (
    id_blog INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    conteudo TEXT,
    Data_criacao DATE,
    autor_id INT
);

-- Tabela Sistema (informações gerais)
CREATE TABLE Sistema (
    blog VARCHAR(255),
    areaDoacao VARCHAR(255),
    infoVacinas VARCHAR(255)
);

-- INSERÇÕES NAS TABELAS

INSERT INTO Adotante (CPF, Email, Endereco) 
VALUES 
('12345678910', 'joao@example.com', 'Rua, 123'),
('98765432109', 'maria@example.com', 'Rua, 123');

INSERT INTO Veterinario (CPF, Email, Endereco, CRMV)
VALUES 
('98765432109', 'vetjoao@example.com', 'Rua C, 789', 'CRMV1234'),
('87654321098', 'vetmaria@example.com', 'Rua D, 101', 'CRMV5678');

INSERT INTO Funcionario (CPF, Email, Endereco)
VALUES 
('12309845677', 'func1@example.com', 'Rua E, 111'),
('12345609877', 'func2@example.com', 'Rua F, 222');

INSERT INTO Animal (Raca, statusVac, statusDisp)
VALUES 
('Bulldog', TRUE, TRUE),
('Poodle', FALSE, TRUE),
('Golden Retriever', TRUE, FALSE);

INSERT INTO ConsultaVeterinaria (dataConsulta, Notas, Procedimentos, CPF_Veterinario, id_animal)
VALUES 
('2024-10-10', 'Consulta de rotina', 'Aplicação de vacina', '98765432109', 1),
('2024-09-12', 'Exame geral', 'Procedimento cirúrgico', '87654321098', 2);

INSERT INTO Historico_Adocoes (dataAdocao, id_animal, CPF_Adotante)
VALUES 
('2024-10-15', 1, '12345678910'),
('2024-10-16', 2, '98765432109');

INSERT INTO AreaAdocoes (id_animal, nome_animal, idade, descricao, status_adocao, data_resgate)
VALUES 
(1, 'Rex', '3 anos', 'Animal muito amigável e saudável', TRUE, '2024-09-15'),
(2, 'Luna', '2 anos', 'Animal resgatado em boas condições', FALSE, '2024-09-18');

INSERT INTO Doador (CPF, Email, Endereco)
VALUES 
('19283746500', 'doador1@example.com', 'Rua G, 333'),
('12398765412', 'doador2@example.com', 'Rua H, 444');

INSERT INTO Feedback (Tipo, Descricao, Data, Rating, Remetente, id_area)
VALUES 
('Positivo', 'Excelente atendimento e adoção fácil', '2024-10-12', 5, 'joao@example.com', 1),
('Negativo', 'Demora no processo de adoção', '2024-10-14', 2, 'maria@example.com', 2);

INSERT INTO Infovacinas (nome_vacina, descricao)
VALUES 
('Antirrábica', 'Vacina contra a raiva'),
('V10', 'Vacina polivalente contra várias doenças caninas');

INSERT INTO Vacina (id_vacina, id_animal)
VALUES 
(1, 1), -- Animal 1 recebeu a antirrábica
(2, 1), -- Animal 1 recebeu a V10
(1, 2); -- Animal 2 recebeu a antirrábica

INSERT INTO Blog (titulo, conteudo, Data_criacao, autor_id)
VALUES 
('Adoção Responsável', 'Importância de adotar pets de forma consciente', '2024-10-15', 1),
('Cuidados com Animais Resgatados', 'Como cuidar de um pet após o resgate', '2024-10-16', 2);

-- Procedures de inserção, atualização e exclusão de cada tabela que precise dessas funcionalidades:

-- Para Adotante
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirAdotante(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255)
)
BEGIN
    INSERT INTO Adotante (CPF, Email, Endereco) 
    VALUES (p_CPF, p_Email, p_Endereco);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarAdotante(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255)
)
BEGIN
    UPDATE Adotante 
    SET Email = p_Email, Endereco = p_Endereco 
    WHERE CPF = p_CPF;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirAdotante(IN p_CPF VARCHAR(11))
BEGIN
    DELETE FROM Adotante WHERE CPF = p_CPF;
END $$

-- Para Veterinario
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirVeterinario(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255),
    IN p_CRMV VARCHAR(10)
)
BEGIN
    INSERT INTO Veterinario (CPF, Email, Endereco, CRMV) 
    VALUES (p_CPF, p_Email, p_Endereco, p_CRMV);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarVeterinario(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255),
    IN p_CRMV VARCHAR(10)
)
BEGIN
    UPDATE Veterinario 
    SET Email = p_Email, Endereco = p_Endereco, CRMV = p_CRMV 
    WHERE CPF = p_CPF;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirVeterinario(IN p_CPF VARCHAR(11))
BEGIN
    DELETE FROM Veterinario WHERE CPF = p_CPF;
END $$

-- Para Funcionario
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirFuncionario(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255)
)
BEGIN
    INSERT INTO Funcionario (CPF, Email, Endereco) 
    VALUES (p_CPF, p_Email, p_Endereco);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarFuncionario(
    IN p_CPF VARCHAR(11),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255)
)
BEGIN
    UPDATE Funcionario 
    SET Email = p_Email, Endereco = p_Endereco 
    WHERE CPF = p_CPF;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirFuncionario(IN p_CPF VARCHAR(11))
BEGIN
    DELETE FROM Funcionario WHERE CPF = p_CPF;
END $$

-- Para Animal
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirAnimal(
    IN p_Raca VARCHAR(50),
    IN p_statusVac BOOLEAN,
    IN p_statusDisp BOOLEAN
)
BEGIN
    INSERT INTO Animal (Raca, statusVac, statusDisp) 
    VALUES (p_Raca, p_statusVac, p_statusDisp);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarAnimal(
    IN p_id_animal INT,
    IN p_Raca VARCHAR(50),
    IN p_statusVac BOOLEAN,
    IN p_statusDisp BOOLEAN
)
BEGIN
    UPDATE Animal 
    SET Raca = p_Raca, statusVac = p_statusVac, statusDisp = p_statusDisp 
    WHERE id_animal = p_id_animal;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirAnimal(IN p_id_animal INT)
BEGIN
    DELETE FROM Animal WHERE id_animal = p_id_animal;
END $$

-- Para ConsultaVeterinaria
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirConsulta(
    IN p_dataConsulta DATE,
    IN p_Notas TEXT,
    IN p_Procedimentos TEXT,
    IN p_CPF_Veterinario VARCHAR(11),
    IN p_id_animal INT
)
BEGIN
    INSERT INTO ConsultaVeterinaria (dataConsulta, Notas, Procedimentos, CPF_Veterinario, id_animal) 
    VALUES (p_dataConsulta, p_Notas, p_Procedimentos, p_CPF_Veterinario, p_id_animal);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarConsulta(
    IN p_id_consulta INT,
    IN p_dataConsulta DATE,
    IN p_Notas TEXT,
    IN p_Procedimentos TEXT
)
BEGIN
    UPDATE ConsultaVeterinaria 
    SET dataConsulta = p_dataConsulta, Notas = p_Notas, Procedimentos = p_Procedimentos
    WHERE id_consulta = p_id_consulta;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirConsulta(IN p_id_consulta INT)
BEGIN
    DELETE FROM ConsultaVeterinaria WHERE id_consulta = p_id_consulta;
END $$

-- Para Historico_Adocoes
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirAdocao(
    IN p_dataAdocao DATE,
    IN p_id_animal INT,
    IN p_CPF_Adotante VARCHAR(11)
)
BEGIN
    INSERT INTO Historico_Adocoes (dataAdocao, id_animal, CPF_Adotante) 
    VALUES (p_dataAdocao, p_id_animal, p_CPF_Adotante);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarAdocao(
    IN p_id_adocao INT,
    IN p_dataAdocao DATE
)
BEGIN
    UPDATE Historico_Adocoes 
    SET dataAdocao = p_dataAdocao 
    WHERE id_adocao = p_id_adocao;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirAdocao(IN p_id_adocao INT)
BEGIN
    DELETE FROM Historico_Adocoes WHERE id_adocao = p_id_adocao;
END $$

-- Para AreaAdocoes
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirAreaAdocao(
    IN p_id_animal INT,
    IN p_nome_animal VARCHAR(100),
    IN p_idade VARCHAR(10),
    IN p_descricao TEXT,
    IN p_status_adocao BOOLEAN,
    IN p_data_resgate DATE
)
BEGIN
    INSERT INTO AreaAdocoes (id_animal, nome_animal, idade, descricao, status_adocao, data_resgate) 
    VALUES (p_id_animal, p_nome_animal, p_idade, p_descricao, p_status_adocao, p_data_resgate);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarAreaAdocao(
    IN p_id_area INT,
    IN p_nome_animal VARCHAR(100),
    IN p_idade VARCHAR(10),
    IN p_descricao TEXT,
    IN p_status_adocao BOOLEAN,
    IN p_data_resgate DATE
)
BEGIN
    UPDATE AreaAdocoes 
    SET nome_animal = p_nome_animal, idade = p_idade, descricao = p_descricao, 
        status_adocao = p_status_adocao, data_resgate = p_data_resgate
    WHERE id_area = p_id_area;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirAreaAdocao(IN p_id_area INT)
BEGIN
    DELETE FROM AreaAdocoes WHERE id_area = p_id_area;
END $$

-- Para Feedback
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirFeedback(
    IN p_Tipo VARCHAR(50),
    IN p_Descricao TEXT,
    IN p_Data DATE,
    IN p_Rating INT,
    IN p_Remetente VARCHAR(255),
    IN p_id_area INT
)
BEGIN
    INSERT INTO Feedback (Tipo, Descricao, Data, Rating, Remetente, id_area) 
    VALUES (p_Tipo, p_Descricao, p_Data, p_Rating, p_Remetente, p_id_area);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarFeedback(
    IN p_id_feedback INT,
    IN p_Tipo VARCHAR(50),
    IN p_Descricao TEXT,
    IN p_Rating INT
)
BEGIN
    UPDATE Feedback 
    SET Tipo = p_Tipo, Descricao = p_Descricao, Rating = p_Rating
    WHERE id_feedback = p_id_feedback;
END $$

-- Exclusão
CREATE PROCEDURE excluirFeedback(IN p_id_feedback INT)
BEGIN
    DELETE FROM Feedback WHERE id_feedback = p_id_feedback;
END $$

-- Para InfoVacinas
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirVacina(
    IN p_nome_vacina VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO Infovacinas (nome_vacina, descricao) 
    VALUES (p_nome_vacina, p_descricao);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarVacina(
    IN p_id_vacina INT,
    IN p_nome_vacina VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    UPDATE Infovacinas 
    SET nome_vacina = p_nome_vacina, descricao = p_descricao 
    WHERE id_vacina = p_id_vacina;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirVacina(IN p_id_vacina INT)
BEGIN
    DELETE FROM Infovacinas WHERE id_vacina = p_id_vacina;
END $$

-- Para Vacina
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirVacina(
    IN p_id_veterinario VARCHAR(11),  -- CPF do veterinário
    IN p_id_animal INT,               -- ID do animal
    IN p_id_vacina INT,               -- ID da vacina da tabela Infovacinas
    IN p_data_vacinacao DATE
)
BEGIN
    INSERT INTO Vacina (id_veterinario, id_animal, id_vacina, data_vacinacao)
    VALUES (p_id_veterinario, p_id_animal, p_id_vacina, p_data_vacinacao);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarVacina(
    IN p_id_vacina INT,
    IN p_id_veterinario VARCHAR(11),
    IN p_id_animal INT,
    IN p_data_vacinacao DATE
)
BEGIN
    UPDATE Vacina
    SET id_veterinario = p_id_veterinario, id_animal = p_id_animal, data_vacinacao = p_data_vacinacao
    WHERE id_vacina = p_id_vacina;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirVacina(IN p_id_vacina INT)
BEGIN
    DELETE FROM Vacina WHERE id_vacina = p_id_vacina;
END $$

-- Para Blog
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirBlog(
    IN p_titulo VARCHAR(255),
    IN p_conteudo TEXT,
    IN p_data_criacao DATE,
    IN p_autor_id INT
)
BEGIN
    INSERT INTO Blog (titulo, conteudo, data_criacao, autor_id) 
    VALUES (p_titulo, p_conteudo, p_data_criacao, p_autor_id);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarBlog(
    IN p_id_blog INT,
    IN p_titulo VARCHAR(255),
    IN p_conteudo TEXT,
    IN p_data_criacao DATE,
    IN p_autor_id INT
)
BEGIN
    UPDATE Blog 
    SET titulo = p_titulo, conteudo = p_conteudo, data_criacao = p_data_criacao, autor_id = p_autor_id
    WHERE id_blog = p_id_blog;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirBlog(IN p_id_blog INT)
BEGIN
    DELETE FROM Blog WHERE id_blog = p_id_blog;
END $$

-- Para Sistema
-- Inserção
DELIMITER $$
CREATE PROCEDURE inserirSistema(
    IN p_blog VARCHAR(255),
    IN p_areaDoacao VARCHAR(255),
    IN p_infoVacinas VARCHAR(255)
)
BEGIN
    INSERT INTO Sistema (blog, areaDoacao, infoVacinas) 
    VALUES (p_blog, p_areaDoacao, p_infoVacinas);
END $$

-- Atualização
DELIMITER $$
CREATE PROCEDURE atualizarSistema(
    IN p_id INT,
    IN p_blog VARCHAR(255),
    IN p_areaDoacao VARCHAR(255),
    IN p_infoVacinas VARCHAR(255)
)
BEGIN
    UPDATE Sistema 
    SET blog = p_blog, areaDoacao = p_areaDoacao, infoVacinas = p_infoVacinas 
    WHERE id = p_id;
END $$

-- Exclusão
DELIMITER $$
CREATE PROCEDURE excluirSistema(IN p_id INT)
BEGIN
    DELETE FROM Sistema WHERE id = p_id;
END $$

DELIMITER ;

-- TRIGGERS

-- Atualizar o status de disponibilidade do animal quando ele for adotado:
DELIMITER $$
CREATE TRIGGER AtualizaStatusAnimal
AFTER INSERT ON Historico_Adocoes
FOR EACH ROW
BEGIN
    UPDATE Animal
    SET statusDisp = FALSE
    WHERE id_animal = NEW.id_animal;
END $$

-- Inserir automaticamente a data de criação do blog:
DELIMITER $$
CREATE TRIGGER InsereDataCriacaoBlog
BEFORE INSERT ON Blog
FOR EACH ROW
BEGIN
    SET NEW.Data_criacao = CURDATE();
END $$