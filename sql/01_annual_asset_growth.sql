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