class EmployeeController < ApplicationController
    before '/employees*' do
        auth
    end

    get '/employees/new' do
        erb :'employees/new'
    end

    post '/employees/new' do
        new_emp = Employee.create(params)
        current_user(session).employees << new_emp
        redirect to "/employees/#{new_emp.id}"
    end

    get '/employees' do
        erb :'employees/all'
    end

    get '/employees/:id' do
        @employee = Employee.find(params[:id])
        current_user(session).employees.include?(@employee) ? (erb :'employees/employee') : (redirect to '/employees')
    end

    get '/employees/:id/edit' do
        @employee = Employee.find(params[:id])
        current_user(session).employees.include?(@employee) ? (erb :'employees/edit') : (redirect to '/employees')
    end

    patch '/employees/:id' do
        @employee = Employee.find(params[:id])
        if current_user(session).employees.include?(@employee)
            params[:end_date].empty? ? @employee.update(active: true) : @employee.update(active: false)
            params.delete(:_method)
            @employee.update(params)
            redirect to "/employees/#{@employee.id}"
        else
            redirect to '/employees'
        end
    end

    get '/employees/:id/delete' do
        @employee = Employee.find(params[:id])
        if current_user(session).employees.include?(@employee)
            @employee.destroy
        end
        redirect to '/employees'
    end
end
