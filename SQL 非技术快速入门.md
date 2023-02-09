---
title: SQL 非技术快速入门
created: '2023-02-08T11:27:02.530Z'
modified: '2023-02-09T06:46:10.558Z'
---

# SQL 非技术快速入门

现在运营需要查看用户来自于哪些学校，请从用户信息表中取出学校的去重数据。
```sql
select distinct university from user_profile;
```
现在运营只需要查看前2个用户明细设备ID数据，请你从用户信息表 user_profile 中取出相应结果。
```sql
select device_id from user_profile limit 2;
```
现在你需要查看前2个用户明细设备ID数据，并将列名改为 'user_infos_example',，请你从用户信息表取出相应结果。
```sql
select device_id as user_infos_example from user_profile limit 2;
```
现在运营想要筛选出所有北京大学的学生进行用户调研，请你从用户信息表中取出满足条件的数据，结果返回设备id和学校。
```sql
select device_id, university from user_profile where university = "北京大学";
```
现在运营想要针对24岁以上的用户开展分析，请你取出满足条件的设备ID、性别、年龄、学校。
用户信息表：user_profile
```sql
select device_id, gender, age, university from user_profile where age >= 24;
```
现在运营想要针对20岁及以上且23岁及以下的用户开展分析，请你取出满足条件的设备ID、性别、年龄。
```sql
select device_id, gender, age from user_profile where age >=20 and age <= 23; 
```
现在运营想要查看除复旦大学以外的所有用户明细，请你取出相应数据
```sql
select device_id, gender, age, university from user_profile where university not in ("复旦大学");
```
现在运营想要对用户的年龄分布开展分析，在分析时想要剔除没有获取到年龄的用户，请你取出所有年龄值不为空的用户的设备ID，性别，年龄，学校的信息。
```sql
select device_id, gender, age, university from user_profile where age is not null;
```
现在运营想要找到男性且GPA在3.5以上(不包括3.5)的用户进行调研，请你取出相关数据。
```sql
select device_id, gender, age, university, gpa from user_profile where gpa >3.5 and gender = "male";
```

现在运营想要找到学校为北大或GPA在3.7以上(不包括3.7)的用户进行调研，请你取出相关数据（使用OR实现）
```sql
select device_id, gender, age, university, gpa from user_profile where university = "北京大学" or gpa > 3.7;
```
现在运营想要找到学校为北大、复旦和山大的同学进行调研，请你取出相关数据。
```sql
select device_id, gender, age, university, gpa from user_profile where university in ("北京大学","复旦大学","山东大学");
```

现在运营想要找到gpa在3.5以上(不包括3.5)的山东大学用户 或 gpa在3.8以上(不包括3.8)的复旦大学同学进行用户调研，请你取出相应数据
```sql
select device_id, gender, age, university, gpa from user_profile where (university="山东大学" and gpa >3.5) or (university="复旦大学" and gpa >3.8);
```
现在运营想查看所有大学中带有北京的用户的信息，请你取出相应数据。
```sql
select device_id, age, university from user_profile where university like "%北京%";
```
运营想要知道复旦大学学生gpa最高值是多少，请你取出相应数据
```sql
select max(gpa) from user_profile where university = "复旦大学";
```

现在运营想要看一下男性用户有多少人以及他们的平均gpa是多少，用以辅助设计相关活动，请你取出相应数据。
```sql
select count(gender), avg(gpa) from user_profile where gender = "male";
```
现在运营想要对每个学校不同性别的用户活跃情况和发帖数量进行分析，请分别计算出每个学校每种性别的用户数、30天内平均活跃天数和平均发帖数量。
```sql
select gender, university, count(device_id) as user_num, avg(active_days_within_30) as avg_active_day, avg(question_cnt) as avg_question_cnt from user_profile group by gender, university;
```

现在运营想查看每个学校用户的平均发贴和回帖情况，寻找低活跃度学校进行重点运营，请取出平均发贴数低于5的学校或平均回帖数小于20的学校。
```sql
select university, avg(question_cnt) as avg_question_cnt, avg(answer_cnt) as avg_answer_cnt from user_profile group by university having (avg_question_cnt <5) or (avg_answer_cnt <20);
```
现在运营想要查看不同大学的用户平均发帖情况，并期望结果按照平均发帖情况进行升序排列，请你取出相应数据。
```sql
select university, avg(question_cnt) as avg_question_cnt from user_profile group by university order by avg_question_cnt asc;
```

