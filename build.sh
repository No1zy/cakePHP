#!bin/sh

docker-compose up -d 
#docker exec -it $(docker-compose ps -q cakedb) mysql -u root -e "CREATE USER 'root'@'%';"

docker exec -it $(docker-compose ps -q cakedb) mysql -u root -e "grant all privileges on *.* to root@'%' with grant option;"

