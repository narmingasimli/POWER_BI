----------------------------------------------------------------------------------------------------------------
----Kodda tipi duz secmesek Network yuklenir cpu prosessor ram hdd yuklenir ve server cokur xarab olur---
---HDD-disk driver butun datalarimizi saxladigimiz disk-----
---CPU-komputerin doyunen ureyi prosessor-------------------
---RAM-rami random acces memory-----------------------------
---NET-network
------------------------------------------------------------------
---Tam eded - bigint----------------------------------------------
---Kesr eded - float----------------------------------------------
---Simvol---------------------------------------------------------
---CoreSQL deyir ki, mende ne qeder tip var boluruk 7 yere--------
---1)Exact numerics---tam ededler-- (- + 0)
---2)Approximate numerics--(,vergullu ededler, kesr ededler,tam ededler)
---3)Date and time---------()
---4)Character strings-----(herf,simvol,yazilar)-----------
---5)Unicode character strings -(unicode yadda saxlayaciq.standart english elifbasindan basqa elifba: əçöü, ereb elifbasi, rus elifbasi)---------
---6)Binary strings--- dehsetli boyuk bir stringlerdir----
---7)Other data types--
-----------------------------------------------------------------------------
--------------------------------------
use school
go
-----------------------------------------------------------------
-------------5 TAM EDED UCUN TIPIMIZ VAR-------------------------
-----------------------------------------------------------------

use school
go

create table test_int
	(	
		col1	bit,
		col2	tinyint,
		col3	smallint,
		col4	int,
		col5	bigint
	);
go
--------------------------------------
insert into test_int values (0, 0, 0, 0, 0)
--------------------------------------
select * from test_int
go
----DATALENGTH(Datanin hecmin hesabla)------bir 0-i saxlamaga ne qeder yer itirib----------------------------
select
	p.col1,
		DATALENGTH(col1) bit_hecmi, --- 1 bayt
	p.col2,
		DATALENGTH(col2) tinyint_hecm, --- 1 bayt
	p.col3,
		DATALENGTH(col3) smallint_hecm, --- 2 bayt
	p.col4,
		DATALENGTH(col4) int_hecm, --- 4 bayt
	p.col5,
		DATALENGTH(col5) bigint_hecmi  --- 8 bayt
from	test_int as p
go
-------BIT columuna yazacagimiz deyer (0 ya da 1)-------------------------------
-------Tinyint saxlayacagimiz deyer (0 dan ... 255 kimi)-------------------------------
-------Smallint saxlayacagimiz deyer (-32768 den ... +32767 kimi)-------------------------------
-------Int saxlayacagimiz deyer (-2milyon 147 minden ... +2milyon 147mine kimi)-------------------------------
-------Bigint-de saxlayacagimiz deyer(-19reqemliden ... +19reqemliye kimi)-------------------------------
---Bazaya BIT hecmine 0 ya da 1 yaza bilersen durub 2 yazsan onu max 1 kimi goturecek-------
insert into test_int values (2, 0, 0, 0, 0)		----bit 0 yada 1 ola biler
insert into test_int values (-2, 0, 0, 0, 0)
-------Bazaya tinyint ucun 255den boyuk simvol yazanda goturmeyecek----------
insert into test_int values (1, 255, 0, 0, 0)	---tinyint 255 kimi olmalidir.

select
	min(col2),
	max(col2)
from	test_int













--------------------------------------------------------------------------------------------------------------
----------------5 KESR EDED UCUN TIPIMIZ VAR------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
create	table	 test_kesr
	(
		col1 decimal(12, 3),	----123456789,012 demekdir
		col2 numeric(12, 3),
		col3 money,
		col4 float,
		col5 real
	);

insert into test_kesr values (0, 0, 0, 0, 0);
insert into test_kesr values (1.1, 1.1, 1.1, 1.1, 1.1);
insert into test_kesr values (121, 121, 121, 121, 121);
insert into test_kesr values (1.0, 1.0, 1.0, 1.0, 1.0);
----
use master
go
----
select * from	test_kesr
----
select
	p.col1,
		DATALENGTH(col1) decimal_hecmi,		---5bayt
	p.col2,
		DATALENGTH(col2) numeric_hecm,		---5bayt
	p.col3,
		DATALENGTH(col3) money_hecm, 		---8bayt
	p.col4,
		DATALENGTH(col4) float_hecm, 		---8bayt
	p.col5,
		DATALENGTH(col5) real_hecmi  		---4bayt
from	test_kesr as p
go
-------money deyirki onde isteniler qeder tam eded yaz vergulden sonra 2 eded yadda saxlayacam-------------------------------------------
-------float deyirki men ozumde 56 simvol saxlayacam.Amma bir emmasi var ya vergulu onde qoy 56 simvol yaz ya da sonda vergulu qoy ondan evvel 56 simvol yaz-----
-------real deyirki 24 simvol saxlayir vergulu ya 24 simvolun onune qoy ya da 24 simvoldan sonra vergulu qoy----
-------
-------MS SQL-de money isletsek bilin ki bonkrot olacaqsiz------
-------EN OPTIMALI REAL-DIR---------


