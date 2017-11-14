#!/bin/bash
if [ $# != 1 ]; then 
	echo "please input db name" 
	exit 1;
fi
dbname=$1
mysql -uroot -p123456 -hlocalhost -e "CREATE DATABASE IF NOT EXISTS $dbname DEFAULT CHARSET utf8 COLLATE utf8_general_ci"
mysql -uroot -p123456 -hlocalhost -D $dbname < ./dmr.sql
mysql -uroot -p123456 -hlocalhost -D $dbname < ./update.sql
