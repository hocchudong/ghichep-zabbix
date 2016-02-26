###Ghi chú upgrade lên Zabbix 3.0

`Trước khi upgrade, cần backup file cấu hình zabbix

####. Cách bước upgrade

##### Bước 1 : 

Dowload gói server và web-frontend package.deb theo link http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix/

root@manh-zabbix:~# wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix/zabbix-server-mysql_3.0.0-1+trusty_amd64.deb

root@manh-zabbix:~# wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix/zabbix-frontend-php_3.0.0-1+trusty_all.deb

root@manh-zabbix:~# dpkg -i zabbix-server-mysql_3.0.0-1+trusty_amd64.deb

root@manh-zabbix:~# dpkg -i zabbix-frontend-php_3.0.0-1+trusty_all.deb

##### Bước 2 : Restart dịch vụ

  root@manh-zabbix:~# service zabbix-server restart
  root@manh-zabbix:~# service apache2 restart

##### Bước 3 : Đăng nhập giao diện Web như bình thường
