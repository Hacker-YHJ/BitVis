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
        compass:
            dist:
                options:
                    sassDir: "sass/export"
                    cssDir: "build/css/"
                    environment: 'production'
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
        bower:
            install:
                options:
                    targetDir: 'build/lib'
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
        esteWatch:
            options:
                dirs: [
                    "coffee/**"
                    "jade/**"
                    "sass/**"
                    "build/**"
                ]
                livereload:
                    enabled: true
                    extensions: ['js', 'html', 'css']
                    port: 35729
            "coffee": (path) ->
                ['newer:coffee']
            "jade": (path) ->
                ['jade']
            "sass": (path) ->
                ['compass']
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-bower-task'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-este-watch'
    grunt.loadNpmTasks 'grunt-newer'
    grunt.registerTask 'make', ['bower', 'newer:coffee', 'jade', 'compass']
    grunt.registerTask 'default', ['make', 'connect', 'esteWatch']