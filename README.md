# Usage

```
index="uptime"
type="log"

curl -XDELETE "http://localhost:9200/${index}"
curl -XPUT "localhost:9200/${index}"
curl -XPUT "localhost:9200/${index}/${type}/_mapping" -d @mapping.json
```
