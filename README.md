# BinData.js

BinData.js is a simple and structured way to read and write binary data. Instead of having to remember a whole table of obscure character codes, you can write and encapsulate chunks of binary data together with ease.

BinData.js aims to be a very close port of [Ruby's BinData library](http://bindata.rubyforge.org/).

## Examples

** Data record definition **

``` coffeescript
class Rectangle extends BinData.Record
  endian: "little"
  parse: ->
    @uint16 "len"
    @string "name", readLength: len
    @uint32 "width"
    @uint32 "height"
```

** Reading a data record **

``` coffeescript
file = new BinData.File("/path/to/file")
r = Rectangle.read file

console.log "Rectangle #{r.name} is #{r.width} x #{r.height}"