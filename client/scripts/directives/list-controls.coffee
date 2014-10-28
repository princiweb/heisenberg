define ['app'], (app) ->
  app.directive 'listControls', ->
    restrict: 'E'
    templateUrl: '../../views/shared/list-controls.html',
    controller: ($scope, $location, $timeout) ->
      $scope.$watch (->
        $scope.data
      ), ->
        if $scope.data isnt undefined
          $scope.totalRows = if $scope.data.length > 0 then $scope.data[0].totalRows else 0
          $scope.to = $scope.data.length + $scope.from
          $scope.totalPages = Math.ceil($scope.totalRows / $scope.rowsPerPage)

      $scope.orderBy = (column) ->
        $scope.orderByDir = if $scope.orderByDir is 'desc' then 'asc' else 'desc'
        $location.search('orderByDir', $scope.orderByDir).search('orderByColumn', column)

      $scope.range = (from, to, max) ->
        input = []

        if max? and from? and to?
          i = from

          while i <= to
            input.push i  if i > 0 and i <= max
            i++
        input

      $scope.updateRowsPerPage = (quantity) ->
        $location.search('rowsPerPage', quantity)

      $scope.changePage = (page) ->
        $location.search('currentPage', page)