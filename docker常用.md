# docker
## 一、docker基础操作
`service docker start/stop/restart`
## 二、镜像基础操作

- 1.搜索镜像：
`docker search imageName`
- 2.拉取搜索出的镜像：
`docker pull 镜像名；`
- 3.修改镜像名
`docker tag` 旧镜像名:tag 新镜像名:tag
- 4.查看当前镜像列表：
`docker images`
- 5.删除镜像
`docker rmi imageName`
  - 5.1匹配删除镜像（匹配删除 镜像列表中名字以 servers_打头的镜像，根据过滤出的第三列的IMAGE ID删除）
    `docker rmi $(docker images | grep ^servers_ | awk '{print $3}')`
## 三、容器基础操作(对已经启动的镜像操作)

- 1.显示所有容器
`docker ps -a`

- 2.显示当前运行中的容器
`docker ps`

- 3.启动容器
`docker start containerId`

- 4.停止容器
`docker stop containerId`

- 5.重启容器
`docker restart containerId`

- 6.删除容器
`docker rm containerId`
## 四、从无到有构建一个新的镜像（基于已有镜像，创建一个新的镜像），并启动

- 1.随意创建一个文件夹；
- 2.创建Dockerfile文件（名字只能为 Dockerfile）,内容如下：
### 镜像来源
```
FROM centos:latest

#作者
MAINTAINER "chengxp"

#在新创建的镜像中创建目录
RUN mkdir /usr/local/jdk
RUN mkdir /usr/local/runentry

#添加当前镜像中需要依赖的工具
ADD jdk1.8.0_65.tar /usr/local/jdk/
ADD jboss.tar /usr/local/runentry/

#卷，会将镜像中的目录挂载到宿主机的docker安装目录下
VOLUME ["/usr/local/runentry/jboss/logs"]

#环境变量添加
ENV JAVA_HOME /usr/local/jdk1.8.0_65
ENV PATH $PATH:$JAVA_HOME/bin

#提示要输出的端口（没有实际意义）
EXPOSE 8181

#镜像启动成容器需要执行的命令（软件启动指令）
CMD ["./usr/local/runentry/jboss/bin/run.sh","-c","all"]
```
- 3.执行Dockerfile，在当前目录(Dockerfile文件所在目录)执行：
`docker build -t 自定义镜像名称:tag(版本号) .("."代表当前目录执行)`
- 4.镜像被成功创建。
- 5.运行镜像→生成容器
`docker run -d(后台运行) -p 8888:8181(指定外部8888端口映射出内部的8080端口) --name 容器名(指定容器运行的名称) 镜像名:tag(版本号)`
        
  备注：运行基础的centos镜像，因为没有启动指令，所以需要额外增加命令参数
 `docker run -dit 镜像名 /bin/bash`
## 五、清理无效镜像与容器
- 删除<none>的镜像
`docker rmi $(docker images | grep "none" | awk '{print $3}')`
- 删除无用容器
`docker rm `docker ps -a | grep Exited | awk '{print $1}'`
## 六、宿主机与容器交互

- 1.进入容器中的系统
`docker exec -it 容器ID /bin/bash`
- 2.文件拷贝

  - 1)从主机到容器：
  docker cp 文件 容器ID:容器中的路径（路径必须提前创建）

  - 2）从容器到主机：
  docker cp 容器ID:容器中的路径 主机上文件的路径


## 七、卷（容器与宿主机文件同步）

- 1.查看所有卷
`docker volume ls`

- 2.查看容器卷详细信息：
`docker inspect containerId `

- 3.创建卷
`docker volume create my-vol`
- 4.创建容器时指定卷
`docker run -v 主机路径:容器中路径`

- 5.删除容器时，连同卷一起删除
`docker rm -v 容器id`

- 6.清理所有无用卷
`docker volume prune`
- 7.dockerfile中创建镜像指定卷

`VOLUEME ["/data1","/data2"]`
以上,会在运行后的容器中的根目录中，分别创建 两个目录；

△缺点：以这种方式创建的卷，不能指定主机目录。而对应的目录默认是docker安装时指定的目录：/var/lib/docker/volumes/;
可通过docker inspect containerId 查看对应的自动生成的主机目录； 


## 八、容器备份（实质上应导出镜像进行转移）
### 第一种方式（导出容器）【不推荐】：

使用命令：docker export/import 相关进行操作；
缺点：
不能保留运行时相关信息，如把war包存放到tomcat，导出时，war包会被遗弃；

### 第二种方式（导出成镜像）【推荐】：
步骤：

1.导出：

1）提交当前容器状态，并根据当前容器 生成一个新的镜像:

docker commit 容器id 新创建的镜像名称

2）将新创建的镜像导出成tar:
docker save 新创建的镜像名称 > 镜像名称.tar

2.导入：
docker load < 镜像名称.tar
△查看容器运行日志
docker logs -f -t --tail 显示最后多少行 容器id
 

docker-comepose(用于启动N个镜像，一个项目中所需要用到的软件)

一、在任意文件夹下创建一个docker-compose.yaml文件，内容如下：
```
version: "3"
services:
    back-app:
        #1.镜像来源：根据指定镜像启动(二选一)
        image: 25.30.9.228:5000/back-app:v1.1.0
        #2.镜像来源：根据指定的Dockerfile所在目录来启动(二选一)
        build: /home/start-entry/back-app(绝对路径)
        build: ./back-app (相对当前目录路径)
        #若同时配置了image和build，那么将通过build创建一个 名为image配置的镜像
        
        
        #自定义启动后的镜像名称
        container-name: back-app-container
        #宿主机目录与容器目录映射
        volumes:
          #1.宿主机绝对路径目录:容器中绝对路径目录
          - /home/back-app/logs:/home/logs   
          #2.默认在容器内部创建一个数据卷，指向宿主机匿名位置[不推荐]
          - /home/logs
        #执行时，重启当前服务
        restart: always
        #启动映射端口：外部:内部
        ports:
          - "8181:8181"
        #将主机名写入到容器中的hosts文件
        extra_hosts:
          - "master:192.168.1.1"
          - "node1:192.168.1.2"
          - "node2:192.168.1.3"
        #当前镜像启动之前，必须等待以下服务启动完毕之后才能启动
        #depends_on:
           - mysql
           - kafka
        
    mysql:
        build: ./mysql
        ports:
          - "3306:3306"
    kafka:
        build: /home/start-entry/kafka
        ports:
          - "8787:8787"
```
二、启动docker-compose：
`docker-compose up -d(后台运行)`
三、相应软件启动成功，可通过docker ps查看。
四、停止docker-compose，并删除对应启动的容器：
`docker-compose down`
五、若更改了当前docker-compose.yaml关联配置（含dockerfile及镜像源），下次启动之前，请先执行：
`docker-compose build`
再执行启动：
`docker-compose up -d`
