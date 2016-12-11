zabbix-2.2
==========

Trong bài viết này tôi sẽ hướng dẫn các bạn cài đặt và cấu hình zabbix - một công cụ để monitor.

Yêu cầu với máy chủ cài Zabbix server: Ubuntu 14.04

## 1. Cài đặt zabbix server

SSH vào máy chủ và thực hiện các lệnh sau:

    apt-get update

    apt-get install wget -y

    wget https://raw.githubusercontent.com/hocchudong/ghichep-zabbix/master/Zabbix%20Scripts/install-zabbix2.2-server.sh

    bash install-zabbix2.2-server.sh

Sau khi cài đặt thành công, mở trình duyệt web tại địa chỉ http://$IP_Zabbix_server/zabbix
	
	user: admin
	
	password: zabbix
	
## 2. Thêm host để giám sát
	
Tham khảo [link sau] (http://tecadmin.net/add-host-zabbix-server-monitor/)
	
## 3. Cấu hình gửi mail cảnh báo

## 4. Cấu hình gửi SMS cảnh báo	
	
## Tham khảo
	
[Digital Ocean] (https://www.digitalocean.com/community/tutorials/how-to-install-zabbix-on-ubuntu-configure-it-to-monitor-multiple-vps-servers)
	
