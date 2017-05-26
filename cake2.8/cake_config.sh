#!/bin/sh
CONTENTS_DIR='cakephp'

MYSQL_ID='root'
MYSQL_PASSWORD=''
MYSQL_HOST='172.20.0.2'
MYSQL_DATABASE_NAME='cake'

chmod -R 777 $CONTENTS_DIR/app/webroot
chmod -R 777 $CONTENTS_DIR/app/tmp
sed -i -e "s/\/\/date_default_timezone_set('\(.*\)')/date_default_timezone_set('Asia\/Tokyo')/" $CONTENTS_DIR/app/Config/core.php
sed -i -e "s/\/\/Configure::write('Security.salt', '\(.*\)')/Configure::write('Security.salt', 'DYhGsss93b0qyJfIxfs2guVoUubWwvniR2G0FgaC9mi')/" $CONTENTS_DIR/app/Config/core.php

sed -i -e "s/\/\/Configure::write('Security.cipherSeed', '\(.*\)')/Configure::write('Security.cipherSeed', '7682359309657453542496749683645')/" $CONTENTS_DIR/app/Config/core.php

cp $CONTENTS_DIR/app/Config/database.php.default $CONTENTS_DIR/app/Config/database.php

sed -i -e "s/'login' => '\(.*\)'/'login' => '$MYSQL_ID'/" $CONTENTS_DIR/app/Config/database.php

sed -i -e "s/'password' => '\(.*\)'/'password' => '$MYSQL_PASSWORD'/" $CONTENTS_DIR/app/Config/database.php

sed -i -e "s/'database' => '\(.*\)'/'database' => '$MYSQL_DATABASE_NAME'/" $CONTENTS_DIR/app/Config/database.php

sed -i -e "s/'host' => '\(.*\)'/'host' => '$MYSQL_HOST'/" $CONTENTS_DIR/app/Config/database.php
sed -i -e "s/\/\/'encoding'/'encoding'/" $CONTENTS_DIR/app/Config/database.php
