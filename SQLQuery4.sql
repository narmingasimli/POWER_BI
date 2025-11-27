select
	*
from
	TT
where
	shert 1
	shert 2

-----------------------------------------
use AdventureWorks2017 go
select * from AdventureWorks2017.Person.Person go
-------------------AND----*-Vurma-----------------
a1	a2	->	a1 and a2
0	*	0	=	0	false
1	*	0	=	0	false
0	*	1	=	0	false
1	*	1	=	1	true
0 - false
1 - true

select
	*
from AdventureWorks2017.Person.Person
where
	1 = 1 and (sert 2) and (sert 3)
go
-------------------OR-----------max-----------
a1	a2	->	a1 or a2
0	&	0		0	
1	&	0		1	
0	&	1		1	
1	&	1		1	
0 - false
1 - true

select
	*
from AdventureWorks2017.Person.Person
where
	1 = 1 or (sert 2)
go
-------Burada butun datani getirir----------------------------------
select	*
from	HR01.Persons
go
---Burada class ve gender gore kriteriya ile one cekir ve diger butun datani getirir-----
select	
	class,
	gender,
	*
from	HR01.Persons
go
-------------AND----------------------------
Select
	*
from	HR01.Persons
where
	Name = 'Aynur' and gender= 'Q'
go
---------------OR------------------------------
use university
go

select
	*
from	HR01.Persons
where
	name = 'Aynur' or birthday = '2002-12-03'
go
-----------------------------------------------------------------------------------------------------------------------------------------------------
---------AdventureWorks2017 kecid et-----
use AdventureWorks2017
go

select	*	from AdventureWorks2017.Person.Person	go
---AND-----2 sertin arasinda (hemde) sohbeti varsa (AND) olmalidir, (ya yada) varsa (OR) olmalidir
select
	BusinessEntityID,
	PersonType,
	NameStyle,
	Title,
	FirstName,
	MiddleName,
	Lastname
from	AdventureWorks2017.Person.Person
where
	PersonType = 'EM' and title = 'Ms.' and EmailPromotion = '0'
go
---OR-----2 sertin arasinda (ya)(yada) varsa (OR) olmalidir, (hemde)(hemde mutleq) sohbeti varsa (AND) olmalidir
----AND OR---
select
	BusinessEntityID,
	PersonType,
	NameStyle,
	Title,
	FirstName,
	MiddleName,
	Lastname
from	AdventureWorks2017.Person.Person
where
	(PersonType = 'EM' and MiddleName = 'A') or FirstName = 'Ken'
order by BusinessEntityID desc;
go
---- OR AND---
select
	BusinessEntityID,
	PersonType,
	NameStyle,
	Title,
	FirstName,
	MiddleName,
	Lastname
from	AdventureWorks2017.Person.Person
where
	(PersonType = 'EM' or MiddleName = 'A') and FirstName = 'Ken'
