##Hướng dẫn gửi mail cảnh báo với Zabbix

Bài viết hướng dẫn gửi mail cảnh báo với Zabbix thông qua SMTP server.

**Bước 1** : Kiểm tra thư mục chứa script cảnh báo của zabbix :

```sh
cat /etc/zabbix/zabbix_server.conf | grep alert
```
![email](/images/email-00.png)

**Bước 2** : Cấu hình script cảnh báo qua SMTP

 -	Tải script cảnh báo vào thư mục chứa script cảnh báo của Zabbix `/usr/lib/zabbix/alertscripts` 
 
```sh
wget https://gist.githubusercontent.com/superdaigo/3754055/raw/e28b4b65110b790e4c3e4891ea36b39cd8fcf8e0/zabbix-alert-smtp.sh
```
 - Thay các thông số bằng **gmail** và password dùng để xác thực 
 
![email](/images/email-01.png)

 -	Phân quyền thực hiện cho script và gửi email test :
 
```sh
chmod +x zabbix-alert-smtp.sh
./zabbix-alert-smtp.sh manh.dinhvan@meditech.vn "Test email" "Hello Zabbix"
```

Kiểm tra mail test tại hòm thư :

![email](/images/email-02.png)
