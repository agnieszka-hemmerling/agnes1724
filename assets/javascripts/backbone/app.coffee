#= require_self
#= require_tree ./templates
#= require_tree ../../templates
#= require_tree ./models
#= require_tree ./views
#= require ./router
#= require_tree .


window.App = {}
App.Models = {}
App.Collections = {}
App.Views = {}

$ ->
  Backbone.history.start pushState: false

  Backbone.history.bind 'route', (router,name,params)->
    unless name.match(/^settings-/)
     $('#topnav').hide()

$ ->
  $("a[href]").click (e)->
    e.preventDefault()
    router.navigate \
      $(this).attr('href').replace(/^\//, ''), trigger: true
