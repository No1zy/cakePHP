#!/bin/sh
DOCUMENT_ROOT='/var/www/html'
APP_DIR='cake'
DB_USER='root'
DB_NAME='test'
DB_PASSWORD=''

yum update -y
yum install -y epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi,remi-php70 php php-devel php-mbstring php-ldap php-mysql php-pdo php-gd php-cli php-opcache php-mcrypt php-intl
yum install -y mysql mariadb-server httpd git

systemctl enable httpd
systemctl enable mariadb
systemctl start httpd
systemctl start mariadb

#cakephp インストール
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
mkdir $DOCUMENT_ROOT/$APP_DIR

echo "Y" | composer create-project --prefer-dist cakephp/app $DOCUMENT_ROOT/$APP_DIR


firewall-cmd --add-service=http --permanent
firewall-cmd --reload
#disable SElinux
setenforce 0
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#cakeの設定
sed -i -e "s/\/\/date_default_timezone_set('\(.*\)')/date_default_timezone_set('Asia\/Tokyo')/" $DOCUMENT_ROOT/$APP_DIR/config/bootstrap.php


#config/app.php
#	Datasourcesのところ
#	'username' => 'root',
#	'password' => '',
#	'database' => 'test',
#	'timezone' => 'Asia/Tokyo',

cp $DOCUMENT_ROOT/$APP_DIR/config/app.default.php $DOCUMENT_ROOT/$APP_DIR/config/app.php
sed -ie "232 s/my_app/$DB_USER/" $DOCUMENT_ROOT/$APP_DIR/config/app.php
sed -ie "233 s/secret/$DB_PASSWORD/" $DOCUMENT_ROOT/$APP_DIR/config/app.php
sed -ie "234 s/my_app/$DB_NAME/" $DOCUMENT_ROOT/$APP_DIR/config/app.php
sed -ie "236 s/UTC/Asia\/Tokyo/" app.php

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u $DB_USER





-rw-r--r--.  1 root root   964  5月 20 15:58 README.md
drwxr-xr-x.  2 root root    50  5月 20 15:58 bin
-rw-r--r--.  1 root root  1206  5月 20 15:58 composer.json
-rw-r--r--.  1 root root 67444  5月 20 15:58 composer.lock
drwxr-xr-x.  3 root root   155  5月 20 16:03 config
-rw-r--r--.  1 root root   648  5月 20 15:58 index.php
drwxr-xr-x.  2 root root    19  5月 20 15:58 logs
-rw-r--r--.  1 root root  1139  5月 20 15:58 phpunit.xml.dist
drwxr-xr-x.  2 root root    19  5月 20 15:58 plugins
drwxr-xr-x.  8 root root    93  5月 20 15:58 src
drwxr-xr-x.  4 root root    58  5月 20 15:58 tests
drwxr-xr-x.  5 root root    48  5月 20 15:58 tmp
drwxr-xr-x. 19 root root  4096  5月 20 15:58 vendor
drwxr-xr-x.  5 root root    91  5月 20 15:58 webroot
