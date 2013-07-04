window.App ||= {}
App.Views.Photos ||= {}

class App.Models.Photo extends Backbone.Model
  idAttribute: 'filename'

class App.Collections.Photos extends Backbone.Collection
  url: '/photos/upload'
  model: App.Models.Photo


class App.Views.Photos.Index extends Backbone.View
  template: JST['backbone/templates/photos/index']

  initialize: =>

    photo_collection.on 'add', (photo)=>
      @addOne(photo)
    photo_collection.on 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)



  addAll: (collection)=>

    collection.each (photo)=>
    
      @addOne(photo)

    photo = new App.Models.Photo
    collection.add photo

#  get_next: (model)=>
#    photo_collection.get photo_collection.indexOf(model)+1

  addOne: (photo)=>
#    photo.set 'next', @get_next(photo)

    photo_view = new App.Views.Photos.Photo(model: photo)
    @$el.find('.well').append photo_view.render().el

  render: =>
    @$el.html @template()
    @addAll(photo_collection)
    return this

class App.Views.Photos.Photo extends Backbone.View
  template: JST['backbone/templates/photos/photo']

  className: 'photo-item'

  initialize: =>
    @model.bind 'remove', =>
      @$el.fadeOut()


  events: =>
    'mouseover': 'show_x'
    'mouseout': 'hide_x'
    'click .icon': 'remove'
      
  show_x: =>
    @$el.find('.icon').show()
  hide_x: =>
    @$el.find('.icon').hide()

  remove: (e)=>
    @$el.fadeOut()
#    @model.destroy()


  render: =>
    @$el.html @template(photo: @model.toJSON())
    return this

class App.Views.Photos.Show extends Backbone.View
  template: JST['backbone/templates/photos/show']

  events: =>
  'click .next-photo': 'next'

  get_prev_id: (model)=>

    prev_index = window.photo_collection.indexOf(model) - 1

    if  prev_index == -1
      false
    else
      prev = window.photo_collection.at(prev_index)
      prev.get(prev.idAttribute)

  get_next_id: (model)=>

    next_index = window.photo_collection.indexOf(model) + 1

    if  next_index > window.photo_collection.length - 1
      false
    else
      next = window.photo_collection.at(next_index)
      next.get(next.idAttribute)


  render: =>



    #this.get_prev_id(@model)
    @model.set 'prev_id', this.get_prev_id(@model)
    @model.set 'next_id', this.get_next_id(@model)

    @$el.html @template(photo: @model.toJSON())
    setTimeout =>
      if @$el.find('img.large-photo').height() > 600
        @$el.find('img.large-photo').css height: 600
        @$el.find('img.large-photo').css width: 'auto'
    , 200
    return this

class App.Views.Photos.Upload extends Backbone.View
  template: JST['backbone/templates/photos/upload']
  
  render: =>
    @$el.html @template()
    return this



