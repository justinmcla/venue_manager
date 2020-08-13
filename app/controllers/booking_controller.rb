class BookingController < ApplicationController

    get '/bookings/new' do
        erb :'bookings/new'
    end

    post '/bookings/new' do
        new_booking = Booking.create(params)
        new_booking.venue_id = params[:venue_id]
        if params[:tenant_id] == '0'
            redirect to "/tenants/new"
        end
        redirect to "/bookings/#{new_booking.id}"
    end

    get '/bookings/:id' do
        @booking = Booking.find(params[:id])
        erb :'bookings/booking'
    end

    get '/bookings' do
        erb :'bookings/all'
    end


end
