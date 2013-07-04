routes do
  get '/search' do
    @results = User.all(:username.like => "%#{params[:username]}%")
    @results.to_json

  end

  post '/search' do
    params = JSON.parse(request.body.read.to_s)

    @results = User.all( :username.like => "%#{params['username']}%")# +
   # User.all(:email => params['email'])

    @results.to_json(:only => [:username,:email, :id, :avatar_url])

  end

end

