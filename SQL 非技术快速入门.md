---
title: SQL 非技术快速入门
created: '2023-02-08T11:27:02.530Z'
modified: '2023-02-08T11:38:46.091Z'
---

# SQL 非技术快速入门

从表中查找所有学校
```sql
select distinct university from user_profile;
```
查询前几个行
```sql
select device_id from user_profile limit 2;
```
现在你需要查看前2个用户明细设备ID数据，并将列名改为 'user_infos_example',，请你从用户信息表取出相应结果。
```sql
select device_id as user_infos_example from user_profile limit 2;
```
