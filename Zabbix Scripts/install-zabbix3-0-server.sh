#!/bin/bash
#############################################################
# Zabbix 3.x
# Ubuntu 14.04.1
# Update: 12/8/2016
# Author: ManhDV
#############################################################
# Run with root account  
# wget 
# bash install-zabbix3-0-server.sh
# Wait ....and here we go :)

###############################
# Get IP Server
IPADD="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
#Cac bien moi truong, co the tu khai bao
Mysql_pass='123456a@'
Mysql_host='localhost'
Mysql_port='3306'
Zabbix_db='zabbix'
Zabbix_pass='123456a@'
# Cai dat Zabbix 3.0 
wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
dpkg -i zabbix-release_3.0-1+trusty_all.deb
apt-get update -y 

echo mysql-server mysql-server/root_password password $Mysql_pass | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $Mysql_pass | debconf-set-selections

apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-agent -y
# Sua file cau hinh zabbix
echo "Sua file cau hinh zabbix"
sleep 7

filezabbix=/etc/zabbix/zabbix_server.conf
test -f $filezabbix.bka || cp $filezabbix $filezabbix.bka
sed -i 's/# DBHost=localhost/DBHost=localhost/g' /etc/zabbix/zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=$Zabbix_pass/g" /etc/zabbix/zabbix_server.conf
sed -i 's/# php_value date.timezone Europe\/Riga/php_value date.timezone Asia\/Ho_Chi_Minh/g' /etc/apache2/conf-enabled/zabbix.conf

#Tao bang zabbix trong mysql
echo "Tao bang zabbix trong mysql"
cat << EOF | mysql -uroot -p$Mysql_pass
DROP DATABASE IF EXISTS zabbix;
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by '$Mysql_pass';
flush privileges;
EOF

#Tao bang cho DB
cd /usr/share/doc/zabbix-server-mysql
zcat create.sql.gz | mysql -uzabbix -p$Mysql_pass zabbix

#Restart dich vu
service zabbix-server start
service apache2 restart

echo "Dang nhap zabbix web voi dia chi http://$IPADD/zabbix"