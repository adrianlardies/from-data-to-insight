SELECT
    CASE
        WHEN e.interest_rate <= 2 THEN 'Bajas tasas de interés'
        ELSE 'Altas tasas de interés'
    END AS interest_rate_scenario,
    AVG(a.price_bitcoin) AS avg_bitcoin_price,
    STD(a.price_bitcoin) AS bitcoin_price_stddev
FROM
    economic_factors e
JOIN
    assets a ON e.id_date = a.id_date
WHERE
    e.interest_rate IS NOT NULL
GROUP BY
    interest_rate_scenario;