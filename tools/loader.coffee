util = require "util"
http = require "http"

setInterval ->
	client = Math.floor(Math.random() * 3) + 1
	count = Math.floor(Math.random() * 100)
	util.log "generating #{count} requests, site=testclient#{client}"

	options = 
		host: 'localhost'
		port: 1200
		path: '/v10.g?account=vip32&site=testclient' + client

	for i in [0..count] 
		http.get(options, (res) -> 
			if res.statusCode != 200 then util.log "status: #{res.statusCode}"
		).on 'error', (err) ->
			util.log "error: #{err.message}"
, 5000