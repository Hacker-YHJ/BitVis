module.exports = (grunt) =>
  grunt.initConfig
    jade:
      compile:
        options:
            pretty: true
        files: [
            expand: true
            cwd: 'jade'
            src: ['*.jade']
            dest: 'build/'
            ext: '.html'
        ]
      dist:
        options:
            pretty: true
        files: [
            expand: true
            cwd: 'jade'
            src: ['*.jade']
            dest: 'release/'
            ext: '.html'
        ]
    compass:
      compile:
        options:
          sassDir: "sass/"
          cssDir: "build/css/"
          environment: 'production'
      dist:
        options:
          sassDir: "sass/"
          cssDir: "build/css/"
          environment: 'development'
    coffee:
      compile:
        options:
          bare: true
        files: [
          expand: true
          cwd: 'coffee'
          src: ['**/*.coffee']
          dest: 'build/js/'
          ext: '.js'
        ]
      release:
        options:
          bare: true
        files: [
          expand: true
          cwd: 'coffee'
          src: ['**/*.coffee']
          dest: 'release/js/'
          ext: '.js'
        ]
    bower:
      install:
        options:
          targetDir: 'build/lib'
          layout: 'byComponent'
          install: true
          cleanTargetDir: true
          cleanBowerDir: false
      dist:
        options:
          targetDir: 'release/lib'
          layout: 'byComponent'
          install: true
          cleanTargetDir: true
          cleanBowerDir: false
    connect:
      server:
        options:
          port: 2333
          hostname: "*"
          base: 'build'
          livereload: 35729
    watch:
      css:
        files: 'sass/**'
        tasks: ['compass:dev']
        options:
          spawn: false
          livereload: 35729
      jade:
        files: 'jade/**'
        tasks: ['jade']
        options:
          spawn: false
          livereload: 35729
      coffee:
        files: 'coffee/**'
        tasks: ['coffee']
        options:
          spawn: false
          livereload: 35729
    copy:
      dev:
        src: 'img/**'
        dest: 'build/img'
      dist:
        src: 'img/**'
        dest: 'release/img'

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'remake', ['bower:install', 'coffee:compile', 'jade:compile', 'compass:compile', 'copy:dev']
  grunt.registerTask 'make', ['coffee:compile', 'jade:compile', 'compass:compile']
  grunt.registerTask 'server', ['connect', 'watch']
  grunt.registerTask 'default', ['remake', 'connect', 'watch']
  grunt.registerTask 'release', ['bower:dist', 'coffee:dist', 'jade:dist', 'compass:dist', 'copy:dist']