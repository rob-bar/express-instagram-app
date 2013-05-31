module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  # Project configuration.
  grunt.initConfig
    vendorlibs:['assets/js/vendor/*.js', 'assets/js/base.js']
    compass:
      app:
        options:
          require: [] #to use compass libs ex: 'compass-h5bp','ceaser-easing'
          sassDir: 'assets/css'
          cssDir: 'assets/css'
          imagesDir: 'assets/img'
          fontsDir: 'assets/font'
          httpPath: "/"
          relativeAssets: true
          boring: true
          debugInfo: true
          outputStyle: 'compressed'
          raw: 'preferred_syntax = :sass\n'

    coffee:
      app:
        expand: true,
        cwd: 'assets/coffee',
        src: ['*.coffee','**/*.coffee'],
        dest: 'assets/js',
        ext: '.js'
        options:
          sourceMap: true
          bare: false
          join: true

    jshint:
      app:
        options:
          sub: true
          boss: true
          expr: true
          eqnull: true
        files:
          src: ['assets/js/base.js', 'app.js']

    concat:
      options:
        stripBanners: true
      dist:
        src: '<%= vendorlibs %>',
        dest: 'assets/js/app.js'

    uglify:
      app:
        options:
          sourceMap: 'assets/js/app.js.map' # the sourcemap
        files:
          'assets/js/app.min.js': ['assets/js/app.js']

    watch:
      app:
        files: ['assets/coffee/**/*.coffee']
        tasks: ['coffee:app']
      server:
        files: ['assets/server/app.coffee']
        tasks: ['coffee:server']
      sass:
        files: ['assets/css/**/*.sass']
        tasks: ['compass']
      scss:
        files: ['assets/css/**/*.scss']
        tasks: ['compass']

  # Server task.
  grunt.registerTask 'server', ['coffee:server', 'jshint']
  # Default task.
  grunt.registerTask 'default', ['compass', 'coffee:app', 'jshint']
  # deploy
  grunt.registerTask 'deploy', ['compass', 'coffee:app', 'jshint', 'concat', 'uglify']
