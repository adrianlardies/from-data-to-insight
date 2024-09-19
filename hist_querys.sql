-- Query history
-- Create the database
CREATE DATABASE financial_analysis;

-- Use the newly created database
USE financial_analysis;

-- Create date table
CREATE TABLE dates (
id_date INT AUTO_INCREMENT PRIMARY KEY,
date DATE NOT NULL
);

-- Create asset table (Bitcoin, Gold, S&P 500)
CREATE TABLE assets (
id_date INT PRIMARY KEY,
price_bitcoin DECIMAL(10, 2),
price_gold DECIMAL(10, 2),
price_sp500 DECIMAL(10, 2),
change_bitcoin DECIMAL(5, 2),
change_gold DECIMAL(5, 2),
FOREIGN KEY (id_date) REFERENCES dates(id_date)
);


-- Create table of economic factors (VIX, interest rates, CPI, inflation)
CREATE TABLE economic_factors (
id_date INT PRIMARY KEY,
vix DECIMAL(5, 2),
interest_rate DECIMAL(5, 2),
cpi DECIMAL(10, 2),
inflation DECIMAL(5, 2),
FOREIGN KEY (id_date) REFERENCES dates(id_date)
);

-- 1. **Bitcoin, Gold and S&P 500 Annual Growth Advanced Query**
SELECT
    year(d.date) AS year,
    a.price_bitcoin,
    a.price_gold,
    a.price_sp500,
    ROUND( (a.price_bitcoin - LAG(a.price_bitcoin) OVER (ORDER BY year(d.date))) / LAG(a.price_bitcoin) OVER (ORDER BY year(d.date)) * 100, 2) AS bitcoin_growth,
    ROUND( (a.price_gold - LAG(a.price_gold) OVER (ORDER BY year(d.date))) / LAG(a.price_gold) OVER (ORDER BY year(d.date)) * 100, 2) AS gold_growth,
    ROUND( (a.price_sp500 - LAG(a.price_sp500) OVER (ORDER BY year(d.date))) / LAG(a.price_sp500) OVER (ORDER BY year(d.date)) * 100, 2) AS sp500_growth
FROM
    assets a
JOIN
    dates d ON a.id_date = d.id_date
WHERE
    d.date IN (SELECT MAX(d2.date) FROM dates d2 GROUP BY year(d2.date))
ORDER BY
    year(d.date);

-- 2.Analysis of the average and monthly volatility of assets
SELECT 
    DATE_FORMAT(d.date, '%Y-%m') AS month_year,
    AVG(a.price_bitcoin) AS avg_bitcoin,
    STD(a.price_bitcoin) AS volatility_bitcoin,
    AVG(a.price_gold) AS avg_gold,
    STD(a.price_gold) AS volatility_gold,
    AVG(a.price_sp500) AS avg_sp500,
    STD(a.price_sp500) AS volatility_sp500
FROM 
    assets a
JOIN 
    dates d ON a.id_date = d.id_date
GROUP BY 
    month_year
ORDER BY 
    month_year;
    
-- 3. Comparison of Bitcoin performance during periods of high and low interest rates
SELECT
    CASE
        WHEN e.interest_rate <= 2 THEN 'Bajas tasas de interés'
        ELSE 'Altas tasas de interés'
    END AS interest_rate_scenario,
    AVG(a.price_bitcoin) AS avg_bitcoin_price,
    STD(a.price_bitcoin) AS volatility_bitcoin
FROM
    economic_factors e
JOIN
    assets a ON e.id_date = a.id_date
GROUP BY
    interest_rate_scenario;
    
-- 4. Analysis of inflation and its relationship with the growth of the S&P 500
WITH yearly_data AS (
    SELECT 
        year(d.date) AS year,
        MAX(a.price_sp500) AS price_sp500,
        AVG(e.inflation) AS avg_inflation
    FROM 
        assets a
    JOIN 
        economic_factors e ON a.id_date = e.id_date
    JOIN 
        dates d ON a.id_date = d.id_date
    WHERE 
        d.date IN (SELECT MAX(d2.date) FROM dates d2 GROUP BY year(d2.date))
    GROUP BY 
        year(d.date)
)
SELECT 
    year,
    price_sp500,
    ROUND((price_sp500 - LAG(price_sp500) OVER (ORDER BY year)) / LAG(price_sp500) OVER (ORDER BY year) * 100, 2) AS sp500_growth,
    avg_inflation
FROM 
    yearly_data
ORDER BY 
    year;
    
-- 5.Analysis of the combined impact of volatility (VIX) and inflation on Bitcoin
SELECT
    AVG(a.price_bitcoin) AS avg_bitcoin_price,
    STD(a.price_bitcoin) AS volatility_bitcoin,
    AVG(e.vix) AS avg_vix,
    AVG(e.inflation) AS avg_inflation
FROM
    assets a
JOIN
    economic_factors e ON a.id_date = e.id_date
WHERE
    e.vix > 30 AND e.inflation > 3;