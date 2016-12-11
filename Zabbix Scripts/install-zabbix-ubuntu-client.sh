#!/bin/bash
#############################################################
# Zabbix Client
# Ubuntu 14.04.1
# Update: 12/8/2016
# Author: ManhDV
#############################################################
# Run with root account  
# wget 
# bash install-zabbix-ubuntu-client.sh
# Wait ....and here we go :)
#Script cai cat zabbix clien Ubuntu
echo "Nhap Zabbix-server IP"
read zabbix_srv_ip
echo "Nhap hostname cho zabbix-client"
read hostname

#Cai dat zabbix-client
apt-get update
apt-get install zabbix-aget

#Sua file cau hinh

cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bka

sed -i "s/Server=127.0.0.1/Server=$zabbix_srv_ip/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/Server=$zabbix_srv_ip/g" /etc/zabbix/zabbix_agentd.conf 
sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf

#Restart service
service zabbix-agent restart
echo "Script Install Done! Bay gio ban co the thuc hien add host tren Zabbix-WebInterface"