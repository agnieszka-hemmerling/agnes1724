class Router extends Backbone.Router
#  initialize: ->
#    $ ->
#      $('body').html JST['backbone/templates/new_layout']

  routes:
    'pets': 'pets'
    'pets/:name': 'pet'
    'photos/upload' : 'photos'
    'photos/upload/:filename' : 'show_photo'
    'adverts': 'adverts'
    'adverts/new': 'new_advert'

    'messages/sent': 'sent'
    'messages/sent/:id': 'sent_show'
    'messages/inbox': 'inbox'
    'messages/inbox/:id': 'inbox_show'
    'messages/inbox/reply/:id': 'inbox_reply'

    'settings': 'settings'
    'settings/password': 'password'
    'settings/email': 'email'
    '': 'register'
    'logout': 'logout'
    'chat': 'chat'

    'search': 'search'

  search: =>

    window.search_collection = new App.Collections.Searches
    search_collection.fetch()

    view = new App.Views.Search.SearchIndex
    $('#yield').html view.render().$el

    add_view = new App.Views.Search.AddSearchView
    $('#yield').append add_view.render().$el
    
  chat: =>

    chat_view = new App.Views.Chats.ShowMessage
    $('#chatbox').html chat_view.render().$el

    message_view = new App.Views.Chats.AddMessage
    $('#chatbox').append message_view.render().$el

    window.chat_collection = new App.Collections.ChatMessages
    chat_collection.fetch()

    index_view = new App.Views.Chats.Index
    $('#yield').html index_view.render().$el

  register: =>

    window.logout = new App.Models.Register
    logout.fetch()
    register_view = new App.Views.Register.Logout

    $('#yield').html register_view.render().$el


  register: =>

    window.register = new App.Models.Register
    register.fetch()
    register_view = new App.Views.Register.SignUp 

    $('#yield-register').html register_view.render().$el

  settings: =>
    
    settings_view = new App.Views.Settings.SettingsIndex
    view =  settings_view.render().$el
    console.log view
    $('#settings').html view
    $('#settings').fadeIn()

  email: =>

    window.current_user = new App.Models.CurrentUser
    current_user.fetch success: ->
      email_view = new App.Views.Settings.Email(model: current_user)

      $('#inurl').html email_view.render().$el
#    $('#inurl').fadeIn()

  password: =>
    
    window.current_user_password = new App.Models.CurrentUserPassword
    current_user_password.fetch()

    password_view = new App.Views.Settings.Password
    view =  password_view.render().$el
    console.log view
    $('#inurl').html view
#    $('#inurl').fadeIn()

  inbox: =>
    window.inbox_collection = new App.Collections.InboxMessages
    inbox_collection.fetch()
    inbox_view = new App.Views.Inbox.InboxIndex
    $('#yield').html inbox_view.render().el

  inbox_show: (id)=>
    window.inbox_collection = new App.Collections.InboxMessages
    inbox_collection.fetch success: =>
      @model = new App.Models.Message
      @view = new App.Views.Inbox.MessageShow()
      $('#yield').html @view.render(id).el

  inbox_reply: (id)=>
    window.inbox_collection = new App.Collections.InboxMessages
    inbox_collection.fetch success: =>
      @model = new App.Models.Message
      @view = new App.Views.Inbox.MessageReplay()
      $('#yield').html @view.render(id).el

  sent: =>

    window.sent_collection = new App.Collections.SentMessages
    sent_collection.fetch()
    
    sent_view = new App.Views.Sents.SentIndex
    $('#yield').html sent_view.render().el

 
  sent_show: (id)=>
    window.sent_collection = new App.Collections.SentMessages
    sent_collection.fetch success: =>
      @model = new App.Models.SentMessage
      @view = new App.Views.Sents.MessageShow()
      $('#yield').html @view.render(id).el


  adverts: =>

    window.advert_collection = new App.Collections.Adverts
    advert_collection.fetch()
    
    index_view = new App.Views.Adverts.Index
    $('#yield').html index_view.render().el

  new_advert: =>
    add_view = new App.Views.Adverts.AddAdvert
    $('#yield').html add_view.render().el

  pets: =>
    window.pet_collection = new App.Collections.Pets
    pet_collection.fetch()


    view = new App.Views.PetsIndex
    $('#yield').html view.render().el

  pet: (name)=>
    alert name

    
  photos: =>
    window.photo_collection = new App.Collections.Photos
    photo_collection.fetch()

    upload_view = new App.Views.Photos.Upload
    $('#yield').html upload_view.render().el
#  $ ->
#   new qq.FileUploader
#     element: document.getElementById('file-uploader')
#     action: '/photos/upload'
#     onComplete: (id, fileName, response)->
#       $('#gallery').append JST['backbone/templates/photos/index'](photo: response.photo)


    photo_view = new App.Views.Photos.Index
    $('#yield').append photo_view.render().el

  show_photo: (filename)=>
    show_view = new App.Views.Photos.Show
      model: window.photo_collection.get(filename)
      #collection: photo_collection, filename: filename
    
    rendered = show_view.render().$el
    $('#yield').html rendered



window.router = new Router()




router.route 'messages/compose', '', ->
  @view = new App.Views.Compose()
  $('#yield').html @view.render().el

#Upload photos

#router.route 'photos/upload', '', ->
#  $.getJSON '/photos/upload.json', (data, e)->
#    $('#yield').html(JST["upload"](photos: data))

$('.set-avatar').live 'click', ->
  $.post '/settings/avatar',
    avatar_url: $('.set-avatar').closest('tr').find('img').attr('src')




#router.route 'home', '', ->
#  @view = new App.Views.Home
#  $('#home-page').html @view.render().el

#$("a[href='/home']").click ->
#  $('#home-page').animate
#    width: 'toggle'
#    height: 'linear'
#  $("#close-box").live "click", ->
#    $("#home-page").animate
#      width: 'hide'
#      height: 'linear'


#################################################
#################################################

$ ->
  $('.nav-list li').click ->
    $('li').removeClass('active')
    $(this).addClass('active')







