#!/bin/sh

systemctl start mariadb

mysql -u root -e "grant all privilege on *.* to root@'%' with grant option;"
