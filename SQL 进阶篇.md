---
title: SQL 进阶篇
created: '2023-02-09T14:53:13.713Z'
modified: '2023-02-10T09:04:36.693Z'
---

# SQL 进阶篇

请把exam_record表中2021年9月1日之前开始作答的未完成记录全部改为被动完成，即：将完成时间改为'2099-01-01 00:00:00'，分数改为0。
```sql
update exam_record 
set submit_time = "2099-01-01 00:00:00", score = 0
where (start_time <"2021-09-01") and (submit_time is null)
```
## DROP TABLE, TRUNCATE TABLE, DELETE TABLE　三种删除语句的区别
1. DROP TABLE　清除数据并且销毁表，是一种数据库定义语言(DDL Data Definition Language), 执行后不能撤销，被删除表格的关系，索引，权限等等都会被永久删除。
2. TRUNCATE TABLE　只清除数据，保留表结构，列，权限，索引，视图，关系等等，相当于清零数据，是一种数据库定义语言(DDL Data Definition Language)，执行后不能撤销。
3. DELETE TABLE　删除（符合某些条件的）数据，是一种数据操纵语言(DML Data Manipulation Language)，执行后可以撤销。（还不太明白怎么撤销TT，在什么情况下可以撤销，求大神指点。
运行速度一般DROP最快，DELETE最慢，但是DELETE最安全。

请删除exam_record表中所有记录，并重置自增主键。
```sql
truncate table exam_record
```
牛客的运营同学想要查看大家在SQL类别中高难度试卷的得分情况。
请你帮她从exam_record数据表中计算所有用户完成SQL类别高难度试卷得分的截断平均值（去掉一个最大值和一个最小值后的平均值）。
```sql
select a.tag as tag, a.difficulty as difficulty, round((sum(b.score)-max(b.score)-min(b.score))/(count(b.score)-2),1) as clip_avg_score
from examination_info as a
right join exam_record as b 
on a.exam_id = b.exam_id
where a.tag = "SQL" and a.difficulty = "hard"


```

请从试卷作答记录表中找到SQL试卷得分不小于该类试卷平均得分的用户最低得分。
```sql
select min(a.score) as min_score_over_avg
from exam_record as a
left join examination_info as b
on a.exam_id = b.exam_id
where b.tag = "SQL"
and a.score >= (
    select avg(a.score) 
from exam_record as a
left join examination_info as b
on a.exam_id = b.exam_id
where b.tag = "SQL"
)
```
请计算2021年每个月里试卷作答区用户平均月活跃天数avg_active_days和月度活跃人数mau，
```sql
select date_format(submit_time,"%Y%m")as month, round(count(distinct uid, date_format(submit_time,"%Y%m%d"))/count(distinct uid),2) as avg_active_days, count(distinct uid) as mau
from exam_record
where year(submit_time) = 2021
group by month

```
> 学习使用date_format(), 一个人一天做好几次，distinct uid, submit_time

请从中统计出2021年每个月里用户的月总刷题数month_q_cnt 和日均刷题数avg_day_q_cnt（按月份升序排序）以及该年的总体情况，
```sql
select date_format(submit_time,"%Y%m") as submit_month, any_value(count(id)) as month_q_cnt, any_value(round(count(id)/day(last_day(submit_time)),3)) as avg_day_q_cnt
from practice_record
where year(submit_time)=2021
group by submit_month
union all 
    select "2021汇总" as submit_month, count(id) as month_q_cnt,round(count(id)/31,3) as avg_day_q_cnt
    from practice_record
    where year(submit_time)=2021


order by submit_month
```

> mysql 提供 any_value() 应对group by 报错， last_day() 获取当月最后一天， day()进一步取得天数

请统计2021年每个未完成试卷作答数大于1的有效用户的数据（有效用户指完成试卷作答数至少为1且未完成数小于5），输出用户ID、未完成试卷作答数、完成试卷作答数、作答过的试卷tag集合，按未完成试卷数量由多到少排序。

```sql
select uid, incomplete_cnt, complete_cnt, detail 
from (
    select uid, 
sum(if(submit_time is not null, 1,0)) as complete_cnt,
sum(if(submit_time is null,1,0)) as incomplete_cnt,
group_concat(distinct sub separator";") as detail
from (
select a.uid,
concat_ws(":",substring(a.start_time,1,10),b.tag) as sub,
a.submit_time
from exam_record as a
left join examination_info as b
on a.exam_id = b.exam_id
where year(a.start_time)=2021
) temp_table
group by uid
) as final_table
where incomplete_cnt >1
and complete_cnt >=1 
and incomplete_cnt < 5
order by incomplete_cnt desc;

```
> 先两表连接，并将时间与tag用','合并以及筛选2021年

select uid
        ,concat_ws(':',substring(start_time,1,10),tag) as sub
        ,submit_time
from exam_record a
inner join examination_info b
on a.exam_id = b.exam_id
where year(start_time) = '2021'
第二步通过submit_time来计算完成，未完成试卷数，还有通过group_concat()来将第一步的数据通过';'合并成detial

select uid
        ,sum(if(submit_time is not null,1,0)) as complete_cnt
        ,sum(if(submit_time is null,1,0)) as incomplete_cnt
        ,group_concat(distinct sub separator ';') as detail
from(
select uid
        ,concat_ws(':',substring(start_time,1,10),tag) as sub
        ,submit_time
from exam_record a
inner join examination_info b
on a.exam_id = b.exam_id
where year(start_time) = '2021'
) cnt 
group by uid
第三步筛选出未完成试卷作答数大于1的有效用户就好，where+and筛选就行，还有排序不要忘了

select uid,incomplete_cnt,complete_cnt,detail
from(
select uid
        ,sum(if(submit_time is not null,1,0)) as complete_cnt
        ,sum(if(submit_time is null,1,0)) as incomplete_cnt
        ,group_concat(distinct sub separator ';') as detail
from(
select uid
        ,concat_ws(':',substring(start_time,1,10),tag) as sub
        ,submit_time
from exam_record a
inner join examination_info b
on a.exam_id = b.exam_id
where year(start_time) = '2021'
) cnt 
group by uid
) aa
where incomplete_cnt > 1 
and complete_cnt >= 1 and incomplete_cnt < 5
order by incomplete_cnt desc
感觉这个逻辑写的不复杂，一层套一层就好，感兴趣的可以看看，如果有更简单更直观的方法欢迎指正
