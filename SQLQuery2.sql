use  university
GO
---------------------------------
INSERT INTO HR01.Students
(
	id, name, surname, class, gender, birthday
)
Values
	(1, N'Nərmin', N'Qasimli', 'A6144', 'Q', 2003),
	(2, N'Leyla', N'Hüseynova', '614.24', 'Q', 2002),
	(3, N'Günay', N'Ramazanli', 'A6166', 'Q', 2003),
	(4, N'D?niz', N'Hüseynov', '614.24', 'K', 2002),
	(5, N'Baki', N'Qasimov', 'A6166', 'K', 2003),
	(6, N'Aygün', N'Qasimli', 'A6144', 'Q', 2001),
	(7, N'Ayan', N'Hüseynova', '614.24', 'Q', 2000),
	(8, N'Aygün', N'Qasimli', 'A6144', 'Q', 2001),
	(6, N'Aygün', N'Ramazanli', 'A6166', 'Q', 2004)
----------------------------------------------------------------
------------A herfi baslayanlari sorgulayin-------
select * from  
 [HR01].[Students]
 'ü?gis ü?gs                    '
 'üəğış üəğş                    '

insert into [HR01].[Students]
	(name) values (null)
	go
SELECT DISTINCT
	p.id,
    p.name,
	p.surname
FROM HR01.Students AS p
WHERE
    p.name LIKE 'A[%]';
GO

'Ayan                          '

'A_____________________________'
SELECT DISTINCT
	p.id,
    p.name,
	p.surname
FROM HR01.Students AS p
WHERE
    p.name LIKE 'A_____________________________';



SELECT DISTINCT
    p.id,
    p.name,
	p.surname
FROM HR01.Students AS p
WHERE
    p.name LIKE 'A%';
GO
-------------ID between 2 and 8 arasinda olanlari sorgula----------------
SELECT DISTINCT
	p.id,
	p.name,
	p.surname
FROM	HR01.Students AS p
WHERE
	ID between '2' and '8';
GO
-------------Birthday between 2001 and 2003 arasinda olanlari sorgula----------------
SELECT
	p.id,
	p.name,
	p.birthday
FROM HR01.Students AS p
WHERE
	birthday between '2001' and '2003'
GO

SELECT
    p.id,
    p.name,
    p.birthday
FROM HR01.Students AS p
WHERE
    ordered between '01.01.2001' and '31.12.2003';
GO

select *  FROM HR01.Students






















--------------Clustered Index yaratmaq------------
CREATE CLUSTERED INDEX IX_Students_ID
ON HR01.Students (id);

SELECT 
    name AS IndexName, 
    type_desc AS IndexType,
    is_unique AS IsUnique
FROM sys.indexes
WHERE object_id = OBJECT_ID('HR01.Students');

