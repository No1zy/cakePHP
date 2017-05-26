#!bin/sh

DOCUMENT_ROOT='/var/www/html'
CONTENTS_DIR='cakephp'

echo \
"<Directory \"/$DOCUMENT_ROOT/$CONTENTS_DIR\">
	Options FollowSymLinks
    AllowOverride All
</Directory>" > /etc/httpd/conf.d/cakephp.conf
