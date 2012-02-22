util = require "util"
qs = require "querystring"

if process.env.PORT? 
  conn = 'mongodb://heroku:heroku@staff.mongohq.com:10025/app2553413'
  util.log "db: #{conn}"
  db = require('mongoskin').db conn
else
  env = require './env'
  conn = "#{env.settings.db.host}:#{env.settings.db.port}/#{env.settings.db.name}"
  util.log "db: #{conn}"
  db = require('mongoskin').db conn

insertRecord = (name, record, callback) ->
  db.collection(name).insert record, (err, result) -> 
    if err then throw err
    callback err, result

updateStatRecord = (name, record, statrecord, callback) ->
  db.collection(name).update {account: record.account, site: record.site}, {$inc : statrecord}, { upsert: true, safe: true }, (err, result) -> 
    if err then throw err
    callback err, result

getCount = (name, callback) ->
  db.collection(name).count (err, result) -> 
    if err then throw err
    callback err, result

findSiteStats = (name, account, site, callback) ->
  db.collection(name).find({account: account, site: site}).toArray (err, result) -> 
    if err then throw err
    callback err, result

findAllStats = (name, callback) ->
  db.collection(name).find().toArray (err, result) -> 
    if err then throw err
    callback err, result

start = (server) ->
  server.on "record", (version, req, query, time ) ->
    record = createV10Record(req, query, time)
    # insertRecord "records", record, (err, result) ->
    #   util.log "record: " + JSON.stringify(record)
      
    statrecord = createV10StatRecord(req, query, time)
    updateStatRecord "statrecords", record, statrecord, (err, result) ->
        # util.log "statrecord: " + JSON.stringify(statrecord)
  util.log "db recorder started"

logger = (interval) ->
  # log what we have in the database
  setInterval ->
    # getCount "records", (err, result) ->
    #   util.log "record count: " + result

    getCount "statrecords", (err, result) ->
      util.log "statrecord total count: " + result

    findAllStats "statrecords", (err, result) ->
      for stat in result
        util.log "statrecord: #{stat.account}/#{stat.site}= " + stat.sum
      #util.log "all stats: \n" + JSON.stringify result
  , interval

exports.start = start
exports.logger = logger
exports.insertRecord = insertRecord
exports.updateStatRecord = updateStatRecord
exports.findSiteStats = findSiteStats
exports.findAllStats = findAllStats
exports.getCount = getCount

createV10Record = (req, query, time) ->
  record =
    hst: req.headers.host
    # ip: req.socket and (req.socket.remoteAddress or (req.socket.socket and req.socket.socket.remoteAddress))
    url: req.url
    ref: req.headers["referer"]
    uag: req.headers["user-agent"]

  if req.headers['x-forwarded-for']
    ips = req.headers['x-forwarded-for'].split(/[\s,]+/)
    record.ip = ips[ips.length-1].trim()

  (query or "").replace new RegExp("([^?=&]+)(=([^&]*))?", "g"), ($0, $1, $2, $3) ->
    record[$1] = qs.unescape($3.replace(/\+/g, " "))

  record.v = 10
  record.ux = time.unix
  record.hr = time.hour
  record.mi = time.minute
  record.mt = time.month
  record.yr = time.year
  record.dy = time.day
  record.wk = time.week
  record.yd = time.yday
  return record

createV10StatRecord = (req, query, time) ->
  record = {}
  record.v = 10
  record.sum = 1
  record[time.year + ".sum"] = 1
  record[time.year + ".week." + time.week + ".sum"] = 1
  record[time.year + ".day." + time.yday + ".sum"] = 1
  record[time.year + "." + time.month + ".sum"] = 1
  record[time.year + "." + time.month + "." + time.day + ".sum"] = 1
  record[time.year + "." + time.month + "." + time.day + "." + time.hour + ".sum"] = 1
  record[time.year + "." + time.month + "." + time.day + "." + time.hour + "." + time.minute + ".sum"] = 1
  return record

