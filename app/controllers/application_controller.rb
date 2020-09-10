require './config/environment'

class ApplicationController < Sinatra::Base
    register Sinatra::Flash

    enable :sessions
    begin
        set :session_secret, ENV.fetch('SESSION_SECRET')
    rescue
        puts <<-ERROR
        Unable to fetch SESSION_SECRET.
        Session will not be encrypted. 
        Refer to README.md for help.
        ERROR
    end
    set (:cookie_options) do 
        { :expires => Time.now + 3600*24*30 } 
    end
    
    configure do
        set :views, 'app/views'
        set :public_dir, 'public'
    end

    not_found do
        status 404
        erb :'404'
    end

    get '/' do
        redirect to '/home' if is_logged_in?(session)
        erb :index
    end

    helpers do
        def is_logged_in?(session)
            !!session[:user_id]
        end
        def current_user(session)
            User.find(session[:user_id])
        end
        def auth
            redirect to "/" unless is_logged_in?(session)
        end
        def update_safe(var)
            params.each { |key, val| var.send("#{key}=", val) if var.respond_to?("#{key}=") }
            var.save
        end
        def validate_form(var, att, path)
            if var.save
                current_user(session).send(att) << var
                redirect to path
            else
                flash[:error] = var.errors.full_messages.join(', ')
                redirect to request.path_info
            end
        end
    end

    before '/:route*' do
        pass if params[:route] == '' || params[:route] == 'signup' || params[:route] == 'login'
        auth
    end

    before '/:route/:id*' do
        pass if params[:id] == 'new'
        case params[:route]
        when 'bookings'
            @booking = Booking.find(params[:id])
            redirect to '/bookings' unless current_user(session).bookings.include?(@booking)
        when 'employees'
            @employee = Employee.find(params[:id])
            redirect to '/employees' unless current_user(session).employees.include?(@employee)
        when 'tasks'
            @task = Task.find(params[:id])
            redirect to '/home' unless current_user(session).tasks.include?(@task)
        when 'tenants'
            @tenant = Tenant.find(params[:id])
            redirect to '/tenants' unless current_user(session).tenants.include?(@tenant)
        when 'venues'
            @venue = Venue.find(params[:id])
            redirect to '/venues' unless current_user(session).venues.include?(@venue)
        end
    end

end
