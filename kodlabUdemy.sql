----------------DB yarat----------------
create database customer
go
--------------Persons Table yarat----------------
create table persons
	(
		persons_id int primary key identity, ---idendity otomatik artan---
		fin char(7) not null unique, ---unique eynisinde 1 kisi yoxdur, yalniz 1 kiside ola biler---
		namesurname nvarchar(90),
		adress varchar(max),
		phonenumber char(10) not null unique
	)
--------------Device Table yarat----------------
create table device
	(
		device_id int primary key identity, 
		brand nvarchar(100),
		model nvarchar(100),
		garanty bit default  0,
		problem varchar(max)
	)
--------------Persons Table yarat----------------
create table testing
	(
		testing_id int primary key,
		reached_date datetime,
		entry_date datetime default getdate(),
	)
 