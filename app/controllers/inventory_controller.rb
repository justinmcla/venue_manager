class InventoryController < VenueController

    get '/venues/:id/inventories/new' do
        erb :'inventories/new'
    end

    post '/venues/:id/inventories/new' do
        venue = Venue.find(params[:id])
        if current_user(session).venues.include?(venue)
            new_inv = Inventory.create(name: params[:name])
            params.each { |key, val| new_inv.send("#{key}=", val) if new_inv.respond_to?("#{key}=") }
            new_inv.save
            venue.inventories << new_inv
            redirect to "/venues/#{venue.id}/inventories/#{new_inv.id}"
        else
            redirect to "/venues/#{venue.id}/inventories"
        end
    end

    get '/venues/:id/inventories' do
        @venue = venue.find(params[:id])
        current_user(session).venues.include?(@venue) ? (erb :'inventories/all') : (redirect to '/venues')
    end

    get '/venues/:id/inventories/:inv_id' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                erb :'inventories/inventory'
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inv_id/edit' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                erb :'inventories/edit'
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    patch '/venues/:id/inventories/:inv_id' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                params.each { |key, val| @inv.send("#{key}=", val) if @inv.respond_to?("#{key}=") }
                @inv.save
                redirect to "/venues/#{@venue.id}/inventories/#{@inv.id}"
            else
                redirect to "/venues/#{@venue.id}/inventories"
            end
        else
            redirect to "/venues"
        end
    end

    get '/venues/:id/inventories/:inv_id/delete' do
        @venue = Venue.find(params[:id])
        @inv = Inventory.find(params[:inv_id])
        if current_user(session).venues.include?(@venue)
            if @venue.inventories.include?(@inv)
                @inv.destroy
            end
            redirect to "/venues/#{@venue.id}/inventories"
        else
            redirect to "/venues"
        end
    end
        

end
