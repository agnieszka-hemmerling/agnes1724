window.App ||= {}
App.Views.Sents ||= {}

class App.Models.SentMessage extends Backbone.Model
  url: =>
    "/messages/sent/#{this.get('id')}"



class App.Collections.SentMessages extends Backbone.Collection
  model: App.Models.SentMessage
  url: '/messages/sent'
  comparator: (message) =>
    message.get 'created_at'


class App.Views.Sents.SentIndex extends Backbone.View
  template: JST['backbone/templates/sent_messages/sent']

  initialize: =>

    sent_collection.on 'add', (sent)=>
      @addOne(sent)
    sent_collection.on 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)

  addAll: (collection)=>
    @$el.find('tbody').html ''

    collection.each (sent)=>
      @addOne(sent)


  addOne: (sent)=>
    console.log sent.toJSON()

    view = new App.Views.Sents.SentMessage(model: sent)
    view.render().$el.hide()

    @$el.find('table').prepend view.render().$el.fadeIn()


  render: =>
    @$el.html @template()
    @addAll(sent_collection)
    return this



class App.Views.Sents.SentMessage extends Backbone.View
  template: JST['backbone/templates/sent_messages/message']

  tagName: 'tr'

  initialize: =>
    @model.bind 'remove', =>
      @$el.fadeOut()

  events:
    'click .icon-img-js': 'delete'

  delete: =>
    @model.destroy()

  render: =>
    @$el.html @template(sent: @model.toJSON())

    $msg_body = @$el.find('.td-color a')

    old_text = $msg_body.text()
    text = old_text.substr(0, 30)

    if text != old_text
      $msg_body.text "#{text}..."
    else
      $msg_body.text(text)


    return this


class App.Views.Sents.MessageShow extends Backbone.View
  template: JST['backbone/templates/sent_messages/message_show']
  
  get_prev_id: (model)=>

    prev_index = window.sent_collection.indexOf(model) - 1

    if  prev_index == -1
      false
    else
      prev = window.sent_collection.at(prev_index)
      prev.get('id')

  get_next_id: (model)=>

    next_index = window.sent_collection.indexOf(model) + 1

    if  next_index > window.sent_collection.length - 1
      false
    else
      next = window.sent_collection.at(next_index)
      next.get('id')
  
  
  
  render: (id)=>
    @model = window.sent_collection.get(id)

    @model.set 'prev_id', this.get_prev_id(@model)
    @model.set 'next_id', this.get_next_id(@model)

    @$el.html @template(message: @model.toJSON())

    @$el.find('.text-message').niceScroll()

    return this
 


