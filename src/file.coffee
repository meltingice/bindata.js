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
  
  # Reads from the file given the unpack format string. Format string codes 
  # can be easily referenced 
  # [from the Python docs](http://docs.python.org/library/struct.html#format-characters)
  readf: (format) -> jspack.Unpack format, @read(jspack.CalcLength(format))