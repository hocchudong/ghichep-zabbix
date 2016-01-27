###Sự khác nhau giữa Zabbix active check và Zabbix passive check

Như chúng ta đã được biết, Zabbix server thu thập thông tin từ Agent thông qua các item tương ướng. Các item có nhiều loại, tuy nhiên 2 loại chính là Active Item (Item chủ động) và Passive Item (Item bị động). Vậy nên việc kiểm tra phân loại chủ động (active) hay bị động (passive) dựa vào giá trị item đang sử dụng ở dạng active hay passive. Trong bài viết tôi sẽ phân loại riêng 2 kiểu kiểm tra là Zabbix Passive Check và Zabbix Active Check, đông thời nêu ra đặc điểm của từng loại.

###1. Zabbix Passive Check là gì?

- Đây là kiểu kiểm tra tương ứng với Item Zabbix Passive (bị động), kiểu này có đặc tính là công việc ưu cầu thông tin cần giám sát thuộc về Zabbix Server.
- Zabbix Server sẽ request thông tin cần tìm kiếm đến các Agent theo các khoảng thời gian (interval time) đã được cấu hình trong item tương ứng, lấy thông tin monitor và báo cáo lại về hệ thống ngay lập tức. Server khởi tạo kết nối, Agent luôn ở chế động lắng nghe kết nối từ Server.
<img src="http://i.imgur.com/Qa03yHR.png">

Cấu hình Zabbix Passive check : 
<img src="http://i.imgur.com/gupW4It.png">
  + 1 : Kiểu Item ( Zabbix agent = Zabbix Passive Item 
  + 2 : Key tương ứng với kiểu Passive
  
###2. Zabbix Active Check là gì?

- Đây là kiểu kiểm tra tương ứng với Item Active (chủ động), đặc tính của kiểu này là công việc chủ động request thông tin cần giám sát thuộc về Zabbix Agent. Kiểu kiếm tra này hay dùng khi Zabbix Server không thể kết nối trực tiếp đến Zabbix Agent (có thể do chính sách firewall...)
- Zabbix Agent sẽ chủ động gửi request đến Zabbix Server nhằm lấy thông tin về các Item được Server chỉ định sẵn. Sau khi lấy được danh sách item thì Agent sẽ xử lý động lập rồi gửi tuần tự thông tin về cho Server. Server sẽ không khởi tạo kết nối nào mà chỉ trả lời request item list và nhận lại thông tin được trả về. Tuy nhiên nếu Agent trei hoặc chết thì Server sẽ không nhận được bất kỳ kết nối nào.
 <img src="http://i.imgur.com/XUpbj9S.png">

 Cấu hình sử dụng Zabbix Active Check :
 <img src="http://i.imgur.com/Af1hr8I.png">
  + 1 : Zabbix agent (active) = Zabbix Active Item 
  + 2 : Key tương ứng với kiểu Active
  
###3. Một số phân tích sâu và một vài lưu ý nhỏ.
####3.1 Tiến trình trao đổi dữ liệu 

#### Passive Check
- Tiến trình :
 +  Server mở kết nối TCP đến Zabbix Agent
 +  Server gửi ưu cầu thu thập thông tin với item tương ứng. Ví dụ : "agent.ping"
 +  Agent nhận ưu cầu, phân tích, thu thập dữ liệu và gửi trả về Server. Với item "agent.ping", kết quả trả về ở đây sẽ là "0" hoặc "1".
 +  Kết nối TCP đóng lại

-  Nội dung gói tin "Server request" : <img src="http://i.imgur.com/Z2zML84.png">
-  Nội dung gói tin "Agent response" : <img src="http://i.imgur.com/b9TpJSI.png">

#### Active Check
- Tiến trình : 
  + Agent mở kết nối TCP đến Zabbix Server
  + Agent yêu cầu danh sách item cần thu thập
  + Server phản hồi với danh sách item tương ứng ( danh sách này đã được định sẵn trước đó, gồm item key, delay).
  + Kết nối TCP đóng lại.
  + Agent bắt đầu thu thập thông tin tương ứng với danh sách item nhận được.
- Nội dung gói tin "Agent Request" : <img src="http://i.imgur.com/dK9q6VR.png">
- Nội dung gói tin "Agent Response" : <img src="http://i.imgur.com/romONxJ.png">
 
