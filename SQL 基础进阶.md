---
title: SQL 基础进阶
created: '2023-02-09T07:53:50.893Z'
modified: '2023-02-09T11:10:01.418Z'
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
牛客投递记录数据表、职位信息表 ，查询每个公司`company_id`查看过的投递用户数cnt，`resume_if_checked` 简历是否被查看 1 被查看 0 未被查看
查询返回结果名称和顺序
```sql
select b.company_id, sum(a.resume_if_checked) as cnt
from deliver_record as a
left join job_info as b
on a.job_id = b.job_id
group by b.company_id
having cnt > 0
order by b.company_id;
```
现有牛客职位信息表 ，请查询职位城市在北京的job_id和company_id，与职位工资高于100000的job_id和company_id，二者合并输出不去重，查询返回结果名称和顺序为
```sql
select job_id, company_id
from job_info
where job_city = "北京"
union all (
    select job_id, company_id
    from job_info
    where salary > 100000
) 


```

现有牛客职位信息表 ，请查询职位发布时间在2021年后的job_id, boss_id, company_id，与职位城市为上海的job_id, boss_id, company_id，二者结果合并去重，按照job_city升序排序，查询返回结果名称和顺序为

```sql
select job_id,boss_id,company_id
from (
    select job_id, boss_id,company_id,job_city
    from job_info
    where year(post_time)>=2021
    union (
    select job_id, boss_id,company_id,job_city
    from job_info
    where job_city ="上海"
    )
) as temp
order by job_city asc;

```

现有牛客顾客购买信息表customers_info，请查询客户id并新增一列判断该客户是否有过购买记录(`latest_place_order_date` 1为有 0为没有)
```sql
select customer_id, if(latest_place_order_date is not null,1,0) as if_placed_order
from customers_info
```

牛客顾客购买信息表`customers_info`
按年龄给客户分群（age_group 分为 '20以下' ，'20-50' ， '50以上'，'未填写' 四个群体）,并计算各群体人数并命名为 user_count
```sql
select
    case
        when age < 20 then "20以下"
        when age <= 50 and age >= 20 then "20-50"
        when age > 50 then "50以上"
        else "未填写"
    end as age_group, count( customer_id) as user_count
from customers_info
group by age_group;
```
牛客刷题记录表`done_questions_record`，输出提交次数大于2次的用户ID且倒序排列，查询返回结果名称和顺序
```sql
select user_id 
from done_questions_record
group by user_id
having count(user_id)>2
order by user_id desc;
```
牛客刷题记录表`done_questions_record`，输出提交且通过次数大于2 的用户ID且升序排列，result_info  '是否通过，1：通过； 0：不通过'，查询返回结果名称和顺序，
```sql
select user_id
from (select * from done_questions_record
where result_info = 1) as temp
group by user_id
having (count(user_id) >2)
```

牛客购买点击表`user_ad_click_time`, 支付成功表`user_payment_time`，求出哪个小时为广告点击的高峰期,以及发生的点击次数（假设高峰期唯一），查询返回结果名称和顺序为
```sql

    select hour(click_time) as click_hour, count(trace_id) as click_cnt
    from user_ad_click_time
    group by click_hour
    order by click_cnt desc
    limit 1

```

牛客购买点击表`user_ad_click_time`, 支付成功表`user_payment_time`，输出在5min内完成点击并购买的用户ID(倒排），查询返回结果名称和顺序为
```sql
select user_id as uid
from (
    select a.user_id,a.trace_id,time(a.click_time) as time1, time(b.pay_time) as time2
from user_ad_click_time as a 
left join user_payment_time as b
on a.user_id = b.user_id
where timediff(b.pay_time,a.click_time)<=300
) as temp1
```
