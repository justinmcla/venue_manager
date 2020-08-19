class TaskController < ApplicationController

    before '/tasks*' do
        auth
    end

    before '/tasks/:id*' do
        pass if params[:id] == 'new'
        @task = Task.find(params[:id])
        redirect to '/home' unless current_user(session).tasks.include?(@task)
    end

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
        params.delete(:_method)
        @task.update(params)
        redirect to '/home'
    end

    get '/tasks/:id/delete' do
        @task.destroy
        redirect to '/home'
    end

end