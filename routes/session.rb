require 'yaml'

routes do
  require 'action_view'
  include ActionView::Helpers::DateHelper

  class HtmlSafeString < String
    def html_safe?
      true
    end
  end

    helpers do
      def no_escape(path)
        path = HtmlSafeString.new(path)
      end
    end
    before do

      if session[:user_id]
        @current_user = User.find(session[:user_id])
#      else
#        @layout = :'register-layout'
      end
    end

    get '/' do
      session[:user_id] ||= false
      if session[:user_id]
       @current_user = User.find(session[:user_id])
      else
        flash.now[:info] = 'Please sign in'
      end
      slim :index# , :layout => @layout

    end

    get '/register' do
      @errors = []
    end

    post '/register' do
      
      params = JSON.parse(request.body.read.to_s)      
      @errors = []
        user = User.create(:username => params['username'],
                       :password => params['password'], 
                       :password_confirmation => params['password_confirmation'],
                       :email => params['email'])


      if user.errors.any?
        @errors = user.errors
        flash[:error] = 'Registration failed:'
      else
        flash[:success] = "Thank You for Your Registration!"
        session[:user_id] = user.id
#        return redirect :/
      end
   end

      
    post '/login' do  
    # logowanie nowego usera
      @current_user = User.first(:username => params[:username],
                      :password => params[:password])

      if @current_user
        session[:user_id] = @current_user.id
        flash[:success] = 'You are now logged in'
      else
        flash[:error] = "Incorrect username or password"
      end
      return redirect :/
    end

    get '/logout' do
      session[:user_id] = false
      flash[:info] = "You are now logged out"
      redirect :/
    end

end

