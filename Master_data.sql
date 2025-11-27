 
; with src as(

SELECT
 'STP MMC' comp
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM TGR3.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP MMC')


union all


SELECT
 'STP AH' comp
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM          TGR3_AH.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_AH.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_AH.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_AH.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_AH.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_AH.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_AH.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_AH.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3_AH.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP AH')


union all


SELECT
 'STP AMPZ' comp
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM          TGR3_AMPZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_AMPZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_AMPZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_AMPZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_AMPZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_AMPZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3_AMPZ.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP AMPZ')



union all


SELECT
 'STP KZ' comp
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM          TGR3_KZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_KZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_KZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_KZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_KZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_KZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3_KZ.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP KZ')
 

 
union all


SELECT
 'STP PMZ' comp
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM          TGR3_PMZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_PMZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_PMZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_PMZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_PMZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_PMZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3_PMZ.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP PMZ')



union all


SELECT
 'STP QQZ' comp 
, EMFLINE.LOGICALREF
, u.NAME 'Yaradan Adi'
, u1.NAME 'Son Deyisdiren Adi'
, EMFICHE.CAPIBLOCK_CREADEDDATE 'Yaranma Tarixi'
, ISNULL(EMFICHE.CAPIBLOCK_MODIFIEDDATE, '') 'Son Deyisiklik Tarixi'
, EMFLINE.DATE_ 'Tarix'
, EMFLINE.DEPARTMENT 'Bölüm No'
, DEPT.NAME 'Bölüm Adý'
, EMFLINE.BRANCH 'Ýþ Yeri No'
, EMCENTER.CODE 'Masraf Kodu'
, EMCENTER.DEFINITION_ 'Masraf Adý'
, EMUHACC.CODE 'Hesab Kodu'
, EMUHACC.DEFINITION_ 'Hesab Adý'
, CASE WHEN CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) > 0 THEN    SUBSTRING(EMFLINE.LINEEXP,1,LEN(EMFLINE.LINEEXP)- CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)
			  , CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 1)+ 2 ) + SUBSTRING(EMFLINE.LINEEXP, LEN(EMFLINE.LINEEXP) - CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)) + 2,
                CHARINDEX(',', REVERSE(EMFLINE.LINEEXP)))         ELSE EMFLINE.LINEEXP   END 'Açýqlama'
, EMFICHE.FICHENO 'Mahsub No'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.DEBIT) 'Debit'
, iif(EMFICHE.CAPIBLOCK_CREATEDBY=1 and EMFICHE.TRCODE in (1,7) , 0, EMFLINE.CREDIT) 'Kredit'
, EMFICHE.MODULENR 'Kaynak Fiþ Türü'
, EMFLINE.CLCODE 'Cari Kod'
, EMFLINE.CLDEF 'Cari Ad'
, EMFLINE.CROSSCODE 'qarsi hesab kod'
, EMUHACC1.DEFINITION_ 'qarsi hesab ad'
, div.NAME is_yeri
FROM          TGR3_QQZ.dbo.LG_001_01_EMFLINE EMFLINE WITH(NOLOCK) 
    left JOIN TGR3_QQZ.dbo.LG_001_01_EMFICHE EMFICHE WITH(NOLOCK)  ON EMFICHE.LOGICALREF = EMFLINE.ACCFICHEREF
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMUHACC EMUHACC   WITH(NOLOCK)   ON EMFLINE.ACCOUNTREF = EMUHACC.LOGICALREF
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMUHACC EMUHACC1  WITH(NOLOCK)    on EMFLINE.CROSSCODE = EMUHACC1.CODE
    left join TGR3_QQZ.dbo.L_CAPIUSER u   WITH(NOLOCK)    on u.NR = EMFICHE.CAPIBLOCK_CREATEDBY
    left join TGR3_QQZ.dbo.L_CAPIUSER u1    WITH(NOLOCK)   on u1.NR = EMFICHE.CAPIBLOCK_MODIFIEDBY
    LEFT JOIN TGR3_QQZ.dbo.L_CAPIDEPT DEPT   WITH(NOLOCK)   ON DEPT.NR = EMFLINE.DEPARTMENT       AND DEPT.FIRMNR = 1
    LEFT JOIN TGR3_QQZ.dbo.LG_001_EMCENTER EMCENTER  WITH(NOLOCK)    ON EMCENTER.LOGICALREF = EMFLINE.CENTERREF
	left join TGR3_QQZ.dbo.[L_CAPIDIV] div WITH(NOLOCK) on div.NR=  EMFLINE.BRANCH and div.FIRMNR=1
