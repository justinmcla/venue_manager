class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.integer :quantity
      t.text :description
      t.integer :inventory_id
    end
  end
end
