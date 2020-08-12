class VenueController < ApplicationController

    get '/venues/new' do
        erb :'venues/new'
    end

    post '/venues/new' do
        new_venue = Venue.create(params)
        new_venue.user_id = current_user(session).id
        redirect to "/venues/#{new_venue.id}"
    end

end
