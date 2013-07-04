window.App ||= {}
App.Views.Inbox ||= {}

class App.Models.Message extends Backbone.Model
  url: =>
    if this.get('id')
      "/messages/#{this.get('id')}"
    else
      "/messages"

#class App.Models.InboxMessage extends Backbone.Model
#  url: =>
#    "/messages/inbox/#{this.get('id')}"


class App.Collections.InboxMessages extends Backbone.Collection
  model: App.Models.Message
  url: '/messages/inbox'
  comparator: (message) =>
    message.get 'created_at'


class App.Views.Inbox.InboxIndex extends Backbone.View
  template: JST['backbone/templates/inbox_messages/inbox']

  initialize: =>

    window.inbox_collection.on 'add', (model)=>
      @addOne(model)
    window.inbox_collection.on 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)

#    setInterval =>
#      inbox_collection.fetch add: true
#    , 300


  addAll: (collection)=>
    @$el.find('tbody').html ''
    collection.each (model)=>
      @addOne(model)


  addOne: (model)=>

    view = new App.Views.Inbox.InboxMessage(model: model)
    view.render().$el.hide()
    
    @$el.find('table').prepend view.render().$el.fadeIn()
    

  render: =>
    @$el.html @template()
    return this

class App.Views.Inbox.InboxMessage extends Backbone.View
  template: JST['backbone/templates/inbox_messages/message']

  tagName: 'tr'

  initialize: =>
    @model.bind 'remove', =>
      @$el.fadeOut()

  events:
    'click .icon-img-js': 'delete'

  delete: =>
    @$el.fadeOut()
    @model.destroy()

  render: =>
    @$el.html @template(@model.toJSON())

    $msg_body = @$el.find('.td-color a')

    old_text = $msg_body.text()
    text = old_text.substr(0, 30)

    if text != old_text
      $msg_body.text "#{text}..."
    else
      $msg_body.text(text)

    #longText.text(longText.text().substr(0, 30))

    return this

class App.Views.Inbox.MessageShow extends Backbone.View
  template: JST['backbone/templates/inbox_messages/message_show']
  reply_template: JST['backbone/templates/inbox_messages/reply_message']

  events: 
    'submit': 'submit'

  submit: =>
    event.preventDefault()

    text = @$el.find('#text-reply').val()
    @$el.find('#text-reply').val('')

    message = new App.Models.Message
    message.save
      to_user: @model.get('from_user').username
      body: text

    @$el.find('#replies').append @reply_template(message: message.toJSON())



  get_prev_id: (model)=>

    prev_index = window.inbox_collection.indexOf(model) - 1

    if  prev_index == -1
      false
    else
      prev = window.inbox_collection.at(prev_index)
      prev.get('id')

  get_next_id: (model)=>

    next_index = window.inbox_collection.indexOf(model) + 1

    if  next_index > window.inbox_collection.length - 1
      false
    else
      next = window.inbox_collection.at(next_index)
      next.get('id')

  render: (id)=>
    @model = window.inbox_collection.get(id)

    @model.set 'prev_id', this.get_prev_id(@model)
    @model.set 'next_id', this.get_next_id(@model)

    @$el.html @template(message: @model.toJSON())

    @$el.find('.text-message').niceScroll()

    return this


