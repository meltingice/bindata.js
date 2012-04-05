 class BinData.Type.Double extends BinData.DataType
  read: (data) -> @readFormat "d", data
  numBytes: -> 4
