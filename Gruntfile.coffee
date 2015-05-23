module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    filerev:
      options:
        algorithm: 'md5'
        length: 8
      dist:
        src: ['dist/js/**/*.js', 'dist/css/**/*.css', 'dist/**/*.html', 'dist/img/**/*']
    watch:
      build:
        tasks: ['build']
        files: ['js/**/*.coffee', 'css/**/*.scss', '*.html']
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
          cwd: ''
          src: '*.html'
          dest: 'build/'
        }, {
          # AngularJS
          src: 'bower_components/angular/angular.js'
          dest: 'build/vendor/angular-1.3.15/js/angular.js'
        }, {
          # Angular Bootstrap
          src: 'bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
          dest: 'build/vendor/angular-bootstrap-0.13.0/js/ui-bootstrap-tpls.js'
        }, {
          # ngCordova
          src: 'bower_components/ngCordova/dist/ng-cordova.js'
          dest: 'build/vendor/ng-cordova-0.1.15/js/ng-cordova.js'
        }, {
          # Bootstrap CSS
          src: 'bower_components/bootstrap/dist/css/bootstrap.css'
          dest: 'build/vendor/bootstrap-3.1.1/css/bootstrap.css'
        }, {
          # Bootstrap Fonts
          expand: true
          flatten: true
          src: 'bower_components/bootstrap/dist/fonts/*'
          dest: 'build/vendor/bootstrap-3.1.1/fonts/'
        }]
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
          cwd: 'css'
          src: ['*.scss']
          dest: 'build/css/'
          ext: '.css'
        }]
    uglify:
      dist:
        files: [{
          expand: true
          cwd: 'dist/'
          src: ['**/*.js']
          dest: 'dist/'
          ext: '.js'
        }]
    coffee:
      build:
        files: [{
          expand: true
          cwd: 'js/'
          src: ['*.coffee']
          dest: 'build/js/'
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
  ]
