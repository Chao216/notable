---
title: SQL 基础进阶
created: '2023-02-09T07:53:50.893Z'
modified: '2023-02-09T08:06:59.010Z'
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
