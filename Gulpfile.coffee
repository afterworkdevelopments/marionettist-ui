# npm install -D gulp gulp-concat gulp-util gulp-uglify gulp-coffee gulp-rollup gulp-sourcemaps

gulp    = require("gulp")
gutil   = require("gulp-util")
sass        = require("gulp-sass")
cssImport   = require("gulp-cssimport")
cssmin = require('gulp-cssmin')
coffee  = require("gulp-coffee")
concat  = require("gulp-concat")
rename = require('gulp-rename')
include = require("gulp-include")
uglify  = require("gulp-uglify")
runSequence   = require('run-sequence').use(gulp)
rollup         = require("rollup-stream")
sourcemaps     = require("gulp-sourcemaps")
pkg            = require("./package.json")
pagakeName     = pkg.name

browserify  = require("browserify")
watchify    = require("watchify")
coffeeify   = require("coffeeify")
debowerify  = require("debowerify")
hamlc       = require("gulp-haml-coffee-compile")
pathmodify  = require("pathmodify")
buffer      = require('vinyl-buffer')
source      = require("vinyl-source-stream")
hamlc       = require("gulp-haml-coffee-compile")

gulp.task "hamlc", ()->
  options =
    compile:
      includePath: true
      pathRelativeTo: "./src"
  gulp.src("./src/**/**/**/**/*.hamlc")
    .pipe(hamlc(options).on("error", gutil.log))
    .pipe(concat("templates.js"))
    .pipe(gulp.dest("./dist/templates.js"))

gulp.task "bundle", ->
  console.log "Bundle"
  return rollup(
    entry: "./lib/#{pagakeName}.js"
    sourceMap: true
    moduleName: "Marionettist"
    format: "umd"
    exports: "default"
    external: ["marionettist"]
    plugins: []
    globals:
      'marionettist': "Marionettist"

  )
  .pipe(source("#{pagakeName}.js"))
  .pipe(sourcemaps.write("."))
  .pipe gulp.dest("./dist")

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


gulp.task "coffee", ()->
  console.log "Coffee"
  return gulp.src(["./src/**/**/**/**/*.coffee"])
    .pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest("./lib"))

gulp.task "watchfiles", ()->
  console.log "Watchfiles"
  gulp.watch "./src/**/**/**/*.coffee" , (callback)->
    runSequence("coffee",'bundle', "minify")
  gulp.watch "./src/#{pagakeName}.sass" , (callback)->
    runSequence("sass", "sass-minify")

gulp.task "site", ()->
  options=
    entries:    "./site/src/index.coffee"
    extensions: [".coffee",".css", ".hamlc"]
    debug: true
    paths: ['./node_modules','./site/src']
  b = watchify(browserify(options)).on("error", gutil.log)
  b.plugin(pathmodify(), {mods: [
    pathmodify.mod.dir("marionettist-site", "./site/src")
  ]})
  b.transform(coffeeify)
  # b.transform(debowerify)
  bundle = ()->
    b.bundle()
    .on("error", gutil.log)
    .pipe(source("js/application.js"))
    .pipe(buffer())

    .pipe(gulp.dest("./docs/assets"))

  b.on("update", bundle)
  b.on("log", gutil.log)
  bundle()
  gulp.start("hamlc")

gulp.task "default", (callback = ->)->
  runSequence("coffee", "sass", "sass-minify",'bundle', "minify", "watchfiles")
