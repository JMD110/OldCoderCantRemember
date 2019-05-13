### spark
- spark的核心是一个由很*多计算任务*组成的, 在多个工作机器或者计算集群中进行 调度 分发 以及监控 的*计算引擎*
- RDD弹性分布式数据集, spark对分布式数据和计算的基本抽象
### RDD
- Spark只会惰性计算这些RDD, 只有在第一次行动操作中, 才会真正计算, 只计算求结果时真正需要的数据, 而不需要读取整个文件
- 重用 RDD.persist()让spark将RDD缓存
### Spark程序
- 从外部数据创建出输入RDD
- 转化操作(如filter)转化RDD, 定义新的RDD
- 告诉Spark对需要被重用的中间结果RDD执行persist()操作
- 行动操作, 触发并行计算, 对计算结果进行优化后再执行
### RDD操作
- 转化操作 => 新的RDD
- 行动操作 => 其他的数据类型
### RDD操作 ---
- 针对各个元素的转化操作: filter()将符合函数的元素放入新的RDD, map()将每个元素执行函数, flatMap()没个输入元素多个输出
- 伪集合操作: union(), distinct()开销很大, intersection(), subtract(), cartesian()笛卡尔积
- 行动操作: reduce(), fold(), aggregate(),collect()数据太大不行, top(), count(), take(), countByValue(), foreach()...
