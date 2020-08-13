class AddTenantIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :tenant_id, :integer
  end
end
