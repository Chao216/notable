---
title: SQL 非技术快速入门
created: '2023-02-08T11:27:02.530Z'
modified: '2023-02-08T12:09:21.722Z'
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