---------------------------------------------------------------------------------
-----Char tilerimiz------Unicode olan ve unicode olmayan data yazi tipleri-------
------Unicode qebul eden:nchar,nvarchar,ntext------------------------------------
------Unicode qebul etmeyen(sirf ENG elifbasi ile olanlar):char,varchar,text-----
-----varchar - dinamik chardir- yeni ne qeder yazirsan o qeder bayt yer tutur----
-----nchar o demekdir ki Unicode-du onune N yazanda vurur 2ye nvarchar(50) yazsam vurur 2ye 100 bayt yazir------
-----nvarchar o demekdir ki simvol sayina gore 2ye vurur-----
-----ntext nvarchar ile ekvivalentdir---
-----bir xanaya bir defeye max 8kb yer islede bilerik---8kb=8000bayt-----  text = varchar(8000) ----
-----text = varchar(8000) ekvivalentdir    textin limiti maximum 8000ne kimidir----
-----ntext = nvarchar(4000) ekvivalentdir    textin limiti maximum 4000ne kimidir----


use school
go

create table test_char(
	col1	char(50),
	col2	varchar(50),
	col3	text,

	col4	nchar(50),
	col5	nvarchar(50),
	col6	ntext
	);

insert into	test_char	values	('a','a','a','a','a','a');
insert into	test_char	values	('aaaaa','aaaaa','aaaaa','aaaaa','aaaaa','aaaaa');
insert into	test_char	values	('aaaaaaaaaa','aaaaaaaaaa','aaaaaaaaaa','aaaaaaaaaa','aaaaaaaaaa','aaaaaaaaaa');

-----
select * from	test_char;
-----
 use school
 go
 ----
select
	col1,
		DATALENGTH(col1) char_hecmi,		---50 bayt---
	col2,
		DATALENGTH(col2) varchar_hecm,		---1 5 10 bayt---
	col3,
		DATALENGTH(col3) text_hecm, 		---1 5 10 bayt---
	col4,
		DATALENGTH(col4) nchar_hecmi, 		---100 bayt---
	col5,
		DATALENGTH(col5) nvarchar_hecm , 	---2 10 20 bayt---
	col6,
		DATALENGTH(col6) ntext_hecm 		---2 10 20 bayt---
from  dbo.test_char 
go
--------------uzunlugu tapmaq ucun yazilir--------
select	LEN('a'), LEN('aaaaa'), LEN('aaaaaaaaaa');
---------------uzunlugunu tap--------------------------------
select
	col1,
		LEN(col1) char_hecmi,		
	col2,
		LEN(col2) varchar_hecm,		
	col4,
		LEN(col4) nchar_hecmi, 		
	col5,
		LEN(col5) nvarchar_hecm  	
from	test_char 
go
-----------------------------------------------------------
create table test_date
	(
		col1 date,
		col2 time,
		col3 datetime,
		col4 datetime2
	)
-------
select GETDATE();
2024-12-09 16:09:36.260
-------
insert into test_date values
	(
		GETDATE(),
		GETDATE(),
		GETDATE(),
		GETDATE()		
	);
-------
select	*	from test_date;
-------
select
	col1,
		DATALENGTH(col1) date_hecm,		---3bayt---
	col2,
		DATALENGTH(col2) time_hecm,		---5bayt---
	col3,
		DATALENGTH(col3) datetime_hecm, ---8bayt--- ,123
	col4,
		DATALENGTH(col4) datetime2_hecm ---8bayt--- ,1234567 --- Ideal proqram ucun bu yaxsidir---
from	test_date ;
go
-----
use school
-----
select
	*
from	test_int
where
	col2>10;
go
-----2022-07-01 11-59-23,1234567-----8 bayt yer islenir----
-----					 2022-07-01		11-59-23,	 12	 34		567
--datetime2(0) yazdiqda
--datetime2(2) yazdiqda	(2022-07-01		11-59-23,	 12)		bura qeder verir
--datetime2(4) yazdiqda
--datetime2(7) yazdiqda

create table test_date2
	(
		col1	datetime2(0),
		col2	datetime2(2),
		col3	datetime2(4),
		col4	datetime2(7)
	);

insert into test_date2 values(getdate(), getdate(), getdate(), getdate());

select * from test_date2;
----2024-12-10 11:01:55.6800000----
----Datetime2 isletmekle yaddasdan uduruk, en azi 12,5% en coxu 25% uduruk.-----
select
	col1,
		DATALENGTH(col1) datetime2_0_hecm,		---6bayt---		,
	col2,
		DATALENGTH(col2) datetime2_2_hecm,		---6bayt---		,12
	col3,
		DATALENGTH(col3) datetime2_4_hecm,		---7bayt---		,1234
	col4,
		DATALENGTH(col4) datetime2_7_hecm		---8bayt---		,1234567  
from	test_date2 ;
go

