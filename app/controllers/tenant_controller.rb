class TenantController < ApplicationController

    get '/tenants/new' do
        erb :'tenants/new'
    end
    
    post '/tenants/new' do
        new_tenant = Tenant.new(params)
        current_user(session).tenants << new_tenant
        redirect to "/tenants/#{new_tenant.id}"
    end

    get '/tenants/:id' do
        @tenant = Tenant.find(params[:id])
        erb :'tenants/tenant'
    end

    get '/tenants' do
        erb :'tenants/all'
    end

    get '/tenants/:id/edit' do
        @tenant = Tenant.find(params[:id])
        erb :'tenants/edit'
    end

    patch '/tenants/:id' do
        @tenant = Tenant.find(params[:id])
        params.each { |key, val| @tenant.send("#{key}=", val) if @tenant.respond_to?("#{key}=") }
        @tenant.save
        redirect to "/tenants/#{@tenant.id}"
    end

    get '/tenants/:id/delete' do
        @tenant = Tenant.find(params[:id])
        @tenant.destroy
        redirect to '/tenants'
    end
end
