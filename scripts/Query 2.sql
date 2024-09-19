SELECT 
    DATE_FORMAT(d.date, '%Y-%m') AS month_year,
    (SELECT AVG(a.price_bitcoin) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS avg_bitcoin,
    (SELECT STD(a.price_bitcoin) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS volatility_bitcoin,
    (SELECT AVG(a.price_gold) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS avg_gold,
    (SELECT STD(a.price_gold) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS volatility_gold,
    (SELECT AVG(a.price_sp500) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS avg_sp500,
    (SELECT STD(a.price_sp500) FROM assets a WHERE DATE_FORMAT(d.date, '%Y-%m') = DATE_FORMAT(d.date, '%Y-%m')) AS volatility_sp500
FROM 
    dates d
GROUP BY 
    month_year
ORDER BY 
    month_year;
    
    
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
