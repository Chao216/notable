---
title: SQL 必知必会
created: '2023-02-09T11:43:37.443Z'
modified: '2023-02-09T14:30:46.877Z'
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
除了返回顾客名称和订单号，返回 Customers 表中的顾客名称（cust_name）和Orders 表中的相关订单号（order_num），添加第三列 OrderTotal，其中包含每个订单的总价，并按顾客名称再按订单号对结果进行升序排序。
```sql
select a.cust_name, b.order_num, sum(c.quantity * c.item_price) as OrderTotal
from
    Customers as a
    left join Orders as b
    on a.cust_id = b.cust_id
    left join OrderItems as c
    on b.order_num = c.order_num
group by a.cust_name, b.order_num
order by a.cust_name asc;
```
编写 SQL 语句，返回订单总价不小于1000 的客户名称和总额（OrderItems 表中的order_num）。
提示：需要计算总和（item_price 乘以 quantity）。按总额对结果进行排序，请使用INNER JOIN 语法。
```sql
select c.cust_name, sum(a.item_price * a.quantity) as total_price
from 
    Customers as c
    right join Orders as b
    on c.cust_id = b.cust_id
    right join OrderItems as a
    on b.order_num = a.order_num
group by c.cust_name
having total_price >= 1000
order by total_price asc;
```

 将两个 SELECT 语句结合起来，以便从 OrderItems表中检索产品 id（prod_id）和 quantity。其中，一个 SELECT 语句过滤数量为 100 的行，另一个 SELECT 语句过滤 id 以 BNBG 开头的产品，最后按产品 id 对结果进行升序排序。
 ```sql
 
    select prod_id, quantity
    from OrderItems
    where quantity = 100
    union all
    select prod_id,quantity
    from OrderItems
    where prod_id regexp "^BNBG"
    order by  prod_id asc;

 ```
