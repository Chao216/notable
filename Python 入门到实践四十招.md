---
title: Python 入门到实践四十招
created: '2023-02-10T13:30:18.471Z'
modified: '2023-02-10T14:21:37.549Z'
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
牛妹有一个坏习惯，一旦与朋友吵架了，她就要删除好友。现在输入一个行多个字符串表示牛妹的朋友，请把它们封装成列表，然后再输入与牛妹吵架的朋友的名字，请使用remove函数帮她从列表中删除这个好友，然后输出完整列表。
### NP23 remove
```python
import sys

for line in sys.stdin:
    a = line.split()
    a.remove(input())
    print(a)

```
某实验班实行末位淘汰制，期中考试需要淘汰末三位同学。现输入一行多个字符串表示按分数排名的该班级同学的名字（数量一定不少于三个），请你使用list将其封装为列表，然后使用三次pop函数，去掉末三位同学的名字，最后输出淘汰后的班级名字列表。
### NP24 pop
```python
import sys

for line in sys.stdin:
    a = line.split()
    for i in range(3):
        a.pop()
    print(a)

```
创建一个依次包含字符串'P'、'y'、't'、'h'、'o'和'n'的列表my_list，先使用sorted函数对列表my_list进行临时排序，第一行输出排序后的完整列表，第二行输出原始的列表。再使用sort函数对列表my_list进行降序排序，第三行输出排序后完整的列表。
### NP25 sorted, sort
```python
my_list = list(("P","y","t","h","o","n"))
a = sorted(my_list)
print(a)
print(my_list)
my_list.sort(reverse=True)
print(my_list)
```
