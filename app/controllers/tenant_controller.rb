class TenantController < ApplicationController

    before '/tenants*' do
        auth
    end

    before '/tenants/:id*' do
        pass if params[:id] == 'new'
        @tenant = Tenant.find(params[:id])
        redirect to '/tenants' unless current_user(session).tenants.include?(@tenant)
    end

    get '/tenants/new' do
        erb :'tenants/new'
    end
    
    post '/tenants/new' do
        current_user(session).tenants << Tenant.create(params)
        redirect to "/tenants/#{Tenant.last.id}"
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

    get '/tenants/:id/delete' do
        @tenant.destroy
        redirect to '/tenants'
    end
end
