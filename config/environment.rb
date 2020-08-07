ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'db/venue.sqlite'
)

require_all 'app'
require_all 'public'