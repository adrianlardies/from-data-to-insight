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