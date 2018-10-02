-- create database from scratch
/* 
CREATE DATABASE d2 
ON (NAME='d2', FILENAME = 'C:\data\d2.mdf') 
LOG ON (NAME='d2_log', FILENAME = 'C:\data\d2.ldf')
/*

-- deploy data
/*
use d2

create table t1 (id nvarchar(20))

insert into t1(id) values('a1')

select * from t1
*/

-- check databases
/*
select name from sys.databases
*/

-- attach database
/* 
CREATE DATABASE d2 
ON (FILENAME = 'C:\data\d2.mdf'), (FILENAME = 'C:\data\d2.ldf')
FOR ATTACH
/*

/*
use d2

select * from t1
*/
