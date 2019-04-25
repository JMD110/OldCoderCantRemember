### PySpark is the Python API for Spark.
Pyspark 是 spark 的 python API

#### Public classes:
公共类

- SparkContext:
Main entry point for Spark functionality. SparkContext是spark功能的关键入口

- RDD:
A Resilient Distributed Dataset (RDD), the basic abstraction in Spark. 弹性分布式数据集 (RDD) ，是Spark中的基本抽象。

- Broadcast:
A broadcast variable that gets reused across tasks. braoadcast是跨任务重复使用的变量

- Accumulator:
An “add-only” shared variable that tasks can only add values to. 一个“附加”的共享变量，任务只能添加值

- SparkConf:
For configuring Spark. 配置spark

- SparkFiles:
Access files shipped with jobs . 与作业相关的文件

- StorageLevel:
Finer-grained cache persistence levels. 更细粒度的缓存持久化级别

- TaskContext:
Information about the current running task, available on the workers and experimental. 关于当前运行任务的信息，在worker和experimental中可用

- RDDBarrier:
Wraps an RDD under a barrier stage for barrier execution. 在障碍阶段包装RDD，用于障碍执行

- BarrierTaskContext:
A TaskContext that provides extra info and tooling for barrier execution. 一个TaskContext，提供额外的信息和工具，用于障碍的执行。

- BarrierTaskInfo:
Information about a barrier task. 障碍任务信息。
