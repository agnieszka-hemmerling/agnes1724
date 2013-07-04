window.App ||= {}
App.Views.Chats ||= {}

class App.Models.Chat extends Backbone.Model
  url: =>
    '/chat'

class App.Collections.ChatMessages extends Backbone.Collection
  model: App.Models.Chat
  url: '/chat'

class App.Views.Chats.Index extends Backbone.View
  template: JST['backbone/templates/chats/index']

  initialize: =>

    chat_collection.on 'add', (chat)=>
      @addOne(chat)
    chat_collection.on 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)



  addAll: (collection)=>
    collection.each (chat)=>
      @addOne(chat)


  addOne: (chat)=>
    user_view = new App.Views.Chats.User(model: chat)
    @$el.append user_view.render().$el



  render: =>
    @$el.html @template()
    @addAll(chat_collection)
    return this

class App.Views.Chats.ShowMessage extends Backbone.View
  template: JST['backbone/templates/chats/show_message']

  render: =>
    @$el.html @template()
    return this
    
class App.Views.Chats.AddMessage extends Backbone.View
  template: JST['backbone/templates/chats/add_message']

  events:
    'submit': 'submit'

  submit: =>
     text = @$el.find('textarea#body').val()
     user = @$el.find('#user').val()

     message = new App.Models.Chat
     chat_collection.create(body: text, to_user: user )
     false


  render: =>
    @$el.html @template()
    return this

class App.Views.Chats.User extends Backbone.View
  template: JST['backbone/templates/chats/user']

  render: =>
    @$el.html @template(user: @model.toJSON())
    return this