WHERE EMFLINE.DATE_ >= @gl_db     AND EMFLINE.DATE_ <= @gl_de   and EMFLINE.CANCELLED = 0
and @comp in ('STP QQZ')
)
, balance as
(select 1 acn, 'BS' typ1, 'Assets' typ2 union all
select 2 acn, 'BS' typ1, 'Assets' typ2 union all
select 3 acn, 'BS' typ1, 'Equity' typ2 union all
select 4 acn, 'BS' typ1, 'Liabilities' typ2 union all
select 5 acn, 'BS' typ1, 'Liabilities' typ2 union all
select 6 acn, 'PL' typ1, 'Revenue' typ2 union all
select 7 acn, 'PL' typ1, 'Expense' typ2 union all
select 8 acn, 'Profit' typ1, 'Profit' typ2 union all
select 9 acn, 'Profit TAX' typ1, 'Profit TAX' typ2 )  
, ac as(
select '1' Logo_account_number, '' Disclosure_line, 'Non-current assets' FS_line union all
select '1.10' Logo_account_number, '' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.101' Logo_account_number, '' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.101.01' Logo_account_number, '' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.101.01.01' Logo_account_number, 'Software' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.101.01.02' Logo_account_number, 'Patents' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.101.01.03' Logo_account_number, 'Intangible assets - cost' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.102' Logo_account_number, '' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.102.01' Logo_account_number, '' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.102.01.01' Logo_account_number, 'Accumulated amortization of software' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.102.01.02' Logo_account_number, 'Accumulated amortization of patents' Disclosure_line, 'Intangible assets' FS_line union all
select '1.10.102.01.03' Logo_account_number, 'Intangible assets - accumulated amortization' Disclosure_line, 'Intangible assets' FS_line union all
select '1.11' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111.01' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111.01.01' Logo_account_number, 'Buildings and premises' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111.01.02' Logo_account_number, 'Machinery and equipment-cost' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111.01.03' Logo_account_number, 'Machinery and equipment-cost' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.111.01.04' Logo_account_number, 'Furniture and fixtures -cost' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112.01' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112.01.01' Logo_account_number, 'Accumulated depreciation of buildings and premises' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112.01.02' Logo_account_number, 'Machinery and equipment- accumulated depreciation' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112.01.03' Logo_account_number, 'Accumulated depreciation of transport vehicles' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.112.01.04' Logo_account_number, 'Furniture and fixtures- accumulated depreciation' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01' Logo_account_number, '' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.01' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.02' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.03' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.04' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.05' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.11.113.01.06' Logo_account_number, 'CIP' Disclosure_line, 'Property, plant and equipment' FS_line union all
select '1.12' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.12.121' Logo_account_number, 'Investment property' Disclosure_line, 'Investment property' FS_line union all
select '1.12.122' Logo_account_number, 'Accumulated depreciation of investment property' Disclosure_line, 'Investment property' FS_line union all
select '1.12.123' Logo_account_number, 'Capitalized expenditures on investment property' Disclosure_line, 'Investment property' FS_line union all
select '1.13' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.13.131' Logo_account_number, 'Biological assets' Disclosure_line, 'Biological assets' FS_line union all
select '1.13.132' Logo_account_number, 'Accumulated amortization of biologival assets' Disclosure_line, 'Biological assets' FS_line union all
select '1.14' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.14.141' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.14.142' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.15' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.15.151' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.15.151.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.15.151.01.01' Logo_account_number, 'Investments in subsidairies' Disclosure_line, 'Investment' FS_line union all
select '1.15.152' Logo_account_number, 'Investment in joint ventures' Disclosure_line, 'Investment' FS_line union all
select '1.15.153' Logo_account_number, 'Revaluation gain/(loss) on investments' Disclosure_line, 'Investment' FS_line union all
select '1.16' Logo_account_number, '' Disclosure_line, 'Deferred tax asset' FS_line union all
select '1.16.161' Logo_account_number, 'Deffered tax asset' Disclosure_line, 'Deffered tax asset' FS_line union all
select '1.16.162' Logo_account_number, 'Deferred tax asset' Disclosure_line, 'Deferred tax asset' FS_line union all
select '1.17' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.171' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.171.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.171.01.01' Logo_account_number, 'Long-term trade and other receivables' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.17.172' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.172.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.172.01.01' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.17.173' Logo_account_number, 'Long-term trade and other receivables' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.17.174' Logo_account_number, 'Long-term lease receivable' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.17.175' Logo_account_number, 'Long-term trade and other receivables' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.17.176' Logo_account_number, 'Long-term trade and other receivables' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.17.177' Logo_account_number, 'Long-term trade and other receivables' Disclosure_line, 'Long-term trade and other receivables' FS_line union all
select '1.18' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.181' Logo_account_number, 'Assets held for sale' Disclosure_line, 'Assets held for sale' FS_line union all
select '1.18.182' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.182.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.182.01.01' Logo_account_number, 'Long-term debts issued' Disclosure_line, 'Long-term debts issued' FS_line union all
select '1.18.183' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.183.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.183.01.01' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.18.184' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.19' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.19.191' Logo_account_number, 'Prepayment for services' Disclosure_line, 'Long-term prepayment' FS_line union all
select '1.19.191.01' Logo_account_number, '' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.19.191.01.01' Logo_account_number, 'Prepayment for services' Disclosure_line, 'Other non-current assets' FS_line union all
select '1.19.192' Logo_account_number, 'Prepayment for goods' Disclosure_line, 'Long-term prepayment' FS_line union all
select '1.19.193' Logo_account_number, 'Other non-current assets' Disclosure_line, 'Other non-current assets' FS_line union all
select '2' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.201' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.201.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.201.01.01' Logo_account_number, 'Raw materials' Disclosure_line, 'Inventory' FS_line union all
select '2.20.201.01.02' Logo_account_number, 'Work in progress' Disclosure_line, 'Inventory' FS_line union all
select '2.20.201.01.03' Logo_account_number, 'Work in progress' Disclosure_line, 'Inventory' FS_line union all
select '2.20.201.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.201.02.01' Logo_account_number, 'Inventory in transit' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.202.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.202.01.01' Logo_account_number, 'Other' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.02' Logo_account_number, 'Salary expenses overhead' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.03' Logo_account_number, 'Utility overhead' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.04' Logo_account_number, 'Depreciation overhead' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.05' Logo_account_number, 'Repair overhead' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.06' Logo_account_number, 'Work in progress' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.01.99' Logo_account_number, 'Other' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.99' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.202.99.01' Logo_account_number, 'Other' Disclosure_line, 'Inventory' FS_line union all
select '2.20.202.99.02' Logo_account_number, 'Raw materials' Disclosure_line, 'Inventory' FS_line union all
select '2.20.203' Logo_account_number, 'Contract asset' Disclosure_line, 'Contract asset' FS_line union all
select '2.20.204' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.204.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.204.01.01' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.02' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.03' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.04' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.05' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.06' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.07' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.204.01.08' Logo_account_number, 'Finished goods' Disclosure_line, 'Inventory' FS_line union all
select '2.20.205' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.205.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.205.01.01' Logo_account_number, 'Other' Disclosure_line, 'Inventory' FS_line union all
select '2.20.205.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.205.02.01' Logo_account_number, 'Inventory in transit' Disclosure_line, 'Inventory' FS_line union all
select '2.20.206' Logo_account_number, 'Assets held for sale' Disclosure_line, 'Assets held for sale' FS_line union all
select '2.20.207' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.207.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.207.01.01' Logo_account_number, 'Low value items' Disclosure_line, 'Inventory' FS_line union all
select '2.20.207.01.02' Logo_account_number, 'Low value items' Disclosure_line, 'Inventory' FS_line union all
select '2.20.207.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.207.02.01' Logo_account_number, 'Goods in transit' Disclosure_line, 'Inventory' FS_line union all
select '2.20.208' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.20.208.99' Logo_account_number, 'Warehouse movement' Disclosure_line, 'Inventory' FS_line union all
select '2.21' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.211' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.211.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.211.01.01' Logo_account_number, 'Trade receivables from corporate clients' Disclosure_line, 'Trade and other receivables' FS_line union all
select '2.21.211.01.02' Logo_account_number, 'Trade receivables from individual clients' Disclosure_line, 'Trade and other receivables' FS_line union all
select '2.21.211.01.03' Logo_account_number, 'Trade receivables -foreign customers' Disclosure_line, 'Trade and other receivables' FS_line union all
select '2.21.212' Logo_account_number, 'Short-term trade and other receivables' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.213' Logo_account_number, 'Short-term trade and other receivables' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.214' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.214.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.214.01.01' Logo_account_number, 'Short-term lease receivable' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.215' Logo_account_number, 'Short-term trade and other receivables' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.216' Logo_account_number, 'Short-term trade and other receivables' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.217' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.217.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.217.01.01' Logo_account_number, 'Short-term trade and other receivables' Disclosure_line, 'Short-term trade and other receivables' FS_line union all
select '2.21.217.01.02' Logo_account_number, 'Tax receivables' Disclosure_line, 'Trade and other receivables' FS_line union all
select '2.21.218' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.218.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.21.218.01.01' Logo_account_number, 'Allowance for trade and other receivables' Disclosure_line, 'Allowance for trade and other receivables' FS_line union all
select '2.22' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.221' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.221.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.221.01.01' Logo_account_number, 'Petty cash' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.222' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.222.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.222.01.01' Logo_account_number, 'Cash and cash equivalents' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.223' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.223.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.223.01.01' Logo_account_number, 'Bank balances -AZN' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.223.01.02' Logo_account_number, 'Bank balances -USD' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.223.01.03' Logo_account_number, 'Bank balances -EUR' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.223.01.04' Logo_account_number, 'Bank balances RUB' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.223.01.05' Logo_account_number, 'Bank balances' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.224' Logo_account_number, 'Cash and cash equivalents' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.225' Logo_account_number, 'Cash and cash equivalents' Disclosure_line, 'Cash and cash equivalents' FS_line union all
select '2.22.226' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.226.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.22.226.01.01' Logo_account_number, 'VAT deposit account' Disclosure_line, 'Other current assets' FS_line union all
select '2.23' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.23.231' Logo_account_number, 'Investments held for sale' Disclosure_line, 'Investment security' FS_line union all
select '2.23.232' Logo_account_number, 'Investments at amortized cost' Disclosure_line, 'Investment security' FS_line union all
select '2.23.233' Logo_account_number, 'Short-term debts issued' Disclosure_line, 'Short-term debts issued' FS_line union all
select '2.23.234' Logo_account_number, 'Other current assets' Disclosure_line, 'Other current assets' FS_line union all
select '2.23.235' Logo_account_number, 'Other current assets' Disclosure_line, 'Other current assets' FS_line union all
select '2.24' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.241' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.241.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.241.01.01' Logo_account_number, 'VAT recoverable' Disclosure_line, 'Other current assets' FS_line union all
select '2.24.242' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.242.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.242.01.01' Logo_account_number, 'Import expenses' Disclosure_line, 'Other current assets' FS_line union all
select '2.24.242.01.02' Logo_account_number, 'Hedging account balance' Disclosure_line, 'Other current assets' FS_line union all
select '2.24.243' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.243.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.243.01.01' Logo_account_number, 'Prepayment for goods' Disclosure_line, 'Short-term prepayment' FS_line union all
select '2.24.244' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.244.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.244.01.01' Logo_account_number, 'Advance paid to suppliers' Disclosure_line, 'Prepayments' FS_line union all
select '2.24.245' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.245.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '2.24.245.01.01' Logo_account_number, 'PTS balance' Disclosure_line, 'Other current assets' FS_line union all
select '2.24.245.01.02' Logo_account_number, 'Advance paid to suppliers' Disclosure_line, 'Prepayments' FS_line union all
select '2.24.245.01.03' Logo_account_number, 'Advance paid to suppliers' Disclosure_line, 'Prepayments' FS_line union all
select '2.24.245.12' Logo_account_number, 'Advance paid to suppliers' Disclosure_line, 'Prepayments' FS_line union all
select '3' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301.01.01' Logo_account_number, 'Share capital' Disclosure_line, 'Share capital' FS_line union all
select '3.30.302' Logo_account_number, 'Paid-up share capital' Disclosure_line, 'Share Capital' FS_line union all
select '3.31' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.31.311' Logo_account_number, 'Share premium' Disclosure_line, 'Share premium' FS_line union all
select '3.32' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.32.321' Logo_account_number, 'Bought back shares' Disclosure_line, 'Bought back shares' FS_line union all
select '3.33' Logo_account_number, '' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.331' Logo_account_number, 'Revaluation surplus' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.332' Logo_account_number, 'Reserve for currency' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.333' Logo_account_number, 'Reserve for changes in legislation' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.334' Logo_account_number, 'Reserve for share capital' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.335' Logo_account_number, 'Other reserves' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.34' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.34.341' Logo_account_number, 'Current year profit/(loss)' Disclosure_line, 'Retained earnings/(Accumulated losses)' FS_line union all
select '3.34.342' Logo_account_number, 'Change in retained earnings' Disclosure_line, 'Retained earnings/(Accumulated losses)' FS_line union all
select '3.34.343' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.34.343.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.34.343.01.01' Logo_account_number, 'Retained earnings' Disclosure_line, 'Retained earnings' FS_line union all
select '3.34.344' Logo_account_number, 'Dividends declared' Disclosure_line, 'Dividends declared' FS_line union all
select '4' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.401' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.401.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.401.01.01' Logo_account_number, 'Short term loans' Disclosure_line, 'Loan and borrowings' FS_line union all
select '4.40.402' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.40.403' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.40.404' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.404.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.404.01.01' Logo_account_number, 'Long-term loans and borrowings from third parties' Disclosure_line, 'Long-term loans and borrowings' FS_line union all
select '4.40.405' Logo_account_number, 'Long-term recoverable preferred shares' Disclosure_line, 'Long-term recoverable preferred shares' FS_line union all
select '4.40.406' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.406.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.40.406.01.01' Logo_account_number, 'Long-term lease liabilities' Disclosure_line, 'Long-term lease liabilities' FS_line union all
select '4.40.407' Logo_account_number, 'Long-term loans and borrowings from group components' Disclosure_line, 'Long-term loans and borrowings' FS_line union all
select '4.40.408' Logo_account_number, 'Other borrowings' Disclosure_line, 'Other borrowings' FS_line union all
select '4.41' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.41.411' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.41.412' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.41.413' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.41.414' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.42' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.42.421' Logo_account_number, 'Deffered tax liability' Disclosure_line, 'Deffered tax liability' FS_line union all
select '4.42.422' Logo_account_number, 'Deffered tax liability' Disclosure_line, 'Deffered tax liability' FS_line union all
select '4.43' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.43.431' Logo_account_number, 'Long-term trade and other payables' Disclosure_line, 'Long-term trade and other payables' FS_line union all
select '4.43.432' Logo_account_number, 'Long-term payables to subsidairies' Disclosure_line, 'Long-term payables to subsidairies' FS_line union all
select '4.43.433' Logo_account_number, 'Contract liability' Disclosure_line, 'Contract liability' FS_line union all
select '4.43.434' Logo_account_number, 'Interest-bearing payables' Disclosure_line, 'Long -term trade and other payables' FS_line union all
select '4.43.435' Logo_account_number, 'Other payables' Disclosure_line, 'Long -term trade and other payables' FS_line union all
select '4.44' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.44.441' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '4.44.442' Logo_account_number, 'Long-term advance received' Disclosure_line, 'Long-term advance received' FS_line union all
select '4.44.443' Logo_account_number, 'Long-term advance received' Disclosure_line, 'Long-term advance received' FS_line union all
select '4.44.444' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.44.444.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '4.44.444.01.01' Logo_account_number, 'Long-term loans from shareholders' Disclosure_line, 'Loan and borrowings' FS_line union all
select '4.44.445' Logo_account_number, 'Other long-term liabilities' Disclosure_line, 'Other long-term liabilities' FS_line union all
select '5' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50.501' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50.501.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50.501.01.01' Logo_account_number, 'Short term loans' Disclosure_line, 'Loan and borrowings' FS_line union all
select '5.50.502' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.50.503' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.50.504' Logo_account_number, 'Short-term loans and borrowings from third parties' Disclosure_line, 'Short-term loans and borrowings' FS_line union all
select '5.50.505' Logo_account_number, 'Short-term recoverable preferred shares' Disclosure_line, 'Short-term recoverable preferred shares' FS_line union all
select '5.50.506' Logo_account_number, 'Interest-bearing loans and borrowings (short-term)' Disclosure_line, 'Interest-bearing loans and borrowings (short-term)' FS_line union all
select '5.50.507' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50.507.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.50.507.01.01' Logo_account_number, 'Short-term interest payable' Disclosure_line, 'Loan and borrowings' FS_line union all
select '5.50.507.01.02' Logo_account_number, 'Short-term interest payable' Disclosure_line, 'Loan and borrowings' FS_line union all
select '5.51' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.51.511' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.51.512' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.51.513' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.51.514' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.51.515' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.52' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.521' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.521.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.521.01.01' Logo_account_number, 'Other tax payables' Disclosure_line, 'Other current assets' FS_line union all
select '5.52.521.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.521.02.01' Logo_account_number, 'VAT Payable' Disclosure_line, 'Other current assets' FS_line union all
select '5.52.522' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.522.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.522.01.01' Logo_account_number, 'Social Security Protection Fund contribution' Disclosure_line, 'Other liabilities' FS_line union all
select '5.52.523' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.523.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.52.523.01.01' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.53' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.531' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.531.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.531.01.01' Logo_account_number, 'Trade payables - to local customers' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.531.01.02' Logo_account_number, 'Trade payables - to foreign customers' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.532' Logo_account_number, 'Trade and other payables - related parties' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.533' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.533.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.533.01.01' Logo_account_number, 'Payables to employees' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.533.01.02' Logo_account_number, 'Payables to employees' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.534' Logo_account_number, 'Trade and other payables to shareholder' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.535' Logo_account_number, 'Short-term lease liabilities' Disclosure_line, 'Short-term lease liabilities' FS_line union all
select '5.53.536' Logo_account_number, 'Short-term trade and other payables' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.537' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.537.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.537.01.01' Logo_account_number, 'Interest-bearing payables' Disclosure_line, 'Short-term trade and other payables' FS_line union all
select '5.53.538' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.538.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.53.538.01.01' Logo_account_number, 'Short-term other payables' Disclosure_line, 'Trade and other payables' FS_line union all
select '5.53.538.01.03' Logo_account_number, 'Short-term other payables' Disclosure_line, 'Trade and other payables' FS_line union all
select '5.54' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.54.541' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '5.54.542' Logo_account_number, 'Short-term advance received' Disclosure_line, 'Short-term advance received' FS_line union all
select '5.54.543' Logo_account_number, 'Short-term advance received' Disclosure_line, 'Short-term advance received' FS_line union all
select '5.54.543.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '5.54.543.01.01' Logo_account_number, 'Short-term advance received' Disclosure_line, 'Short-term advance received' FS_line union all
select '5.54.544' Logo_account_number, 'Short-term loans and borrowings' Disclosure_line, 'Short-term loans and borrowings' FS_line union all
select '5.54.545' Logo_account_number, 'Other short-term liabilities' Disclosure_line, 'Other short-term liabilities' FS_line union all
select '6' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.601' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.601.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.601.01.01' Logo_account_number, 'Cable product sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.02' Logo_account_number, 'Sandwich panel sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.03' Logo_account_number, 'Technical gases sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.04' Logo_account_number, 'Polymer product sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.05' Logo_account_number, 'Metal melting product sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.06' Logo_account_number, 'Aluminium products sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.07' Logo_account_number, 'Electric equipments sale' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.01.08' Logo_account_number, 'Other sales' Disclosure_line, 'Revenue' FS_line union all
select '6.60.601.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.601.02.01' Logo_account_number, 'Sales of other products' Disclosure_line, 'Other income' FS_line union all
select '6.60.602' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.602.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.602.01.01' Logo_account_number, 'Cable sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.02' Logo_account_number, 'Sandwich panel sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.03' Logo_account_number, 'Technical gases sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.04' Logo_account_number, 'Polymer product sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.05' Logo_account_number, 'Metal melting product sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.06' Logo_account_number, 'Aluminium products sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.07' Logo_account_number, 'Electric equipments sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.01.08' Logo_account_number, 'Other sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.602.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.602.02.01' Logo_account_number, 'Other sales return' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.603.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.603.01.01' Logo_account_number, 'Cable sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.02' Logo_account_number, 'Sandwich panel sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.03' Logo_account_number, 'Technical gases sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.04' Logo_account_number, 'Polymer products sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.05' Logo_account_number, 'Metal melting products sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.06' Logo_account_number, 'Aluminium products sales dicsount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.07' Logo_account_number, 'Electric equipment sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.01.08' Logo_account_number, 'Other sales discount' Disclosure_line, 'Revenue' FS_line union all
select '6.60.603.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.60.603.02.01' Logo_account_number, 'Other discount' Disclosure_line, 'Revenue' FS_line union all
select '6.61' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.61.611' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.61.611.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.61.611.01.01' Logo_account_number, 'Foreign exchange translation gains' Disclosure_line, 'General and administrative expenses ' FS_line union all
select '6.61.611.01.02' Logo_account_number, 'Revaluation gain/(loss)' Disclosure_line, 'Revaluation gain/(loss)' FS_line union all
select '6.61.611.01.03' Logo_account_number, 'Gain/(loss) on disposal' Disclosure_line, 'Gain/(loss) on disposal' FS_line union all
select '6.61.611.01.04' Logo_account_number, 'Gain from counts of inventory' Disclosure_line, 'Other income' FS_line union all
select '6.61.611.01.98' Logo_account_number, 'Other operating income' Disclosure_line, 'Other income' FS_line union all
select '6.62' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.62.621' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.63' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.63.631' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.63.631.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.63.631.01.01' Logo_account_number, 'Income due to hedging' Disclosure_line, 'Other income' FS_line union all
select '6.64' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '6.64.641' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.70' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.70.701' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.70.701.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.70.701.01.01' Logo_account_number, 'Cable products' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.02' Logo_account_number, 'Sandwich panel' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.03' Logo_account_number, 'Technical gases' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.04' Logo_account_number, 'Polymer products ' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.05' Logo_account_number, 'Metal melting products' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.06' Logo_account_number, 'Aluminium products' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.07' Logo_account_number, 'Electric equipments' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.01.08' Logo_account_number, 'Other products' Disclosure_line, 'Cost of sales' FS_line union all
select '7.70.701.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.70.701.02.01' Logo_account_number, 'Other income/(expenses)' Disclosure_line, 'Other income' FS_line union all
select '7.71' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.01.01' Logo_account_number, 'Staff expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.01.02' Logo_account_number, 'Staff expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.01.03' Logo_account_number, 'Vacation expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.02.01' Logo_account_number, 'Marketing expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.02.02' Logo_account_number, 'Research expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.02.03' Logo_account_number, 'Other marketing expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.03' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.03.01' Logo_account_number, 'Depreciation  expenses of buildings and premises' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.03.02' Logo_account_number, 'Depreciations expenses of equipments' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.03.03' Logo_account_number, 'Depreciations expenses of vehicles' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.03.04' Logo_account_number, 'Other depreciation expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.04' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.04.01' Logo_account_number, 'Amortization expenses of the software' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.05' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.05.01' Logo_account_number, 'Repair and maintenance expenses of buildings' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.05.02' Logo_account_number, 'Repair and maintenance expenses of equipment' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.05.03' Logo_account_number, 'Repair and maintenance expenses of vehicles' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.05.04' Logo_account_number, 'Repair and maintenance expenses of other assets' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.06' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.06.01' Logo_account_number, 'Transportation' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.06.02' Logo_account_number, 'Transportation' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.06.03' Logo_account_number, 'Fuel expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.06.99' Logo_account_number, 'Other logistic expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.07' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.07.01' Logo_account_number, 'Product certification' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.07.02' Logo_account_number, 'Transportation' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.07.03' Logo_account_number, 'Other expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.71.711.99.01' Logo_account_number, 'Export expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.02' Logo_account_number, 'IT expense' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.03' Logo_account_number, 'Utilities' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.04' Logo_account_number, 'Professional services' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.05' Logo_account_number, 'Bank fees' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.06' Logo_account_number, 'Tax expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.07' Logo_account_number, 'Staff expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.08' Logo_account_number, 'Insurance expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.09' Logo_account_number, 'Procurrement expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.11' Logo_account_number, 'Damaged materials' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.12' Logo_account_number, 'Export expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.14' Logo_account_number, 'Other income/(expenses)' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.23' Logo_account_number, 'Packaging expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.71.711.99.99' Logo_account_number, 'Other expenses' Disclosure_line, 'Cost of sales - overhead' FS_line union all
select '7.72' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.01.01' Logo_account_number, 'Salary and related expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.01.02' Logo_account_number, 'Salary and related expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.01.03' Logo_account_number, 'Business trips' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.01.04' Logo_account_number, 'Payroll indirect' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.01.05' Logo_account_number, 'Salary and related expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.02' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.02.01' Logo_account_number, 'Marketing expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.02.02' Logo_account_number, 'Marketing expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.02.03' Logo_account_number, 'Research expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.02.04' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.03' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.03.01' Logo_account_number, 'Depreciation  expenses of buildings and premises' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.03.02' Logo_account_number, 'Depreciations expenses of equipments' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.03.03' Logo_account_number, 'Depreciations expenses of vehicles' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.03.04' Logo_account_number, 'Other depreciation expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.04' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.04.01' Logo_account_number, 'Amortization expenses of the software' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.05' Logo_account_number, 'Repair and maintenance expenses of buildings' Disclosure_line, '' FS_line union all
select '7.72.721.05.01' Logo_account_number, 'Repair and maintenance expenses of buildings' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.05.02' Logo_account_number, 'Repair and maintenance expenses of equipment' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.05.03' Logo_account_number, 'Repair and maintenance expenses of vehicles' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.05.04' Logo_account_number, 'Repair and maintenance expenses of other assets' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.06' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.06.01' Logo_account_number, 'Transportation' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.06.02' Logo_account_number, 'Transportation' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.06.03' Logo_account_number, 'Fuel expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.06.99' Logo_account_number, 'Other logistic expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.07' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.07.01' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.07.02' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.07.03' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.07.04' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.77.01' Logo_account_number, 'Transportation' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.02' Logo_account_number, 'Canteen (shared services)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.03' Logo_account_number, 'Security (shared services)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.04' Logo_account_number, 'Energy support (shared services)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.05' Logo_account_number, 'SCIP rent' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.06' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.07' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.08' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.09' Logo_account_number, 'Rent expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.10' Logo_account_number, 'Rent expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.11' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.12' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.77.13' Logo_account_number, 'IT expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.78' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.78.01' Logo_account_number, 'Utilities' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.78.02' Logo_account_number, 'Utilities' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.78.03' Logo_account_number, 'Utilities' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.78.04' Logo_account_number, 'Depreciation and amortisation' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.72.721.99.01' Logo_account_number, 'Rent expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.02' Logo_account_number, 'IT expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.03' Logo_account_number, 'Utilities' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.04' Logo_account_number, 'Professional charges' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.05' Logo_account_number, 'Commission fee' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.06' Logo_account_number, 'Tax expenses other than income tax' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.07' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.08' Logo_account_number, 'Insurance expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.09' Logo_account_number, 'Stationary expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.10' Logo_account_number, 'Rent expense' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.11' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.12' Logo_account_number, 'Export expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.13' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.14' Logo_account_number, 'Auxiliary production costs' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.15' Logo_account_number, 'Other income/(expenses)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.15' Logo_account_number, 'Other income/(expenses)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.15' Logo_account_number, 'Other income/(expenses)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.16' Logo_account_number, 'Meal expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.17' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.18' Logo_account_number, 'Security expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.19' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.20' Logo_account_number, 'Residental expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.21' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.22' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.23' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.99' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.99' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.72.721.99.99' Logo_account_number, 'Other expenses' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.73' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.73.731' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.73.731.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.73.731.01.01' Logo_account_number, ' Foreign exchange translation gains less losses/(losses less gains)' Disclosure_line, 'General and Administrative expenses' FS_line union all
select '7.73.731.01.02' Logo_account_number, 'Revaluation gain/loss' Disclosure_line, 'Revaluation gain/loss' FS_line union all
select '7.73.731.01.03' Logo_account_number, 'Gain on disposal' Disclosure_line, 'Gain on disposal' FS_line union all
select '7.73.731.01.04' Logo_account_number, 'Other expenses' Disclosure_line, 'General and administrative expenses ' FS_line union all
select '7.74' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.74.741' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.75' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.75.751' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.75.751.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.75.751.01.01' Logo_account_number, 'Interest expense' Disclosure_line, 'Finance cost' FS_line union all
select '7.76' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '7.76.761' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '8' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '8.80' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '8.80.801' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '8.81' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '8.81.811' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '9' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '9.90' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '9.90.901' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '9.90.902' Logo_account_number, '' Disclosure_line, '' FS_line 
)
, plant as(

select N'STP Inzibati' plants_logo, N'STP Head Office' plant union all
select N'KZ (Kabel Zavod)' plants_logo, N'Cable' plant union all
select N'PMZ (Polimer Memulatlar Zavodu)' plants_logo, N'Polymer' plant union all
select N'SPZ (Sendvic Paneller Zavodu)' plants_logo, N'Sandwich' plant union all
select N'MZ (Metaleritme Zavodu)' plants_logo, N'Metalsmelting' plant union all
select N'EAZ (Elektrik Avadanliqlar Zavodu)' plants_logo, N'Electric Equipments' plant union all
select N'AOZ (Antikorroziya)' plants_logo, N'Non-conveyor' plant union all
select N'QQZ-MEZ (Qaynaq Qurasdirma-Mexaniki emal)' plants_logo, N'Non-conveyor' plant union all
select N'AMPZ (Alum. Ve Mis Profiller Zavodu)' plants_logo, N'Al profiles' plant union all
select N'TQZ (Texniki Qazlar Zavodu)' plants_logo, N'Technical Gases' plant union all
select N'Secim edin' plants_logo, N'Al profiles' plant union all
select N'STP ALuminium Inzibati' plants_logo, N'Al profiles' plant union all
select N'STP Global Cable Inzibati' plants_logo, N'Cable' plant union all
select N'STP ALuminium İnzibati' plants_logo, N'Al profiles' plant union all
select N'12.01 FG RM TQZ Anbari' plants_logo, N'Technical Gases' plant union all
select N'02.01 FG AMPZ Hazir Mehsul Anbari' plants_logo, N'Al profiles' plant union all
select N'12.01 Texniki qazlar' plants_logo, N'Technical Gases' plant union all
select N'Alüminium Profillər istehsalı sahəsi' plants_logo, N'Al profiles' plant union all
select N'Toz boya sahəsi' plants_logo, N'Al profiles' plant union all
select N'Əritmə və homogenizasiya sahəsi' plants_logo, N'Al profiles' plant union all
select N'Alüminium Profillər istehsali sahəsi' plants_logo, N'Al profiles' plant union all
select N'02.01 RM AMPZ Xammal ve Material Anbari' plants_logo, N'Al profiles' plant union all
select N'Qarantin Anbarı' plants_logo, N'Al profiles' plant union all
select N'Ehtiyat hissə anbarı' plants_logo, N'Al profiles' plant union all
select N'Karantin Anbarı' plants_logo, N'Al profiles' plant union all
select N'Təmir və texniki xidmət ' plants_logo, N'Al profiles' plant union all
select N'İnzibati' plants_logo, N'Al profiles' plant union all
select N'Ehtiyat hissə anbarı' plants_logo, N'Al profiles' plant union all
select N'02.01 RM AMPZ Xammal ve Material Anbari' plants_logo, N'Al profiles' plant union all
select N'AMPZ Esas Vesait Anbari' plants_logo, N'Al profiles' plant union all
select N'12.01 Texniki qazlar' plants_logo, N'Technical Gases' plant union all
select N'12.01 FG RM TQZ Anbari' plants_logo, N'Technical Gases' plant union all
select N'Toz boya sahəsi' plants_logo, N'Al profiles' plant union all
select N'Alüminium Profillər istehsalı sahəsi' plants_logo, N'Al profiles' plant union all
select N'Əritmə və homogenizasiya sahəsi' plants_logo, N'Al profiles' plant union all
select N'Karantin Anbarı' plants_logo, N'Al profiles' plant union all
select N'İnzibati' plants_logo, N'Al profiles' plant union all
select N'TQZ Hazir məhsul anbarı' plants_logo, N'Technical Gases' plant union all
select N'TQZ Xammal və material anbari' plants_logo, N'Technical Gases' plant union all
select N'TQZ Esas Vesait Anbari' plants_logo, N'Technical Gases' plant union all
select N'Paketləmə və qablaşdırma sahəsi' plants_logo, N'Al profiles' plant union all
select N'Dərnəgül Satış Mərkəzi' plants_logo, N'Al profiles' plant union all
select N'TQZ Hazir məhsul anbari' plants_logo, N'Technical Gases' plant  

)

