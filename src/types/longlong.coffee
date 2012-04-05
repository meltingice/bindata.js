class BinData.Type.LongLong extends BinData.DataType
  opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "Q"
      else "q"

    @readFormat code, data

  numBytes: -> 8

BinData.Record.registerType "longlong", (name) -> 
  @readType "LongLong", name

BinData.Record.registerType "ulonglong", (name) -> 
  @readType "LongLong", name, unsigned: true