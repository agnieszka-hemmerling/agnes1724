window.App || = {}
App.Pet || = {}

class App.Pet.Model extends Backbone.Model
#  url: '/pet'

class App.Collections.Pets extends Backbone.Collection
  url: '/pets'
  model: App.Pet.Model


class App.Views.PetsIndex extends Backbone.View
  template: JST['backbone/templates/pets/pets_index']

  initialize: =>

    pet_collection.on 'add', (pet)=>
      @addOne(pet)
    pet_collection.on 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)



  addAll: (collection)=>

    collection.each (pet)=>
      @addOne(pet)

    pet = new App.Pet.Model
    pet.set('name', 'new pet')
    collection.add pet

  addOne: (pet)=>
    view = new App.Views.PetLi(model: pet)

    if pet.get('name') == 'new pet'
      pet_view = new App.Views.AddPet
    else
      pet_view = new App.Views.Pet(model: pet)

    window.$el = @$el

    @$el.find('ul').append view.render().el
    @$el.find('.tab-content').append pet_view.render().el
#    @$el.find('.add-pet').html add_pet_view.render().el


  render: =>
    @$el.html @template()
#    @addAll(pet_collection)
    return this

class App.Views.AddPet extends Backbone.View
  template: JST['backbone/templates/pets/add_pet']

  events:
    'submit': 'submit'

  submit: =>
     imie = @$el.find('#name').val()
     animal = @$el.find('#animal').val()
     breed = @$el.find('#breed').val()

     pet_collection.create(name: imie, animal: animal, breed: breed)
     false

  render: =>
    @$el.html @template()
    return this


class App.Views.PetLi extends Backbone.View
  template: JST['backbone/templates/pets/pet_li']
  tagName: 'li'

  render: =>
    console.log @model
    @$el.html @template(pet: @model.toJSON())
    return this

class App.Views.Pet extends Backbone.View
  template: JST['backbone/templates/pets/pet']

  className: 'tab-pane'

  attributes: =>
    "data-petname": @model.get('name')

  render: =>
    @$el.html @template(pet: @model.toJSON())
    return this

