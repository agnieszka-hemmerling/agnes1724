class App.Views.Compose extends Backbone.View
  template: JST['backbone/templates/compose_messages/compose']


  events:
    'submit': 'post_message'
    'change #to_user': 'change'


  change: =>
    username = @$el.find('#to_user').val()

#    user = @users.where(username: username)[0]
#    avatar_url = user.get('avatar_url')

#   $image = $("<img src='#{avatar_url}'>")
#    @$el.find('#avatar_image').prepend($image)


  post_message: =>
    event.preventDefault()
    $.post '/messages/compose.json',
      to_user: @$el.find("[name='to_user']").val()
      body: @$el.find("[name='body']").val()


  render: =>

    @$el.html @template()
    ###
    users = new App.Collections.Users
    users.fetch
      url: '/users_list.json'
      success: (users)=>
        @users = users
        kwadraty = []
        for user in users.models
          kwadraty.push user.get('username')

        @$el.find('#to_user').typeahead
          source: kwadraty
    ###
    return this
