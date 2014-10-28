sql       = require 'mssql'
database  = require '../database'
Post      = require '../../server/models/post'
posts     = new (require '../../server/dal/posts')

post = new Post { title: 'title', description: 'description' }

save = (post, done) ->
  sql.connect configConn, (err) ->
    request = new sql.Request()

    request.input 'title', sql.VarChar, post.title
    request.input 'description', sql.VarChar, post.description

    request.query 'insert into posts (title, description) values (@title, @description)', (err) ->
      done err

before ->
  global.configConn = database.configConn

beforeEach (done) ->
  posts.save post, (err) ->
    posts.save post, (err) ->
      done()

afterEach (done) ->
  sql.connect configConn, (err) ->
    request = new sql.Request()

    request.query 'truncate table posts', (err) ->
      if err is undefined
        done()

describe 'DAL - Posts', ->
  it 'should get by id', (done) ->
    posts.getById 1, (data, err) ->
      data.should.have.property('id', 1)
      data.should.have.property('title', data.title)
      data.should.have.property('description', data.description)

      done()

  it 'should insert new post', (done) ->
    posts.save post, (err, id) ->
      id.should.be.exactly 3

      done()

  it 'should update a post', (done) ->
    newPost = new Post { title: 'new title', description: 'new description' }

    posts.update 1, newPost, (err) ->
      posts.getById 1, (data, err) ->
        data.should.have.property('id', 1)
        data.should.have.property('title', newPost.title)
        data.should.have.property('description', newPost.description)

        done()

  it 'should get all posts', (done) ->
    posts.getAll (data) ->
      data.should.have.lengthOf 2

      done()

  it 'should delete post by id', (done) ->
    posts.delete 1, (err) ->
      posts.getById 1, (data, err) ->
        (data is undefined).should.be.true

        done()