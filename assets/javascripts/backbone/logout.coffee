window.App ||= {}
App.Views.Register ||= {}

class App.Models.Logout extends Backbone.Model
  url: =>
    "/logout"


class App.Views.Register.Logout extends Backbone.View
  template: JST['backbone/templates/register/logout']

#  window.location.href = '/'
#  false

  render: =>
    @$el.html @template()
    return this


