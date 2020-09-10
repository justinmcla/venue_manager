class VenueController < ApplicationController

    get '/venues/new' do
        erb :'venues/new'
    end

    post '/venues/new' do
        new_venue = Venue.new(params)
        if new_venue.save
            current_user(session).venues << new_venue
            redirect "/venues/#{new_venue.id}"
        else
            flash[:error] = new_venue.errors.full_messages.join(', ')
            redirect to '/venues/new'
        end
    end

    get '/venues' do
        erb :'venues/all'
    end

    get '/venues/:id' do
        erb :'venues/venue'
    end

    get '/venues/:id/edit' do
        erb :'venues/edit'
    end

    patch '/venues/:id' do
        update_safe(@venue)
        redirect to "/venues/#{@venue.id}"
    end

    delete '/venues/:id' do
        @venue.destroy
        redirect to "/venues"
    end

end
