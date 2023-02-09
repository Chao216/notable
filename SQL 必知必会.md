---
title: SQL 必知必会
created: '2023-02-09T11:43:37.443Z'
modified: '2023-02-09T12:38:40.216Z'
---

# SQL 必知必会
编写 SQL 语句，返回名为 cheapest_item 的字段，该字段包含每个供应商成本最低的产品（使用 Products 表中的 prod_price），然后从最低成本到最高成本对结果进行升序排序。
```sql
select distinct vend_id,min(prod_price) over(partition by vend_id ) as cheapest_item
from Products
order by cheapest_item asc;
```
编写 SQL 语句，根据订单号聚合，返回订单总价不小于1000 的所有订单号，最后的结果按订单号进行升序排序。 
```sql
select order_num, sum(item_price * quantity) as total_price
from OrderItems
group by order_num
having sum(item_price * quantity) >=1000
order by order_num asc;
```
编写 SQL语句，返回顾客 ID（Orders 表中的 cust_id），并使用子查询返回total_ordered 以便返回每个顾客的订单总数，将结果按金额从大到小排序。
```sql
select b.cust_id, sum(a.item_price * a.quantity) as total_ordered
from OrderItems as a
left join Orders as b
on a.order_num = b.order_num
where b.cust_id is not null
group by b.cust_id
order by total_ordered desc;
```
