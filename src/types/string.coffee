class BinData.Type.String extends BinData.DataType
  opts: 
    length: 4

  read: (data) ->
    code = "#{@opts.length}s"
    @readFormat code, data

  numBytes: -> @opts.length

BinData.Record.registerType "string", (name, opts = {}) -> 
  @readType "String", name, opts