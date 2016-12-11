zabbix-3.0
==========

Trong bài viết này tôi sẽ hướng dẫn các bạn cài đặt và cấu hình zabbix - một công cụ để monitor.

Yêu cầu với máy chủ cài Zabbix server: Ubuntu 14.04

## 1. Cài đặt zabbix server

SSH vào máy chủ và thực hiện các lệnh sau:

    apt-get update

    apt-get install wget -y

    https://raw.githubusercontent.com/hocchudong/ghichep-zabbix/master/Zabbix%20Scripts/install-zabbix3-0-server.sh

    bash install-zabbix3-0-server.sh

Sau khi cài đặt trên server thành công, mở trình duyệt web tại địa chỉ http://$IP_Zabbix_server/zabbix, thực hiện cài đặt trên web :

![setup-zabbix](/images/setup-01.png)
![setup-zabbix](/images/setup-02.png)
![setup-zabbix](/images/setup-03.png)
![setup-zabbix](/images/setup-04.png)
![setup-zabbix](/images/setup-05.png)
![setup-zabbix](/images/setup-06.png)
![setup-zabbix](/images/setup-07.png)
![setup-zabbix](/images/setup-08.png)

User name và password đăng nhập mặc định : 

	user: Admin
	
	password: zabbix
	
Script cài đặt trên client :

- [Trên Ubuntu](https://raw.githubusercontent.com/manhdinh/ghichep-zabbix/master/Zabbix%20Scripts/install-zabbix-ubuntu-client.sh)
