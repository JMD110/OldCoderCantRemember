1       OpenStack CPS
1.1       查看主机上的组件的状态
                cps host-template-instance-list HOST_ID

1.2       查看nova服务组件的状态
                nova service-list

1.3       查看OpenStack中所有主机
                cps host-list

1.4       查看主机资源
                nova hypervisor-show HOST_ID

1.5       查看OpenStack内时钟同步
                 ntp time-delta --host all

1.6       查看主机详细配置信息
                cps host-show HOST_ID

1.7       重启某个指定服务
以nova-compute为例，有两种情况：所有节点的该服务全部重启，只重启指定节点的服务：

1 指定主机重启服务

cps host-template-instance-operate --action stop --service nova nova-comptue --host HOST_ID

cps host-template-instance-operate --action start --service nova nova-comptue --host HOST_ID

2 重启所有指定服务

cps host-template-instance-operate --action stop --service nova nova-compute

cps host-template-instance-operate --action start --service nova nova-compute

1.8       查看主机配置
包括查看主机配置列表、某个配置、更新某个配置，举例如下：

cps hostcfg-list：查看配置列表

cps hostcfg-show --type kernel default 如EVS的配置就在kernel中查看。

cps hostcfg-add --type kernel evs --copy-from default：新加一个配置组，配置从default复制。

cps hostcfg-item-update --parameter auto_hugepages=0 --item kernel.boot --type kernel evs ：修改配置中的某个配置。

2       虚拟机
2.1       查看虚拟机列表
nova list

2.2       查看虚拟机状态
nova show VM-ID

2.3       查看虚拟机规格
nova flavor-list 

2.4       创建虚拟机规格
nova flavor-create name（名字） id  ram（内存） disk（硬盘） vcpus（CPU核数）

如：nova flavor-create yy 10 16384 100 8

2.5       创建虚拟机
模板

nova  boot --image 0a906dd6-30aa-41c4-8665-7aad76131590（镜像ID） --flavor 33 （虚拟机规格编号）--nic net-id=42e27a29-90b0-4cee-81fa-c0c2f1c0bcac（网卡1） --nic net-id=a0cdd6b1-e50f-41bb-8c17-83bb449786fe（网卡2） I2000A（虚拟机名称）  --availability-zone az1.dc1:603EA7AC-8F88-E411-A8C8-000000821800（主机ID,可选项）

2.6       指定ip创建虚拟机
nova boot --flavor 12 --image b062fc2a-ee59-4674-bf82-7fc9b337b628 --nic net-id=6eb13333-156a-4d65-8017-181fc9efd12c,v4-fixed-ip=10.148.32.7 --nic net-id=24f25afe-df52-42a4-bc90-4345e368af66,v4-fixed-ip=10.148.32.71 MTServer --availability-zone az1.dc2:C0038281-0980-E411-A8C8-000000821800

2.7       重启虚拟机
nova stop VM_ID  nova start VM_ID 或者 nova reboot VM_ID 

2.8       删除虚拟机
nova delete VM_ID 

2.9       查看虚拟机所在单板
nova show VM_ID | grep host

2.10   查看虚拟机操作历史记录
nova instance-action-list VM_ID 

2.11   指定虚拟机请求查看虚拟机action记录
（定位时，发现某个请求失败，可以通过该命令查看到当时的错误原因）

nova instance-action VM_ID  REQ_ID

2.12   重置虚拟机状态
虚拟机由于某种异常，需要重置其状态为error或者active

nova reset-state VM_ID 重置为error

nova reset-state --active VM_ID，重置虚拟机状态为active

2.13   指定租户修改注入文件长度配额
nova quota-update tenant_id --injected-files 10 --injected-file-content-bytes 10485760

2.14   按照指定字段过滤虚拟机列表
nova list --all-t --field host,name


2.15   查看指定主机上的虚拟机
 nova list --all-t --host HOST_ID

2.16   开启和关闭虚拟机软件狗
nova meta a2c14063-6d36-4f50-9b4f-0a1719e74083（VM_ID） set __instance_vwatchdog=false
  nova meta a2c14063-6d36-4f50-9b4f-0a1719e74083（VM_ID） delete __instance_vwatchdog=false

3        网络   
3.1       查看虚拟网络平面
neutron net-list

