routes do

  get '/home.json' do

    response = {}
    response[:username] = @current_user.username
    response[:email] = @current_user.email
    response[:pet_name] = @current_user.pet.name
    response[:pet_city] = @current_user.pet.city
    response[:pet_information] = @current_user.pet.information
    response[:avatar] = @current_user.avatar_url
    response[:photos] = []
    @current_user.photos.each do |p|
      photo = {}
      photo[:url] = p.url
      photo[:thumb_url] = p.thumb_url
      response[:photos] << photo
    end
    response.to_json
    end

  get '/user.json' do

    response = {}
    response[:username] = @current_user.username
    response[:email] = @current_user.email
    response[:pet_name] = @current_user.pet.name
    response[:pet_city] = @current_user.pet.city
    response[:pet_information] = @current_user.pet.information
    response[:avatar] = @current_user.avatar_url
    response[:photos] = []
    @current_user.photos.each do |p|
      photo = {}
      photo[:url] = p.url
      photo[:thumb_url] = p.thumb_url
      response[:photos] << photo
    end
    response.to_json
    end
end
