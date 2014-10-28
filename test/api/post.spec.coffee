path        = require 'path'
serverPath  = path.join(__dirname, '..', '..', 'server')
server      = require "#{serverPath}/server"
PORT        = 3434
request     = new(require 'supertest')('http://localhost:' + PORT + '/api')

before ->
  server.start PORT

describe "API - Post", ->
  describe "\nPOST\n", ->

    it 'should return success to post a valid post', (done) ->
      post =
        title: 'title'
        description: 'description'

      request.post('/post').send(post).end (err, res) ->
        res.status.should.be.exactly 200
        done()

    it 'should return error to post a post without title', (done) ->
      post =
        title: null
        description: 'description'

      request.post('/post').send(post).end (err, res) ->
        res.status.should.be.exactly 500
        done()

    it 'should return error to post a post without description', (done) ->
      post =
        title: 'title'
        description: null

      request.post('/post').send(post).end (err, res) ->
        res.status.should.be.exactly 500
        done()

  describe "\nGET\n", ->

    it 'should return success to get all posts', (done) ->
      request.get('/posts').end (err, res) ->
        res.status.should.be.exactly 200
        done()

    it 'should return success to get a specific post', (done) ->
      request.get('/post/1').end (err, res) ->
        res.status.should.be.exactly 200
        done()

    it 'should return not found to get a post without id', (done) ->
      request.get('/post/').end (err, res) ->
        res.status.should.be.exactly 404
        done()

  describe "\nPUT\n", ->

    it 'should return success when updating a post', (done) ->
      post =
        title: 'title'
        description: 'description'

      request.put('/post/1').send(post).end (err, res) ->
        res.status.should.be.exactly 200
        done()

    it 'should return not found when updating a post without id', (done) ->
      post =
        title: 'title'
        description: 'description'

      request.put('/post/').send(post).end (err, res) ->
        res.status.should.be.exactly 404
        done()

  describe "\nDELETE\n", ->

    it 'should return success when deleting a post', (done) ->
      request.delete('/post/1').end (err, res) ->
        res.status.should.be.exactly 200
        done()

    it 'should return not found when deleting a post without id', (done) ->
      request.delete('/post/').end (err, res) ->
        res.status.should.be.exactly 404
        done()