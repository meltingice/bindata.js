# BinData.js

BinData.js is a simple and structured way to read and write binary data. Instead of having to remember a whole table of obscure character codes, you can write and encapsulate chunks of binary data together with ease.

BinData.js aims to be a very close port of [Ruby's BinData library](http://bindata.rubyforge.org/).

## Examples

**Data record definition**

``` coffeescript
class Rectangle extends BinData.Record
  endian: "little"
  define: ->
    @uint16 "len"
    @string "name", length: 4
    @uint32 "width"
    @uint32 "height"
```

**Reading a data record**

``` coffeescript
file = BinData.File.open("/path/to/file")
r = new Rectangle(file)
r.read()

console.log "Rectangle #{r.name} is #{r.width} x #{r.height}"
```