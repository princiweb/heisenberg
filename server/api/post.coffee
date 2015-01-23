Post  = require '../models/post'
posts = new (require '../dal/posts')
url   = require 'url'

# GET
exports.posts = (req, res) ->
  url_parts = url.parse(req.url, true)
  query = url_parts.query
  search = {}

  search.title = query.title ?= ''

  posts.getAllPaginated(
    query.from
    query.to
    query.orderByColumn
    query.orderByDir
    search
    (err, posts) ->
      if err is undefined
        res.json posts
      else
        res.status(500).send(err)
    )

exports.post = (req, res) ->
  id = req.params.id

  posts.getById id, (err, data) ->
    if err is undefined
      res.json data[0]
    else
      res.status(500).send(err)

# POST
exports.add = (req, res) ->
  post = new Post req.body

  posts.save post, (err) ->
    if err is undefined
      res.json post
    else
      res.status(500).send(err)

# PUT
exports.edit = (req, res) ->
  id = req.params.id
  post = new Post req.body

  posts.update id, post, (err) ->
    if err is undefined
      res.json post
    else
      res.status(500).send(err)

# DELETE
exports.delete = (req, res) ->
  id = req.params.id

  posts.delete id, (err) ->
    if err is undefined
      res.json true
    else
      res.status(500).send(err)