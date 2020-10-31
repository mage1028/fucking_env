echo "安装 kong 加入数据库挂载和密码"

docker network create kong-net

docker run -d --name kong-database --network=kong-net -p 5432:5432 -v ~/db/postgresql:/var/lib/postgresql/data -e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" -e "POSTGRES_PASSWORD=gaoshi1024" postgres:9.6

docker run --rm --network=kong-net -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" -e "KONG_PG_PASSWORD=gaoshi1024" kong:latest kong migrations bootstrap

docker run -d --name kong \
 --network=kong-net \
 -e "KONG_DATABASE=postgres" \
 -e "KONG_PG_HOST=kong-database" \
 -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
 -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
 -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
 -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
 -e "KONG_PG_PASSWORD=gaoshi1024" \
 -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
 -p 80:80 \
 -p 8443:8443 \
 -p 8001:8001 \
 -p 8444:8444 \
 kong