3.2       查看物理网络平面
neutron physical-net-list

3.3       为虚拟机添加网卡
nova interface-attach --net-id NET_ID  VM_ID

3.4       创建外部网络
neutron net-create base（名称） --provider:network_type vlan（类型为VLAN） --provider:segmentation_id 1700（VLAN_ID） --provider:physical_network physnet2（物理网卡） --shared --router:external true

3.5       创建子网
neutron subnet-create base（子网名称） 10.148.32.0/26（子网段） --allocation-pool start=10.148.32.6,end=10.148.32.40 --name sub-base（名称） --gateway_ip=10.148.32.1（网关）

3.6       指定IP添加网卡
nova interface-attach CHG1（VM_name） --net-id caa92335-84aa-4061-8b70-dc8a98b8a870(net_id) --fixed-ip 192.168.6.122(ip)

3.7       删除网卡
nova show VM_ID 查看虚拟机的port-id

nova interface-detach  5882da8b-fea1-4291-869d-0dc4fef4a82a（VM_ID）  0ec1f964-4d3f-4e08-9ff4-fb338c345ed1 (port-id)

3.8       查看子网、端口等信息
查看网络状态：neutron net-show id

查看子网信息：neutron subnet-show subnet_id

查看子网使用的所有ip地址：neutron port-list |grep subnet_id

查看某个ip地址的使用情况：neutron port-show ip_id

3.9       查看做banding的trunk对应的物理网口的命令：
cat /sys/class/net/trunk0/bonding/slaves

3.10   bonding后查看逻辑网口与物理网卡对应关系：
cat /usr/bin/ports_info | python -m json.tool

3.11   查看网络规划
cps hostcfg-list

3.12   查看网络规划详情
cps hostcfg-show --type network group0

3.13   修改trunk的MTU值
cps hostcfg-item-update --item bond --bond-name trunk0 --bond-mode nobond --mtu 9000 --type network group*

cps commit

3.14   查看虚拟机网卡信息
nova interface-list VM_ID

3.15   查看某个port属于哪个虚拟机
neutron port-show port-id | grep device-id

3.16   各种网络问题排查命令
     16.1 ethtool ethX 主要关注link detected是否为yes，表示联通性ok。

     16.2 ethtool -i ethX 某些网络不通情况下，需要查看网卡固件版本是和虚拟机否兼容，同样的也可以在虚拟机上执行这个命令查看固件版本。

     16.3 OVS网络不通排查，虚拟机--主机--交换板网络排查：

            vconfig add trunk0 4012 //4012假设为虚拟机所在网络VLAN

            ifconfig trunk0.4012 192.168.100.100/24

            vconfig rem trunk0.4021 //排查完毕删除该接口

      16.4 EVS网络不通，初步排查命令

            ovs-vsctl get port tapport-id tag：用来查看虚拟机的port所带的VLAN，tapport-id是虚拟机port-id的前11位；

            ovs-vsctl list-br：查询所有的ovs网桥。

            ovs-vsctl add-port br-evs hnic1 00 -- set interface ：如果ifconfig hnic1没有这个设备，则添加这么个设备

            如果已经配置了hnic1，则查看下类型是否为hnic：ovs-vsctl list interface hnic1，查看type是否为hnic(默认是local_service)，如果不是如下

            ovs-vsctl -- set interface hnic1 type=hnic

            vconfig add hnic1 2016

            ifconfig hnic1.2016 192.168.201.6/24 //不要冲突了

            ifconfig hnic1 up

            vconfig rem hnic1.2016  // 排查完毕删除该接口

     16.5 硬直通网络不通，初步排查命令

            ip link show eth3 //eth3为用作硬直通的网卡

            ifconfig eth0 192.168.20.16/24 up，登陆虚拟机，配置IP

            vconfig add eth3 2016 // 登陆虚拟机所在主机，2016 为虚拟机eth0网卡所使用的vlan

            ifconfig eth3.2016 192.168.20.17/24 // 配置IP

            vconfig rem eth3.2016 //排查完毕删除该接口

     16.6 IP冲突排查，以下以FS external_api可能冲突为例，只关注命令

            非Haproxy所在节点配置：ip addr show external_api
            如果没有同网段的，需要配置一个IP：ip addr add 128.22.225/24 dev external_api
            重复操作arping 检测  正向代理、反向代理 IP 以及网关IP 是否有冲突：arping 128.22.22.10 -I external_api
            正常如下，只返回一个MAC地址，否则就是IP冲突了。

      注：交换机上配置对应VLAN的vlanif并配置测试IP，测试完要删除。

