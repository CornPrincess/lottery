# 抽奖系统
ERD design for a simple lottery system

![lottery system](https://blog-1300663127.cos.ap-shanghai.myqcloud.com/BackEnd_Notes/database/lottery_ERD2.png)

## 实现功能
### 用户抽奖

### 限制抽奖次数
#### 限制1
对每天，每周，每月，每年，终身对应的次数进行限制

实现方案：
通过设计的 count_date 与 count_limit 表格进行是否有抽奖资格的限制。
思路：
1.通过 user_id 普通查找 count_limit 表格，得到该用户每天，每周，每月，每年，终身限制的次数

** 开始事务 **
2.通过 user_id 使用悲观锁查找 count_date 表， 得到用户在该天，该周，该月，该年，终身以抽奖的次数
3.通过前两步得到的值进行判断用户是否有资格抽奖
- 如果可以抽奖，进行抽奖逻辑，
- 如果不能抽奖，告诉用户抽奖次数已用完。
** 结束事务 **
4.

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

## 参考
1. [introduction of database](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%B8%80%E3%80%81%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AE%80%E4%BB%8B.md)
2. [introduction of ERD](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%BA%8C%E3%80%81ER%E5%9B%BE%E7%AE%80%E4%BB%8B.md)
3. [convert ERD to relation](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%B8%89%E3%80%81%E5%85%B3%E7%B3%BB%E6%A8%A1%E5%9E%8B%E7%AE%80%E4%BB%8B.md)
