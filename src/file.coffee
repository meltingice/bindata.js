# Simulation and abstraction of a disk-based file.
# Provides methods to read the raw binary file data, which is stored in a 
# variable instead of read from disk. A lot of these functions are from C,
# but some of them are helper functions to make things a bit easier to
# understand.
BinData.File = class File
  @open: (path) ->
    data = fs.readFileSync path
    new File(data)

  constructor: (@data) ->
    # Track our current position in the file data. This is analogous to the
    # file pointer in C.
    @pos = 0

  # Get the current position in the file. This is here to parallel the C method
  tell: -> @pos

  # Read one or more bytes from the file. Note that this moves the file pointer
  # forward the number of bytes specified.
  read: (bytes) -> (@data[@pos++] for i in [0...bytes])

  # Move the file pointer to a new position. By default, this is done relative
  # to the current file pointer position. Setting the 2nd argument to false
  # causes the file pointer to move to the absolute location specified.
  seek: (amount, rel = true) ->
    if rel then @pos += amount else @pos = amount

  #
  # Helper functions so we don't have to remember the unpack
  # format codes.
  #
  
  # 4 bytes
  readInt: -> @readf(">i")[0]
  readUInt: -> @readf(">I")[0]

  # 2 bytes
  readShortInt: -> @readf(">h")[0]
  readShortUInt: -> @readf(">H")[0]

  # 4 bytes
  readLongInt: -> @readf(">l")[0]
  readLongUInt: -> @readf(">L")[0]

  # 8 bytes
  readDouble: -> @readf(">d")[0]

  # 1 byte
  readBoolean: -> @read(1)[0] isnt 0

  # Reads a string with the given length. Because some strings are also
  # null-byte padded, we strip out these null bytes since they are of no
  # use to us in Javascript.
  readString: (length) -> @readf(">#{length}s")[0].replace /\u0000/g, ""

  # Used for reading pascal strings, which are strings that have their length 
  # prepended to the chunk of character bytes. If a length isn't found, a 
  # string with the default length will be read instead.
  readLengthWithString: (defaultLen = 4) ->
    length = @read(1)[0]
    if length is 0
      str = @readString defaultLen
    else
      str = @readString length

    str
  
  # Reads from the file given the unpack format string. Format string codes 
  # can be easily referenced 
  # [from the Python docs](http://docs.python.org/library/struct.html#format-characters)
  readf: (format) -> jspack.Unpack format, @read(jspack.CalcLength(format))

  # Skips a block, assuming the next byte describes the size of the section.
  # An optional description is given to explain why we are skipping this block
  # instead of parsing it.
  skipBlock: (desc = "unknown") ->
    [n] = @readf('>L')
    @seek(n) if n # relative

    Log.debug "Skipped #{desc} with #{n} bytes"