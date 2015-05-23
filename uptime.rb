#!/usr/bin/env ruby
# coding: utf-8

require "date"
require "json"

index = "uptime"
type = "log"

# `curl -XDELETE "http://localhost:9200/#{index}"`
# `curl -XPUT "localhost:9200/#{index}"`
# `curl -XPUT localhost:9200/#{index} -d '{
#   "mappings": {
#     "#{type}": {
#       "properties": {
#         "time": { "type": "date", "format": "yyyy-MM-dd HH:mm:ss Z" },
#         "load_average": { "type": "float" },
#         "minute" : { "type": "integer"}
#       }
#     }
#   }
# }'`

date = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")

tmp = `uptime | perl -ne "print /load averages: (.*?)$/"`.split(" ").map{|item| item.to_f}
[1, 5, 15].each_with_index{|minute, idx|
  id = "#{minute} #{date}"
  puts "{ \"index\" : { \"_index\" : \"#{index}\", \"_type\" : \"#{type}\", \"_id\" : \"#{id}\"} }"
  result = {"minute" => minute,
            "load_average" => tmp[idx]}
  puts result.to_json
}
