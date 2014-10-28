define ['app'], (app) ->
  app.directive 'formValidate', ->
    restrict: 'A'
    controller: ($scope) ->
      $scope.validate = (isValid) ->
        $scope.isDisabled = true

        unless isValid
          $('.ng-invalid:input:first').focus()
          $scope.isDisabled = false
          $scope.submitted = true
          return false

        $scope.submit()