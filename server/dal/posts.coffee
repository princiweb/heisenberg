sql   = require 'mssql'
Post  = require "../models/post"

class Posts
  getById: (id, done) ->
    sql.connect configConn, (err) ->
      request = new sql.Request()
      
      request.input 'id', sql.Int, id

      request.query 'select id, title, description from posts where id = @id', (err, recordset) ->
        done recordset[0]

  getAllPaginated: (from, to, orderByColumn, orderByDir, search, done) ->
    sql.connect configConn, (err) ->
      request = new sql.Request()

      sqlCmd = "select count(*) over() as totalRows, id, title, description from posts"

      unless search.title is ''
        request.input 'title', sql.VarChar, "%#{search.title}%"
        sqlCmd += " where title like @title"

      sqlCmd +=  " order by #{orderByColumn} #{orderByDir} offset #{from} rows fetch next #{to} rows only"
      
      request.query sqlCmd, (err, recordset) ->
        if err is undefined
          done undefined, recordset
        else
          done err

  save: (post, done) ->
    sql.connect configConn, (err) ->
      request = new sql.Request()

      request.input 'title', sql.VarChar, post.title
      request.input 'description', sql.VarChar, post.description

      request.query 'insert into posts (title, description) output inserted.id values (@title, @description)', (err, recordset) ->
        if err is undefined
          done err, recordset[0]["id"]
        else
          done err
      return
    return

  update: (id, post, done) ->
    sql.connect configConn, (err) ->
      request = new sql.Request()

      request.input 'id', sql.Int, id
      request.input 'title', sql.VarChar, post.title
      request.input 'description', sql.VarChar, post.description

      request.query 'update posts set title = @title, description = @description where id = @id', (err) ->
        done err
      return
    return

  delete: (id, done) ->
    sql.connect configConn, (err) ->
      request = new sql.Request()

      request.input 'id', sql.Int, id

      request.query 'delete from posts where id = @id', (err) ->
        done err
      return
    return

module.exports = Posts