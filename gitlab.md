### 迁移遇到的坑
#### 权限
+ 发现权限出现了问题
```
remote: /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_logger.rb:42:in `initialize': Permission denied @ rb_sysopen - /var/log/gitlab/gitaly/gitlab-shell.log (Errno::EACCES)
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_logger.rb:42:in `open'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_logger.rb:42:in `initialize'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_logger.rb:132:in `new'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_logger.rb:132:in `<top (required)>'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_metrics.rb:2:in `require_relative'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_metrics.rb:2:in `<top (required)>'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_custom_hook.rb:3:in `require_relative'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/lib/gitlab_custom_hook.rb:3:in `<top (required)>'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/hooks/pre-receive:20:in `require_relative'
remote:         from /opt/gitlab/embedded/service/gitaly-ruby/gitlab-shell/hooks/pre-receive:20:in `<main>'
To ssh://110.43.34.88:8222/mage/bilibili-golang-spider.git
 ! [remote rejected] mage -> mage (pre-receive hook declined)
error: 推送一些引用到 'ssh://git@110.43.34.88:8222/mage/bilibili-golang-spider.git' 失败
```
+ 尝试使用git clone 仍然出错
+ 登陆docker容器检查
```
su git
cat ~/.ssh/authorized_keys
command="/opt/gitlab/embedded/service/gitlab-shell/bin/gitlab-shell key-1",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDq43HdJgZMM+qXmYMDGMSo266nOTsu8/9k1GoQVbUIH1V5XTUPk0ar/LN6VhGXkoF8IVi69Ui9TwX4XraAAsvPF3Lys/5dpXM5DQZqJDu51HLdPwHR63zw68L1gHhjletIYcL42mKXA3/t+ZrVEN9FnSL52Nj+Q110JcKhw4YM4E0NX6w5amf/KvA2A7H7YUH3TSywPyh1En7uHQXiQDXXLiZJfHoYDkmOJLt5Te1e5fN9rVydb5SnE4/zDRr60op1f/v+jbO+vLOmqZVMjvXYvKmTYQ8MeAM4nvxJNwh82jxaMQ+sGV9u3dXFFCgqjbKsSlfbRj+F8MrCHsAlk0/1lT/MX5p+cqTH/jo/tKOGGcT9IfJ2AnUQeWuDA1rNe/Li9ON1/WiOGNCpuhCzXr06DDMKkUsuIQYr/PRmpfPscO+NG9RTvMVr/ZPhVeQOypSD2cv+gBxYOY8GhbtCQ9YysvPikyXS0kp0j3dlWzcXuXL7sLqbvbKb6b3/MeLcfis=
###################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################
#######################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################
```
发现pubKey还是没问题，问题并没有解决
+ 解决问题
```
I solve this issue using with:
# chown 998:998 /var/log/gitlab/gitaly/gitlab-shell.log

998 is the git user
```
#### 项目路径
更改host文件
```
 cd /opt/gitlab/embedded/service/gitlab-rails/config    
```
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 8443:443 --publish 8880:8880 --publish 8222:22 --publish 4567:4567 \
  --name gitlab1 \
  --restart always \
  --volume ~/gitlab/config:/etc/gitlab \
  --volume ~/gitlab/logs:/var/log/gitlab \
  --volume ~/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest