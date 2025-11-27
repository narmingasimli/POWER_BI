CREATE DATABASE advanced_;

USE advanced_;

CREATE SCHEMA HR;
---------------------------------------------
CREATE TABLE HR.monthly_data (
    month_ VARCHAR(20),
    id INT,
    column_m VARCHAR(50),
    column_n VARCHAR(50)
);
---------------------------------------------
--- Jan ---
INSERT INTO HR.monthly_data (month_, id, column_m, column_n) VALUES
('January', 1, 'm1', 'n1'),
('January', 2, 'm2', 'n2'),
('January', 3, 'm3', 'n3');
--- Feb ---
INSERT INTO HR.monthly_data (month_, id, column_m, column_n) VALUES
('February', 4, 'm4', 'n4'),
('February', 5, 'm5', 'n5'),
('February', 6, 'm6', 'n6');
--- Mar ---
INSERT INTO HR.monthly_data (month_, id, column_m, column_n) VALUES
('March', 1, 'm1', 'n1'),
('March', 2, 'm2', 'n2'),
('March', 3, 'm3', 'n3');

SELECT * FROM HR.monthly_data
---------------------------------------------
WITH cte AS (
    SELECT 
        month_,
        COUNT(*) AS cari_cem
    FROM HR.monthly_data
    GROUP BY month_
),
cte2 AS (
    SELECT 
        month_,
        cari_cem,
        SUM(cari_cem) OVER (ORDER BY 
            CASE month_
                WHEN 'January' THEN 1
                WHEN 'February' THEN 2
                WHEN 'March' THEN 3
            END
        ) AS cumilative_cem
    FROM cte
)
SELECT * FROM cte2;
