CREATE DATABASE diosolo;
USE diosolo;

-- Tabela de Clientes
CREATE TABLE clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    FedId CHAR(11) NOT NULL COMMENT '1 CPF por pessoa',
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Tabela de Veículos
CREATE TABLE vehicles (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    CarModel VARCHAR(50) NOT NULL,
    CarBrand VARCHAR(50),
    CarColor VARCHAR(20),
    LicensePlate CHAR(8) NOT NULL UNIQUE,
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- Tabela de Mecânicos
CREATE TABLE mechanics (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    Mname VARCHAR(50) NOT NULL,
    MFedId CHAR(11) NOT NULL UNIQUE,
    HourlyRate DECIMAL(10, 2)
);

-- Tabela de Peças de Reposição
CREATE TABLE autoParts (
    idPart INT AUTO_INCREMENT PRIMARY KEY,
    PartName VARCHAR(100) NOT NULL UNIQUE,
    PartCost DECIMAL(10, 2),
    PartStatus ENUM('Disponível', 'Fora de Estoque', 'Solicitado') DEFAULT 'Disponível'
);

-- Tabela de Solicitações de Serviço
CREATE TABLE serviceRequests (
    idRequest INT AUTO_INCREMENT PRIMARY KEY,
    idVehicle INT,
    RequestType VARCHAR(50) DEFAULT 'Reparo',
    Description TEXT NOT NULL,
    Status ENUM('Aprovado', 'Em Andamento', 'Cancelado', 'Concluído') DEFAULT 'Aprovado',
    FOREIGN KEY (idVehicle) REFERENCES vehicles(idVehicle)
);

-- Tabela de Serviços de Mecânicos
CREATE TABLE mechanicService (
    idMService INT AUTO_INCREMENT PRIMARY KEY,
    idRequest INT,
    idMechanic INT,
    WorkHours DECIMAL(5, 2),
    FOREIGN KEY (idRequest) REFERENCES serviceRequests(idRequest),
    FOREIGN KEY (idMechanic) REFERENCES mechanics(idMechanic)
);

-- Tabela de Peças de Serviço
CREATE TABLE partService (
    idPService INT AUTO_INCREMENT PRIMARY KEY,
    idRequest INT,
    idPart INT,
    PQuantity INT,
    FOREIGN KEY (idRequest) REFERENCES serviceRequests(idRequest),
    FOREIGN KEY (idPart) REFERENCES autoParts(idPart)
);

-- Tabela de Pagamentos
CREATE TABLE payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    PaymentMethod ENUM('Crédito', 'Débito', 'Transferência', 'Dinheiro'),
    PaymentStatus ENUM('Pendente', 'Concluído', 'Estornado') DEFAULT 'Pendente',
    FOREIGN KEY (idClient) REFERENCES clients(idClient)
);
