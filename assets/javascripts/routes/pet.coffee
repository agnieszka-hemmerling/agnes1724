#router.route 'pet/profile', '', ->
#  autocomplete = (response)->
#    $("input[name='animal']").typeahead source: response.animals
#    $("input[name='breed']").typeahead source: response.breeds

#  $.getJSON '/pet/profile.json', (response)->
#    console.log response
#    $('#yield').html JST["pet/pets"]
#    $ ->
#      for pet in response.pets
#        $('#pets .tab-content').append JST["pet/pet_profile"](pet: pet)
#        $('#pets ul').append JST['pet/pet_li'](pet: pet)

#      $('#pets .tab-content').append JST["pet/pet_profile"](pet: response.new_pet)
#      $('#pets ul').append JST['pet/pet_li'](pet: response.new_pet)
#      $('#pets ul li a').first().click()

#      autocomplete(response)

#      $("[data-petname='newpet'] form").submit ->
        
#        $tab = $("#pets li.active a")
##        petname = $(this).find("[name='pet_name']").val()
#        $tab.text petname
#        $tab.attr href: "[data-petname='#{petname}']"

#        window.tab = $tab

#        $content = $(this).closest('.tab-pane')
#        $content.attr 'data-petname', petname
#        window.content = $content
#        $('#pets .tab-content').append JST["pet/pet_profile"](pet: response.new_pet)
#        $('#pets ul').append JST['pet/pet_li'](pet: response.new_pet)

#      $('#add_pet').live 'click', ->
#        $('#pets').append JST["pet/pet_profile"](pet: response.new_pet)
#        autocomplete(response)


#    $('form#pet').live 'submit', ->
#      $.post '/pet/profile.json',
#        pet_name: $(this).find("[name='pet_name']").val()
#        _pet_name: $(this).find("[name='_pet_name']").val()
#        breed: $(this).find("[name='breed']").val()
#        animal: $(this).find("[name='animal']").val()
#      false

