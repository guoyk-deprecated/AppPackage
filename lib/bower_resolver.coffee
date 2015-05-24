_           = require 'lodash'
pathModule  = require 'path'

module.exports = (grunt, config, tgtpath)->
  result = []
  _.each config.libs, (lib, name)->
    bowerJSON = grunt.file.readJSON "#{config.root}/#{name}/bower.json"
    bowerVer  = bowerJSON.version
    lname = name.toLowerCase()
    _.each lib, (path, folder)->
      if _.contains path, '*'
        result.push
          expand: true
          flatten: true
          src: "#{config.root}/#{name}/#{path}"
          dest:"#{tgtpath}/#{folder}/"
      else
        result.push
          src: "#{config.root}/#{name}/#{path}"
          dest:"#{tgtpath}/#{folder}/#{pathModule.basename(path)}"
  result