3.17   网络不通问题排查
关于tcpdump，有时候网络不通的问题，手段到了山穷水尽的时候，就试下这几个常用命令，附件有工具

      监视指定方向和接口的包1:tcpdump -i eth0 src host 10.126.1.222
      监视指定方向和接口的包2:tcpdump -i eth0 dst host 10.126.1.222

      监视指定主机和另外主机之间得通信：tcpdump host 10.126.1.222 and  (10.126.1.1 or 10.126.1.13 )

      更为详细的，直接参考大神的：http://3ms.huawei.com/hi/group/2692033/thread_386133.html?mapId=5074967

   

3.18   全局关闭安全组
#配置nova-compute。 在云数据中心场景，以对接FC为例，在FusionCompute的系统--第三方对接，可以看到是否需要开启安全组，尽管web-ui上可能已经全局关闭了安全组，但如果这里还是开启的，虚拟机也会出现安全组的典型虚拟机网络不通现象，此时需要排查这里。
cps template-params-update --service nova nova-compute --parameter security_group_api=nova firewall_driver=nova.virt.firewall.NoopFirewallDriver libvirt_vif_driver=nova.virt.libvirt.vif.LibvirtGenericVIFDriver

#配置neutron-server。
cps template-params-update --service neutron neutron-server --parameter firewall_driver=neutron.agent.firewall.NoopFirewallDriver
cps template-params-update --service neutron neutron-server --parameter enable_security_group=False 

#配置neutron-openvswitch-agent。
cps template-params-update --service neutron neutron-openvswitch-agent --parameter firewall_driver=neutron.agent.firewall.NoopFirewallDriver
cps template-params-update --service neutron neutron-openvswitch-agent --parameter enable_security_group=False

cps template-params-update --service neutron neutron-openvswitch-agent --parameter enable_ipset=False

 

3.19   安全组相关
安全组开关打开后，创建的虚拟机会加入到一个默认安全组，此时从外面ping该虚拟机默认是不通的，需要作如下处理。

安全组开关打开后，neutron 安全组相关的命令能够执行，如果没有开启，会报404

创建安全组

neutron security-group-create 安全组名称

B）为安全组增加规则

安全组内的虚拟机配置EIP后，能够从外部ping ，需要配置ICMP规则，方向为ingress：

neutron security-group-rule-create  名称或ID  –direction ingress  –protocol  ICMP –remote-ip-prefix 0.0.0.0/0     

安全组内的虚拟机配置EIP后，能够从外部SSH，需要配置TCP规则和端口号，方向为ingress：

neutron security-group-rule-create  名称或ID –direction ingress –protocol TCP –remote-ip-prefix 0.0.0.0/0 –port-range-min 0 –port-range-max 65535

安全组内的虚拟机配置EIP后，能够从外部SSH，需要配置UDP规则和端口号，方向为ingress：

neutron security-group-rule-create  名称或ID –direction ingress –protocol UDP –remote-ip-prefix 0.0.0.0/0 –port-range-min 0 –port-range-max 65535

4         存储   
4.1       查看卷列表
cinder list

4.2       删除卷
cinder delete volume_ID

4.3       查看存储服务及对接RAID状态
cinder service-list

4.4       查看存储标签名称和后端存储对应关系
cinder extra-specs-list

4.5       创建标签
cinder type-create 标签名

删除为cinder type-delete

4.6       标签映射RAID
cinder type-key SMSC01 set volume_backend_name=SMSC01 ///把标签名与RAID组对应

4.7       创建卷
usage: cinder create [--consisgroup-id <consistencygroup-id>]

                    [--snapshot-id <snapshot-id>]

                    [--source-volid <source-volid>]

                    [--source-replica <source-replica>]

                    [--image-id <image-id>] [--image <image>] [--name <name>]

                    [--description <description>]

                    [--volume-type <volume-type>]

                    [--availability-zone <availability-zone>]

                    [--metadata [<key=value> [<key=value> ...]]]

                    [--hint <key=value>] [--allow-multiattach]

                    [--shareable <&apos;T&apos;|&apos;F&apos;>]

                    [<size>]

