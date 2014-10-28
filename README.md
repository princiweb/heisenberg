# Heisenberg

![Logo](http://www.princiweb.com.br/heisenberg/logo.jpg)

## Running the app

### Database

Because of [offset_fetch](http://msdn.microsoft.com/en-us/library/ms188385%28SQL.110%29.aspx), you will need SQL Server 2012+

```
CREATE DATABASE heisenberg
GO

USE heisenberg
GO

CREATE TABLE Posts(
   Id int IDENTITY(1,1) NOT NULL,
   Title nvarchar(100) NOT NULL,
   Description nvarchar(max) NOT NULL,
   PRIMARY KEY(Id)
)
GO
```

### App

First of all, you need to have Node.js:

- [Node.js](http://nodejs.org/)

and the global dependencies:

- Gulp
- Bower
- CoffeeScript

```        
npm install -g gulp bower coffee-script
```

and finally, the local dependencies:

```
npm install gulp && npm install && bower install
```

Now run `gulp` and your app is ready to use! :)

## Running the tests

Get [Mocha](http://visionmedia.github.io/mocha/):

```
npm install -g mocha
```

After this, configure your database test in `/test/dal/database.coffee`

Now you're ready to run the tests:

```
npm test
```

If you want to run a specifc kind of test, see below.

### Server

- **DAL:**

```
mocha test/dal
```

- **API:**

```
mocha test/api
```

### Client

- **TODO:** TODO

```
TODO
```

## Based on

- [SEA = SQL + Express + AngularJS](https://github.com/tdumitrescu/sea-blog)
- [Angular Express Seed](https://github.com/btford/angular-express-seed)