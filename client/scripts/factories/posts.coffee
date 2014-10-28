define ['app'], (app) ->
  app.factory 'posts', [
    '$http'
    ($http) ->
      baseUrl = '/api/post'
      posts = {}

      posts.getAllPaginated = (from, to, orderByColumn, orderByDir, search) ->
        searchParameters = ''

        for property of search
          searchParameters += "&#{property}=#{search[property]}"  unless search[property] is undefined

        $http.get("#{baseUrl}s?from=#{from}&to=#{to}&orderByColumn=#{orderByColumn}&orderByDir=#{orderByDir}#{searchParameters}")
      
      posts.save = (post) ->
        $http.post(baseUrl, post)

      posts.getById = (id) ->
        $http.get("#{baseUrl}/#{id}")

      posts.update = (id, post) ->
        $http.put("#{baseUrl}/#{id}", post)

      posts.delete = (post) ->
        $http.delete("#{baseUrl}/#{post.id}")

      return posts
  ]