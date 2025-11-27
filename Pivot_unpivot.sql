declare @il int=year( dateadd(month, -1, getdate()))
declare @comp nvarchar(max)='STP AMPZ'--'STP QQZ'--'STP PMZ'--'STP KZ'--'STP AMPZ'--'STP AH' --'STP MMC'  


 --'STP QQZ'--'STP PMZ'--'STP KZ'--'STP AMPZ'--'STP AH' --'STP MMC' 
;with maliyet as(
  SELECT 
'STP MMC' Comp
,  STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]	       
, convert(date, STFIC.DATE_) Tarih 
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý] 
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]
, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2
 
WHERE STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

and @comp in ('STP MMC')
 
 union all

  SELECT 
'STP AH' Comp
,  STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]
, convert(date, STFIC.DATE_) Tarih
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý]
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]

, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3_AH].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3_AH].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3_AH].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3_AH].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2
 
WHERE STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

and @comp in ('STP AH') 

 union all

  SELECT 
'STP AMPZ' Comp
, STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]
, convert(date, STFIC.DATE_) Tarih
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý]
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]
, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3_AMPZ].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3_AMPZ].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3_AMPZ].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3_AMPZ].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2
                          
WHERE STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

and @comp in ('STP AMPZ')

--AND STFIC.FICHENO in ('SQ.0107.24.0013','UG.0103.24.0002')


 union all


  SELECT 
'STP KZ' Comp
,  STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]
, convert(date, STFIC.DATE_) Tarih
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý]
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]
, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3_KZ].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3_KZ].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3_KZ].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3_KZ].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2
 
WHERE STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

and @comp in ('STP KZ')

 union all

  SELECT 
'STP PMZ' Comp
,  STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]
, convert(date, STFIC.DATE_) Tarih
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý]
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]
, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3_PMZ].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3_PMZ].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3_PMZ].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3_PMZ].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2
 
WHERE STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

 

and @comp in ('STP PMZ') 

 union all

  SELECT 
'STP QQZ' Comp
, STRNS.LOGICALREF STRNS_LOGICALREF
, STFIC.LOGICALREF STFIC_LOGICALREF
, ITMSC.CODE [Malzeme (Sýnýfý) Kodu]
, convert(date, STFIC.DATE_) Tarih
, round(iif(  STRNS.IOCODE>2,  STRNS.TOTAL,0),2)   [Çýkýþ Mal Tutarý]
, round(iif(  STRNS.IOCODE<3,  STRNS.TOTAL,0),2)  [Giren Mal Tutarý]
, wh_src.NAME [Çýkýþ Ambarý]
, iif(  STRNS.IOCODE>2,  STRNS.Amount,0)  [Çýkýþ Miktarý]
, iif(  STRNS.IOCODE<3,  STRNS.Amount,0) [Giren Miktar]
, iif(STFIC.TRCODE=13,'Production', 'Sales') Type_

FROM        [172.16.1.48].[TGR3_QQZ].dbo.LG_001_01_STFICHE STFIC
inner join  [172.16.1.48].[TGR3_QQZ].dbo.LG_001_01_STLINE STRNS ON STRNS.STFICHEREF = STFIC.LOGICALREF
inner join  [172.16.1.48].[TGR3_QQZ].dbo.LG_001_ITEMS ITMSC ON STRNS.STOCKREF = ITMSC.LOGICALREF
left join   [172.16.1.48].[TGR3_QQZ].dbo.L_CAPIWHOUSE wh_src  on wh_src. COSTGRP=STRNS.SOURCECOSTGRP   and wh_src. FIRMNR=1 and STRNS.IOCODE>2

WHERE
1=1  
and STRNS.EXIMFCTYPE not IN (1, 6)
AND (STRNS.EXIMFCTYPE <> 7 OR STRNS.IOCODE = 2)
AND STFIC.PRODSTAT = 0
AND STFIC.DEVIR <> 3
AND ITMSC.CARDTYPE <> 22
AND year(STRNS.DATE_)=@il 
AND STRNS.CANCELLED = 0
and STFIC.TRCODE  in (3, 8, 13)

and @comp in ('STP QQZ') 
 
 ) 

 select 
 'Actual' [Actual/Budget]
, Comp	
, 'Implementation plan' t1
, Type_	 t2
, Category t3

, DN	
, FS_Line	
, [Plant category]	

 , Year_ 
, [1]  as [Jan]
, [2]  as [Feb]
, [3]  as [Mar]
, [4]  as [Apr]
, [5]  as [May]
, [6]  as [Jun]
, [7]  as [Jul]
, [8]  as [Aug]
, [9]  as [Sep]
, [10] as [Oct]
, [11] as [Nov]
, [12] as [Dec]

 from (

 select *
 from (
 select 
  t.Comp
, year(t.Tarih) Year_
, month(t.Tarih) Month_
, iif(t.Type_='Sales', [Çýkýþ Mal Tutarý], t.[Giren Mal Tutarý]) [Amount]
, iif(t.Type_='Sales', t.[Çýkýþ Miktarý] , t.[Giren Miktar]*pr.KG )   [Quantity]
, t.Type_
, iif(t.Type_='Sales', s.Group_,pr.Name_for_reporting) [DN]
, '' FS_Line
, iif(t.Type_='Sales', p.PlantName,'') [Plant category]
from maliyet t
LEFT join DWH.dbo.Plant p on DWH.DBO.azh(p.PlantLogoName)=DWH.DBO.azh(t.[Çýkýþ Ambarý]) collate SQL_Latin1_General_CP1_CI_AS
left join DWH.dbo.Classification_for_Sales s on s.ProductCode=t.[Malzeme (Sýnýfý) Kodu] collate SQL_Latin1_General_CP1_CI_AS
left join DWH.dbo.Classification_for_Production pr on pr.Code=t.[Malzeme (Sýnýfý) Kodu] collate SQL_Latin1_General_CP1_CI_AS
) t 
UNPIVOT
(
    [Value_] FOR Category IN (Amount, Quantity)
) AS unpvt
) t
pivot(
sum(Value_)
for Month_ in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) pv



