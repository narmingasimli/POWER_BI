 select 
    c.id as TableCommon,
    t.id as TableTeacher,
    s.id as TableSubject,
    s.name_ as SubjectName,
    t.name_ as TeacherName2
from 
    university_HR02.Common2 as c
LEFT JOIN university_HR02.Teacher2 as t on c.t_id = t.id
LEFT JOIN university_HR02.Subject as s on c.s_id = s.id 

union all

select 
    null as TableCommon,
    t.id as TableTeacher,
    null as TableSubject,
    null as SubjectName,
    t.name_ as TeacherName2
    --,cast( GETDATE() as date) AS CurrentDate,     cast(GETDATE() as time) AS CurrentTime
from 
	university_HR02.Teacher2 as t
where
	t.id not in (select c.t_id  from university_HR02.Common2 as c )

union all

select 
    null as TableCommon,
    -- c.t_id as CommonTeacher,
    -- c.s_id as CommonSubject,
    null as TableTeacher,
    s.id as TableSubject,
    s.name_ as SubjectName,
    null as TeacherName2
    --,cast( GETDATE() as date) as CurrentDate,     cast(GETDATE() as time) as CurrentTime
from 
	university_HR02.Subject as s
where
	s.id not in (select c.s_id  from university_HR02.Common2 as c )

--------------------------------------------------------------------------------------

select 
    c.id as TableCommon,
    t.id as TableTeacher,
    s.id as TableSubject,
    s.name_ as SubjectName,
    t.name_ as TeacherName2
from 
    university_HR02.Common2 c
LEFT JOIN university_HR02.Teacher2 t on c.t_id = t.id
LEFT JOIN university_HR02.Subject s on c.s_id = s.id

union all

select 
    NULL, 
	t.id, 
	NULL, 
	NULL, 
	t.name_
from 
    university_HR02.Teacher2 t
where 
    t.id NOT IN (select c.t_id from university_HR02.Common2 c)

union all

select 
    NULL, 
	NULL, 
	s.id, 
	s.name_, 
	NULL
from 
    university_HR02.Subject s
where 
    s.id NOT IN (select c.s_id from university_HR02.Common2 c);

--------------------------------------------------------------------------------------
select 
    c.id as TableCommon,
    t.id as TableTeacher,
    s.id as TableSubject,
    s.name_ as SubjectName,
    t.name_ as TeacherName2
from 
    university_HR02.Common2 c
LEFT JOIN university_HR02.Teacher2 t on c.t_id = t.id
LEFT JOIN university_HR02.Subject s on c.s_id = s.id

union all

select 
    null, 
	t.id, 
	null, 
	null, 
	t.name_
from 
    university_HR02.Teacher2 t
where 
    not exists (select 1 from university_HR02.Common2 c where c.t_id = t.id)

union all

select 
    null, 
	null, 
	s.id, 
	s.name_, 
	null
from 
    university_HR02.Subject s
where 
    not exists (select 1 from university_HR02.Common2 c where c.s_id = s.id);


--------------------------------------------------------------------------------------------
select
	case when c.id is not null then c.id end as TableCommon,
    t.id as TableTeacher,
    s.id as C,
    s.name_ as SubjectName,
    t.name_ as TeacherName2
from
	university_HR02.Common2 as c
FULL OUTER JOIN university_HR02.Teacher2 as t on c.t_id = t.id
FULL OUTER JOIN university_HR02.Subject as s on c.s_id = s.id;

-------------------------------ID getir-------------------------------------------------------------

select
	case when c.id is not null then c.id end as TableCommon,
    case when t.id is not null then t.id end as TableTeacher,
	case when s.id is not null then s.id end as TableTeacher
	
from
	university_HR02.Common2 as c
FULL OUTER JOIN university_HR02.Teacher2 as t on c.t_id = t.id
FULL OUTER JOIN university_HR02.Subject as s on c.s_id = s.id;

---------------------------ID getir ve name-leri getir-----------------------------------------------------------------

select
	case when c.id is not null then c.id end as TableCommon,
    case when t.id is not null then t.id end as TableTeacher,
	case when s.id is not null then s.id end as TableTeacher,
	s.name_ as SubjectName,
    t.name_ as TeacherName2
from
	university_HR02.Common2 as c
FULL OUTER JOIN university_HR02.Teacher2 as t on c.t_id = t.id
FULL OUTER JOIN university_HR02.Subject as s on c.s_id = s.id;

----------------------else ile NULL yerine 0 yaz---------------------------------------------------------------
select
	case when c.id is not null then c.id else 0 end as TableCommon,
    case when t.id is not null then t.id else 0 end as TableTeacher,
	case when s.id is not null then s.id else 0 end as TableTeacher,
	s.name_ as SubjectName,
    t.name_ as TeacherName2
from
	university_HR02.Common2 as c
FULL OUTER JOIN university_HR02.Teacher2 as t on c.t_id = t.id
FULL OUTER JOIN university_HR02.Subject as s on c.s_id = s.id;

----------------------else ile NULL yerine 0 yaz---------------------------------------------------------------

select
	case when c.id is not null then c.id else 0 end as TableCommon,
    case when t.id is not null then t.id else 0 end as TableTeacher,
	case when s.id is not null then s.id else 0 end as TableTeacher,
	case when s.name_ is not null then s.name_ else '0' end as SubjectName,
    case when t.name_ is not null then t.name_ else '0' end as TeacherName2
from
	university_HR02.Common2 as c
FULL OUTER JOIN university_HR02.Teacher2 as t on c.t_id = t.id
FULL OUTER JOIN university_HR02.Subject as s on c.s_id = s.id;

-------------------------------------------------------------------------------------------------------------------
