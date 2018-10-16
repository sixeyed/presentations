-- create database from scratch
/* 
CREATE DATABASE d1
/*

-- deploy data
/*
use d1
 
create table t1 (id nvarchar(20))

insert into t1(id) values('a1')

select * from t1
*/

-- check file locations

/*
select name, physical_name from sys.master_files
*/