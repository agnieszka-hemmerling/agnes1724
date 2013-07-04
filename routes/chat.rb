routes do

#  get '/chat' do
#    @current_user.chat_messages.to_json
#    ChatMessage.all.to_json(:only => :body)
#  end

  get '/chat' do
    users = User.all
    responses = []
      users.each do |u|
      response = {}
      response[:username] = u.username
      responses.push response
    end
    responses.to_json
  end


  post '/chat' do
   params = JSON.parse(request.body.read.to_s)
      
    msg = ChatMessage.new
    msg.body = params['body']
    msg.to_user = User.first(:username => params['to_user'])
    msg.from_user = @current_user
    msg.save
    @current_user.chat_messages << msg
    @current_user.save

    response = {}
    response[:body] = msg.body
    response[:from_user] = msg.from_user.username
    response[:to_user] = msg.to_user.username
    response[:id] = msg.id
    return 200
  end

end
