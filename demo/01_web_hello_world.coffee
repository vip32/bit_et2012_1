http = require "http" 

# =========================================
# a simple non-blocking webserver 
# =========================================
server = http.createServer (req, res) ->
	res.writeHead 200, "Content-Type": "text/plain"
	res.write "Hello\n"
	setTimeout ->
		res.end "World\n"
	, 2000
server.listen 1337, "127.0.0.1"

# curl -i http://127.0.0.1:1337/
# ..\..\tools\ab.exe  -c 100 -n 100 http://127.0.0.1:1337/