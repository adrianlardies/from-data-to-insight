WITH year_end_prices AS (
    SELECT 
        year(d.date) AS year,
        a.price_sp500
    FROM 
        assets a
    JOIN 
        dates d ON a.id_date = d.id_date
    WHERE 
        d.date IN (SELECT MAX(d2.date) FROM dates d2 GROUP BY year(d2.date))
),
yearly_inflation AS (
    SELECT
        year(d.date) AS year,
        AVG(e.inflation) AS avg_inflation
    FROM
        economic_factors e
    JOIN
        dates d ON e.id_date = d.id_date
    GROUP BY 
        year(d.date)
)
SELECT 
    p.year,
    p.price_sp500,
    ROUND((p.price_sp500 - LAG(p.price_sp500) OVER (ORDER BY p.year)) / LAG(p.price_sp500) OVER (ORDER BY p.year) * 100, 2) AS sp500_growth,
    i.avg_inflation
FROM 
    year_end_prices p
JOIN
    yearly_inflation i ON p.year = i.year
ORDER BY 
    p.year;