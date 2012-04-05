class BinData.Type.Char extends BinData.DataType
  @opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "B"
      else "b"

    @readFormat code, data

  numBytes: -> 1
