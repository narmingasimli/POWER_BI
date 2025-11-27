--declare @gl_db date='2020-01-01'
--declare @gl_de date='2024-09-30'--getdate()

--declare @report_db date='2022-04-15'
--declare @report_de date='2022-08-30'


--declare @comp nvarchar(max)='STP PMZ'
----declare @hesab_typ nvarchar(max)='Main'

; with src as(

SELECT
 'STP MMC' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM TGR3.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP MMC')


union all


SELECT
 'STP AH' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM          TGR3_AH.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_AH.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_AH.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_AH.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_AH.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_AH.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_AH.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_AH.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP AH')


union all


SELECT
 'STP AMPZ' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM          TGR3_AMPZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_AMPZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_AMPZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_AMPZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_AMPZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP AMPZ')



union all


SELECT
 'STP KZ' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM          TGR3_KZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_KZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_KZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_KZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_KZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP KZ')
 

 
union all


SELECT
 'STP PMZ' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM          TGR3_PMZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_PMZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_PMZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_PMZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_PMZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP PMZ')



union all


SELECT
 'STP QQZ' comp,
       EMFLINE.LOGICALREF,
       u.NAME 'Yaradan Adi',
       u1.NAME 'Son Deyisdiren Adi',
       EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi',
       ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi',
       EMFLINE.DATE_ 'Tarix',
       EMFLINE.DEPARTMENT 'Bölüm No',
       DEPT.NAME 'Bölüm Adý',
       EMFLINE.BRANCH 'Ýþ Yeri No',
       EMCENTER.CODE 'Masraf Kodu',
       EMCENTER.DEFINITION_ 'Masraf Adý',
       EMUHACC.CODE 'Hesab Kodu',
       EMUHACC.DEFINITION_ 'Hesab Adý',
	   EMFLINE.LINEEXP,
       CASE
           WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN
               SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			                   , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 )
               + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                              CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))
           ELSE EMFLINE.LINEEXP   END 'Açýqlama',
       EMFICHE.FICHENO 'Mahsub No',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit',
       iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit',
       EMFICHE.MODULENR 'Kaynak Fiþ Türü',
       EMFLINE.CLCODE 'Cari Kod',
       EMFLINE.CLDEF 'Cari Ad',
       EMFLINE.CROSSCODE 'qarsi hesab kod',
       EMUHACC1.DEFINITION_ 'qarsi hesab ad'
FROM          TGR3_QQZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_QQZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_QQZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_QQZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_QQZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP QQZ')
),




