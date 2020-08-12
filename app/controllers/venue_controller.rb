class VenueController < ApplicationController

    get '/venues/new' do
        erb :'venues/new'
    end

    post '/venues/new' do
        new_venue = Venue.create(params)
        current_user(session).venues << new_venue
        redirect "/venues/#{new_venue.id}"
    end

    get '/venues' do
        erb :'venues/all'
    end

    get '/venues/:id' do
        @venue = Venue.find(params[:id])
        erb :'venues/venue'
    end

    get '/venues/:id/edit' do
        @venue = Venue.find(params[:id])
        erb :'venues/edit'
    end

    patch '/venues/:id' do
        @venue = Venue.find(params[:id])
        params.each { |key, val| @venue.send("#{key}=", val) if @venue.respond_to?("#{key}=") }
        @venue.save
        redirect to "/venues/#{@venue.id}"
    end

end
