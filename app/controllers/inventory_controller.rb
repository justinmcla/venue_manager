class InventoryController < ApplicationController

    before '/venues/:venue_id/inventories/:inventory_id*' do
        pass if params[:inventory_id] == 'new'
        @inventory = Inventory.find(params[:inventory_id])
        redirect to "/venues/#{@venue.id}" unless @venue.inventories.include?(@inventory)
    end

    get '/venues/:venue_id/inventories/new' do
       erb :'inventories/new'
    end

    post '/venues/:venue_id/inventories' do
        Inventory.create(params)
        redirect to "/venues/#{@venue.id}/inventories/#{Inventory.last.id}"
    end

    get '/venues/:venue_id/inventories' do
        erb :'inventories/all'
    end

    get '/venues/:venue_id/inventories/:inventory_id' do
        erb :'inventories/inventory'
    end

    get '/venues/:venue_id/inventories/:inventory_id/edit' do
        erb :'inventories/edit'
    end

    patch '/venues/:venue_id/inventories/:inventory_id' do
        update_safe(@inventory)
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end

    delete '/venues/:venue_id/inventories/:inventory_id' do
        @inventory.destroy
        redirect to "/venues/#{@venue.id}"
    end
end
