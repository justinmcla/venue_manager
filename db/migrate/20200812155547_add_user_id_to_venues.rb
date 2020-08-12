class AddUserIdToVenues < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :user_id, :integer
  end
end
