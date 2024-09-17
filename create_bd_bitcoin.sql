CREATE DATABASE Economia_Financiera;

USE Economia_Financiera;

-- Tabla para las fechas
CREATE TABLE Fecha (
    id_fecha INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL
);

-- Tabla para los activos financieros
CREATE TABLE Activos (
    id_activos INT PRIMARY KEY AUTO_INCREMENT,
    id_fecha INT,
    precio_bitcoin DECIMAL(15, 2),
    precio_oro DECIMAL(15, 2),
    precio_sp500 DECIMAL(15, 2),
    FOREIGN KEY (id_fecha) REFERENCES Fecha(id_fecha)
);

-- Tabla para los factores económicos
CREATE TABLE Factores_Economicos (
    id_factores INT PRIMARY KEY AUTO_INCREMENT,
    id_fecha INT,
    vix DECIMAL(10, 2),
    interes DECIMAL(5, 2),
    inflacion DECIMAL(5, 2),
    cpi DECIMAL(10, 2),
    FOREIGN KEY (id_fecha) REFERENCES Fecha(id_fecha)
);
SHOW TABLES;
select * from fecha;
select * from factores_economicos;
select * from activos;
-- HE MIRADO LOS LOGS Y PONE INCONSISTENCIA EN LOS DATOS, SOLO HE INTRODUCIDO LOS DATOS DE FECHA PORQUE LAS OTRAS TABLAS GENERAN EL ERROR DE INCONSISTENCIA EN EL id_fecha como que esta esperando otro formato o algo así, disculpa las mayúsculas pero es para que lo veas.
