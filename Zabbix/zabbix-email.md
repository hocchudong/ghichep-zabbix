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
 - Thay các thông số bằng thông tin gmail dùng để xác thực, 
 
![email](/images/email-01.png)

 -	Phân quyền thực hiện cho script và gửi email test :
 
```sh
chmod +x zabbix-alert-smtp.sh
./zabbix-alert-smtp.sh manh.dinhvan@meditech.vn "Test email" "Hello Zabbix"
```

Kiểm tra mail test tại hòm thư :

![email](/images/email-02.png)

**Bước 3** : Cấu hình tại Web-interface

 -	Thêm Media-type, điền tên, chọn Type là `Script`, điền tên của script, thêm các Script parameter.
 
![email](/images/email-03.png)
![email](/images/email-04.png)

 -	Thêm Media-type vào user Administrator :
 
![email](/images/email-05.png)
![email](/images/email-06.png)

Chọn Type là `Email-alert`, điền email nhận cảnh báo và chọn các mức gửi cảnh báo, sau đó ấn `Add`

![email](/images/email-07.png)

![email](/images/email-07.png)

 -	Tạo Action, mỗi khi có đủ điều kiện trong Action được tạo, cảnh báo sẽ được gửi đi.

![email](/images/email-08.png)
![email](/images/email-09.png)

Trong mục `Condition`, chọn `Type of caculation` phù hợp, trong ví dụ này, action sẽ được thực hiện khi và chỉ khi có đủ cả 2 điều kiện A và B xảy ra (Sẽ có action khi tại host compute-10.0.0.20 có trigger đang ở trạng thái PROBLEM)

![email](/images/email-10.png)

Tạo Operation mới, chỉnh sửa thời gian thực hiện khi action xảy ra (Default operation step duration)

![email](/images/email-11.png)

Chọn Operation type là `Send message`, tùy chọn gửi tới User group hoặc gửi tới User nhất định, gửi bằng Media-type là `Email-alert`. Chú ý chọn `Add` trươc khi `Update`

![email](/images/email-12.png)

Khi host comute-10.0.0.20 có trigger có trạng thái PROBLEM, cảnh báo sẽ được gửi tới email.

![email](/images/email-13.png)


