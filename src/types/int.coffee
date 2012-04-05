class BinData.Type.Int extends BinData.DataType
  @opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "I"
      else "i"

    @readFormat code, data

  numBytes: -> 4
