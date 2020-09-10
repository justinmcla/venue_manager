class BookingController < ApplicationController

    get '/bookings/new' do
        erb :'bookings/new'
    end

    post '/bookings' do
        new_booking = Booking.new(name: params[:name], date: params[:date], time: params[:time])
        if new_booking.save
            params[:employee_list].each { |employee| new_booking.employees << Employee.find(employee) } if params.has_key? :employee_list
            update_safe(new_booking)
            if params[:tenant_id] == '0' && !params[:new_tenant].empty?
                current_user(session).tenants << Tenant.create(org_name: params[:new_tenant])
                new_booking.update(tenant_id: Tenant.last.id)
                redirect to "/tenants/#{Tenant.last.id}/edit"
            else
                redirect to "/bookings/#{new_booking.id}"
            end
        else
            flash[:error] = new_booking.errors.full_messages.join(', ')
            redirect to '/bookings/new'
        end
    end

    get '/bookings/:id' do
        erb :'bookings/booking'
    end

    get '/bookings/:id/edit' do
        erb :'bookings/edit'
    end

    patch '/bookings/:id' do
        params[:employee_list].each { |employee| @booking.employees << Employee.find(employee) unless @booking.employees.include?(Employee.find(employee)) } if params.has_key? :employee_list
        update_safe(@booking)
        redirect to "/bookings/#{@booking.id}"
    end

    get '/bookings' do
        erb :'bookings/all'
    end

    delete '/bookings/:id' do
        @booking.destroy
        redirect to "/bookings"
    end

end
