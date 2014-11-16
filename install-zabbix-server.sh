#!/bin/bash
# Script nay dung de cai dat zabbix 2.2 tren Ubuntu Server 14.04

# Cac bien moi truong, ban co the tu khai bao hoac dung mac dinh nhu hinh duoi
IP_Zabbix_server=`/sbin/ifconfig eth1 | awk '/inet addr/ {print $2}' | cut -f2 -d ":" `
Mysql_pass='Admin123'
Mysql_host='localhost'
Mysql_port='3306'
Zabbix_db='zabbixdb'
Zabbix_user='zabbixuser'
Zabbix_pass='zabbixpass'

echo 'Cai dat zabbix tren ubuntu server 14.04'

echo "127.0.0.1	localhost" >> /etc/hosts
echo "deb http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main" >> /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main" >> /etc/apt/sources.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C407E17D5F76A32B

# cai dat cac goi
echo "Cai dat cac goi"
echo "Trong qua trinh cai dat, hay uong 1 tach tra nhe :))"
sleep 7

apt-get update -y

echo mysql-server mysql-server/root_password password $Mysql_pass | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $Mysql_pass | debconf-set-selections

apt-get install -y zabbix-server-mysql php5-mysql zabbix-frontend-php

# sua file cau hinh zabbix
echo "Sua file cau hinh zabbix"
sleep 7

filezabbix=/etc/zabbix/zabbix_server.conf
test -f $filezabbix.bka || cp $filezabbix $filezabbix.bka

cat << EOF > $filezabbix
LogFile=/var/log/zabbix-server/zabbix_server.log
PidFile=/var/run/zabbix/zabbix_server.pid
DBHost=localhost
DBName=$Zabbix_db
DBUser=$Zabbix_user
DBPassword=$Zabbix_pass
AlertScriptsPath=/etc/zabbix/alert.d/
FpingLocation=/usr/bin/fping
EOF

cat << EOF | mysql -uroot -p$Mysql_pass
DROP DATABASE IF EXISTS $Zabbix_db;
#
CREATE DATABASE $Zabbix_db;
GRANT ALL PRIVILEGES ON $Zabbix_db.* TO '$Zabbix_user'@'$Mysql_host' IDENTIFIED BY '$Zabbix_pass';
#
FLUSH PRIVILEGES;
EOF

# Tao bang database
echo "Import cac database"
sleep 5

cd /usr/share/zabbix-server-mysql/
gunzip *.gz
mysql -u $Zabbix_user -p$Zabbix_pass $Zabbix_db < schema.sql
mysql -u $Zabbix_user -p$Zabbix_pass $Zabbix_db < images.sql
mysql -u $Zabbix_user -p$Zabbix_pass $Zabbix_db < data.sql
cd

# sua file cau hinh apache
echo "Sua file cau hinh apache"
sleep 5

apacheconf=/etc/php5/apache2/php.ini
test -f $apacheconf.bka || cp $apacheconf $apacheconf.bka

sed -i 's/post_max_size = 8M/post_max_size = 16M/g' $apacheconf
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' $apacheconf
sed -i 's/max_input_time = 60/max_input_time = 300/g' $apacheconf
sed -i 's/;date.timezone =/date.timezone = Asia/Ho_Chi_Minh/g' $apacheconf

#cd
cp /usr/share/doc/zabbix-frontend-php/examples/zabbix.conf.php.example /etc/zabbix/zabbix.conf.php

#sed -i 's/$DB["DATABASE"]                 = 'zabbix'/$DB['DATABASE'] = $Zabbix_db/g' /etc/zabbix/zabbix.conf.php
#sed -i 's/$DB["USER"]                     = 'zabbix'/$DB['USER'] = $Zabbix_user/g' /etc/zabbix/zabbix.conf.php
#sed -i 's/$DB["PASSWORD"]                 = 'zabbix_password'/$DB['PASSWORD'] = $Zabbix_pass/g' /etc/zabbix/zabbix.conf.php

zabbixconfphp=/etc/zabbix/zabbix.conf.php
test -f $zabbixconfphp.bka || cp $zabbixconfphp $zabbixconfphp.bka
x='$DB["SCHEMA"]'
y='$DB'
ZBX_SERVER='$ZBX_SERVER'
ZBX_SERVER_PORT='$ZBX_SERVER_PORT'
ZBX_SERVER_NAME='$ZBX_SERVER_NAME'
IMAGE_FORMAT_DEFAULT='$IMAGE_FORMAT_DEFAULT'

cat <<EOF > /etc/zabbix/zabbix.conf.php
<?php
// Zabbix GUI configuration file
global $y;

$y['TYPE']     = 'MYSQL';
$y['SERVER']   = 'localhost';
$y['PORT']     = '3306';
$y['DATABASE'] = '$Zabbix_db';
$y['USER']     = '$Zabbix_user';
$y['PASSWORD'] = '$Zabbix_pass';

// SCHEMA is relevant only for IBM_DB2 database
$x               = '';
$ZBX_SERVER      = 'localhost';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = '';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
EOF

# Config apache file

#cp /usr/share/doc/zabbix-frontend-php/examples/apache.conf /etc/apache2/conf.d/zabbix.conf

cp /usr/share/doc/zabbix-frontend-php/examples/apache.conf /etc/apache2/conf-enabled/zabbix.conf

#a2enconf zabbix.conf

a2enmod alias

service apache2 restart

sed -i 's/START=no/START=yes/g' /etc/default/zabbix-server

service zabbix-server start



##############
# install agent tren Zabbix Server
echo Cai dat zabbix agent
sleep 5

apt-get install zabbix-agent -y

/etc/init.d/zabbix-agent start

update-rc.d zabbix-server defaults

update-rc.d zabbix-agent defaults

echo Cai dat hoan tat, ban hay truy cap vao dia chi http://$IP_Zabbix_server/zabbix voi tai khoan admin va mat khau zabbix

sleep 7
