CREATE DATABASE vaccinTherm;
USE vaccinTherm;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
cnpj char(14) NOT NULL
); 

CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(45) NOT NULL,
telefone CHAR(11),
fkEmpresa INT,
CONSTRAINT fkempresaUsuario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Mensagem (
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
nomeCompleto VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL,
telefone CHAR(9) NOT NULL,
mensagem VARCHAR(300) NOT NULL
);


CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
especialidade VARCHAR(45),
status VARCHAR(30),
CONSTRAINT chkSensor CHECK (status in ('Habiitado', 'Desabilitado'))
);

 
CREATE TABLE Vacina (
idVacina INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
tipo VARCHAR(45),
temperaturaMaximaSuportada DECIMAL(4,2),
temperaturaMinimaSuportada DECIMAL(4,2),
umidadeMaximaSuportada INT,
umidadeMinimaSuportada INT
);


CREATE TABLE Veiculo (
idVeiculo INT NOT NULL,
dataEntrega date NOT NULL,
CONSTRAINT pkComposta PRIMARY KEY (idVeiculo, dataEntrega),
placa VARCHAR(45) NOT NULL,
modeloVeiculo VARCHAR(45),
responsavel VARCHAR(45) NOT NULL,
fkEmpresaVeiculo INT,
CONSTRAINT empresaVeiculo FOREIGN KEY (fkEmpresaVeiculo) REFERENCES Empresa(idEmpresa),
fkSensor INT,
CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
fkVacina INT,
CONSTRAINT vacinaVeiculo FOREIGN KEY (fkVacina) REFERENCES Vacina(idVacina)
);

CREATE TABLE Registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
dataHora DATETIME,
dht11Umidade DECIMAL(4,2),
dht11Temperatura DECIMAL(4,2),
fkSensorRegistro INT,
CONSTRAINT sensorRegistro FOREIGN KEY (fkSensorRegistro) REFERENCES Sensor(idSensor),
fkVacinaRegistro INT,
CONSTRAINT vacinaRegistro FOREIGN KEY (fkVacinaRegistro) REFERENCES Vacina(idVacina),
fkUsuarioRepresentante INT,
CONSTRAINT usuarioRepresentante FOREIGN KEY (fkUsuarioRepresentante) REFERENCES Usuario(idUsuario),
fkVeiculoRegistro INT,
dataEntrega DATE,
CONSTRAINT veiculoRegistro FOREIGN KEY (fkVeiculoRegistro, dataEntrega) REFERENCES Veiculo(idVeiculo, dataEntrega)
);

CREATE TABLE Avisos (
idAlerta INT,
ideal VARCHAR(45),
alerta VARCHAR(45),
emergencia VARCHAR(45),
fkRegistro INT,
CONSTRAINT registoAvisos FOREIGN KEY (fkRegistro) REFERENCES Registro (idRegistro)
);

 
INSERT INTO Empresa (nome, cnpj) VALUES
('Empresa A', '12345678000190'),
('Empresa B', '98765432000180'),
('Empresa C', '10293847560123');

 

INSERT INTO Usuario (nome, email, senha, telefone, fkEmpresa) VALUES
('João Silva', 'joao.silva@empresaA.com', 'senha123', '123456789', 1),
('Maria Oliveira', 'maria.oliveira@empresaB.com', 'senha456', '987654321', 2),
('Carlos Souza', 'carlos.souza@empresaC.com', 'senha789', '123123123', 3);


INSERT INTO Mensagem (nomeCompleto, email, telefone, mensagem) VALUES

('Ana Pereira', 'ana.pereira@example.com', '987654321', 'Preciso de informações sobre as vacinas disponíveis.'),
('Bruno Costa', 'bruno.costa@example.com', '123456789', 'Qual é a temperatura máxima suportada pela vacina A?'),
('Clara Lima', 'clara.lima@example.com', '123123123', 'Como posso entrar em contato com o responsável pela empresa B?');


INSERT INTO Sensor (nome, especialidade, status) VALUES

('Sensor A', 'Temperatura', 'Habiitado'),
('Sensor B', 'Umidade', 'Desabilitado'),
('Sensor C', 'Temperatura e Umidade', 'Habiitado');

 

