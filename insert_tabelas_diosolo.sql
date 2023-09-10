-- Inserção de dados na tabela clients
INSERT INTO clients (Fname, Lname, FedId, PhoneNumber, Email) VALUES
    ('João', 'Silva', '12345678900', '123-456-7890', 'joao.silva@example.com'),
    ('Maria', 'Santos', '98765432100', '987-654-3210', 'maria.santos@example.com'),
    ('Carlos', 'Ferreira', '56789012345', '567-890-1234', 'carlos.ferreira@example.com');

-- Inserção de dados na tabela vehicles
INSERT INTO vehicles (idClient, CarModel, CarBrand, CarColor, LicensePlate) VALUES
    (1, 'Fiesta', 'Ford', 'Azul', 'ABC1234'),
    (1, 'Corolla', 'Toyota', 'Prata', 'XYZ5678'),
    (2, 'Civic', 'Honda', 'Preto', 'DEF9876');

-- Inserção de dados na tabela mechanics
INSERT INTO mechanics (Mname, MFedId, HourlyRate) VALUES
    ('Pedro Mecânico', '11122233344', 25.50),
    ('Ana Mecânica', '55566677788', 28.75),
    ('José Mecânico', '99900011122', 22.00);

-- Inserção de dados na tabela autoParts
INSERT INTO autoParts (PartName, PartCost, PartStatus) VALUES
    ('Filtro de Óleo', 15.99, 'Disponível'),
    ('Pastilhas de Freio', 32.50, 'Disponível'),
    ('Bateria 12V', 75.00, 'Fora de Estoque');

-- Inserção de dados na tabela serviceRequests
INSERT INTO serviceRequests (idVehicle, RequestType, Description, Status) VALUES
    (1, 'Reparo', 'Problema no motor', 'Aprovado'),
    (2, 'Manutenção', 'Troca de óleo', 'Em Andamento'),
    (3, 'Revisão', 'Verificação geral', 'Aprovado');

-- Inserção de dados na tabela mechanicService
INSERT INTO mechanicService (idRequest, idMechanic, WorkHours) VALUES
    (1, 1, 3.5),
    (2, 2, 2.0),
    (3, 3, 4.5);

-- Inserção de dados na tabela partService
INSERT INTO partService (idRequest, idPart, PQuantity) VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 1);

-- Inserção de dados na tabela payments
INSERT INTO payments (idClient, PaymentMethod, PaymentStatus) VALUES
    (1, 'Crédito', 'Concluído'),
    (2, 'Débito', 'Pendente'),
    (3, 'Transferência', 'Concluído');
