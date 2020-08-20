class BookingController < ApplicationController

    before '/bookings*' do
        auth
    end

    get '/bookings/new' do
        erb :'bookings/new'
    end

    post '/bookings' do
        new_booking = Booking.create(name: params[:name])
        params.each { |key, val| new_booking.send("#{key}=", val) if new_booking.respond_to?("#{key}=") }
        if !params[:booking].nil?
            params[:booking][:employees].each { |employee| new_booking.employees << Employee.find(employee) }
        end
        new_booking.save
        if params[:tenant_id] == '0' && !params[:new_tenant].empty?
            new_tenant = Tenant.create(org_name: params[:new_tenant])
            current_user(session).tenants << new_tenant
            new_booking.update(tenant_id: new_tenant.id)
            redirect to "/tenants/#{new_tenant.id}/edit"
        else
            redirect to "/bookings/#{new_booking.id}"
        end
    end

    get '/bookings/:id' do
        @booking = Booking.find(params[:id])
        current_user(session).bookings.include?(@booking) ? (erb :'bookings/booking') : (redirect to '/bookings')
    end

    get '/bookings/:id/edit' do
        @booking = Booking.find(params[:id])
        current_user(session).bookings.include?(@booking) ? (erb :'bookings/edit') : (redirect to '/bookings')
    end

    patch '/bookings/:id' do
        @booking = Booking.find(params[:id])
        if current_user(session).bookings.include?(@booking)
            params.each { |key, val| @booking.send("#{key}=", val) if @booking.respond_to?("#{key}=") }
            @booking.employees.clear
            if !params[:booking].nil?
                params[:booking][:employees].each { |employee| @booking.employees << Employee.find(employee) unless @booking.employees.include?(Employee.find(employee)) }
            end
            @booking.save
            redirect to "/bookings/#{@booking.id}"
        else
            redirect to "/bookings"
        end
    end

    get '/bookings' do
        erb :'bookings/all'
    end

    get '/bookings/:id/delete' do
        @booking = Booking.find(params[:id])
        @booking.destroy if current_user(session).bookings.include?(@booking)
        redirect to "/bookings"
    end

end
