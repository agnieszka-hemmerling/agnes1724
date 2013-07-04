routes do
  get '/current_user' do
    response = {}
    response[:email] = @current_user.email
    response[:username] = @current_user.username
    response.to_json
  end

  post '/current_user' do
    params = JSON.parse(request.body.read.to_s)
    @current_user.email = params['email']
    @current_user.save
    200
  end

  get '/settings/password' do
  end

  post '/settings/password' do
  params = JSON.parse(request.body.read.to_s)

    if not @current_user.password == params['oldPassword']
      return [422, 'Current password invalid']
    end

    if params['password']  != params['passwordConfirmation']
      return [422, 'Password does not match confirmation']
    end
    @current_user.password = params['password']

    if @current_user.save
      return [200, 'You have successfully updated your password']
    else 
      return [422, @current_user.errors.to_json]
    end

  end

  get '/settings/email/:id' do
    @current_user.email.to_json
  end
  post '/settings/email/:id' do
  params = JSON.parse(request.body.read.to_s)

    @current_user.email = params['email']
    

    if @current_user.save
      return [200, 'You have successfully updated your email address']
    else
      return [422, @current_user.errors.to_json]
    end
  end

end
