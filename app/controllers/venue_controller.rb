class VenueController < ApplicationController

    before '/venues*' do
        auth
    end

    before '/venues/:id*' do
        pass if params[:id] == 'new'
        @venue = Venue.find(params[:id])
        redirect to '/venues' unless current_user(session).venues.include?(@venue)
    end

    get '/venues/new' do
        erb :'venues/new'
    end

    post '/venues/new' do
        current_user(session).venues << Venue.create(params)
        redirect "/venues/#{Venue.last.id}"
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
        params.each { |key, val| @venue.send("#{key}=", val) if @venue.respond_to?("#{key}=") }
        @venue.save
        redirect to "/venues/#{@venue.id}"
    end

    get '/venues/:id/delete' do
        @venue.destroy
        redirect to "/venues"
    end

end
