BinData.DataType = class DataType
  opts = {}
  defaults:
    endian: "native"
    initialValue: null
    length: null

  data: null

  constructor: (options = {}) ->
    @opts = _.defaults options, @defaults, @opts

    @e = switch @opts.endian
      when "native" then "@"
      when "native-standard" then "="
      when "little" then "<"
      when "big" then ">"

    @data = @opts.initialValue

  # This does nothing by default. Override it.
  read: (data) -> @data = data

  readFormat: (format, data) ->
    file = new File(data)
    @data = file.readf format

  assign: (value) -> @data = value
  clear: -> @data = @opts.initialValue
  isClear: -> @data is @opts.initialValue

  numBytes: -> # Override this.
  snapshot: -> @data
  toString: -> @data