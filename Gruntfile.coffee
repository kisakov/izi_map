module.exports = (grunt) ->
  grunt.initConfig
    copy:
      build:
        cwd: 'source',
        src: [ '**', '!**/*.coffee', '!**/*.sass', '!**/*.slim', 'img/*' ],
        dest: 'build',
        expand: true

    clean:
      build:
        src: [ 'build' ]
      stylesheets:
        src: [ 'build/**/*.css', 'build/application.css' ]
      scripts:
        src: [ 'build/**/*.js', 'build/application.js' ]
      images:
        src: [ 'build/img/*' ]

    coffee:
      build:
        expand: true,
        cwd: 'source',
        src: [ '**/*.coffee' ],
        dest: 'build',
        ext: '.js'

    sass:
      build:
        expand: true,
        cwd: 'source',
        src: [ '**/*.sass' ],
        dest: 'build',
        ext: '.css'

    uglify:
      build:
        options:
          mangle: false
        files:
          'build/application.js': [ 'build/**/*.js' ]

    cssmin:
      combine:
        files:
          'build/application.css': [ 'build/**/*.css' ]

    slim:
      build:
        expand: true,
        cwd: 'source',
        src: [ '**/*.slim' ],
        dest: 'build',
        ext: '.html'

    watch:
      scripts:
        files: 'source/**/*.coffee',
        tasks: [ 'scripts' ]
      stylesheets:
        files: 'source/**/*.sass',
        tasks: [ 'stylesheets' ]
      copy:
        files: [ 'source/**', '!source/**/*.coffee', '!source/**/*.sass', '!source/**/*.slim' ],
        tasks: [ 'copy' ]
      slim:
        files: 'source/**/*.slim',
        tasks: [ 'slim' ]

    connect:
      server:
        options:
          port: 4000,
          base: 'build',
          hostname: '*'

  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-slim')

  grunt.registerTask 'stylesheets',
    'Compiles the stylesheets.',
    [ 'clean:stylesheets', 'sass', 'cssmin' ]

  grunt.registerTask 'scripts',
    'Compiles the JavaScript files.',
    [ 'clean:scripts', 'coffee', 'uglify' ]

  grunt.registerTask 'build',
    'Compiles all of the assets and copies the files to the build directory.',
    [ 'clean:build', 'clean:images', 'copy', 'stylesheets', 'scripts', 'slim' ]

  grunt.registerTask 'default',
    'Watches the project for changes, automatically builds them and runs a server.',
    [ 'build', 'connect', 'watch' ]

