###
$ ->
  
  setInterval ->

    $.getJSON '/chat.json',(data) ->
      $('#box').html('')
      $(data).each ->
        $('#box').append this.body
        $('#box').append '<br>'
      $('#box').scrollTop(100000)
  , 1000


  close_chat = ()->
    $('#chatbox').animate(height: 20, 100)
    $('#chatbox textarea').hide()
    document.cookie = 'closed'
  open_chat = ()->
    $('#chatbox').animate(height: 300, 100)
    $('#chatbox textarea').show()
    document.cookie = 'open'

  if document.cookie == 'closed'
    $('#chatbox').css(height: 20)
    $('#chatbox textarea').hide()

  $('#top').on 'click', ->
    if $('#chatbox').height() >= 300
      close_chat()
    else
      open_chat()

  $('textarea').keypress (e)->
    if e.which == 13
      $.post('/chat.json', {body: $(this).val()})
      $(this).val('')
      this.setSelectionRange(0, 0)
      e.preventDefault()
  ###
