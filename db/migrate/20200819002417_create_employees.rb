class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.date :start_date
      t.date :end_date
      t.boolean :active
      t.float :rate
      t.integer :user_id
    end
  end
end
