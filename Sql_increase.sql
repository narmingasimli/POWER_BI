WITH t AS (
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
CTE AS (
    SELECT Id, number,
           LAG(number) OVER (ORDER BY Id) AS add_number
    FROM t
)
SELECT Id,
       CASE 
           WHEN number IS NULL THEN ISNULL(add_number + 10, 50) 
           ELSE number
       END AS final_number
FROM CTE;






-------------LAG---eyni sütundakı əvvəlki sətirin dəyərini əldə etmək-----------------