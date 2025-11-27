WITH t AS (
    SELECT 'A' prod, 100 qty, 'in' typ, EOMONTH('2024-01-01') time UNION ALL
    SELECT 'A', 20, 'out', EOMONTH('2024-02-01') UNION ALL
    SELECT 'A', 10, 'in', EOMONTH('2024-03-01') UNION ALL
    SELECT 'A', 40, 'out', EOMONTH('2024-04-01') UNION ALL
    SELECT 'A', 30, 'out', EOMONTH('2024-05-01') UNION ALL
    SELECT 'A', 9, 'out', EOMONTH('2024-06-01') UNION ALL
    SELECT 'A', 11, 'out', EOMONTH('2024-07-01') UNION ALL
    SELECT 'A', 30, 'in', EOMONTH('2024-08-01') UNION ALL
    SELECT 'A', 3, 'in', EOMONTH('2024-09-01') UNION ALL
    SELECT 'A', 15, 'out', EOMONTH('2024-10-01') UNION ALL
    SELECT 'A', 12, 'out', EOMONTH('2024-11-01') UNION ALL
    SELECT 'A', 3, 'in', EOMONTH('2024-12-01')
),
FIFO AS (
    SELECT
        prod,
        time,
        SUM(CASE WHEN typ='in' THEN qty ELSE -qty END)
        OVER (PARTITION BY prod ORDER BY time ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rest_number,
        typ,
        qty
    FROM t
),
STOCK_AGE AS (
    SELECT 
        prod,
        time,
        qty,
        DATEDIFF(MONTH, time, '2024-12-31') AS age_months 
    FROM FIFO
    WHERE typ = 'in' AND rest_number > 0
)
SELECT 
    prod,
    SUM(CASE WHEN age_months = 0 THEN qty ELSE 0 END) AS "0 months (new stock)",
    SUM(CASE WHEN age_months = 1 THEN qty ELSE 0 END) AS "1 month old",
    SUM(CASE WHEN age_months = 2 THEN qty ELSE 0 END) AS "2 months old",
    SUM(CASE WHEN age_months = 3 THEN qty ELSE 0 END) AS "3 months old",
    SUM(CASE WHEN age_months = 4 THEN qty ELSE 0 END) AS "4 months old",
    SUM(CASE WHEN age_months > 4 THEN qty ELSE 0 END) AS "More than 4 months old",
    SUM(qty) AS "Total Stock"
FROM STOCK_AGE
GROUP BY prod
ORDER BY prod;
