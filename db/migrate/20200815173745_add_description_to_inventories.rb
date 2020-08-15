class AddDescriptionToInventories < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :description, :text
  end
end
