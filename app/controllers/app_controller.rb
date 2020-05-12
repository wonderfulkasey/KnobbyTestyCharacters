require './config/environment'

class AppController < Sinatra::Base

  before do
      @title = 'Haversack!'
    end

  enable :sessions

  #register Sinatra::Flash
    set :views, 'app/views'
    set :public_folder, 'app/public'

    configure :development do
      set :session_secret, 'only_for_development'
    end

    configure :production do
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    end

    get "/" do
      if logged_in?
        redirect to('/index')
      else
        erb :layout
      end
    end

    helpers do


      def current_user
        @current_user ||= User.find(session[:user_id])
      end

      def logged_in?
           !!session[:user_id]
         end


    end
  end
