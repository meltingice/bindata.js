 class BinData.Record
  endian: "native"
  data: {}

  constructor: (@file) ->

  define: ->

  read: -> @define()
  write: -> @define()
  toJSON: -> @data

  setData: (name, data) ->
    @data[name] = data
    Object.defineProperty @, name,
      get: -> @data[name]
      set: (value) -> @data[name] = value

  readType: (type, name, opts = {}) ->
    _.extend opts, endian: @endian

    item = new BinData.Type[type] opts
    item.read @file.read(item.numBytes())
    @setData name, item.snapshot()

  pad: (bytes) -> @file.read bytes

  char: (name) -> @readType "Char", name
  uchar: (name) -> @readType "Char", name, unsigned: true

  bool: (name) -> @readType "Bool", name

  short: (name) -> @readType "Short", name
  ushort: (name) -> @readType "Short", name, unsigned: true

  int: (name) -> @readType "Int", name
  uint: (name) -> @readType "Int", name, unsigned: true

  long: (name) -> @readType "Long", name
  ulong: (name) -> @readType "Long", name, unsigned: true

  longlong: (name) -> @readType "LongLong", name
  ulonglong: (name) -> @readType "LongLong", name, unsigned: true

  float: (name) -> @readType "Float", name
  double: (name) -> @readType "Double", name

  string: (name, opts = {}) -> @readType "String", name, opts
  stringz: (name, opts = {}) ->

  # Aliases
  int8: Record::char
  uint8: Record::uchar
  int16: Record::short
  uint16: Record::ushort
  int32: Record::int
  uint32: Record::uint