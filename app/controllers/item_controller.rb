class ItemController < ApplicationController

    before '/venues/:venue_id/inventories/:inventory_id/items/:item_id*' do
        @venue = Venue.find(params[:venue_id])
        @inventory = Inventory.find(params[:inventory_id])
        pass if params[:item_id] == 'new'
        @item = Item.find(params[:item_id])
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}" unless @inventory.items.include?(@item)
    end

    get '/venues/:venue_id/inventories/:inventory_id/items/new' do
        erb :'items/new'
    end

    post '/venues/:venue_id/inventories/:inventory_id/items' do
        params.delete(:venue_id)
        new_item = Item.new(params)
        if new_item.save
            Inventory.find(params[:inventory_id]).items << new_item
            redirect to "/venues/#{@venue.id}/inventories/#{Inventory.find(params[:inventory_id]).id}"
        else
            flash[:error] = new_item.errors.full_messages.join(', ')
            redirect to '/venues/:venue_id/inventories/:inventory_id/items/new'
        end
    end

    get '/venues/:venue_id/inventories/:inventory_id/items/:id/edit' do
        erb :'items/edit'
    end

    patch '/venues/:venue_id/inventories/:inventory_id/items/:item_id' do
        update_safe(@item)
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end

    delete '/venues/:venue_id/inventories/:inventory_id/items/:item_id' do
        @item.destroy
        redirect to "/venues/#{@venue.id}/inventories/#{@inventory.id}"
    end
end
