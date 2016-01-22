###Một số ghi kỹ thuật làm việc với Web Interface của Zabbix
##Mục lục
  
*   [1. Tạo Item cho Template](#themitem)
*   [2. Tạo Graph và Screen ](#graphvascreen)
  *   [2.1 Tạo Graph ] (#graph)
  *   [2.2 Tạo Screen ] (#screen)


###1. Tạo Item cho Template

Khi muốn giám sát những thông số của host mà không có sẵn trong template, ví dụ như từng content của RAM như free, used, cached, buffers... thì cần phải tự thêm vào item. 
Ví dụ : Thêm item giảm sát các content free, used, cached, buffer của RAM cho Template của OS Linux 

* Step 1 : 
<img src="http://i.imgur.com/dI35OEL.png">
* Step 2 : Chọn OS Linux
<img src="http://i.imgur.com/J05Lc4e.png">
* Step 3 : Create Item
<img src="http://i.imgur.com/HZyb6RR.png">
* Step 4 : Tạo Item như các bước sau :
<img src="http://i.imgur.com/GxE42kk.png">

1 : Đặt tên cho Item

2 : Chọn type cho Item

3 : Chọn key cho Item, ở đây ta chọn key với memory như hình  :
  <img src="http://i.imgur.com/nYBlIOo.png">
  
  Chú ý thay <mode> với các paramater phù hợp của memory, tham khảo link sau : https://www.zabbix.com/documentation/2.0/manual/appendix/items/vm.memory.size_params
  
4 : Chọn đơn vị cho Item ( B = Byte ) ( Chọn "Use custom multiplier" khi muốn convert sang loại dữ liệu MB khi lưu lượng > 1024Byte )

5 : Chọn Application cho Item

6 : Sau khi hoàn thành, ấn Save để lưu item.



###2. Tạo Graph và Screen
<a name="graphvascreen"> </a> 
Để thuận tiện cho việc theo dõi, ta có thể tạo riêng Graph để lấy chỉ những thông tin cần thiết cho bản thân, và thêm nhiều Graph có cùng một đặc tính vào 1 Screen ( Screen tổng hợp về Network, RAM, CPU, Disk... của các host trong hệ thống )
####2.1 Tạo Graph 
<a name="graph"> </a>
Trước khi tạo Graph, ta cần xác định được Graph được tạo sẽ có hình dạng như thế nào? ( line chart, pie chart...) Cần có những thông số gì... để có thể lấy chính xác được item cần thêm vào.

  * Line chart : Thường dùng để biểu diễn các dạng như CPU load, Memory Usage, Network traffic on ethernet...
     Ví dụ về tạo Graph biểu diễn Network Traffic trên card eth0 :
      Step 1 : Xác định thông số cần giám sát, ở đây ta sẽ giám sát traffic incoming và outgoing trên eth0
      <img src="http://i.imgur.com/36Q09Rx.png">
  
