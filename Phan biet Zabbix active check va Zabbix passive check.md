###Sự khác nhau giữa Zabbix active check và Zabbix passive check

Như chúng ta đã được biết, Zabbix server thu thập thông tin từ Agent thông qua các item tương ướng. Các item có nhiều loại, tuy nhiên 2 loại chính là Active Item (Item chủ động) và Passive Item (Item bị động). Vậy nên việc kiểm tra phân loại chủ động (active) hay bị động (passive) dựa vào giá trị item đang sử dụng ở dạng active hay passive.

####1. Zabbix Passive Check là gì?

- Đây là kiểu kiểm tra tương ứng với Item Zabbix Passive (bị động), kiểu này có đặc tính là công việc ưu cầu thông tin cần giám sát thuộc về Zabbix Server.
- Zabbix Server sẽ request thông tin cần tìm kiếm đến các Agent theo các khoảng thời gian (interval time) đã được cấu hình trong item tương ứng, lấy thông tin monitor và báo cáo lại về hệ thống ngay lập tức. Server khởi tạo kết nối, Agent luôn ở chế động lắng nghe kết nối từ Server.
<img src="http://i.imgur.com/Qa03yHR.png")
