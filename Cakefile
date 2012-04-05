fs      = require 'fs'
{exec, spawn}  = require 'child_process'
util    = require 'util'
{jsmin} = require 'jsmin'

targetName    = "bindata"

###
CoffeeScript Options
###
csSrcDir      = "src"
csTargetDir   = "lib"

depsDir        = "deps"

targetCoffee  = "#{csSrcDir}/build"

targetCoreJS      = "#{csTargetDir}/#{targetName}.js"
coffeeCoreOpts    = "-r coffeescript-growl -j #{targetName}.js -o #{csTargetDir} -c #{targetCoffee}.coffee"

# All source files listed in include order
coffeeFiles   = [
  "bindata"
  "log"
  
  "file"
  "record"
  "datatype"
]

###
Event System
###
finishedCallback = {}
finished = (type) ->      
  finishedCallback[type]() if finishedCallback[type]?

finishListener = (type, cb) ->
  finishedCallback[type] = cb

###
Options
###
option '-f', '--file [FILE]', 'Test file to load (for debugging)'

###
Tasks
###
task 'debug', 'Run in debug mode with node-inspector', (opts) ->
  throw "Must specify a file with -f" if not opts.file

  debug = spawn 'coffee', ['--nodejs', '--debug-brk', opts.file]
  debug.stdout.on 'data', (data) -> console.log data

  insp = spawn 'node-inspector'
  insp.stdout.on 'data', (data) -> util.log data

  exec 'open http://127.0.0.1:8080/debug?port=5858'

task 'docs', 'Generates documentation for the coffee files', ->
  util.log 'Invoking docco on the CoffeeScript source files'
  
  files = coffeeFiles
  files[i] = "#{csSrcDir}/#{files[i]}.coffee" for i in [0...files.length]

  exec "docco #{files.join(' ')}", (err, stdout, stderr) ->
    util.log err if err
    util.log "Documentation built into docs/ folder."
        
task 'watch', 'Automatically recompile the CoffeeScript files when updated', ->
  util.log "Watching for changes in #{csSrcDir}"
  
  for jsFile in coffeeFiles then do (jsFile) ->
    fs.watchFile "#{csSrcDir}/#{jsFile}.coffee", (curr, prev) ->
      if +curr.mtime isnt +prev.mtime
        util.log "#{csSrcDir}/#{jsFile}.coffee updated"
        invoke 'build'
        
task 'build', 'Compile and minify all CoffeeScript source files', ->
  finishListener 'js', ->
  invoke 'compile'

task 'compile', 'Compile all CoffeeScript source files', (opts) ->
  util.log "Building #{targetCoreJS}"
  contents = []
  remaining = coffeeFiles.length

  console.log "\n### Core Library ###\n"
  util.log "Appending #{coffeeFiles.length} core files to #{targetCoffee}.coffee"
  
  for file, index in coffeeFiles then do (file, index) ->
    fs.readFile "#{csSrcDir}/#{file}.coffee", "utf8", (err, fileContents) ->
      util.log err if err
      
      contents[index] = fileContents
      util.log "[#{index + 1}] #{file}.coffee"
      process() if --remaining is 0
      
  process = ->
    # Automatically add types
    console.log "\n### Data Types ###\n"
    types = fs.readdirSync "#{csSrcDir}/types"
    for type in types
      util.log "Adding datatype #{type}"
      contents.push "\n" + fs.readFileSync("#{csSrcDir}/types/#{type}", "utf8") + "\n";

    # Automatically add dependencies
    console.log "\n### Dependencies ###\n"
    contents.unshift "###\nEND DEPENDENCIES\n###\n\n"
    deps = fs.readdirSync depsDir
    for dep in deps
      util.log "Adding dependency #{dep}"
      contents.unshift "`" + fs.readFileSync("#{depsDir}/#{dep}", "utf8").replace(/`/g, "'") + "`\n\n"

    core = contents.join("\n\n")

    fs.writeFile "#{targetCoffee}.coffee", core, "utf8", (err) ->
      util.log err if err
      
      exec "./node_modules/.bin/coffee #{coffeeCoreOpts}", (err, stdout, stderr) ->
        util.log err if err
        util.log "Compiled #{targetCoreJS}"
        #fs.unlink "#{targetCoffee}.coffee"

        finished('js')
        
task 'minify', 'Minify the CoffeeScript files', ->
  util.log "Minifying #{targetCoreJS}"
  fs.readFile targetCoreJS, "utf8", (err, contents) ->
    fs.writeFile targetCoreMinJS, jsmin(contents), "utf8", (err) ->
      util.log err if err