class AddUserIdToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :user_id, :integer
  end
end
