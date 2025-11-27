use company
-----------------------------------------
CREATE TABLE company_sales_ (
    id INT identity,
    input_date DATE,
    report_date DATE,
    monthly_sales INT,
    cumulative_sales INT
);
-----------------------------------------
INSERT INTO company_sales_ (input_date, report_date, monthly_sales, cumulative_sales)
VALUES 
('2024-10-15', '2024-09-30', '2024-08-31', '2023-09-30', 100000, 500000);

INSERT INTO company_sales_ (input_date, report_date, monthly_sales, cumulative_sales)
VALUES 
('2024-10-15', '2024-09-30', 100000, 500000),  -- Cari ayliq v? kümülyativ satis
('2024-08-31', '2024-08-31', 90000, 400000),   -- ?vv?lki ayin satislari
('2023-09-30', '2023-09-30', 80000, 450000);

-------------Ayliq report/?vv?lki ay report ----------------------------
SELECT 
    c.report_date,    c.monthly_sales,
    (c.monthly_sales / NULLIF(b.monthly_sales, 0)) * 100 AS Ayliq_Report____Evvelki_Ay_report
FROM company_sales_ AS c, company_sales_ AS b
WHERE c.report_date = '2024-09-30' 
  AND b.report_date = '2024-08-31';

---------------Ayliq report/?vv?lki il report--------------------------
SELECT 
    c.report_date,
    c.monthly_sales,
    (c.monthly_sales / NULLIF(b.monthly_sales, 0)) * 100 AS Ayliq_Report____Evvelki_Il_report
FROM company_sales_ AS c, company_sales_ AS b
WHERE c.report_date = '2024-09-30' 
  AND b.report_date = '2023-09-30';


---------------Illik kümülyativ satis/?vv?lki ilin report --------------------------
SELECT 
    c.report_date,
    c.cumulative_sales,
    (c.cumulative_sales / NULLIF(b.cumulative_sales, 0)) * 100 AS Illik_Kumiilyativ____Evvelki_Il_report
FROM company_sales_ AS c, company_sales_ AS b
WHERE c.report_date = '2024-09-30' 
  AND b.report_date = '2023-09-30';





-----------------------------------------


























DECLARE @t DATE = '2024-10-15'; -- Sorğuda istifadə etmək üçün tarix dəyişəni elan edilir.
DECLARE @RD DATE = EOMONTH(DATEADD(MONTH, -1, @t)); -- Əvvəlki ayın son tarixi hesablanır.
DECLARE @PrevYearRD DATE = EOMONTH(DATEADD(YEAR, -1, @t)); -- Əvvəlki ilin eyni ayının son tarixi hesablanır.



SELECT 
    t1.DATE_ AS report_date,
    t1.TOTALACTIVE AS monthly_sales,
    (t1.TOTALACTIVE / NULLIF(t2.TOTALACTIVE, 0)) * 100 AS Ayliq_Report____Evvelki_Ay_report
FROM dwh.dbo.test_LGEMFICHE t1
JOIN dwh.dbo.test_LGEMFICHE t2 ON t2.DATE_ = @RD
WHERE t1.DATE_ = EOMONTH(@t, 0);



----------------------------


DECLARE @t DATE = '2024-10-15'; -- Sorğuda istifadə etmək üçün tarix dəyişəni elan edilir.
DECLARE @RD DATE = EOMONTH(DATEADD(MONTH, -1, @t)); -- Əvvəlki ayın son tarixi hesablanır.
DECLARE @PrevYearRD DATE = EOMONTH(DATEADD(YEAR, -1, @t)); -- Əvvəlki ilin eyni ayının son tarixi hesablanır.




SELECT 
    t1.DATE_ AS report_date,
    t1.TOTALACTIVE AS monthly_sales,
    (t1.TOTALACTIVE / NULLIF(t2.TOTALACTIVE, 0)) * 100 AS Ayliq_Report____Evvelki_Il_report
FROM dwh.dbo.test_LGEMFICHE t1
JOIN dwh.dbo.test_LGEMFICHE t2 ON t2.DATE_ = @PrevYearRD
WHERE t1.DATE_ = EOMONTH(@t, 0);


------------------------------


DECLARE @t DATE = '2024-10-15'; -- Sorğuda istifadə etmək üçün tarix dəyişəni elan edilir.
DECLARE @RD DATE = EOMONTH(DATEADD(MONTH, -1, @t)); -- Əvvəlki ayın son tarixi hesablanır.
DECLARE @PrevYearRD DATE = EOMONTH(DATEADD(YEAR, -1, @t)); -- Əvvəlki ilin eyni ayının son tarixi hesablanır.



SELECT 
    t1.DATE_ AS report_date,
    SUM(t1.TOTALACTIVE) AS cumulative_sales,
    (SUM(t1.TOTALACTIVE) / NULLIF(SUM(t2.TOTALACTIVE), 0)) * 100 AS Illik_Kumiilyativ____Evvelki_Il_report
FROM dwh.dbo.test_LGEMFICHE t1
JOIN dwh.dbo.test_LGEMFICHE t2 ON t2.DATE_ = @PrevYearRD
WHERE t1.DATE_ BETWEEN '2024-01-01' AND EOMONTH(@t, 0)
GROUP BY t1.DATE_;
