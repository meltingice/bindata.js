class BinData.Type.Char extends BinData.DataType
  opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "B"
      else "b"

    @readFormat code, data

  numBytes: -> 1

BinData.Record.registerType ["char", "int8"], (name) -> 
  @readType "Bool", name

BinData.Record.registerType ["uchar", "uint8"], (name) -> 
  @readType "Bool", name, unsigned: true