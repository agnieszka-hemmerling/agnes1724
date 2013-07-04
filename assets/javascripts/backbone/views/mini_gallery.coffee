App.Views.MiniGallery ||= {}
class App.Views.MiniGallery.Thumb extends Backbone.View
  template: JST['backbone/templates/mini_gallery/thumb']
  tagName: 'li'

  events:
    'click': 'on_click'

  initialize: =>
    @model.on 'change', (model)=>
      if model.get('main')
        @$el.find('img').addClass 'active'
      else
        @$el.find('img').removeClass 'active'
      

  on_click: =>
    $target = $ event.target
    unless @model.get('main')
#      @model.collection.invoke 'set', ['main', false]
      @model.collection.where(main: true).forEach (model)->
        console.log model
        model.set('main', false)

      @model.set main: true
    

  render: =>
    @$el.html @template(@model.toJSON())
    @
    

class App.Views.MiniGallery.Gallery extends Backbone.View
  className: 'mini_gallery'
  template: JST['backbone/templates/mini_gallery/gallery']

  initialize: (options)=>
    if options?.images
      images = options.images.map (src)-> src: src
      @images = new Backbone.Collection images
    else
      @images = new Backbone.Collection
    
    @images.on 'add', @append_thumb
    @images.on 'change', (model)=>
      if model.get('main')
        @display_as_main model

  display_as_main: (model)=>
    $('img.js_main_img').attr(src: model.get('src'))

    

  append_thumb: (model)=>
    image_view = new App.Views.MiniGallery.Thumb
      model: model
    @$el.find('ul').append image_view.render().el

    if model.collection.length == 1
      @display_as_main model
      


  render: =>
    @$el.html @template()
    @images.each @append_thumb

    @
