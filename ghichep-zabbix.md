# Ghi chép về Zabbix


## Cài đặt ZABBIX 3.2

- Môi trường

```sh

```

### Các bước cài đặt

#### Cài đặt các ứng dụng bổ trợ

- Cài đặt các gói chuẩn bị

```sh
apt-get -y install apache2
```

- Cài đặt PHP và các gói mở rộng

```sh
sudo apt-get install php5 php5-cli php5-common php5-mysql
```

- Chỉnh timezone trong file `/etc/php5/apache2/php.ini`. Sửa dòng 879 như dưới

```sh
date.timezone = 'Asia/Ho_Chi_Minh'
```

    - Tham khảo ảnh:  date.timezone = 'Asia/Ho_Chi_Minh'

- Cài đặt MariaDB. Khi cài đặt DB cần khai báo mật khẩu cho tài khoản `root`. Tài khoản này dùng ở bước dưới.
- Trong hướng dẫn này dùng mật khẩu là `Welcome123`

```sh
apt-get -y install mariadb-server
```

- Cấu hình cho mariadb-server

```sh
sed -r -i 's/127\.0\.0\.1/0\.0\.0\.0/' /etc/mysql/my.cnf
```

- Khởi động lại mariadb-server

```sh
service mysql restart
```

- Tạo DB cho zabbix

```sh
mysql -u root -p
```

```sh
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Welcome123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'Welcome123' WITH GRANT OPTION;

CREATE DATABASE zabbixdb;
GRANT ALL on zabbixdb.* to 'zabbix'@'%' IDENTIFIED BY 'Welcome123';
GRANT ALL on zabbixdb.* to 'zabbix'@'localhost' IDENTIFIED BY 'Welcome123';
FLUSH PRIVILEGES;

exit;
```

#### Cài đặt zabbix 3.2

- Khai báo repos

```sh
wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.2-1+trusty_all.deb
dpkg -i zabbix-release_3.2-1+trusty_all.deb
apt-get update
```

- Cài đặt zabbix

```sh
apt-get -y install zabbix-server-mysql zabbix-frontend-php
```

- Cài đặt zabbix agent

```sh
apt-get -y install zabbix-agent
```

-  Đồng bộ DB cho zabbix

```sh
cd /usr/share/doc/zabbix-server-mysql
zcat create.sql.gz | mysql -u root -p zabbixdb
```

- Sửa các dòng dưới trong file `/etc/zabbix/zabbix_server.conf` như sau:

```sh
DBHost=localhost
DBName=zabbixdb
DBUser=zabbix
DBPassword=Welcome123
```

- Khởi động lại Apache va zabbix

```sh
service apache2 restart
service zabbix-server restart
```

- Truy cập vào web và cài đặt

```sh
http://dia_chi_ip_zabbix_server/zabbix
```

### Các bước cấu hình zabbix

- Truy cập vào web : http://prntscr.com/ck2qpg

- Nếu các bước check OK thì tiếp tục: http://prntscr.com/ck2qvh

- Khai báo DB cho zabbix (đúng thông số với các bước trước đó): http://prntscr.com/ck2r14 

- Nếu bước trên đúng sẽ chuyển sang bước tiếp, khai báo như ảnh: http://prntscr.com/ck2r7o

- Xác nhận lại các bước ở trên: http://prntscr.com/ck2rbo

- Thông báo cài đặt thành công: http://prntscr.com/ck2rg7 . Chọn `Finish`

- Chuyển sang màn hình đăng nhập: http://prntscr.com/ck2rml . Nhập user: `admin` , mật khẩu: `zabbix`

- Màn hình sau khi đăng nhập: http://prntscr.com/ck2rtn


# Các bước cấu hình nâng cao khác


