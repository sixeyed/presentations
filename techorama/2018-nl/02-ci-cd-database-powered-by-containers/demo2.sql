-- create database from scratch
/* 
<<<<<<< HEAD
CREATE DATABASE d2 ON (FILENAME = 'C:\data\d2.mdf'), (FILENAME = 'C:\data\d2.ldf')
=======
CREATE DATABASE d2 
ON (NAME='d2', FILENAME = 'C:\data\d2.mdf') 
LOG ON (NAME='d2_log', FILENAME = 'C:\data\d2.ldf')
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
/*

-- deploy data
/*
use d2

create table t1 (id nvarchar(20))

insert into t1(id) values('a1')

select * from t1
*/

<<<<<<< HEAD

-- attach database
-- create database from scratch
/* 
CREATE DATABASE d2 ON (FILENAME = 'C:\data\d2.mdf'), (FILENAME = 'C:\data\d2.ldf')
=======
-- check databases
/*
select name, physical_name from sys.master_files
*/

-- attach database
/* 
CREATE DATABASE d2 
ON (FILENAME = 'C:\data\d2.mdf'), (FILENAME = 'C:\data\d2.ldf')
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
FOR ATTACH
/*

/*
use d2

select * from t1
*/
