---
title: Python 入门到实践四十招
created: '2023-02-10T13:30:18.471Z'
modified: '2023-02-10T14:00:28.846Z'
---

# Python 入门到实践四十招

为庆祝驼瑞驰在牛爱网找到合适的对象，驼瑞驰通过输入的多个连续字符串创建了一个列表作为派对邀请名单，在检查的时候发现少了他最好的朋友“Allen”的名字，你能使用append函数将这个名字加到列表末尾吗？添加完成请输出完整列表。
### NP20 append
```python
import sys

for line in sys.stdin:
    a = line.split()
    a.append("Allen")
    print(a)

```
为庆祝驼瑞驰在牛爱网找到合适的对象，驼瑞驰通过输入的多个连续字符串创建了一个列表作为派对邀请名单，在检查的时候发现少了他最好的朋友“Allen”的名字，因为是最好的朋友，他想让这个名字出现在邀请列表的最前面，你能用insert函数帮他实现吗？请输出插入后的完整列表。
### NP21 insert
```python
import sys

for line in sys.stdin:
    a = line.split()
    a.insert(0,"Allen")
    print(a)

```
牛牛在各大互联网公司投入了简历，公司的名字通过字符串的形式在一行中输入，请用列表记录。现在牛牛已经确定了第一所公司的HR表露了不录用他的态度，请你使用del函数帮助牛牛从列表中删除第一个元素，然后输出列表。
### NP22 del
```python
import sys

for line in sys.stdin:
    a = line.split()
    del a[0]
    print(a)

```
