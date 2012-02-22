events = require "events"
util = require "util"

# =========================================
# create the pulser class, emit pulses
# =========================================
class Pulser extends events.EventEmitter
	start: =>
		self = this
		@id = setInterval ->
			util.log ">>>> emit pulse"
			self.emit "pulse", "data:data"
			, 1000

# ==========================================
# demonstrate the pulser by receiving events
# ==========================================
pulser = new Pulser()
pulser.on "pulse", (data) ->
	util.log "<<<< pulse received! " + data
pulser.start()

     