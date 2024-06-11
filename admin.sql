CREATE DATABASE PanelDeControl;
GO

USE PanelDeControl;
GO

-- Tabla Administradores
CREATE TABLE Administradores (
    Id INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    FotoPerfil VARBINARY(MAX)
);
GO

-- Tabla Ciclistas
CREATE TABLE Ciclistas (
    Id INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL,
    ClubID INT, -- Relación con Clubes
    FOREIGN KEY (ClubID) REFERENCES Clubes(ClubID)
);
GO

-- Tabla Carreras
CREATE TABLE Carreras (
    Id INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Fecha DATE NOT NULL,
    UbicacionID INT, -- Relación con Ubicaciones
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO

-- Tabla Reportes
CREATE TABLE Reportes (
    Id INT PRIMARY KEY IDENTITY,
    Titulo VARCHAR(255) NOT NULL,
    Contenido TEXT NOT NULL,
    Fecha DATE NOT NULL
);
GO

-- Tabla Actividad Reciente
CREATE TABLE ActividadReciente (
    Id INT PRIMARY KEY IDENTITY,
    Descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL
);
GO

-- Tabla Clubes
CREATE TABLE Clubes (
    ClubID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(255) NOT NULL,
    Descripcion NVARCHAR(MAX) NOT NULL
);
GO

-- Tabla Configuraciones
CREATE TABLE Configuraciones (
    ConfiguracionID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT,
    FullName NVARCHAR(100),
    Username NVARCHAR(50),
    Email NVARCHAR(100),
    Age INT,
    Gender NVARCHAR(10),
    HeightCM INT,
    WeightKG INT,
    ExperienceLevel NVARCHAR(20),
    Language NVARCHAR(10),
    MeasurementUnits NVARCHAR(10),
    Notifications NVARCHAR(10),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
GO

-- Tabla Ubicaciones
CREATE TABLE Ubicaciones (
    UbicacionID INT PRIMARY KEY IDENTITY(1,1),
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    Descripcion NVARCHAR(255)
);
GO

-- Tabla Challenges
CREATE TABLE Challenges (
    ChallengeID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(255) NOT NULL,
    Descripcion NVARCHAR(MAX) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    MinDuration INT,
    Frequency INT
);
GO

-- Tabla Ciclistas2
CREATE TABLE Ciclistas2 (
    CiclistaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Direccion NVARCHAR(200) NOT NULL,
    Club NVARCHAR(100),
    Email NVARCHAR(100) NOT NULL
);
GO

-- Tabla Roles
CREATE TABLE Roles (
    RolID INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol NVARCHAR(50) NOT NULL
);
GO

-- Tabla Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    RolID INT,
    FOREIGN KEY (RolID) REFERENCES Roles(RolID)
);
GO

-- Tabla TicketsSoporte
CREATE TABLE TicketsSoporte (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT,
    Descripcion NVARCHAR(MAX),
    Estado NVARCHAR(50),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
GO

-- Tabla Feedback
CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT,
    Comentarios NVARCHAR(MAX),
    FechaRecepcion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
GO

-- Tabla ReglasAutomatizacion
CREATE TABLE ReglasAutomatizacion (
    ReglaID INT IDENTITY(1,1) PRIMARY KEY,
    DescripcionRegla NVARCHAR(MAX)
);
GO

-- Insertar datos de ejemplo en la tabla Roles
INSERT INTO Roles (NombreRol)
VALUES 
('Admin'),
('Soporte'),
('Usuario');
GO

-- Insertar datos de ejemplo en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Email, RolID)
VALUES 
('Georgina', 'georgina@example.com', 1),
('Juan Pérez', 'juan.perez@example.com', 2),
('María López', 'maria.lopez@example.com', 3);
GO

-- Insertar datos de ejemplo en la tabla TicketsSoporte
INSERT INTO TicketsSoporte (UsuarioID, Descripcion, Estado)
VALUES 
(2, 'Problema con el login', 'Pendiente'),
(3, 'No puedo acceder a mi cuenta', 'Resuelto');
GO

-- Insertar datos de ejemplo en la tabla Feedback
INSERT INTO Feedback (UsuarioID, Comentarios)
VALUES 
(2, 'El sistema es muy intuitivo y fácil de usar.'),
(3, 'Me gustaría que hubiera más opciones de personalización.');
GO

-- Insertar datos de ejemplo en la tabla ReglasAutomatizacion
INSERT INTO ReglasAutomatizacion (DescripcionRegla)
VALUES 
('Enviar email de bienvenida al nuevo usuario'),
('Cerrar ticket automáticamente si no hay respuesta en 7 días');
GO

-- Insertar datos de ejemplo en la tabla Clubes
INSERT INTO Clubes (Nombre, Descripcion)
VALUES 
('Club de Ciclismo A', 'Un club dedicado a los entusiastas del ciclismo de carretera.'),
('Club de Ciclismo B', 'Un club para aquellos interesados en el ciclismo de montaña.');
GO

-- Insertar datos de ejemplo en la tabla Ubicaciones
INSERT INTO Ubicaciones (Latitude, Longitude, Descripcion)
VALUES 
    (40.712776, -74.005974, 'New York City, USA'),
    (34.052235, -118.243683, 'Los Angeles, USA'),
    (41.878113, -87.629799, 'Chicago, USA'),
    (29.760427, -95.369804, 'Houston, USA'),
    (33.448376, -112.074036, 'Phoenix, USA'),
    (51.507351, -0.127758, 'London, UK'),
    (48.856613, 2.352222, 'Paris, France'),
    (35.689487, 139.691711, 'Tokyo, Japan');
GO

-- Insertar datos de ejemplo en la tabla Challenges
INSERT INTO Challenges (Nombre, Descripcion, StartDate, EndDate, MinDuration, Frequency)
VALUES 
    ('Challenge de Resistencia', 'Completa al menos 100 km en una sola salida', '2024-07-01', '2024-07-31', 100, 1),
    ('Challenge de Velocidad', 'Mantén una velocidad promedio de 30 km/h durante 1 hora', '2024-08-01', '2024-08-31', 1, 1),
    ('Challenge de Altitud', 'Acumula 2000 metros de ascenso en un mes', '2024-09-01', '2024-09-30', 2000, 1);
GO

-- Insertar datos de ejemplo en la tabla Configuraciones
INSERT INTO Configuraciones (UsuarioID, FullName, Username, Email, Age, Gender, HeightCM, WeightKG, ExperienceLevel, Language, MeasurementUnits, Notifications)
VALUES 
    (1, 'Georgina', 'georgina', 'georgina@example.com', 30, 'Female', 170, 60, 'Intermediate', 'EN', 'Metric', 'ON'),
    (2, 'Juan Pérez', 'juanp', 'juan.perez@example.com', 25, 'Male', 180, 75, 'Beginner', 'ES', 'Metric', 'ON'),
    (3, 'María López', 'marial', 'maria.lopez@example.com', 28, 'Female', 165, 55, 'Advanced', 'EN', 'Imperial', 'OFF');
GO

-- Relación entre Ciclistas y Clubes
ALTER TABLE Ciclistas
ADD ClubID INT,
FOREIGN KEY (ClubID) REFERENCES Clubes(ClubID);
GO

-- Relación entre Carreras y Ubicaciones
ALTER TABLE Carreras
ADD UbicacionID INT,
FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID);
GO

-- Relación entre Configuraciones y Usuarios
ALTER TABLE Configuraciones
ADD UsuarioID INT,
FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID);
GO

-- Crear relación entre Challenges y Ciclistas
CREATE TABLE CiclistaChallenges (
    CiclistaChallengeID INT PRIMARY KEY IDENTITY(1,1),
    CiclistaID INT,
    ChallengeID INT,
    FOREIGN KEY (CiclistaID) REFERENCES Ciclistas(Id),
    FOREIGN KEY (ChallengeID) REFERENCES Challenges(ChallengeID)
);
GO

