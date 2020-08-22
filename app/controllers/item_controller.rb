class ItemController < ApplicationController

    before '/venues/:venue_id/inventories/:inventory_id*' do
        @venue = Venue.find(params[:venue_id])
        @inventory = Inventory.find(params[:inventory_id])
        redirect to "/venues/#{@venue.id}" unless current_user(session).venues.include?(@venue)
        redirect to "/venues/#{@venue.id}" unless @venue.inventories.include?(@inventory)
    end

    before '/venues/:venue_id/inventories/:inventory_id/items/:item_id*' do
        pass if params[:item_id] == 'new'
        @item = Item.find(params[:item_id])
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}" unless @inventory.items.include?(@item)
    end

    get '/venues/:venue_id/inventories/:inventory_id/items/new' do
        erb :'items/new'
    end

    post '/venues/:venue_id/inventories/:inventory_id/items' do
        params.delete(:venue_id)
        @inventory.items << Item.create(params)
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end

    get '/venues/:venue_id/inventories/:inventory_id/items/:id/edit' do
        erb :'items/edit'
    end

    patch '/venues/:venue_id/inventories/:inventory_id/items/:item_id' do
        update_safe(@item)
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end

    get '/venues/:venue_id/inventories/:inventory_id/items/:item_id/delete' do
        @item.destroy
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end
end
