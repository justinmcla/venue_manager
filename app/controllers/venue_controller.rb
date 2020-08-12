class VenueController < ApplicationController

    get '/venues/new' do
        erb :'venues/new'
    end

    post '/venues/new' do
        new_venue = Venue.create(params)
        current_user(session).venues << new_venue
        redirect to "/venues/#{new_venue.id}"
    end

    get '/venues/:id' do
        @venue = Venue.find(params[:id])
        erb :'venues/venue'
    end

end
