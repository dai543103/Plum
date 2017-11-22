echo off

if [%1] == [] (
	echo "please input a dbname"	
) else (
	set dbname=%1	
	echo "create database %dbname% begin......."
	mysql -uroot -p123456 -hlocalhost -e "CREATE DATABASE IF NOT EXISTS %dbname% DEFAULT CHARSET utf8"
	echo "create database %dbname% finish......."

	echo "create table from dmr.sql begin......."
	mysql -uroot -p123456 -hlocalhost -D%dbname% < ./dmr.sql
	echo "create table from dmr.sql finish......."

	echo "update table from update.sql begin......."
	mysql -uroot -p123456 -hlocalhost -D%dbname% < ./update.sql
	echo "update table from update.sql finish......."	
)
