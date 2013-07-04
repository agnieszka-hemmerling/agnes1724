class App.Models.User extends Backbone.Model
  url: '/user.json'

class App.Collections.Users extends Backbone.Collection
  model: App.Models.User
  url: '/users.json'
