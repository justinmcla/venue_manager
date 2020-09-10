class TenantController < ApplicationController

    get '/tenants/new' do
        erb :'tenants/new'
    end
    
    post '/tenants/new' do
        new_tenant = Tenant.new(params)
        if new_tenant.save
            current_user(session).tenants << new_tenant
            redirect to "/tenants/#{new_tenant.id}"
        else
            flash[:error] = new_tenant.errors.full_messages.join(', ')
            redirect to '/tenants/new'
        end
    end

    get '/tenants/:id' do
        erb :'tenants/tenant'
    end

    get '/tenants' do
        erb :'tenants/all'
    end

    get '/tenants/:id/edit' do
        erb :'tenants/edit'
    end

    patch '/tenants/:id' do
        update_safe(@tenant)
        redirect to "/tenants/#{@tenant.id}"
    end

    delete '/tenants/:id' do
        @tenant.destroy
        redirect to '/tenants'
    end
end
