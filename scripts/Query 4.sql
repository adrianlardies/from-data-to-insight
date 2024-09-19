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