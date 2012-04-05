class PascalString extends BinData.Record
  define: ->
    @uint8 "length"
    @string "str", length: @length

BinData.Record.registerRecord "pascalString", PascalString, (record) ->
  record.str