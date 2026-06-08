-- tạo view tổng hợp tổng amount theo từng khách hàng
create or replace view customer_sales as
select customer_id, sum(amount) as total_amount
from sales
group by customer_id;


-- xem các khách hàng có tổng amount lớn hơn 1000
select * from customer_sales
where total_amount > 1000;


-- thử cập nhật dữ liệu qua view
update customer_sales
set total_amount = 5000
where customer_id = 951;
-- kết quả:
-- error: cannot update a non-updatable view "customer_sales"


/*
giải thích:

view customer_sales sử dụng hàm tổng hợp sum()
và group by.

mỗi dòng trong view được tạo từ nhiều dòng
của bảng sales nên hệ quản trị không xác định
được cần cập nhật dòng nào trong bảng gốc.

vì vậy view này không thể cập nhật trực tiếp.
*/


-- Giải pháp: cập nhật dữ liệu trên bảng gốc
update sales
set amount = amount + 100
where customer_id = 951;


-- kiểm tra lại dữ liệu trên view
select *
from customer_sales
where customer_id = 951;


/*
kết luận:

customer_sales là view tổng hợp dữ liệu.

có thể sử dụng để truy vấn và báo cáo.

không thể update trực tiếp vì chứa group by
và hàm tổng hợp sum().

khi dữ liệu trong bảng sales thay đổi,
view sẽ tự động phản ánh dữ liệu mới.
*/
