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
email VARCHAR(45) NOT NULL,
senha VARCHAR(45) NOT NULL,
telefone CHAR(9),
fkEmpresa INT,
CONSTRAINT fkempresaUsuario FOREIGN KEY (fkEmpresa) REFERENCES EMPRESA(idEmpresa)
);

CREATE TABLE Mensagem (
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
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
CONSTRAINT empresaVeiculo FOREIGN KEY (fkEmpresaVeiculo) REFERENCES EMPRESA(idEmpresa),
fkSensor INT,
CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES SENSOR(idSensor),
fkVacina INT,
CONSTRAINT vacinaVeiculo FOREIGN KEY (fkVacina) REFERENCES Vacina(idVacina)
);

CREATE TABLE REGISTRO (
idRegistro INT NOT NULL,
dataHora DATETIME,
dht11Umidade DECIMAL (4,2),
dht11Temperatura DECIMAL (4,2),
fkSensorRegistro INT,
CONSTRAINT sensorRegistro FOREIGN KEY (fkSensorRegistro) REFERENCES SENSOR(idSensor),
fkVacinaRegistro INT,
CONSTRAINT vacinaRegistro FOREIGN KEY (fkVacinaRegistro) REFERENCES Vacina(idVacina),
fkUsuarioRepresentante INT,
CONSTRAINT usuarioRepresentante FOREIGN KEY (fkUsuarioRepresentante) REFERENCES USUARIO (idUsuario)
);