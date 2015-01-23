define [], ->
  (dependencies) ->
    definition = resolver: [
      '$q'
      '$rootScope'
      ($q, $rootScope) ->
        deferred = $q.defer()
        require dependencies, ->
          $rootScope.$apply ->
            deferred.resolve()

        return deferred.promise
    ]
    
    return definition