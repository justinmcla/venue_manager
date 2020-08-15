class UserController < ApplicationController

    include BCrypt

    get "/signup" do
        erb :'user/signup'
      end
    
    post "/signup" do
        if params[:username].empty?
            flash[:error] = "You must enter a username."
            redirect '/signup'
        end
        if User.all.any? { |u| u.username == params[:username] }
            flash[:error] = "Username already in use."
            redirect '/signup'
        end
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect '/home'
        else
            flash[:error] = "You must fill out all fields."
            redirect '/signup'
        end
    end

    get '/home' do
        auth
        erb :'user/home'
    end

    get '/login' do
        erb :'user/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/home'
        else
            flash[:error] = "Invalid username/password."
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/account' do
        auth
        erb :'user/account'
    end

    patch '/account' do
        auth
        if !params[:username].empty? 
            user = current_user(session)
            user.username = params[:username]
            user.save
            redirect to '/account'
        else
            flash[:error] = "Invalid username."
            redirect to '/account'
        end
    end
end