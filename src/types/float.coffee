 class BinData.Type.Float extends BinData.DataType
  read: (data) -> @readFormat "f", data
  numBytes: -> 4
