http = require("http")
events = require "events"
util = require "util"
fs = require("fs")
url = require("url")
qs = require("querystring")
env = require("./env")
timer = require("./timer")
pixel = require("./pixel")
db = require("./db")
argv = process.argv.slice(2) # heroku port

server = http.createServer (req, res) ->
  self = this
  url_parts = url.parse(req.url)
  util.log "tracker request: #{req.url}"
  switch url_parts.pathname
    when "/v10.g"
      res.writeHead 200, 
        "Content-Type": "image/gif"
        "Content-Disposition": "inline" 
        "Content-Length": "43"        
      res.end pixel.data()
      server.emit "record", 10, req, url_parts.query, timer.current
    else
      res.writeHead 404, "Content-Type": "text/html"
      res.end "404 Not Found"
      util.log "404 Not Found" + url_parts.pathname

port = argv[0] or process.env.PORT or env.settings.tracker.port
server.listen port
db.start server
db.logger 15000
util.log "tracker server started: #{port}"

