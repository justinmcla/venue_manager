class TaskController < ApplicationController

    before '/tasks*' do
        auth
    end

    get '/tasks/new' do
        erb :'tasks/new'
    end

    post '/tasks/new' do
        new_task = Task.create(params)
        current_user(session).tasks << new_task
        redirect to '/home'
    end

    get '/tasks/:id/edit' do
        @task = Task.find(params[:id])
        current_user(session).tasks.include?(@task) ? (erb :'tasks/edit') : (redirect to '/home')
    end

    patch '/tasks/:id' do
        @task = Task.find(params[:id])
        if current_user(session).tasks.include?(@task)
            params.delete(:_method)
            @task.update(params)
        end
        redirect to '/home'
    end

    get '/tasks/:id/delete' do
        @task = Task.find(params[:id])
        @task.destroy if current_user(session).tasks.include?(@task)
        redirect to '/home'
    end

end