例子：

host03:/home/fsp# cinder create --image-id fa25679d-84d3-47c0-ad76-4802dde80d99 --name zhltest3 10

4.8       卷映射给虚拟机
lun_smc_app映射的命令如下：

nova volume-attach 8d2d8828-5ae7-439b-bb7a-762a7697fe5e(VM_ID) fd8f890c-c872-43d4-b271-63ae2c770515(LUN_id)

4.9       解除映射命令
nova volume-detach VM-ID LUN-id

4.10   修改存储配额
cps template-params-update --service cinder cinder-api --parameter quota_gigabytes=-1（不限）

cps commit

4.11   修改FS创建LUN的数量
cps template-params-update --service cinder cinder-api --parameter quota_volumes=1000

cps commit

修改容量限制（可选，只在阿尔及利亚项目中修改过）

cps template-params-update --service cinder cinder-api --parameter use_default_quota_class=false

cps commit

4.12   查看存储相关参数
cps template-params-show --service cinder cinder-api

4.13   查看存储对接信息
cps template-params-show --service cinder cinder-volume

4.14   查看卷控制器：
如果接入存储失败时，需要查看卷控制器是否为fault状态，如果2个fault后，很大概率接入失败，需要重启卷控制器

cps template-instance-list --service cinder cinder-api

cinder-volumeControl -A RESTART

4.15   查看IO使用率
iostat -dmx 3

        举例：查看ceilometer逻辑磁盘IO使用情况： iostat -dmx 3 | grep dm-6


4.16   存储配额查看、修改
将所有租户的quota_snapshots配额修改为不限：
1）修改use_default_quota_class为False，目的是存储配额不使用系统默认值。
cps template-params-update --service cinder cinder-api --parameter use_default_quota_class=False
cps commit



2）修改cinder-api的对外配置项quota_snapshots=-1，不限快照。
cps template-params-update --service cinder cinder-api --parameter quota_snapshots=-1
cps commit
3）如果只需要对以后新创的租户生效，则操作结束，否则继续
4）针对已有的每个租户，找出租户ID，然后对每个租户ID执行如下命令，修改即可；
cinder quota-update [租户ID] --snapshots -1

 

5）如果只是还是要使用存储配额默认值，但是默认值又不够用，可以用这个命令修改：cinder quota-class-update --volumes -1 default

4.17   强制删除卷
由于cinder故障（磁阵连接数占满、磁阵密码过期等）可能导致再删除卷的时候出现卷一直处于deleting状态的情况，可以尝试在解决环境问题后，通过这个命令强制删除卷：cinder force-delete volume-id。

4.18   重置卷状态到available
cinder reset-state volumeId


5         镜像   
5.1       查看所有镜像
glance image-list

5.2       查看镜像属性
glance image-show iamge_id

5.3       虚拟机启动失败，报no bootable device
虚拟机启动失败，报no bootable device的情况下，可以下载镜像看下是否有问题，也可以使用：

glance image-download --progress --file file-name  image-id

5.4       查看镜像信息
qemu-img info file-name

5.5       上传镜像
glance image-create --name horizon_image --disk-format=qcow2 --container-format=bare --min-disk=50 --min-ram=4096 --property virtual_env_type=KVM  --file horizon-160527.qcow2 --progress  --如果提示--progress参数不存在，需要改变glance api版本：

      export OS_IMAGE_API_VERSION=1

5.6       删除镜像
glance image-delete image_id

如果protected = true而提示没有权限删除，需先执行glance image-update --protected False image_id后再删除

 

6         修改虚拟机网卡信息和默认路由   
1、 登录虚拟机。默认用户名和密码：root/Huawei123

2、 网卡信息位于etc/sysconfig/network/ifcfg-eth0文件中：

3、 输入 cd /etc/sysconfig/network到达指定目录，输入  vi ifcfg-eth0查看文件，按i进入编辑模式，把static改为dhcp，把文件中IP以及掩码数据删除（或依然保持static，然后把IP、掩码改为正确值），按Esc，然后输入:wq，保存退出。输入rcnetwork restart重启网卡，就可以DHCP获取IP

