require './config/environment'

class AppController < Sinatra::Base

  before do
      @title = 'Catchup!'
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

    get '/' do
      erb :'layout'
    end


    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        @current_user ||= User.find_by_id(session[:user_id])
      end
    end
  end
