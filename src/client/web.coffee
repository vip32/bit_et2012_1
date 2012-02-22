express = require 'express'
if process.env.PORT? 
	env = require './env.heroku'
else
	env = require './env.local'

app = express.createServer(express.logger())
app.get "/", (request, response) ->
  response.send "<html><head><title>" + env.settings.web.name + "</title></head>       
	    <body>
	    	<h1>hello from client: [ip=" + request.header('x-forwarded-for') + ", env=" + env.settings.descr + ", account=" + env.settings.web.account + "]</h1>
		    <img height='1' width='1' alt='' src='http://" + env.settings.tracker.host  + ":" + env.settings.tracker.port  + "/v10.g?account=" + env.settings.web.account + "&site=" + env.settings.web.name + "'/>
	    </body>
	</html>"

app.listen env.settings.web.port, ->
  console.log "Listening on http://#{env.settings.web.host}:#{env.settings.web.port}"