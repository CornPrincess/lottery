# 抽奖系统
ERD design for a simple lottery system

![lottery system](https://blog-1300663127.cos.ap-shanghai.myqcloud.com/BackEnd_Notes/database/lottery.png)

## 实现功能
### 用户抽奖

### 限制抽奖次数
#### 限制1
对每天，每周，每月，每年，终身对应的次数进行限制

实现方案：
通过设计的 count_day,count_week,count_month,count_year,count_lifelong 表格进行限制。
思路：
抽奖前先通过各个表中limit与count进行判断用户目前是否有资格参与抽奖
- 如果可以抽奖，进行抽奖逻辑，然后使用表中的 last_update 字段进行乐观锁的方式更新对应的表格
  - 更新失败，说明有并发冲突，此次抽奖显示失败，用户进行重试
  - 更新成功，此次抽奖成功
- 如果不能抽奖，告诉用户抽奖次数已用完。


#### 限制2
对用户参与过的所有抽奖活动总和进行限制

实现方案：
通过count_lottery表格进行限制
思路：
抽奖前先查出count_lottery表中该用户对应的lottery的次数，然后将次数之和与limit进行比较
- 如果可以抽奖，进行抽奖逻辑，然后然后使用表中的 last_update 字段进行乐观锁的方式更新对应的涉及到的 抽奖页面相关的字段
  - 更新失败，说明有并发冲突，此次抽奖显示失败，用户进行重试
  - 更新成功，此次抽奖成功
- 如果不可以抽奖，告诉用户抽奖次数已用完。
