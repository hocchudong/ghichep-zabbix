###Một số ghi kỹ thuật làm việc với Web Interface của Zabbix
##Mục lục
*   [1. Tạo Graph và Screen ](#graphvascreen)
  *   [1.1 Tạo Graph ] (#graph)
  *   [1.2 Tạo Screen ] (#screen)
  
*   [2. Thêm Item cho Template](#themitem)



###1. Tạo Graph và Screen
<a name="graphvascreen"> </a> 
Để thuận tiện cho việc theo dõi, ta có thể tạo riêng Graph để lấy chỉ những thông tin cần thiết cho bản thân, và thêm nhiều Graph có cùng một đặc tính vào 1 Screen ( Screen tổng hợp về Network, RAM, CPU, Disk... của các host trong hệ thống )
####1.1 Tạo Graph 
<a name="graph"> </a>
Trước khi tạo Graph, ta cần xác định được Graph được tạo sẽ có hình dạng như thế nào? ( line chart, pie chart...) Cần có những thông số gì... để có thể lấy chính xác được item cần thêm vào.

  * Line chart : Thường dùng để biểu diễn các dạng như CPU load, Memory Usage, Network traffic on ethernet...
     Ví dụ về tạo Graph biểu diễn Network Traffic trên card eth0 :
      Step 1 : Xác định thông số cần giám sát, ở đây ta sẽ giám sát traffic incoming và outgoing trên eth0
      <img src="http://i.imgur.com/36Q09Rx.png">
  
