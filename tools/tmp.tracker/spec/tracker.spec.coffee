should = require 'should'
http = require 'http'
env = require '../env'

describe "the tracker", ->
  options = 
	  host: "localhost"
	  port: env.settings.tracker.port
	  path: "/v10.g"

  req = http.get(options, (res) ->
    console.log "response: " + res.statusCode
    a =true
    res.on "data", (chunk) ->
      console.log "body: " + chunk
    ).on("error", (e) -> console.log "error: " + e.message)
  req.end

  it "is serving the image", ->
    req.should.not.equal undefined
    req.finished.should.equal true
    #req.should.equal 200
