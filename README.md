解决一些环境问题 自用
docker docker安装
redis redis安装并开启远程
kong kong的docker安装并启动
docker run -d --name kong-database --network=kong-net -p 5432:5432 - v kong-volume:/var/lib/postgresql/data -e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" postgres:9.6
