routes do
  get '/current_user.json' do
    user = @current_user
    response = {}
    response[:username] = user.username
    response[:email] = user.email
    if user.pet
      response[:pet_name] = user.pet.name
      response[:pet_city] = user.pet.city
      response[:pet_information] = user.pet.information
    end
    response[:avatar] = user.avatar_url
    response[:photos] = []
    user.photos.each do |p|
      photo = {}
      photo[:url] = p.url
      photo[:thumb_url] = p.thumb_url
      response[:photos] << photo
    end
    response.to_json
  end

  get '/users_list.json' do
    @users = User.all
    @responses = []
    @users.each do |user|
      response = {}
      response[:username] = user.username
      response[:avatar_url] = user.avatar_url

      @responses.push response
    end
    @responses.to_json
  end

  get '/users.json' do
    @users = User.all
    @responses = []
    @users.each do |user|
      response = {}
      response[:username] = user.username
#      response[:email] = user.email
      if user.pet
        response[:pet_name] = user.pet.name
        response[:pet_city] = user.pet.city
        response[:pet_information] = user.pet.information
      end
      response[:avatar] = user.avatar_url
      response[:photos] = []
      user.photos.each do |p|
        photo = {}
        photo[:url] = p.url
        photo[:thumb_url] = p.thumb_url
        response[:photos] << photo
      end
      @responses.push response
    end
      @responses.to_json
  end
end
