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
yum install -y mysql mariadb-server httpd git vim

systemctl enable httpd
systemctl enable mariadb
systemctl start httpd
systemctl start mariadb

#cakephp インストール
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
mkdir $DOCUMENT_ROOT/$APP_DIR

composer create-project --prefer-dist cakephp/app $DOCUMENT_ROOT/$APP_DIR <<EOS
Y
Y
EOS

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
sed -ie "236 s/UTC/Asia\/Tokyo/" $DOCUMENT_ROOT/$APP_DIR/config/app.php
sed -ie "s/__SALT__/hogefugavar/" $DOCUMENT_ROOT/$APP_DIR/config/app.php
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u $DB_USER mysql

