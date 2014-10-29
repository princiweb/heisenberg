require.config
  paths:
    'jquery': '/scripts/vendor/jquery.min'
    'angular': '/scripts/vendor/angular.min'
    'angular-route': '/scripts/vendor/angular-route.min'

  shim:
    'app':
      deps: [
        'jquery'
        'angular'
        'angular-route'
      ]

    'angular':
      deps: ['jquery']

    'angular-route':
      deps: ['angular']

require ['app'], (app) ->
  angular.bootstrap document, ['app']