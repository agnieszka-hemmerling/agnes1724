window.App ||= {}
App.Views.Settings ||= {}

class App.Models.CurrentUser extends Backbone.Model
  url: =>
    "/current_user"

class App.Models.CurrentUserPassword extends Backbone.Model
  url: =>
    "/settings/password"

class App.Views.Settings.SettingsIndex extends Backbone.View
  template: JST['backbone/templates/settings/index']

  render: =>
    @$el.html @template()
    return this



class App.Views.Settings.Email extends Backbone.View
  template: JST['backbone/templates/settings/user_email']

#  initialize: =>
#    @model.on 'change', (model)=>
#      @render()


  events:
    'submit': 'submit'

  submit: =>
    email = @$el.find('#email').val()

    #current_user.set(email: email)
    #current_user.save()
    current_user.save(email: email)
    console.log @$el
    false



  render: =>
    @$el.html @template(current_user: @model.toJSON())
    return this


class App.Views.Settings.Password extends Backbone.View
  template: JST['backbone/templates/settings/user_password']


  events:
    'submit': 'submit'

  submit: =>
    old = @$el.find('#old').val()
    password = @$el.find('#new').val()
    confirmation = @$el.find('#confirm').val()

    current_user_password.set(oldPassword: old, password: password, passwordConfirmation: confirmation)
    current_user_password.save()
    false

  render: =>
    @$el.html @template()
    return this


