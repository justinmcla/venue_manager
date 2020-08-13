class BookingController < ApplicationController

    get '/bookings/new' do
        erb :'bookings/new'
    end

    post '/bookings/new' do
        new_booking = Booking.create(params)
        new_booking.venue_id = params[:venue_id]
        redirect to "/bookings/#{new_booking.id}"
    end

    get '/bookings/:id' do
        @booking = Booking.find(params[:id])
        erb :'bookings/booking'
    end

    get '/bookings/:id/edit' do
        @booking = Booking.find(params[:id])
        erb :'bookings/edit'
    end

    patch '/bookings/:id' do
        @booking = Booking.find(params[:id])
        params.each { |key, val| @booking.send("#{key}=", val) if @booking.respond_to?("#{key}=") }
        @booking.save
        redirect to "/bookings/#{@booking.id}"
    end

    get '/bookings' do
        erb :'bookings/all'
    end

    get '/bookings/:id/delete' do
        @booking = Booking.find(params[:id])
        @booking.destroy
        redirect to "/bookings"
    end


end
