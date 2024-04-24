-- Crear la base de datos "Ciclismo1"
CREATE DATABASE Ciclismo1;
-- Usar la base de datos recién creada
USE Ciclismo1;

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del usuario
    nombre_usuario NVARCHAR(50) NOT NULL, -- Nombre del usuario
    correo_electrónico NVARCHAR(100) NOT NULL, -- Correo electrónico del usuario
    contraseña_hash NVARCHAR(100) NOT NULL, -- Hash de la contraseña del usuario
    fecha_de_registro DATE NOT NULL, -- Fecha de registro del usuario
    género NVARCHAR(10) NOT NULL, -- Género del usuario
    fecha_de_nacimiento DATE NOT NULL, -- Fecha de nacimiento del usuario
    ubicación NVARCHAR(100), -- Ubicación del usuario
    foto_de_perfil NVARCHAR(255), -- Ruta de la foto de perfil del usuario
    descripción_perfil NVARCHAR(MAX), -- Descripción del perfil del usuario
    configuraciones_notificaciones NVARCHAR(MAX) -- Configuraciones de notificaciones del usuario
);

-- Tabla: Actividades
CREATE TABLE Actividades (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la actividad
    id_usuario INT, -- Identificador del usuario que realizó la actividad
    tipo_actividad NVARCHAR(50) NOT NULL, -- Tipo de actividad (ej. ciclismo, carrera, etc.)
    subtipo_actividad NVARCHAR(50), -- Subtipo de actividad (opcional)
    título NVARCHAR(100), -- Título de la actividad
    descripción NVARCHAR(MAX), -- Descripción de la actividad
    distancia FLOAT NOT NULL, -- Distancia recorrida en la actividad
    duración TIME NOT NULL, -- Duración de la actividad
    fecha_hora_inicio DATETIME NOT NULL, -- Fecha y hora de inicio de la actividad
    fecha_hora_fin DATETIME NOT NULL, -- Fecha y hora de fin de la actividad
    ubicación_inicio NVARCHAR(100), -- Ubicación de inicio de la actividad
    ubicación_fin NVARCHAR(100), -- Ubicación de fin de la actividad
    ruta_GPS NVARCHAR(MAX), -- Ruta GPS seguida durante la actividad
    altitud FLOAT, -- Altitud alcanzada durante la actividad
    velocidad_media FLOAT NOT NULL, -- Velocidad media durante la actividad
    velocidad_máxima FLOAT NOT NULL, -- Velocidad máxima alcanzada durante la actividad
    ritmo_medio TIME, -- Ritmo medio durante la actividad
    calorías_quemadas INT NOT NULL, -- Calorías quemadas durante la actividad
    frecuencia_cardiaca_promedio INT, -- Frecuencia cardíaca promedio durante la actividad
    equipo_utilizado NVARCHAR(100), -- Equipo utilizado durante la actividad
    condiciones_climáticas NVARCHAR(MAX), -- Condiciones climáticas durante la actividad
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Seguimiento de Amigos
CREATE TABLE Seguimiento_Amigos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del seguimiento de amigos
    id_usuario_seguidor INT, -- Identificador del usuario que sigue a otro
    id_usuario_seguido INT, -- Identificador del usuario seguido
    estado_seguimiento NVARCHAR(20) NOT NULL, -- Estado del seguimiento (ej. pendiente, aceptado, rechazado, etc.)
    fecha_seguimiento DATETIME, -- Fecha y hora del seguimiento
    FOREIGN KEY (id_usuario_seguidor) REFERENCES Usuarios(id), -- Relación con la tabla Usuarios (usuario seguidor)
    FOREIGN KEY (id_usuario_seguido) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios (usuario seguido)
);

-- Tabla: Comentarios
CREATE TABLE Comentarios (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del comentario
    id_actividad INT, -- Identificador de la actividad relacionada
    id_usuario INT, -- Identificador del usuario que realizó el comentario
    comentario NVARCHAR(MAX) NOT NULL, -- Contenido del comentario
    fecha_hora DATETIME NOT NULL, -- Fecha y hora del comentario
    FOREIGN KEY (id_actividad) REFERENCES Actividades(id), -- Relación con la tabla Actividades
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Desafíos
CREATE TABLE Desafíos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del desafío
    nombre_desafío NVARCHAR(100) NOT NULL, -- Nombre del desafío
    descripción_desafío NVARCHAR(MAX), -- Descripción del desafío
    tipo_desafío NVARCHAR(20) NOT NULL, -- Tipo de desafío (ej. distancia, velocidad, etc.)
    valor_objetivo FLOAT NOT NULL, -- Valor objetivo del desafío
    fecha_inicio DATE NOT NULL, -- Fecha de inicio del desafío
    fecha_fin DATE NOT NULL -- Fecha de fin del desafío
);

-- Tabla: Participantes_Desafíos
CREATE TABLE Participantes_Desafíos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la participación en desafíos
    id_desafío INT, -- Identificador del desafío
    id_usuario INT, -- Identificador del usuario participante
    valor_logrado FLOAT NOT NULL, -- Valor logrado por el participante
    fecha_registro DATETIME NOT NULL, -- Fecha y hora de registro de la participación
    FOREIGN KEY (id_desafío) REFERENCES Desafíos(id), -- Relación con la tabla Desafíos
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Logros
CREATE TABLE Logros (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del logro
    id_usuario INT, -- Identificador del usuario que obtuvo el logro
    tipo_logro NVARCHAR(100) NOT NULL, -- Tipo de logro (ej. distancia recorrida, velocidad máxima alcanzada, etc.)
    valor_logro FLOAT NOT NULL, -- Valor del logro obtenido
    fecha_obtención DATE NOT NULL, -- Fecha de obtención del logro
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Equipos
CREATE TABLE Equipos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del equipo
    nombre_equipo NVARCHAR(100) NOT NULL, -- Nombre del equipo
    descripción_equipo NVARCHAR(MAX), -- Descripción del equipo
    fecha_creación DATE NOT NULL -- Fecha de creación del equipo
);

