module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      build: ['./build']
      dist:  ['./dist' ]
    sass:
      dist:
        options:
          style: 'compressed'
        files: [{
          expand: true
          cwd: 'css'
          src: ['*.scss']
          dest: './dist/css/'
          ext: '.css'
        }]
      compile:
        options:
          style: 'expanded'
        files: [{
          expand: true
          cwd: 'css'
          src: ['*.scss']
          dest: './build/css/'
          ext: '.css'
        }]
    uglify:
      dist:
        files: [{
          expand: true
          cwd: './build/js/'
          src: ['*.js']
          dest: './dist/js/'
          ext: '.js'
        }]
    coffee:
      compile:
        files: [{
          expand: true
          cwd: 'js/'
          src: ['*.coffee']
          dest: './build/js/'
          ext: '.js'
        }]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['clean:build', 'coffee:compile', 'sass:compile']
