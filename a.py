import requests
a = requests.get("http://api.bilibili.com/x/v1/dm/list.so?oid=11")
a.encoding="uft-8"
print(a.text)
