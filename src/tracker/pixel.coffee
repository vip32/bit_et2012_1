fs = require("fs")
pixelData = undefined # needed?
pixel = new Buffer(43)

data = ->
  unless pixelData
    pixelData = fs.readFileSync(__dirname + "/tracking.gif", "binary")
    pixel.write(pixelData, "binary", 0)
  pixel

exports.data = data