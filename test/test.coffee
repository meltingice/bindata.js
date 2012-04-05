{BinData} = require '../lib/bindata.js'

# Our header definition
class PSDHeader extends BinData.Record
  # >4sH 6B HLLHH
  endian: "big"

  define: ->
    @string "signature", length: 4
    @pad 4
    @short "version"

    @uint8  "a"
    @uint8  "b"
    @uint8  "c"
    @uint8  "d"
    @uint8  "e"
    @uint8  "f"

    @short "channels"
    @long "rows"
    @long "cols"
    @short "depth"
    @short "mode"

file = BinData.File.open __dirname + "/files/test.psd"
header = new PSDHeader(file)
header.read()

console.log "PSD signature: #{header.signature}"
console.log "PSD size is #{header.rows} x #{header.cols}"