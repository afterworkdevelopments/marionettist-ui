# npm install -D gulp gulp-concat gulp-util gulp-uglify gulp-coffee gulp-rollup gulp-sourcemaps

gulp           = require("gulp")
gutil          = require("gulp-util")
sass           = require("gulp-sass")
cssImport      = require("gulp-cssimport")
cssmin         = require('gulp-cssmin')
concat         = require("gulp-concat")
rename         = require('gulp-rename')
uglify         = require("gulp-uglify")
runSequence    = require('run-sequence').use(gulp)
rollup         = require("rollup")
sourcemaps     = require("gulp-sourcemaps")
pkg            = require("./package.json")
pagakeName     = pkg.name
coffee         = require("rollup-plugin-coffee-script")
hamlc          = require("gulp-haml-coffee-compile")

gulp.task "hamlc", ()->
  options =
    compile:
      includePath: true
      pathRelativeTo: "./src/lib"
  gulp.src("./src/**/**/**/**/*.hamlc")
    .pipe(hamlc(options).on("error", gutil.log))
    .pipe(concat("templates.js"))
    .pipe(gulp.dest("./dist"))


gulp.task 'bundle', ->
  rollup.rollup(
    entry: "./src/#{pagakeName}.coffee"
    plugins: [ coffee() ]
  ).then (bundle) ->
    bundle.write
      dest: "./dist/#{pagakeName}.js"
      sourceMap: true
      moduleName: "Marionettist"
      format: "umd"
      exports: "default"
      external: ["marionettist"]
      plugins: [coffee()]
      globals:
        'marionettist': "Marionettist"



gulp.task "sass", ()->
  gulp.src("./src/#{pagakeName}.sass")
    .pipe(sourcemaps.init())
    .pipe(sass({}).on('error', sass.logError))
    .pipe(cssImport())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest("./dist"))

gulp.task "sass-minify", ()->
  gulp.src("./dist/#{pagakeName}.css")
    .pipe(cssmin())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest('./dist'));

gulp.task "minify", ()->
  console.log "Minify"
  return gulp.src(["./dist/#{pagakeName}.js"])
    .pipe(uglify())
    .pipe(concat("#{pagakeName}.min.js"))
    .pipe(gulp.dest("./dist"))



gulp.task "watchfiles", ()->
  console.log "Watchfiles"
  gulp.watch "./src/**/**/**/*.coffee" , (callback)->
    runSequence('bundle', "minify")
  gulp.watch "./src/#{pagakeName}.sass" , (callback)->
    runSequence("sass", "sass-minify")
  gulp.watch "./src/**/**/**/*.hamlc" , (callback)->
    runSequence("hamlc")



gulp.task "default", (callback = ->)->
  runSequence("sass", "sass-minify",'bundle', "minify", "hamlc", "watchfiles")