, src1 as(
select src.*, plant.plant
from src
left join plant on plant.plants_logo=src.is_yeri

)
, cl as(
select *
from 

(
select
  t.Logo_account_number
, b.typ1
, b.typ2
, t.Disclosure_line
, t.FS_line

, case when uz=1 then 'Main' when  uz<lead(uz) over(order by Logo_account_number)  then 'Other' else 'Sub' end account_type
from ( select *, LEN(ac.Logo_account_number) uz from ac  ) t
left join balance b on b.acn=left(t.Logo_account_number,1)
 
)c
)


,



t as(
 
 select 
  t.comp
, t.[Hesab Kodu]
, t.plant
, t.Tarix
, t.Total_debt-t.Total_kredit Amount
 from (
 select
   t.comp
 , t.[Hesab Kodu]
 , t.plant
 , eomonth(t.Tarix)  Tarix
 , round( sum(iif(t.Tarix>=@gl_db , t.Debit, 0)),4) Total_debt
 , round( sum(iif(t.Tarix>=@gl_db , t.Kredit, 0)),4) Total_kredit
 from src1 t
 
 group by t.[Hesab Kodu], eomonth(t.Tarix), t.plant, t.comp
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
 
 , r as(
 select   t1.comp
 , isnull(cl.typ1, balance.typ1) typ1
 , isnull(cl.typ2, balance.typ2) typ2
 , cl.Disclosure_line
 , cl.FS_line
 , t1.plant
 , sum(Amount) amount
 --, t1.Tarix
 , year(t1.Tarix) il
 , month(t1.Tarix) ay
 from t1 
left join cl on t1.[Hesab Kodu]=cl.Logo_account_number
left join balance on balance.acn=left(t1.[Hesab Kodu],1)
where year(t1.Tarix) =@il
group by t1.comp,  isnull(cl.typ1, balance.typ1) , isnull(cl.typ2, balance.typ2), cl.Disclosure_line, cl.FS_line, t1.plant, t1.Tarix
 )

 select * 
 from r
pivot(
sum(amount)
for ay in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) pv