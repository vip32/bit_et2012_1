env = require("./env")
argv = process.argv.slice(2) # heroku port

# setup the webserver, always serves static index.html
start = ->
  server = require("http").createServer( (req, res) ->
    require("fs").readFile __dirname + "/index.html", (err, data) ->
      if err
        res.writeHead 500
        return res.end("Error loading index.html")
      res.writeHead 200
      res.end data
  )
  port = argv[0] or process.env.PORT or env.settings.web.port
  server.listen port
  console.log "dashboard server started:  #{port}"
  server

exports.start = start;
