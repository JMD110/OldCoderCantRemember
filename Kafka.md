- kafka 文档
http://kafka.apachecn.org/documentation.html
- 下载kafka(注意不要下载错了source): `wget http://archive.apache.org/dist/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz`
- 下载zookeeper: ` wget http://mirror-hk.koddos.net/apache/zookeeper/stable/apache-zookeeper-3.5.5-bin.tar.gz`
- how to start:
  - `bin/zookeeper-server-start.sh config/zookeeper.properties`
  - `bin/kafka-server-start.sh config/server.properties`
  
### Kafka适用场景
- 实时数据管道(系统或应用间可靠地获取数据,相当于MQ)
- 实时流式应用程序(对流数据进行转换或影响,流处理)
### Kafka四个核心API
- Producer (即发布者,允许一个应用程序发布一串流式数据到一个或多个kafka topic)
- Connsume (即订阅者,允许一个应用程序订阅一个或多个topic,并且对发布给他们的流式数据进行处理)
- Streams (允许一个应用程序作为一个流处理器,消费一个或多个topic产生的输入流,然后生产一个输出流到一个或多个topic中,在输入输出流中进行有效转换)
- Connector (允许构建并运行可重用的生产者或者消费者, 将kafka topics链接到已存在的应用程序或者数据系统,比如连接到一个关系型数据库,捕捉表的所有变更内容)
### 什么是topic
topic就是数据主题, 是数据记录发布的地方, **可用于区分业务系统**. Kafka中的Topics总是订阅者模式,一个topic可以拥有一个或者多个消费者来订阅它的数据
- Kafka集群会为每一个topic维持一个分区日志,每一个记录都会分配一个id表示顺序,称为offset, offset用来唯一标识分区每一条记录
- Kafka所有的发布记录**无论是否被消费**通过配置参数(保留期限),在保留期限内,可以**随时被消费**,到期释放,Kafka的性能和数据大小**无关**,所以可以长时间存储数据
