#router.route 'settings', 'settings', ->
#  $('#topnav').show 1, ->
#    $("a[href='/settings/email']").click()

#router.route 'settings/email', 'settings-email', ->
#  $('#topnav').show()
#  $.getJSON '/settings/email.json', (data, e)->
#    $('#inurl').html(JST["user_email"](current_user_email: data))

#$('form#email').live 'submit', ->
#  $.post '/settings/email.json',
#    email: $(this).find("[name='email']").val()
#  false
