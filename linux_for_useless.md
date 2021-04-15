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
