class BinData.Type.Long extends BinData.DataType
  opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "L"
      else "l"

    @readFormat code, data

  numBytes: -> 4

BinData.Record.registerType "long", (name) -> 
  @readType "Long", name

BinData.Record.registerType "ulong", (name) ->
  @readType "Long", name, unsigned: true
