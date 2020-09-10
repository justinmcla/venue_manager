class TaskController < ApplicationController

    get '/tasks/new' do
        erb :'tasks/new'
    end

    post '/tasks/new' do
        new_item = Task.new(params)
        if new_item.save
            current_user(session).tasks << new_item
            redirect to '/home'
        else
            flash[:error] = new_item.errors.full_messages.join(', ')
            redirect to "/tasks/new"
        end
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