4、 修改默认路由，依然在上面的目录下，输入 vi routes，打开文件，输入：default 192.168.151.1 -- （注，此IP为网关IP）然后保存退出，输入rcnetwork restart重启网卡后，输入route –n，查看路由信息。

5、 添加路由：route add -net 10.205.30.64/26 gw 10.205.30.65

6、 添加默认路由：route add default gw 192.168.0.1

7        修改时区
1、 手动修改系统时间（高危操作，慎用）

date -s 月/日/年

date -s 时:分:秒

2、 强制同步系统时间

cps template-instance-list --service ntp ntp-server  //可以得到两个NTP主机

ssh到两个对应主机，date -s 修改系统时间（date –s 月/日/年  或date –s 时:分:秒）

ntp stop-hosts --host all

ntp result-show 查看状态为OK

ntp sync-time --host all

ntp result-show  //看到OK

ntp start-hosts --host all

ntp result-show  //看到OK

执行以下命令查看所有主机与时钟源的时间偏差

ntp time-delta --host all

8       强制启动虚拟机命令
如果发现虚拟机起不来，并且虚拟机的状态是error的，一般情况是由于设备启动顺序不合理导致（正常顺序是先上电存储，再上电服务器或E9000，如果是先上电E9000，再上电存储，就有可能出现这种情况），解决办法：

登陆首节点，执行环境变量

手动拉起有问题的虚拟机：

nova reset-state --active your-error-vm-uuid

nova reboot --hard your-error-vm-uuid

举例：

F1S2:/home/fsp # nova reset-state --active d5159fba-6bf2-4e8b-8844-b3ce64453b91

F1S2:/home/fsp # nova reboot --hard d5159fba-6bf2-4e8b-8844-b3ce64453b91

9         监控告警   
  

ceilometer sample-list -m host.stat -l 10 (加上 -q resource=hostID可以查询指定单板)，查询单板状态的采样指标。

ceilometer sample-list -m inst.state -l 10(加上 -q resource=instID可以查询指定虚拟机），查询虚拟机状态的采样指标。

ceilometer alarm-list | grep host.stat | grep hostID ,查询指定单板的告警记录。

ceilometer alarm-list | grep inst.state | grep instID,查询指定虚拟机的告警记录。

ceilometer alarm-history 告警ID，查询指定告警的历史记录。

cps template-instance-list --service mongodb mongodb ，查看mongodb服务状态

cps template-instance-list --service ceilometer ceilometer-agent-central ，查看ceilometer-agent-central服务状态

 

cps host-template-instance-operate --action stop --service mongodb mongodb (--host hostID)，停止mongodb服务，不指定hostID在所有节点执行。

cps host-template-instance-operate --action start --service mongodb mongodb 启动mongodb服务。

mongo mongodbIP，登陆mongodb查看状态，mongodbIP用 cat /etc/mongodb/mongodb.conf | grep bind_ip来查看，鉴权密码:**

 

10  gaussdb数据库
10.1   查看、更改数据库运行状态
支持在数据库主节点执行，所以要先查看数据库运行状态：
su gaussdba
gaussdba@linux:~> gs_ctl query -U gaussdba -P **
Ha state:
        LOCAL_ROLE                             : Primary                        ------数据库主备状态（Primary：主   Standby：备）
        STATIC_CONNECTIONS             : 1                          
        DB_STATE                                 : Normal                         ------数据库运行状态
        DETAIL_INFORMATION              : Normal
        ......
或者
cps template-instance-list --service gaussdb gaussdb，找到status是active的节点，然后登陆该节点执行接下来的命令。
重启：gaussdbControl  -A RESTART
停止：gaussdbControl  -S STOP

10.2   登陆数据库
su gaussdba
gsql nova
输入密码：**
切换组件数据库：\c keystone  
退出：\q   

10.3   数据库常用操作
查看所有数据库：\l
查看所有表：\dt
查看具体某张表：\d instances
查询nova数据库中instances表：select * from instances;
指定列查询：select id,uuid,vm_state,deleted from instances;
修改指定字段值：update instances set wm_state = 'deleted' where uuid= 'fd329d07-b4a1-4893-aaf6-1390cec69b59';
删除指定数据：delete from instances where resourceid = '136'
