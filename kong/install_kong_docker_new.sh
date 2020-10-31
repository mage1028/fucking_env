docker run -d --name kong-database --network=host \
-p 5432:5432 \
-e "POSTGRES_USER=kong" \
-e "KONG_PG_PASSWORD=gaoshi1024" \
-e "POSTGRES_DB=kong" postgres:9.6 