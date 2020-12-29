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
  - 如果中奖，更新 count_date， record表格
  - 如果没中间，更新 count_date 表格
- 如果不能抽奖，告诉用户抽奖次数已用完。
** 结束事务 **
4.在每天凌晨，每周最后一条凌晨，每月最后一天凌晨，每年最后一天凌晨更新 count_date 表格中的累计抽奖次数数据

#### 限制2
对用户参与过的所有抽奖活动总和进行限制

实现方案：
通过设计的 count_lottery 与 count_limit 表格进行是否有抽奖资格的限制。
思路：
1.通过 user_id 普通查找 count_limit 表格，得到该用户参加所有抽奖活动总次数的限制值

** 开始事务 **
2.通过 user_id 使用悲观锁查找 count_lottery 表， 得到该用户参加的所有抽奖活动各自次数，计算出参加抽奖活动的总次数
3.通过前两步得到的值进行判断用户是否有资格抽奖
- 如果可以抽奖，进行抽奖逻辑，
  - 如果中奖，更新 count_lottery， record表格
  - 如果没中奖，更新 count_lottery 表格
- 如果不能抽奖，告诉用户抽奖次数已用完。
** 结束事务 **


## 参考
1. [introduction of database](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%B8%80%E3%80%81%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AE%80%E4%BB%8B.md)
2. [introduction of ERD](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%BA%8C%E3%80%81ER%E5%9B%BE%E7%AE%80%E4%BB%8B.md)
3. [convert ERD to relation](https://github.com/CornPrincess/Backend_Notes/blob/master/notes/%E6%95%B0%E6%8D%AE%E5%BA%93/%E6%95%B0%E6%8D%AE%E5%BA%93%E5%9F%BA%E7%A1%80/%E4%B8%89%E3%80%81%E5%85%B3%E7%B3%BB%E6%A8%A1%E5%9E%8B%E7%AE%80%E4%BB%8B.md)
