define ['app'], (app) ->
  app.controller 'PostsCtrl', [
    '$scope', '$location', 'posts'
    ($scope, $location, posts) ->
      $scope.$on '$routeUpdate', ->
        $scope.loadData()
        $scope.filters = location.search

      $scope.remove = (post) ->
        posts.delete(post).success ->
          $location
            .search 'action', 'deleted'
            .search 'registry', post.title

      $scope.search = ->
        $scope.searched = true
        
        $location
          .search 'currentPage', 1
          .search 'title', $scope.search.title

      $scope.loadData = ->
        $scope.filters = location.search
        $scope.action = $location.search().action
        $scope.registry = $location.search().registry

        $scope.search.title = $location.search().title

        $scope.rowsPerPage = $location.search().rowsPerPage ?= 20
        $scope.currentPage = $location.search().currentPage ?= 1
        $scope.from = ($scope.currentPage * $scope.rowsPerPage) - $scope.rowsPerPage

        orderByColumn = $location.search().orderByColumn ?= 'id'
        orderByDir = $location.search().orderByDir ?= 'desc'

        posts.getAllPaginated($scope.from, $scope.rowsPerPage, orderByColumn, orderByDir, $scope.search)
          .success (posts) -> $scope.data = posts

      $scope.loadData()
  ]

  app.controller 'PostsAddCtrl', [
    '$scope', '$location', 'posts'
    ($scope, $location, posts) ->
      $scope.submit = ->
        posts.save($scope.post).success ->
          $location.path '/posts/list'
            .search 'action', 'inserted'
            .search 'registry', $scope.post.title
  ]

  app.controller 'PostsEditCtrl', [
    '$scope', '$location', '$routeParams', 'posts'
    ($scope, $location, $routeParams, posts) ->
      posts.getById($routeParams.id).success (post) ->
        $scope.post = post

      $scope.submit = ->
        posts.update($routeParams.id, $scope.post).success ->
          $location.path '/posts/list'
            .search 'action', 'updated'
            .search 'registry', $scope.post.title
  ]