window.App ||= {}
App.Views.Adverts ||= {}

class App.Models.Advert extends Backbone.Model
  url: =>
    if this.get('id')
      "/adverts/#{this.get('id')}"
    else
      '/adverts'

class App.Collections.Adverts extends Backbone.Collection
  url: '/adverts'
  model: App.Models.Advert


class App.Models.Animal extends Backbone.Model
  url: =>
    if this.get('id')
      "/animals/#{this.get('id')}"
    else
      '/animals'

class App.Collections.Animals extends Backbone.Collection
  url: '/animals'
  model: App.Models.Animal
 

class App.Views.Adverts.Index extends Backbone.View
  template: JST['backbone/templates/adverts/index']

  initialize: =>

    advert_collection.on 'add', (advert)=>
      @addOne(advert)
    advert_collection.on 'reset', (collection)=>
      @$el.html ''
      @addAll(collection)



  addAll: (collection)=>

    collection.each (advert)=>
      @addOne(advert)


  addOne: (advert)=>

    advert_view = new App.Views.Adverts.Advert(model: advert)
    @$el.append advert_view.render().el


  render: =>
    @$el.html @template()
    @addAll(advert_collection)
    return this

class App.Views.Adverts.Advert extends Backbone.View
  template: JST['backbone/templates/adverts/advert']

  initialize: =>
    @model.bind 'remove', =>
      @$el.fadeOut()


  events: =>
    'click': 'hide'

  hide: =>
    @model.destroy()


  render: =>
    @$el.html @template(advert: @model.toJSON())
    return this


class App.Views.Adverts.AddAdvert extends Backbone.View
  template: JST['backbone/templates/adverts/new']

  initialize: =>
    @gallery = new App.Views.MiniGallery.Gallery

  events: =>
    'submit': 'submit'
    'change :file' : 'handle_file'

  handle_file: (e)=>

    file = e.target.files[0]
    reader = new FileReader()

    reader.onload = (file)=>
      #console.log file
      @gallery.images.add
        src: file.target.result


    reader.readAsDataURL file
      
    

  submit: =>
    event.preventDefault()
    animal = @$el.find('#animal').val()

    city = @$el.find('#city').val()
    body = @$el.find('#body').val()

    advert = new App.Models.Advert
      animal: animal
      city: city
      body: body

    advert.save()



  render: =>

    window.model_animals = new App.Models.Animal
    model_animals.fetch
      success: =>
        @$el.html @template(animals: model_animals.toJSON())
        @$el.find('.js-gallery').html @gallery.render().el
        @$el.find('#animal_type').select2(placeholder: 'Pet Type')
    @






