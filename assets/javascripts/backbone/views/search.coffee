window.App ||= {}
App.Views.Search ||= {}


class App.Models.Search extends Backbone.Model


class App.Collections.Searches extends Backbone.Collection
  model: App.Models.Search
  url: '/search'


class App.Views.Search.SearchIndex extends Backbone.View
  template: JST['backbone/templates/searches/index']

  initialize: =>

    search_collection.on 'add', (search)=>
      @addOne(search)
    search_collection.bind 'reset', (collection)=>
#      @$el.html ''
      @addAll(collection)



  addAll: (collection)=>
    collection.each (search)=>
      @addOne(search)

  addOne: (search)=>
    view = new App.Views.Search.SearchView (model: search)
    @$el.append view.render().el


  render: =>
    @$el.html @template()
    @addAll(search_collection)

    return this


class App.Views.Search.SearchView extends Backbone.View

  template: JST['backbone/templates/searches/search']

  render: =>
    @$el.html @template(user: @model.toJSON())
    return this

class App.Views.Search.AddSearchView extends Backbone.View
  template: JST['backbone/templates/searches/add_search']

  events:
    'submit': 'submit'

  submit: =>

    search = @$el.find('#search-s').val()
    search_collection.create(username: search)
    false

  render: =>
    @model = new App.Collections.Searches
    @$el.html @template(user: @model.toJSON())
    return this




