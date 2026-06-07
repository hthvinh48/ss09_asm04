-- 1 Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
create or replace view customer_sales as 
select customer_id, sum(amount) total_amount
from sales 
group by customer_id;

-- 2
select * from customer_sales where total_amount > 1000;

-- 3
update customer_sales
set total_amount = 123456789
where customer_id = 951;
/*
 * ERROR: cannot update a non-updatable view "customer_sales"
 * Lý do: view dùng GROUP BY + SUM() nên không thể xác định
 * được cần cập nhật dòng nào trong bảng sales gốc
 * → Muốn sửa thì phải UPDATE thẳng vào bảng sales
 */