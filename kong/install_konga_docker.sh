echo "需要先完成kong"
docker run --rm  --network=kong-net pantsel/konga:latest -a postgres -u postgres://konga:password@konga-database:5432/konga

docker run -d -p 1337:1337  \
               --network kong-net  \
               -e "DB_ADAPTER=postgres"  \
               -e "DB_URI=postgres://konga:password@konga-database:5432/konga"  \
               -e "NODE_ENV=production"  \
               -e "DB_PASSWORD=konga" \
               --name konga \
               pantsel/konga

docker run -p 1337:1337 \
             --network kong-net \
             --name konga \
             -e "NODE_ENV=production" \
             -e "TOKEN_SECRET=kjgdfjFLGNKFNG#(#(" \
             pantsel/konga

docker run -p 1337:1337  --network host  -e "TOKEN_SECRET=beichuiyunle.."  -e "DB_ADAPTER=mongo"  -e "DB_URI=mongodb://root:Football9668#@139.159.195.211:27017" -e "NODE_ENV=production"  --name konga pantsel/konga:latest
