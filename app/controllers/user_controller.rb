class UserController < ApplicationController

    get "/signup" do
        erb :'user/signup'
      end
    
    post "/signup" do
        if User.all.any? { |u| u.username == params[:username] }
            flash[:error] = "Username already in use."
            redirect '/signup'
        end
        user = User.create(params)
        session[:user_id] = user.id
        redirect '/home'
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
        if User.all.any? { |u| u.username == params[:username] }
            flash[:error] = "Username already in use."
            redirect '/account'
        end
        current_user(session).update(username: params[:username])
        redirect to '/account'
    end

    get '/account/password_change' do
        auth
        erb :'user/password'
    end

    patch '/account/password_change' do
        auth
        if current_user(session) && current_user(session).authenticate(params[:old_password])
            if params[:new_password_1] == params[:new_password_2]
                current_user(session).update(password: params[:new_password_1])
                flash[:error] = "Password successfully updated."
                redirect to '/account'
            else
                flash[:error] = "New password does not match confirmation. Password not updated. Please try again."
                redirect to '/account/password_change'
            end
        else
            flash[:error] = "Invalid password. Password not updated. Please try again."
            redirect to '/account/password_change'
        end
    end

    get '/account/delete' do
        auth
        erb :'user/delete'
    end

    post '/account/delete' do
        auth
        if params[:password_1] == params[:password_2]
            if current_user(session) && current_user(session).authenticate(params[:password_1])
                current_user(session).tasks.destroy
                current_user(session).inventories.each do |i|
                    i.items.each do |item|
                        item.destroy
                    end
                    i.destroy
                end
                current_user(session).employees.destroy
                current_user(session).tenants.destroy
                current_user(session).bookings.destroy
                current_user(session).venues.destroy
                deleted_userid = current_user(session).id
                session.clear
                User.find(deleted_userid).destroy
                redirect to '/'
            else
                flash[:error] = "Invalid password."
                redirect to 'account/delete'
            end
        else
            flash[:error] = "Passwords do not match."
            redirect to 'account/delete'
        end
    end


end