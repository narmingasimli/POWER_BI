WITH a AS (
    SELECT 1 Id, 50 number UNION ALL
    SELECT 2 Id, 65 number UNION ALL
    SELECT 3 Id, 80 number UNION ALL
    SELECT 4 Id, NULL number UNION ALL
    SELECT 5 Id, 110 number UNION ALL
    SELECT 6 Id, 123 number UNION ALL
    SELECT 7 Id, NULL number UNION ALL
    SELECT 8 Id, NULL number UNION ALL
    SELECT 9 Id, 155 number UNION ALL
    SELECT 10 Id, 170 number UNION ALL
    SELECT 11 Id, 176 number UNION ALL
    SELECT 12 Id, 185 number
),
b AS (
	SELECT Id, number,
		   CASE WHEN number IS NULL THEN 1 ELSE 0 END AS sütun1,
		   CASE WHEN number IS NULL THEN 0 ELSE 1 END AS sütun2,
		   SUM(CASE WHEN number IS NULL THEN 0 ELSE 1 END) OVER (ORDER BY Id) AS sütun3
	FROM a
),
c AS (
	SELECT Id, number, sütun1, sütun2, sütun3,
		COUNT(*) OVER(PARTITION BY sütun3) AS sütun4,
		(  ROW_NUMBER() OVER(PARTITION BY sütun3 ORDER BY Id)-1  ) AS sütun6, 
		LEAD(sütun3) over(order by Id desc) sutun10
	FROM b
)
-------Umumi cagir hamisini-------------
select  *,
		sütun1 * sütun4 AS sütun5,
		sütun6,
		ISNULL(MAX(c.number) OVER(PARTITION BY sütun3), 0)*sütun1   AS sütun7,
		ISNULL(MAX(c.number) OVER(PARTITION BY sutun10), 0)*sütun1   AS sütun9
FROM c

