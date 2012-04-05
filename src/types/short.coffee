 class BinData.Type.Short extends BinData.DataType
  @opts:
    unsigned: false

  read: (data) ->
    code = switch @opts.unsigned
      when true then "H"
      else "h"

    @readFormat code, data

  numBytes: -> 2
