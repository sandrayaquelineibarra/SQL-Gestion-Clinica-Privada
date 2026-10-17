
-- PROYECTO: GESTION DE CLINICA PRIVADA

CREATE DATABASE IF NOT EXISTS clinica_privada;
USE clinica_privada;

-- 1. Tabla de especialidades
CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Tabla de medicos
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    matricula VARCHAR(30) NOT NULL UNIQUE,
    id_especialidad INT NOT NULL,
    FOREIGN KEY (id_especialidad)
        REFERENCES especialidades(id_especialidad)
);

-- 3. Tabla de pacientes
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(30)
);

-- 4. Tabla de turnos
CREATE TABLE turnos (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    estado ENUM(
        'Pendiente',
        'Confirmado',
        'Cancelado',
        'Atendido'
    ) NOT NULL DEFAULT 'Pendiente',

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente),

    FOREIGN KEY (id_medico)
        REFERENCES medicos(id_medico),

    UNIQUE (id_medico, fecha_hora)
);

-- Cargar especialidades de ejemplo
INSERT INTO especialidades (nombre) VALUES
('Clinica medica'),
('Cardiologia'),
('Pediatria'),
('Dermatologia');

-- Cargar medicos ficticios
INSERT INTO medicos
(nombre, apellido, matricula, id_especialidad)
VALUES
('Laura', 'Gomez', 'MAT1001', 1),
('Carlos', 'Perez', 'MAT1002', 2),
('Maria', 'Lopez', 'MAT1003', 3);

-- Cargar pacientes ficticios
INSERT INTO pacientes
(dni, nombre, apellido, fecha_nacimiento, telefono)
VALUES
('30000111', 'Ana', 'Garcia', '1990-05-12', '1100000001'),
('30000222', 'Juan', 'Fernandez', '1985-08-20', '1100000002'),
('30000333', 'Sofia', 'Martinez', '2000-03-15', '1100000003');

-- Cargar turnos ficticios
INSERT INTO turnos
(id_paciente, id_medico, fecha_hora, estado)
VALUES
(1, 1, '2026-11-10 09:00:00', 'Confirmado'),
(2, 2, '2026-11-10 10:00:00', 'Pendiente'),
(3, 3, '2026-11-11 11:00:00', 'Confirmado');
SELECT *
FROM pacientes;
SELECT
    m.nombre,
    m.apellido,
    m.matricula,
    e.nombre AS especialidad
FROM medicos m
INNER JOIN especialidades e
    ON m.id_especialidad = e.id_especialidad;
  SELECT
    t.id_turno,
    p.nombre AS paciente,
    p.apellido AS apellido_paciente,
    m.nombre AS medico,
    m.apellido AS apellido_medico,
    e.nombre AS especialidad,
    t.fecha_hora,
    t.estado
FROM turnos t
INNER JOIN pacientes p
    ON t.id_paciente = p.id_paciente
INNER JOIN medicos m
    ON t.id_medico = m.id_medico
INNER JOIN especialidades e
    ON m.id_especialidad = e.id_especialidad
ORDER BY t.fecha_hora;
  SELECT *
FROM turnos
WHERE estado = 'Pendiente'
ORDER BY fecha_hora;
SELECT
    m.nombre,
    m.apellido,
    COUNT(t.id_turno) AS cantidad_turnos
FROM medicos m
LEFT JOIN turnos t
    ON m.id_medico = t.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido;
SELECT *
FROM pacientes;