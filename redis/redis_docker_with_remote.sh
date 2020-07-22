echo "创建redis服务，同时开启远程连接权限"
mkdir -p /root/docker/redis/data && mkdir -p /root/docker/redis/conf
cd /root/docker/redis/conf
touch redis.conf
bind="#bind 127.0.0.1"
mode="protected-mode no"
append="appendonly yes"
pas="requirepass 001028xj"
echo  -e "${bind}\n${mode}\n${append}\n${pas}"> redis.conf
docker run --name my_redis -p 6379:6379 -v /root/docker/redis/data:/data -v /root/docker/redis/conf/redis.conf:/etc/redis/redis.conf -d --restart=always redis redis-server /etc/redis/redis.conf
