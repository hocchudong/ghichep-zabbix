#!/bin/bash
# Script nay dung de cai dat Zabbix proxy 2.2.10 tu source

echo "127.0.0.1 localhost" >> /etc/hosts
echo "nameserver 8.8.8.8" >> /etc/resovl.conf
sleep 5
yum update -y

# Cai dat cac goi co ban 
echo " Cai dat cac goi co ban "
sleep 3
yum install gcc make wget -y

# Tao user va group
echo " Tao user va group "
groupadd zabbix
useradd -g zabbix zabbix

# Tai goi zabbix 
echo "Tai goi zabbix tu source"
sleep 5
wget http://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/2.2.10/zabbix-2.2.10.tar.gz
tar -zxvf zabbix-2.2.10.tar.gz

# Tai cac goi bo tro
echo "Tai cac goi bo tro"
sleep 5
yum install zlib-devel glibc-devel sqlite-devel curl-devel libidn-devel openssl-devel net-snmp-devel popt-devel rpm-devel OpenIPMI-devel libssh2-devel -y
# Su dung checkinstall
echo "Su dung checkinstall"
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/ikoinoba/CentOS_CentOS-6/x86_64/checkinstall-1.6.2-3.el6.1.x86_64.rpm
yum install checkinstall-1.6.2-3.el6.1.x86_64.rpm -y

# Configure va make
echo "Configure va make"
sleep 5
cd zabbix-2.2.10
./configure --enable-proxy --with-sqlite3 --with-libcurl --with-netsnmp --with-openipmi
make
checkinstall --nodoc --install=yes -y
cd 
#

filezabbixproxy=/usr/local/etc/zabbix_proxy.conf
test -f $fielzabbixproxy.bka || cp $fielzabbixproxy $fielzabbixproxy.bka

cat << EOF > $filezabbixproxy
Hostname=proxy
Server=$ZabbixServerIP
DBName=/tmp/zabbix_proxy.db
LogFile=/tmp/zabbix_proxy.log
DBUser=root
EOF
#
firewall-cmd --permanent --add-port=10050/tcp
firewall-cmd --permanent --add-port=10051/tcp
systemctl restart firewalld
# 
zabbix_proxy
#
echo "Chu y them Zabbix Server Ip vao thu muc /usr/local/etc/zabbix_proxy.conf"
echo "Them proxy trung voi hostname tai Dashboard"
sleep 5