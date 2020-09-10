class TaskController < ApplicationController

    get '/tasks/new' do
        erb :'tasks/new'
    end

    post '/tasks/new' do
        new_item = Task.new(params)
        validate_form(new_item, 'tasks', '/home')
    end

    get '/tasks/:id/edit' do
        erb :'tasks/edit'
    end

    patch '/tasks/:id' do
        update_safe(@task)
        redirect to '/home'
    end

    delete '/tasks/:id' do
        @task.destroy
        redirect to '/home'
    end

end