con as(

 
select t.comp, t.hk
, case when len(t.hk)=1 then  upper(t.hesab_Ad)
       else upper(left(t.hesab_Ad,1))+lower(SUBSTRING(t.hesab_Ad, 2, 10000)) end hesab_Ad

from 
(

select 'STP MMC' comp, '1' hk, N'UZUNMÜDDəTLİ AKTİVLəR' hesab_Ad union all
select 'STP MMC' comp, '1.10' hk, N'Qeyri-maddi aktivlər' hesab_Ad union all
select 'STP MMC' comp, '1.10.101' hk, N'Qeyri-maddi aktivlərin dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.10.101.01' hk, N'Qeyri-maddi aktivlərin dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.10.101.01.01' hk, N'Proqram təminatı' hesab_Ad union all
select 'STP MMC' comp, '1.10.101.01.02' hk, N'Patentlər' hesab_Ad union all
select 'STP MMC' comp, '1.10.101.01.03' hk, N'Sertifikat və Lisenziyalar' hesab_Ad union all
select 'STP MMC' comp, '1.10.102' hk, N'Qeyri-maddi aktivlərin dəyəri üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.10.102.01' hk, N'Qeyri-maddi aktivlərin dəyəri üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.10.102.01.01' hk, N'Proqram təminatı üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.10.102.01.02' hk, N'Patentlər üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.10.102.01.03' hk, N'Sertifikat və Lisenziyalar üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11' hk, N'Torpaq, tikili və avadanlıqlar' hesab_Ad union all
select 'STP MMC' comp, '1.11.111' hk, N'Torpaq, tikili və avadanlıqların dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.11.111.01' hk, N'Torpaq, tikili və avadanlıqların dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.11.111.01.01' hk, N'Bina Tikili və Qurğular' hesab_Ad union all
select 'STP MMC' comp, '1.11.111.01.02' hk, N'Maşın və Avadanlıqlar' hesab_Ad union all
select 'STP MMC' comp, '1.11.111.01.03' hk, N'Nəqliyyat vasitələri' hesab_Ad union all
select 'STP MMC' comp, '1.11.111.01.04' hk, N'Digər Avadanlıqlar' hesab_Ad union all
select 'STP MMC' comp, '1.11.112' hk, N'Torpaq, tikili və avadanlıqlar üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.112.01' hk, N'Torpaq, tikili və avadanlıqlar üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.112.01.01' hk, N'Bina Tikili və Qurğular üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.112.01.02' hk, N'Maşın və Avadanlıqlar üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.112.01.03' hk, N'Nəqliyyat vasitələri üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.112.01.04' hk, N'Digər Avadanlıqlar üzrə yığılmış amortizasiya' hesab_Ad union all
select 'STP MMC' comp, '1.11.113' hk, N'Torpaq, tikili və avadanlıqlarla bağlı məsrəflərin kapitallaşdırılması' hesab_Ad union all
select 'STP MMC' comp, '1.11.113.01' hk, N'Torpaq, tikili və avadanlıqlarla bağlı məsrəflərin kapitallaşdırılması' hesab_Ad union all
select 'STP MMC' comp, '1.11.113.01.01' hk, N'Torpaq, tikili və avadanlıqlarla bağlı məsrəflərin kapitallaşdırılması' hesab_Ad union all
select 'STP MMC' comp, '1.12' hk, N'İnvestisiya mülkiyyəti' hesab_Ad union all
select 'STP MMC' comp, '1.12.121' hk, N'İnvestisiya mülkiyyətinin dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.12.122' hk, N'İnvestisiya mülkiyyəti üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' hesab_Ad union all
select 'STP MMC' comp, '1.12.123' hk, N'İnvestisiya mülkiyyəti ilə bağlı məsrəflərin kapitallaşdırılması' hesab_Ad union all
select 'STP MMC' comp, '1.13' hk, N'Bioloji aktivlər' hesab_Ad union all
select 'STP MMC' comp, '1.13.131' hk, N'Bioloji aktivlərin dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.13.132' hk, N'Bioloji aktivlər üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' hesab_Ad union all
select 'STP MMC' comp, '1.14' hk, N'Təbii sərvətlər' hesab_Ad union all
select 'STP MMC' comp, '1.14.141' hk, N'Təbii sərvətlərin (ehtiyatların) dəyəri' hesab_Ad union all
select 'STP MMC' comp, '1.14.142' hk, N'Təbii sərvətlərin (ehtiyatların) tükənməsi' hesab_Ad union all
select 'STP MMC' comp, '1.15' hk, N'İştirak payı metodu ilə uçota alınmış investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.15.151' hk, N'Asılı müəssisələrə investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.15.151.01' hk, N'Asılı müəssisələrə investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.15.151.01.01' hk, N'Asılı müəssisələrə investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.15.152' hk, N'Birgə müəssisələrə investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.15.153' hk, N'Asılı və birgə müəssisələrə investisiyaların dəyərinin azalmasına görə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '1.16' hk, N'Təxirə salınmış vergi aktivləri' hesab_Ad union all
select 'STP MMC' comp, '1.16.161' hk, N'Mənfəət vergisi üzrə təxirə salınmış vergi aktivləri' hesab_Ad union all
select 'STP MMC' comp, '1.16.162' hk, N'Digər təxirə salınmış vergi aktivləri' hesab_Ad union all
select 'STP MMC' comp, '1.17' hk, N'Uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.171' hk, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.171.01' hk, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.171.01.01' hk, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.172' hk, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.172.01' hk, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.172.01.01' hk, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.173' hk, N'əsas idarəetmə heyətinin uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.174' hk, N'İcarə üzrə uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.175' hk, N'Tikinti müqavilələri üzrə uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.176' hk, N'Faizlər üzrə uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.17.177' hk, N'Digər uzunmüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '1.18' hk, N'Sair uzunmüddətli maliyyə aktivləri' hesab_Ad union all
select 'STP MMC' comp, '1.18.181' hk, N'Ödənişə qədər saxlanılan uzunmüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.18.182' hk, N'Verilmiş uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '1.18.182.01' hk, N'Verilmiş uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '1.18.182.01.01' hk, N'Verilmiş uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '1.18.183' hk, N'Digər uzunmüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.18.183.01' hk, N'Digər uzunmüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.18.183.01.01' hk, N'Digər uzunmüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '1.18.184' hk, N'Sair uzunmüddətli maliyyə aktivlərinin dəyərinin azalmasına görə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '1.19' hk, N'Sair uzunmüddətli aktivlər' hesab_Ad union all
select 'STP MMC' comp, '1.19.191' hk, N'Gələcək hesabat dövrlərinin xərcləri' hesab_Ad union all
select 'STP MMC' comp, '1.19.192' hk, N'Verilmiş uzunmüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '1.19.193' hk, N'Digər uzunmüddətli aktivlər' hesab_Ad union all
select 'STP MMC' comp, '2' hk, N'QISAMÜDDəTLİ AKTİVLəR' hesab_Ad union all
select 'STP MMC' comp, '2.20' hk, N'Ehtiyatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.201' hk, N'Material ehtiyatları' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.01' hk, N'Material ehtiyatları' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.01.01' hk, N'Xammallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.01.02' hk, N'Yarimfabrikatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.01.03' hk, N'Tekraremal ve tullantilar' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.02' hk, N'Yolda olan xammallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.201.02.01' hk, N'Yolda olan xammallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.202' hk, N'İstehsalat (iş və xidmət) məsrəfləri' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01' hk, N'İstehsalat (iş və xidmət) məsrəfləri' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.01' hk, N'Xammal və Material Serfiyyatları' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.02' hk, N'İşçilik xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.03' hk, N'Kommunal Xərclər' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.04' hk, N'Amortizasiya Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.05' hk, N'Təmir Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.06' hk, N'Qeyri Konveyer Bitmemis Istehsalat' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.01.99' hk, N'Diger Xercler' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.99' hk, N'Yansıtma Hesabları' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.99.01' hk, N'Yansıtma Hesabları (Istehsalat)' hesab_Ad union all
select 'STP MMC' comp, '2.20.202.99.02' hk, N'Yansıtma Hesabları (Malzeme Virman)' hesab_Ad union all
select 'STP MMC' comp, '2.20.203' hk, N'Tikinti müqavilələri üzrə məsrəflər' hesab_Ad union all
select 'STP MMC' comp, '2.20.204' hk, N'Hazır məhsul' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01' hk, N'Hazır məhsul' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.01' hk, N'KZ üzrə hazır məhsulları' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.02' hk, N'Sendviç Panel Zavodu Hazır Məhsulları' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.03' hk, N'Texniki Qazlar Zavodu Hazir Mehsullari' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.04' hk, N'Polimer Məmulatları Zavodu' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.05' hk, N'Metaləritmə Zavodu' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.06' hk, N'Alüminium və Mis Profillər Zavodu HM' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.07' hk, N'Elektrik Avadanlıqları Hazır Məhsulları' hesab_Ad union all
select 'STP MMC' comp, '2.20.204.01.08' hk, N'Qeyri Konveyer Hazırməhsulları' hesab_Ad union all
select 'STP MMC' comp, '2.20.205' hk, N'Mallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.205.01' hk, N'Ticari Mallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.205.01.01' hk, N'Ticari Mallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.205.02' hk, N'Yolda olan ticari mallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.205.02.01' hk, N'Yolda olan ticari mallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.206' hk, N'Satış məqsədi ilə saxlanılan digər aktivlər' hesab_Ad union all
select 'STP MMC' comp, '2.20.207' hk, N'Digər ehtiyatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.207.01' hk, N'Digər ehtiyatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.207.01.01' hk, N'Azqiymətli tezköhnələn materiallar' hesab_Ad union all
select 'STP MMC' comp, '2.20.207.01.02' hk, N'Təsərrüfat malları' hesab_Ad union all
select 'STP MMC' comp, '2.20.207.02' hk, N'Yolda olan diger ehtiyyatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.207.02.01' hk, N'Yolda olan Diger ehtiyyatlar' hesab_Ad union all
select 'STP MMC' comp, '2.20.208' hk, N'Ehtiyatların dəyərinin azalmasına görə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '2.20.208.99' hk, N'Isyerleri arasi anbar transferleri' hesab_Ad union all
select 'STP MMC' comp, '2.21' hk, N'Qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.211' hk, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.211.01' hk, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.211.01.01' hk, N'Korporativ müştərilər üzrə debitor borc' hesab_Ad union all
select 'STP MMC' comp, '2.21.211.01.02' hk, N'Fiziki şəxslər üzrə debitor borc' hesab_Ad union all
select 'STP MMC' comp, '2.21.211.01.03' hk, N'Export müştərilər üzrə debitor borc' hesab_Ad union all
select 'STP MMC' comp, '2.21.212' hk, N'Törəmə (asılı) müəssisələrin qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.213' hk, N'əsas idarəetmə heyətinin qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.214' hk, N'İcarə üzrə qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.214.01' hk, N'İcarə üzrə qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.214.01.01' hk, N'İcarə üzrə qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.215' hk, N'Tikinti müqavilələri üzrə qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.216' hk, N'Faizlər üzrə qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.217' hk, N'Digər qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.217.01' hk, N'Digər qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.217.01.01' hk, N'Digər qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.217.01.02' hk, N'Vergi üzrə digər qısamüddətli debitor borcları' hesab_Ad union all
select 'STP MMC' comp, '2.21.218' hk, N'Şübhəli borclar üzrə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '2.21.218.01' hk, N'Şübhəli borclar üzrə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '2.21.218.01.01' hk, N'Şübhəli borclar üzrə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '2.22' hk, N'Pul vəsaitləri və onların ekvivalentləri' hesab_Ad union all
select 'STP MMC' comp, '2.22.221' hk, N'Kassa' hesab_Ad union all
select 'STP MMC' comp, '2.22.221.01' hk, N'Kassa' hesab_Ad union all
select 'STP MMC' comp, '2.22.221.01.01' hk, N'Kassa' hesab_Ad union all
select 'STP MMC' comp, '2.22.222' hk, N'Yolda olan pul köçürmələri' hesab_Ad union all
select 'STP MMC' comp, '2.22.222.01' hk, N'Yolda olan pul kocurmeleri' hesab_Ad union all
select 'STP MMC' comp, '2.22.222.01.01' hk, N'Yolda olan pul kocurmeleri' hesab_Ad union all
select 'STP MMC' comp, '2.22.223' hk, N'Bank hesablaşma hesabları' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01' hk, N'Bank hesablaşma hesabları' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01.01' hk, N'Bank hesablaşma hesabları (AZN)' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01.02' hk, N'Bank hesablaşma hesabları (USD)' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01.03' hk, N'Bank hesablaşma hesabları (EUR)' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01.04' hk, N'Bank hesablaşma hesabları (RUR)' hesab_Ad union all
select 'STP MMC' comp, '2.22.223.01.05' hk, N'Bank hesablaşma hesabları (GBP)' hesab_Ad union all
select 'STP MMC' comp, '2.22.224' hk, N'Tələblərə əsasən açılan digər bank hesabları' hesab_Ad union all
select 'STP MMC' comp, '2.22.225' hk, N'Pul vəsaitlərinin ekvivalentləri' hesab_Ad union all
select 'STP MMC' comp, '2.22.226' hk, N'əDV sub-uçot hesabı' hesab_Ad union all
select 'STP MMC' comp, '2.22.226.01' hk, N'əDV sub-uçot hesabı' hesab_Ad union all
select 'STP MMC' comp, '2.22.226.01.01' hk, N'əDV sub-uçot hesabı' hesab_Ad union all
select 'STP MMC' comp, '2.23' hk, N'Sair qısamüddətli maliyyə aktivləri' hesab_Ad union all
select 'STP MMC' comp, '2.23.231' hk, N'Satış məqsədi ilə saxlanılan qısamüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '2.23.232' hk, N'Ödənişə qədər saxlanılan qısamüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '2.23.233' hk, N'Verilmiş qısamüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '2.23.234' hk, N'Digər qısamüddətli investisiyalar' hesab_Ad union all
select 'STP MMC' comp, '2.23.235' hk, N'Sair qısamüddətli maliyyə aktivlərinin dəyərinin azalmasına görə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '2.24' hk, N'Sair qısamüddətli aktivlər' hesab_Ad union all
select 'STP MMC' comp, '2.24.241' hk, N'əvəzləşdirilən vergilər' hesab_Ad union all
select 'STP MMC' comp, '2.24.241.01' hk, N'əvəzləşdirilən vergilər' hesab_Ad union all
select 'STP MMC' comp, '2.24.241.01.01' hk, N'əvəzləşdirilən vergilər' hesab_Ad union all
select 'STP MMC' comp, '2.24.242' hk, N'Gələcək hesabat dövrünün xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.24.242.01' hk, N'Gələcək hesabat dövrünün xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.24.242.01.01' hk, N'İdxalat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.24.242.01.02' hk, N'Digər Gələcək hesabat dövrünün xərcləri' hesab_Ad union all
select 'STP MMC' comp, '2.24.243' hk, N'Verilmiş qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '2.24.243.01' hk, N'Verilmiş qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '2.24.243.01.01' hk, N'Verilmiş qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '2.24.244' hk, N'Təhtəlhesab məbləğlər' hesab_Ad union all
select 'STP MMC' comp, '2.24.244.01' hk, N'Təhtəlhesab məbləğlər' hesab_Ad union all
select 'STP MMC' comp, '2.24.244.01.01' hk, N'Təhtəlhesab məbləğlər' hesab_Ad union all
select 'STP MMC' comp, '2.24.245' hk, N'Digər qısamüddətli aktivlər' hesab_Ad union all
select 'STP MMC' comp, '3' hk, N'KAPİTAL' hesab_Ad union all
select 'STP MMC' comp, '3.30' hk, N'Ödənilmiş nizamnamə (nominal) kapital' hesab_Ad union all
select 'STP MMC' comp, '3.30.301' hk, N'Nizamnamə (nominal) kapitalı' hesab_Ad union all
select 'STP MMC' comp, '3.30.301.01' hk, N'Nizamnamə (nominal) kapitalı' hesab_Ad union all
select 'STP MMC' comp, '3.30.301.01.01' hk, N'Nizamnamə (nominal) kapitalı' hesab_Ad union all
select 'STP MMC' comp, '3.30.302' hk, N'Nizamnamə (nominal) kapitalın ödənilməmiş hissəsi' hesab_Ad union all
select 'STP MMC' comp, '3.31' hk, N'Emissiya gəliri' hesab_Ad union all
select 'STP MMC' comp, '3.31.311' hk, N'Emissiya gəliri' hesab_Ad union all
select 'STP MMC' comp, '3.32' hk, N'Geri alınmış kapital (səhmlər)' hesab_Ad union all
select 'STP MMC' comp, '3.32.321' hk, N'Geri alınmış kapital (səhmlər)' hesab_Ad union all
select 'STP MMC' comp, '3.33' hk, N'Kapital ehtiyatları' hesab_Ad union all
select 'STP MMC' comp, '3.33.331' hk, N'Yenidən qiymətləndirilmə üzrə ehtiyat' hesab_Ad union all
select 'STP MMC' comp, '3.33.332' hk, N'Məzənnə fərgləri üzrə ehtiyat' hesab_Ad union all
select 'STP MMC' comp, '3.33.333' hk, N'Qanunvericilik üzrə ehtiyat' hesab_Ad union all
select 'STP MMC' comp, '3.33.334' hk, N'Nizamnamə üzrə ehtiyat' hesab_Ad union all
select 'STP MMC' comp, '3.33.335' hk, N'Digər ehtiyatlar' hesab_Ad union all
select 'STP MMC' comp, '3.34' hk, N'Bölüşdürülməmiş mənfəət (ödənilməmiş zərər)' hesab_Ad union all
select 'STP MMC' comp, '3.34.341' hk, N'Hesabat dövründə xalis mənfəət (zərər)' hesab_Ad union all
select 'STP MMC' comp, '3.34.342' hk, N'Mühasibat uçotu siyasətində dəyişikliklərlə bağlı mənfəət (zərər) üzrə düzəlişlər' hesab_Ad union all
select 'STP MMC' comp, '3.34.343' hk, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' hesab_Ad union all
select 'STP MMC' comp, '3.34.343.01' hk, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' hesab_Ad union all
select 'STP MMC' comp, '3.34.343.01.01' hk, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' hesab_Ad union all
select 'STP MMC' comp, '3.34.344' hk, N'Elan edilmiş dividentlər' hesab_Ad union all
select 'STP MMC' comp, '4' hk, N'UZUNMÜDDəTLİ ÖHDəLİKLəR' hesab_Ad union all
select 'STP MMC' comp, '4.40' hk, N'Uzunmüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.40.401' hk, N'Uzunmüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '4.40.401.01' hk, N'Uzunmüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '4.40.401.01.01' hk, N'Uzunmüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '4.40.402' hk, N'İşçilər üçün uzunmüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '4.40.403' hk, N'Uzunmüddətli konvertasiya olunan istiqrazlar' hesab_Ad union all
select 'STP MMC' comp, '4.40.404' hk, N'Uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '4.40.404.01' hk, N'Uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '4.40.404.01.01' hk, N'Uzunmüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '4.40.405' hk, N'Geri alınan məhdud tədavül müddətli imtiyazlı səhmlər(uzunmüddətli)' hesab_Ad union all
select 'STP MMC' comp, '4.40.406' hk, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.40.406.01' hk, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.40.406.01.01' hk, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.40.407' hk, N'Törəmə(asılı) müəssisələrə uzunmüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.40.408' hk, N'Digər uzunmüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.41' hk, N'Uzunmüddətli qiymətləndirilmiş öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.41.411' hk, N'İşdən azad olma ilə bağlı uzunmüddətli müavinətlər və öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.41.412' hk, N'Uzunmüddətli zəmanət öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '4.41.413' hk, N'Uzunmüddətli hüquqi öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.41.414' hk, N'Digər uzunmüddətli qiymətləndirilmiş öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.42' hk, N'Təxirə salınmış vergi öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '4.42.421' hk, N'Mənfəət vergisi üzrə təxirə salınmış vergi öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '4.42.422' hk, N'Digər təxirə salınmış vergi öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.43' hk, N'Uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.43.431' hk, N'Malsatan və podratçılara uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.43.432' hk, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.43.433' hk, N'Tikinti müqavilələri üzrə uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.43.434' hk, N'Faizlər üzrə uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.43.435' hk, N'Digər uzunmüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '4.44' hk, N'Sair uzunmüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '4.44.441' hk, N'Uzunmüddətli pensiya öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '4.44.442' hk, N'Gələcək hesabat dövrlərinin gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '4.44.443' hk, N'Alınmış uzunmüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '4.44.444' hk, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' hesab_Ad union all
select 'STP MMC' comp, '4.44.444.01' hk, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' hesab_Ad union all
select 'STP MMC' comp, '4.44.444.01.01' hk, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' hesab_Ad union all
select 'STP MMC' comp, '4.44.445' hk, N'Digər uzunmüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5' hk, N'QISAMÜDDəTLİ ÖHDəLİKLəR' hesab_Ad union all
select 'STP MMC' comp, '5.50' hk, N'Qısamüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.50.501' hk, N'Qısamüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '5.50.501.01' hk, N'Qısamüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '5.50.501.01.01' hk, N'Qısamüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '5.50.502' hk, N'İşçilər üçün qısamüddətli bank kreditləri' hesab_Ad union all
select 'STP MMC' comp, '5.50.503' hk, N'Qısamüddətli konvertasiya olunan istiqrazlar' hesab_Ad union all
select 'STP MMC' comp, '5.50.504' hk, N'Qısamüddətli borclar' hesab_Ad union all
select 'STP MMC' comp, '5.50.505' hk, N'Geri alınan məhdud tədavül müddətli imtiyazlı səhmlər(qısamüddətli)' hesab_Ad union all
select 'STP MMC' comp, '5.50.506' hk, N'Törəmə(asılı) müəssisələrə qısamüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.50.507' hk, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.50.507.01' hk, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.50.507.01.01' hk, N'Uzunmuddetli kreditlere gore cari faiz ohdelikleri' hesab_Ad union all
select 'STP MMC' comp, '5.50.507.01.02' hk, N'Qisamuddetli kreditlere gore cari faiz ohdelikleri' hesab_Ad union all
select 'STP MMC' comp, '5.51' hk, N'Qısamüddətli qiymətləndirilmiş öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.51.511' hk, N'İşdən azad olma ilə bağlı qısamüddətli müavinətlər və öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.51.512' hk, N'Qısamüddətli zəmanət öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '5.51.513' hk, N'Qısamüddətli hüquqi öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.51.514' hk, N'Mənfəətdə iştirak planı və müavinət planları' hesab_Ad union all
select 'STP MMC' comp, '5.51.515' hk, N'Digər qısamüddətli qiymətləndirilmiş öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52' hk, N'Vergi və sair məcburi ödənişlər üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.521' hk, N'Vergi öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '5.52.521.01' hk, N'Vergi öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '5.52.521.01.01' hk, N'Vergi öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '5.52.521.02' hk, N'Satisdan yaranan vergi ohdeliyi' hesab_Ad union all
select 'STP MMC' comp, '5.52.521.02.01' hk, N'Satisdan yaranan vergi ohdeliyi' hesab_Ad union all
select 'STP MMC' comp, '5.52.522' hk, N'Sosial sığorta və təminat üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.522.01' hk, N'Sosial sığorta və təminat üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.522.01.01' hk, N'Sosial sığorta və təminat üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.523' hk, N'Digər məcburi ödənişlər üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.523.01' hk, N'Digər məcburi ödənişlər üzrə öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.52.523.01.01' hk, N'Digər məcburi ödənişlər üzrə öhdəliklər (Həmkarlar)' hesab_Ad union all
select 'STP MMC' comp, '5.53' hk, N'Qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.531' hk, N'Malsatan və podratçılara qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.531.01' hk, N'Malsatan və podratçılara qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.531.01.01' hk, N'Yerli Kreditor borclar' hesab_Ad union all
select 'STP MMC' comp, '5.53.531.01.02' hk, N'Xarici Kreditor borclar' hesab_Ad union all
select 'STP MMC' comp, '5.53.532' hk, N'Törəmə(asılı) müəssisələrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.533' hk, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' hesab_Ad union all
select 'STP MMC' comp, '5.53.533.01' hk, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' hesab_Ad union all
select 'STP MMC' comp, '5.53.533.01.01' hk, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' hesab_Ad union all
select 'STP MMC' comp, '5.53.534' hk, N'Dividendlərin ödənilməsi üzrə təsisçilərə kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.535' hk, N'İcarə üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.536' hk, N'Tikinti müqavilələri üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.537' hk, N'Faizlər üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.537.01' hk, N'Faizlər üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.537.01.01' hk, N'Faizlər üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.538' hk, N'Digər qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.538.01' hk, N'Digər qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.538.01.01' hk, N'Digər qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.53.538.01.03' hk, N'İcbari ödənişlər üzrə qısamüddətli kreditor borcları' hesab_Ad union all
select 'STP MMC' comp, '5.54' hk, N'Sair qısamüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '5.54.541' hk, N'Qısamüddətli pensiya öhdəlikləri' hesab_Ad union all
select 'STP MMC' comp, '5.54.542' hk, N'Gələcək hesabat dövrünün gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '5.54.543' hk, N'Alınmış qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '5.54.543.01' hk, N'Alınmış qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '5.54.543.01.01' hk, N'Alınmış qısamüddətli avanslar' hesab_Ad union all
select 'STP MMC' comp, '5.54.544' hk, N'Qisamüddətli məqsədli maliyyələşmələr və daxilolmalar' hesab_Ad union all
select 'STP MMC' comp, '5.54.545' hk, N'Digər qısamüddətli öhdəliklər' hesab_Ad union all
select 'STP MMC' comp, '6' hk, N'GəLİRLəR' hesab_Ad union all
select 'STP MMC' comp, '6.60' hk, N'əsas əməliyyat gəliri' hesab_Ad union all
select 'STP MMC' comp, '6.60.601' hk, N'Satış' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01' hk, N'Hazirmehsulların satışları' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.01' hk, N'Kabel Hazırməhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.02' hk, N'Sendviç Panel Zavodu Hazır Məhsulları' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.03' hk, N'Texniki Qazlar Zavodu Hazırməhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.04' hk, N'Polimer məmulatlarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.05' hk, N'Metaləritmə Zavodu məhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.06' hk, N'AMPZ Hazırməhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.07' hk, N'Elektrik Avadanlıqları Hazırməhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.01.08' hk, N'Qeyri Konveyer hazırməhsullarının satışı' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.02' hk, N'Diger Mehsullarin Satisi' hesab_Ad union all
select 'STP MMC' comp, '6.60.601.02.01' hk, N'Diger Mehsullarin Satisi' hesab_Ad union all
select 'STP MMC' comp, '6.60.602' hk, N'Satılmış malların qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01' hk, N'Hazırməhsullar üzrə qaytarmalar' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.01' hk, N'Kabel Hazırməhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.02' hk, N'Sendviç Panel Zavodu Hazır Məhsulları' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.03' hk, N'Texniki Qazlar Zavodu Hazırməhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.04' hk, N'Polimer məmulatlarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.05' hk, N'Metaləritmə Zavodu məhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.06' hk, N'AMPZ Hazırməhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.07' hk, N'Elektrik Avadanlıqları Hazırməhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.01.08' hk, N'Qeyri Konveyer hazırməhsullarının qaytarılması' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.02' hk, N'Diger Mehsullarin Geriqaytarmasi' hesab_Ad union all
select 'STP MMC' comp, '6.60.602.02.01' hk, N'Diger Mehsullarin Geriqaytarmasi' hesab_Ad union all
select 'STP MMC' comp, '6.60.603' hk, N'Verilmiş güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01' hk, N'Hazırməhsullar üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.01' hk, N'Kabel Hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.02' hk, N'SPZ hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.03' hk, N'Texniki Qazlar Zavodu Hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.04' hk, N'Polimer məmulatları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.05' hk, N'Metaləritmə Zavodu məhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.06' hk, N'AMPZ Hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.07' hk, N'Elektrik Avadanlıqları Hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.01.08' hk, N'Qeyri Konveyer hazırməhsulları üzrə güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.02' hk, N'Diger Mehsullarin güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.60.603.02.01' hk, N'Diger Mehsullarin güzəştlər' hesab_Ad union all
select 'STP MMC' comp, '6.61' hk, N'Sair əməliyyat gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.61.611' hk, N'Sair əməliyyat gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01' hk, N'Sair əməliyyat gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.01' hk, N'Məzənnə fərqləri üzrə gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.02' hk, N'Yenidən qiymətləndirilmədən gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.03' hk, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.04' hk, N'Anbar sayımlarından yaranan gəlir' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.10' hk, N'İcarə (əsas vəsaitlərin)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.11' hk, N'Kommunal' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.12' hk, N'Yeməkxana (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.13' hk, N'Sərnişin daşınma (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.14' hk, N'Tibb (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.15' hk, N'Admin (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.16' hk, N'Təhlükəsizlik (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.17' hk, N'HSE (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.18' hk, N'Energetika (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.19' hk, N'SCİP (shared services)' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.20' hk, N'Biznes Vahidləri ilə bağlı digər gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.21' hk, N'HSE (Shared services) ' hesab_Ad union all
select 'STP MMC' comp, '6.61.611.01.98' hk, N'Sair əməliyyat gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.62' hk, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.62.621' hk, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.63' hk, N'Maliyyə gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.63.631' hk, N'Maliyyə gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.63.631.01' hk, N'Maliyyə gəlirləri' hesab_Ad union all
select 'STP MMC' comp, '6.63.631.01.01' hk, N'Hedging üzrə gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.64' hk, N'Fövqəladə gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '6.64.641' hk, N'Fövqəladə gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '7' hk, N'XəRCLəR' hesab_Ad union all
select 'STP MMC' comp, '7.70' hk, N'Satışın maya dəyəri üzrə xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.70.701' hk, N'Satışın maya dəyəri üzrə xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01' hk, N'Hazirmehsul satışlarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.01' hk, N'Kabel Hazırməhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.02' hk, N'Sendviç Panel Zavodu Hazır Məhsulları' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.03' hk, N'Texniki Qazlar Zavodu Hazırməhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.04' hk, N'Polimer məmulatlarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.05' hk, N'Metaləritmə Zavodu məhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.06' hk, N'AMPZ Hazırməhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.07' hk, N'Elektrik Avadanlıqları Hazırməhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.01.08' hk, N'Qeyri Konveyer hazırməhsullarının maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.02' hk, N'Diger Mehsullarin maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.70.701.02.01' hk, N'Diger Mehsullarin maya dəyəri' hesab_Ad union all
select 'STP MMC' comp, '7.71' hk, N'Kommersiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711' hk, N'Kommersiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.01' hk, N'əmək haqqı və işçilik xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.01.01' hk, N'İşçilik xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.01.02' hk, N'İR Xərcləri (təlim, tədbir, axtarış)' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.01.03' hk, N'Ezamiyyə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.02' hk, N'Marketinq Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.02.01' hk, N'Reklam Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.02.02' hk, N'Araşdırma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.02.03' hk, N'Digər marketinq xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.03' hk, N'əsas Vəsaitlərin Amortizasiya Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.03.01' hk, N'Bina Tikili və Qurğuların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.03.02' hk, N'Maşın və Avadanlıqların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.03.03' hk, N'Nəqliyyat vasitələriın amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.03.04' hk, N'Digər Avadanlıqların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.04' hk, N'Qeyri Maddi aktivlərin amortizasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.04.01' hk, N'Proqram təminatları üzrə amortizasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.05' hk, N'əsas Vəsaitlərin Təmir Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.05.01' hk, N'Bina Tikili və Qurğuların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.05.02' hk, N'Maşın və Avadanlıqların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.05.03' hk, N'Nəqliyyat vasitələriın təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.05.04' hk, N'Digər Avadanlıqların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.06' hk, N'Logostika xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.06.01' hk, N'Yükdaşıma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.06.02' hk, N'Sərnişindaşıma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.06.03' hk, N'Yanacaq xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.06.99' hk, N'Digər logistika xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.07' hk, N'Sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.07.01' hk, N'Məhsullar üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.07.02' hk, N'Nəqliyyat vasitələri üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.07.03' hk, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99' hk, N'Digər Xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.01' hk, N'İcarə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.02' hk, N'IT xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.03' hk, N'Kommunal xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.04' hk, N'Profisonal xidmətlər xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.05' hk, N'Bank xidmətləri xərci' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.06' hk, N'Vergi Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.07' hk, N'əməyin mühafizəsi və tibbi xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.08' hk, N'Sığorta xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.09' hk, N'Təsərrüfat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.11' hk, N'Xarab Mal xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.12' hk, N'Ixracat Xercleri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.14' hk, N'Köməkçi istehsalat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.15' hk, N'Yardim xercleri' hesab_Ad union all
select 'STP MMC' comp, '7.71.711.99.99' hk, N'Sair Xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72' hk, N'İnzibati xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721' hk, N'İnzibati xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.01' hk, N'əmək haqqı və işçilik xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.01.01' hk, N'İşçilik xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.01.02' hk, N'İR Xərcləri (təlim, tədbir, axtarış)' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.01.03' hk, N'Ezamiyyə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.02' hk, N'Marketinq Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.02.01' hk, N'Reklam Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.02.02' hk, N'Səhifələrin idarə olunması xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.02.03' hk, N'Araşdırma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.02.04' hk, N'Digər marketinq xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.03' hk, N'əsas Vəsaitlərin Amortizasiya Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.03.01' hk, N'Bina Tikili və Qurğuların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.03.02' hk, N'Maşın və Avadanlıqların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.03.03' hk, N'Nəqliyyat vasitələriın amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.03.04' hk, N'Digər Avadanlıqların amortizasiya xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.04' hk, N'Qeyri Maddi aktivlərin amortizasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.04.01' hk, N'Proqram təminatları üzrə amortizasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.05' hk, N'əsas Vəsaitlərin Təmir Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.05.01' hk, N'Bina Tikili və Qurğuların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.05.02' hk, N'Maşın və Avadanlıqların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.05.03' hk, N'Nəqliyyat vasitələriın təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.05.04' hk, N'Digər Avadanlıqların təmir xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.06' hk, N'Logostika xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.06.01' hk, N'Yükdaşıma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.06.02' hk, N'Sərnişindaşıma xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.06.03' hk, N'Yanacaq xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.06.99' hk, N'Digər logistika xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.07' hk, N'Sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.07.01' hk, N'Məhsullar üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.07.02' hk, N'Nəqliyyat vasitələri üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.07.03' hk, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.08' hk, N'Rezidentlik xercleri ' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.08.01' hk, N'Parkin idare olunması' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.09' hk, N'Muhafize xercleri ' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.09.01' hk, N'Muhafize xercleri ' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.10' hk, N'Yemekxana xercleri, Iase sahesi' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.10.01' hk, N'Erzaq ve birdefelik qablar' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.11' hk, N'Bank xidmətləri xərci ' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.11.01' hk, N'Faiz xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99' hk, N'Digər Xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.01' hk, N'İcarə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.02' hk, N'IT xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.03' hk, N'Kommunal xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.04' hk, N'Profisonal xidmətlər xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.05' hk, N'Bank xidmətləri xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.06' hk, N'Vergi Xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.07' hk, N'əməyin mühafizəsi və tibbi xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.08' hk, N'Sığorta xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.09' hk, N'Təsərrüfat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.11' hk, N'Xarab Mal xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.12' hk, N'Ixracat Xercleri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.13' hk, N'Mobil Rabitə xərci' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.14' hk, N'Köməkçi istehsalat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.15' hk, N'Yardim xercleri' hesab_Ad union all
select 'STP MMC' comp, '7.72.721.99.99' hk, N'Sair Xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.73' hk, N'Sair əməliyyat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.73.731' hk, N'Sair əməliyyat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.73.731.01' hk, N'Sair əməliyyat xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.73.731.01.01' hk, N'Məzənnə fərqləri üzrə xercler' hesab_Ad union all
select 'STP MMC' comp, '7.73.731.01.02' hk, N'Yenidən qiymətləndirilmədən gəlirlər' hesab_Ad union all
select 'STP MMC' comp, '7.73.731.01.03' hk, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' hesab_Ad union all
select 'STP MMC' comp, '7.73.731.01.04' hk, N'Anbar sayımlarından yaranan xərc' hesab_Ad union all
select 'STP MMC' comp, '7.74' hk, N'Fəaliyyətin dayandırılmasından yaranan xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.74.741' hk, N'Fəaliyyətin dayandırılmasından yaranan xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.75' hk, N'Maliyyə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.75.751' hk, N'Maliyyə xərcləri' hesab_Ad union all
select 'STP MMC' comp, '7.76' hk, N'Fövqəladə xərclər' hesab_Ad union all
select 'STP MMC' comp, '7.76.761' hk, N'Fövqəladə xərclər' hesab_Ad union all
select 'STP MMC' comp, '8' hk, N'MəNFəəTLəR (ZəRəRLəR)' hesab_Ad union all
select 'STP MMC' comp, '8.80' hk, N'Ümumi mənfəət (zərər)' hesab_Ad union all
select 'STP MMC' comp, '8.80.801' hk, N'Ümumi mənfəət (zərər)' hesab_Ad union all
select 'STP MMC' comp, '8.81' hk, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' hesab_Ad union all
select 'STP MMC' comp, '8.81.811' hk, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' hesab_Ad union all
select 'STP MMC' comp, '9' hk, N'MəNFəəT VERGİSİ' hesab_Ad union all
select 'STP MMC' comp, '9.90' hk, N'Mənfəət vergisi' hesab_Ad union all
select 'STP MMC' comp, '9.90.901' hk, N'Cari mənfəət vergisi üzrə xərclər' hesab_Ad union all
select 'STP MMC' comp, '9.90.902' hk, N'Təxirə salınmış mənfəət vergisi üzrə xərclər' hesab_Ad   union all



select N'STP PMZ' comp, N'1' hesab, N'UZUNMÜDDəTLİ aktivlər' ad union all
select N'STP PMZ' comp, N'1.10' hesab, N'Qeyri-maddi aktivlər' ad union all
select N'STP PMZ' comp, N'1.10.101' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP PMZ' comp, N'1.10.101.01' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP PMZ' comp, N'1.10.101.01.01' hesab, N'Proqram təminatı' ad union all
select N'STP PMZ' comp, N'1.10.101.01.02' hesab, N'Patentlər' ad union all
select N'STP PMZ' comp, N'1.10.101.01.03' hesab, N'Sertifikat və Lisenziyalar' ad union all
select N'STP PMZ' comp, N'1.10.102' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.10.102.01' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.10.102.01.01' hesab, N'Proqram təminatı üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.10.102.01.02' hesab, N'Patentlər üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.10.102.01.03' hesab, N'Sertifikat və Lisenziyalar üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11' hesab, N'Torpaq, tikili və avədanlıqlar' ad union all
select N'STP PMZ' comp, N'1.11.111' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP PMZ' comp, N'1.11.111.01' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP PMZ' comp, N'1.11.111.01.01' hesab, N'Bina Tikili və Qurğular' ad union all
select N'STP PMZ' comp, N'1.11.111.01.02' hesab, N'Maşın və Avədanlıqlar' ad union all
select N'STP PMZ' comp, N'1.11.111.01.03' hesab, N'Nəqliyyat vəsitələri' ad union all
select N'STP PMZ' comp, N'1.11.111.01.04' hesab, N'Digər Avədanlıqlar' ad union all
select N'STP PMZ' comp, N'1.11.112' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.112.01' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.112.01.01' hesab, N'Bina Tikili və Qurğular üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.112.01.02' hesab, N'Maşın və Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.112.01.03' hesab, N'Nəqliyyat vəsitələri üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.112.01.04' hesab, N'Digər Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP PMZ' comp, N'1.11.113' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP PMZ' comp, N'1.11.113.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP PMZ' comp, N'1.11.113.01.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP PMZ' comp, N'1.12' hesab, N'İnvəstisiya mülkiyyəti' ad union all
select N'STP PMZ' comp, N'1.12.121' hesab, N'İnvəstisiya mülkiyyətinin dəyəri' ad union all
select N'STP PMZ' comp, N'1.12.122' hesab, N'İnvəstisiya mülkiyyəti üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP PMZ' comp, N'1.12.123' hesab, N'İnvəstisiya mülkiyyəti ilə bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP PMZ' comp, N'1.13' hesab, N'Bioloji aktivəər' ad union all
select N'STP PMZ' comp, N'1.13.131' hesab, N'Bioloji aktivəərin dəyəri' ad union all
select N'STP PMZ' comp, N'1.13.132' hesab, N'Bioloji aktivəər üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP PMZ' comp, N'1.14' hesab, N'Təbii sərvətlər' ad union all
select N'STP PMZ' comp, N'1.14.141' hesab, N'Təbii sərvətlərin (ehtiyatların) dəyəri' ad union all
select N'STP PMZ' comp, N'1.14.142' hesab, N'Təbii sərvətlərin (ehtiyatların) tükənməsi' ad union all
select N'STP PMZ' comp, N'1.15' hesab, N'İştirak payı metodu ilə uçota alınmış invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.15.151' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.15.151.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.15.151.01.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.15.152' hesab, N'Birgə müəssisələrə invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.15.153' hesab, N'Asılı və birgə müəssisələrə invəstisiyaların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP PMZ' comp, N'1.16' hesab, N'Təxirə salınmış vərgi aktivəəri' ad union all
select N'STP PMZ' comp, N'1.16.161' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi aktivəəri' ad union all
select N'STP PMZ' comp, N'1.16.162' hesab, N'Digər təxirə salınmış vərgi aktivəəri' ad union all
select N'STP PMZ' comp, N'1.17' hesab, N'Uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.171' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.171.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.171.01.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.172' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.172.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.172.01.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.173' hesab, N'əsas idarəetmə heyətinin uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.174' hesab, N'İcarə üzrə uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.175' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.176' hesab, N'Faizlər üzrə uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.17.177' hesab, N'Digər uzunmüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'1.18' hesab, N'Sair uzunmüddətli maliyyə aktivəəri' ad union all
select N'STP PMZ' comp, N'1.18.181' hesab, N'Ödənişə qədər saxlanılan uzunmüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.18.182' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'1.18.182.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'1.18.182.01.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'1.18.183' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.18.183.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.18.183.01.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'1.18.184' hesab, N'Sair uzunmüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP PMZ' comp, N'1.19' hesab, N'Sair uzunmüddətli aktivəər' ad union all
select N'STP PMZ' comp, N'1.19.191' hesab, N'Gələcək hesabat dövələrinin xərcləri' ad union all
select N'STP PMZ' comp, N'1.19.192' hesab, N'vərilmiş uzunmüddətli avənslar' ad union all
select N'STP PMZ' comp, N'1.19.193' hesab, N'Digər uzunmüddətli aktivəər' ad union all
select N'STP PMZ' comp, N'2' hesab, N'QISAMÜDDəTLİ aktivəər' ad union all
select N'STP PMZ' comp, N'2.20' hesab, N'Ehtiyatlar' ad union all
select N'STP PMZ' comp, N'2.20.201' hesab, N'Material ehtiyatları' ad union all
select N'STP PMZ' comp, N'2.20.201.01' hesab, N'Material ehtiyatları' ad union all
select N'STP PMZ' comp, N'2.20.201.01.01' hesab, N'Xammallar' ad union all
select N'STP PMZ' comp, N'2.20.201.01.02' hesab, N'Yarimfabrikatlar' ad union all
select N'STP PMZ' comp, N'2.20.201.01.03' hesab, N'Tekraremal və tullantilar' ad union all
select N'STP PMZ' comp, N'2.20.201.02' hesab, N'Yolda olan xammallar' ad union all
select N'STP PMZ' comp, N'2.20.201.02.01' hesab, N'Yolda olan xammallar' ad union all
select N'STP PMZ' comp, N'2.20.202' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP PMZ' comp, N'2.20.202.01' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP PMZ' comp, N'2.20.202.01.01' hesab, N'Xammal və Material Serfiyyatları' ad union all
select N'STP PMZ' comp, N'2.20.202.01.02' hesab, N'İşçilik xərcləri' ad union all
select N'STP PMZ' comp, N'2.20.202.01.03' hesab, N'Kommunal Xərclər' ad union all
select N'STP PMZ' comp, N'2.20.202.01.04' hesab, N'Amortizasiya Xərcləri' ad union all
select N'STP PMZ' comp, N'2.20.202.01.05' hesab, N'Təmir Xərcləri' ad union all
select N'STP PMZ' comp, N'2.20.202.01.06' hesab, N'Qeyri Konvəyer Bitmemis Istehsalat' ad union all
select N'STP PMZ' comp, N'2.20.202.01.99' hesab, N'Digər Xercler' ad union all
select N'STP PMZ' comp, N'2.20.202.99' hesab, N'Yansıtma Hesabları' ad union all
select N'STP PMZ' comp, N'2.20.202.99.01' hesab, N'Yansıtma Hesabları (Istehsalat)' ad union all
select N'STP PMZ' comp, N'2.20.202.99.02' hesab, N'Yansıtma Hesabları (Malzeme vərman)' ad union all
select N'STP PMZ' comp, N'2.20.203' hesab, N'Tikinti müqavələləri üzrə məsrəflər' ad union all
select N'STP PMZ' comp, N'2.20.204' hesab, N'Hazır məhsul' ad union all
select N'STP PMZ' comp, N'2.20.204.01' hesab, N'Hazır məhsul' ad union all
select N'STP PMZ' comp, N'2.20.204.01.01' hesab, N'KZ üzrə hazır məhsulları' ad union all
select N'STP PMZ' comp, N'2.20.204.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP PMZ' comp, N'2.20.204.01.03' hesab, N'Texniki Qazlar Zavədu Hazir Mehsullari' ad union all
select N'STP PMZ' comp, N'2.20.204.01.04' hesab, N'Polimer Məmulatları Zavədu' ad union all
select N'STP PMZ' comp, N'2.20.204.01.05' hesab, N'Metaləritmə Zavədu' ad union all
select N'STP PMZ' comp, N'2.20.204.01.06' hesab, N'Alüminium və Mis Profillər Zavədu HM' ad union all
select N'STP PMZ' comp, N'2.20.204.01.07' hesab, N'Elektrik Avədanlıqları Hazır Məhsulları' ad union all
select N'STP PMZ' comp, N'2.20.204.01.08' hesab, N'Qeyri Konvəyer Hazırməhsulları' ad union all
select N'STP PMZ' comp, N'2.20.205' hesab, N'Mallar' ad union all
select N'STP PMZ' comp, N'2.20.205.01' hesab, N'Ticari Mallar' ad union all
select N'STP PMZ' comp, N'2.20.205.01.01' hesab, N'Ticari Mallar' ad union all
select N'STP PMZ' comp, N'2.20.205.02' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP PMZ' comp, N'2.20.205.02.01' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP PMZ' comp, N'2.20.206' hesab, N'Satış məqsədi ilə saxlanılan Digər aktivəər' ad union all
select N'STP PMZ' comp, N'2.20.207' hesab, N'Digər ehtiyatlar' ad union all
select N'STP PMZ' comp, N'2.20.207.01' hesab, N'Digər ehtiyatlar' ad union all
select N'STP PMZ' comp, N'2.20.207.01.01' hesab, N'Azqiymətli tezköhnələn materiallar' ad union all
select N'STP PMZ' comp, N'2.20.207.01.02' hesab, N'Təsərrüfat malları' ad union all
select N'STP PMZ' comp, N'2.20.207.02' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP PMZ' comp, N'2.20.207.02.01' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP PMZ' comp, N'2.20.208' hesab, N'Ehtiyatların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP PMZ' comp, N'2.20.208.99' hesab, N'Isyerleri arasi anbar transferleri' ad union all
select N'STP PMZ' comp, N'2.21' hesab, N'Qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.211' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.211.01' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.211.01.01' hesab, N'Korporativəmüştərilər üzrə debitor borc' ad union all
select N'STP PMZ' comp, N'2.21.211.01.02' hesab, N'Fiziki şəxslər üzrə debitor borc' ad union all
select N'STP PMZ' comp, N'2.21.211.01.03' hesab, N'Export müştərilər üzrə debitor borc' ad union all
select N'STP PMZ' comp, N'2.21.212' hesab, N'Törəmə (asılı) müəssisələrin qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.213' hesab, N'əsas idarəetmə heyətinin qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.214' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.214.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.214.01.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.215' hesab, N'Tikinti müqavələləri üzrə qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.216' hesab, N'Faizlər üzrə qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.217' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.217.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.217.01.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.217.01.02' hesab, N'vərgi üzrə Digər qısamüddətli debitor borcları' ad union all
select N'STP PMZ' comp, N'2.21.218' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP PMZ' comp, N'2.21.218.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP PMZ' comp, N'2.21.218.01.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP PMZ' comp, N'2.22' hesab, N'Pul vəsaitləri və onların ekvəvəlentləri' ad union all
select N'STP PMZ' comp, N'2.22.221' hesab, N'Kassa' ad union all
select N'STP PMZ' comp, N'2.22.221.01' hesab, N'Kassa' ad union all
select N'STP PMZ' comp, N'2.22.221.01.01' hesab, N'Kassa' ad union all
select N'STP PMZ' comp, N'2.22.222' hesab, N'Yolda olan pul köçürmələri' ad union all
select N'STP PMZ' comp, N'2.22.222.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP PMZ' comp, N'2.22.222.01.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP PMZ' comp, N'2.22.223' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP PMZ' comp, N'2.22.223.01' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP PMZ' comp, N'2.22.223.01.01' hesab, N'Bank hesablaşma hesabları (AZN)' ad union all
select N'STP PMZ' comp, N'2.22.223.01.02' hesab, N'Bank hesablaşma hesabları (USD)' ad union all
select N'STP PMZ' comp, N'2.22.223.01.03' hesab, N'Bank hesablaşma hesabları (EUR)' ad union all
select N'STP PMZ' comp, N'2.22.223.01.04' hesab, N'Bank hesablaşma hesabları (RUR)' ad union all
select N'STP PMZ' comp, N'2.22.223.01.05' hesab, N'Bank hesablaşma hesabları (GBP)' ad union all
select N'STP PMZ' comp, N'2.22.224' hesab, N'Tələblərə əsasən açılan Digər bank hesabları' ad union all
select N'STP PMZ' comp, N'2.22.225' hesab, N'Pul vəsaitlərinin ekvəvəlentləri' ad union all
select N'STP PMZ' comp, N'2.22.226' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP PMZ' comp, N'2.22.226.01' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP PMZ' comp, N'2.22.226.01.01' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP PMZ' comp, N'2.23' hesab, N'Sair qısamüddətli maliyyə aktivəəri' ad union all
select N'STP PMZ' comp, N'2.23.231' hesab, N'Satış məqsədi ilə saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'2.23.232' hesab, N'Ödənişə qədər saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'2.23.233' hesab, N'vərilmiş qısamüddətli borclar' ad union all
select N'STP PMZ' comp, N'2.23.234' hesab, N'Digər qısamüddətli invəstisiyalar' ad union all
select N'STP PMZ' comp, N'2.23.235' hesab, N'Sair qısamüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP PMZ' comp, N'2.24' hesab, N'Sair qısamüddətli aktivəər' ad union all
select N'STP PMZ' comp, N'2.24.241' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP PMZ' comp, N'2.24.241.01' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP PMZ' comp, N'2.24.241.01.01' hesab, N'Evəzlesdirilen xercler' ad union all
select N'STP PMZ' comp, N'2.24.242' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP PMZ' comp, N'2.24.242.01' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP PMZ' comp, N'2.24.242.01.01' hesab, N'İdxalat xərcləri' ad union all
select N'STP PMZ' comp, N'2.24.242.01.02' hesab, N'Digər Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP PMZ' comp, N'2.24.243' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'2.24.243.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'2.24.243.01.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'2.24.244' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP PMZ' comp, N'2.24.244.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP PMZ' comp, N'2.24.244.01.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP PMZ' comp, N'2.24.245' hesab, N'Digər qısamüddətli aktivəər' ad union all
select N'STP PMZ' comp, N'3' hesab, N'KAPİTAL' ad union all
select N'STP PMZ' comp, N'3.30' hesab, N'Ödənilmiş nizamnamə (nominal) kapital' ad union all
select N'STP PMZ' comp, N'3.30.301' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP PMZ' comp, N'3.30.301.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP PMZ' comp, N'3.30.301.01.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP PMZ' comp, N'3.30.302' hesab, N'Nizamnamə (nominal) kapitalın ödənilməmiş hissəsi' ad union all
select N'STP PMZ' comp, N'3.31' hesab, N'Emissiya gəliri' ad union all
select N'STP PMZ' comp, N'3.31.311' hesab, N'Emissiya gəliri' ad union all
select N'STP PMZ' comp, N'3.32' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP PMZ' comp, N'3.32.321' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP PMZ' comp, N'3.33' hesab, N'Kapital ehtiyatları' ad union all
select N'STP PMZ' comp, N'3.33.331' hesab, N'Yenidən qiymətləndirilmə üzrə ehtiyat' ad union all
select N'STP PMZ' comp, N'3.33.332' hesab, N'Məzənnə fərgləri üzrə ehtiyat' ad union all
select N'STP PMZ' comp, N'3.33.333' hesab, N'Qanunvəricilik üzrə ehtiyat' ad union all
select N'STP PMZ' comp, N'3.33.334' hesab, N'Nizamnamə üzrə ehtiyat' ad union all
select N'STP PMZ' comp, N'3.33.335' hesab, N'Digər ehtiyatlar' ad union all
select N'STP PMZ' comp, N'3.34' hesab, N'Bölüşdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP PMZ' comp, N'3.34.341' hesab, N'Hesabat dövəündə xalis mənfəət (zərər)' ad union all
select N'STP PMZ' comp, N'3.34.342' hesab, N'Mühasibat uçotu siyasətində dəyişikliklərlə bağlı mənfəət (zərər) üzrə düzəlişlər' ad union all
select N'STP PMZ' comp, N'3.34.343' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP PMZ' comp, N'3.34.343.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP PMZ' comp, N'3.34.343.01.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP PMZ' comp, N'3.34.344' hesab, N'Elan edilmiş divədentlər' ad union all
select N'STP PMZ' comp, N'4' hesab, N'UZUNMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP PMZ' comp, N'4.40' hesab, N'Uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.40.401' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'4.40.401.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'4.40.401.01.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'4.40.402' hesab, N'İşçilər üçün uzunmüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'4.40.403' hesab, N'Uzunmüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP PMZ' comp, N'4.40.404' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'4.40.404.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'4.40.404.01.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP PMZ' comp, N'4.40.405' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(uzunmüddətli)' ad union all
select N'STP PMZ' comp, N'4.40.406' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.40.406.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.40.406.01.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.40.407' hesab, N'Törəmə(asılı) müəssisələrə uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.40.408' hesab, N'Digər uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.41' hesab, N'Uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.41.411' hesab, N'İşdən azad olma ilə bağlı uzunmüddətli müavənətlər və öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.41.412' hesab, N'Uzunmüddətli zəmanət öhdəlikləri' ad union all
select N'STP PMZ' comp, N'4.41.413' hesab, N'Uzunmüddətli hüquqi öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.41.414' hesab, N'Digər uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.42' hesab, N'Təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP PMZ' comp, N'4.42.421' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP PMZ' comp, N'4.42.422' hesab, N'Digər təxirə salınmış vərgi öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.43' hesab, N'Uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.431' hesab, N'Malsatan və podratçılara uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.432' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.432.01' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.432.01.01' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.433' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.434' hesab, N'Faizlər üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.43.435' hesab, N'Digər uzunmüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'4.44' hesab, N'Sair uzunmüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'4.44.441' hesab, N'Uzunmüddətli pensiya öhdəlikləri' ad union all
select N'STP PMZ' comp, N'4.44.442' hesab, N'Gələcək hesabat dövələrinin gəlirləri' ad union all
select N'STP PMZ' comp, N'4.44.443' hesab, N'Alınmış uzunmüddətli avənslar' ad union all
select N'STP PMZ' comp, N'4.44.444' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP PMZ' comp, N'4.44.444.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP PMZ' comp, N'4.44.444.01.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP PMZ' comp, N'4.44.445' hesab, N'Digər uzunmüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'5' hesab, N'QISAMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP PMZ' comp, N'5.50' hesab, N'Qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.50.501' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'5.50.501.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'5.50.501.01.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'5.50.502' hesab, N'İşçilər üçün qısamüddətli bank kreditləri' ad union all
select N'STP PMZ' comp, N'5.50.503' hesab, N'Qısamüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP PMZ' comp, N'5.50.504' hesab, N'Qısamüddətli borclar' ad union all
select N'STP PMZ' comp, N'5.50.505' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(qısamüddətli)' ad union all
select N'STP PMZ' comp, N'5.50.506' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.50.507' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.50.507.01' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.50.507.01.01' hesab, N'Uzunmuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP PMZ' comp, N'5.50.507.01.02' hesab, N'Qisamuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP PMZ' comp, N'5.51' hesab, N'Qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.51.511' hesab, N'İşdən azad olma ilə bağlı qısamüddətli müavənətlər və öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.51.512' hesab, N'Qısamüddətli zəmanət öhdəlikləri' ad union all
select N'STP PMZ' comp, N'5.51.513' hesab, N'Qısamüddətli hüquqi öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.51.514' hesab, N'Mənfəətdə iştirak planı və müavənət planları' ad union all
select N'STP PMZ' comp, N'5.51.515' hesab, N'Digər qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52' hesab, N'vərgi və sair məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.521' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP PMZ' comp, N'5.52.521.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP PMZ' comp, N'5.52.521.01.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP PMZ' comp, N'5.52.521.02' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP PMZ' comp, N'5.52.521.02.01' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP PMZ' comp, N'5.52.522' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.522.01' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.522.01.01' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.522.01.02' hesab, N'Icbari odenisler uzre qisa muddetli kreditor borclari' ad union all
select N'STP PMZ' comp, N'5.52.523' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.523.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.52.523.01.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər (Həmkarlar)' ad union all
select N'STP PMZ' comp, N'5.53' hesab, N'Qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.531' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.531.01' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.531.01.01' hesab, N'Yerli Kreditor borclar' ad union all
select N'STP PMZ' comp, N'5.53.531.01.02' hesab, N'Xarici Kreditor borclar' ad union all
select N'STP PMZ' comp, N'5.53.532' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.533' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP PMZ' comp, N'5.53.533.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP PMZ' comp, N'5.53.533.01.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP PMZ' comp, N'5.53.534' hesab, N'Divədendlərin ödənilməsi üzrə təsisçilərə kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.535' hesab, N'İcarə üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.536' hesab, N'Tikinti müqavələləri üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.537' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.537.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.537.01.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.538' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.538.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.538.01.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.53.538.01.03' hesab, N'İcbari ödənişlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP PMZ' comp, N'5.54' hesab, N'Sair qısamüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.54.541' hesab, N'Qısamüddətli pensiya öhdəlikləri' ad union all
select N'STP PMZ' comp, N'5.54.542' hesab, N'Gələcək hesabat dövəünün gəlirləri' ad union all
select N'STP PMZ' comp, N'5.54.543' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'5.54.543.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'5.54.543.01.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP PMZ' comp, N'5.54.544' hesab, N'Qisamüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP PMZ' comp, N'5.54.545' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.54.545.01' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP PMZ' comp, N'5.54.545.01.01' hesab, N'Sayim artiqindan yaranan ehtiyyat' ad union all
select N'STP PMZ' comp, N'6' hesab, N'GəLİRLəR' ad union all
select N'STP PMZ' comp, N'6.60' hesab, N'əsas əməliyyat gəliri' ad union all
select N'STP PMZ' comp, N'6.60.601' hesab, N'Satış' ad union all
select N'STP PMZ' comp, N'6.60.601.01' hesab, N'Hazirmehsulların satışları' ad union all
select N'STP PMZ' comp, N'6.60.601.01.01' hesab, N'Kabel Hazırməhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP PMZ' comp, N'6.60.601.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.04' hesab, N'Polimer məmulatlarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.05' hesab, N'Metaləritmə Zavədu məhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.06' hesab, N'AMPZ Hazırməhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının satışı' ad union all
select N'STP PMZ' comp, N'6.60.601.02' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP PMZ' comp, N'6.60.601.02.01' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP PMZ' comp, N'6.60.601.Z' hesab, N'Yansitma Hesabi' ad union all
select N'STP PMZ' comp, N'6.60.601.Z.01' hesab, N'Yansitma Hesabi' ad union all
select N'STP PMZ' comp, N'6.60.602' hesab, N'Satılmış malların qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01' hesab, N'Hazırməhsullar üzrə qaytarmalar' ad union all
select N'STP PMZ' comp, N'6.60.602.01.01' hesab, N'Kabel Hazırməhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP PMZ' comp, N'6.60.602.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.04' hesab, N'Polimer məmulatlarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.05' hesab, N'Metaləritmə Zavədu məhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.06' hesab, N'AMPZ Hazırməhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının qaytarılması' ad union all
select N'STP PMZ' comp, N'6.60.602.02' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP PMZ' comp, N'6.60.602.02.01' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP PMZ' comp, N'6.60.602.Z' hesab, N'Satilmis Mallarin Qaytarilmasi Yansitma' ad union all
select N'STP PMZ' comp, N'6.60.602.Z.01' hesab, N'Satilmis Mallarin Qaytarilmasi Yansitma' ad union all
select N'STP PMZ' comp, N'6.60.603' hesab, N'vərilmiş güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01' hesab, N'Hazırməhsullar üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.01' hesab, N'Kabel Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.02' hesab, N'SPZ hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.04' hesab, N'Polimer məmulatları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.05' hesab, N'Metaləritmə Zavədu məhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.06' hesab, N'AMPZ Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.01.08' hesab, N'Qeyri Konvəyer hazırməhsulları üzrə güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.02' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP PMZ' comp, N'6.60.603.02.01' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP PMZ' comp, N'6.61' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP PMZ' comp, N'6.61.611' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP PMZ' comp, N'6.61.611.01' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP PMZ' comp, N'6.61.611.01.01' hesab, N'Məzənnə fərqləri üzrə gəlirlər' ad union all
select N'STP PMZ' comp, N'6.61.611.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP PMZ' comp, N'6.61.611.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP PMZ' comp, N'6.61.611.01.04' hesab, N'Anbar sayımlarından yaranan gəlir' ad union all
select N'STP PMZ' comp, N'6.61.611.01.98' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP PMZ' comp, N'6.61.611.Z' hesab, N'Sair emeliyyat gelirleri Yansitma' ad union all
select N'STP PMZ' comp, N'6.61.611.Z.01' hesab, N'Sair emeliyyat gelirleri Yansitma' ad union all
select N'STP PMZ' comp, N'6.62' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP PMZ' comp, N'6.62.621' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP PMZ' comp, N'6.63' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP PMZ' comp, N'6.63.631' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP PMZ' comp, N'6.63.631.01' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP PMZ' comp, N'6.63.631.01.01' hesab, N'Hedging üzrə gəlirlər' ad union all
select N'STP PMZ' comp, N'6.64' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP PMZ' comp, N'6.64.641' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP PMZ' comp, N'7' hesab, N'XəRCLəR' ad union all
select N'STP PMZ' comp, N'7.70' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP PMZ' comp, N'7.70.701' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP PMZ' comp, N'7.70.701.01' hesab, N'Hazirmehsul satışlarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.01' hesab, N'Kabel Hazırməhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP PMZ' comp, N'7.70.701.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.04' hesab, N'Polimer məmulatlarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.05' hesab, N'Metaləritmə Zavədu məhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.06' hesab, N'AMPZ Hazırməhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.02' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.02.01' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP PMZ' comp, N'7.70.701.Z' hesab, N'Satisin Maya dəyəri Yansitma' ad union all
select N'STP PMZ' comp, N'7.70.701.Z.01' hesab, N'Satisin Maya dəyəri Yansitma' ad union all
select N'STP PMZ' comp, N'7.71' hesab, N'Kommersiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711' hesab, N'Kommersiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.01' hesab, N'əmək haqqı və işçilik xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.01.01' hesab, N'İşçilik xərclər' ad union all
select N'STP PMZ' comp, N'7.71.711.01.02' hesab, N'İR Xərcləri (təlim, tədbir, axtarış)' ad union all
select N'STP PMZ' comp, N'7.71.711.01.03' hesab, N'Ezamiyyə xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.02' hesab, N'Marketinq Xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.02.01' hesab, N'Reklam Xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.02.02' hesab, N'Araşdırma xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.02.03' hesab, N'Digər marketinq xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.03' hesab, N'əsas vəsaitlərin Amortizasiya Xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.03.03' hesab, N'Nəqliyyat vəsitələriın amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.03.04' hesab, N'Digər Avədanlıqların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.04.01' hesab, N'Proqram təminatları üzrə amortizasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.05' hesab, N'əsas vəsaitlərin Təmir Xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.05.01' hesab, N'Bina Tikili və Qurğuların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.05.02' hesab, N'Maşın və Avədanlıqların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.05.03' hesab, N'Nəqliyyat vəsitələriın təmir xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.05.04' hesab, N'Digər Avədanlıqların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.06' hesab, N'Logostika xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.06.01' hesab, N'Yükdaşıma xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.06.02' hesab, N'Sərnişindaşıma xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.06.03' hesab, N'Yanacaq xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.06.99' hesab, N'Digər logistika xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.07' hesab, N'Sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.07.01' hesab, N'Məhsullar üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.07.02' hesab, N'Nəqliyyat vəsitələri üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.07.03' hesab, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99' hesab, N'Digər Xərclər' ad union all
select N'STP PMZ' comp, N'7.71.711.99.01' hesab, N'İcarə xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.02' hesab, N'IT xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.03' hesab, N'Kommunal xərclər' ad union all
select N'STP PMZ' comp, N'7.71.711.99.04' hesab, N'Profisonal xidmətlər xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.99.05' hesab, N'Bank xidmətləri xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.99.06' hesab, N'vərgi Xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.07' hesab, N'əməyin mühafizəsi və tibbi xərclər' ad union all
select N'STP PMZ' comp, N'7.71.711.99.08' hesab, N'Sığorta xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.09' hesab, N'Təsərrüfat xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.11' hesab, N'Xarab Mal xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.13' hesab, N'Mobil Rabitə xərci' ad union all
select N'STP PMZ' comp, N'7.71.711.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.16' hesab, N'Faiz xercleri' ad union all
select N'STP PMZ' comp, N'7.71.711.99.22' hesab, N'Menzil icare xerci' ad union all
select N'STP PMZ' comp, N'7.71.711.99.99' hesab, N'Sair Xərclər' ad union all
select N'STP PMZ' comp, N'7.71.711.Z' hesab, N'Kommersiya Xercleri Yansitma' ad union all
select N'STP PMZ' comp, N'7.71.711.Z.01' hesab, N'Kommersiya Xercleri Yansitma' ad union all
select N'STP PMZ' comp, N'7.72' hesab, N'İnzibati xərclər' ad union all
select N'STP PMZ' comp, N'7.72.721' hesab, N'İnzibati xərclər' ad union all
select N'STP PMZ' comp, N'7.72.721.01' hesab, N'əmək haqqı və işçilik xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.01.01' hesab, N'İşçilik xərclər' ad union all
select N'STP PMZ' comp, N'7.72.721.01.02' hesab, N'İR Xərcləri (təlim, tədbir, axtarış)' ad union all
select N'STP PMZ' comp, N'7.72.721.01.03' hesab, N'Ezamiyyə xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.01.04' hesab, N'İşçilik xərclər (ofis heyəti)' ad union all
select N'STP PMZ' comp, N'7.72.721.01.05' hesab, N'İşçilik xərclər (istehsalat heyəti)' ad union all
select N'STP PMZ' comp, N'7.72.721.02' hesab, N'Marketinq Xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.02.01' hesab, N'Reklam Xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.02.02' hesab, N'Səhifələrin idarə olunması xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.02.03' hesab, N'Araşdırma xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.02.04' hesab, N'Digər marketinq xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.03' hesab, N'əsas vəsaitlərin Amortizasiya Xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.03.03' hesab, N'Nəqliyyat vəsitələriın amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.03.04' hesab, N'Digər Avədanlıqların amortizasiya xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.04.01' hesab, N'Proqram təminatları üzrə amortizasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.05' hesab, N'əsas vəsaitlərin Təmir Xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.05.01' hesab, N'Bina Tikili və Qurğuların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.05.02' hesab, N'Maşın və Avədanlıqların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.05.03' hesab, N'Nəqliyyat vəsitelerinin temiri xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.05.04' hesab, N'Digər Avədanlıqların təmir xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.06' hesab, N'Logostika xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.06.01' hesab, N'Yükdaşıma xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.06.02' hesab, N'Sernisindasima xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.06.03' hesab, N'Yanacaq xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.06.04' hesab, N'Masinalrin icaresi xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.06.99' hesab, N'Digər logistika xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.07' hesab, N'Sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.07.01' hesab, N'Məhsullar üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.07.02' hesab, N'Nəqliyyat vəsitələri üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.07.03' hesab, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.99' hesab, N'Digər Xərclər' ad union all
select N'STP PMZ' comp, N'7.72.721.99.01' hesab, N'Icare xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.02' hesab, N'IT xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.03' hesab, N'Kommunal xerclerr' ad union all
select N'STP PMZ' comp, N'7.72.721.99.04' hesab, N'Profisonal xidmetler xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.99.05' hesab, N'Bank xidmetleri xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.99.06' hesab, N'vərgi xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.07' hesab, N'Emeyin muhafizesi və tibbi xercler' ad union all
select N'STP PMZ' comp, N'7.72.721.99.08' hesab, N'Sığorta xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.09' hesab, N'Teserrufat xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.11' hesab, N'Xarab mal xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.13' hesab, N'Mobil Rabitə xərci' ad union all
select N'STP PMZ' comp, N'7.72.721.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.16' hesab, N'Faiz xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.17' hesab, N'SCIP xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.99.18' hesab, N'Tehlukesizlik (muhafize) xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.19' hesab, N'Admin xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.20' hesab, N'Yemekxana xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.21' hesab, N'Energetika xercleri' ad union all
select N'STP PMZ' comp, N'7.72.721.99.22' hesab, N'Menzil icare xerci' ad union all
select N'STP PMZ' comp, N'7.72.721.99.99' hesab, N'Sair xercler' ad union all
select N'STP PMZ' comp, N'7.72.721.Z' hesab, N'Inzibati Xercler Yansitma' ad union all
select N'STP PMZ' comp, N'7.72.721.Z.01' hesab, N'Inzibati Xercler Yansitma' ad union all
select N'STP PMZ' comp, N'7.73' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP PMZ' comp, N'7.73.731' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP PMZ' comp, N'7.73.731.01' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP PMZ' comp, N'7.73.731.01.01' hesab, N'Məzənnə fərqləri üzrə xercler' ad union all
select N'STP PMZ' comp, N'7.73.731.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP PMZ' comp, N'7.73.731.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP PMZ' comp, N'7.73.731.01.04' hesab, N'Anbar sayımlarından yaranan xərc' ad union all
select N'STP PMZ' comp, N'7.73.731.Z' hesab, N'Sair emeliyyat xercleri yansitma' ad union all
select N'STP PMZ' comp, N'7.73.731.Z.01' hesab, N'Sair emeliyyat xercleri yansitma' ad union all
select N'STP PMZ' comp, N'7.74' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP PMZ' comp, N'7.74.741' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP PMZ' comp, N'7.75' hesab, N'Maliyyə xərcləri' ad union all
select N'STP PMZ' comp, N'7.75.751' hesab, N'Maliyyə xərcləri' ad union all
select N'STP PMZ' comp, N'7.76' hesab, N'Fövəəladə xərclər' ad union all
select N'STP PMZ' comp, N'7.76.761' hesab, N'Fövəəladə xərclər' ad union all
select N'STP PMZ' comp, N'8' hesab, N'MəNFəəTLəR (ZəRəRLəR)' ad union all
select N'STP PMZ' comp, N'8.80' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP PMZ' comp, N'8.80.801' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP PMZ' comp, N'8.80.801.01' hesab, N'Umimi Menfeet (Zerer)' ad union all
select N'STP PMZ' comp, N'8.80.801.01.01' hesab, N'Umimi Menfeet (Zerer)' ad union all
select N'STP PMZ' comp, N'8.81' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP PMZ' comp, N'8.81.811' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP PMZ' comp, N'9' hesab, N'MəNFəəT vəRGİSİ' ad union all
select N'STP PMZ' comp, N'9.90' hesab, N'Mənfəət vərgisi' ad union all
select N'STP PMZ' comp, N'9.90.901' hesab, N'Cari mənfəət vərgisi üzrə xərclər' ad union all
select N'STP PMZ' comp, N'9.90.902' hesab, N'Təxirə salınmış mənfəət vərgisi üzrə xərclər' ad union all
select N'STP QQZ' comp, N'1' hesab, N'UZUNMÜDDəTLİ aktivəər' ad union all
select N'STP QQZ' comp, N'1.10' hesab, N'Qeyri-maddi aktivəər' ad union all
select N'STP QQZ' comp, N'1.10.101' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP QQZ' comp, N'1.10.101.01' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP QQZ' comp, N'1.10.101.01.01' hesab, N'Proqram təminatı' ad union all
select N'STP QQZ' comp, N'1.10.101.01.02' hesab, N'Patentlər' ad union all
select N'STP QQZ' comp, N'1.10.101.01.03' hesab, N'Sertifikat və Lisenziyalar' ad union all
select N'STP QQZ' comp, N'1.10.102' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.10.102.01' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.10.102.01.01' hesab, N'Proqram təminatı üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.10.102.01.02' hesab, N'Patentlər üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.10.102.01.03' hesab, N'Sertifikat və Lisenziyalar üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11' hesab, N'Torpaq, tikili və avədanlıqlar' ad union all
select N'STP QQZ' comp, N'1.11.111' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP QQZ' comp, N'1.11.111.01' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP QQZ' comp, N'1.11.111.01.01' hesab, N'Bina Tikili və Qurğular' ad union all
select N'STP QQZ' comp, N'1.11.111.01.02' hesab, N'Maşın və Avədanlıqlar' ad union all
select N'STP QQZ' comp, N'1.11.111.01.03' hesab, N'Nəqliyyat vəsitələri' ad union all
select N'STP QQZ' comp, N'1.11.111.01.04' hesab, N'Yüksək texnologiyalar məhsulu olan hesablama texnikalarının dəyəri' ad union all
select N'STP QQZ' comp, N'1.11.111.01.05' hesab, N'Digər Avədanlıqlar' ad union all
select N'STP QQZ' comp, N'1.11.111.01.06' hesab, N'Azqiymətli Əsas vəsaitlər' ad union all
select N'STP QQZ' comp, N'1.11.112' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.01' hesab, N'Bina Tikili və Qurğular üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.02' hesab, N'Maşın və Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.03' hesab, N'Nəqliyyat vəsitələri üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.04' hesab, N'Yüksək texnologiyalar məhsulu olan hesablama texnikası üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.05' hesab, N'Digər Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.112.01.06' hesab, N'Azqiymətli Əsas vəsaitlər üzrə yığılmış amortizasiya' ad union all
select N'STP QQZ' comp, N'1.11.113' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP QQZ' comp, N'1.11.113.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP QQZ' comp, N'1.11.113.01.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP QQZ' comp, N'1.11.113.02' hesab, N'1-Cİ ZSU ' ad union all
select N'STP QQZ' comp, N'1.11.113.02.01' hesab, N'1-Cİ ZSU SİLİNMƏ' ad union all
select N'STP QQZ' comp, N'1.11.113.02.01.01' hesab, N'Torpaq, tikili və avədanliqlarla bağlı məsrəflərin kapitallasdırılması' ad union all
select N'STP QQZ' comp, N'1.12' hesab, N'İnvəstisiya mülkiyyəti' ad union all
select N'STP QQZ' comp, N'1.12.121' hesab, N'İnvəstisiya mülkiyyətinin dəyəri' ad union all
select N'STP QQZ' comp, N'1.12.122' hesab, N'İnvəstisiya mülkiyyəti üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP QQZ' comp, N'1.12.123' hesab, N'İnvəstisiya mülkiyyəti ilə bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP QQZ' comp, N'1.13' hesab, N'Bioloji aktivəər' ad union all
select N'STP QQZ' comp, N'1.13.131' hesab, N'Bioloji aktivəərin dəyəri' ad union all
select N'STP QQZ' comp, N'1.13.132' hesab, N'Bioloji aktivəər üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP QQZ' comp, N'1.14' hesab, N'Təbii sərvətlər' ad union all
select N'STP QQZ' comp, N'1.14.141' hesab, N'Təbii sərvətlərin (ehtiyatların) dəyəri' ad union all
select N'STP QQZ' comp, N'1.14.142' hesab, N'Təbii sərvətlərin (ehtiyatların) tükənməsi' ad union all
select N'STP QQZ' comp, N'1.15' hesab, N'İştirak payı metodu ilə uçota alınmış invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.15.151' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.15.151.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.15.151.01.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.15.152' hesab, N'Birgə müəssisələrə invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.15.153' hesab, N'Asılı və birgə müəssisələrə invəstisiyaların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP QQZ' comp, N'1.16' hesab, N'Təxirə salınmış vərgi aktivəəri' ad union all
select N'STP QQZ' comp, N'1.16.161' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi aktivəəri' ad union all
select N'STP QQZ' comp, N'1.16.162' hesab, N'Digər təxirə salınmış vərgi aktivəəri' ad union all
select N'STP QQZ' comp, N'1.17' hesab, N'Uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.171' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.171.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.171.01.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.172' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.172.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.172.01.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.173' hesab, N'əsas idarəetmə heyətinin uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.174' hesab, N'İcarə üzrə uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.175' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.176' hesab, N'Faizlər üzrə uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.17.177' hesab, N'Digər uzunmüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'1.18' hesab, N'Sair uzunmüddətli maliyyə aktivəəri' ad union all
select N'STP QQZ' comp, N'1.18.181' hesab, N'Ödənişə qədər saxlanılan uzunmüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.18.182' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'1.18.182.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'1.18.182.01.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'1.18.183' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.18.183.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.18.183.01.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'1.18.184' hesab, N'Sair uzunmüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP QQZ' comp, N'1.19' hesab, N'Sair uzunmüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'1.19.191' hesab, N'Gələcək hesabat dövələrinin xərcləri' ad union all
select N'STP QQZ' comp, N'1.19.192' hesab, N'vərilmiş uzunmüddətli avənslar' ad union all
select N'STP QQZ' comp, N'1.19.193' hesab, N'Digər uzunmüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'2' hesab, N'QISAMÜDDəTLİ aktivəər' ad union all
select N'STP QQZ' comp, N'2.20' hesab, N'Ehtiyatlar' ad union all
select N'STP QQZ' comp, N'2.20.201' hesab, N'Material ehtiyatları' ad union all
select N'STP QQZ' comp, N'2.20.201.01' hesab, N'Material ehtiyatları' ad union all
select N'STP QQZ' comp, N'2.20.201.01.01' hesab, N'Xammallar' ad union all
select N'STP QQZ' comp, N'2.20.201.01.02' hesab, N'Yarimfabrikatlar' ad union all
select N'STP QQZ' comp, N'2.20.201.01.03' hesab, N'Tekraremal və tullantilar' ad union all
select N'STP QQZ' comp, N'2.20.201.01.04' hesab, N'BenziN'ad union all
select N'STP QQZ' comp, N'2.20.201.01.05' hesab, N'Dizel' ad union all
select N'STP QQZ' comp, N'2.20.201.01.06' hesab, N'Mal-material' ad union all
select N'STP QQZ' comp, N'2.20.201.01.99' hesab, N'İnvəntarizasiya' ad union all
select N'STP QQZ' comp, N'2.20.201.02' hesab, N'Yolda olan xammallar' ad union all
select N'STP QQZ' comp, N'2.20.201.02.01' hesab, N'Yolda olan xammallar' ad union all
select N'STP QQZ' comp, N'2.20.202' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.01' hesab, N'Xammal və Material Serfiyyatları' ad union all
select N'STP QQZ' comp, N'2.20.202.01.02' hesab, N'İşçilik xərcləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.03' hesab, N'STP Utility of FA' ad union all
select N'STP QQZ' comp, N'2.20.202.01.04' hesab, N'Amortizasiya Xərcləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.05' hesab, N'Alınmış Xidmət xərcləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.06' hesab, N'Qeyri Konvəyer Bitmemis Istehsalat' ad union all
select N'STP QQZ' comp, N'2.20.202.01.07' hesab, N'Tərtibat/detal dəyəri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.10' hesab, N'STP CanteeN'ad union all
select N'STP QQZ' comp, N'2.20.202.01.11' hesab, N'STP Transportation expenses' ad union all
select N'STP QQZ' comp, N'2.20.202.01.12' hesab, N'Bank qarantiya faizi' ad union all
select N'STP QQZ' comp, N'2.20.202.01.13' hesab, N'Bank xidmətləri xərci' ad union all
select N'STP QQZ' comp, N'2.20.202.01.14' hesab, N'Bank kredit faizi' ad union all
select N'STP QQZ' comp, N'2.20.202.01.15' hesab, N'Yanacaq və sürtkü materialları' ad union all
select N'STP QQZ' comp, N'2.20.202.01.16' hesab, N'Ezamiyyət xərcləri' ad union all
select N'STP QQZ' comp, N'2.20.202.01.17' hesab, N'STP Rent' ad union all
select N'STP QQZ' comp, N'2.20.202.01.18' hesab, N'STP HSE & Medical' ad union all
select N'STP QQZ' comp, N'2.20.202.01.19' hesab, N'STP Admin expenses' ad union all
select N'STP QQZ' comp, N'2.20.202.01.20' hesab, N'STP Energy support' ad union all
select N'STP QQZ' comp, N'2.20.202.01.21' hesab, N'STP SCİP rent' ad union all
select N'STP QQZ' comp, N'2.20.202.01.22' hesab, N'STP Security' ad union all
select N'STP QQZ' comp, N'2.20.202.01.23' hesab, N'STP Other ShS' ad union all
select N'STP QQZ' comp, N'2.20.202.01.24' hesab, N'Personal qidalanma xərci' ad union all
select N'STP QQZ' comp, N'2.20.202.01.25' hesab, N'Fərdi mühafizə vəsitələri xərci' ad union all
select N'STP QQZ' comp, N'2.20.202.01.26' hesab, N'Yükdaşıma xərci' ad union all
select N'STP QQZ' comp, N'2.20.202.01.99' hesab, N'Digər Xercler' ad union all
select N'STP QQZ' comp, N'2.20.202.99' hesab, N'Yansıtma Hesabları' ad union all
select N'STP QQZ' comp, N'2.20.202.99.01' hesab, N'Yansıtma Hesabları (Istehsalat)' ad union all
select N'STP QQZ' comp, N'2.20.202.99.02' hesab, N'Yansıtma Hesabları (Malzeme vərman)' ad union all
select N'STP QQZ' comp, N'2.20.203' hesab, N'Tikinti müqavələləri üzrə məsrəflər' ad union all
select N'STP QQZ' comp, N'2.20.204' hesab, N'Hazır məhsul' ad union all
select N'STP QQZ' comp, N'2.20.204.01' hesab, N'Hazır məhsul' ad union all
select N'STP QQZ' comp, N'2.20.204.01.01' hesab, N'Hazır məhsul' ad union all
select N'STP QQZ' comp, N'2.20.204.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP QQZ' comp, N'2.20.204.01.03' hesab, N'Texniki Qazlar Zavədu Hazir Mehsullari' ad union all
select N'STP QQZ' comp, N'2.20.204.01.04' hesab, N'Polimer Məmulatları Zavədu' ad union all
select N'STP QQZ' comp, N'2.20.204.01.05' hesab, N'Metaləritmə Zavədu' ad union all
select N'STP QQZ' comp, N'2.20.204.01.06' hesab, N'Alüminium və Mis Profillər Zavədu HM' ad union all
select N'STP QQZ' comp, N'2.20.204.01.07' hesab, N'Elektrik Avədanlıqları Hazır Məhsulları' ad union all
select N'STP QQZ' comp, N'2.20.204.01.08' hesab, N'Qeyri Konvəyer Hazırməhsulları' ad union all
select N'STP QQZ' comp, N'2.20.204.01.09' hesab, N'10 ədəd Hovə maşını' ad union all
select N'STP QQZ' comp, N'2.20.205' hesab, N'Mallar' ad union all
select N'STP QQZ' comp, N'2.20.205.01' hesab, N'Ticari Mallar' ad union all
select N'STP QQZ' comp, N'2.20.205.01.01' hesab, N'Ticari Mallar' ad union all
select N'STP QQZ' comp, N'2.20.205.02' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP QQZ' comp, N'2.20.205.02.01' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP QQZ' comp, N'2.20.206' hesab, N'Satış məqsədi ilə saxlanılan Digər aktivəər' ad union all
select N'STP QQZ' comp, N'2.20.207' hesab, N'Digər ehtiyatlar' ad union all
select N'STP QQZ' comp, N'2.20.207.01' hesab, N'Digər ehtiyatlar' ad union all
select N'STP QQZ' comp, N'2.20.207.01.01' hesab, N'Azqiymətli tezköhnələn materiallar' ad union all
select N'STP QQZ' comp, N'2.20.207.01.02' hesab, N'Təsərrüfat malları' ad union all
select N'STP QQZ' comp, N'2.20.207.02' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP QQZ' comp, N'2.20.207.02.01' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP QQZ' comp, N'2.20.208' hesab, N'Ehtiyatların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP QQZ' comp, N'2.20.208.99' hesab, N'Isyerleri arasi anbar transferleri' ad union all
select N'STP QQZ' comp, N'2.20.209' hesab, N'Hazırlanmış tərtibatlar' ad union all
select N'STP QQZ' comp, N'2.20.209.01' hesab, N'Hazırlanmış tərtibatlar' ad union all
select N'STP QQZ' comp, N'2.20.209.01.01' hesab, N'Hazırlanmış tərtibatlar' ad union all
select N'STP QQZ' comp, N'2.20.209.01.02' hesab, N'Hazırlanmış ehtiyyat hissələri (T-72M1 əB03BT1686)' ad union all
select N'STP QQZ' comp, N'2.21' hesab, N'Qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.211' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.211.01' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.211.01.01' hesab, N'Korporativəmüştərilər üzrə debitor borc' ad union all
select N'STP QQZ' comp, N'2.21.211.01.02' hesab, N'Fiziki şəxslər üzrə debitor borc' ad union all
select N'STP QQZ' comp, N'2.21.211.01.03' hesab, N'Export müştərilər üzrə debitor borc' ad union all
select N'STP QQZ' comp, N'2.21.212' hesab, N'Törəmə (asılı) müəssisələrin qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.213' hesab, N'əsas idarəetmə heyətinin qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.214' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.214.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.214.01.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.215' hesab, N'Tikinti müqavələləri üzrə qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.216' hesab, N'Faizlər üzrə qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.217' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.217.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.217.01.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.217.01.02' hesab, N'vərgi üzrə Digər qısamüddətli debitor borcları' ad union all
select N'STP QQZ' comp, N'2.21.218' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP QQZ' comp, N'2.21.218.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP QQZ' comp, N'2.21.218.01.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP QQZ' comp, N'2.22' hesab, N'Pul vəsaitləri və onların ekvəvəlentləri' ad union all
select N'STP QQZ' comp, N'2.22.221' hesab, N'Kassa' ad union all
select N'STP QQZ' comp, N'2.22.221.01' hesab, N'Kassa' ad union all
select N'STP QQZ' comp, N'2.22.221.01.01' hesab, N'Kassa' ad union all
select N'STP QQZ' comp, N'2.22.222' hesab, N'Yolda olan pul köçürmələri' ad union all
select N'STP QQZ' comp, N'2.22.222.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP QQZ' comp, N'2.22.222.01.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP QQZ' comp, N'2.22.223' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP QQZ' comp, N'2.22.223.01' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP QQZ' comp, N'2.22.223.01.01' hesab, N'Bank hesablaşma hesabları (AZN)' ad union all
select N'STP QQZ' comp, N'2.22.223.01.02' hesab, N'Bank hesablaşma hesabları (USD)' ad union all
select N'STP QQZ' comp, N'2.22.223.01.03' hesab, N'Bank hesablaşma hesabları (EUR)' ad union all
select N'STP QQZ' comp, N'2.22.223.01.04' hesab, N'Bank hesablaşma hesabları (RUR)' ad union all
select N'STP QQZ' comp, N'2.22.223.01.05' hesab, N'Bank hesablaşma hesabları (GBP)' ad union all
select N'STP QQZ' comp, N'2.22.224' hesab, N'Tələblərə əsasən açılan Digər bank hesabları' ad union all
select N'STP QQZ' comp, N'2.22.225' hesab, N'Pul vəsaitlərinin ekvəvəlentləri' ad union all
select N'STP QQZ' comp, N'2.22.226' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP QQZ' comp, N'2.22.226.01' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP QQZ' comp, N'2.22.226.01.01' hesab, N'ƏDvəsub-uçot hesabı' ad union all
select N'STP QQZ' comp, N'2.22.226.01.02' hesab, N'ƏDvəsub-uçot hesabı (DGK üzrə qalığı)' ad union all
select N'STP QQZ' comp, N'2.23' hesab, N'Sair qısamüddətli maliyyə aktivəəri' ad union all
select N'STP QQZ' comp, N'2.23.231' hesab, N'Satış məqsədi ilə saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'2.23.232' hesab, N'Ödənişə qədər saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'2.23.233' hesab, N'vərilmiş qısamüddətli borclar' ad union all
select N'STP QQZ' comp, N'2.23.234' hesab, N'Digər qısamüddətli invəstisiyalar' ad union all
select N'STP QQZ' comp, N'2.23.235' hesab, N'Sair qısamüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP QQZ' comp, N'2.24' hesab, N'Sair qısamüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'2.24.241' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP QQZ' comp, N'2.24.241.01' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP QQZ' comp, N'2.24.241.01.01' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP QQZ' comp, N'2.24.241.01.02' hesab, N'Əvəzləşdirilən vərgilər Gömrük' ad union all
select N'STP QQZ' comp, N'2.24.242' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP QQZ' comp, N'2.24.242.01' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP QQZ' comp, N'2.24.242.01.01' hesab, N'İdxalat xərcləri' ad union all
select N'STP QQZ' comp, N'2.24.242.01.02' hesab, N'Digər Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP QQZ' comp, N'2.24.242.01.04' hesab, N'Gələcək hesabat dövəünün xərcləri (Nvəİcbarı sığortası)' ad union all
select N'STP QQZ' comp, N'2.24.242.01.05' hesab, N'Gələcək hesabat dövəünün xərcləri (NvəKasko sığortası)' ad union all
select N'STP QQZ' comp, N'2.24.242.01.06' hesab, N'İşçilik (STP)' ad union all
select N'STP QQZ' comp, N'2.24.242.01.07' hesab, N'İşçilik (STP ASSAN)' ad union all
select N'STP QQZ' comp, N'2.24.243' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'2.24.243.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'2.24.243.01.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'2.24.243.01.02' hesab, N'vərilmiş qısamüddətli avənslar (USD)' ad union all
select N'STP QQZ' comp, N'2.24.243.01.03' hesab, N'vərilmiş qısamüddətli avənslar (EURO)' ad union all
select N'STP QQZ' comp, N'2.24.244' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP QQZ' comp, N'2.24.244.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP QQZ' comp, N'2.24.244.01.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP QQZ' comp, N'2.24.245' hesab, N'Digər qısamüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'2.24.245.01' hesab, N'Digər qısamüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'2.24.245.01.01' hesab, N'Digər qısamüddətli aktivəər' ad union all
select N'STP QQZ' comp, N'3' hesab, N'KAPİTAL' ad union all
select N'STP QQZ' comp, N'3.30' hesab, N'Ödənilmiş nizamnamə (nominal) kapital' ad union all
select N'STP QQZ' comp, N'3.30.301' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP QQZ' comp, N'3.30.301.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP QQZ' comp, N'3.30.301.01.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP QQZ' comp, N'3.30.302' hesab, N'Nizamnamə (nominal) kapitalın ödənilməmiş hissəsi' ad union all
select N'STP QQZ' comp, N'3.31' hesab, N'Emissiya gəliri' ad union all
select N'STP QQZ' comp, N'3.31.311' hesab, N'Emissiya gəliri' ad union all
select N'STP QQZ' comp, N'3.32' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP QQZ' comp, N'3.32.321' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP QQZ' comp, N'3.33' hesab, N'Kapital ehtiyatları' ad union all
select N'STP QQZ' comp, N'3.33.331' hesab, N'Yenidən qiymətləndirilmə üzrə ehtiyat' ad union all
select N'STP QQZ' comp, N'3.33.332' hesab, N'Məzənnə fərgləri üzrə ehtiyat' ad union all
select N'STP QQZ' comp, N'3.33.333' hesab, N'Qanunvəricilik üzrə ehtiyat' ad union all
select N'STP QQZ' comp, N'3.33.334' hesab, N'Nizamnamə üzrə ehtiyat' ad union all
select N'STP QQZ' comp, N'3.33.335' hesab, N'Digər ehtiyatlar' ad union all
select N'STP QQZ' comp, N'3.34' hesab, N'Bölüşdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP QQZ' comp, N'3.34.341' hesab, N'Hesabat dövəündə xalis mənfəət (zərər)' ad union all
select N'STP QQZ' comp, N'3.34.341.01' hesab, N'Hesabat dövəündə xalis mənfəət (zərər)' ad union all
select N'STP QQZ' comp, N'3.34.341.01.01' hesab, N'Hesabat dövəündə xalis mənfəət (zərər)' ad union all
select N'STP QQZ' comp, N'3.34.342' hesab, N'Mühasibat uçotu siyasətində dəyişikliklərlə bağlı mənfəət (zərər) üzrə düzəlişlər' ad union all
select N'STP QQZ' comp, N'3.34.343' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP QQZ' comp, N'3.34.343.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP QQZ' comp, N'3.34.343.01.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP QQZ' comp, N'3.34.344' hesab, N'Elan edilmiş divədentlər' ad union all
select N'STP QQZ' comp, N'4' hesab, N'UZUNMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP QQZ' comp, N'4.40' hesab, N'Uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.40.401' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'4.40.401.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'4.40.401.01.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'4.40.402' hesab, N'İşçilər üçün uzunmüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'4.40.403' hesab, N'Uzunmüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP QQZ' comp, N'4.40.404' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'4.40.404.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'4.40.404.01.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP QQZ' comp, N'4.40.405' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(uzunmüddətli)' ad union all
select N'STP QQZ' comp, N'4.40.406' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.40.406.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.40.406.01.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.40.407' hesab, N'Törəmə(asılı) müəssisələrə uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.40.408' hesab, N'Digər uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.41' hesab, N'Uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.41.411' hesab, N'İşdən azad olma ilə bağlı uzunmüddətli müavənətlər və öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.41.412' hesab, N'Uzunmüddətli zəmanət öhdəlikləri' ad union all
select N'STP QQZ' comp, N'4.41.413' hesab, N'Uzunmüddətli hüquqi öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.41.414' hesab, N'Digər uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.42' hesab, N'Təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP QQZ' comp, N'4.42.421' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP QQZ' comp, N'4.42.422' hesab, N'Digər təxirə salınmış vərgi öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.43' hesab, N'Uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.431' hesab, N'Malsatan və podratçılara uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.432' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.432.01' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.432.01.01' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.433' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.434' hesab, N'Faizlər üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.43.435' hesab, N'Digər uzunmüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'4.44' hesab, N'Sair uzunmüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'4.44.441' hesab, N'Uzunmüddətli pensiya öhdəlikləri' ad union all
select N'STP QQZ' comp, N'4.44.442' hesab, N'Gələcək hesabat dövələrinin gəlirləri' ad union all
select N'STP QQZ' comp, N'4.44.443' hesab, N'Alınmış uzunmüddətli avənslar' ad union all
select N'STP QQZ' comp, N'4.44.444' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP QQZ' comp, N'4.44.444.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP QQZ' comp, N'4.44.444.01.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP QQZ' comp, N'4.44.445' hesab, N'Digər uzunmüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'5' hesab, N'QISAMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP QQZ' comp, N'5.50' hesab, N'Qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.50.501' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'5.50.501.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'5.50.501.01.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'5.50.502' hesab, N'İşçilər üçün qısamüddətli bank kreditləri' ad union all
select N'STP QQZ' comp, N'5.50.503' hesab, N'Qısamüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP QQZ' comp, N'5.50.504' hesab, N'Qısamüddətli borclar' ad union all
select N'STP QQZ' comp, N'5.50.505' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(qısamüddətli)' ad union all
select N'STP QQZ' comp, N'5.50.506' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.50.507' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.50.507.01' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.50.507.01.01' hesab, N'Uzunmuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP QQZ' comp, N'5.50.507.01.02' hesab, N'Qisamuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP QQZ' comp, N'5.51' hesab, N'Qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.51.511' hesab, N'İşdən azad olma ilə bağlı qısamüddətli müavənətlər və öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.51.512' hesab, N'Qısamüddətli zəmanət öhdəlikləri' ad union all
select N'STP QQZ' comp, N'5.51.513' hesab, N'Qısamüddətli hüquqi öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.51.514' hesab, N'Mənfəətdə iştirak planı və müavənət planları' ad union all
select N'STP QQZ' comp, N'5.51.515' hesab, N'Digər qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52' hesab, N'vərgi və sair məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.521' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP QQZ' comp, N'5.52.521.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP QQZ' comp, N'5.52.521.01.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP QQZ' comp, N'5.52.521.01.07' hesab, N'Gəlir vərgisi İşçilər üzrə öhdəliyi' ad union all
select N'STP QQZ' comp, N'5.52.521.02' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP QQZ' comp, N'5.52.521.02.01' hesab, N'Satisdan yaranan vərgi ohdeliyi (ƏDvə' ad union all
select N'STP QQZ' comp, N'5.52.522' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.01' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.01.01' hesab, N'İşəgötürən tərəfindən ödənilməli sosial öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.01.02' hesab, N'İşçi tərəfindən ödənilməli sosial öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.02' hesab, N'İcbari sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.02.01' hesab, N'İşəgötürən tərəfindən ödənilməli icbari sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.02.02' hesab, N'İşçi tərəfindən ödənilməli icbari sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.03' hesab, N'İşsizlik sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.03.01' hesab, N'İşəgötürən tərəfindən ödənilməli işsizlik sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.522.03.02' hesab, N'İşçi tərəfindən ödənilməli işsizlik sığorta üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.523' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.523.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.52.523.01.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər (Həmkarlar)' ad union all
select N'STP QQZ' comp, N'5.53' hesab, N'Qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.531' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.531.01' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.531.01.01' hesab, N'Yerli Kreditor borclar' ad union all
select N'STP QQZ' comp, N'5.53.531.01.02' hesab, N'Xarici Kreditor borclar' ad union all
select N'STP QQZ' comp, N'5.53.531.01.03' hesab, N'Kreditor borclar Faturalanmamış' ad union all
select N'STP QQZ' comp, N'5.53.532' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.533' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP QQZ' comp, N'5.53.533.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP QQZ' comp, N'5.53.533.01.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP QQZ' comp, N'5.53.534' hesab, N'Divədendlərin ödənilməsi üzrə təsisçilərə kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.535' hesab, N'İcarə üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.536' hesab, N'Tikinti müqavələləri üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.537' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.537.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.537.01.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.538' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.538.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.538.01.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.53.538.01.03' hesab, N'İcbari ödənişlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP QQZ' comp, N'5.54' hesab, N'Sair qısamüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.54.541' hesab, N'Qısamüddətli pensiya öhdəlikləri' ad union all
select N'STP QQZ' comp, N'5.54.542' hesab, N'Gələcək hesabat dövəünün gəlirləri' ad union all
select N'STP QQZ' comp, N'5.54.543' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'5.54.543.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'5.54.543.01.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP QQZ' comp, N'5.54.543.01.02' hesab, N'Alınmış qısamüddətli avənslar (USD)' ad union all
select N'STP QQZ' comp, N'5.54.543.01.03' hesab, N'Alınmış qısamüddətli avənslar (EUR)' ad union all
select N'STP QQZ' comp, N'5.54.544' hesab, N'Qisamüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP QQZ' comp, N'5.54.545' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.54.545.01' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'5.54.545.01.01' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP QQZ' comp, N'6' hesab, N'GəLİRLəR' ad union all
select N'STP QQZ' comp, N'6.60' hesab, N'əsas əməliyyat gəliri' ad union all
select N'STP QQZ' comp, N'6.60.601' hesab, N'Satış' ad union all
select N'STP QQZ' comp, N'6.60.601.01' hesab, N'Hazirmehsulların satışları' ad union all
select N'STP QQZ' comp, N'6.60.601.01.01' hesab, N'Hazır məhsulların satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP QQZ' comp, N'6.60.601.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.04' hesab, N'Polimer məmulatlarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.05' hesab, N'Metaləritmə Zavədu məhsullarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.06' hesab, N'AMPZ Hazırməhsullarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.01.09' hesab, N'Hovə maşınların satışı' ad union all
select N'STP QQZ' comp, N'6.60.601.02' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP QQZ' comp, N'6.60.601.02.01' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP QQZ' comp, N'6.60.601.02.02' hesab, N'Mal-matrerial satışı' ad union all
select N'STP QQZ' comp, N'6.60.602' hesab, N'Satılmış malların qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01' hesab, N'Hazırməhsullar üzrə qaytarmalar' ad union all
select N'STP QQZ' comp, N'6.60.602.01.01' hesab, N'Kabel Hazırməhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP QQZ' comp, N'6.60.602.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.04' hesab, N'Polimer məmulatlarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.05' hesab, N'Metaləritmə Zavədu məhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.06' hesab, N'AMPZ Hazırməhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının qaytarılması' ad union all
select N'STP QQZ' comp, N'6.60.602.02' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP QQZ' comp, N'6.60.602.02.01' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP QQZ' comp, N'6.60.603' hesab, N'vərilmiş güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01' hesab, N'Hazırməhsullar üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.01' hesab, N'Kabel Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.02' hesab, N'SPZ hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.04' hesab, N'Polimer məmulatları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.05' hesab, N'Metaləritmə Zavədu məhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.06' hesab, N'AMPZ Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.01.08' hesab, N'Qeyri Konvəyer hazırməhsulları üzrə güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.02' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP QQZ' comp, N'6.60.603.02.01' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP QQZ' comp, N'6.61' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP QQZ' comp, N'6.61.611' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP QQZ' comp, N'6.61.611.01' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP QQZ' comp, N'6.61.611.01.01' hesab, N'Məzənnə fərqləri üzrə gəlirlər' ad union all
select N'STP QQZ' comp, N'6.61.611.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP QQZ' comp, N'6.61.611.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP QQZ' comp, N'6.61.611.01.04' hesab, N'Anbar sayımlarından yaranan gəlir' ad union all
select N'STP QQZ' comp, N'6.61.611.01.98' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP QQZ' comp, N'6.62' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP QQZ' comp, N'6.62.621' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP QQZ' comp, N'6.63' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP QQZ' comp, N'6.63.631' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP QQZ' comp, N'6.63.631.01' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP QQZ' comp, N'6.63.631.01.01' hesab, N'Hedging üzrə gəlirlər' ad union all
select N'STP QQZ' comp, N'6.64' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP QQZ' comp, N'6.64.641' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP QQZ' comp, N'7' hesab, N'XəRCLəR' ad union all
select N'STP QQZ' comp, N'7.70' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP QQZ' comp, N'7.70.701' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP QQZ' comp, N'7.70.701.01' hesab, N'Hazirmehsul satışlarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.01' hesab, N'Hazır məhsul satışlarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP QQZ' comp, N'7.70.701.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.04' hesab, N'Polimer məmulatlarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.05' hesab, N'Metaləritmə Zavədu məhsullarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.06' hesab, N'AMPZ Hazırməhsullarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.01.09' hesab, N'10 ədəd Hovə maşınının maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.02' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.70.701.02.01' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP QQZ' comp, N'7.71' hesab, N'Kommersiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.71.711' hesab, N'Kommersiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.71.711.99' hesab, N'Digər Xərclər' ad union all
select N'STP QQZ' comp, N'7.71.711.99.04' hesab, N'Profisonal xidmətlər xərci' ad union all
select N'STP QQZ' comp, N'7.71.711.99.09' hesab, N'Təsərrüfat xərcləri' ad union all
select N'STP QQZ' comp, N'7.72' hesab, N'İnzibati xərclər' ad union all
select N'STP QQZ' comp, N'7.72.721' hesab, N'İnzibati xərclər' ad union all
select N'STP QQZ' comp, N'7.72.721.01' hesab, N'Əmək haqqı və işçilik xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.01.01' hesab, N'İşçilik xərclər' ad union all
select N'STP QQZ' comp, N'7.72.721.01.02' hesab, N'İR Xərcləri (təlim, tədbir, axtarış)' ad union all
select N'STP QQZ' comp, N'7.72.721.01.03' hesab, N'Ezamiyyə xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.01.04' hesab, N'STP CanteeN'ad union all
select N'STP QQZ' comp, N'7.72.721.01.05' hesab, N'Bonus' ad union all
select N'STP QQZ' comp, N'7.72.721.02' hesab, N'Marketinq Xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.02.01' hesab, N'Reklam Xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.02.02' hesab, N'Səhifələrin idarə olunması xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.02.03' hesab, N'Araşdırma xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.02.04' hesab, N'Digər marketinq xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.03' hesab, N'əsas vəsaitlərin Amortizasiya Xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.03.03' hesab, N'Nəqliyyat vəsitələriın amortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.03.04' hesab, N'Yüksək texnologiyalar məhsulu olan hesablama texnikası üzrə amortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.03.05' hesab, N'Digər Avədanlıqların amortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.03.06' hesab, N'Azqiymətli Əvəamortizasiya xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.04.01' hesab, N'Proqram təminatları üzrə amortizasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.05' hesab, N'əsas vəsaitlərin Təmir Xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.05.01' hesab, N'Bina Tikili və Qurğuların təmir xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.05.02' hesab, N'Maşın və Avədanlıqların təmir xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.05.03' hesab, N'Nəqliyyat vəsitələriın təmir xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.05.04' hesab, N'Digər Avədanlıqların təmir xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.06' hesab, N'Logostika xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.06.01' hesab, N'Yükdaşıma xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.06.02' hesab, N'STP Transportation expenses' ad union all
select N'STP QQZ' comp, N'7.72.721.06.03' hesab, N'Yanacaq xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.06.99' hesab, N'Digər logistika xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.07' hesab, N'Sertifikasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.07.01' hesab, N'Məhsullar üzrə sertifikasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.07.02' hesab, N'Nəqliyyat vəsitələri üzrə sertifikasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.07.03' hesab, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99' hesab, N'Digər Xərclər' ad union all
select N'STP QQZ' comp, N'7.72.721.99.01' hesab, N'İcarə xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.02' hesab, N'STP IT expenses' ad union all
select N'STP QQZ' comp, N'7.72.721.99.03' hesab, N'STP Utility of FA' ad union all
select N'STP QQZ' comp, N'7.72.721.99.04' hesab, N'Profisonal xidmətlər xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.05' hesab, N'Bank xidmətləri xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.06' hesab, N'STP Rent' ad union all
select N'STP QQZ' comp, N'7.72.721.99.07' hesab, N'STP HSE & Medical' ad union all
select N'STP QQZ' comp, N'7.72.721.99.08' hesab, N'Sığorta xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.09' hesab, N'Təsərrüfat xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.11' hesab, N'Team building və Bayram (tədbir) xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.12' hesab, N'Ofis xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.13' hesab, N'Rabitə xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.14' hesab, N'Laboratoriya xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.15' hesab, N'Avəomobillərin saxlanma və Servəs xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.16' hesab, N'Cərimə xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.17' hesab, N'Nvəyagdeyishme xercleri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.18' hesab, N'Poct və kuryer xidmetleri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.19' hesab, N'Servəs və baxım xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.20' hesab, N'Təlim xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.21' hesab, N'Faiz xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.22' hesab, N'Audit xərcləri' ad union all
select N'STP QQZ' comp, N'7.72.721.99.23' hesab, N'STP Admin expenses' ad union all
select N'STP QQZ' comp, N'7.72.721.99.24' hesab, N'STP Energy support' ad union all
select N'STP QQZ' comp, N'7.72.721.99.25' hesab, N'STP SCİP rent' ad union all
select N'STP QQZ' comp, N'7.72.721.99.26' hesab, N'STP Security' ad union all
select N'STP QQZ' comp, N'7.72.721.99.27' hesab, N'STP Other ShS' ad union all
select N'STP QQZ' comp, N'7.72.721.99.28' hesab, N'Qonaq qarşılama' ad union all
select N'STP QQZ' comp, N'7.72.721.99.29' hesab, N'IT expenses' ad union all
select N'STP QQZ' comp, N'7.72.721.99.30' hesab, N'Personalın daşınması xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.31' hesab, N'Personalın qidalanması xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.32' hesab, N'Mətbəx xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.33' hesab, N'Fərdi mühafizə vəsitələri xərci' ad union all
select N'STP QQZ' comp, N'7.72.721.99.99' hesab, N'Sair Xərclər' ad union all
select N'STP QQZ' comp, N'7.73' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP QQZ' comp, N'7.73.731' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP QQZ' comp, N'7.73.731.01' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP QQZ' comp, N'7.73.731.01.01' hesab, N'Məzənnə fərqləri üzrə xercler' ad union all
select N'STP QQZ' comp, N'7.73.731.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP QQZ' comp, N'7.73.731.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP QQZ' comp, N'7.73.731.01.04' hesab, N'Anbar sayımlarından yaranan xərc' ad union all
select N'STP QQZ' comp, N'7.74' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP QQZ' comp, N'7.74.741' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP QQZ' comp, N'7.75' hesab, N'Maliyyə xərcləri' ad union all
select N'STP QQZ' comp, N'7.75.751' hesab, N'Maliyyə xərcləri' ad union all
select N'STP QQZ' comp, N'7.76' hesab, N'Fövəəladə xərclər' ad union all
select N'STP QQZ' comp, N'7.76.761' hesab, N'Fövəəladə xərclər' ad union all
select N'STP QQZ' comp, N'8' hesab, N'MəNFəəTLəR (ZəRəRLəR)' ad union all
select N'STP QQZ' comp, N'8.80' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP QQZ' comp, N'8.80.801' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP QQZ' comp, N'8.81' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP QQZ' comp, N'8.81.811' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP QQZ' comp, N'9' hesab, N'MəNFəəT vəRGİSİ' ad union all
select N'STP QQZ' comp, N'9.90' hesab, N'Mənfəət vərgisi' ad union all
select N'STP QQZ' comp, N'9.90.901' hesab, N'Cari mənfəət vərgisi üzrə xərclər' ad union all
select N'STP QQZ' comp, N'9.90.902' hesab, N'Təxirə salınmış mənfəət vərgisi üzrə xərclər' ad union all
select N'STP AMPZ' comp, N'1' hesab, N'UZUNMÜDDəTLİ aktivəər' ad union all
select N'STP AMPZ' comp, N'1.10' hesab, N'Qeyri-maddi aktivəər' ad union all
select N'STP AMPZ' comp, N'1.10.101' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP AMPZ' comp, N'1.10.101.01' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP AMPZ' comp, N'1.10.101.01.01' hesab, N'Proqram təminatı' ad union all
select N'STP AMPZ' comp, N'1.10.101.01.02' hesab, N'Patentlər' ad union all
select N'STP AMPZ' comp, N'1.10.101.01.03' hesab, N'Sertifikat və Lisenziyalar' ad union all
select N'STP AMPZ' comp, N'1.10.102' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.10.102.01' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.10.102.01.01' hesab, N'Proqram təminatı üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.10.102.01.02' hesab, N'Patentlər üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.10.102.01.03' hesab, N'Sertifikat və Lisenziyalar üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11' hesab, N'Torpaq, tikili və avədanlıqlar' ad union all
select N'STP AMPZ' comp, N'1.11.111' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP AMPZ' comp, N'1.11.111.01' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP AMPZ' comp, N'1.11.111.01.01' hesab, N'Bina Tikili və Qurğular' ad union all
select N'STP AMPZ' comp, N'1.11.111.01.02' hesab, N'Maşın və Avədanlıqlar' ad union all
select N'STP AMPZ' comp, N'1.11.111.01.03' hesab, N'Nəqliyyat vəsitələri' ad union all
select N'STP AMPZ' comp, N'1.11.111.01.04' hesab, N'Digər Avədanlıqlar' ad union all
select N'STP AMPZ' comp, N'1.11.112' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.112.01' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.112.01.01' hesab, N'Bina Tikili və Qurğular üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.112.01.02' hesab, N'Maşın və Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.112.01.03' hesab, N'Nəqliyyat vəsitələri üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.112.01.04' hesab, N'Digər Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AMPZ' comp, N'1.11.113' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP AMPZ' comp, N'1.11.113.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.02' hesab, N'Dönər Soba ( Pota ) Layihəsi' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.03' hesab, N'TGZ Oksigen sahəsi' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.04' hesab, N'TGZ Karbon sahəsi' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.05' hesab, N'Terezi (agir tonnajli)' ad union all
select N'STP AMPZ' comp, N'1.11.113.01.06' hesab, N'XJ3000 PRESS XETTI' ad union all
select N'STP AMPZ' comp, N'1.12' hesab, N'İnvəstisiya mülkiyyəti' ad union all
select N'STP AMPZ' comp, N'1.12.121' hesab, N'İnvəstisiya mülkiyyətinin dəyəri' ad union all
select N'STP AMPZ' comp, N'1.12.122' hesab, N'İnvəstisiya mülkiyyəti üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP AMPZ' comp, N'1.12.123' hesab, N'İnvəstisiya mülkiyyəti ilə bağlı məsrəflərin kapitallaşdırılması' ad union all
select N'STP AMPZ' comp, N'1.13' hesab, N'Bioloji aktivəər' ad union all
select N'STP AMPZ' comp, N'1.13.131' hesab, N'Bioloji aktivəərin dəyəri' ad union all
select N'STP AMPZ' comp, N'1.13.132' hesab, N'Bioloji aktivəər üzrə yığılmış amortizasiya və qiymətdəndüşmə zərərləri' ad union all
select N'STP AMPZ' comp, N'1.14' hesab, N'Təbii sərvətlər' ad union all
select N'STP AMPZ' comp, N'1.14.141' hesab, N'Təbii sərvətlərin (ehtiyatların) dəyəri' ad union all
select N'STP AMPZ' comp, N'1.14.142' hesab, N'Təbii sərvətlərin (ehtiyatların) tükənməsi' ad union all
select N'STP AMPZ' comp, N'1.15' hesab, N'İştirak payı metodu ilə uçota alınmış invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.15.151' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.15.151.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.15.151.01.01' hesab, N'Asılı müəssisələrə invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.15.152' hesab, N'Birgə müəssisələrə invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.15.153' hesab, N'Asılı və birgə müəssisələrə invəstisiyaların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'1.16' hesab, N'Təxirə salınmış vərgi aktivəəri' ad union all
select N'STP AMPZ' comp, N'1.16.161' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi aktivəəri' ad union all
select N'STP AMPZ' comp, N'1.16.162' hesab, N'Digər təxirə salınmış vərgi aktivəəri' ad union all
select N'STP AMPZ' comp, N'1.17' hesab, N'Uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.171' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.171.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.171.01.01' hesab, N'Alıcıların və sifarişçilərin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.172' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.172.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.172.01.01' hesab, N'Törəmə (asılı) müəssisələrin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.173' hesab, N'əsas idarəetmə heyətinin uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.174' hesab, N'İcarə üzrə uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.175' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.176' hesab, N'Faizlər üzrə uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.17.177' hesab, N'Digər uzunmüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'1.18' hesab, N'Sair uzunmüddətli maliyyə aktivəəri' ad union all
select N'STP AMPZ' comp, N'1.18.181' hesab, N'Ödənişə qədər saxlanılan uzunmüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.18.182' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'1.18.182.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'1.18.182.01.01' hesab, N'vərilmiş uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'1.18.183' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.18.183.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.18.183.01.01' hesab, N'Digər uzunmüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'1.18.184' hesab, N'Sair uzunmüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'1.19' hesab, N'Sair uzunmüddətli aktivəər' ad union all
select N'STP AMPZ' comp, N'1.19.191' hesab, N'Gələcək hesabat dövələrinin xərcləri' ad union all
select N'STP AMPZ' comp, N'1.19.191.01' hesab, N'Gələcək hesabat dövələrinin xərcləri' ad union all
select N'STP AMPZ' comp, N'1.19.191.01.01' hesab, N'GƏLƏCƏK DÖNƏM XƏRCLƏRİNİN İZLƏNİLMƏSİ HESABI' ad union all
select N'STP AMPZ' comp, N'1.19.192' hesab, N'vərilmiş uzunmüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'1.19.193' hesab, N'Digər uzunmüddətli aktivəər' ad union all
select N'STP AMPZ' comp, N'2' hesab, N'QISAMÜDDəTLİ aktivəər' ad union all
select N'STP AMPZ' comp, N'2.20' hesab, N'Ehtiyatlar' ad union all
select N'STP AMPZ' comp, N'2.20.201' hesab, N'Material ehtiyatları' ad union all
select N'STP AMPZ' comp, N'2.20.201.01' hesab, N'Material ehtiyatları' ad union all
select N'STP AMPZ' comp, N'2.20.201.01.01' hesab, N'Xammallar' ad union all
select N'STP AMPZ' comp, N'2.20.201.01.02' hesab, N'Yarimfabrikatlar' ad union all
select N'STP AMPZ' comp, N'2.20.201.01.03' hesab, N'Tekraremal və tullantilar' ad union all
select N'STP AMPZ' comp, N'2.20.201.02' hesab, N'Yolda olan xammallar' ad union all
select N'STP AMPZ' comp, N'2.20.201.02.01' hesab, N'Yolda olan xammallar' ad union all
select N'STP AMPZ' comp, N'2.20.202' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP AMPZ' comp, N'2.20.202.01' hesab, N'İstehsalat (iş və xidmət) məsrəfləri' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.01' hesab, N'Xammal və Material Serfiyyatları' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.02' hesab, N'İşçilik xərcləri' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.03' hesab, N'Kommunal Xərclər' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.04' hesab, N'Amortizasiya Xərcləri' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.05' hesab, N'Təmir Xərcləri' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.06' hesab, N'Qeyri Konvəyer Bitmemis Istehsalat' ad union all
select N'STP AMPZ' comp, N'2.20.202.01.99' hesab, N'Digər Xercler' ad union all
select N'STP AMPZ' comp, N'2.20.202.99' hesab, N'Yansıtma Hesabları' ad union all
select N'STP AMPZ' comp, N'2.20.202.99.01' hesab, N'Yansıtma Hesabları (Istehsalat)' ad union all
select N'STP AMPZ' comp, N'2.20.202.99.02' hesab, N'Yansıtma Hesabları (Malzeme vərman)' ad union all
select N'STP AMPZ' comp, N'2.20.203' hesab, N'Tikinti müqavələləri üzrə məsrəflər' ad union all
select N'STP AMPZ' comp, N'2.20.204' hesab, N'Hazır məhsul' ad union all
select N'STP AMPZ' comp, N'2.20.204.01' hesab, N'Hazır məhsul' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.01' hesab, N'KZ üzrə hazır məhsulları' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.03' hesab, N'Texniki Qazlar Zavədu Hazir Mehsullari' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.04' hesab, N'Polimer Məmulatları Zavədu' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.05' hesab, N'Metaləritmə Zavədu' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.06' hesab, N'Alüminium və Mis Profillər Zavədu HM' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.07' hesab, N'Elektrik Avədanlıqları Hazır Məhsulları' ad union all
select N'STP AMPZ' comp, N'2.20.204.01.08' hesab, N'Qeyri Konvəyer Hazırməhsulları' ad union all
select N'STP AMPZ' comp, N'2.20.205' hesab, N'Mallar' ad union all
select N'STP AMPZ' comp, N'2.20.205.01' hesab, N'Ticari Mallar' ad union all
select N'STP AMPZ' comp, N'2.20.205.01.01' hesab, N'Ticari Mallar' ad union all
select N'STP AMPZ' comp, N'2.20.205.02' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP AMPZ' comp, N'2.20.205.02.01' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP AMPZ' comp, N'2.20.206' hesab, N'Satış məqsədi ilə saxlanılan Digər aktivəər' ad union all
select N'STP AMPZ' comp, N'2.20.207' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AMPZ' comp, N'2.20.207.01' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AMPZ' comp, N'2.20.207.01.01' hesab, N'Azqiymətli tezköhnələn materiallar' ad union all
select N'STP AMPZ' comp, N'2.20.207.01.02' hesab, N'Təsərrüfat malları' ad union all
select N'STP AMPZ' comp, N'2.20.207.02' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP AMPZ' comp, N'2.20.207.02.01' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP AMPZ' comp, N'2.20.208' hesab, N'Ehtiyatların dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'2.20.208.99' hesab, N'Isyerleri arasi anbar transferleri' ad union all
select N'STP AMPZ' comp, N'2.21' hesab, N'Qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.211' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.211.01' hesab, N'Alıcıların və sifarişçilərin qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.211.01.01' hesab, N'Korporativəmüştərilər üzrə debitor borc' ad union all
select N'STP AMPZ' comp, N'2.21.211.01.02' hesab, N'Fiziki şəxslər üzrə debitor borc' ad union all
select N'STP AMPZ' comp, N'2.21.211.01.03' hesab, N'Export müştərilər üzrə debitor borc' ad union all
select N'STP AMPZ' comp, N'2.21.212' hesab, N'Törəmə (asılı) müəssisələrin qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.213' hesab, N'əsas idarəetmə heyətinin qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.214' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.214.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.214.01.01' hesab, N'İcarə üzrə qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.215' hesab, N'Tikinti müqavələləri üzrə qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.216' hesab, N'Faizlər üzrə qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.217' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.217.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.217.01.01' hesab, N'Digər qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.217.01.02' hesab, N'vərgi üzrə Digər qısamüddətli debitor borcları' ad union all
select N'STP AMPZ' comp, N'2.21.218' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'2.21.218.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'2.21.218.01.01' hesab, N'Şübhəli borclar üzrə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'2.22' hesab, N'Pul vəsaitləri və onların ekvəvəlentləri' ad union all
select N'STP AMPZ' comp, N'2.22.221' hesab, N'Kassa' ad union all
select N'STP AMPZ' comp, N'2.22.221.01' hesab, N'Kassa' ad union all
select N'STP AMPZ' comp, N'2.22.221.01.01' hesab, N'Kassa' ad union all
select N'STP AMPZ' comp, N'2.22.222' hesab, N'Yolda olan pul köçürmələri' ad union all
select N'STP AMPZ' comp, N'2.22.222.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP AMPZ' comp, N'2.22.222.01.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP AMPZ' comp, N'2.22.223' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP AMPZ' comp, N'2.22.223.01' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP AMPZ' comp, N'2.22.223.01.01' hesab, N'Bank hesablaşma hesabları (AZN)' ad union all
select N'STP AMPZ' comp, N'2.22.223.01.02' hesab, N'Bank hesablaşma hesabları (USD)' ad union all
select N'STP AMPZ' comp, N'2.22.223.01.03' hesab, N'Bank hesablaşma hesabları (EUR)' ad union all
select N'STP AMPZ' comp, N'2.22.223.01.04' hesab, N'Bank hesablaşma hesabları (RUR)' ad union all
select N'STP AMPZ' comp, N'2.22.223.01.05' hesab, N'Bank hesablaşma hesabları (GBP)' ad union all
select N'STP AMPZ' comp, N'2.22.224' hesab, N'Tələblərə əsasən açılan Digər bank hesabları' ad union all
select N'STP AMPZ' comp, N'2.22.225' hesab, N'Pul vəsaitlərinin ekvəvəlentləri' ad union all
select N'STP AMPZ' comp, N'2.22.226' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP AMPZ' comp, N'2.22.226.01' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP AMPZ' comp, N'2.22.226.01.01' hesab, N'əDvəsub-uçot hesabı' ad union all
select N'STP AMPZ' comp, N'2.23' hesab, N'Sair qısamüddətli maliyyə aktivəəri' ad union all
select N'STP AMPZ' comp, N'2.23.231' hesab, N'Satış məqsədi ilə saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'2.23.232' hesab, N'Ödənişə qədər saxlanılan qısamüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'2.23.233' hesab, N'vərilmiş qısamüddətli borclar' ad union all
select N'STP AMPZ' comp, N'2.23.234' hesab, N'Digər qısamüddətli invəstisiyalar' ad union all
select N'STP AMPZ' comp, N'2.23.235' hesab, N'Sair qısamüddətli maliyyə aktivəərinin dəyərinin azalmasına görə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'2.24' hesab, N'Sair qısamüddətli aktivəər' ad union all
select N'STP AMPZ' comp, N'2.24.241' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP AMPZ' comp, N'2.24.241.01' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP AMPZ' comp, N'2.24.241.01.01' hesab, N'əvəzləşdirilən vərgilər' ad union all
select N'STP AMPZ' comp, N'2.24.242' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP AMPZ' comp, N'2.24.242.01' hesab, N'Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP AMPZ' comp, N'2.24.242.01.01' hesab, N'İdxalat xərcləri' ad union all
select N'STP AMPZ' comp, N'2.24.242.01.02' hesab, N'Digər Gələcək hesabat dövəünün xərcləri' ad union all
select N'STP AMPZ' comp, N'2.24.243' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'2.24.243.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'2.24.243.01.01' hesab, N'vərilmiş qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'2.24.244' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP AMPZ' comp, N'2.24.244.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP AMPZ' comp, N'2.24.244.01.01' hesab, N'Təhtəlhesab məbləğlər' ad union all
select N'STP AMPZ' comp, N'2.24.245' hesab, N'Digər qısamüddətli aktivəər' ad union all
select N'STP AMPZ' comp, N'2.24.245.01' hesab, N'Digər Q/M aktivəər' ad union all
select N'STP AMPZ' comp, N'2.24.245.01.01' hesab, N'ŞHvəin AZN uçotu' ad union all
select N'STP AMPZ' comp, N'2.24.245.01.02' hesab, N'HEDG üçün bağlanma-açılma hesabı' ad union all
select N'STP AMPZ' comp, N'2.24.245.01.03' hesab, N'Akkreditivəüçün bağlanma-açılma hesabı' ad union all
select N'STP AMPZ' comp, N'2.24.245.12' hesab, N'Şəxsi hesab uçotu' ad union all
select N'STP AMPZ' comp, N'3' hesab, N'KAPİTAL' ad union all
select N'STP AMPZ' comp, N'3.30' hesab, N'Ödənilmiş nizamnamə (nominal) kapital' ad union all
select N'STP AMPZ' comp, N'3.30.301' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP AMPZ' comp, N'3.30.301.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP AMPZ' comp, N'3.30.301.01.01' hesab, N'Nizamnamə (nominal) kapitalı' ad union all
select N'STP AMPZ' comp, N'3.30.302' hesab, N'Nizamnamə (nominal) kapitalın ödənilməmiş hissəsi' ad union all
select N'STP AMPZ' comp, N'3.31' hesab, N'Emissiya gəliri' ad union all
select N'STP AMPZ' comp, N'3.31.311' hesab, N'Emissiya gəliri' ad union all
select N'STP AMPZ' comp, N'3.32' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP AMPZ' comp, N'3.32.321' hesab, N'Geri alınmış kapital (səhmlər)' ad union all
select N'STP AMPZ' comp, N'3.33' hesab, N'Kapital ehtiyatları' ad union all
select N'STP AMPZ' comp, N'3.33.331' hesab, N'Yenidən qiymətləndirilmə üzrə ehtiyat' ad union all
select N'STP AMPZ' comp, N'3.33.332' hesab, N'Məzənnə fərgləri üzrə ehtiyat' ad union all
select N'STP AMPZ' comp, N'3.33.333' hesab, N'Qanunvəricilik üzrə ehtiyat' ad union all
select N'STP AMPZ' comp, N'3.33.334' hesab, N'Nizamnamə üzrə ehtiyat' ad union all
select N'STP AMPZ' comp, N'3.33.335' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AMPZ' comp, N'3.34' hesab, N'Bölüşdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP AMPZ' comp, N'3.34.341' hesab, N'Hesabat dövəündə xalis mənfəət (zərər)' ad union all
select N'STP AMPZ' comp, N'3.34.342' hesab, N'Mühasibat uçotu siyasətində dəyişikliklərlə bağlı mənfəət (zərər) üzrə düzəlişlər' ad union all
select N'STP AMPZ' comp, N'3.34.343' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP AMPZ' comp, N'3.34.343.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP AMPZ' comp, N'3.34.343.01.01' hesab, N'Keçmiş illər üzrə bölühdürülməmiş mənfəət (ödənilməmiş zərər)' ad union all
select N'STP AMPZ' comp, N'3.34.344' hesab, N'Elan edilmiş divədentlər' ad union all
select N'STP AMPZ' comp, N'4' hesab, N'UZUNMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP AMPZ' comp, N'4.40' hesab, N'Uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.40.401' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'4.40.401.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'4.40.401.01.01' hesab, N'Uzunmüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'4.40.402' hesab, N'İşçilər üçün uzunmüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'4.40.403' hesab, N'Uzunmüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP AMPZ' comp, N'4.40.404' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'4.40.404.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'4.40.404.01.01' hesab, N'Uzunmüddətli borclar' ad union all
select N'STP AMPZ' comp, N'4.40.405' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(uzunmüddətli)' ad union all
select N'STP AMPZ' comp, N'4.40.406' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.40.406.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.40.406.01.01' hesab, N'Maliyyə icarəsi üzrə uzunmüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.40.407' hesab, N'Törəmə(asılı) müəssisələrə uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.40.408' hesab, N'Digər uzunmüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.41' hesab, N'Uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.41.411' hesab, N'İşdən azad olma ilə bağlı uzunmüddətli müavənətlər və öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.41.412' hesab, N'Uzunmüddətli zəmanət öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'4.41.413' hesab, N'Uzunmüddətli hüquqi öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.41.414' hesab, N'Digər uzunmüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.42' hesab, N'Təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'4.42.421' hesab, N'Mənfəət vərgisi üzrə təxirə salınmış vərgi öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'4.42.422' hesab, N'Digər təxirə salınmış vərgi öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.43' hesab, N'Uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.43.431' hesab, N'Malsatan və podratçılara uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.43.432' hesab, N'Törəmə(asılı) cəmiyyətlərə uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.43.433' hesab, N'Tikinti müqavələləri üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.43.434' hesab, N'Faizlər üzrə uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.43.435' hesab, N'Digər uzunmüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'4.44' hesab, N'Sair uzunmüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'4.44.441' hesab, N'Uzunmüddətli pensiya öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'4.44.442' hesab, N'Gələcək hesabat dövələrinin gəlirləri' ad union all
select N'STP AMPZ' comp, N'4.44.443' hesab, N'Alınmış uzunmüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'4.44.444' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP AMPZ' comp, N'4.44.444.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP AMPZ' comp, N'4.44.444.01.01' hesab, N'Uzunmüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP AMPZ' comp, N'4.44.445' hesab, N'Digər uzunmüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5' hesab, N'QISAMÜDDəTLİ ÖHDəLİKLəR' ad union all
select N'STP AMPZ' comp, N'5.50' hesab, N'Qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.50.501' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'5.50.501.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'5.50.501.01.01' hesab, N'Qısamüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'5.50.501.01.02' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.50.502' hesab, N'İşçilər üçün qısamüddətli bank kreditləri' ad union all
select N'STP AMPZ' comp, N'5.50.503' hesab, N'Qısamüddətli konvərtasiya olunan istiqrazlar' ad union all
select N'STP AMPZ' comp, N'5.50.504' hesab, N'Qısamüddətli borclar' ad union all
select N'STP AMPZ' comp, N'5.50.505' hesab, N'Geri alınan məhdud tədavəl müddətli imtiyazlı səhmlər(qısamüddətli)' ad union all
select N'STP AMPZ' comp, N'5.50.506' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.50.507' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.50.507.01' hesab, N'Digər qısamüddətli faiz xərcləri yaradan öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.50.507.01.01' hesab, N'Uzunmuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP AMPZ' comp, N'5.50.507.01.02' hesab, N'Qisamuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP AMPZ' comp, N'5.51' hesab, N'Qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.51.511' hesab, N'İşdən azad olma ilə bağlı qısamüddətli müavənətlər və öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.51.512' hesab, N'Qısamüddətli zəmanət öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'5.51.513' hesab, N'Qısamüddətli hüquqi öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.51.514' hesab, N'Mənfəətdə iştirak planı və müavənət planları' ad union all
select N'STP AMPZ' comp, N'5.51.515' hesab, N'Digər qısamüddətli qiymətləndirilmiş öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52' hesab, N'vərgi və sair məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.521' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'5.52.521.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'5.52.521.01.01' hesab, N'vərgi öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'5.52.521.02' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP AMPZ' comp, N'5.52.521.02.01' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP AMPZ' comp, N'5.52.522' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.522.01' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.522.01.01' hesab, N'Sosial sığorta və təminat üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.523' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.523.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.52.523.01.01' hesab, N'Digər məcburi ödənişlər üzrə öhdəliklər (Həmkarlar)' ad union all
select N'STP AMPZ' comp, N'5.53' hesab, N'Qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.531' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.531.01' hesab, N'Malsatan və podratçılara qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.531.01.01' hesab, N'Yerli Kreditor borclar' ad union all
select N'STP AMPZ' comp, N'5.53.531.01.02' hesab, N'Xarici Kreditor borclar' ad union all
select N'STP AMPZ' comp, N'5.53.532' hesab, N'Törəmə(asılı) müəssisələrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.533' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP AMPZ' comp, N'5.53.533.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP AMPZ' comp, N'5.53.533.01.01' hesab, N'əməyin ödənişi üzrə işçi heyətinə olan borclar' ad union all
select N'STP AMPZ' comp, N'5.53.533.01.02' hesab, N'Əmək məzuniyyət üzrə işçi heyətinə olan borclar' ad union all
select N'STP AMPZ' comp, N'5.53.534' hesab, N'Divədendlərin ödənilməsi üzrə təsisçilərə kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.535' hesab, N'İcarə üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.536' hesab, N'Tikinti müqavələləri üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.537' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.537.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.537.01.01' hesab, N'Faizlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.538' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.538.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.538.01.01' hesab, N'Digər qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.53.538.01.03' hesab, N'İcbari ödənişlər üzrə qısamüddətli kreditor borcları' ad union all
select N'STP AMPZ' comp, N'5.54' hesab, N'Sair qısamüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'5.54.541' hesab, N'Qısamüddətli pensiya öhdəlikləri' ad union all
select N'STP AMPZ' comp, N'5.54.542' hesab, N'Gələcək hesabat dövəünün gəlirləri' ad union all
select N'STP AMPZ' comp, N'5.54.543' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'5.54.543.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'5.54.543.01.01' hesab, N'Alınmış qısamüddətli avənslar' ad union all
select N'STP AMPZ' comp, N'5.54.544' hesab, N'Qisamüddətli məqsədli maliyyələşmələr və daxilolmalar' ad union all
select N'STP AMPZ' comp, N'5.54.545' hesab, N'Digər qısamüddətli öhdəliklər' ad union all
select N'STP AMPZ' comp, N'6' hesab, N'GəLİRLəR' ad union all
select N'STP AMPZ' comp, N'6.60' hesab, N'əsas əməliyyat gəliri' ad union all
select N'STP AMPZ' comp, N'6.60.601' hesab, N'Satış' ad union all
select N'STP AMPZ' comp, N'6.60.601.01' hesab, N'Hazirmehsulların satışları' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.01' hesab, N'Kabel Hazırməhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.04' hesab, N'Polimer məmulatlarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.05' hesab, N'Metaləritmə Zavədu məhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.06' hesab, N'AMPZ Hazırməhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının satışı' ad union all
select N'STP AMPZ' comp, N'6.60.601.02' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP AMPZ' comp, N'6.60.601.02.01' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP AMPZ' comp, N'6.60.602' hesab, N'Satılmış malların qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01' hesab, N'Hazırməhsullar üzrə qaytarmalar' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.01' hesab, N'Kabel Hazırməhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.04' hesab, N'Polimer məmulatlarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.05' hesab, N'Metaləritmə Zavədu məhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.06' hesab, N'AMPZ Hazırməhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının qaytarılması' ad union all
select N'STP AMPZ' comp, N'6.60.602.02' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP AMPZ' comp, N'6.60.602.02.01' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP AMPZ' comp, N'6.60.603' hesab, N'vərilmiş güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01' hesab, N'Hazırməhsullar üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.01' hesab, N'Kabel Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.02' hesab, N'SPZ hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.04' hesab, N'Polimer məmulatları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.05' hesab, N'Metaləritmə Zavədu məhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.06' hesab, N'AMPZ Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.01.08' hesab, N'Qeyri Konvəyer hazırməhsulları üzrə güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.02' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.60.603.02.01' hesab, N'Digər Mehsullarin güzəştlər' ad union all
select N'STP AMPZ' comp, N'6.61' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.61.611' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.61.611.01' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.61.611.01.01' hesab, N'Məzənnə fərqləri üzrə gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.61.611.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.61.611.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP AMPZ' comp, N'6.61.611.01.04' hesab, N'Anbar sayımlarından yaranan gəlir' ad union all
select N'STP AMPZ' comp, N'6.61.611.01.98' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.62' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.62.621' hesab, N'Fəaliyyətin dayandırılmasından yaranan gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.63' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.63.631' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.63.631.01' hesab, N'Maliyyə gəlirləri' ad union all
select N'STP AMPZ' comp, N'6.63.631.01.01' hesab, N'Hedging üzrə gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.64' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP AMPZ' comp, N'6.64.641' hesab, N'Fövəəladə gəlirlər' ad union all
select N'STP AMPZ' comp, N'7' hesab, N'XəRCLəR' ad union all
select N'STP AMPZ' comp, N'7.70' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP AMPZ' comp, N'7.70.701' hesab, N'Satışın maya dəyəri üzrə xərclər' ad union all
select N'STP AMPZ' comp, N'7.70.701.01' hesab, N'Hazirmehsul satışlarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.01' hesab, N'Kabel Hazırməhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Məhsulları' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.03' hesab, N'Texniki Qazlar Zavədu Hazırməhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.04' hesab, N'Polimer məmulatlarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.05' hesab, N'Metaləritmə Zavədu məhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.06' hesab, N'AMPZ Hazırməhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.07' hesab, N'Elektrik Avədanlıqları Hazırməhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.01.08' hesab, N'Qeyri Konvəyer hazırməhsullarının maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.02' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.70.701.02.01' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP AMPZ' comp, N'7.71' hesab, N'Kommersiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711' hesab, N'Kommersiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.01' hesab, N'əmək haqqı və işçilik xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.01.01' hesab, N'İşçilik xərclər' ad union all
select N'STP AMPZ' comp, N'7.71.711.01.02' hesab, N'İR Xərcləri (təlim, tədbir, axtarış)' ad union all
select N'STP AMPZ' comp, N'7.71.711.01.03' hesab, N'Ezamiyyə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.01.04' hesab, N'Emek haqqi xercleri inzibati' ad union all
select N'STP AMPZ' comp, N'7.71.711.02' hesab, N'Marketinq Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.02.01' hesab, N'Reklam Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.02.02' hesab, N'Araşdırma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.02.03' hesab, N'Digər marketinq xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.03' hesab, N'əsas vəsaitlərin Amortizasiya Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.03.03' hesab, N'Nəqliyyat vəsitələriın amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.03.04' hesab, N'Digər Avədanlıqların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.04.01' hesab, N'Proqram təminatları üzrə amortizasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.05' hesab, N'əsas vəsaitlərin Təmir Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.05.01' hesab, N'Bina Tikili və Qurğuların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.05.02' hesab, N'Maşın və Avədanlıqların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.05.03' hesab, N'Nəqliyyat vəsitələriın təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.05.04' hesab, N'Digər Avədanlıqların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.06' hesab, N'Logostika xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.06.01' hesab, N'Yükdaşıma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.06.02' hesab, N'Sərnişindaşıma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.06.03' hesab, N'Yanacaq xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.06.99' hesab, N'Digər logistika xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.07' hesab, N'Sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.07.01' hesab, N'Məhsullar üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.07.02' hesab, N'Nəqliyyat vəsitələri üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.07.03' hesab, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99' hesab, N'Digər Xərclər' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.01' hesab, N'İcarə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.02' hesab, N'IT xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.03' hesab, N'Kommunal xərclər' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.04' hesab, N'Profisonal xidmətlər xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.05' hesab, N'Bank xidmətləri xərci' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.06' hesab, N'vərgi Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.07' hesab, N'əməyin mühafizəsi və tibbi xərclər' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.08' hesab, N'Sığorta xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.09' hesab, N'Təsərrüfat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.11' hesab, N'Xarab Mal xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.23' hesab, N'Satis xercleri' ad union all
select N'STP AMPZ' comp, N'7.71.711.99.99' hesab, N'Sair Xərclər' ad union all
select N'STP AMPZ' comp, N'7.72' hesab, N'İnzibati xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721' hesab, N'İnzibati xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.01' hesab, N'əmək haqqı və işçilik xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.01.01' hesab, N'İşçilik xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.01.02' hesab, N'İR Xərcləri (təlim, tədbir, axtarış)' ad union all
select N'STP AMPZ' comp, N'7.72.721.01.03' hesab, N'Ezamiyyə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.01.04' hesab, N'Emek haqqi xercleri inzibati' ad union all
select N'STP AMPZ' comp, N'7.72.721.01.05' hesab, N'Emek haqqi xercleri TGZ' ad union all
select N'STP AMPZ' comp, N'7.72.721.02' hesab, N'Marketinq Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.02.01' hesab, N'Reklam Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.02.02' hesab, N'Səhifələrin idarə olunması xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.02.03' hesab, N'Araşdırma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.02.04' hesab, N'Digər marketinq xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.03' hesab, N'əsas vəsaitlərin Amortizasiya Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.03.03' hesab, N'Nəqliyyat vəsitələriın amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.03.04' hesab, N'Digər Avədanlıqların amortizasiya xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.04.01' hesab, N'Proqram təminatları üzrə amortizasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.05' hesab, N'əsas vəsaitlərin Təmir Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.05.01' hesab, N'Bina Tikili və Qurğuların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.05.02' hesab, N'Maşın və Avədanlıqların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.05.03' hesab, N'Nəqliyyat vəsitələriın təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.05.04' hesab, N'Digər Avədanlıqların təmir xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.06' hesab, N'Logostika xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.06.01' hesab, N'Yükdaşıma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.06.02' hesab, N'Sərnişindaşıma xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.06.03' hesab, N'Yanacaq xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.06.99' hesab, N'Digər logistika xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.07' hesab, N'Sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.07.01' hesab, N'Məhsullar üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.07.02' hesab, N'Nəqliyyat vəsitələri üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.07.03' hesab, N'Keyfiyyətə nəzarət üzrə sertifikasiya xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.07.04' hesab, N'Avədanliqlar üzrə sertifikasiya xercleri' ad union all
select N'STP AMPZ' comp, N'7.72.721.77' hesab, N'STP Ümumi Xərclər ' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.01' hesab, N'STP İşçi heyyətinin daşınması ' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.02' hesab, N'STP Yeməkxana' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.03' hesab, N'STP Muhafize və tehlukesizlik xidmeti' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.04' hesab, N'STP Enerji dəstək xidməti' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.05' hesab, N'STP SCIP icare haqqi xidməti' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.06' hesab, N'STP Tibbi xidmetler' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.07' hesab, N'STP Setem ' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.08' hesab, N'STP Ovərtime (cars, machinery)' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.09' hesab, N'STP İX Nəqliyyat vəsitəsi' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.10' hesab, N'STP İX Nəqliyyat vəsitəsi (saatlıq)' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.11' hesab, N'STP Abunə haqqı - Texniki xidmət' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.12' hesab, N'STP Digər xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.77.13' hesab, N'STP IT xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.78' hesab, N'STP Amorizasiya -Komunal' ad union all
select N'STP AMPZ' comp, N'7.72.721.78.01' hesab, N'STP Qaz təminatı' ad union all
select N'STP AMPZ' comp, N'7.72.721.78.02' hesab, N'STP Su təminatı (texniki su)' ad union all
select N'STP AMPZ' comp, N'7.72.721.78.03' hesab, N'STP Elektrik enerjisi təminatı' ad union all
select N'STP AMPZ' comp, N'7.72.721.78.04' hesab, N'STP Amortizasiya' ad union all
select N'STP AMPZ' comp, N'7.72.721.99' hesab, N'Digər Xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.01' hesab, N'İcare xercleri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.02' hesab, N'IT xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.03' hesab, N'Kommunal xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.04' hesab, N'Profisonal xidmətlər xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.05' hesab, N'Bank xidmətləri xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.06' hesab, N'vərgi Xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.07' hesab, N'əməyin mühafizəsi və tibbi xərclər' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.08' hesab, N'Sığorta xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.09' hesab, N'Təsərrüfat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.10' hesab, N'Nəqliyyat icarəsi xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.11' hesab, N'Xarab Mal xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.13' hesab, N'Mobil Rabitə xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.16' hesab, N'Yemək xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.17' hesab, N'SCIP xerci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.18' hesab, N'Mühafizə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.19' hesab, N'Energetika xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.20' hesab, N'Rezidentlik xərcləri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.21' hesab, N'Gömrükdə boş dayanma xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.22' hesab, N'Ovərtime (mashin texnika) xərci' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.23' hesab, N'Satis xercleri' ad union all
select N'STP AMPZ' comp, N'7.72.721.99.99' hesab, N'Sair Xərclər' ad union all
select N'STP AMPZ' comp, N'7.73' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.73.731' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.73.731.01' hesab, N'Sair əməliyyat xərcləri' ad union all
select N'STP AMPZ' comp, N'7.73.731.01.01' hesab, N'Məzənnə fərqləri üzrə xercler' ad union all
select N'STP AMPZ' comp, N'7.73.731.01.02' hesab, N'Yenidən qiymətləndirilmədən gəlirlər' ad union all
select N'STP AMPZ' comp, N'7.73.731.01.03' hesab, N'əsas vəsaitlərin satışından yaranan gəlir (zərər)' ad union all
select N'STP AMPZ' comp, N'7.73.731.01.04' hesab, N'Anbar sayımlarından yaranan xərc' ad union all
select N'STP AMPZ' comp, N'7.73.731.01.05' hesab, N'Hereket gormeyen invəntar' ad union all
select N'STP AMPZ' comp, N'7.74' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP AMPZ' comp, N'7.74.741' hesab, N'Fəaliyyətin dayandırılmasından yaranan xərclər' ad union all
select N'STP AMPZ' comp, N'7.75' hesab, N'Maliyyə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.75.751' hesab, N'Maliyyə xərcləri' ad union all
select N'STP AMPZ' comp, N'7.75.751.01' hesab, N'Maliyyə / Faiz xərcləri' ad union all
select N'STP AMPZ' comp, N'7.75.751.01.01' hesab, N'Maliyyə / Faiz xərcləri' ad union all
select N'STP AMPZ' comp, N'7.76' hesab, N'Fövəəladə xərclər' ad union all
select N'STP AMPZ' comp, N'7.76.761' hesab, N'Fövəəladə xərclər' ad union all
select N'STP AMPZ' comp, N'8' hesab, N'MəNFəəTLəR (ZəRəRLəR)' ad union all
select N'STP AMPZ' comp, N'8.80' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP AMPZ' comp, N'8.80.801' hesab, N'Ümumi mənfəət (zərər)' ad union all
select N'STP AMPZ' comp, N'8.81' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP AMPZ' comp, N'8.81.811' hesab, N'Asılı və birgə müəssisələrin mənfəətlərində(zərərlərində) pay' ad union all
select N'STP AMPZ' comp, N'9' hesab, N'MəNFəəT vəRGİSİ' ad union all
select N'STP AMPZ' comp, N'9.90' hesab, N'Mənfəət vərgisi' ad union all
select N'STP AMPZ' comp, N'9.90.901' hesab, N'Cari mənfəət vərgisi üzrə xərclər' ad union all
select N'STP AMPZ' comp, N'9.90.902' hesab, N'Təxirə salınmış mənfəət vərgisi üzrə xərclər' ad union all
select N'STP AH' comp, N'1' hesab, N'UZUNMÜDDeTLİ aktivəər' ad union all
select N'STP AH' comp, N'1.10' hesab, N'Qeyri-maddi aktivəər' ad union all
select N'STP AH' comp, N'1.10.101' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP AH' comp, N'1.10.101.01' hesab, N'Qeyri-maddi aktivəərin dəyəri' ad union all
select N'STP AH' comp, N'1.10.101.01.01' hesab, N'Proqram teminatı' ad union all
select N'STP AH' comp, N'1.10.101.01.02' hesab, N'Patentler' ad union all
select N'STP AH' comp, N'1.10.101.01.03' hesab, N'Sertifikat və Lisenziyalar' ad union all
select N'STP AH' comp, N'1.10.102' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.10.102.01' hesab, N'Qeyri-maddi aktivəərin dəyəri üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.10.102.01.01' hesab, N'Proqram teminatı üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.10.102.01.02' hesab, N'Patentler üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.10.102.01.03' hesab, N'Sertifikat və Lisenziyalar üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11' hesab, N'Torpaq, tikili və avədanlıqlar' ad union all
select N'STP AH' comp, N'1.11.111' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP AH' comp, N'1.11.111.01' hesab, N'Torpaq, tikili və avədanlıqların dəyəri' ad union all
select N'STP AH' comp, N'1.11.111.01.01' hesab, N'Bina Tikili və Qurğular' ad union all
select N'STP AH' comp, N'1.11.111.01.02' hesab, N'Maşın və Avədanlıqlar' ad union all
select N'STP AH' comp, N'1.11.111.01.03' hesab, N'Nəqliyyat vəsiteleri' ad union all
select N'STP AH' comp, N'1.11.111.01.04' hesab, N'Digər Avədanlıqlar' ad union all
select N'STP AH' comp, N'1.11.112' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01' hesab, N'Torpaq, tikili və avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01.01' hesab, N'Bina Tikili və Qurğular üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01.02' hesab, N'Maşın və Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01.03' hesab, N'Nəqliyyat vəsiteleri üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01.04' hesab, N'Digər Avədanlıqlar üzrə yığılmış amortizasiya' ad union all
select N'STP AH' comp, N'1.11.112.01.05' hesab, N'Maşın və Avədanlıqlar üzrə yığılmış amortizasiya ISTEHSAL' ad union all
select N'STP AH' comp, N'1.11.113' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı mesreflerin kapitallaşdırılması' ad union all
select N'STP AH' comp, N'1.11.113.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı mesreflerin kapitallaşdırılması' ad union all
select N'STP AH' comp, N'1.11.113.01.01' hesab, N'Torpaq, tikili və avədanlıqlarla bağlı mesreflerin kapitallaşdırılması' ad union all
select N'STP AH' comp, N'1.12' hesab, N'İnvəstisiya mülkiyyəti' ad union all
select N'STP AH' comp, N'1.12.121' hesab, N'İnvəstisiya mülkiyyətinin dəyəri' ad union all
select N'STP AH' comp, N'1.12.122' hesab, N'İnvəstisiya mülkiyyəti üzrə yığılmış amortizasiya və qiymetdendüşme zererleri' ad union all
select N'STP AH' comp, N'1.12.123' hesab, N'İnvəstisiya mülkiyyəti ile bağlı mesreflerin kapitallaşdırılması' ad union all
select N'STP AH' comp, N'1.13' hesab, N'Bioloji aktivəər' ad union all
select N'STP AH' comp, N'1.13.131' hesab, N'Bioloji aktivəərin dəyəri' ad union all
select N'STP AH' comp, N'1.13.132' hesab, N'Bioloji aktivəər üzrə yığılmış amortizasiya və qiymetdendüşme zererleri' ad union all
select N'STP AH' comp, N'1.14' hesab, N'Təbii sərvətlər' ad union all
select N'STP AH' comp, N'1.14.141' hesab, N'Təbii sərvətlərin (ehtiyatların) dəyəri' ad union all
select N'STP AH' comp, N'1.14.142' hesab, N'Təbii sərvətlərin (ehtiyatların) tükenmesi' ad union all
select N'STP AH' comp, N'1.15' hesab, N'İştirak payı metodu ile uçota alınmış invəstisiyalar' ad union all
select N'STP AH' comp, N'1.15.151' hesab, N'Asılı müessiselere invəstisiyalar' ad union all
select N'STP AH' comp, N'1.15.151.01' hesab, N'Asılı müessiselere invəstisiyalar' ad union all
select N'STP AH' comp, N'1.15.151.01.01' hesab, N'Asılı müessiselere invəstisiyalar' ad union all
select N'STP AH' comp, N'1.15.152' hesab, N'Birge müessiselere invəstisiyalar' ad union all
select N'STP AH' comp, N'1.15.153' hesab, N'Asılı və birge müessiselere invəstisiyaların dəyərinin azalmasına göre düzelişler' ad union all
select N'STP AH' comp, N'1.16' hesab, N'Texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.161' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.161.01' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.161.01.01' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.162' hesab, N'Digər texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.162.01' hesab, N'Digər texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.16.162.01.01' hesab, N'Digər texire salınmış vərgi aktivəəri' ad union all
select N'STP AH' comp, N'1.17' hesab, N'Uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.171' hesab, N'Alıcıların və sifarişçilerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.171.01' hesab, N'Alıcıların və sifarişçilerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.171.01.01' hesab, N'Alıcıların və sifarişçilerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.172' hesab, N'Töreme (asılı) müessiselerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.172.01' hesab, N'Töreme (asılı) müessiselerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.172.01.01' hesab, N'Töreme (asılı) müessiselerin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.173' hesab, N'esas idareetme heyetinin uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.174' hesab, N'İcare üzrə uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.175' hesab, N'Tikinti müqavəleleri üzrə uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.176' hesab, N'Faizler üzrə uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.17.177' hesab, N'Digər uzunmüddetli debitor borcları' ad union all
select N'STP AH' comp, N'1.18' hesab, N'Sair uzunmüddetli maliyye aktivəəri' ad union all
select N'STP AH' comp, N'1.18.181' hesab, N'Ödenişe qeder saxlanılan uzunmüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'1.18.182' hesab, N'vərilmiş uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'1.18.182.01' hesab, N'vərilmiş uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'1.18.182.01.01' hesab, N'vərilmiş uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'1.18.183' hesab, N'Digər uzunmüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'1.18.183.01' hesab, N'Digər uzunmüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'1.18.183.01.01' hesab, N'Digər uzunmüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'1.18.184' hesab, N'Sair uzunmüddetli maliyye aktivəərinin dəyərinin azalmasına göre düzelişler' ad union all
select N'STP AH' comp, N'1.19' hesab, N'Sair uzunmüddetli aktivəər' ad union all
select N'STP AH' comp, N'1.19.191' hesab, N'Gelecek hesabat dövəlerinin xercleri' ad union all
select N'STP AH' comp, N'1.19.192' hesab, N'vərilmiş uzunmüddetli avənslar' ad union all
select N'STP AH' comp, N'1.19.193' hesab, N'Digər uzunmüddetli aktivəər' ad union all
select N'STP AH' comp, N'2' hesab, N'QISAMÜDDeTLİ aktivəər' ad union all
select N'STP AH' comp, N'2.20' hesab, N'Ehtiyatlar' ad union all
select N'STP AH' comp, N'2.20.201' hesab, N'Material ehtiyatları' ad union all
select N'STP AH' comp, N'2.20.201.01' hesab, N'Material ehtiyatları' ad union all
select N'STP AH' comp, N'2.20.201.01.01' hesab, N'Xammallar' ad union all
select N'STP AH' comp, N'2.20.201.01.02' hesab, N'Yarimfabrikatlar' ad union all
select N'STP AH' comp, N'2.20.201.01.03' hesab, N'Tekraremal və tullantilar' ad union all
select N'STP AH' comp, N'2.20.201.02' hesab, N'Yolda olan xammallar' ad union all
select N'STP AH' comp, N'2.20.201.02.01' hesab, N'Yolda olan xammallar' ad union all
select N'STP AH' comp, N'2.20.202' hesab, N'İstehsalat (iş və xidmet) mesrefleri' ad union all
select N'STP AH' comp, N'2.20.202.01' hesab, N'İstehsalat (iş və xidmet) mesrefleri' ad union all
select N'STP AH' comp, N'2.20.202.01.01' hesab, N'Xammal və Material Serfiyyatları' ad union all
select N'STP AH' comp, N'2.20.202.01.02' hesab, N'İşçilik xercleri' ad union all
select N'STP AH' comp, N'2.20.202.01.03' hesab, N'Kommunal Xercler' ad union all
select N'STP AH' comp, N'2.20.202.01.04' hesab, N'Amortizasiya Xercleri' ad union all
select N'STP AH' comp, N'2.20.202.01.05' hesab, N'Temir Xercleri' ad union all
select N'STP AH' comp, N'2.20.202.01.06' hesab, N'Qeyri Konvəyer Bitmemis Istehsalat' ad union all
select N'STP AH' comp, N'2.20.202.01.95' hesab, N'yemekxana xercleri' ad union all
select N'STP AH' comp, N'2.20.202.01.99' hesab, N'Yanacaq' ad union all
select N'STP AH' comp, N'2.20.202.99' hesab, N'Yansıtma Hesabları' ad union all
select N'STP AH' comp, N'2.20.202.99.01' hesab, N'Yansıtma Hesabları (Istehsalat)' ad union all
select N'STP AH' comp, N'2.20.202.99.02' hesab, N'Yansıtma Hesabları (Malzeme vərman)' ad union all
select N'STP AH' comp, N'2.20.202.99.03' hesab, N'Yansıtma Hesabları (Birbasa)' ad union all
select N'STP AH' comp, N'2.20.202.99.04' hesab, N'Yansıtma Hesabları (Dolayi)' ad union all
select N'STP AH' comp, N'2.20.203' hesab, N'Tikinti müqavəleleri üzrə mesrefler' ad union all
select N'STP AH' comp, N'2.20.204' hesab, N'Hazır mehsul' ad union all
select N'STP AH' comp, N'2.20.204.01' hesab, N'Hazır mehsul' ad union all
select N'STP AH' comp, N'2.20.204.01.01' hesab, N'KZ üzrə hazır mehsulları' ad union all
select N'STP AH' comp, N'2.20.204.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Mehsulları' ad union all
select N'STP AH' comp, N'2.20.204.01.03' hesab, N'Texniki Qazlar Zavədu Hazir Mehsullari' ad union all
select N'STP AH' comp, N'2.20.204.01.04' hesab, N'Polimer Memulatları Zavədu' ad union all
select N'STP AH' comp, N'2.20.204.01.05' hesab, N'Metaleritme Zavədu' ad union all
select N'STP AH' comp, N'2.20.204.01.06' hesab, N'Alüminium və Mis Profiller Zavədu HM' ad union all
select N'STP AH' comp, N'2.20.204.01.07' hesab, N'Elektrik Avədanlıqları Hazır Mehsulları' ad union all
select N'STP AH' comp, N'2.20.204.01.08' hesab, N'Qeyri Konvəyer Hazırmehsulları' ad union all
select N'STP AH' comp, N'2.20.205' hesab, N'Mallar' ad union all
select N'STP AH' comp, N'2.20.205.01' hesab, N'Ticari Mallar' ad union all
select N'STP AH' comp, N'2.20.205.01.01' hesab, N'Ticari Mallar' ad union all
select N'STP AH' comp, N'2.20.205.02' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP AH' comp, N'2.20.205.02.01' hesab, N'Yolda olan ticari mallar' ad union all
select N'STP AH' comp, N'2.20.206' hesab, N'Satış meqsedi ile saxlanılan Digər aktivəər' ad union all
select N'STP AH' comp, N'2.20.207' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AH' comp, N'2.20.207.01' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AH' comp, N'2.20.207.01.01' hesab, N'Azqiymetli tezköhnelen materiallar' ad union all
select N'STP AH' comp, N'2.20.207.01.02' hesab, N'Teserrüfat malları' ad union all
select N'STP AH' comp, N'2.20.207.01.03' hesab, N'Digər materiallar' ad union all
select N'STP AH' comp, N'2.20.207.02' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP AH' comp, N'2.20.207.02.01' hesab, N'Yolda olan Digər ehtiyyatlar' ad union all
select N'STP AH' comp, N'2.20.208' hesab, N'Ehtiyatların dəyərinin azalmasına göre düzelişler' ad union all
select N'STP AH' comp, N'2.20.208.99' hesab, N'Isyerleri arasi anbar transferleri' ad union all
select N'STP AH' comp, N'2.21' hesab, N'Qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.211' hesab, N'Alıcıların və sifarişçilerin qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.211.01' hesab, N'Alıcıların və sifarişçilerin qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.211.01.01' hesab, N'Korporativəmüşteriler üzrə debitor borc' ad union all
select N'STP AH' comp, N'2.21.211.01.02' hesab, N'Fiziki şexsler üzrə debitor borc' ad union all
select N'STP AH' comp, N'2.21.211.01.03' hesab, N'Export müşteriler üzrə debitor borc' ad union all
select N'STP AH' comp, N'2.21.212' hesab, N'Töreme (asılı) müessiselerin qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.213' hesab, N'esas idareetme heyetinin qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.214' hesab, N'İcare üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.214.01' hesab, N'İcare üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.214.01.01' hesab, N'İcare üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.215' hesab, N'Tikinti müqavəleleri üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.216' hesab, N'Faizler üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.216.01' hesab, N'Faizler üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.216.01.01' hesab, N'Faizler üzrə qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.217' hesab, N'Digər qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.217.01' hesab, N'Digər qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.217.01.01' hesab, N'Digər qısamüddetli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.217.01.02' hesab, N'vərgi üzrə Digər qısamüddətli debitor borcları' ad union all
select N'STP AH' comp, N'2.21.218' hesab, N'Şübheli borclar üzrə düzelişler' ad union all
select N'STP AH' comp, N'2.21.218.01' hesab, N'Şübheli borclar üzrə düzelişler' ad union all
select N'STP AH' comp, N'2.21.218.01.01' hesab, N'Şübheli borclar üzrə düzelişler' ad union all
select N'STP AH' comp, N'2.22' hesab, N'Pul vəsaitleri və onların ekvəvəlentleri' ad union all
select N'STP AH' comp, N'2.22.221' hesab, N'Kassa' ad union all
select N'STP AH' comp, N'2.22.221.01' hesab, N'Kassa' ad union all
select N'STP AH' comp, N'2.22.221.01.01' hesab, N'Kassa' ad union all
select N'STP AH' comp, N'2.22.222' hesab, N'Yolda olan pul köçürmeleri' ad union all
select N'STP AH' comp, N'2.22.222.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP AH' comp, N'2.22.222.01.01' hesab, N'Yolda olan pul kocurmeleri' ad union all
select N'STP AH' comp, N'2.22.223' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP AH' comp, N'2.22.223.01' hesab, N'Bank hesablaşma hesabları' ad union all
select N'STP AH' comp, N'2.22.223.01.01' hesab, N'Bank hesablaşma hesabları (AZN)' ad union all
select N'STP AH' comp, N'2.22.223.01.02' hesab, N'Bank hesablaşma hesabları (USD)' ad union all
select N'STP AH' comp, N'2.22.223.01.03' hesab, N'Bank hesablaşma hesabları (EUR)' ad union all
select N'STP AH' comp, N'2.22.223.01.04' hesab, N'Bank hesablaşma hesabları (RUR)' ad union all
select N'STP AH' comp, N'2.22.223.01.05' hesab, N'Bank hesablaşma hesabları (GBP)' ad union all
select N'STP AH' comp, N'2.22.224' hesab, N'Teleblere esasen açılan Digər bank hesabları' ad union all
select N'STP AH' comp, N'2.22.225' hesab, N'Pul vəsaitlerinin ekvəvəlentleri' ad union all
select N'STP AH' comp, N'2.22.226' hesab, N'eDvəsub-uçot hesabı' ad union all
select N'STP AH' comp, N'2.22.226.01' hesab, N'eDvəsub-uçot hesabı' ad union all
select N'STP AH' comp, N'2.22.226.01.01' hesab, N'eDvəsub-uçot hesabı' ad union all
select N'STP AH' comp, N'2.23' hesab, N'Sair qısamüddetli maliyye aktivəəri' ad union all
select N'STP AH' comp, N'2.23.231' hesab, N'Satış meqsedi ile saxlanılan qısamüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'2.23.232' hesab, N'Ödenişe qeder saxlanılan qısamüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'2.23.233' hesab, N'vərilmiş qısamüddetli borclar' ad union all
select N'STP AH' comp, N'2.23.233.01' hesab, N'vərilmiş qısamüddetli borclar' ad union all
select N'STP AH' comp, N'2.23.233.01.01' hesab, N'vərilmiş qısamüddetli borclar' ad union all
select N'STP AH' comp, N'2.23.234' hesab, N'Digər qısamüddetli invəstisiyalar' ad union all
select N'STP AH' comp, N'2.23.235' hesab, N'Sair qısamüddetli maliyye aktivəərinin dəyərinin azalmasına göre düzelişler' ad union all
select N'STP AH' comp, N'2.24' hesab, N'Sair qısamüddetli aktivəər' ad union all
select N'STP AH' comp, N'2.24.241' hesab, N'evəzleşdirilen vərgiler' ad union all
select N'STP AH' comp, N'2.24.241.01' hesab, N'evəzleşdirilen vərgiler' ad union all
select N'STP AH' comp, N'2.24.241.01.01' hesab, N'evəzleşdirilen vərgiler' ad union all
select N'STP AH' comp, N'2.24.242' hesab, N'Gelecek hesabat dövəünün xercleri' ad union all
select N'STP AH' comp, N'2.24.242.01' hesab, N'Gelecek hesabat dövəünün xercleri' ad union all
select N'STP AH' comp, N'2.24.242.01.01' hesab, N'İdxalat xercleri' ad union all
select N'STP AH' comp, N'2.24.242.01.02' hesab, N'Digər Gelecek hesabat dövəünün xercleri' ad union all
select N'STP AH' comp, N'2.24.243' hesab, N'vərilmiş qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'2.24.243.01' hesab, N'vərilmiş qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'2.24.243.01.01' hesab, N'vərilmiş qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'2.24.244' hesab, N'Tehtelhesab mebleğler' ad union all
select N'STP AH' comp, N'2.24.244.01' hesab, N'Tehtelhesab mebleğler' ad union all
select N'STP AH' comp, N'2.24.244.01.01' hesab, N'Tehtelhesab mebleğler' ad union all
select N'STP AH' comp, N'2.24.245' hesab, N'Digər qısamüddetli aktivəər' ad union all
select N'STP AH' comp, N'2.24.245.01' hesab, N'Digər qısamüddetli aktivəər' ad union all
select N'STP AH' comp, N'2.24.245.01.01' hesab, N'Digər qısamüddetli aktivəər' ad union all
select N'STP AH' comp, N'2.24.245.01.02' hesab, N'Sexsi hesab vəreqesi' ad union all
select N'STP AH' comp, N'3' hesab, N'KAPİTAL' ad union all
select N'STP AH' comp, N'3.30' hesab, N'Ödenilmiş nizamname (nominal) kapital' ad union all
select N'STP AH' comp, N'3.30.301' hesab, N'Nizamname (nominal) kapitalı' ad union all
select N'STP AH' comp, N'3.30.301.01' hesab, N'Nizamname (nominal) kapitalı' ad union all
select N'STP AH' comp, N'3.30.301.01.01' hesab, N'Nizamname (nominal) kapitalı' ad union all
select N'STP AH' comp, N'3.30.302' hesab, N'Nizamname (nominal) kapitalın ödenilmemiş hissesi' ad union all
select N'STP AH' comp, N'3.31' hesab, N'Emissiya geliri' ad union all
select N'STP AH' comp, N'3.31.311' hesab, N'Emissiya geliri' ad union all
select N'STP AH' comp, N'3.32' hesab, N'Geri alınmış kapital (sehmler)' ad union all
select N'STP AH' comp, N'3.32.321' hesab, N'Geri alınmış kapital (sehmler)' ad union all
select N'STP AH' comp, N'3.33' hesab, N'Kapital ehtiyatları' ad union all
select N'STP AH' comp, N'3.33.331' hesab, N'Yeniden qiymetlendirilme üzrə ehtiyat' ad union all
select N'STP AH' comp, N'3.33.332' hesab, N'Mezenne fergleri üzrə ehtiyat' ad union all
select N'STP AH' comp, N'3.33.333' hesab, N'Qanunvəricilik üzrə ehtiyat' ad union all
select N'STP AH' comp, N'3.33.334' hesab, N'Nizamname üzrə ehtiyat' ad union all
select N'STP AH' comp, N'3.33.335' hesab, N'Digər ehtiyatlar' ad union all
select N'STP AH' comp, N'3.34' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.341' hesab, N'Hesabat dövəünde xalis menfeet (zerer)' ad union all
select N'STP AH' comp, N'3.34.341.01' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.341.01.01' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.341.01.86' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer) yansitma' ad union all
select N'STP AH' comp, N'3.34.341.01.86.01' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer) yansitma' ad union all
select N'STP AH' comp, N'3.34.341.88' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer) yansitma' ad union all
select N'STP AH' comp, N'3.34.341.88.01' hesab, N'Bölüşdürülmemiş menfeet (ödenilmemiş zerer) yansitma' ad union all
select N'STP AH' comp, N'3.34.342' hesab, N'Mühasibat uçotu siyasetinde deyişikliklerle bağlı menfeet (zerer) üzrə düzelişler' ad union all
select N'STP AH' comp, N'3.34.342.01' hesab, N'Mühasibat uçotu siyasetinde deyişikliklerle bağlı menfeet (zerer) üzrə düzelişler' ad union all
select N'STP AH' comp, N'3.34.342.01.01' hesab, N'Mühasibat uçotu siyasetinde deyişikliklerle bağlı menfeet (zerer) üzrə düzelişler' ad union all
select N'STP AH' comp, N'3.34.343' hesab, N'Keçmiş iller üzrə bölühdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.343.01' hesab, N'Keçmiş iller üzrə bölühdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.343.01.01' hesab, N'Keçmiş iller üzrə bölühdürülmemiş menfeet (ödenilmemiş zerer)' ad union all
select N'STP AH' comp, N'3.34.344' hesab, N'Elan edilmiş divədentler' ad union all
select N'STP AH' comp, N'3.34.344.01' hesab, N'Elan edilmiş divədentler' ad union all
select N'STP AH' comp, N'3.34.344.01.01' hesab, N'Elan edilmiş divədentler' ad union all
select N'STP AH' comp, N'4' hesab, N'UZUNMÜDDeTLİ ÖHDeLİKLeR' ad union all
select N'STP AH' comp, N'4.40' hesab, N'Uzunmüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'4.40.401' hesab, N'Uzunmüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'4.40.401.01' hesab, N'Uzunmüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'4.40.401.01.01' hesab, N'Uzunmüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'4.40.402' hesab, N'İşçiler üçün uzunmüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'4.40.403' hesab, N'Uzunmüddetli konvərtasiya olunan istiqrazlar' ad union all
select N'STP AH' comp, N'4.40.404' hesab, N'Uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'4.40.404.01' hesab, N'Uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'4.40.404.01.01' hesab, N'Uzunmüddetli borclar' ad union all
select N'STP AH' comp, N'4.40.405' hesab, N'Geri alınan mehdud tedavəl müddetli imtiyazlı sehmler(uzunmüddetli)' ad union all
select N'STP AH' comp, N'4.40.406' hesab, N'Maliyye icaresi üzrə uzunmüddetli öhdelikler' ad union all
select N'STP AH' comp, N'4.40.406.01' hesab, N'Maliyye icaresi üzrə uzunmüddetli öhdelikler' ad union all
select N'STP AH' comp, N'4.40.406.01.01' hesab, N'Maliyye icaresi üzrə uzunmüddetli öhdelikler' ad union all
select N'STP AH' comp, N'4.40.407' hesab, N'Töreme(asılı) müessiselere uzunmüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'4.40.408' hesab, N'Digər uzunmüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'4.40.408.01' hesab, N'Digər uzunmüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'4.40.408.01.01' hesab, N'Digər uzunmüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'4.41' hesab, N'Uzunmüddetli qiymetlendirilmiş öhdelikler' ad union all
select N'STP AH' comp, N'4.41.411' hesab, N'İşden azad olma ile bağlı uzunmüddetli müavənetler və öhdelikler' ad union all
select N'STP AH' comp, N'4.41.412' hesab, N'Uzunmüddetli zemanet öhdelikleri' ad union all
select N'STP AH' comp, N'4.41.413' hesab, N'Uzunmüddetli hüquqi öhdelikler' ad union all
select N'STP AH' comp, N'4.41.414' hesab, N'Digər uzunmüddetli qiymetlendirilmiş öhdelikler' ad union all
select N'STP AH' comp, N'4.42' hesab, N'Texire salınmış vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'4.42.421' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'4.42.421.01' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'4.42.421.01.01' hesab, N'Menfeet vərgisi üzrə texire salınmış vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'4.42.422' hesab, N'Digər texire salınmış vərgi öhdelikler' ad union all
select N'STP AH' comp, N'4.42.422.01' hesab, N'Digər texire salınmış vərgi öhdelikler' ad union all
select N'STP AH' comp, N'4.42.422.01.01' hesab, N'Digər texire salınmış vərgi öhdelikler' ad union all
select N'STP AH' comp, N'4.43' hesab, N'Uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.43.431' hesab, N'Malsatan və podratçılara uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.43.432' hesab, N'Töreme(asılı) cemiyyetlere uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.43.433' hesab, N'Tikinti müqavəleleri üzrə uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.43.434' hesab, N'Faizler üzrə uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.43.435' hesab, N'Digər uzunmüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'4.44' hesab, N'Sair uzunmüddetli öhdelikler' ad union all
select N'STP AH' comp, N'4.44.441' hesab, N'Uzunmüddetli pensiya öhdelikleri' ad union all
select N'STP AH' comp, N'4.44.442' hesab, N'Gelecek hesabat dövəlerinin gelirleri' ad union all
select N'STP AH' comp, N'4.44.443' hesab, N'Alınmış uzunmüddetli avənslar' ad union all
select N'STP AH' comp, N'4.44.444' hesab, N'Uzunmüddetli meqsedli maliyyeleşmeler və daxilolmalar' ad union all
select N'STP AH' comp, N'4.44.444.01' hesab, N'Uzunmüddetli meqsedli maliyyeleşmeler və daxilolmalar' ad union all
select N'STP AH' comp, N'4.44.444.01.01' hesab, N'Uzunmüddetli meqsedli maliyyeleşmeler və daxilolmalar' ad union all
select N'STP AH' comp, N'4.44.445' hesab, N'Digər uzunmüddetli öhdelikler' ad union all
select N'STP AH' comp, N'5' hesab, N'QISAMÜDDeTLİ ÖHDeLİKLeR' ad union all
select N'STP AH' comp, N'5.50' hesab, N'Qısamüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'5.50.501' hesab, N'Qısamüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'5.50.501.01' hesab, N'Qısamüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'5.50.501.01.01' hesab, N'Qısamüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'5.50.502' hesab, N'İşçiler üçün qısamüddetli bank kreditleri' ad union all
select N'STP AH' comp, N'5.50.503' hesab, N'Qısamüddetli konvərtasiya olunan istiqrazlar' ad union all
select N'STP AH' comp, N'5.50.504' hesab, N'Qısamüddetli borclar' ad union all
select N'STP AH' comp, N'5.50.505' hesab, N'Geri alınan mehdud tedavəl müddetli imtiyazlı sehmler(qısamüddetli)' ad union all
select N'STP AH' comp, N'5.50.506' hesab, N'Töreme(asılı) müessiselere qısamüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'5.50.507' hesab, N'Digər qısamüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'5.50.507.01' hesab, N'Digər qısamüddetli faiz xercleri yaradan öhdelikler' ad union all
select N'STP AH' comp, N'5.50.507.01.01' hesab, N'Uzunmuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP AH' comp, N'5.50.507.01.02' hesab, N'Qisamuddetli kreditlere gore cari faiz ohdelikleri' ad union all
select N'STP AH' comp, N'5.51' hesab, N'Qısamüddetli qiymetlendirilmiş öhdelikler' ad union all
select N'STP AH' comp, N'5.51.511' hesab, N'İşden azad olma ile bağlı qısamüddetli müavənetler və öhdelikler' ad union all
select N'STP AH' comp, N'5.51.512' hesab, N'Qısamüddetli zemanet öhdelikleri' ad union all
select N'STP AH' comp, N'5.51.513' hesab, N'Qısamüddetli hüquqi öhdelikler' ad union all
select N'STP AH' comp, N'5.51.514' hesab, N'Menfeetde iştirak planı və müavənet planları' ad union all
select N'STP AH' comp, N'5.51.515' hesab, N'Digər qısamüddetli qiymetlendirilmiş öhdelikler' ad union all
select N'STP AH' comp, N'5.52' hesab, N'vərgi və sair mecburi ödenişler üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.521' hesab, N'vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'5.52.521.01' hesab, N'vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'5.52.521.01.01' hesab, N'vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'5.52.521.01.02' hesab, N'Menfeet vərgisi uzre vərgi öhdelikleri' ad union all
select N'STP AH' comp, N'5.52.521.01.03' hesab, N'Gəlir vərgisi' ad union all
select N'STP AH' comp, N'5.52.521.01.04' hesab, N'ÖMvəmetal' ad union all
select N'STP AH' comp, N'5.52.521.01.05' hesab, N'ÖMvəDigər' ad union all
select N'STP AH' comp, N'5.52.521.02' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP AH' comp, N'5.52.521.02.01' hesab, N'Satisdan yaranan vərgi ohdeliyi' ad union all
select N'STP AH' comp, N'5.52.522' hesab, N'Sosial sığorta və teminat üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.522.01' hesab, N'Sosial sığorta və teminat üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.522.01.01' hesab, N'Sosial sığorta və teminat üzrə öhdelikler DSMF' ad union all
select N'STP AH' comp, N'5.52.522.01.02' hesab, N'Issizlikden sigorta üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.522.01.03' hesab, N'Icbari tibbi sigorta  üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.523' hesab, N'Digər mecburi ödenişler üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.523.01' hesab, N'Digər mecburi ödenişler üzrə öhdelikler' ad union all
select N'STP AH' comp, N'5.52.523.01.01' hesab, N'Digər mecburi ödenişler üzrə öhdelikler (Həmkarlar)' ad union all
select N'STP AH' comp, N'5.52.526' hesab, N'Digər mecburi formalasan  ohdelikler' ad union all
select N'STP AH' comp, N'5.52.526.01' hesab, N'Digər mecburi formalasan  ohdelikler' ad union all
select N'STP AH' comp, N'5.52.526.01.01' hesab, N'Digər mecburi formalasan  ohdelikler' ad union all
select N'STP AH' comp, N'5.53' hesab, N'Qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.531' hesab, N'Malsatan və podratçılara qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.531.01' hesab, N'Malsatan və podratçılara qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.531.01.01' hesab, N'Yerli Kreditor borclar' ad union all
select N'STP AH' comp, N'5.53.531.01.02' hesab, N'Xarici Kreditor borclar' ad union all
select N'STP AH' comp, N'5.53.532' hesab, N'Töreme(asılı) müessiselere qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.533' hesab, N'emeyin ödenişi üzrə işçi heyetine olan borclar' ad union all
select N'STP AH' comp, N'5.53.533.01' hesab, N'emeyin ödenişi üzrə işçi heyetine olan borclar' ad union all
select N'STP AH' comp, N'5.53.533.01.01' hesab, N'emeyin ödenişi üzrə işçi heyetine olan borclar' ad union all
select N'STP AH' comp, N'5.53.534' hesab, N'Divədendlerin ödenilmesi üzrə tesisçilere kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.534.01' hesab, N'Divədendlerin ödenilmesi üzrə tesisçilere kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.534.01.01' hesab, N'Divədendlerin ödenilmesi üzrə tesisçilere kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.535' hesab, N'İcare üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.536' hesab, N'Tikinti müqavəleleri üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.537' hesab, N'Faizler üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.537.01' hesab, N'Faizler üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.537.01.01' hesab, N'Faizler üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.538' hesab, N'Digər qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.538.01' hesab, N'Digər qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.538.01.01' hesab, N'Digər qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.53.538.01.03' hesab, N'İcbari ödənişlər üzrə qısamüddetli kreditor borcları' ad union all
select N'STP AH' comp, N'5.54' hesab, N'Sair qısamüddetli öhdelikler' ad union all
select N'STP AH' comp, N'5.54.541' hesab, N'Qısamüddetli pensiya öhdelikleri' ad union all
select N'STP AH' comp, N'5.54.542' hesab, N'Gelecek hesabat dövəünün gelirleri' ad union all
select N'STP AH' comp, N'5.54.543' hesab, N'Alınmış qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'5.54.543.01' hesab, N'Alınmış qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'5.54.543.01.01' hesab, N'Alınmış qısamüddetli avənslar' ad union all
select N'STP AH' comp, N'5.54.544' hesab, N'Qisamüddetli meqsedli maliyyeleşmeler və daxilolmalar' ad union all
select N'STP AH' comp, N'5.54.545' hesab, N'Digər qısamüddetli öhdelikler' ad union all
select N'STP AH' comp, N'5.54.545.01' hesab, N'Digər qısamüddetli öhdelikler' ad union all
select N'STP AH' comp, N'5.54.545.01.01' hesab, N'Digər qısamüddetli öhdelikler' ad union all
select N'STP AH' comp, N'6' hesab, N'GeLİRLeR' ad union all
select N'STP AH' comp, N'6.60' hesab, N'esas emeliyyat geliri' ad union all
select N'STP AH' comp, N'6.60.601' hesab, N'Satış' ad union all
select N'STP AH' comp, N'6.60.601.01' hesab, N'Hazirmehsulların satışları' ad union all
select N'STP AH' comp, N'6.60.601.01.01' hesab, N'Kabel Hazırmehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Mehsulları' ad union all
select N'STP AH' comp, N'6.60.601.01.03' hesab, N'Texniki Qazlar Zavədu Hazırmehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.04' hesab, N'Polimer memulatlarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.05' hesab, N'Metaleritme Zavədu mehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.06' hesab, N'AMPZ Hazırmehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.07' hesab, N'Elektrik Avədanlıqları Hazırmehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.01.08' hesab, N'Qeyri Konvəyer hazırmehsullarının satışı' ad union all
select N'STP AH' comp, N'6.60.601.02' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP AH' comp, N'6.60.601.02.01' hesab, N'Digər Mehsullarin Satisi' ad union all
select N'STP AH' comp, N'6.60.601.85' hesab, N'Hazirmehsulların satışları yansitma' ad union all
select N'STP AH' comp, N'6.60.601.85.05' hesab, N'Metaleritme Zavədu mehsullarının satışı yansitma' ad union all
select N'STP AH' comp, N'6.60.601.86' hesab, N'Digər Mehsullarin Satisi yansitma' ad union all
select N'STP AH' comp, N'6.60.601.86.01' hesab, N'Digər Mehsullarin Satisi yansitma' ad union all
select N'STP AH' comp, N'6.60.602' hesab, N'Satılmış malların qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01' hesab, N'Hazırmehsullar üzrə qaytarmalar' ad union all
select N'STP AH' comp, N'6.60.602.01.01' hesab, N'Kabel Hazırmehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Mehsulları' ad union all
select N'STP AH' comp, N'6.60.602.01.03' hesab, N'Texniki Qazlar Zavədu Hazırmehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.04' hesab, N'Polimer memulatlarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.05' hesab, N'Metaleritme Zavədu mehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.06' hesab, N'AMPZ Hazırmehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.07' hesab, N'Elektrik Avədanlıqları Hazırmehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.01.08' hesab, N'Qeyri Konvəyer hazırmehsullarının qaytarılması' ad union all
select N'STP AH' comp, N'6.60.602.02' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP AH' comp, N'6.60.602.02.01' hesab, N'Digər Mehsullarin Geriqaytarmasi' ad union all
select N'STP AH' comp, N'6.60.602.87' hesab, N'Hazırmehsullar üzrə qaytarmalar yansitma' ad union all
select N'STP AH' comp, N'6.60.602.87.05' hesab, N'Metaleritme Zavədu mehsullarının qaytarılması yansitma' ad union all
select N'STP AH' comp, N'6.60.602.88' hesab, N'Digər Mehsullarin Geriqaytarmasi yansitma' ad union all
select N'STP AH' comp, N'6.60.602.88.01' hesab, N'Digər Mehsullarin Geriqaytarmasi yansitma' ad union all
select N'STP AH' comp, N'6.60.603' hesab, N'vərilmiş güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01' hesab, N'Hazırmehsullar üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.01' hesab, N'Kabel Hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.02' hesab, N'SPZ hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.03' hesab, N'Texniki Qazlar Zavədu Hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.04' hesab, N'Polimer memulatları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.05' hesab, N'Metaleritme Zavədu mehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.06' hesab, N'AMPZ Hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.07' hesab, N'Elektrik Avədanlıqları Hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.01.08' hesab, N'Qeyri Konvəyer hazırmehsulları üzrə güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.02' hesab, N'Digər Mehsullarin güzeştler' ad union all
select N'STP AH' comp, N'6.60.603.02.01' hesab, N'Digər Mehsullarin güzeştler' ad union all
select N'STP AH' comp, N'6.61' hesab, N'Sair emeliyyat gelirleri' ad union all
select N'STP AH' comp, N'6.61.611' hesab, N'Sair emeliyyat gelirleri' ad union all
select N'STP AH' comp, N'6.61.611.01' hesab, N'Sair emeliyyat gelirleri' ad union all
select N'STP AH' comp, N'6.61.611.01.01' hesab, N'Mezenne ferqleri üzrə gelirler' ad union all
select N'STP AH' comp, N'6.61.611.01.02' hesab, N'Yeniden qiymetlendirilmeden gelirler' ad union all
select N'STP AH' comp, N'6.61.611.01.03' hesab, N'esas vəsaitlerin satışından yaranan gelir (zerer)' ad union all
select N'STP AH' comp, N'6.61.611.01.04' hesab, N'Anbar sayımlarından yaranan gelir' ad union all
select N'STP AH' comp, N'6.61.611.01.05' hesab, N'Sair emeliyyat gelirleri' ad union all
select N'STP AH' comp, N'6.61.611.01.06' hesab, N'Esas vəsait satisindan gelir' ad union all
select N'STP AH' comp, N'6.61.611.01.74' hesab, N'Anbar sayımlarından yaranan gelir yansitma' ad union all
select N'STP AH' comp, N'6.61.611.01.98' hesab, N'Sair əməliyyat gəlirləri' ad union all
select N'STP AH' comp, N'6.61.611.86' hesab, N'Sair emeliyyat gelirleri yansitma' ad union all
select N'STP AH' comp, N'6.61.611.86.01' hesab, N'Sair emeliyyat gelirleri yansitma' ad union all
select N'STP AH' comp, N'6.62' hesab, N'Fealiyyetin dayandırılmasından yaranan gelirler' ad union all
select N'STP AH' comp, N'6.62.621' hesab, N'Fealiyyetin dayandırılmasından yaranan gelirler' ad union all
select N'STP AH' comp, N'6.63' hesab, N'Maliyye gelirleri' ad union all
select N'STP AH' comp, N'6.63.631' hesab, N'Maliyye gelirleri' ad union all
select N'STP AH' comp, N'6.63.631.01' hesab, N'Maliyye gelirleri' ad union all
select N'STP AH' comp, N'6.63.631.01.01' hesab, N'Hedging üzrə gelirler' ad union all
select N'STP AH' comp, N'6.64' hesab, N'Fövəelade gelirler' ad union all
select N'STP AH' comp, N'6.64.641' hesab, N'Fövəelade gelirler' ad union all
select N'STP AH' comp, N'7' hesab, N'XeRCLeR' ad union all
select N'STP AH' comp, N'7.70' hesab, N'Satışın maya dəyəri üzrə xercler' ad union all
select N'STP AH' comp, N'7.70.701' hesab, N'Satışın maya dəyəri üzrə xercler' ad union all
select N'STP AH' comp, N'7.70.701.01' hesab, N'Hazirmehsul satışlarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.01' hesab, N'Kabel Hazırmehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.02' hesab, N'Sendvəç Panel Zavədu Hazır Mehsulları' ad union all
select N'STP AH' comp, N'7.70.701.01.03' hesab, N'Texniki Qazlar Zavədu Hazırmehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.04' hesab, N'Polimer memulatlarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.05' hesab, N'Metaleritme Zavədu mehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.06' hesab, N'AMPZ Hazırmehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.07' hesab, N'Elektrik Avədanlıqları Hazırmehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.01.08' hesab, N'Qeyri Konvəyer hazırmehsullarının maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.02' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.02.01' hesab, N'Digər Mehsullarin maya dəyəri' ad union all
select N'STP AH' comp, N'7.70.701.98' hesab, N'Hazirmehsul satışlarının maya dəyəri yansitma ' ad union all
select N'STP AH' comp, N'7.70.701.98.01' hesab, N'Metaleritme Zavədu mehsullarının maya dəyəri yansitma' ad union all
select N'STP AH' comp, N'7.70.701.99' hesab, N'Digər Mehsullarin maya dəyəri yansitma' ad union all
select N'STP AH' comp, N'7.70.701.99.01' hesab, N'Digər Mehsullarin maya dəyəri yansitma' ad union all
select N'STP AH' comp, N'7.71' hesab, N'Kommersiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711' hesab, N'Kommersiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.01' hesab, N'emek haqqı və işçilik xercleri' ad union all
select N'STP AH' comp, N'7.71.711.01.01' hesab, N'Emek haqqi (iscilik xercleri net satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.02' hesab, N'İR Xercleri (telim, tedbir, axtarış)' ad union all
select N'STP AH' comp, N'7.71.711.01.03' hesab, N'Ezamiyye xercleri' ad union all
select N'STP AH' comp, N'7.71.711.01.04' hesab, N'Hazir mehsulun paketleme xerci' ad union all
select N'STP AH' comp, N'7.71.711.01.05' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.06' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen  satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.07' hesab, N'Emek haqqi (Issizlikden sigorta isegturen  Satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.08' hesab, N'Emek haqqi (Issizlikden sigorta isci  Satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.09' hesab, N'Emek haqqi (DSMF isegoturen satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.10' hesab, N'Emek haqqi (DSMF isci satis)' ad union all
select N'STP AH' comp, N'7.71.711.01.11' hesab, N'Hazir mehsulun paketleme xerci yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.63' hesab, N'Emek haqqi (DSMF isci satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.66' hesab, N'Emek haqqi (DSMF isegoturen satis)  yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.69' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.70' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen  satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.75' hesab, N'Emek haqqi (Issizlikden sigorta isci  Satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.78' hesab, N'Emek haqqi (Issizlikden sigorta isegturen  Satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.83' hesab, N'Emek haqqi (iscilik xercleri net satis) yansitma' ad union all
select N'STP AH' comp, N'7.71.711.01.85' hesab, N'Emek haqqi (heyatin yigim sigortasi)' ad union all
select N'STP AH' comp, N'7.71.711.02' hesab, N'Marketinq Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.02.01' hesab, N'Reklam Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.02.02' hesab, N'Araşdırma xercleri' ad union all
select N'STP AH' comp, N'7.71.711.02.03' hesab, N'Digər marketinq xercleri' ad union all
select N'STP AH' comp, N'7.71.711.03' hesab, N'esas vəsaitlerin Amortizasiya Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.71.711.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.71.711.03.03' hesab, N'Nəqliyyat vəsiteleriın amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.71.711.03.04' hesab, N'Digər Avədanlıqların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.71.711.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.04.01' hesab, N'Proqram teminatları üzrə amortizasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.05' hesab, N'esas vəsaitlerin Temir Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.05.01' hesab, N'Bina Tikili və Qurğuların temir xerci' ad union all
select N'STP AH' comp, N'7.71.711.05.02' hesab, N'Maşın və Avədanlıqların temir xerci' ad union all
select N'STP AH' comp, N'7.71.711.05.03' hesab, N'Nəqliyyat vəsiteleriın temir xerci' ad union all
select N'STP AH' comp, N'7.71.711.05.04' hesab, N'Digər Avədanlıqların temir xerci' ad union all
select N'STP AH' comp, N'7.71.711.06' hesab, N'Logostika xercleri' ad union all
select N'STP AH' comp, N'7.71.711.06.01' hesab, N'Yükdaşıma xercleri' ad union all
select N'STP AH' comp, N'7.71.711.06.02' hesab, N'Sernişindaşıma xercleri' ad union all
select N'STP AH' comp, N'7.71.711.06.03' hesab, N'Yanacaq xerci' ad union all
select N'STP AH' comp, N'7.71.711.06.99' hesab, N'Digər logistika xercleri' ad union all
select N'STP AH' comp, N'7.71.711.07' hesab, N'Sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.07.01' hesab, N'Mehsullar üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.07.02' hesab, N'Nəqliyyat vəsiteleri üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.07.03' hesab, N'Keyfiyyete nezaret üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.71.711.07.04' hesab, N'Avədanliq və qurgulara pasportlarin vərilmesi xercleri' ad union all
select N'STP AH' comp, N'7.71.711.85' hesab, N'Digər Xercler yansitma' ad union all
select N'STP AH' comp, N'7.71.711.85.01' hesab, N'Ixracat Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.71.711.99' hesab, N'Digər Xercler' ad union all
select N'STP AH' comp, N'7.71.711.99.01' hesab, N'İcare xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.02' hesab, N'IT xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.03' hesab, N'Kommunal xercler' ad union all
select N'STP AH' comp, N'7.71.711.99.04' hesab, N'Profisonal xidmetler xerci' ad union all
select N'STP AH' comp, N'7.71.711.99.05' hesab, N'Bank xidmetleri xerci' ad union all
select N'STP AH' comp, N'7.71.711.99.06' hesab, N'vərgi Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.07' hesab, N'emeyin mühafizesi və tibbi xercler' ad union all
select N'STP AH' comp, N'7.71.711.99.08' hesab, N'Sığorta xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.09' hesab, N'Teserrüfat xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.11' hesab, N'Xarab Mal xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP AH' comp, N'7.71.711.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP AH' comp, N'7.71.711.99.99' hesab, N'Sair Xercler' ad union all
select N'STP AH' comp, N'7.72' hesab, N'İnzibati xercler' ad union all
select N'STP AH' comp, N'7.72.721' hesab, N'İnzibati xercler' ad union all
select N'STP AH' comp, N'7.72.721.01' hesab, N'emek haqqı və işçilik xercleri' ad union all
select N'STP AH' comp, N'7.72.721.01.01' hesab, N'Emek haqqi (iscilik xercleri net inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.02' hesab, N'İR Xercleri (telim, tedbir, axtarış)' ad union all
select N'STP AH' comp, N'7.72.721.01.03' hesab, N'Ezamiyye xercleri' ad union all
select N'STP AH' comp, N'7.72.721.01.04' hesab, N'Emek haqqi (iscilik xercleri net istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.05' hesab, N'Ezamiyye xercleri istehsal' ad union all
select N'STP AH' comp, N'7.72.721.01.06' hesab, N'Emek haqqi (DSMF isegoturen inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.07' hesab, N'Emek haqqi (DSMF isci inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.08' hesab, N'Emek haqqi (DSMF isci istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.09' hesab, N'Emek haqqi (DSMF isegoturen istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.10' hesab, N'Emek haqqi (Issizlikden sigorta  isegoturen inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.11' hesab, N'Emek haqqi (Issizlikden sigorta isci inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.12' hesab, N'Emek haqqi (Issizlikden sigorta isegoturen istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.13' hesab, N'Emek haqqi (Issizlikden sigorta isci  istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.14' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.15' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci inzibati)' ad union all
select N'STP AH' comp, N'7.72.721.01.16' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.17' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci istehsal)' ad union all
select N'STP AH' comp, N'7.72.721.01.18' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen satis)' ad union all
select N'STP AH' comp, N'7.72.721.01.55' hesab, N'Telim inkisaf xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.01.61' hesab, N'Emek haqqi (DSMF isci inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.62' hesab, N'Emek haqqi (DSMF isci istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.64' hesab, N'Emek haqqi (DSMF isegoturen inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.65' hesab, N'Emek haqqi (DSMF isegoturen istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.67' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.68' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isci istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.71' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.72' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.73' hesab, N'Emek haqqi (Issizlikden sigorta  isegoturen inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.74' hesab, N'Emek haqqi (Issizlikden sigorta isci  istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.76' hesab, N'Emek haqqi (Issizlikden sigorta isci inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.77' hesab, N'Emek haqqi (Issizlikden sigorta isegoturen istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.79' hesab, N'Telim inkisaf xerci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.81' hesab, N'Emek haqqi (iscilik xercleri net inzibati) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.82' hesab, N'Emek haqqi (iscilik xercleri net istehsal) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.84' hesab, N'Telim inkisaf xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.01.94' hesab, N'Emek haqqi (iscilik xercleri net umumi)' ad union all
select N'STP AH' comp, N'7.72.721.01.96' hesab, N'Emek haqqi (Issizlikden sigorta  isegoturen umumi)' ad union all
select N'STP AH' comp, N'7.72.721.01.97' hesab, N'Emek haqqi (Icbari tibbi  sigorta  isegoturen umumi)' ad union all
select N'STP AH' comp, N'7.72.721.01.98' hesab, N'Emek haqqi (DSMF isegoturen umumi)' ad union all
select N'STP AH' comp, N'7.72.721.01.99' hesab, N'Telim inkisaf xerci' ad union all
select N'STP AH' comp, N'7.72.721.02' hesab, N'Marketinq Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.02.01' hesab, N'Reklam Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.02.02' hesab, N'Sehifelerin idare olunması xercleri' ad union all
select N'STP AH' comp, N'7.72.721.02.03' hesab, N'Araşdırma xercleri' ad union all
select N'STP AH' comp, N'7.72.721.02.04' hesab, N'Digər marketinq xercleri' ad union all
select N'STP AH' comp, N'7.72.721.03' hesab, N'esas vəsaitlerin Amortizasiya Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.03.01' hesab, N'Bina Tikili və Qurğuların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.72.721.03.02' hesab, N'Maşın və Avədanlıqların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.72.721.03.03' hesab, N'Nəqliyyat vəsiteleriın amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.72.721.03.04' hesab, N'Digər Avədanlıqların amortizasiya xerci' ad union all
select N'STP AH' comp, N'7.72.721.03.05' hesab, N'Maşın və Avədanlıqların amortizasiya xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.03.72' hesab, N'Maşın və Avədanlıqların amortizasiya xerci yansitma ' ad union all
select N'STP AH' comp, N'7.72.721.03.73' hesab, N'Maşın və Avədanlıqların amortizasiya xerci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.04' hesab, N'Qeyri Maddi aktivəərin amortizasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.04.01' hesab, N'Proqram teminatları üzrə amortizasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.04.02' hesab, N'Sertifikatlar  və vərilmis lisenziyalar uzre  amortizasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.05' hesab, N'esas vəsaitlerin Temir Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.05.01' hesab, N'Bina Tikili və Qurğuların temir xerci' ad union all
select N'STP AH' comp, N'7.72.721.05.02' hesab, N'Maşın və Avədanlıqların temir xerci' ad union all
select N'STP AH' comp, N'7.72.721.05.03' hesab, N'Nəqliyyat vəsiteleriın temir xerci' ad union all
select N'STP AH' comp, N'7.72.721.05.04' hesab, N'Digər Avədanlıqların temir xerci' ad union all
select N'STP AH' comp, N'7.72.721.05.05' hesab, N'Nəqliyyat vəsiteleriın temir xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.05.06' hesab, N'Bina Tikili və Qurğuların temir xerci ISTEHSAL' ad union all
select N'STP AH' comp, N'7.72.721.05.07' hesab, N'Maşın və Avədanlıqların temir xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.05.08' hesab, N'Nəqliyyat vəsiteleriın temir xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.06' hesab, N'Logostika xercleri' ad union all
select N'STP AH' comp, N'7.72.721.06.01' hesab, N'Yükdaşıma xercleri' ad union all
select N'STP AH' comp, N'7.72.721.06.02' hesab, N'Sernişindaşıma xercleri' ad union all
select N'STP AH' comp, N'7.72.721.06.03' hesab, N'Yanacaq xerci' ad union all
select N'STP AH' comp, N'7.72.721.06.04' hesab, N'Yanacaq xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.06.05' hesab, N'Yükdaşıma xercleri istehsal' ad union all
select N'STP AH' comp, N'7.72.721.06.99' hesab, N'Digər logistika xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07' hesab, N'Sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07.01' hesab, N'Mehsullar üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07.02' hesab, N'Nəqliyyat vəsiteleri üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07.03' hesab, N'Keyfiyyete nezaret üzrə sertifikasiya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07.04' hesab, N'Avədanliq və qurgulara  pasportun vərilmesi' ad union all
select N'STP AH' comp, N'7.72.721.07.05' hesab, N'Labaratoriya xercleri' ad union all
select N'STP AH' comp, N'7.72.721.07.77' hesab, N'Labaratoriya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.75' hesab, N'emek haqqı və işçilik xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.75.01' hesab, N'İşçilik xercler yansitma' ad union all
select N'STP AH' comp, N'7.72.721.75.02' hesab, N'İşçilik xercleri istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.75.03' hesab, N'İR Xercleri (telim, tedbir, axtarış) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.76' hesab, N'Marketinq Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.76.01' hesab, N'Digər marketinq xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77' hesab, N'esas vəsaitlerin Amortizasiya Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77.01' hesab, N'Bina tikili və Qurğuların  Amortizasiya Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77.02' hesab, N'Maşın və avədanlıqların   Amortizasiya Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77.03' hesab, N'Nəqliyyat vəsitelerinin   Amortizasiya Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77.04' hesab, N'Digər avədanlıqların  Amortizasiya Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.77.05' hesab, N'Maşın və avədanlıqların   Amortizasiya Xerci istehsal  yansitma' ad union all
select N'STP AH' comp, N'7.72.721.78' hesab, N'Qeyri Maddi aktivəərin amortizasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.78.01' hesab, N'Proqram teminatları üzrə  amortizasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.78.02' hesab, N'Sertifikatlar və vərilmis lisenziyalar uzre  amortizasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79' hesab, N'Esas vəsaitlerin Temir Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.01' hesab, N'Bina tikili və Qurğuların  temir Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.02' hesab, N'Maşın və Avədanlıqların   temir Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.03' hesab, N'Maşın və Avədanlıqların   temir Xerci istehsal  yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.04' hesab, N'Bina tikili və Qurğuların  temir Xerci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.05' hesab, N'Nəqliyyat vəsitelerinin  temir Xerci  yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.06' hesab, N'Nəqliyyat vəsitelerinin  temir Xerci istehsal  yansitma' ad union all
select N'STP AH' comp, N'7.72.721.79.07' hesab, N'Digər avədanliqlarin  temir Xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80' hesab, N'Logostika xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.01' hesab, N'Yükdaşıma xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.02' hesab, N'Sernişindaşıma xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.03' hesab, N'Yanacaq xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.04' hesab, N'Yanacaq xerci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.05' hesab, N'Yükdaşıma xercleri istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.80.99' hesab, N'Digər logistika xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.81' hesab, N'Sertifikasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.81.01' hesab, N'Mehsullar üzrə sertifikasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.81.02' hesab, N'Nəqliyyat vəsiteleri üzrə sertifikasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.81.03' hesab, N'Keyfiyyete nezaret üzrə sertifikasiya xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.81.05' hesab, N'Labarotoriya  xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82' hesab, N'Digər Xercler yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.01' hesab, N'İcare xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.02' hesab, N'IT xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.03' hesab, N'Kommunal xercler yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.04' hesab, N'Profisonal xidmetler xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.05' hesab, N'Bank xidmetleri xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.06' hesab, N'vərgi Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.07' hesab, N'emeyin mühafizesi və tibbi xercler yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.08' hesab, N'Sığorta xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.09' hesab, N'Teserrüfat xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.10' hesab, N'Yemekxana xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.12' hesab, N'Ixracat Xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.13' hesab, N'Mobil Rabitə xərci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.14' hesab, N'Köməkçi istehsalat xərcləri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.15' hesab, N'Yardim xercleri yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.16' hesab, N'Mühafizə xidməti yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.17' hesab, N'Sinaq - Yoxlama (test) xidmeti yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.18' hesab, N'Səyahət xərci (bilet) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.19' hesab, N'Mehmanxana(hotel) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.20' hesab, N'Kommunal xercler istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.21' hesab, N'Sernisin dasima xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.22' hesab, N'Sernisin dasima xerci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.23' hesab, N'Yemekxana xercleri istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.24' hesab, N'Sığorta xercleri istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.25' hesab, N'İcare xercleri istehsal(greyfer) yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.26' hesab, N'Səyahət xərci və.s yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.27' hesab, N'Defterxana və ofis levəzimatlari xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.28' hesab, N'Teserrufat qida və benzeri mallar xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.29' hesab, N'Temizlik mallari xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.34' hesab, N'Mobil Rabitə xərci istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.85' hesab, N'Tullanti dasinmasi xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.95' hesab, N'İcare xercleri zavəd  yansitma' ad union all
select N'STP AH' comp, N'7.72.721.82.99' hesab, N'Sair Xercler yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99' hesab, N'Digər Xercler' ad union all
select N'STP AH' comp, N'7.72.721.99.01' hesab, N'İcare xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.02' hesab, N'IT xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.03' hesab, N'Kommunal xercler' ad union all
select N'STP AH' comp, N'7.72.721.99.04' hesab, N'Profisonal xidmetler xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.05' hesab, N'Bank xidmetleri xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.06' hesab, N'vərgi Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.07' hesab, N'emeyin mühafizesi və tibbi xercler' ad union all
select N'STP AH' comp, N'7.72.721.99.08' hesab, N'Sığorta xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.09' hesab, N'Teserrüfat xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.10' hesab, N'Yemekxana xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.11' hesab, N'Xarab Mal xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.12' hesab, N'Ixracat Xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.13' hesab, N'Mobil Rabitə xərci' ad union all
select N'STP AH' comp, N'7.72.721.99.14' hesab, N'Köməkçi istehsalat xərcləri' ad union all
select N'STP AH' comp, N'7.72.721.99.15' hesab, N'Yardim xercleri' ad union all
select N'STP AH' comp, N'7.72.721.99.16' hesab, N'Mühafizə xidməti' ad union all
select N'STP AH' comp, N'7.72.721.99.17' hesab, N'Sinaq - Yoxlama (test) xidmeti' ad union all
select N'STP AH' comp, N'7.72.721.99.18' hesab, N'Səyahət xərci (bilet)' ad union all
select N'STP AH' comp, N'7.72.721.99.19' hesab, N'Mehmanxana(hotel)' ad union all
select N'STP AH' comp, N'7.72.721.99.20' hesab, N'Kommunal xercler istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.21' hesab, N'Sernisin dasima xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.22' hesab, N'Sernisin dasima xerci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.23' hesab, N'Yemekxana xercleri istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.24' hesab, N'Sığorta xercleri istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.25' hesab, N'İcare xercleri istehsal(greyfer)' ad union all
select N'STP AH' comp, N'7.72.721.99.26' hesab, N'Səyahət xərci və.s' ad union all
select N'STP AH' comp, N'7.72.721.99.27' hesab, N'Defterxana və ofis levəzimatlari xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.28' hesab, N'Teserrufat qida və benzeri mallar xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.29' hesab, N'Temizlik mallari xerci ' ad union all
select N'STP AH' comp, N'7.72.721.99.34' hesab, N'Mobil Rabitə xərci istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.35' hesab, N'Geyim  xərcləri  istehsalat' ad union all
select N'STP AH' comp, N'7.72.721.99.36' hesab, N'Geyim xercleri tibbi' ad union all
select N'STP AH' comp, N'7.72.721.99.37' hesab, N'Geyim  xərcləri inzibati' ad union all
select N'STP AH' comp, N'7.72.721.99.38' hesab, N'İstehsal geyimlərinin dərzi xidməti' ad union all
select N'STP AH' comp, N'7.72.721.99.39' hesab, N'emeyin mühafizesi və tibbi xercler STP' ad union all
select N'STP AH' comp, N'7.72.721.99.49' hesab, N'Stasionar  Rabitə xərci' ad union all
select N'STP AH' comp, N'7.72.721.99.71' hesab, N'Sair Xercler istehsalla bagli yansitma ' ad union all
select N'STP AH' comp, N'7.72.721.99.76' hesab, N'Geyim  xərcləri inzibati yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.77' hesab, N'Icare xidmet xercleri   istehsal yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.78' hesab, N'Geyim  xərcləri  istehsalat yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.79' hesab, N'Stasionar  Rabitə xərci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.81' hesab, N'Sair Xercler istehsalla bagli' ad union all
select N'STP AH' comp, N'7.72.721.99.85' hesab, N'Tullanti dasinmasi xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.86' hesab, N'Audit xerci' ad union all
select N'STP AH' comp, N'7.72.721.99.87' hesab, N'Icare xidmet xercleri   istehsal' ad union all
select N'STP AH' comp, N'7.72.721.99.88' hesab, N'emeyin mühafizesi və tibbi xercler STP yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.89' hesab, N'Digər Avədanlıqların amortizasiya xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.91' hesab, N'Audit xerci yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.95' hesab, N'İcare xercleri zavəd ' ad union all
select N'STP AH' comp, N'7.72.721.99.98' hesab, N'İstehsal geyimlərinin dərzi xidməti yansitma' ad union all
select N'STP AH' comp, N'7.72.721.99.99' hesab, N'Sair Xercler' ad union all
select N'STP AH' comp, N'7.73' hesab, N'Sair emeliyyat xercleri' ad union all
select N'STP AH' comp, N'7.73.731' hesab, N'Sair emeliyyat xercleri' ad union all
select N'STP AH' comp, N'7.73.731.01' hesab, N'Sair emeliyyat xercleri' ad union all
select N'STP AH' comp, N'7.73.731.01.01' hesab, N'Mezenne ferqleri üzrə xercler' ad union all
select N'STP AH' comp, N'7.73.731.01.02' hesab, N'Yeniden qiymetlendirilmeden gelirler' ad union all
select N'STP AH' comp, N'7.73.731.01.03' hesab, N'esas vəsaitlerin satışından yaranan gelir (zerer)' ad union all
select N'STP AH' comp, N'7.73.731.01.04' hesab, N'Anbar sayımlarından yaranan xərc' ad union all
select N'STP AH' comp, N'7.73.731.01.05' hesab, N'cərimələr və Digər oxşar ödənişlər,' ad union all
select N'STP AH' comp, N'7.73.731.01.06' hesab, N'esas vəsaitlerin silinmesinden (zerer)' ad union all
select N'STP AH' comp, N'7.73.731.83' hesab, N'Sair emeliyyat xercleri yansitma' ad union all
select N'STP AH' comp, N'7.73.731.83.01' hesab, N'Mezenne ferqleri üzrə xercler yansitma' ad union all
select N'STP AH' comp, N'7.73.731.83.02' hesab, N'Yeniden qiymetlendirilmeden gelirler yansitma' ad union all
select N'STP AH' comp, N'7.73.731.83.03' hesab, N'esas vəsaitlerin satışından yaranan gelir (zerer) yansitma' ad union all
select N'STP AH' comp, N'7.73.731.83.04' hesab, N'Anbar sayımlarından yaranan xərc yansitma' ad union all
select N'STP AH' comp, N'7.73.731.83.05' hesab, N'cərimələr və Digər oxşar ödənişlər yansitma' ad union all
select N'STP AH' comp, N'7.74' hesab, N'Fealiyyetin dayandırılmasından yaranan xercler' ad union all
select N'STP AH' comp, N'7.74.741' hesab, N'Fealiyyetin dayandırılmasından yaranan xercler' ad union all
select N'STP AH' comp, N'7.75' hesab, N'Maliyye xercleri' ad union all
select N'STP AH' comp, N'7.75.751' hesab, N'Maliyye xercleri' ad union all
select N'STP AH' comp, N'7.75.751.01' hesab, N'Maliyye xercleri ' ad union all
select N'STP AH' comp, N'7.75.751.01.01' hesab, N'Maliyye xercleri ' ad union all
select N'STP AH' comp, N'7.75.751.01.02' hesab, N'Faiz xercleri ' ad union all
select N'STP AH' comp, N'7.75.751.84' hesab, N'Maliyye xercleri  yansitma' ad union all
select N'STP AH' comp, N'7.75.751.84.01' hesab, N'Maliyye xercleri  yansitma' ad union all
select N'STP AH' comp, N'7.75.751.84.02' hesab, N'Faiz xercleri yansitma' ad union all
select N'STP AH' comp, N'7.76' hesab, N'Fövəelade xercler' ad union all
select N'STP AH' comp, N'7.76.761' hesab, N'Fövəelade xercler' ad union all
select N'STP AH' comp, N'8' hesab, N'MeNFeeTLeR (ZeReRLeR)' ad union all
select N'STP AH' comp, N'8.80' hesab, N'Ümumi menfeet (zerer)' ad union all
select N'STP AH' comp, N'8.80.801' hesab, N'Ümumi menfeet (zerer)' ad union all
select N'STP AH' comp, N'8.80.801.01' hesab, N'Ümumi menfeet (zerer)' ad union all
select N'STP AH' comp, N'8.80.801.01.01' hesab, N'Ümumi menfeet (zerer)' ad union all
select N'STP AH' comp, N'8.80.801.85' hesab, N'Ümumi menfeet (zerer) yansitma' ad union all
select N'STP AH' comp, N'8.80.801.85.01' hesab, N'Ümumi menfeet (zerer) yansitma' ad union all
select N'STP AH' comp, N'8.81' hesab, N'Asılı və birge müessiselerin menfeetlerinde(zererlerinde) pay' ad union all
select N'STP AH' comp, N'8.81.811' hesab, N'Asılı və birge müessiselerin menfeetlerinde(zererlerinde) pay' ad union all
select N'STP AH' comp, N'9' hesab, N'MeNFeeT vəRGİSİ' ad union all
select N'STP AH' comp, N'9.90' hesab, N'Menfeet vərgisi' ad union all
select N'STP AH' comp, N'9.90.901' hesab, N'Cari menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.901.01' hesab, N'Cari menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.901.01.01' hesab, N'Cari menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.901.87' hesab, N'Cari menfeet vərgisi üzrə xercler yansitma' ad union all
select N'STP AH' comp, N'9.90.901.87.01' hesab, N'Cari menfeet vərgisi üzrə xercler yansitma' ad union all
select N'STP AH' comp, N'9.90.902' hesab, N'Texire salınmış menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.902.01' hesab, N'Texire salınmış menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.902.01.01' hesab, N'Texire salınmış menfeet vərgisi üzrə xercler' ad union all
select N'STP AH' comp, N'9.90.903' hesab, N'Cari menfeet vərgisi Menfeet vərgisi' ad) t

where t.comp=@comp



) 
,  t as(



 
 select 
   t.[Hesab Kodu]
 , round(IIF(t.[Devr Debit 2]>t.[Devr Kredit 2], t.[Devr Debit 2]-t.[Devr Kredit 2], 0),4) [Devr Debit 1]
 , round(IIF(t.[Devr Debit 2]<t.[Devr Kredit 2], t.[Devr Kredit 2]-t.[Devr Debit 2], 0),4) [Devr Kredit 1]
 , t.[Devr Debit 2]
 , t.[Devr Kredit 2]
 , t.DT
 , t.KT
, round(iif(t.Total_debt>t.Total_kredit, t.Total_debt-t.Total_kredit, 0),4) [Son Debt]
, round(iif(t.Total_debt<t.Total_kredit, t.Total_kredit-t.Total_debt, 0),4) [Son Kredit]

 from (
 select t.[Hesab Kodu]
 , round( sum(iif(t.Tarix<@report_db, t.Debit, 0)),4) [Devr Debit 2]
 , round( sum(iif(t.Tarix<@report_db, t.Kredit, 0)),4) [Devr Kredit 2]
 , round( sum(iif(t.Tarix>=@report_db and t.Tarix<=@report_de, t.Debit, 0)),4) [DT]
 , round( sum(iif(t.Tarix>=@report_db and t.Tarix<=@report_de, t.Kredit, 0)),4) [KT]
 , round( sum(iif(t.Tarix>=@gl_db and t.Tarix<=@report_de, t.Debit, 0)),4) Total_debt
 , round( sum(iif(t.Tarix>=@gl_db and t.Tarix<=@report_de, t.Kredit, 0)),4) Total_kredit

 

 from src t
 
 group by t.[Hesab Kodu]
 ) t


)
, t1 as(
select 
t.[Hesab Kodu] hk
,left( t.[Hesab Kodu], 1) hk1
,left( t.[Hesab Kodu], 4) hk2
,left( t.[Hesab Kodu], 8) hk3
,left( t.[Hesab Kodu], 11) hk4
--,left( t.[Hesab Kodu], 4) hk2
--,left( t.[Hesab Kodu], 4) hk2

, t.*
from t
) 
, t2 as(
select  '' [Hesab Kodu]
	   ,''  account_type
       ,'' [Hesap Adı]
	   , isnull(sum(t.[Devr Debit 1]),0) [Devr Debit 1]
       , isnull(sum(t.[Devr Kredit 1]),0) [Devr Kredit 1]
       , isnull(sum(t.[Devr Debit 2]),0) [Devr Debit 2]
       , isnull(sum(t.[Devr Kredit 2]),0) [Devr Kredit 2]
       , isnull(sum(t.DT),0)  DT
       , isnull(sum(t.KT),0) KT
       , isnull(sum(t.[Son Debt]),0) [Son Debt]
       , isnull(sum(t.[Son Kredit]),0) [Son Kredit]
from t1 t

union all

select 
 t.hk0 [Hesab Kodu]
, t.account_type
, t.hesab_Ad [Hesap Adı]
, isnull(sum(t.[Devr Debit 1]),0) [Devr Debit 1]
, isnull(sum(t.[Devr Kredit 1]),0) [Devr Kredit 1]
, isnull(sum(t.[Devr Debit 2]),0) [Devr Debit 2]
, isnull(sum(t.[Devr Kredit 2]),0) [Devr Kredit 2]
, isnull(sum(t.DT),0)  DT
, isnull(sum(t.KT),0) KT
, isnull(sum(t.[Son Debt]),0) [Son Debt]
, isnull(sum(t.[Son Kredit]),0) [Son Kredit]
from
(
select t1.*
, con.hk hk0, con.hesab_Ad
--, iif(t1.hk=con.hk, 'Sub', 'main') account_type
--, case when  t1.hk=con.hk then  'Sub' when len(con.hk)=1 then 'Main' else 'other' end  account_type
, con.account_type
from (
select  t.hk, t.hesab_Ad
, case when uz=1 then 'Main' when  uz<lead(uz) over(order by hk)  then 'Other' else 'Sub' end account_type
from ( select *, LEN(con.hk) uz from con ) t
 
)con
left join  t1 on t1.hk=con.hk or con.hk=t1.hk1 or con.hk=t1.hk2 or con.hk=t1.hk3 or con.hk=t1.hk4
--where con.hk like '1.10.101%'
) t
where t.account_type in (@hesab_typ)
group by  t.hk0, t.hesab_Ad, t.account_type
)
 

select *
from t2
order by 1