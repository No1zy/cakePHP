#!bin/sh

MYSQL_DATABASE_NAME='cake'
docker-compose up -d 
docker exec -it $(docker-compose ps -q cakedb) mysql -u root -e "create database $MYSQL_DATABASE_NAME;"
docker exec -it $(docker-compose ps -q cakedb) mysql -u root -e "grant all privileges on *.* to root@'%' with grant option;"

