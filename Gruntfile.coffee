module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      build:
        tasks: ['build']
        files: ['js/**/*.coffee', 'css/**/*.scss', '**/*.html']
    clean:
      build: ['./build']
      dist:  ['./dist' ]
    copy:
      build:
        files: [{
          # HTML
          expand: true
          cwd: './'
          src: '*.html'
          dest: './build/'
        }, {
          # AngularJS
          expand: true
          flatten: true
          src: 'bower_components/angularjs/angular.js'
          dest: './build/js/'
        }]
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
      build:
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
      build:
        files: [{
          expand: true
          cwd: 'js/'
          src: ['*.coffee']
          dest: './build/js/'
          ext: '.js'
        }]

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', [ 'build', 'watch:build' ]
  grunt.registerTask 'build', [ 'clean:build', 'coffee:build', 'sass:build', 'copy:build' ]
