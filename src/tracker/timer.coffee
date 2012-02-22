util = require "util"
moment = require "./moment"

updateTime = ->
  now = moment()
  unix: now.valueOf
  hour: now.format("HH")
  minute: now.format("mm")
  year: now.format("YYYY")
  month: now.format("MM")
  day: now.format("DD")
  week: now.format("ww")
  yday: now.format("DDDD")
  offset: now.zone()
  
current = updateTime()
setInterval ->
  current = updateTime()
  exports.current = current
  util.log "time updated: #{current.year}-#{current.month}-#{current.day},#{current.week}-#{current.yday} #{current.hour}:#{current.minute}"
, 5000

exports.current = current
