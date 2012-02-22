util = require("util")
server = require("./server").start()
db = require("../tracker/db")

# setup the socket.io connection and room joining
io = require("socket.io").listen(server)
io.set('log level', 2); 
io.sockets.on "connection", (socket) ->
  socket.emit "message", data: "welcome message for client"
  socket.on "join room", (room) ->
    if room
      socket.join room
      console.log "client joined room: " + room
    else
      console.log "no room specified, not joining any room"

# regularly push statrecords to the clients in the rooms
setInterval ->
  if db?
    db.findAllStats "statrecords", (err, result) ->
      for statrecord in result
        util.log "dashboard statrecord emit: #{statrecord.site}" 
        io.sockets.in(statrecord.site).emit 'statrecord', statrecord
  else
    io.sockets.emit "message", data: "database not found"
, 3000