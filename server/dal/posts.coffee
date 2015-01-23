sql   = require 'mssql'
Post  = require "../models/post"

class Posts
  getById: (id, done) ->
    sql.connect configConn, (err) ->
      done err, undefined  if err isnt null

      request = new sql.Request()
      
      request.input 'id', id

      cmd = 'select id, title, description
            from posts
            where id = @id'

      request.query cmd, (err, recordset) ->
        done err, recordset

  getAllPaginated: (from, to, orderByColumn, orderByDir, search, done) ->
    sql.connect configConn, (err) ->
      done err, undefined  if err isnt null

      request = new sql.Request()

      request.input 'title', "%#{search.title}%"

      cmd = "select count(*) over() as totalRows, id, title, description
            from posts
            where title like @title
            order by #{orderByColumn} #{orderByDir}
            offset #{from} rows fetch next #{to} rows only"
      
      request.query cmd, (err, recordset) ->
        done err, recordset

  save: (post, done) ->
    sql.connect configConn, (err) ->
      done err, undefined  if err isnt null

      request = new sql.Request()

      request.input 'title', post.title
      request.input 'description', post.description

      cmd = 'insert into posts
            (title, description)
            output inserted.id values
            (@title, @description)'

      request.query cmd, (err, recordset) ->
        done err, recordset

  update: (id, post, done) ->
    sql.connect configConn, (err) ->
      done err  if err isnt null

      request = new sql.Request()

      request.input 'id', id
      request.input 'title', post.title
      request.input 'description', post.description

      cmd = 'update posts
            set title = @title
            ,description = @description
            where id = @id'

      request.query cmd, (err) ->
        done err

  delete: (id, done) ->
    sql.connect configConn, (err) ->
      done err  if err isnt null

      request = new sql.Request()

      request.input 'id', id

      cmd = 'delete from posts
            where id = @id'

      request.query cmd, (err) ->
        done err

module.exports = Posts