require './config/environment'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash

    set :database, {adapter: "sqlite3", database: "db/venue.sqlite3"}
    enable :sessions
    set :session_secret, "development"

    configure do
        set :views, 'app/views'
        set :public_dir, 'public'
    end

    get '/' do
        erb :index
    end

    helpers do
        def is_logged_in?(session)
            !!session[:user_id]
        end
        def current_user(session)
            User.find(session[:user_id])
        end
    end

end
