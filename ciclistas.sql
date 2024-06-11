CREATE DATABASE BiKeBlitz;
USE BiKeBlitz;

-- Usuarios
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL
);

-- Publicaciones
CREATE TABLE Posts (
    PostID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Likes
CREATE TABLE Likes (
    LikeID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Comentarios
CREATE TABLE Comments (
    CommentID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    Text NVARCHAR(500) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Ubicaciones
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    Description NVARCHAR(255)
);

-- Rutas
CREATE TABLE Routes (
    RouteID INT PRIMARY KEY IDENTITY(1,1),
    RouteName NVARCHAR(100) NOT NULL,
    UserID INT NOT NULL,
    Description NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Atributos de rutas
CREATE TABLE RouteAttributes (
    AttributeID INT PRIMARY KEY IDENTITY(1,1),
    RouteID INT NOT NULL,
    Length DECIMAL(5,2),
    Difficulty NVARCHAR(50),
    ElevationGain DECIMAL(5,2),
    SurfaceType NVARCHAR(50),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);

-- Deportes
CREATE TABLE Sports (
    SportID INT PRIMARY KEY IDENTITY(1,1),
    SportName NVARCHAR(50) NOT NULL
);

-- Tipos de actividades
CREATE TABLE ActivityTypes (
    ActivityTypeID INT PRIMARY KEY IDENTITY(1,1),
    ActivityTypeName NVARCHAR(50) NOT NULL
);

-- Actividades
CREATE TABLE Activities (
    ActivityID INT PRIMARY KEY IDENTITY(1,1),
    ActivityName NVARCHAR(100) NOT NULL,
    SportID INT NOT NULL,
    ActivityTypeID INT NOT NULL,
    UserID INT NOT NULL,
    BikeModel NVARCHAR(100),
    Distance DECIMAL(5,2),
    Pace NVARCHAR(50),
    Duration NVARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (SportID) REFERENCES Sports(SportID),
    FOREIGN KEY (ActivityTypeID) REFERENCES ActivityTypes(ActivityTypeID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Retos
CREATE TABLE Challenges (
    ChallengeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    MinDuration INT,
    Frequency INT
);

-- Clubes
CREATE TABLE Clubs (
    ClubID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL
);

-- Relación entre Usuarios y Clubes
CREATE TABLE UserClubs (
    UserClubID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ClubID INT NOT NULL,
    JoinDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

-- Configuración
CREATE TABLE Configurations (
    ConfigurationID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
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
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Relación entre Retos y Usuarios
CREATE TABLE UserChallenges (
    UserChallengeID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ChallengeID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ChallengeID) REFERENCES Challenges(ChallengeID)
);

-- Relación entre Actividades y Rutas
CREATE TABLE ActivityRoutes (
    ActivityRouteID INT PRIMARY KEY IDENTITY(1,1),
    ActivityID INT NOT NULL,
    RouteID INT NOT NULL,
    FOREIGN KEY (ActivityID) REFERENCES Activities(ActivityID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);

-- Insertar deportes
INSERT INTO Sports (SportName) VALUES ('Ciclismo'), ('Correr'), ('Caminata'), ('Senderismo');

-- Insertar tipos de actividades
INSERT INTO ActivityTypes (ActivityTypeName) VALUES ('Carrera'), ('Entrenamiento'), ('Desplazamiento');

-- Insertar datos de ejemplo en la tabla retos
INSERT INTO Challenges (Name, Description, StartDate, EndDate, MinDuration, Frequency)
VALUES 
('Reto de abril: Racha de Actividades', 'Participa en el reto de abril completando tres actividades de al menos 15 minutos cada una, por semana, durante cuatro semanas. ¡Muestra tu consistencia y gana premios virtuales!', '2024-04-01', '2024-04-28', 15, 3),
('Le Col Classics', 'Únete a Le Col Classics y desafíate con carreras de larga distancia. Perfecto para aquellos que buscan mejorar su resistencia y velocidad.', NULL, NULL, NULL, NULL),
('Running Up for Air', 'Participa en el reto de Running Up for Air, diseñado para corredores y ciclistas que desean probar su límite en alturas y condiciones desafiantes.', NULL, NULL, NULL, NULL);

-- Insertar datos de ejemplo en la tabla clubes
INSERT INTO Clubs (Name, Description)
VALUES 
('Club de Ciclismo A', 'Un club dedicado a los entusiastas del ciclismo de carretera.'),
('Club de Ciclismo B', 'Un club para aquellos interesados en el ciclismo de montaña.');
