class BinData.Type.Short extends BinData.DataType
  opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "H"
      else "h"

    @readFormat code, data

  numBytes: -> 2

BinData.Record.registerType ["short", "int16"], (name) -> 
  @readType "Short", name

BinData.Record.registerType ["ushort", "uint16"], (name) -> 
  @readType "Short", name