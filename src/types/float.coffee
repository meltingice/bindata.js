class BinData.Type.Float extends BinData.DataType
  read: (data) -> @readFormat "f", data
  numBytes: -> 4

BinData.Record.registerType "float", (name) -> @readType "Float", name