express = require  "express"

app = express.createServer()
app.get "/", (req, res) ->
  res.send "<h1>Hello World from express</h1>"

app.listen 3000
console.log "server running on port 3000"


# npm install express