INSERT INTO Vacina (nome, tipo, temperaturaMaximaSuportada, temperaturaMinimaSuportada, umidadeMaximaSuportada, umidadeMinimaSuportada) VALUES
('Vacina A', 'COVID-19', -20.00, -80.00, 85, 35),
('Vacina B', 'Influenza', 8.00, 2.00, 60, 30),
('Vacina C', 'Hepatite B', 4.00, 2.00, 70, 40);

 
INSERT INTO Veiculo (idVeiculo, dataEntrega, placa, modeloVeiculo, responsavel, fkEmpresaVeiculo, fkSensor, fkVacina) VALUES
(1, '2024-06-15', 'ABC1234', 'Caminhão Refrigerado', 'João Silva', 1, 1, 1),
(2, '2024-06-16', 'DEF5678', 'Van Refrigerada', 'Maria Oliveira', 2, 2, 2),
(3, '2024-06-17', 'GHI9012', 'Caminhão Refrigerado', 'Carlos Souza', 3, 3, 3),
(4, '2024-06-16', 'DEF5678', 'Van Refrigerada', 'Maria Oliveira', 1, 2, 2);


INSERT INTO Registro (idRegistro, dataHora, dht11Umidade, dht11Temperatura, fkSensorRegistro, fkVacinaRegistro, fkUsuarioRepresentante) VALUES
(1, '2024-06-10 14:30:00', 45.50, 22.30, 2, 1, 1),
(2, '2024-06-11 15:00:00', 50.00, 24.00, 2, 2, 2),
(3, '2024-06-12 16:15:00', 55.25, 23.75, 2, 3, 3),
(4, '2024-06-13 17:45:00', 40.80, 21.60, 2, 1, 1),
(5, '2024-06-14 18:30:00', 48.90, 22.10, 2, 2, 2);
 
 
 INSERT INTO Registro (dataHora, dht11Umidade, dht11Temperatura, fkSensorRegistro, fkVacinaRegistro, fkUsuarioRepresentante, fkVeiculoRegistro, dataEntrega)
VALUES ('2024-07-10 10:01:00', 24.0, 18.0, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:02:00', 22.5, 17.5, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:03:00', 23.5, 18.5, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:04:00', 25.0, 19.0, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:05:00', 21.0, 17.0, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:06:00', 22.0, 16.5, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:07:00', 24.5, 18.2, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:08:00', 23.0, 17.8, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:09:00', 20.5, 16.0, 1, 1, 1, 1, '2024-06-15'),
('2024-07-10 10:22:00', 23.5, 18.5, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 10:32:00', 25.0, 19.0, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 10:42:00', 21.0, 17.0, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 10:52:00', 24.5, 18.2, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 11:12:00', 20.5, 16.0, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 11:02:00', 23.0, 17.8, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 11:22:00', 26.0, 19.5, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 11:42:00', 23.5, 18.5, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 11:32:00', 22.0, 17.0, 1, 1, 1, 4, '2024-06-16'),
('2024-07-10 10:10:00', 26.0, 19.5, 1, 1, 1, 1, '2024-06-15');

SELECT * FROM Empresa;
SELECT * FROM Usuario;
SELECT * FROM Mensagem;
SELECT * FROM Sensor;
SELECT * FROM Vacina;
SELECT * FROM Veiculo;
SELECT * FROM Registro;


SELECT idregistro, Usuario.fkEmpresa
AS idEmpresa, Registro.dht11Umidade, Registro.dht11Temperatura, DATE_FORMAT(dataHora, '%d/%m/%y às %h:%i:%s')
AS dataHora, Registro.fkVeiculoRegistro
FROM Registro JOIN Usuario ON Registro.fkUsuarioRepresentante = Usuario.idUsuario
WHERE Usuario.fkEmpresa = 1 AND Registro.fkVeiculoRegistro = 1 ORDER BY idRegistro DESC LIMIT 10;

-- ADICIONANDO O CAMPO DE STATUS NO REGISTRO
ALTER TABLE Registro ADD COLUMN status VARCHAR(45);
ALTER TABLE Registro ADD CONSTRAINT alertaStatus CHECK (status in ('Alerta', 'Emergência', 'Ideal'));

SELECT * FROM Registro;

UPDATE Registro SET status = 'Emergência' WHERE idRegistro in (1,2,3,4,5);