-- Tabla: Miembros_Equipo
CREATE TABLE Miembros_Equipo (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la membresía en equipo
    id_equipo INT, -- Identificador del equipo
    id_usuario INT, -- Identificador del usuario que es miembro del equipo
    rol_miembro NVARCHAR(20) NOT NULL, -- Rol del usuario en el equipo (ej. líder, miembro, etc.)
    fecha_unión DATE NOT NULL, -- Fecha de unión del usuario al equipo
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id), -- Relación con la tabla Equipos
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Publicaciones
CREATE TABLE Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la publicación
    id_usuario INT, -- Identificador del usuario que realizó la publicación
    contenido_publicación NVARCHAR(MAX) NOT NULL, -- Contenido de la publicación
    fecha_publicación DATETIME NOT NULL, -- Fecha y hora de la publicación
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: MeGusta_Publicaciones
CREATE TABLE MeGusta_Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del "Me gusta" en publicaciones
    id_publicación INT, -- Identificador de la publicación
    id_usuario INT, -- Identificador del usuario que dio "Me gusta"
    fecha_megusta DATETIME NOT NULL, -- Fecha y hora del "Me gusta"
    FOREIGN KEY (id_publicación) REFERENCES Publicaciones(id), -- Relación con la tabla Publicaciones
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Comentarios_Publicaciones
CREATE TABLE Comentarios_Publicaciones (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del comentario en publicaciones
    id_publicación INT, -- Identificador de la publicación
    id_usuario INT, -- Identificador del usuario que realizó el comentario
    contenido_comentario NVARCHAR(MAX) NOT NULL, -- Contenido del comentario
    fecha_comentario DATETIME NOT NULL, -- Fecha y hora del comentario
    FOREIGN KEY (id_publicación) REFERENCES Publicaciones(id), -- Relación con la tabla Publicaciones
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Fotos
CREATE TABLE Fotos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la foto
    id_usuario INT, -- Identificador del usuario que subió la foto
    ruta_foto NVARCHAR(255) NOT NULL, -- Ruta de la foto
    descripción_foto NVARCHAR(MAX), -- Descripción de la foto
    fecha_subida DATETIME NOT NULL, -- Fecha y hora de subida de la foto
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Rutas
CREATE TABLE Rutas (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la ruta
    id_usuario INT, -- Identificador del usuario que creó la ruta
    nombre_ruta NVARCHAR(100) NOT NULL, -- Nombre de la ruta
    descripción_ruta NVARCHAR(MAX), -- Descripción de la ruta
    distancia_ruta FLOAT NOT NULL, -- Distancia total de la ruta
    elevación_acumulada FLOAT NOT NULL, -- Elevación acumulada en la ruta
    fecha_creación_ruta DATE NOT NULL, -- Fecha de creación de la ruta
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Seguimiento_Rutas
CREATE TABLE Seguimiento_Rutas (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del seguimiento de rutas
    id_usuario INT, -- Identificador del usuario que sigue la ruta
    id_ruta INT, -- Identificador de la ruta seguida
    fecha_seguimiento DATETIME NOT NULL, -- Fecha y hora del seguimiento de la ruta
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id), -- Relación con la tabla Usuarios
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id) -- Relación con la tabla Rutas
);

-- Tabla: Eventos
CREATE TABLE Eventos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del evento
    nombre_evento NVARCHAR(100) NOT NULL, -- Nombre del evento
    descripción_evento NVARCHAR(MAX), -- Descripción del evento
    fecha_inicio DATE NOT NULL, -- Fecha de inicio del evento
    fecha_fin DATE NOT NULL, -- Fecha de fin del evento
    ubicación NVARCHAR(100) -- Ubicación del evento
);

-- Tabla: Participantes_Eventos
CREATE TABLE Participantes_Eventos (
    id INT PRIMARY KEY IDENTITY, -- Identificador único de la participación en eventos
    id_evento INT, -- Identificador del evento
    id_usuario INT, -- Identificador del usuario participante
    fecha_registro DATETIME NOT NULL, -- Fecha y hora de registro de la participación
    FOREIGN KEY (id_evento) REFERENCES Eventos(id), -- Relación con la tabla Eventos
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios
);

-- Tabla: Mensajes
CREATE TABLE Mensajes (
    id INT PRIMARY KEY IDENTITY, -- Identificador único del mensaje
    id_usuario_origen INT, -- Identificador del usuario que envió el mensaje
    id_usuario_destino INT, -- Identificador del usuario que recibió el mensaje
    contenido_mensaje NVARCHAR(MAX) NOT NULL, -- Contenido del mensaje
    fecha_envío DATETIME NOT NULL, -- Fecha y hora de envío del mensaje
    FOREIGN KEY (id_usuario_origen) REFERENCES Usuarios(id), -- Relación con la tabla Usuarios (usuario origen)
    FOREIGN KEY (id_usuario_destino) REFERENCES Usuarios(id) -- Relación con la tabla Usuarios (usuario destino)
);
