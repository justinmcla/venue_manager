class InventoryController < ApplicationController

    get '/venues/:id/inventories/new' do
        @venue = Venue.find(params[:id])
        current_user(session).venues.include?(@venue) ? (erb :'inventories/new') : (redirect to "/venues")
    end

    post '/venues/:id/inventories/new' do
        venue = Venue.find(params[:id])
        if current_user(session).venues.include?(venue)
            new_inv = Inventory.create(name: params[:name], description: params[:description])
            venue.inventories << new_inv
            redirect to "/venues/#{venue.id}/inventories/#{new_inv.id}"
        else
            redirect to "/venues/#{venue.id}/inventories"
        end
    end

    get '/venues/:id/inventories' do
        @venue = Venue.find(params[:id])
        current_user(session).venues.include?(@venue) ? (erb :'inventories/all') : (redirect to '/venues')
    end

    get '/venues/:id/inventories/:inventory_id' do
        @venue = Venue.find(params[:id])
        @inventory = Inventory.find(params[:inventory_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inventory)
                erb :'inventories/inventory'
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inventory_id/edit' do
        @venue = Venue.find(params[:id])
        @inventory = Inventory.find(params[:inventory_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inventory)
                erb :'inventories/edit'
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    patch '/venues/:id/inventories/:inventory_id' do
        @venue = Venue.find(params[:id])
        @inventory = Inventory.find(params[:inventory_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inventory)
                @inventory.update(name: params[:name], description: params[:description])
                redirect to "/venues/#{@venue.id}/inventories/#{@inventory}"
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inventory_id/delete' do
        @venue = Venue.find(params[:id])
        @inventory = Inventory.find(params[:inventory_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inventory)
                @inventory.items.each { |i| i.destroy }
                @inventory.destroy
            end
            redirect to "/venues/#{@venue.id}/inventories"
        else
            redirect to "/venues"
        end
    end
        

end
