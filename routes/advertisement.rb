require 'json'

routes do
  get '/adverts' do
    @responses = []
    AdvertisementMessage.all.each do |a|
      advert = {}
      advert[:body] = a.body
      advert[:id] = a.id
      advert[:city] = a.city.name if a.city
      advert[:animal_type] = a.animal.name if a.animal

      @responses.push advert
    end

    @responses.to_json
  end

 get '/animals' do
    @responses = []

    Animal.all.each do |a|
      
      animal = {}
      animal[:id] = a.id
      animal[:name] = a.name

      @responses << animal
    end
    @responses.to_json
  end




  get '/adverts.old' do
    @animals = []
    @cities = []

    City.all.each do |c|
      city = {}
      city[:name] = c.name
      city[:id] = c.id
      @cities << city
    end
    @cities.to_yaml

    Animal.all.each do |a|
      
      animal = {}
      animal[:id] = a.id
      animal[:name] = a.name

      @animals << animal
    end

    r = {}
    r[:cities] = @cities
    r[:animals] = @animals
    r.to_json
  end


  delete '/adverts/:id' do
    @advert = AdvertisementMessage.get(params['id'])
    @advert.destroy
    return 200
  end

  post '/adverts' do
    params = JSON.parse(request.body.read.to_s)
    
    @advert = AdvertisementMessage.new
    @advert.animal = Animal.first_or_create(:name => params['animal'])
    @advert.body = params['body']
    @advert.city = City.first_or_create(:name => params['city'])
    @advert.user_id = @current_user.id
    @advert.save
    return [200]

  end
end

