SELECT 
    DATE_FORMAT(d.date, '%Y-%m') AS month_year,
    AVG(a.price_bitcoin) AS avg_bitcoin,
    STD(a.price_bitcoin) AS bitcoin_price_stddev,
    AVG(a.price_gold) AS avg_gold,
    STD(a.price_gold) AS gold_price_stddev,
    AVG(a.price_sp500) AS avg_sp500,
    STD(a.price_sp500) AS sp500_price_stddev
FROM 
    assets a
JOIN 
    dates d ON a.id_date = d.id_date
GROUP BY 
    month_year
ORDER BY 
    month_year;
