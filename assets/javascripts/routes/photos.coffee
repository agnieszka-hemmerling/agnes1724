#router.route 'user/:username/gallery/*filename','',



#router.route 'photos/upload/*filename','', (filename)->

#  $.getJSON '/photos/upload.json', (data)->
#    $('#yield').html JST['upload'](photos: data)

          

#    $ ->
#      new qq.FileUploader
#        element: document.getElementById('file-uploader')
#        action: '/photos/upload'
#        onComplete: (id, fileName, response)->
#          $('#gallery').append JST['photo'](photo: response.photo)

#      $('.icon').live 'click', ->
#        filename = $(this).closest('.my-gallery.img').data('filename')
#        $.ajax
#          type: 'DELETE'
#          url: "/photos/#{filename}"
#        $(this).closest('.my-gallery.img').fadeOut()
#        event.stopPropagation()

#      $(".my-gallery.img").live 'mouseenter',  ->
#        $(this).animate
#          backgroundColor: "#cbc9cf"
#          , 300

#        $(this).find('.icon').show()
#      $(".my-gallery.img").live 'mouseleave',  ->
#        $(this).animate
#          backgroundColor: "transparent"
#          , 100
#        $(this).find('.icon').hide()

#      $('.large-close').live 'click', ->
#        $(this).closest('.js-large').fadeOut()



#      if filename

#        $large = $(".js-large[data-filename='#{filename}']")
#        $large.show()

#        $next_thumb = $("#gallery a[data-filename='#{filename}']").nextAll("a[data-filename]").first()

#        $('.next-photo').attr
#          src: $next_thumb.find('.male-photo').attr('src')

#        next_href = $next_thumb.attr('href')

#        prev_href = $("#gallery a[data-filename='#{filename}']")
#        .prevAll("a[data-filename]").first().attr('href')

#        $large.find('.next').mouseover ->
#          $('.next-photo').show()
#        $large.find('.next').mouseout ->
#          $('.next-photo').hide()
          
#        if next_href
#          $large.find('.next').attr(href: next_href).css(opacity: 0.7)
#        if prev_href
#          $large.find('.prev').attr(href: prev_href).css(opacity: 0.7)

#        if $large.find('img.large-photo').height() > 600
#          $large.find('img.large-photo').css height: 600
#          $large.find('img.large-photo').css width: 'auto'


    #      $("[data-filename='#{filename}']").click()