go
-----------(2+2)*2-2=?-----(2+2*2-2
use AdventureWorks2017 go
select * from	AdventureWorks2017.Person.Person go
select * from	AdventureWorks2017.Production.Product go


select TOP 10
	p.name,
	p.MakeFlag,
	p.FinishedGoodsFlag
from	AdventureWorks2017.Production.Product as p
where
	MakeFlag = '0' and FinishedGoodsFlag = '1'
go
-------cemi 1den boyuk olanlari cixar---------------
select * from	AdventureWorks2017.Production.Product where name = 'HL Road Frame - Black, 58'

select TOP 10
	p.name,
	p.MakeFlag,
	p.FinishedGoodsFlag
from	AdventureWorks2017.Production.Product as p
where
	CAST(MakeFlag as INT) + CAST(FinishedGoodsFlag as INT)  > 1;
go
----------yeni sutun yarat ve butun cemler dussun ora------------
select
	p.name,
	p.MakeFlag,
	p.FinishedGoodsFlag,
	CAST(p.MakeFlag AS INT) + CAST(p.FinishedGoodsFlag AS INT) AS NewColumn
from	AdventureWorks2017.Production.Product as p
go
----cemi 1den boyuk olan yeni TotalSum yarat----------
select 
    p.Name,
    p.MakeFlag,
    p.FinishedGoodsFlag,
    CAST(p.MakeFlag AS INT) + CAST(p.FinishedGoodsFlag AS INT) AS TotalSum 
from 
    AdventureWorks2017.Production.Product AS p
where
	CAST(p.MakeFlag as INT) + CAST(p.FinishedGoodsFlag as INT)  > 1;
go
----cemi 1e beraber olan---------------
select 
    p.Name,
    p.MakeFlag,
    p.FinishedGoodsFlag,
    CAST(p.MakeFlag AS INT) + CAST(p.FinishedGoodsFlag AS INT) AS ColumnSum 
from 
    AdventureWorks2017.Production.Product AS p
where
	(CAST(MakeFlag as INT) + CAST(FinishedGoodsFlag as INT) ) = 1;
go
----------SafetyStockLevel orta leveli tap-------
select * from AdventureWorks2017.Production.Product

select
	AVG(SafetyStockLevel) as average_salary
from	AdventureWorks2017.Production.Product
go
--------500 den cox 800den az olanlari sorgula------
select * from AdventureWorks2017.Production.Product

select distinct
	p.SafetyStockLevel
from	AdventureWorks2017.Production.Product as p
where
	SafetyStockLevel between 500 and 800
go
-----Table da color one cixar ve makeflag 0 olanlari sorgula-----
select * from AdventureWorks2017.Production.Product

select
	p.name,
	p.color,
	p.MakeFlag,
	p.DaysToManufacture,
	p.FinishedGoodsFlag
from	AdventureWorks2017.Production.Product as p
where
	p.MakeFlag = '0' and p.color  is null;
go
----en yuksek safetystockleve yuksek olan adamin name cixar----
select * from	AdventureWorks2017.Production.Product

select	distinct
	p.name,
	p.Class,
	p.SafetyStockLevel,
	p.Color,
	p.DaysToManufacture,
	p.DiscontinuedDate,
	p.FinishedGoodsFlag,
	p.ListPrice,
	p.MakeFlag
from AdventureWorks2017.Production.Product as p
where
	p.SafetyStockLevel = (Select max(SafetyStockLevel) from AdventureWorks2017.Production.Product)
go
-----safetystockLevel orta qiymetin tap + makeflag gel sorgula----
select 
	p.SafetyStockLevel,
	p.MakeFlag
from	AdventureWorks2017.Production.Product as p
go

select
	p.SafetyStockLevel,
	p.MakeFlag,
	cast(avg(SafetyStockLevel) as INT) + cast(p.MakeFlag as INT) as middle
from	AdventureWorks2017.Production.Product as p
group by p.SafetyStockLevel, p.MakeFlag
go


select
	p.SafetyStockLevel,
	p.MakeFlag,
	AVG(SafetyStockLevel) as average,
	cast(avg(SafetyStockLevel) as INT) + cast(p.MakeFlag as INT) as middle
from	AdventureWorks2017.Production.Product as p
group by p.SafetyStockLevel, p.MakeFlag
go



select tt.MakeFlag, tt.SafetyStockLevel, tt.average , tt.average  + cast(tt.MakeFlag as int) as middle from
(select
	p.SafetyStockLevel,
	p.MakeFlag,
	AVG(SafetyStockLevel) as average
	-- ,average  + cast(p.MakeFlag as int) as middle
from	AdventureWorks2017.Production.Product as p
group by p.SafetyStockLevel, p.MakeFlag) tt
go
-----1 unikal data getir-----
select	TOP 1
    p.name,
	p.Class,
	p.SafetyStockLevel,
	p.Color,
	p.DaysToManufacture,
	p.DiscontinuedDate,
	p.FinishedGoodsFlag,
	p.ListPrice,
	p.MakeFlag
from AdventureWorks2017.Production.Product as p
order by NEWID();
go
--------A ile baslayan name kodu tap AND MakeFlag 0 olan birlesdir
select * from	AdventureWorks2017.Production.Product

select distinct
	p.name,
	p.Class,
	p.SafetyStockLevel,
	p.MakeFlag
from AdventureWorks2017.Production.Product as p
where name like 'A%' and p.MakeFlag = '0'
go
----SafetyStockLevel 1000 olmayan AND FinishedGoodsFlag 0 olan birlesdir
select distinct
	p.name,
	p.Class,
	p.SafetyStockLevel,
	p.MakeFlag,
	p.FinishedGoodsFlag
from	AdventureWorks2017.Production.Product as p
where
	NOT SafetyStockLevel = '1000' and FinishedGoodsFlag = '0';
go
----------------------------------------------------------------------
------------------------04.12.2024------------------------------------
----------------------------------------------------------------------
---nvl arasdir

-----------DB kecid et-----------------------
use AdventureWorks2017
select * from AdventureWorks2017.Production.Document
---- 0   => bazada 1 bayt yer zebt edecek-------------------------------------------
----' '  => bazada 1 bayt yer zebt edecek-------------------------------------------
----NULL => sozu bazaya yazilmayib.SSMS size bucur visualliqla gosterir-------------
----NULL hec neye beraber deyil-----------------------------------------------------
----NULL - u hec bir deyerle ve ozu ile de muqayise etmek OLMAZ---------------------
----IS NULL---null=null beraber etmek OLMUR (null=bos coxluq) (<> -ferqlidir)-------
select
	p.owner,
	p.FileName,
	p.ChangeNumber,
	p.status,
	p.DocumentSummary
from AdventureWorks2017.Production.Document as p
where
	p.DocumentSummary is null
go
---IS NOT NULL-----------------null DB-dan hec vaxt sorgulamaq olmaz-----------------
select
	p.owner,
	p.FileName,
	p.ChangeNumber,
	p.status,
	p.DocumentSummary
from AdventureWorks2017.Production.Document as p
where
	p.DocumentSummary is not null
go
------------Owner 217ya da 220 sorgula---------------------------------------------
select * from AdventureWorks2017.Production.Document

select
	p.owner,
	p.FileName,
	p.ChangeNumber,
	p.status,
	p.DocumentSummary
from AdventureWorks2017.Production.Document as p
where
	p.owner = '217' or 
	p.owner = '220'
order by p.owner desc
go

------ChangeNumber ya 28 ya 25 ya 55 ya 15 sorgula-----------------
------MSSQL-de 25, M,26,Xl eyni anda orla baglamaq olur sadece MSSQL-de isleyir digerlerinde islemir---------
--(Qustar usulu)----MSSQL-de kicikle yaz boyukle yaz ona fikir vermir datani getirir--------
select
	p.owner,
	p.FileName,
	p.ChangeNumber,
	p.status,
	p.DocumentSummary
from AdventureWorks2017.Production.Document as p
where
	p.ChangeNumber = '28' or
	p.ChangeNumber = '25' or
	p.ChangeNumber = '55' or
	p.ChangeNumber = '15'
go
--IN(SQL daxili funksiyasi)----proqramlasdirmada tekrarlanan kodlar olmaz--OR AND cox arxa-arxaya yazmaq olmaz-----
select
	p.owner,
	p.FileName,
	p.ChangeNumber,
	p.status,
	p.DocumentSummary
from AdventureWorks2017.Production.Document as p
where
	p.ChangeNumber in ('15', '25', '28', '55')
go
---subquery---IN ile Birlesdir-----------------------------
select * from  AdventureWorks2017.Production.Document

select
	*
from AdventureWorks2017.Production.Document as p
where
	p.ChangeNumber in 
	(
		select p.ChangeNumber
		from AdventureWorks2017.Production.Document as p
		where
			p.ChangeNumber IN ('15', '25', '28', '55')
	)
go
-----( <> - BERABER OLMAYAN)( !=  - BERABER olmayan)------
select
	p.ChangeNumber
from AdventureWorks2017.Production.Document as p
where
	p.ChangeNumber <> '28' and
	p.ChangeNumber != '25' 
go
----not in----------Beraber olmayanlari gosterir------------------
select
	p.ChangeNumber
from AdventureWorks2017.Production.Document as p
where
	p.ChangeNumber not in ('15', '28', '55')
order by ChangeNumber desc
go
--Like START--File Extension-u baslangici '.doc' olanlarin siyahisini cixarin------------
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.FileExtension like '.%'
go
--Like FINISH--File Extension-u sonu 'c' ile bitenlerin siyahisini cixarin------------
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.FileExtension like '%c'
go
------------Orta herfi 'r' olani tap-------------
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.title like '_r%'
go
-----Title 'C' ile baslayan AND Owner '219' sorgula-------------
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.title like 'c%' 
	and
	p.owner = '219'
go
-----Owner in operatoru ile yaz OR FileExtension '.doc' sorgula-----
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.owner in ('217', '219') 
	or
	p.FileExtension like '.%'
go
-----FolderfLAG '1' olan AND title 'A' ile baslayan----------
select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.FolderFlag = '1' 
	and
	p.title like 'A%'
go
------------owner-da 3cu herf '2' olani tap-------------
select * from  AdventureWorks2017.Production.Document

select
	p.DocumentNode,
	p.DocumentLevel,
	p.title,
	p.owner,
	p.FolderFlag,
	p.FileExtension
from AdventureWorks2017.Production.Document as p
where
	p.owner like '2%'
go




















------------BISMILLAHIR RAHMANIR RAHIM-----------------------------
------------------------05.12.2024---------------------------------
-------------------------------------------------------------------
use AdventureWorks2017

select * from AdventureWorks2017.HumanResources.Employee
-----BirthDate - da orta hissesinde '11' reqemi olanlari sorgula---
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where
	p.BirthDate like '%11%'
go
----JobTitle - da ortasinda 'WC4' olani sorgula--------------------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where
	p.JobTitle like '%WC4%'
go
--%%%----------BUTUN DATANI GETIRIR--------------------------------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where 
	p.JobTitle like '%%%'
go
----------2 simvol varki biz onu axtara bilmirdik biri %, biride _ dir---------------
---------- _  rezerv olunmus simvol--------------------------------------------------
---------- %  sonsuz sayda simvol tapirdi adi sekilde yazanda------------------------
----% ya da _ axtarmaq ucun bundan istifade edirik--Escape(bundan basqa demekdir)----
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where
	p.JobTitle like '%ab%' escape 'a'
go
--- _ ya da % axtarmaq ucun bundan istifade edirik--Escape(bundan basqa demekdir)----
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where
	p.JobTitle like '%&_%' escape '&'
go
---------Mutleq onde 1 simvol var orta hissesinde 'a' simvolu olan sorgula-----------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where
	p.JobTitle like '_%a%'
go
---------------------------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
WHERE 
    p.Jobtitle IS NOT NULL;
GO
---------------------------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
WHERE 
    p.Jobtitle IS NULL;
GO
--------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
WHERE 
    p.JobTitle LIKE '%_&M%' ESCAPE '&';
GO
-----------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where 
    p.gender IN ('M', 'F');
go
----------
select
	p.BusinessEntityID,
	p.NationalIDNumber,
	p.JobTitle,
	p.BirthDate,
	p.gender,
	p.VacationHours
from	AdventureWorks2017.HumanResources.Employee as p
where 
    p.VacationHours IN ('61', '8', '9');
go
--------------
select
    p.DocumentNode,
    p.DocumentLevel,
    p.Title,
    p.Owner,
    p.FolderFlag,
    p.FileExtension
from AdventureWorks2017.Production.Document AS p
where
    p.Title LIKE 'c%' 
    AND p.Owner = '219';
go
--------------------------

