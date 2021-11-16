linux
- `sed -i "1,3000d" xxx.log `删除日志前3000行
- `sudo mount -t tmpfs -o rw,size=10G tmpfs /xxx/xxx` 硬盘虚拟内存空间[csdn](https://www.cnblogs.com/djoker/p/8822376.html)
- [crontab在线解析](https://crontab.guru/#00_23_*_*_1-5)
- `stat -c %a ./test.txt ` 返回test.txt的权限数字形式
```
expect -c "
    set timeout -1
    spawn /xxx.../bin/xxx;
    %s
    expect {
    \"root:/xxx>\" {send -- \"exit\\r\";}
    }
    exit 0;
    "
```

```
一、查看哪些端口被打开 netstat -anp
二、关闭端口号:

iptables -A OUTPUT -p tcp --dport 端口号-j DROP
1
三、打开端口号：

iptables -A INPUT -ptcp --dport  端口号-j ACCEPT
1
四、保存设置

service iptables save
1
五、以下是linux打开端口命令的使用方法。
　　nc -lp 23 &(打开23端口，即telnet)
　　netstat -an | grep 23 (查看是否打开23端口)
六、linux打开端口命令每一个打开的端口，都需要有相应的监听程序才可以
```
