routes do  

  get '/messages/inbox/:id' do
    @message = Message.find(params[:id])

    response = {}
    response[:body] = @message.body
    response[:from_user] = @message.from_user.username
    response[:to_user] = @message.to_user.username
    response[:created_at_strftime] = @message.created_at.strftime "%H:%M:%S %d/%m/%y" 
    response.to_json
  end

  get '/messages/inbox' do
    @messages = []
    @messages = Message.all(:to_user_id => @current_user.id,
                            :order => :created_at.asc)
    @responses = []
    @messages.each do |message|
      
      response = {}
      response[:id] = message.id
      response[:body] = message.body

      response[:created_at_ago] = time_ago_in_words(message.created_at)
      response[:created_at] = message.created_at.utc.iso8601
      response[:created_at_strftime] = message.created_at.strftime "%H:%M:%S %d/%m/%y" 
      response[:from_user] = {}
      response[:from_user][:username] = message.from_user.username
      response[:to_user] = {}
      response[:to_user][:username] = message.to_user.username
      @responses << response
    end
    @responses.to_json
  end

  delete '/messages/:id' do
    message = Message.get(params[:id])
    message.destroy
      return [200, 'Your message has been deleted']
  end

  post '/messages' do
    params = JSON.parse(request.body.read.to_s)
    Message.create(
      :from_user => @current_user,
      :to_user => User.first(:username => params['to_user']),
      :body => params['body'])

    return [ 200, 'Your message has been sent']
  end

  post '/messages/inbox' do

  params = JSON.parse(request.body.read.to_s)

   Message.create(

    :from_user_id => @current_user,
    :to_user_id => User.first(:username => params['to_user']).id,
    :body => params[:body])
    return [ 200, 'Your message has been sent']
  end


 get '/messages/compose.json' do

    response = { :username => @current_user.username}
    response.to_json
  end

  post '/messages/compose.json' do

   Message.create(

    :from_user_id => @current_user.id,
    :to_user_id => User.first(:username => params[:to_user]).id,
    :body => params[:body])
    return [ 200, 'Your message has been sent']
  end



  get '/messages/sent' do
    @messages = []
    @messages = Message.all(:to_user_id => @current_user.id, :order => :created_at.asc)
    @responses = []
    @messages.each do |message|
      
      response = {}
      response[:id] = message.id
      response[:body] = message.body

      response[:created_at_ago] = time_ago_in_words(message.created_at)
      response[:created_at] = message.created_at.utc.iso8601
      response[:created_at_strftime] = message.created_at.strftime "%H:%M:%S %d/%m/%y" 
      response[:from_user] = {}
      response[:from_user][:username] = message.from_user.username
      response[:to_user] = {}
      response[:to_user][:username] = message.to_user.username
      @responses << response
    end
    @responses.to_json
  end

  delete '/messages/sent/:id' do
    message = Message.get(params[:id])
    message.destroy
      return [200, 'Your message has been deleted']
  end
  get '/messages/sent/:id' do
    @message = Message.find(params[:id])

    response = {}
    response[:body] = @message.body
    response[:from_user] = @message.from_user.username
    response[:to_user] = @message.to_user.username
    response[:created_at_strftime] = @message.created_at.strftime "%H:%M:%S %d/%m/%y" 
    response.to_json
  end
end
