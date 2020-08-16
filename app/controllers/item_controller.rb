class ItemController < ApplicationController

    get '/venues/:id/inventories/:inv_id/items/new' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(@venue)
            @venue.inventories.include?(@inv) ? (erb :'items/new') : (redirect to "/venues")
        end
    end

    post '/venues/:id/inventories/:inv_id/items/new' do
        venue = Venue.find(params[:id])
        inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(venue)
            if venue.inventories.include?(inv)
                new_item = Item.create(name: params[:name], category: params[:category], quantity: params[:quantity], description: params[:description])
                inv.items << new_item
                redirect to "/venues/#{venue.id}/inventories/#{inv.id}"
            else
                redirect to "/venues/#{venue.id}"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inv_id/items/:item_id/edit' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        @item = Item.find(params[:item_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                @inv.items.include?(@item) ? (erb :'items/edit') : (redirect to "/venues/#{@venue.id}/inventories/#{@inv.id}")
            else
                redirect to "/venues/#{@venue.id}"
            end
        else
            redirect to "/venues"
        end
    end

    patch '/venues/:id/inventories/:inv_id/items/:item_id/edit' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        @item = Item.find(params[:item_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                if @inv.inventories.include?(@item)
                    params.each { |key, val| @item.send("#{key}=", val) if @item.respond_to?("#{key}=") }
                    @item.save
                    redirect to "/venues/#{@venue.id}/inventories/#{@inv.id}"
                else
                    redirect to "/venues/#{@venue.id}/inventories"
                end
            else
                redirect to "/venues/#{@venue.id}"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inv_id/items/:item_id/delete' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        @item = Item.find(params[:item_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                if @inv.inventories.include?(@item)
                    @item.destroy
                    redirect to "/venues/#{@venue.id}/inventories/#{@inv.id}"
                else
                    redirect to "/venues/#{@venue.id}/inventories"
                end
            else
                redirect to "/venues/#{@venue.id}"
            end
        else
            redirect to "/venues"
        end
    end
end
