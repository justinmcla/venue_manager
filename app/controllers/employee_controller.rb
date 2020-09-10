class EmployeeController < ApplicationController

    get '/employees/new' do
        erb :'employees/new'
    end

    post '/employees/new' do
        new_emp = Employee.new(params)
        if new_emp.save
            current_user(session).employees << new_emp
            redirect to "/employees/#{Employee.last.id}"
        else
            flash[:error] = new_emp.errors.full_messages.join(', ')
        end
    end

    get '/employees' do
        erb :'employees/all'
    end

    get '/employees/:id' do
        erb :'employees/employee'
    end

    get '/employees/:id/edit' do
        erb :'employees/edit'
    end

    patch '/employees/:id' do
        params[:end_date].empty? ? @employee.update(active: true) : @employee.update(active: false)
        update_safe(@employee)
        redirect to "/employees/#{@employee.id}"
    end

    delete '/employees/:id' do
        @employee.destroy
        redirect to '/employees'
    end
end
