 class BinData.Record
  endian: "native"
  _data: {}

  @registerType: (funcNames, cb) ->
    unless typeof funcNames is "object" and funcNames.length?
      funcNames = [funcNames]

    Record::[funcName] = cb for funcName in funcNames

  # Nested Record
  @registerRecord: (funcNames, record, cb) ->
    unless typeof funcNames is "object" and funcNames.length?
      funcNames = [funcNames]

    for funcName in funcNames
      Record::[funcName] = (name) ->
        r = new record(@file, @endian)
        r.read()
        
        @setData name, cb(r)

  constructor: (@file, endian = null) ->
    @endian = endian if endian?

  define: ->

  read: -> @define()
  write: -> @define()
  toJSON: -> @_data

  setData: (name, data) ->
    @_data[name] = data
    Object.defineProperty @, name,
      get: -> @_data[name]
      set: (value) -> @_data[name] = value

  readType: (type, name, opts = {}) ->
    _.extend opts, endian: @endian

    item = new BinData.Type[type] opts
    item.read @file.read(item.numBytes(@_data))
    @setData name, item.snapshot()

  pad: (bytes) -> @file.read bytes