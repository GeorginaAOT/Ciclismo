-- Crear la base de datos "Ciclismo1"
CREATE DATABASE Ciclismo1;
-- Usar la base de datos reci�n creada
USE Ciclismo1;

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del usuario
    nombre_usuario NVARCHAR(50) NOT NULL, -- Nombre del usuario
    correo_electr�nico NVARCHAR(100) NOT NULL, -- Correo electr�nico del usuario
    contrase�a_hash NVARCHAR(100) NOT NULL, -- Hash de la contrase�a del usuario
    fecha_de_registro DATE NOT NULL, -- Fecha de registro del usuario
    g�nero NVARCHAR(10) NOT NULL, -- G�nero del usuario
    fecha_de_nacimiento DATE NOT NULL, -- Fecha de nacimiento del usuario
    ubicaci�n NVARCHAR(100), -- Ubicaci�n del usuario
    foto_de_perfil NVARCHAR(255), -- Ruta de la foto de perfil del usuario
    descripci�n_perfil NVARCHAR(MAX), -- Descripci�n del perfil del usuario
    configuraciones_notificaciones NVARCHAR(MAX) -- Configuraciones de notificaciones del usuario
);

-- Tabla: Actividades
CREATE TABLE Actividades (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la actividad
    id_usuario INT, -- Identificador del usuario que realiz� la actividad
    tipo_actividad NVARCHAR(50) NOT NULL, -- Tipo de actividad (ej. ciclismo, carrera, etc.)
    subtipo_actividad NVARCHAR(50), -- Subtipo de actividad (opcional)
    t�tulo NVARCHAR(100), -- T�tulo de la actividad
    descripci�n NVARCHAR(MAX), -- Descripci�n de la actividad
    distancia FLOAT NOT NULL, -- Distancia recorrida en la actividad
    duraci�n TIME NOT NULL, -- Duraci�n de la actividad
    fecha_hora_inicio DATETIME NOT NULL, -- Fecha y hora de inicio de la actividad
    fecha_hora_fin DATETIME NOT NULL, -- Fecha y hora de fin de la actividad
    ubicaci�n_inicio NVARCHAR(100), -- Ubicaci�n de inicio de la actividad
    ubicaci�n_fin NVARCHAR(100), -- Ubicaci�n de fin de la actividad
    ruta_GPS NVARCHAR(MAX), -- Ruta GPS seguida durante la actividad
    altitud FLOAT, -- Altitud alcanzada durante la actividad
    velocidad_media FLOAT NOT NULL, -- Velocidad media durante la actividad
    velocidad_m�xima FLOAT NOT NULL, -- Velocidad m�xima alcanzada durante la actividad
    ritmo_medio TIME, -- Ritmo medio durante la actividad
    calor�as_quemadas INT NOT NULL, -- Calor�as quemadas durante la actividad
    frecuencia_cardiaca_promedio INT, -- Frecuencia card�aca promedio durante la actividad
    equipo_utilizado NVARCHAR(100), -- Equipo utilizado durante la actividad
    condiciones_clim�ticas NVARCHAR(MAX), -- Condiciones clim�ticas durante la actividad
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Seguimiento de Amigos
CREATE TABLE Seguimiento_Amigos (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del seguimiento de amigos
    id_usuario_seguidor INT, -- Identificador del usuario que sigue a otro
    id_usuario_seguido INT, -- Identificador del usuario seguido
    estado_seguimiento NVARCHAR(20) NOT NULL, -- Estado del seguimiento (ej. pendiente, aceptado, rechazado, etc.)
    fecha_seguimiento DATETIME, -- Fecha y hora del seguimiento
    FOREIGN KEY (id_usuario_seguidor) REFERENCES Usuarios(id), -- Relaci�n con la tabla Usuarios (usuario seguidor)
    FOREIGN KEY (id_usuario_seguido) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios (usuario seguido)
);

-- Tabla: Comentarios
CREATE TABLE Comentarios (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del comentario
    id_actividad INT, -- Identificador de la actividad relacionada
    id_usuario INT, -- Identificador del usuario que realiz� el comentario
    comentario NVARCHAR(MAX) NOT NULL, -- Contenido del comentario
    fecha_hora DATETIME NOT NULL, -- Fecha y hora del comentario
    FOREIGN KEY (id_actividad) REFERENCES Actividades(id), -- Relaci�n con la tabla Actividades
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Desaf�os
CREATE TABLE Desaf�os (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del desaf�o
    nombre_desaf�o NVARCHAR(100) NOT NULL, -- Nombre del desaf�o
    descripci�n_desaf�o NVARCHAR(MAX), -- Descripci�n del desaf�o
    tipo_desaf�o NVARCHAR(20) NOT NULL, -- Tipo de desaf�o (ej. distancia, velocidad, etc.)
    valor_objetivo FLOAT NOT NULL, -- Valor objetivo del desaf�o
    fecha_inicio DATE NOT NULL, -- Fecha de inicio del desaf�o
    fecha_fin DATE NOT NULL -- Fecha de fin del desaf�o
);

-- Tabla: Participantes_Desaf�os
CREATE TABLE Participantes_Desaf�os (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la participaci�n en desaf�os
    id_desaf�o INT, -- Identificador del desaf�o
    id_usuario INT, -- Identificador del usuario participante
    valor_logrado FLOAT NOT NULL, -- Valor logrado por el participante
    fecha_registro DATETIME NOT NULL, -- Fecha y hora de registro de la participaci�n
    FOREIGN KEY (id_desaf�o) REFERENCES Desaf�os(id), -- Relaci�n con la tabla Desaf�os
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Logros
CREATE TABLE Logros (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del logro
    id_usuario INT, -- Identificador del usuario que obtuvo el logro
    tipo_logro NVARCHAR(100) NOT NULL, -- Tipo de logro (ej. distancia recorrida, velocidad m�xima alcanzada, etc.)
    valor_logro FLOAT NOT NULL, -- Valor del logro obtenido
    fecha_obtenci�n DATE NOT NULL, -- Fecha de obtenci�n del logro
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Equipos
CREATE TABLE Equipos (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del equipo
    nombre_equipo NVARCHAR(100) NOT NULL, -- Nombre del equipo
    descripci�n_equipo NVARCHAR(MAX), -- Descripci�n del equipo
    fecha_creaci�n DATE NOT NULL -- Fecha de creaci�n del equipo
);

-- Tabla: Miembros_Equipo
CREATE TABLE Miembros_Equipo (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la membres�a en equipo
    id_equipo INT, -- Identificador del equipo
    id_usuario INT, -- Identificador del usuario que es miembro del equipo
    rol_miembro NVARCHAR(20) NOT NULL, -- Rol del usuario en el equipo (ej. l�der, miembro, etc.)
    fecha_uni�n DATE NOT NULL, -- Fecha de uni�n del usuario al equipo
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id), -- Relaci�n con la tabla Equipos
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Publicaciones
CREATE TABLE Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la publicaci�n
    id_usuario INT, -- Identificador del usuario que realiz� la publicaci�n
    contenido_publicaci�n NVARCHAR(MAX) NOT NULL, -- Contenido de la publicaci�n
    fecha_publicaci�n DATETIME NOT NULL, -- Fecha y hora de la publicaci�n
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: MeGusta_Publicaciones
CREATE TABLE MeGusta_Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del "Me gusta" en publicaciones
    id_publicaci�n INT, -- Identificador de la publicaci�n
    id_usuario INT, -- Identificador del usuario que dio "Me gusta"
    fecha_megusta DATETIME NOT NULL, -- Fecha y hora del "Me gusta"
    FOREIGN KEY (id_publicaci�n) REFERENCES Publicaciones(id), -- Relaci�n con la tabla Publicaciones
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Comentarios_Publicaciones
CREATE TABLE Comentarios_Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del comentario en publicaciones
    id_publicaci�n INT, -- Identificador de la publicaci�n
    id_usuario INT, -- Identificador del usuario que realiz� el comentario
    contenido_comentario NVARCHAR(MAX) NOT NULL, -- Contenido del comentario
    fecha_comentario DATETIME NOT NULL, -- Fecha y hora del comentario
    FOREIGN KEY (id_publicaci�n) REFERENCES Publicaciones(id), -- Relaci�n con la tabla Publicaciones
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Fotos
CREATE TABLE Fotos (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la foto
    id_usuario INT, -- Identificador del usuario que subi� la foto
    ruta_foto NVARCHAR(255) NOT NULL, -- Ruta de la foto
    descripci�n_foto NVARCHAR(MAX), -- Descripci�n de la foto
    fecha_subida DATETIME NOT NULL, -- Fecha y hora de subida de la foto
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Rutas
CREATE TABLE Rutas (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la ruta
    id_usuario INT, -- Identificador del usuario que cre� la ruta
    nombre_ruta NVARCHAR(100) NOT NULL, -- Nombre de la ruta
    descripci�n_ruta NVARCHAR(MAX), -- Descripci�n de la ruta
    distancia_ruta FLOAT NOT NULL, -- Distancia total de la ruta
    elevaci�n_acumulada FLOAT NOT NULL, -- Elevaci�n acumulada en la ruta
    fecha_creaci�n_ruta DATE NOT NULL, -- Fecha de creaci�n de la ruta
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Seguimiento_Rutas
CREATE TABLE Seguimiento_Rutas (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del seguimiento de rutas
    id_usuario INT, -- Identificador del usuario que sigue la ruta
    id_ruta INT, -- Identificador de la ruta seguida
    fecha_seguimiento DATETIME NOT NULL, -- Fecha y hora del seguimiento de la ruta
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id), -- Relaci�n con la tabla Usuarios
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id) -- Relaci�n con la tabla Rutas
);

-- Tabla: Eventos
CREATE TABLE Eventos (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del evento
    nombre_evento NVARCHAR(100) NOT NULL, -- Nombre del evento
    descripci�n_evento NVARCHAR(MAX), -- Descripci�n del evento
    fecha_inicio DATE NOT NULL, -- Fecha de inicio del evento
    fecha_fin DATE NOT NULL, -- Fecha de fin del evento
    ubicaci�n NVARCHAR(100) -- Ubicaci�n del evento
);

-- Tabla: Participantes_Eventos
CREATE TABLE Participantes_Eventos (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico de la participaci�n en eventos
    id_evento INT, -- Identificador del evento
    id_usuario INT, -- Identificador del usuario participante
    fecha_registro DATETIME NOT NULL, -- Fecha y hora de registro de la participaci�n
    FOREIGN KEY (id_evento) REFERENCES Eventos(id), -- Relaci�n con la tabla Eventos
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios
);

-- Tabla: Mensajes
CREATE TABLE Mensajes (
    id INT PRIMARY KEY IDENTITY, -- Identificador �nico del mensaje
    id_usuario_origen INT, -- Identificador del usuario que envi� el mensaje
    id_usuario_destino INT, -- Identificador del usuario que recibi� el mensaje
    contenido_mensaje NVARCHAR(MAX) NOT NULL, -- Contenido del mensaje
    fecha_env�o DATETIME NOT NULL, -- Fecha y hora de env�o del mensaje
    FOREIGN KEY (id_usuario_origen) REFERENCES Usuarios(id), -- Relaci�n con la tabla Usuarios (usuario origen)
    FOREIGN KEY (id_usuario_destino) REFERENCES Usuarios(id) -- Relaci�n con la tabla Usuarios (usuario destino)
);
