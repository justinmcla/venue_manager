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
        user = User.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], password_digest: Password.create(params[:password]))
        if user.save
            session[:user_id] = user.id
            redirect '/home'
        else
            flash[:error] = "You must fill out all fields."
            redirect '/signup'
        end
    end

    get '/home' do
        erb :'user/home'
    end

    get '/login' do
        erb :'user/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && Password.new(user.password_digest) == params[:password]
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

    helpers do
        def is_logged_in?(session)
            !!session[:user_id]
        end
        def current_user(session)
            User.find(session[:user_id])
        end
    end

end