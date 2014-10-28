define [], ->
  defaultRoutePath: '/'
  routes:
    '/':
      templateUrl: '../views/home/index.html'
      dependencies: ['controllers/home']

    '/posts/list':
      templateUrl: '../views/posts/list.html'
      dependencies: [
        'controllers/posts'
        'factories/posts'
        'directives/list-controls'
      ]

    '/posts/add':
      templateUrl: '../views/posts/add.html'
      dependencies: [
        'directives/form-validate'
        'directives/post-form'
        'factories/posts'
        'controllers/posts'
      ]

    '/posts/edit/:id':
      templateUrl: '../views/posts/edit.html'
      dependencies: [
        'directives/form-validate'
        'directives/post-form'
        'factories/posts'
        'controllers/posts'
      ]