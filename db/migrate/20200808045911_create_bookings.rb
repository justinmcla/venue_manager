class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :event_type
      t.date :date
      t.string :time
      t.text :description
      t.integer :attendance
      t.boolean :food
      t.boolean :alcohol
      t.boolean :lighting
      t.boolean :sound
      t.boolean :microphones
      t.boolean :street_closure
      t.boolean :spotlight
      t.boolean :curtain
      t.boolean :security
      t.boolean :contract
      t.boolean :deposit
      t.boolean :paid
      t.integer :venue_id
    end
  end
end
