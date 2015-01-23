var gulp        = require('gulp'),
    nodemon     = require('gulp-nodemon'),
    jade        = require('gulp-jade'),
    concat      = require('gulp-concat'),
    coffee      = require('gulp-coffee'),
    changed     = require('gulp-changed'),
    browserSync = require('browser-sync');

gulp.task('server', function () {
  nodemon({ script: './server/start-server.coffee', ext: 'coffee', ignore: ['client/**'] });
});

gulp.task('template', function(){
  gulp.src('./client/views/**/*.jade')
    .pipe(jade())
    .pipe(changed('./_public/views'))
    .pipe(gulp.dest('./_public/views'));
});

gulp.task('img', function(){
  gulp.src('./client/img/*')
    .pipe(changed('./_public/img'))
    .pipe(gulp.dest('./_public/img'));
});

gulp.task('vendor', function() {
  gulp.src([
    './bower_components/angular/angular.min.js',
    './bower_components/angular-route/angular-route.min.js',
    './bower_components/jquery/dist/jquery.min.js',
    './bower_components/requirejs/require.js'
  ])
    .pipe(gulp.dest('./_public/scripts/vendor'));
});

gulp.task('coffee', function() {
  gulp.src('./client/scripts/**/*.coffee')
    .pipe(changed('./_public/scripts', { extension: '.js' }))
    .pipe(coffee({bare: true}).on('error', function(err) {}))
    .pipe(gulp.dest('./_public/scripts'));
  
  gulp.src('./server/**/*.coffee')
    .pipe(changed('./_server', { extension: '.js' }))
    .pipe(coffee({bare: true}).on('error', function(err) {}))
    .pipe(gulp.dest('./_server'));
});


gulp.task('b-s', function() {
  browserSync.init(['./_public/**/*'], {
    proxy: 'localhost:3333'
  });
});

gulp.task('default', ['server', 'img', 'template', 'coffee', 'vendor', 'b-s'], function(){
  gulp.watch('./client/views/**/*.jade', ['template']);
  gulp.watch('./client/scripts/**/*.coffee', ['coffee']);
  gulp.watch('./server/**/*.coffee', ['coffee']);
});