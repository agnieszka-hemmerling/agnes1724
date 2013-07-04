router.route 'home/*filename', '', (filename)->
  $.getJSON '/photos/upload.json', (data)->
    $('#home-page').html JST['user/gallery'](photos: data)

    if not $('#home-page').is(':visible')
      $('#home-page').animate
        width: 'toggle'
        height: 'linear'
      ,300

    $('.close-gallery').click ->
      $('#home-page').animate
        width: 'hide'
        height: 'linear'
      ,300




    if filename
    #  if $('.large').is(':visible')
    #    $('.large').hide()
    #  else

      $zdiecia = $(".zdiecia[data-filename='#{filename}']")
      $zdiecia.show()

      if $zdiecia.find('img.galeria-photo').height() > 600
        $zdiecia.find('img.galeria-photo').css height: 600
        $zdiecia.find('img.galeria-photo').css width: 'auto'

      next_href = $("#glowna-galeria a[data-filename='#{filename}']")
      .nextAll("a[data-filename]").first().attr('href')

      prev_href = $("#glowna-galeria a[data-filename='#{filename}']")
      .prevAll("a[data-filename]").first().attr('href')

      if next_href
        $zdiecia.find('.next-button').attr(href: next_href).css(opacity: 0.7)
      if prev_href
        $zdiecia.find('.prev-button').attr(href: prev_href).css(opacity: 0.7)

  #      $("[data-filename='#{filename}']").click()



