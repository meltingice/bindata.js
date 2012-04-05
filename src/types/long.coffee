 class BinData.Type.Long extends BinData.DataType
  @opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "L"
      else "l"

    @readFormat code, data

  numBytes: -> 4
