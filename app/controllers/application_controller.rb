require './config/environment'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    set :database, {adapter: "sqlite3", database: "db/venue.sqlite3"}

    configure do
        set :views, 'app/views'
        set :public_dir, 'public'
    end

    get '/' do
        erb :index
    end

end
