### 查看远程端口是否开放？
+ nc -vz -w 2 110.43.33.82 18371 #macos
+ telnet 0.0.0.0 3000 

### scp相关
+ scp xx root@0.0.0.0:/
+ -r 递归复制整个

### nohup 相关
+ 覆盖nohup文件内容: cp /dev/null nohup.out
### gitlab
```
docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner:latest

```
