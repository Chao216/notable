---
title: SQL 基础进阶
created: '2023-02-09T07:53:50.893Z'
modified: '2023-02-09T08:54:10.024Z'
---

# SQL 基础进阶
牛客简历详细投递数据表`deliver_record_detail`
如下，请你查询城市为北京的职位投递记录
```sql
select * 
from deliver_record_detail
where job_city like "%北京%"
```
> 有可能是 北京，也可能是 北京市，使用%北京%


牛客刷题详细数据表`questions_pass_record_detail`如下，请你计算总刷题数,并将所选列名改为'总刷题数'
```sql
select sum(pass_count) as 总刷题数
from questions_pass_record_detail
```
牛客刷题详细数据表`questions_pass_record_detail` 如下，请你统计每天days总刷题数passCnt，查询返回结果名称和顺序
```sql
select date(date) as days, sum(pass_count) as passCnt
from questions_pass_record_detail
group by days
```
牛客刷题详细数据表`questions_pass_record_detail`如下，请你统计每天刷题数超过5的user_id以及刷题数，返回结果字段为顺序以及名称为
```sql
select date(date) as date, user_id, sum(pass_count) as total_pass_count
from  questions_pass_record_detail
group by user_id, date
having sum(pass_count) >5
```
现有牛客刷题记录数据表、用户信息表如下，请查询2022年毕业用户的刷题记录，查询返回结果名称和顺序为
```sql
select user_info.user_id, question_type, device, pass_count, `date`
from questions_pass_record
left join user_info
on questions_pass_record.user_id = user_info.user_id
where user_info.graduation_year = 2022;
```
现有牛客刷题记录数据表、用户信息表如下，对于2022年以来有刷题的用户，请查询他们的user_id和毕业院校，查询返回结果名称和顺序为
```sql
select a.user_id, b.university
from questions_pass_record as a
left join user_info as b
on a.user_id = b.user_id
where year(a.date) = 2022;
```
