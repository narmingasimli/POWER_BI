/*
create table HR01.Person04
(id int,
name char(30),
salary float,
address char(150),
B_date date
);
go
*/

/* select * from HR01.Person04; */

select GETDATE();

insert into
	HR01.Person04
values
(14, 'Sona', 980, 'Baku', '2024-11-04 10:18:26.493'),
(15, 'Tural', 980, 'Baku', '2024-11-04 10:18:26.493'),
(16, 'Aise', 980, 'Baku', '2024-11-04 10:18:26.493'),
(17, 'Nermin', 980, 'Baku', '2024-11-04 10:18:26.493'),
(18, 'Aysel', 980, 'Baku', '2024-11-04 10:18:26.493'),
(19, 'Mehemmed', 980, 'Baku', '2024-11-04 10:18:26.493')

insert into
	HR01.Person04
values
(18, 'Sona', 980, 'Baku', '2024-11-04 10:18:26.493')

select  
	* 
from 
	HR01.Person04;


insert into
	HR01.Person01
values
(18, 'Sona')

select  
	* 
from 
	HR01.Person01;
