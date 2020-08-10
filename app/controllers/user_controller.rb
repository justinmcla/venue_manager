class UserController < ApplicationController

    get "/signup" do
        erb :'user/signup'
      end
    
    post "/signup" do
        if params[:username].empty?
            flash[:message] = "You must enter a username."
            redirect '/signup'
        end
        if User.all.any? { |u| u.username == params[:username] }
            flash[:message] = "Username already in use."
            redirect '/signup'
        end
        user = User.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], password_digest: params[:password])
        if user.save
            session[:user_id] = user.id
            redirect '/home'
        else
            flash[:message] = "You must fill out all fields."
            redirect '/signup'
        end
    end

    get '/home' do
        erb :'user/home'
    end

    get '/login' do
        erb :'user/login'
    end

end