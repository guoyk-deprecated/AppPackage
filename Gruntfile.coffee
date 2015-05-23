_            = require 'lodash'
path         = require 'path'
fs           = require 'fs'
walk         = require 'recursive-readdir'

config       = require './config'
bowerResolver= require './lib/bower_resolver'

module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    filerev_replace:
      dist:
        options:
          assets_root: 'dist'
          views_root:  'dist'
        src: 'dist/**/*.html'
    filerev:
      options:
        algorithm: 'md5'
        length: 8
      dist:
        src: ['dist/**/*', '!dist/vendor/**/*']
    watch:
      build:
        tasks: ['build']
        files: ['src/**/*']
    clean:
      build: ['build/*']
      dist:  ['dist/*' ]
    copy:
      dist:
        files: [{
          expand: true
          cwd: 'build'
          src: '**/*'
          dest:'dist'
        }]
      build:
        files: [{
          # HTML
          expand: true
          cwd: 'src'
          src: '**/*.html'
          dest: 'build/'
        }].concat(bowerResolver(grunt, config.bower, 'build/vendor'))
    htmlmin:
      dist:
        options:
          removeComments: true
          collapseWhitespace: true
        files:[{
          expand: true
          cwd: 'dist'
          src: ['**/*.html']
          dest:'dist'
        }]
    cssmin:
      dist:
        files:[{
          expand: true
          cwd: 'dist'
          src: ['**/*.css']
          dest: 'dist'
          ext: '.css'
        }]
    sass:
      build:
        options:
          style: 'expanded'
        files: [{
          expand: true
          cwd: 'src'
          src: ['**/*.scss']
          dest: 'build'
          ext: '.css'
        }]
    uglify:
      dist:
        files: [{
          expand: true
          cwd: 'dist'
          src: ['**/*.js']
          dest: 'dist'
          ext: '.js'
        }]
    coffee:
      build:
        files: [{
          expand: true
          cwd: 'src'
          src: ['**/*.coffee']
          dest: 'build'
          ext: '.js'
        }]

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-filerev'
  grunt.loadNpmTasks 'grunt-filerev-replace'

  grunt.registerTask 'manifest', 'create manifest.json and save to dist/', ()->
    # Go async
    done = @async()
    # chdir
    process.chdir 'dist'
    # get cfg, fileRev, mainRev
    cfg     = config.manifest
    fileRev = (grunt.filerev or {}).summary or {}
    mainRev = fileRev["dist/#{cfg.main}"]
    # manifest object
    manifest=
      version:  cfg.version
      main:     if mainRev then path.basename(mainRev) else cfg.main
      platform: cfg.platform
      downloadBaseUrl: cfg.downloadBaseUrl
      nextCheckAt: (new Date((Date.now() + (1000 * 3600 * 24 * parseInt(cfg.expire))))).toISOString()
      platformFiles: cfg.platformFiles
    walk "./", (err, files)->
      if err
        process.chdir '../'
        done err
      else
        manifest.files = files
        grunt.file.write 'manifest.json', JSON.stringify(manifest, null, ' ')
        process.chdir '../'
        done()

  grunt.registerTask 'default', [ 'build', 'watch:build' ]

  grunt.registerTask 'build', [
    'clean:build'
    'coffee:build'
    'sass:build'
    'copy:build'
  ]
  grunt.registerTask 'dist',  [
    'clean:dist'  # remove  dist/
    'build'       # build   build/js/, build/css, build/vendor
    'copy:dist'   # copy    build/**/*      -> dist/**/*
    'uglify:dist' # dist    dist/**/*.js    -> dist/**/*.js
    'cssmin:dist' # dist    dist/**/*.css   -> dist/**/*.css
    'htmlmin:dist'# dist    dist/**/*.html  -> dist/**/*.html
    'filerev:dist'# rename  dist/css/**/*.css, dist/js/**/*.js, dist/**/*.html
    'filerev_replace:dist'# rename  dist/css/**/*.css, dist/js/**/*.js, dist/**/*.html
    'manifest'    # create  manifest.json
  ]
