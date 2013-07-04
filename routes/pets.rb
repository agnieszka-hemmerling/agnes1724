require 'yaml'
routes do
  get '/pets' do
    @pets = []
    @current_user.pets.each do |p|
      pet = {}
      pet[:name] = p.name
      pet[:animal] = p.animal.name if p.animal

      pet[:animals] = []

      pet[:breed] = p.breed.name if p.breed

      pet[:breeds] = []
      @pets.push pet
    end
    return @pets.to_json
  end

  get '/breeds' do
    response = []
    @breeds = Breed.all
    
    @breeds.each do |b|
      breed = {}
      breed['name'] = b.name
      response.push breed
    end
    return response.to_json
  end

  get '/pet/old' do

    @pets = []
    @current_user.pets.each do |p|
      pet = {}
      pet[:name] = p.name
      pet[:city] = p.city
      pet[:animal] = p.animal.name if p.animal

      pet[:animals] = []

      pet[:breed] = p.breed.name if p.breed

      pet[:breeds] = []
      @pets.push pet
    end
    @res = {}

    @breeds = Breed.all

    @res[:breeds] = []
    @breeds.each do |breed|
      @res[:breeds].push breed.name
    end

    @animals = Animal.all

    @res[:animals] = []
    @animals.each do |animal|
      @res[:animals].push animal.name
    end
    
    @res[:pets] = @pets
    @res[:new_pet] = {}
    @res[:new_pet][:name] = 'newpet'
    @res[:new_pet][:breed] = ''
    @res[:new_pet][:animal] = ''
    @res.to_json
  end

  post '/pets.old' do

    puts params
    if Pet.first_or_create(
      :user_id => @current_user.id,
      :name => params[:_pet_name]).update(

        :name => params[:pet_name],
        :animal => Animal.first_or_create(:name => params[:animal]),
        :breed => Breed.first_or_create(:name => params[:breed]),
        :user_id => @current_user.id)
    return [200 , "Your information is updated"]
    end
  end

  post '/pets' do
    params = JSON.parse(request.body.read.to_s)
      
    @pet = Pet.new
    @pet.name = params['name']
    @pet.user_id = @current_user.id
    @pet.animal = Animal.first_or_create(:name => params['animal'])
    @pet.breed = Breed.first_or_create(:name => params['breed'])
    @pet.save
    return [200 , "Your information is updated"]
  end

  put '/pets' do
    params = JSON.parse(request.body.read.to_s)
    @pet = Pet.get(params['id'])
    @pet.update(:name => params['name'], :user_id => @current_user.id, 
    :animal => Animal.first_or_create(:name => params['animal']),
    :breed => Breed.first_or_create(:name => params['breed']))
  end
end
