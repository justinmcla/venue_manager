class EmployeeController < ApplicationController
    before '/employees*' do
        auth
    end

    before '/employees/:id*' do
        pass if params[:id] == 'new'
        @employee = Employee.find(params[:id])
        redirect to '/employees' unless current_user(session).employees.include?(@employee)
    end

    get '/employees/new' do
        erb :'employees/new'
    end

    post '/employees/new' do
        current_user(session).employees << Employee.create(params)
        redirect to "/employees/#{Employee.last.id}"
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
        params.each { |key, val| @employee.send("#{key}=", val) if @employee.respond_to?("#{key}=") }
        @employee.save
        redirect to "/employees/#{@employee.id}"
    end

    get '/employees/:id/delete' do
        @employee.destroy
        redirect to '/employees'
    end
end
