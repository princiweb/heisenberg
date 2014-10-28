define ['app'], (app) ->
  app.directive 'postForm', ->
    restrict: 'E'
    templateUrl: '../views/posts/form.html'