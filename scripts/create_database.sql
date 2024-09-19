-- Crear la base de datos
CREATE DATABASE financial_analysis;

-- Usar la base de datos recién creada
USE financial_analysis;

-- Crear la tabla de fechas
CREATE TABLE dates (
    id_date INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL
);

-- Crear la tabla de activos (Bitcoin, Oro, S&P 500)
CREATE TABLE assets (
    id_date INT PRIMARY KEY,
    price_bitcoin DECIMAL(10, 2),
    price_gold DECIMAL(10, 2),
    price_sp500 DECIMAL(10, 2),
    change_bitcoin DECIMAL(5, 2),
    change_gold DECIMAL(5, 2),
    FOREIGN KEY (id_date) REFERENCES dates(id_date)
);

-- Crear la tabla de factores económicos (VIX, tasas de interés, CPI, inflación)
CREATE TABLE economic_factors (
    id_date INT PRIMARY KEY,
    vix DECIMAL(5, 2),
    interest_rate DECIMAL(5, 2),
    cpi DECIMAL(10, 2),
    inflation DECIMAL(5, 2),
    FOREIGN KEY (id_date) REFERENCES dates(id_date)
);