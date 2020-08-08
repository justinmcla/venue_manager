class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :customer
      t.date :date
      t.datetime :time
      t.integer :venue_id
    end
  end
end
