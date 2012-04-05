class BinData.Type.Double extends BinData.DataType
  read: (data) -> @readFormat "d", data
  numBytes: -> 4

BinData.Record.registerType "double", (name) -> @readType "Double", name