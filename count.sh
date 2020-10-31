url="https://open.feishu.cn/open-apis/bot/hook/6a060a5f-3b31-47c5-9a05-a66d86328669"
pv=`cat /root/nginx/logs/access.log |grep "/api"| sed -n /$(date "+%d\/%b\/%Y")/p | wc -l`
uv=`cat /root/nginx/logs/access.log | grep "/api"|sed -n /$(date "+%d\/%b\/%Y")/p | awk '{print $1}' | sort | uniq -c | wc -l`
sendMessage() {
    curl -X POST -H "Content-Type: application/json" -d '{"title": "当天pv/uv(不同ip)", "text": "'${1}'/'${2}'"}' "$3"
}
sendMessage $pv $uv $url
