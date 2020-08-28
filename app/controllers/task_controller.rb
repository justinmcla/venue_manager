class TaskController < ApplicationController

    get '/tasks/new' do
        erb :'tasks/new'
    end

    post '/tasks/new' do
        current_user(session).tasks << Task.create(params)
        redirect to '/home'
    end

    get '/tasks/:id/edit' do
        erb :'tasks/edit'
    end

    patch '/tasks/:id' do
        update_safe(@task)
        redirect to '/home'
    end

    get '/tasks/:id/delete' do
        @task.destroy
        redirect to '/home'
    end

end