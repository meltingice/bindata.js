class BinData.Type.Int extends BinData.DataType
  opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "I"
      else "i"

    @readFormat code, data

  numBytes: -> 4

BinData.Record.registerType ["int", "int32"], (name) -> 
  @readType "Int", name

BinData.Record.registerType ["uint", "uint32"], (name) ->
  @readType "Int", name, unsigned: true