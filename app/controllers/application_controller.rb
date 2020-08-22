require './config/environment'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash

    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

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
        def auth
            redirect to "/" unless is_logged_in?(session)
        end
        def update_safe(var)
            params.each { |key, val| var.send("#{key}=", val) if var.respond_to?("#{key}=") }
            var.save
        end
    end

end
