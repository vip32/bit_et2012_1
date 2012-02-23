http = require "http"
util = require "util"

server = http.createServer (req, res) ->
	res.writeHead 200, "Content-Type": "text/plain"
	res.write "Hello\n"
	setTimeout -> # callback, this is run on the eventloop
		res.end "World\n"
	, 2000
server.listen 1337, "127.0.0.1"

server.on "request", (req,res) ->
	util.log "incoming request"
	setTimeout ->
		util.log "* ready doing heavy things"
	, 10000
	util.log "done handling request"

# curl -i http://127.0.0.1:1337/
# tools\ab.exe  -c 100 -n 100 http://127.0.0.1:1337/ 