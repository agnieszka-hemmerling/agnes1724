window.App ||= {}
App.Views.Register ||= {}

class App.Models.Register extends Backbone.Model
  url: =>
    "/register"


class App.Views.Register.SignUp extends Backbone.View
  template: JST['backbone/templates/register/register']



  events:
    'submit': 'submit'

  submit: =>
    username = @$el.find('#username').val()
    mail = @$el.find('#mail').val()
    password = @$el.find('#password').val()
    confirmation = @$el.find('#confirmation').val()

    register.save(username: username, email: mail, password: password, password_confirmation: confirmation)
    false

  render: =>
    @$el.html @template()
    return this



