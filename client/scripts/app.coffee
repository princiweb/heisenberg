define [
  'routes'
  'services/dependencyResolverFor'
], (config, dependencyResolverFor) ->
  app = angular.module('app', ['ngRoute'])
  app.config [
    '$routeProvider'
    '$locationProvider'
    '$controllerProvider'
    '$compileProvider'
    '$filterProvider'
    '$provide'
    ($routeProvider, $locationProvider, $controllerProvider, $compileProvider, $filterProvider, $provide) ->
      app.controller = $controllerProvider.register
      app.directive = $compileProvider.directive
      app.filter = $filterProvider.register
      app.factory = $provide.factory
      app.service = $provide.service

      $locationProvider.html5Mode true

      angular.forEach config.routes, (route, path) ->
        $routeProvider.when path,
          templateUrl: route.templateUrl
          resolve: dependencyResolverFor(route.dependencies)
          reloadOnSearch: false

      if config.defaultRoutePaths isnt undefined
        $routeProvider.otherwise redirectTo: config.defaultRoutePaths
  ]
  
  return app