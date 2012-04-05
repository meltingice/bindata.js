class BinData.Type.Bool extends BinData.DataType
  read: (data) -> @readFormat "?", data
  numBytes: -> 1