***moderate***
现在运营想要查看所有来自浙江大学的用户题目回答明细情况，请你取出相应数据
```sql
select qpd.device_id, qpd.question_id, qpd.result from question_practice_detail as qpd inner join user_profile as up on qpd.device_id = up.device_id and up.university = "浙江大学" order by question_id asc;
```

***moderate***
运营想要了解每个学校答过题的用户平均答题数量情况，请你取出数据。
```sql
select up.university, count(qpd.question_id)/count(distinct qpd.device_id) as avg_answer_cnt
from user_profile as up
right join question_practice_detail as qpd
on up.device_id = qpd.device_id 
group by up.university
order by up.university asc;
```
运营想要计算一些参加了答题的不同学校、不同难度的用户平均答题量，请你写SQL取出相应数据
```sql
select up.university, qd.difficult_level, count(qpd.id)/count(distinct qpd.device_id) as avg_answer_cnt 
from user_profile as up
right join question_practice_detail as qpd 
on up.device_id = qpd.device_id
right join question_detail as qd
on qpd.question_id = qd.question_id 
group by up.university, qd.difficult_level;
```
运营想要查看参加了答题的山东大学的用户在不同难度下的平均答题题目数，请取出相应数据

```sql
select up.university, qd.difficult_level, count(qpd.id)/count(distinct qpd.device_id) as avg_answer_cnt
from user_profile as up
right join question_practice_detail as qpd
on up.device_id = qpd.device_id
right join question_detail as qd
on qd.question_id = qpd.question_id
where up.university = "山东大学"
group by qd.difficult_level;

```
现在运营想要分别查看学校为山东大学或者性别为男性的用户的device_id、gender、age和gpa数据，请取出相应结果，结果不去重。
```sql
select device_id, gender, age, gpa
from user_profile
where (university="山东大学")
union all
select device_id, gender, age, gpa
from user_profile
where (gender = "male");
```

### 使用case
现在运营想要将用户划分为25岁以下和25岁及以上两个年龄段，分别查看这两个年龄段用户数量
本题注意：age为null 也记为 25岁以下
```sql
select 
case
    when age >= 25 then "25岁及以上"
    when age < 25 then "25岁以下"
    else "25岁以下"
end as age_cut, count(device_id) as number
from user_profile
group by age_cut;
```
现在运营想要将用户划分为20岁以下，20-24岁，25岁及以上三个年龄段，分别查看不同年龄段用户的明细情况，请取出相应数据。（注：若年龄为空请返回其他。）
```sql
select device_id, gender,
    case 
        when age < 20 then "20岁以下"
        when age >= 20 and age <= 24 then "20-24岁"
        when age >= 25 then "25岁及以上"
        else "其他"
    end as age_cut
from user_profile;

```

### 使用 year month day
现在运营想要计算出2021年8月每天用户练习题目的数量，请取出相应数据。
```sql
select day(date) as day, count(question_id) as question_cnt
from question_practice_detail
where year(date) = 2021 and month(date)=08
group by day;
```
### 难题
现在运营想要查看用户在某天刷题后第二天还会再来刷题的平均概率。请你取出相应数据。
```sql
select 
    round(count(date2)/count(date1),4) as avg_ret
from 
    (
    select 
    distinct a.device_id,
    a.date as date1,
    b.date as date2
    from question_practice_detail as a
    left join question_practice_detail as b
    on a.device_id = b.device_id and datediff(b.date, a.date) = 1


    ) as new_table
```

现在运营举办了一场比赛，收到了一些参赛申请，表数据记录形式如下所示，现在运营想要统计每个性别的用户分别有多少参赛者，请取出相应结果
***使用 substring_index()***
```sql
select substring_index(profile,",",-1) as gender, count(device_id) as number
from user_submit
group by gender;
```
对于申请参与比赛的用户，blog_url字段中url字符后的字符串为用户个人博客的用户名，现在运营想要把用户的个人博客用户字段提取出单独记录为一个新的字段，请取出所需数据。
```sql
select device_id, substring_index(blog_url,"/",-1)
from user_submit;
```


