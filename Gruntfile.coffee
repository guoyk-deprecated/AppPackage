module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      compile:
        tasks: ['compile']
        files: ['js/**/*.coffee', 'css/**/*.scss', '**/*.html']
    clean:
      compile: ['./build']
      dist:  ['./dist' ]
    copy:
      compile:
        html:
          src: '*.html'
          dest: './build/'
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

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['watch:compile']
  grunt.registerTask 'compile', ['clean:compile', 'coffee:compile', 'sass:compile', 'copy:compile' ]
