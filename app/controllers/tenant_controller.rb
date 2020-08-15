class TenantController < ApplicationController

    before '/tenants*' do
        auth
    end

    get '/tenants/new' do
        erb :'tenants/new'
    end
    
    post '/tenants/new' do
        new_tenant = Tenant.create(params)
        current_user(session).tenants << new_tenant
        redirect to "/tenants/#{new_tenant.id}"
    end

    get '/tenants/:id' do
        @tenant = Tenant.find(params[:id])
        current_user(session).tenants.include?(@tenant) ? (erb :'tenants/tenant') : (redirect to '/tenants')
    end

    get '/tenants' do
        erb :'tenants/all'
    end

    get '/tenants/:id/edit' do
        @tenant = Tenant.find(params[:id])
        current_user(session).tenants.include?(@tenant) ? (erb :'tenants/edit') : (redirect to '/tenants')
    end

    patch '/tenants/:id' do
        @tenant = Tenant.find(params[:id])
        if current_user(session).tenants.include?(@tenant)
            params.each { |key, val| @tenant.send("#{key}=", val) if @tenant.respond_to?("#{key}=") }
            @tenant.save
            redirect to "/tenants/#{@tenant.id}"
        else
            redirect to "/tenants"
        end
    end

    get '/tenants/:id/delete' do
        @tenant = Tenant.find(params[:id])
        @tenant.destroy if current_user(session).tenants.include?(@tenant)
        redirect to '/tenants'
    end
end
